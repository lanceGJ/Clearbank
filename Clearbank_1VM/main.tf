provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  for_each = var.environments
  name     = each.value.resource_group_name
  location = each.value.location
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  for_each            = var.environments
  name                = "vnet-${each.key}"
  resource_group_name = azurerm_resource_group.rg[each.key].name
  address_space       = ["10.0.0.0/16"]
  location            = each.value.location
}

# Subnet
resource "azurerm_subnet" "subnet" {
  for_each             = var.environments
  name                 = "subnet-${each.key}"
  resource_group_name  = azurerm_resource_group.rg[each.key].name
  virtual_network_name = azurerm_virtual_network.vnet[each.key].name
  address_prefixes     = ["10.0.1.0/24"]
}

# Network Security Group
resource "azurerm_network_security_group" "nsg" {
  for_each            = var.environments
  name                = "nsg-${each.key}"
  location            = each.value.location
  resource_group_name = azurerm_resource_group.rg[each.key].name

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "OutboundRules"
    priority                   = 110
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["80", "443", "53"]
    source_address_prefix      = "*"
    destination_address_prefix = "Internet"
  }
}

# Network Interface
resource "azurerm_network_interface" "nic" {
  for_each            = var.environments
  name                = "nic-${each.key}"
  location            = each.value.location
  resource_group_name = azurerm_resource_group.rg[each.key].name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}

# Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "vm" {
  for_each                 = var.environments
  name                     = "vm-${each.key}"
  resource_group_name      = azurerm_resource_group.rg[each.key].name
  location                 = each.value.location
  size                     = each.value.vm_size
  admin_username           = "adminuser"
  network_interface_ids    = [azurerm_network_interface.nic[each.key].id]
  disable_password_authentication = true

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  admin_ssh_key {
    username   = "adminuser"
    public_key = var.ssh_public_key
  }
}

# Management Lock to prevent accidental VM deletion
resource "azurerm_management_lock" "vm_lock" {
  for_each            = var.environments
  name                = "lock-${each.key}"
  scope               = azurerm_linux_virtual_machine.vm[each.key].id
  lock_level          = "CanNotDelete"
  notes               = "Prevent accidental deletion of the VM"
}

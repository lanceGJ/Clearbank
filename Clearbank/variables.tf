variable "environments" {
  description = "A map of environment configurations"
  type = map(object({
    resource_group_name : string
    location            : string
    vm_size             : string
  }))
}

variable "ssh_public_key" {
  description = "Public SSH key for VM authentication"
  type        = string
}

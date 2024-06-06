environments = {
  test = {
    resource_group_name = "Clearbank_1",
    location            = "UK South",
    vm_size             = "Standard_B1s"
  },
  staging = {
    resource_group_name = "Clearbank_2",
    location            = "UK South",
    vm_size             = "Standard_B1s"
  },
  production = {
    resource_group_name = "Clearbank_3",
    location            = "UK South",
    vm_size             = "Standard_B1s"
  }
}

ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDFJksVUK11omfykg4m5stIvl3TuxM5qczieYiAQSahgSFvI/Q330YZJY3lwt3LVknwWTv0mFYc7t38uJGpyA6R1gs41tzq+27EsJ5rXVkUfBJ0gZDtRNgcA9X6okYOtOxTF3unVw5fXTdtIdLuElW+4GKCI4jesdNlE2gpYTWnWB3qh3N5JPgGkGcrB/4buWJ/RZXg0F4MfzfKuflD03AB3RYufVaDQfJ2zeTc29ib0sVMJ7oaeznwaDYEsM6dV+e2KYpM0y/VP/yrnumKv44d8Rtm19t+6A9Gv14KHhJLAXnoFGGq2KW4xe2MCLLcuOnuW1RLTB/MxqmE/FxchJviwdQgEPC6lluKFNuCNaZy4kXTZvXKxFD1LyF9vHWK2w51VHKyh+ELWFa3+a8bN1Zi4Epqp/kKeRl2muZDjE+Oj+W1P9Qf8iKMVR3WHmv7dKrxki2dztbtxvOsZczJw328Am/8hqF51Y5nLDNpyyerlM4flsvLkNcaiU5zvpyigi0= imported-openssh-key"


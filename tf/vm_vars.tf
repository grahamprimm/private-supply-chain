variable "domain" {
  description = "Domain of network"
  type        = map(string)
  default = {
    net  = "example.net"
    org = "example.org"
    com = "example.com"
  }
}

variable "disk" {
  description = "Total Disk Size in GB"
  type        = number
}

variable "name" {
  description = "Name for the new VM"
  type        = string
}
variable "memory_mb" {
  description = "Memory of the VM in MB"
  type        = number
}

variable "vcpu" {
  description = "vCPU count for the VM"
  type        = number
}

variable "ip" {
  description = "IP address of big-bang"
  type        = map(string)
  default = {
    net  = "X.X.X.X"
    org = "X.X.X.X"
    com = "X.X.X.X"
  }
}

variable "netmask" {
  description = "Netmask of network 24 or 16"
  type        = map(number)
  default = {
    net  = 24
    org = 16
    com = 8
  }
}
variable "dns" {
  description = "DNS server of network"
  type        = map(string)
  default = {
    net  = "X.X.X.X"
    org = "X.X.X.X"
    com = "X.X.X.X"
  }
}
variable "gateway" {
  description = "Gateway of network (Usually X.X.X.254)"
  type        = map(string)
  default = {
    net  = "X.X.X.254"
    org = "X.X.X.254"
    com = "X.X.X.254"
  }
}

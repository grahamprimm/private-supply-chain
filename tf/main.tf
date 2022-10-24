
locals {
  vsphere_server = lookup(var.vsphere_server, terraform.workspace, null)
  domain         = lookup(var.domain, terraform.workspace, null)
  folder         = lookup(var.folder, terraform.workspace, null)
  ip             = lookup(var.ip, terraform.workspace, null)
  netmask        = lookup(var.netmask, terraform.workspace, null)
  dns            = lookup(var.dns, terraform.workspace, null)
  gateway        = lookup(var.gateway, terraform.workspace, null)
}
provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = local.vsphere_server
  allow_unverified_ssl = true
}

resource "vsphere_virtual_machine" "vm" {
  name             = var.name
  guest_id         = "rhel8_64Guest"
  num_cpus         = var.vcpu
  memory           = var.memory_mb
  folder           = local.folder
  datastore_id     = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_resource_pool.resources.id
  firmware = data.vsphere_virtual_machine.template.firmware
  network_interface {
    network_id = data.vsphere_network.MGMT.id
  }
  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
    unit_number      = 0
  }
  disk {
    label            = "disk1"
    size             = 750
    thin_provisioned = true
    unit_number      = 1
  }
  disk {
    label            = "disk2"
    size             = 150
    thin_provisioned = true
    unit_number      = 2
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      linux_options {
        host_name = var.name
        domain    = local.domain
      }
      network_interface {
        ipv4_address    = local.ip
        ipv4_netmask    = local.netmask
        dns_server_list = [local.dns]
      }
      ipv4_gateway = local.gateway
    }
  }

  provisioner "local-exec" {
    command = "ANSIBLE_CONFIG='../ansible/ansible.cfg' ansible-playbook -i '${local.ip},' -e 'BIG_BANG_IP=${local.ip}' -e 'BIG_BANG_DOMAIN_SUFFIX=${local.domain}' ../ansible/main.yml --vault-password-file ../vpass.txt"
  }
}
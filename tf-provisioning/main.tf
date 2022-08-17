terraform {
  required_providers {
    vsphere = {
      source = "hashicorp/vsphere"
      version = "2.2.0"
    }
  }
}

provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_compute_cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "resource_pool_lab" {
  name          = var.vsphere_resource_pool
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.vsphere_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.vsphere_template
  datacenter_id = data.vsphere_datacenter.dc.id
}

### CONFIGURAÇÃO DAS VMs WORKERS ###
resource "vsphere_virtual_machine" "vm_workers" {
  count            = var.vm_count
  name             = "${var.name_vm_workers}-${count.index + 1}"
  resource_pool_id = data.vsphere_resource_pool.resource_pool_lab.id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = 2
  memory           = 2024
  guest_id         = data.vsphere_virtual_machine.template.guest_id
  scsi_type        = data.vsphere_virtual_machine.template.scsi_type
  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }
  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      timeout = 10
      linux_options {
        host_name = "${var.name_vm_workers}-${count.index + 1}"
        domain    = "lab.local"
      }
      network_interface {
        ipv4_address = cidrhost("192.168.8.0/24", var.start_ip+count.index)
        ipv4_netmask = 24
      }

      ipv4_gateway = "192.168.8.254"
      dns_server_list = var.dns_list
    }
  }
}

### CONFIGURAÇÃO DA VM MASTER
resource "vsphere_virtual_machine" "vm_master" {
  count            = 1
  name             = var.name_vm_master
  resource_pool_id = data.vsphere_resource_pool.resource_pool_lab.id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = 4
  memory           = 4048
  guest_id         = data.vsphere_virtual_machine.template.guest_id
  scsi_type        = data.vsphere_virtual_machine.template.scsi_type
  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }
  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      timeout = 10
      linux_options {
        host_name = var.name_vm_master
        domain    = "lab.local"
      }
      network_interface {
        ipv4_address = "192.168.8.10"
        ipv4_netmask = 24
      }

      ipv4_gateway = "192.168.8.254"
      dns_server_list = var.dns_list
    }
  }
}
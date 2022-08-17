variable "vsphere_user" {
    type = string    
    default = "leonardo.hauschild@itbrasil.net"  
}

variable "vsphere_password" {
    type = string    
    default = "lhgr@.93"
}

variable "vsphere_datacenter" {
    type = string
    default = "IT Brasil Headquarters"
}

variable "vsphere_datastore" {
    type = string
    default = "FLASH-12TB-Hyb"
}

variable "vsphere_compute_cluster" {
    type = string
    default = "node01"
}

variable "vsphere_resource_pool" {
    type = string
    default = "LAB"
}

variable "vsphere_network" {
    default = "VLAN 8 - Lab"  
}

variable "vsphere_template" {
    default = "k8s-ubuntu-20.04" 
}

variable "vsphere_server" {
    type = string    
    default = "192.168.1.90"
}

variable "name_vm_workers" {
    default = "worker"
}

variable "name_vm_master" {
    default = "master-k8s"
}


variable "vm_count" {
    description = "Number of instance"  
    default = 2
}

variable "start_ip" {
    description = "primeiro IP a ser definido"
    default = 11
}

variable "dns_list" {
    description = "DNS usado nas VMs"
    default = ["1.1.1.1", "8.8.8.8"]
}


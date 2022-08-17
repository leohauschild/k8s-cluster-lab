variable "vsphere_user" {
    type = string    
    default = "user"  
}

variable "vsphere_password" {
    type = string    
    default = "password"
}

variable "vsphere_datacenter" {
    type = string
    default = "dc"
}

variable "vsphere_datastore" {
    type = string
    default = "ds"
}

variable "vsphere_compute_cluster" {
    type = string
    default = "cluster-name"
}

variable "vsphere_resource_pool" {
    type = string
    default = "pool-name"
}

variable "vsphere_network" {
    default = "vlan"  
}

variable "vsphere_template" {
    default = "template-name" 
}

variable "vsphere_server" {
    type = string    
    default = "vcenter-server"
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


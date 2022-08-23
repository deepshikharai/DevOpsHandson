terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "rg" {
  name     = "newresourcegroup"
  location = "northeurope"
}

resource "azurerm_virtual_network" "rg-net" {
    name = "myfirstvnet"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    address_space = [ "10.0.0.0/8" ]
  
}

resource "azurerm_subnet" "rg-subnet" {
    name = "myfirstsubnet"
    virtual_network_name = azurerm_virtual_network.rg-net.name
    resource_group_name = azurerm_resource_group.rg.name
    address_prefixes = [ "10.240.0.0/16" ]
  
}

resource "azurerm_kubernetes_cluster" "rgcluster" {
    name = "rgcluster-aks1"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    dns_prefix = "rgclusteraks1"

    default_node_pool {
      name = "firstcluster"
      node_count = 2
      vm_size = "Standard_D2_v2"
      vnet_subnet_id = azurerm_subnet.rg-subnet.id
    }

    identity {
      type = "SystemAssigned"
    }
  
}

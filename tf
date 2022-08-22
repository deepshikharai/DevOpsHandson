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
  name     = "learnk8sResourceGroup"
  location = "northeurope"
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
    }

    identity {
      type = "SystemAssigned"
    }
  
}

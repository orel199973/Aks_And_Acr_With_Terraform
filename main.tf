terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }
  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
}

resource "azurerm_role_assignment" "role_acrpull" {
  scope                            = module.acr.id
  role_definition_name             = "AcrPull"
  principal_id                     = module.aks.kubelet_identity.0.object_id
  skip_service_principal_aad_check = true
}

module "acr" {
        source  = "github.com/iquzart/terraform-azurerm-acr"
        

        name                      = var.acr_name
        resource_group_name       = var.resource_group_name
        location                  = var.location
        sku                       = var.sku
        admin_enabled             = true

}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = "westeurope"
}


module "aks" {
  source                           = "Azure/aks/azurerm"
  resource_group_name              = var.resource_group_name
  kubernetes_version               = var.kubernetes_version
  prefix                           = "prefix"
  cluster_name                     = var.cluster_name
  network_plugin                   = "kubenet"
  sku_tier                         = "Paid" # defaults to Free
  enable_auto_scaling              = true
  agents_min_count                 = 1
  agents_max_count                 = 3
  agents_count                     = null # Please set `agents_count` `null` while `enable_auto_scaling` is `true` to avoid possible `agents_count` changes.
  agents_pool_name                 = "nodepool"

  agents_labels = {
    "nodepool" : "defaultnodepool"
  }

  depends_on = [azurerm_resource_group.example]

}



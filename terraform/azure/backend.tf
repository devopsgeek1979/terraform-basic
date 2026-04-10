terraform {
  backend "azurerm" {
    resource_group_name  = "tf-rg"
    storage_account_name = "tfstateaccount"
    container_name       = "tfstate"
    key                  = "azure/terraform.tfstate"
  }
}
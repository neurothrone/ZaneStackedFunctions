provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "zanestacked" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "zanestacked_storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.zanestacked.name
  location                 = azurerm_resource_group.zanestacked.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "zanestacked_plan" {
  name                = "zanestacked-plan"
  resource_group_name = azurerm_resource_group.zanestacked.name
  location            = azurerm_resource_group.zanestacked.location
  os_type             = "Linux"
  sku_name            = "Y1"  # Consumption-based plan (Pay-as-you-go)
}

resource "azurerm_linux_function_app" "zanestacked_functions" {
  name                       = var.function_app_name
  resource_group_name        = azurerm_resource_group.zanestacked.name
  location                   = azurerm_resource_group.zanestacked.location
  service_plan_id            = azurerm_service_plan.zanestacked_plan.id
  storage_account_name       = azurerm_storage_account.zanestacked_storage.name
  storage_account_access_key = azurerm_storage_account.zanestacked_storage.primary_access_key

  site_config {
    application_stack {
      dotnet_version = "8.0"
    }
  }

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = "dotnet-isolated"
  }
}
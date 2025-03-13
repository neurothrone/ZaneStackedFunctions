variable "subscription_id" {
  description = "The Azure Subscription ID"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Azure resource group"
  type        = string
  default     = "ZN-Lab3-Functions-RG"
}

variable "location" {
  description = "The Azure region for resources"
  type        = string
  default     = "westeurope"
}

variable "storage_account_name" {
  description = "The name of the Azure Storage Account (must be unique globally)"
  type        = string
  default     = "zanestackedstoragefuncs"
}

variable "function_app_name" {
  description = "The name of the Azure Function App (must be unique globally)"
  type        = string
  default     = "zanestacked-functions"
}
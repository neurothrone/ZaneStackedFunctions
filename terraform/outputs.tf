output "function_app_url" {
  description = "The URL of the deployed Azure Function App"
  value       = "https://${azurerm_linux_function_app.zanestacked_functions.default_hostname}/api/excuses/random"
}
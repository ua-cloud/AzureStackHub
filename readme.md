Azure Satck Hub backupfile

# Connect to Azure StackHub

Add-AzEnvironment -Name "user@tenant.onmicrosoft.com" -ArmEndpoint "https://management.kyiv.azure.kyivstar.ua"
Connect-AzAccount -EnvironmentName "user@tenant.onmicrosoft.com"
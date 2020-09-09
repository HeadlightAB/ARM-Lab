# Connect with Azure Account
#$credential = Get-Credential
#Connect-AzAccount -Credential $credential

##########################################################################################
# Parameters for the ARM templates
Write-Host "Setting parameters..." -ForegroundColor Yellow

$resourceGroupName = 'RG-arm-lab-p'

Write-Host "...done (Setting parameters)`n`n" -ForegroundColor Green

##########################################################################################
# Create/ensure resource group
Write-Host "Creating/ensuring resourcegroup..." -ForegroundColor Yellow

New-AzResourceGroup -Name $resourceGroupName -Location 'North Europe' -Force

Write-Host "...done (Creating/ensuring resourcegroup)`n`n" -ForegroundColor Green

##########################################################################################
# App Service Plan
Write-Host "App Service Plan..." -ForegroundColor Yellow

New-AzResourceGroupDeployment `
    -Name 'armlab-asp-p' `
    -ResourceGroupName $resourceGroupName `
    -TemplateFile 'asp.json' `
    -TemplateParameterFile 'asp.parameters.json'

Write-Host "...done (App Service Plan)`n`n" -ForegroundColor Green

##########################################################################################
# App service (web api)
Write-Host "App service (web api)..." -ForegroundColor Yellow

New-AzResourceGroupDeployment `
    -Name 'armlab-webapi-p' `
    -ResourceGroupName $resourceGroupName `
    -TemplateFile 'webapi.json' `
    -TemplateParameterFile 'webapi.parameters.json'

Write-Host "...done (App service (web api))`n`n" -ForegroundColor Green

##########################################################################################
# Service bus
Write-Host "Service bus..." -ForegroundColor Yellow

New-AzResourceGroupDeployment `
    -Name 'armlab-sb-p' `
    -ResourceGroupName $resourceGroupName `
    -TemplateFile "sb.json" `
    -TemplateParameterFile 'sb.parameters.json'

Write-Host "...done (Service bus)`n`n" -ForegroundColor Green

##########################################################################################
# Function app (storage account included as dependency)
Write-Host "Function app..." -ForegroundColor Yellow

New-AzResourceGroupDeployment `
    -Name 'armlab-fa-p' `
    -ResourceGroupName $resourceGroupName `
    -TemplateFile "fa.json" `
    -TemplateParameterFile 'fa.parameters.json'
    
Write-Host "...done (Function app)`n`n" -ForegroundColor Green
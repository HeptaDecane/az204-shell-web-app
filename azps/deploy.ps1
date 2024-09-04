$Location = "Central India"
$ResourceGroupName = "az204-ps-rg"
$AppServicePlanName = "az204-ps-asp"
$AppServiceName = "az204-ps-app"

New-AzResourceGroup `
-Name $ResourceGroupName `
-Location $Location

New-AzAppServicePlan `
-Name $AppServicePlanName `
-Location $Location `
-ResourceGroupName $ResourceGroupName `
-Tier Free

New-AzWebApp `
-Name $AppServiceName `
-Location $Location `
-AppServicePlan $AppServicePlanName `
-ResourceGroupName $ResourceGroupName

$PropertyObject = @{
    repoUrl = "https://github.com/HeptaDecane/az204-shell-web-app"
    branch = "main"
    isManualIntegration = $true
}

Set-AzResource `
-PropertyObject $PropertyObject `
-ResourceGroupName $ResourceGroupName `
-ResourceType Microsoft.Web/sites/sourcecontrols `
-ResourceName $AppServiceName/web `
-ApiVersion 2018-02-01 `
-Force

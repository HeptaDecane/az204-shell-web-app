$Location = "Central India"
$ResourceGroupName = "az204-ps-rg"
$AppServicePlanName = "az204-ps-asp"
$AppServiceName = "az204-ps-app"

Set-AzAppServicePlan `
-Name $AppServicePlanName `
-ResourceGroupName $ResourceGroupName `
-Tier Standard

New-AzWebAppSlot `
-Name $AppServiceName `
-ResourceGroupName $ResourceGroupName `
-Slot "staging"

$PropertyObject = @{
    repoUrl = "https://github.com/HeptaDecane/az204-shell-web-app"
    branch = "main"
    isManualIntegration = $true
}

Set-AzResource `
-PropertyObject $PropertyObject `
-ResourceGroupName $ResourceGroupName `
-ResourceType Microsoft.Web/sites/slots/sourcecontrols `
-ResourceName $AppServiceName/staging/web `
-ApiVersion 2018-02-01 `
-Force

Switch-AzWebAppSlot `
-Name $AppServiceName `
-ResourceGroupName $ResourceGroupName `
-SourceSlotName "staging" `
-DestinationSlotName "production"

Remove-AzResourceGroup -Name $ResourceGroupName
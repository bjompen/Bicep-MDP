$RG = 'NISMDPRG'
$location = 'Sweden Central'

Connect-AzAccount

New-AzResourceGroup -Name $RG -Location $location

New-AzResourceGroupDeployment -Name 'NISMDP' -ResourceGroupName $RG -TemplateFile .\main.bicep -TemplateParameterFile .\main.bicepparam

Remove-AzResourceGroup -Name $RG -Force

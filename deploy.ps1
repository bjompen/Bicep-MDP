$RG = 'MDPDevRG'
$MDPName = 'MDPLab'
$location = 'West Europe'
$ADOUrl = 'https://dev.azure.com/<your ADO url goes here>'

Connect-AzAccount

New-AzResourceGroup -Name $RG -Location $location

New-AzResourceGroupDeployment -Name 'MDPLab' -ResourceGroupName $RG -TemplateFile .\main.bicep -TemplateParameterObject @{
    DevCenterName = "${MDPName}DC"
    ManagedIdentityName = "${MDPName}MI"
    subnetNameName = "${MDPName}SN"
    vnetNameName = "${MDPName}VN"
    MDPName = "${MDPName}MDP"
    ADOUrl = $ADOUrl
    MDPImageName = @(
        @{
            wellKnownImageName = 'ubuntu-22.04/latest'
        }
    )
    DevOpsInfrastructurePrincipalId = (Get-AzADServicePrincipal -DisplayName DevOpsInfrastructure).Id
}

Remove-AzResourceGroup -Name $RG -Force

extension microsoftGraphV1

param DevCenterName string
param ManagedIdentityName string
param subnetNameName string
param vnetNameName string
param MDPName string
param ADOUrl string
param MDPImageName osImages[]

type osImages = {
  aliases: string[]?
  buffer: string?
  wellKnownImageName: 'windows-2025-g2/latest' | 'windows-2022-g2/latest' | 'ubuntu-22.04-g2/latest' | 'ubuntu-24.04-g2/latest'
}

module DevCenter 'modules/DevCenter.bicep' = {
  name: 'DevCenter'
  params: {
    name: DevCenterName
  }
}

module ManagedIdentity 'modules/ManagedIdentity.bicep' = {
  name: 'ManagedIdentity'
  params: {
    name: ManagedIdentityName
  }
}

resource DevOpsInfrastructurePrincipal 'Microsoft.Graph/servicePrincipals@v1.0' existing = {
  appId: '31687f79-5e43-4c1e-8c63-d9f4bff5cf8b' 
}

module Network 'modules/Network.bicep' = {
  name: 'MDPNetwork'
  params: {
    subnetName: subnetNameName
    vnetName: vnetNameName
    principalId: DevOpsInfrastructurePrincipal.id
  }
}

module MDP 'modules/MDP.bicep' = {
  name: 'ManagedDevOpsPool'
  params: {
    name: MDPName
    AzureDevOpsOrganizations: {
      url: ADOUrl
      parallelism: 2
    }
    DevCenterProjectResourceId: DevCenter.outputs.DevCenterProjectId
    managedIdentityId: ManagedIdentity.outputs.managedIdentityId
    
    images: MDPImageName
    subnetId: Network.outputs.SubnetId
  }
}

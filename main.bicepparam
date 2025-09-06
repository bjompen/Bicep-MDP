using 'main.bicep'
extends 'defaults.bicepparam'

param DevCenterName = 'DevCenter'
param ManagedIdentityName =  'MDPManagedIdentity'
param MDPName = 'MDP'
param vnetNameName =  'DevCenterVNET'
param subnetNameName =  '${DevCenterName}-MDP-Subnet'

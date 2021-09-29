# Connect to Azure StackHub

# Add-AzEnvironment -Name "user@tenant.onmicrosoft.com" -ArmEndpoint "https://management.kyiv.azure.kyivstar.ua"
# Connect-AzAccount -EnvironmentName "user@tenant.onmicrosoft.com"

#   Tags varibles 

$tag = @{
    "owner" = "golovasheveo";
    "project" = "backup";
}

$resourceGroupName = 'rg-snaptest' ;
$location = 'kyiv' ;

$disks = Get-AzDisk -ResourceGroupName $resourceGroupName;


foreach ($var in $disks) {
    $Date = Get-Date -Format "yy/MM/ddTHH:mm:ss" | ForEach-Object { $_ -replace "[^0-9a-zA-Z]+", "" } ;
    $snapshotName = 'Snapshot-'+$var.Name+'-'+$Date;

    try {
#   Creates a configurable snapshot object
    $snapshot = New-AzSnapshotConfig `
    -SourceUri $var.id `
    -Location $location `
    -CreateOption copy `
    -Tag $tag

#   Creates a snapshot
    New-AzSnapshot `
    -Snapshot $snapshot `
    -SnapshotName $snapshotName `
    -ResourceGroupName $resourceGroupName `
    }
    catch {
        Write-Error "An error occurred :";
        Write-Error $snapshotName;
        Write-Error $_;
    }

}
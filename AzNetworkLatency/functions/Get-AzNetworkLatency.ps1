function Get-AzNetworkLatency {
    <#
    .SYNOPSIS
        Get the network latency between two Azure regions.

    .DESCRIPTION
        Get the network latency between two Azure regions in milliseconds. The module has an embedded list of all known latencies. This information can be outdated so there is the option to also retrieve this information from an online resource.

    .PARAMETER Source
        The Source of the network traffic. Make sure you use the region id. For West Europe this would be "westeurope".

    .PARAMETER Destination
        The Destination of the network traffic. Make sure you use the region id. For West Europe this would be "westeurope".

    .PARAMETER Online
        Use this parameter to retrieve the data from the online source which results in the most up-to-date information.

    .PARAMETER IgnoreWarning
        Use this parameter to suppress the warning which is being generated when the Online parameters isn't used.

    .EXAMPLE
        Retrieve the latency from the embedded data.

        PS> Get-AzNetworkLatency -Source westeurope -Destination eastus -IgnoreWarning
        89

    .EXAMPLE
        Retrieve the latency from the online data.

        PS> Get-AzNetworkLatency -Source westeurope -Destination eastus -Online
        89
    #>

    [CmdLetBinding()]
    [OutputType([int])]

    Param (
        [Parameter(Mandatory = $true, Position = 1, ParameterSetName = 'Online')]
        [Parameter(Mandatory = $true, Position = 1, ParameterSetName = 'Offline')]
        [String] $Source,

        [Parameter(Mandatory = $true, Position = 2, ParameterSetName = 'Online')]
        [Parameter(Mandatory = $true, Position = 2, ParameterSetName = 'Offline')]
        [String] $Destination,

        [Parameter(Mandatory = $true, Position = 3, ParameterSetName = 'Online')]
        [Switch] $Online,

        [Parameter(Mandatory = $false, Position = 3, ParameterSetName = 'Offline')]
        [Switch] $IgnoreWarning
    )

    # Send telemetry
    Send-THEvent -ModuleName "AzNetworkLatency" -EventName "Get-AzNetworkLatenc"

    if ($Online) {
        $ldata = Invoke-RestMethod -Method GET -Uri "https://raw.githubusercontent.com/autosysops/azure_network_latency/refs/heads/main/latencydata.json"
    }
    else {
        if(-not $IgnoreWarning) {
            Write-Warning "[WARNING] Module uses embedded latency data. This data could be outdate. Use the switch -online for the most recent data. To suppress this message use the switch -IgnoreWarning."
        }
        $ldata = $script:latencyData
    }

    # Find the source
    $s = $ldata.Sources | Where-Object { $_.id -eq $Source }

    if ($s) {
        # Find the destination
        $d = $s.Destinations | Where-Object { $_.id -eq $Destination }

        if ($d) {
            return $d.Latency
        }
        else {
            Write-Error "[ERROR] Can't find Destination $Destination. Make sure you are using the id of the destination. For West Europe that would be `"westeurope`""
        }
    }
    else {
        Write-Error "[ERROR] Can't find Source $Source. Make sure you are using the id of the source. For West Europe that would be `"westeurope`""
    }

    return -1
}
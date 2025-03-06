# AzNetworkLatency

![example workflow](https://github.com/autosysops/PowerShell_AzNetworkLatency/actions/workflows/build.yml/badge.svg)
[![PowerShell Gallery](https://img.shields.io/powershellgallery/dt/AzNetworkLatency.svg)](https://www.powershellgallery.com/packages/AzNetworkLatency/)

PowerShell module to determine the network latency between two Azure regions.

## Installation

You can install the module from the [PSGallery](https://www.powershellgallery.com/packages/AzNetworkLatency) by using the following command.

```PowerShell
Install-Module -Name AzNetworkLatency
```

Or if you are using PowerShell 7.4 or higher you can use

```PowerShell
Install-PSResource -Name AzNetworkLatency
```

## Usage

To use the module first import it.

```PowerShell
Import-Module -Name AzNetworkLatency
```

You will receive a message about telemetry being enabled. After that you can use the command `Get-AzNetworkLatency` to use the module.

Check out the Get-Help for more information on how to use the function.

## Credits

The module is using the [Telemetryhelper module](https://github.com/nyanhp/TelemetryHelper) to gather telemetry.
The module is made using the [PSModuleDevelopment module](https://github.com/PowershellFrameworkCollective/PSModuleDevelopment) to get a template for a module.

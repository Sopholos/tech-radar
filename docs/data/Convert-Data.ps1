$ErrorActionPreference = "Stop"

$scriptDir = Split-Path $PSCommandPath

$data = Import-Csv $scriptDir/Technologies.tsv -Delimiter "`t" | ? label -ne ""

$rings = @{
    'ADOPT'     = 0
    'TRIAL'     = 1
    'ASSESS'    = 2
    'HOLD'      = 3
}

foreach ($d in $data) {
    $d.active = $d.active.ToLower()
    $d.quadrant = [int]$d.quadrant
    $d.ring = [int]$rings[$d.ring]
    $d.moved = [int]$d.moved
    $d.active = [bool]$d.active
}

$dataJson = ConvertTo-Json $data

$stringJson = $dataJson | Out-String

$dataJS = "var radarEntries = $stringJson;"

$dataJS | Out-File $scriptDir/../data.js

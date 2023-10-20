$scriptDir = Split-Path $PSCommandPath

$data = Import-Csv $scriptDir/Technologies.tsv -Delimiter "`t"
foreach ($d in $data) {
    $d.active = $d.active.ToLower()
    $d.quadrant = [int]$d.quadrant
    $d.ring = [int]$d.ring
    $d.moved = [int]$d.moved
    $d.active = [bool]$d.active
}

$dataJson = ConvertTo-Json $data

$stringJson = $dataJson | Out-String

$dataJS = "var radarEntries = $stringJson;"

$dataJS | Out-File $scriptDir/../data.js

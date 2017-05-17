$ErrorActionPreference = 'Continue'
$exc = 0
$armts = ls -path templates  -Recurse -Filter *.json

forEach ( $arm in $armts ) {
    try {
        $code = gc -Path $arm.FullName -Raw
        $jsonText = $code | ConvertFrom-Json
    } catch [Exception] {
        Write-Output "Error in Json Template " $arm.FullName "`n"
        $Error[0].Exception
        $exc = 100
    }
}

if ( $exc -eq 100 ) { 
    exit 100
}
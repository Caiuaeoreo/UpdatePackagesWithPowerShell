# Path para download do pacote
$PathToPackage = 'C:\UpdatingPackages'

# Versão desejada
$VersionDesirable = "2.0.25"

# Criar o diretório para manter os pacotes a serem atualizados
mkdir $PathToPackage -ErrorAction SilentlyContinue | Out-Null

# Acessar o path
Set-Location $PathToPackage

# Verificar se o pacote existe
$VersionCheck = (Get-WmiObject -Class Win32_Product -Filter "Name LIKE 'aws-cfn%'").Version

# Execução para caso o pacote exista na versão correta
if ($VersionCheck -eq $VersionDesirable) {
"O pacote não precisa ser atualizado nesta máquina"
}
# Para caso ele não exista
elseif (-not $VersionCheck) {
"O cfn-bootstrap não foi existe nessa maquina e não sera instalado"
}
# Para caso ele exista, mas em uma versão diferente da desejada
else {
"Instalando pacote"

# Baixando o pacote para a atualização
$PackageUri = "https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-py3-2.0-25.win64.exe"
$PackagePath = Join-Path $PathToPackage "aws-cfn-bootstrap-py3-2.0-25.win64.exe"
Invoke-WebRequest -Uri $PackageUri -OutFile $PackagePath

# Executando a atualização do pacote
Start-Process -FilePath $PackagePath -ArgumentList "/Quiet" -Wait

# Remover o pacote de instalação.
Remove-Item $PackagePath

"Pacote instalado"
}

exit

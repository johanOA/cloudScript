param(
    [string]$vm1,
    [string]$vm2
)


Start-Sleep -Seconds 1
$count = 0
$folderPath = "$env:USERPROFILE\VirtualBox VMs\$vm1\"

# Obtener todos los archivos en la carpeta y subcarpetas
$file = Get-ChildItem -Path $folderPath -Recurse -File

# Para ver si hay archivos
if (-Not $file) {
    Write-Output "No se encontraron archivos en la carpeta especificada."
    exit
}

# Filtrar los archivos por la extensión .vdi
$filteredFile = $file | Where-Object { $_.Extension -eq ".vdi" }

# Para ver si hay un disco .vdi
if (-Not $filteredFile) {
    Write-Output "No se encontraron archivos con la extension .vdi en la carpeta especificada."
    exit
}

# Mostrar los archivos filtrados
$filteredFile | ForEach-Object {
    if ($_.Name -ne $vm1 -and $count -eq 1) {
        $disk = $_.Name
    } else { if ($_.Name -eq $vm1){
        Write-Output "Disco de la maquina, no es posible moverlo."
        exit
    } else {
        $disk = $_.Name
        Write-Output "Nombre del archivo: $($_.Name) - Extension: $($_.Extension) - Ruta completa: $($_.FullName)"  
    } }
}
#Desacoplar
VBoxManage storageattach $vm1 --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium none
#Mover
VBoxManage modifymedium disk "$env:USERPROFILE\VirtualBox VMs\$vm1\$disk"  --move "$env:USERPROFILE\VirtualBox VMs\$vm2\$disk"
# Acoplar
VBoxManage storageattach $vm2 --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$env:USERPROFILE\VirtualBox VMs\$vm2\$disk"
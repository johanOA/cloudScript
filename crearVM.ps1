param(
    [string]$vmName,
    [int]$vmSmemory,
    [int]$vram,
    [int]$vmCPU
)

Start-Sleep -Seconds 1
Write-Output "Configurando la máquina virtual con los siguientes parametros:"
Write-Output "Nombre de la máquina: $vmName"
Write-Output "Memoria RAM: $vmSmemory MB"
Write-Output "Memoria de video: $vram MB"
Write-Output "Numero de núcleos: $vmCPU"

# Código adicional para la configuración de la máquina virtual
# Solicitar los diferentes datos

# Crear la máquina virtual con el nombre ingresado
VBoxManage createvm --name $vmName --ostype Debian_64 --register


# Modificar la máquina virtual para configurar la memoria
VBoxManage modifyvm $vmName --memory $vmSmemory

# Modificar la máquina virtual para configurar la memoria RAM
VBoxManage modifyvm $vmName --vram $vram

VBoxManage modifyvm $vmName --cpus $vmCPU

# Habilitar IOAPIC
VBoxManage modifyvm $vmName --ioapic on

# Configurar el adaptador de red en modo puente
VBoxManage modifyvm $vmName --nic1 bridged --bridgeadapter1 "Realtek 8822CE Wireless LAN 802.11ac PCI-E NIC"

# Configurar el orden de arranque (DVD primero, luego Disco)
VBoxManage modifyvm $vmName --boot1 dvd --boot2 disk

# Habilitar EFI
VBoxManage modifyvm $vmName --firmware efi

# Configurar el controlador de video como VMSVGA
VBoxManage modifyvm $vmName --graphicscontroller vmsvga

# Crear un disco duro virtual de 25 GB
VBoxManage createmedium disk --filename "$env:USERPROFILE\VirtualBox VMs\$vmName\$vmName.vdi" --size 25600 --format VDI

# Añadir un controlador SATA y conectar el disco duro virtual
VBoxManage storagectl $vmName --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach $vmName --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$env:USERPROFILE\VirtualBox VMs\$vmName\$vmName.vdi"

# Añadir un controlador IDE y conectar la imagen ISO
VBoxManage storagectl $vmName --name "IDE Controller" --add ide
VBoxManage storageattach $vmName --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium "C:/Users/ospin/OneDrive/Documentos/Universidad/EstudioTI/SO/debian-12.5.0-amd64-netinst.iso"

# Confirmar que la máquina virtual ha sido creada y configurada
Write-Host "La maquina virtual '$vmName' ha sido creada y configurada con exito."
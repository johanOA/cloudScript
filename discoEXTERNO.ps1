VBoxManage createhd --filename "$env:USERPROFILE\VirtualBox VMs\discoExterno.vdi" --size 4096 --variant Standard
VBoxManage storageattach "MiVM" --storagectl "SATA Controller" --port 1 --device 0 --type hdd --medium "$env:USERPROFILE\VirtualBox VMs\discoExterno.vdi"
VBoxManage startvm "MiVM" --type headless
# Esperar a que la máquina virtual se inicie completamente
Start-Sleep -Seconds 10
VBoxManage guestcontrol "MiVM" copyto "C:\Users\ospin\OneDrive\Documentos\Universidad\9no_semestre\Computacion\discoEXTERNO.ps1" "/home/user/script.sh" --username user --password user


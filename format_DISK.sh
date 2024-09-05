#!/bin/bash

# Listar todos los discos
echo "Listando discos..."
lsblk

# Identificar el disco externo (ejemplo: /dev/sdb)
DISCO="/dev/sdb"

# Verificar si el disco existe
if [ -b "$DISCO" ]; then
    echo "El disco externo $DISCO ha sido identificado."

    # Formatear el disco con ext4
    echo "Formateando el disco $DISCO..."
    mkfs.ext4 $DISCO

    echo "Formateo completado."
else
    echo "El disco $DISCO no se encontró."
fi

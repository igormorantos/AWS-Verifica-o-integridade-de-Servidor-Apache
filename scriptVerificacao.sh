#!/bin/bash

# Definir variáveis
DATA=$(date +%d/%m/%Y)
HORA=$(date +%H:%M:%S)
SERVICO="httpd"

# Verificar se o serviço está em execução
if systemctl is-active "$SERVICO" > /dev/null; then
  STATUS="active"
else
  STATUS="inactive"
fi

# Gerar mensagem
MENSAGEM="O $SERVICO está $STATUS"

# Registrar mensagem no arquivo de log
echo "$DATA $HORA - $SERVICO - $STATUS - $MENSAGEM" >> /mnt/nfs/igor/statusServer.txt

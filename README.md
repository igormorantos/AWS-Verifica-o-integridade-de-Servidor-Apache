<h1>AWS-Verifica-o-integridade-de-Servidor-Apache</h1>

<h3>Objetivos:</h3>

- Provisionar uma instância EC2 na AWS

- Configurar o NFS na instância EC2
  
- Usar o NFS para armazenar dados

<h3>A atividade consistirá nas seguintes etapas:</h3>

- Geração de uma chave pública de acesso para o usuário.
- Criação de uma instância EC2 com o sistema operacional Amazon Linux 2.
- Atribuição de um endereço IP elástico à instância EC2.
- Abertura de portas de comunicação para acesso público à instância EC2.
- Configuração do NFS para compartilhar arquivos com outras instâncias EC2.
- Criação de um diretório no filesystem do NFS com o nome do usuário.
- Instalação e configuração do servidor web Apache.
- Criação de um script para verificar se o serviço Apache está online e enviar o resultado para o diretório NFS.
- Configuração da execução automatizada do script a cada 5 minutos.

<h1>Requisitos</h1>

<h2>AWS:</h2>
- 1 chave publica para acesso ao ambiente

- Amazon Linux 2
    
    - t3.small
    
    - 16 GB SSD

- Gerar 1 Elastic IP e anexar à instancia EC2

- Portas de comunicação liberadas para acesso publico
    
    - 22/TCP (SSH)
    
    - 111/TCP e UDP (RPC)
    
    - 2049/TCP/UDP (NFS)
    
    - 80/TCP (HTTP)
    
    - 443/TCP (HTTPS)

<h2>Linux Ec2:</h2>
- Configurar o NFS entregue;

- Criar um diretorio dentro do filesystem do NFS com seu nome;

- Subir um apache no servidor - o apache deve estar online e rodando

- Criar um script que valide se o serviço esta online e envie o resultado da
validação para o seu diretorio no nfs;

    - O script deve conter - Data HORA + nome do serviço + Status + mensagem
      personalizada de ONLINE ou offline;
      
    - O script deve gerar 2 arquivos de saida: 1 para o serviço online e 1 para o
      serviço OFFLINE;
      
- Preparar a execução automatizada do script a cada 5 minutos.

- Fazer o versionamento da atividade;

- Fazer a documentação explicando o processo de instalação do Linux.

--------------------------------------------------------------------------------------------------


<h2>Passo a Passo da Atividade: </h2>

### Gerar uma chave pública de acesso na AWS e anexá-la à uma nova instância EC2.
- Feita Durante a criação da instancia na hora de seleciona-la voce pode criar uma nova chave e ja vincular com o EC2


### Alocar um endereço IP elástico à instância EC2.

- Acessar a AWS na pagina do serviço EC2, e clicar em "IPs elásticos" no menu lateral esquerdo.
- Clicar em "Alocar endereço IP elástico".
- Selecionar o ip alocado e clicar em "Ações" > "Associar endereço IP elástico".
- Selecionar a instância EC2 criada anteriormente e clicar em "Associar".

### Configurar regras de segurança.
- Ao criar a instancia voce pode criar as regras de segurança e os grupos juntamente com a instancia nas opções que ela oferece
- Selecionar o grupo de segurança da instância EC2 que esta sendo criada.
- Configurar as seguintes regras:
    Tipo | Protocolo | Intervalo de portas | Origem |
    ---|---|---|---|
    SSH | TCP | 22 | 0.0.0.0/0 |
    TCP personalizado | TCP | 80 | 0.0.0.0/0 |
    TCP personalizado | TCP | 443 | 0.0.0.0/0 |
    TCP personalizado | TCP | 111 | 0.0.0.0/0 |
    UDP personalizado | UDP | 111 | 0.0.0.0/0 |
    TCP personalizado | TCP | 2049 | 0.0.0.0/0 |
    UDP personalizado | UDP | 2049 | 0.0.0.0/0 |

### Criar Um EFS

Criando o Elastic File System:

 - Ir ao Criar sistema de arquivo
 - Criar nome do EFS
 - Escolher a vpc

### Configurar o NFS com o IP fornecido

- Criar um novo diretório para o NFS usando o comando `sudo mkdir /mnt/nfs`.
- Montar o NFS no diretório criado usando o comando `sudo mount IP_OU_DNS_DO_EFS:/ /mnt/nfs`.
- Verificar se foi montado com o comando `df -h`.
- Criar um novo diretório para o usuário `sudo mkdir /mnt/nfs/nomeDaSuaPasta`.

### Configurar o Apache.

- para atualizar o sistema: `sudo yum update -y`
- instalar o apache `sudo yum install httpd -y`
- iniciar o apache `sudo systemctl start httpd`
- habilitar o apache para iniciar automaticamente `sudo systemctl enable httpd`
- verificar o status do apache. `sudo systemctl status httpd`

### Configurar o script de validação.

- Crie um novo arquivo de script usando o comando "vim script.sh" e insira o seguinte codigo:
    ```bash
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
    MENSAGEM="O serviço $SERVICO está $STATUS"

    # Registrar mensagem no arquivo de log
    echo "$DATA $HORA - $SERVICO - $STATUS - $MENSAGEM" >> /mnt/nfs/igor/statusServer.txt
    ```
    
- Execute o comando `chmod +x script.sh` para tornar o arquivo de script executável.
- Execute o comando `./script.sh` para executar o script.

### Configurar a execução do script de validação a cada 5 minutos.

### Configurar o cronjob.

- Execute o comando `crontab -e` para editar o cronjob.
- Adicione a seguinte linha de código no arquivo de cronjob:
    ```bash
    */5 * * * * /caminho-para-seu-arquivo
    ```
    
- Após salvar Execute o comando `crontab -l` para verificar se foi escrito e salvo.

</details>

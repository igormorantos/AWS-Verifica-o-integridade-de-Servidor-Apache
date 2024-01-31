<h1>Projeto-Linux</h1>

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

AWS:
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


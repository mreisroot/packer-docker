# Criação automatizada de imagem de container pelo Packer

Neste projeto, há a criação de imagens Docker através do Packer.

## Procedimento de criação

1. Importar imagens do Docker Hub
1. Criar contêineres
1. Executar provisionadores
1. Criar imagens a partir destes contêineres
1. Matar os contêineres
1. Rotular as imagens

## Resultados

Após a execução do Packer, você terá:

Duas imagens personalizadas do Ubuntu compiladas de forma paralela.

## Como usar este projeto

[Instale o Packer](https://developer.hashicorp.com/packer/downloads)
[Instale o Docker](https://docs.docker.com/engine/install/)

Caso esteja utilizando um usuário comum no Linux, adicione seu usuário ao grupo docker:

`sudo usermod -aG docker <nome_do_seu_usuario>`

Para executar o código do Packer, execute:

`packer build .`

O Packer apenas cria as imagens de container ou imagens de máquina virtual. O gerenciamento destas imagens é responsabilidade sua.

Para visualizar as imagens criadas:

`docker image ls`

Para criar um container de uma destas imagens e entrar no modo interativo:

`docker container run -it <ID_DA_IMAGEM>`

**Dica**: Você pode digitar apenas os 3 primeiros dígitos da id de uma imagem ou de um contêiner para interagir com eles, que funcionará da mesma forma que digitar a id inteira. Isso economiza tempo.

Para sair e matar o contêiner criado:

`exit`

Para apagar todas as imagens criadas:

`docker image rm -f $(docker ls -aq)`

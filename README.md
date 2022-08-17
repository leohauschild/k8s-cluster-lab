# k8s-cluster-lab

Este é um projeto pessoal que criei para estudos da ferramenta de automação Ansible. Porém ao decorrer do projeto vi a possibilidade de automatizar o ambiente com Terraform e ainda aproveitei para começar os estudos em Kubernetes. 




## Ferramentas utilizadas:

- VMware Vcenter
- Terraform
- Ansible
- Docker
- Kubernetes
- Helm
- Prometheus
## Como que o projeto funciona?

Utilizo 3 VMs rodando o Ubuntu 22.04, são 2 workers e 1 Master. Para fazer o deploy das VMs de forma automatizada utilizo VMware + Terraform. 

Com o ambiente pronto faço a utilização do Ansible para criar um cluster k8s, o qual já faz o deploy de uma aplicação em python (super simples) que eu criei e deixei publicada no meu Docker Hub.

O Ansible já instala o Helm e em seguida o Prometheus, com isso consigo fazer a monitoração do cluster.

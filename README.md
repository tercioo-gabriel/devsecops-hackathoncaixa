# 📊 Projeto DevSecOps – HACKATHON CAIXA 2025
## Ambiente Quarkus com Kubernetes, CI/CD e Observabilidade

Este projeto tem como objetivo automatizar o deploy de uma aplicação Quarkus em um ambiente Kubernetes local, utilizando Minikube para orquestração, GitHub Actions para CI/CD, além de monitoramento integrado com Prometheus e Grafana.<br><br>

### O fluxo implementado contempla:

- Ambientes separados de DES (desenvolvimento) e PRD (produção).
- Pipeline de CI/CD no GitHub Actions para build, testes e deploy automático.
- Build nativo da aplicação Quarkus com Maven.
- Observabilidade via Prometheus + Grafana, acessível localmente.<br><br>

### 🛠️ Tecnologias Utilizadas:

- Quarkus → Framework Java nativo em Kubernetes.
- Maven → Build e empacotamento da aplicação.
- Docker → Containerização da aplicação.
- Minikube → Cluster Kubernetes local.
- Kubectl → Gerenciamento do cluster Kubernetes.
- GitHub Actions → Pipeline de CI/CD.
- Prometheus → Coleta de métricas da aplicação.
- Grafana → Visualização das métricas.<br><br>

### 📦 Pré-requisitos:

Antes de rodar localmente, certifique-se de ter instalado:
- ✅ Java 17+ (JDK)
- ✅ Maven
- ✅ Docker
- ✅ Minikube
- ✅ Kubectl<br><br>

## ⚡ Como Rodar Localmente<br>

1️⃣ Subir o cluster local com Minikube
```bash
minikube start
```
<br>

2️⃣ Compilar a aplicação com Maven
```bash<br>
./mvnw clean package -Pnative -DskipTests
```
<br>

3️⃣ Criar a imagem Docker local
```bash
docker build -t quarkus-app:1.0 .
```
Se necessário, exportar a imagem para o Minikube:
```bash
minikube image load quarkus-app:1.0
```
<br>

4️⃣ Aplicar os manifests no Kubernetes
```bash<br>
kubectl apply -f k8s/des/
kubectl apply -f k8s/prd/
```
<br>

5️⃣ Subir Prometheus e Grafana
```bash
kubectl apply -f monitoring/prometheus.yaml
kubectl apply -f monitoring/grafana.yaml
```
<br>

6️⃣ Acessar os serviços localmente
- Aplicação Quarkus:
```bash
minikube service quarkus-app --url
```
Para validar adicione um **/hello** ao final do URL para retornar uma outra página.<br><br>

- Prometheus:
```bash
minikube service prometheus --url
```
- Grafana:
```bash
minikube service grafana --url
```
<br><br>

## 📊 Observabilidade<br>

O endpoint de métricas da aplicação está exposto em:
```bash<br>
/q/metrics
```
<br>

- O Prometheus coleta automaticamente essas métricas.
- O Grafana pode ser configurado para utilizar Prometheus como Data Source, permitindo a criação de dashboards personalizados.<br><br>

***

🔄 CI/CD para rodar o workflow é necessária ativação manual no GitHub Actions:<br>

- Executa testes e build da aplicação.
- Gera a imagem Docker e publica (se configurado).
- Realiza deploy no cluster Kubernetes (em ambiente DES ou PRD).
- Em PRD realiza deploy automático com o Fly.io<br><br>

Link em PRD: https://devsecops-hackathoncaixa-prd.fly.dev/hello

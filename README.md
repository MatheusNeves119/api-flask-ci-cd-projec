# 🐍 Projeto de CI/CD Completo com Flask e Jenkins

Este projeto demonstra a implementação de um pipeline completo de Integração Contínua e Entrega Contínua (CI/CD) usando **Python (Flask)**, **Docker** para containerização e **Jenkins** como orquestrador do pipeline.

O foco da aplicação é em sua automação e processo DevOps, e não na complexidade funcional.

---

## 1. ⚙️ Visão Geral da Aplicação

A aplicação é uma **API REST simples** desenvolvida em Python 3.11 usando o framework Flask.

* **Funcionalidade Principal:** Fornecer um *endpoint* de verificação de saúde (`/health`) para indicar o status da API.
* **Propósito:** Servir como um serviço mínimo para validação de testes unitários, empacotamento em Docker e demonstração do ciclo de CI/CD.

### Endpoint

| Rota | Método | Descrição | Resposta de Sucesso (Status 200) |
| :--- | :--- | :--- | :--- |
| `/health` | `GET` | Verifica se a aplicação está online e retorna metadados. | `{"status": "online", "service": "api-flask-ci-cd", "version": "1.0.0"}` |

---

## 2. 🛠️ Pré-requisitos e Execução Local

### Pré-requisitos

* Python 3.x
* Pip (gerenciador de pacotes do Python)
* Docker (para construir e rodar o contêiner)
* Git

### Execução Via Docker (Método Recomendado)

1.  **Construir a Imagem Docker:**
    ```bash
    docker build -t api-flask-ci-cd-projec:latest .
    ```
2.  **Executar o Contêiner:**
    ```bash
    docker run -d --name my-api -p 5000:5000 api-flask-ci-cd-projec:latest
    ```
3.  **Acessar a API:**
    * Abra o navegador ou use o `curl` para acessar: `http://localhost:5000/health`

---

## 3. 🧪 Testes Automatizados e Relatórios

O projeto utiliza a biblioteca **Pytest** para executar testes unitários, garantindo que a funcionalidade básica (`/health`) esteja operando corretamente. A configuração gera relatórios no formato JUnit, essenciais para o Jenkins.

### Como Rodar os Testes Localmente

1.  **Instalar Dependências:**
    ```bash
    pip install -r requirements.txt
    ```
2.  **Executar Testes e Gerar Relatório JUnit:**
    ```bash
    pytest --junitxml=junit-report.xml tests/
    ```

### Casos de Teste (Implementado em `tests/test_app.py`)

| Tipo | Descrição | Resultado Esperado | Status |
| :--- | :--- | :--- | :--- |
| Unitário | Verifica se o endpoint `/health` retorna o status HTTP 200 e se o campo `status` é "online". | Sucesso (Passando) | **Pass** |
| Cobertura | Demonstra a execução de testes de cobertura de código. | Sucesso (Passando) | **Pass** |
| (Simulação) | *Um teste intencionalmente falho seria adicionado aqui para demonstrar a quebra do pipeline.* | Falha | **Fail** |

---

## 4. 🚀 Pipeline de CI/CD com Jenkins (`Jenkinsfile`)

O pipeline de CI/CD foi implementado utilizando o método **Pipeline as Code** no arquivo `Jenkinsfile` (sintaxe Declarative). 

O pipeline é composto por **6 *Stages*** que definem todo o ciclo de vida do software:

| Stage (Fase) | Descrição e Ações | Requisito Atendido |
| :--- | :--- | :--- |
| **1. Checkout (SCM)** | Clona o código-fonte do repositório GitHub para o workspace do Jenkins. | *Base do CI* |
| **2. Build (Imagem Docker)** | Executa o `docker build` com base no `Dockerfile`. Esta ação cria o **Artefato de Build** (a imagem Docker). | **Gerar Artefatos** |
| **3. Test (Unitários)** | Roda o **Pytest** dentro de um contêiner temporário, garantindo um ambiente isolado. Gera o arquivo `junit-report.xml`. | **Testes Automatizados** |
| **4. Report (Publicar Resultados)** | Utiliza o plugin JUnit do Jenkins para processar o `junit-report.xml` e exibir graficamente os resultados de testes na interface do Jenkins. | **Registrar Relatórios** |
| **5. Artifact (Push para Registry)** | (Simulado) Faz o *tagging* da imagem e a envia (push) para um Container Registry (ex: Docker Hub), tornando o artefato disponível para o deploy. | **Artefato Disponível** |
| **6. Deploy (Entrega Contínua)** | (Simulado) Executa a ação final de *deploy*, como parar a versão antiga e subir a nova imagem Docker no ambiente de produção/staging. | **Realizar Deploy** |

---


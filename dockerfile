# Usa uma imagem base oficial do Python (slim para ser menor)
FROM python:3.11-slim

# Define o diretório de trabalho dentro do container
WORKDIR /usr/src/app

# Copia o arquivo de dependências e instala
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação
COPY . .

# Expõe a porta que o Gunicorn (servidor) vai usar
EXPOSE 5000

# Comando para rodar a aplicação usando Gunicorn
# 'app:app' significa 'do arquivo app.py, rode a variável app (instância Flask)'
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "app:app"]
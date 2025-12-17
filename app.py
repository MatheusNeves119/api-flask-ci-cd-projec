from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/health', methods=['GET'])
def health_check():
    """Endpoint para verificar a saúde e a versão da API."""
    response = {
        "status": "online",
        "service": "api-flask-ci-cd",
        "version": "1.0.0"
    }
    return jsonify(response), 200

if __name__ == '__main__':
    # Usaremos Gunicorn no Docker, mas aqui é para testes locais
    app.run(host='0.0.0.0', port=5000)
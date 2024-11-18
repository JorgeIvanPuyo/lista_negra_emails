from flask import Flask
from flask_restful import Api
from .services import EmailDarkList, EmailDark, Login, Health
from .db import init_db
from flask_jwt_extended import JWTManager

app = Flask(__name__)
api = Api(app)

app.config['JWT_SECRET_KEY'] = 'super-secret-for-rabbits'
jwt = JWTManager(app)

init_db(app)

api.add_resource(EmailDarkList, '/blacklist')
api.add_resource(EmailDark, '/blacklist/<email>')
api.add_resource(Login, '/login')
api.add_resource(Health, '/health')

if __name__ == '__main__':
    app.run(debug=True)

# Usa una imagen base de Python 3.9
FROM python:3.9-slim
# Establece el directorio de trabajo
WORKDIR /app

COPY requirements.txt .
# Instala las dependencias de la aplicación
RUN pip install -r requirements.txt --no-cache-dir

# Copia los archivos de la aplicación al directorio de trabajo
COPY src /app/src
COPY tests /app/tests

RUN groupadd -r user-app && useradd -r -g user-app -d /app user-app
RUN chown -R user-app:user-app /app
USER user-app

ENV FLASK_APP=./src/main.py
ENV DB_USER=postgres
ENV DB_PASSWORD=post_123
ENV DB_NAME=rabbit_commerce
ENV DB_HOST=dark_list_db
ENV DB_PORT=5432

# Expone el puerto 8000 para la aplicación
EXPOSE 5000

# Comando para iniciar la aplicación
CMD ["flask", "run", "--host", "0.0.0.0", "--port", "5000", "--reload"]
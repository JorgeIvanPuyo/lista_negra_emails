# Usa una imagen base de Python 3.9
FROM python:3.9-slim

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos necesarios
COPY requirements.txt .
COPY newrelic.ini .

# Instala las dependencias de la aplicación
RUN pip install -r requirements.txt --no-cache-dir

# Copia los archivos de la aplicación al directorio de trabajo
COPY src /app/src
COPY tests /app/tests

# Crea un usuario no root para mayor seguridad
RUN groupadd -r user-app && useradd -r -g user-app -d /app user-app
RUN chown -R user-app:user-app /app
USER user-app

# Configura las variables de entorno necesarias
ENV FLASK_APP=./src/main.py

# Expone el puerto 3000 para la aplicación
EXPOSE 3000

# Comando para iniciar la aplicación con New Relic
CMD ["newrelic-admin", "run-program", "flask", "run", "--host", "0.0.0.0", "--port", "3000"]
#CMD ["flask", "run", "--host", "0.0.0.0", "--port", "3000", "--reload"]
#CMD ["newrelic-admin", "run-program", "gunicorn", "-w", "4", "-b", "0.0.0.0:3000", "src.main:app"]
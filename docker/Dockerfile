FROM python:3.9-slim
WORKDIR /app
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app/ .
# Ensure instance folder exists
RUN mkdir -p flaskr/instance
EXPOSE 5000
# Initialize DB on container start and run Flask
ENTRYPOINT ["sh", "-c", "flask --app flaskr init-db && flask --app flaskr run --host=0.0.0.0"]


# Use the official Apache Airflow image as the base
FROM apache/airflow:2.9.3

# Set the working directory inside the container
WORKDIR /opt/airflow

# Copy any additional requirements files if needed
# COPY requirements.txt .

# Install additional Python packages if needed
# RUN pip install --no-cache-dir -r requirements.txt

# Copy custom DAGs, plugins, etc. into the container
COPY dags/ /opt/airflow/dags/
COPY plugins/ /opt/airflow/plugins/

# Set environment variables
ENV AIRFLOW__CORE__EXECUTOR=SequentialExecutor
ENV AIRFLOW__DATABASE__SQL_ALCHEMY_CONN=sqlite:////opt/airflow/airflow.db
ENV AIRFLOW__CORE__LOAD_EXAMPLES=False
ENV AIRFLOW__WEBSERVER__BASE_URL=https://airflow-docker-compose-v1-fga9gahehfbpaca0.southindia-01.azurewebsites.net
ENV _AIRFLOW_DB_MIGRATE=true
ENV _AIRFLOW_WWW_USER_CREATE=true
ENV _AIRFLOW_WWW_USER_USERNAME=admin
ENV _AIRFLOW_WWW_USER_PASSWORD=admin

# Expose port 8080 for the Airflow webserver
EXPOSE 8080

# Define the default command to run when starting the container
CMD ["bash", "-c", "
  if ! airflow users check --username admin; then
    airflow users create -r Admin -u admin -e admin@example.com -f Admin -l User -p admin;
  fi &&
  airflow webserver
"]

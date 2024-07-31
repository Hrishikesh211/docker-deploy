# Use the official Apache Airflow image as the base image
FROM apache/airflow:2.9.3

# Switch to root user to install system-level dependencies
USER root

# Install PostgreSQL client and development libraries
RUN apt-get update && apt-get install -y \
    libpq-dev gcc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip to the latest version
RUN pip install --upgrade pip

# Copy the requirements file into the container
COPY requirements.txt /requirements.txt

# Install the dependencies from requirements.txt
RUN pip install --no-cache-dir -r /requirements.txt

# Copy DAGs, plugins, or any other Airflow-specific files if needed
# COPY dags /opt/airflow/dags
# COPY plugins /opt/airflow/plugins

# Ensure the ownership of the airflow folder is correct
RUN chown -R ${AIRFLOW_UID:-50000}:${AIRFLOW_GID:-50000} /opt/airflow

# Switch back to the airflow user
USER ${AIRFLOW_UID:-50000}:${AIRFLOW_GID:-50000}

# Set the entrypoint to Airflow (optional)
# ENTRYPOINT ["airflow"]

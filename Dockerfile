# Use the official Airflow image as the base image
FROM apache/airflow:2.0.2

# Switch to root user to install dependencies
USER root

# Install PostgreSQL client and development libraries
RUN apt-get update && apt-get install -y \
    libpq-dev gcc

# Upgrade pip to the latest version
RUN pip install --upgrade pip

# Copy the requirements file into the container
COPY requirements.txt requirements.txt

# Install the dependencies from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Switch back to the airflow user
USER ${AIRFLOW_UID:-50000}:${AIRFLOW_GID:-50000}

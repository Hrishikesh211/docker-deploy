# Use the official Apache Airflow image as the base image
FROM apache/airflow:2.9.3

# Set environment variables
ENV AIRFLOW_HOME=/opt/airflow

# Copy custom scripts or files (like init_airflow.sh) if needed
COPY init_airflow.sh /init_airflow.sh

# Set permissions and make the script executable
RUN chmod +x /init_airflow.sh

# Expose the webserver port
EXPOSE 8080

# Command to run the Airflow webserver
CMD ["/init_airflow.sh"]

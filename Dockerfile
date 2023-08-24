# Use an official Python runtime as the base image
FROM python:3.9-slim

# Set environment variables
ENV APP_HOME /app

# Create and set the working directory
WORKDIR $APP_HOME

# Install Python dependencies
COPY requirements.txt $APP_HOME/
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code into the container
COPY . $APP_HOME/

# Expose port
EXPOSE 8000

# Define the command to run on startup
CMD gunicorn -b 0.0.0.0:8000 app:app

# Cleanup unnecessary files
RUN apt-get purge -y --auto-remove && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

# Set the maintainer label
LABEL maintainer="saiparthiv95@gmail.com"

# Set a health check for the application
HEALTHCHECK --interval=30s --timeout=10s \
    CMD curl -f http://localhost:8000/ || exit 1


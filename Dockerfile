# Dockerfile for a Java WAR-based Microservice
# This Dockerfile assumes you have a pre-built WAR file (e.g., my-microservice.war) in the build context.
# It uses the official Tomcat image as the base for deploying the WAR.
# For microservices, replicate this pattern for each service, adjusting the WAR name and any service-specific configs.

# Use a lightweight Tomcat image with JRE (adjust version as needed for your Java app)
FROM tomcat:9.0-jre11-slim

# Set maintainer label (optional)
LABEL maintainer="your-team@example.com"
LABEL description="Docker image for Java WAR microservice"

# Remove default Tomcat webapps to keep the image lean
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR file into Tomcat's webapps directory
# Replace 'my-microservice.war' with your actual WAR file name
COPY my-microservice.war /usr/local/tomcat/webapps/ROOT.war

# Expose the default Tomcat port
EXPOSE 8080

# Health check (optional: checks if the app is responsive)
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8080/actuator/health || exit 1

# Start Tomcat (default CMD from base image)
CMD ["catalina.sh", "run"]

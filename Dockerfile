# Dockerfile for deploying two pre-built microservices (as WAR files) on Tomcat
# Assumptions:
# - Pre-built microservices are WAR files: service1.war and service2.war in the build context.
# - They will deploy as /service1 and /service2 contexts on Tomcat.
# - Using Tomcat 10 with OpenJDK 17 for modern Java apps (adjust version as needed).

FROM tomcat:10-jdk17

# Remove default Tomcat webapps (e.g., ROOT, docs, examples) to keep it clean
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the pre-built WAR files for the two microservices
# They will auto-deploy on startup
COPY service1.war /usr/local/tomcat/webapps/service1.war
COPY service2.war /usr/local/tomcat/webapps/service2.war

# Expose the default Tomcat port
EXPOSE 8080

# Start Tomcat (default CMD from base image)
CMD ["catalina.sh", "run"]

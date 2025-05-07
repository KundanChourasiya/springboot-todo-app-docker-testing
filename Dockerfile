# Stage1 - Build the Jar (Java Application Runtime) Using maven
# Maven image
FROM maven:3.8.3-openjdk-17 AS builder

# Set working directory
WORKDIR /app

# Copy source code from local to container
COPY . .

# Build application and skip test cases and create Jar/war file
#EXPOSE 8080
RUN mvn clean install -DskipTests=true

# ENTRYPOINT ["java", "-jar", "/todo-app.war"]

# Stage 2 - Re-execute Jar file from the above stage
# Import small size java image
FROM openjdk:17-alpine

# Set working directory
WORKDIR /app

# Copy build from stage 1 (builder)
COPY --from=builder /app/target/*.war /app/target/todo-app.war

# Expose application port
EXPOSE 8080

# Start the application
# ENTRYPOINT ["java", "-jar", "/app/target/todo-app.war"]

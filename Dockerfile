# Stage1 - Build the Jar (Java Application Runtime) Using maven
# Maven image
FROM maven:3.9.9-openjdk-17 AS builder

# Set working directory
WORKDIR /app

# Copy source code from local to container
COPY . /app

# Build application and skip test cases and create Jar file
#EXPOSE 8080
RUN mvn clean install -DskipTests=true

# ENTRYPOINT ["java", "-jar", "/todo-app.jar"]

# Stage 2 - Rexecute Jar file from the above stage
# Import small size java image
FROM openjdk:17-alpine

# Set working directory
WORKDIR /app

# Copy build from stage 1 (builder)
COPY --from=builder /app/target/*.jar /app/target/todo-app.jar

# Expose application port
EXPOSE 8080

# Start the application
ENTRYPOINT ["java", "-jar", "/app/target/todo-app.jar"]

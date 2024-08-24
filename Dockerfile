# Stage 1: Build the Maven project
FROM maven:3.6.3-openjdk-11 AS build

# Set the working directory
WORKDIR /app

# Copy the Maven project files
COPY pom.xml .
COPY src /app/src

# Download dependencies and build the project
RUN mvn clean package -DskipTests

# Stage 2: Create the final image
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/basic-webapp.war /app/target/basic-webapp.war

# Expose the port on which the app will run
EXPOSE 8080

# Command to run the JAR file
ENTRYPOINT ["java", "-jar", "/app/target/basic-webapp.war"]

# ---- Stage 1: Build the app ----
FROM maven:3.8.7-openjdk-21 AS build
WORKDIR /app

# Copy Maven config first for caching
COPY pom.xml .

# Download dependencies only (caching)
RUN mvn dependency:go-offline -B

# Copy the source code
COPY src ./src

# Build the Spring Boot jar (skip tests to speed up)
RUN mvn clean package -DskipTests

# ---- Stage 2: Create a slim runtime image ----
FROM openjdk:21-jdk-slim
WORKDIR /app

# Copy jar from the build stage
COPY --from=build /app/target/*.jar app.jar

# Run the application
ENTRYPOINT ["java","-jar","/app.jar"]

#Stage 1 build the jar file (java application runtime) using maven
FROM maven:3.8.5-openjdk-17 AS build

WORKDIR /app

COPY pom.xml .

COPY src ./src

RUN mvn clean package -DskipTests

# Use a lightweight OpenJDK image to run the application

 FROM openjdk:17-jdk-slim

 WORKDIR /app

 COPY --from=build /app/target/*.jar app.jar

 EXPOSE 8080


 ENTRYPOINT ["java", "-jar", "app.jar"]





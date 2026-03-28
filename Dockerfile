# GIAI ĐOẠN 1: BUILD
FROM maven:3.9.11-eclipse-temurin-25 AS builder
WORKDIR /app
COPY . .
RUN mvn package -DskipTests

# GIAI ĐOẠN 2: RUN
FROM eclipse-temurin:25-jre-jammy
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 80
ENTRYPOINT ["java","-XX:+UseSerialGC","-Xms128m","-Xmx256m","-jar","app.jar"]
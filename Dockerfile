# First stage: build using Maven Wrapper
FROM eclipse-temurin:17 AS build
WORKDIR /app

# Copy build file and Maven Wrapper
COPY pom.xml ./
COPY lombok.config ./
COPY .mvn .mvn
COPY mvnw ./

# Load dependencies (cache this layer)
RUN ./mvnw dependency:resolve

# Copy source code and build the project
COPY src ./src
RUN ./mvnw clean package -DskipTests

# Second stage: create the final image
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/*.jar jira.jar
COPY resources ./resources

# Run the application
CMD ["java", "-jar", "jira.jar"]

# Используем JDK для сборки и JRE для финального контейнера
FROM eclipse-temurin:17-jdk AS build

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем Maven Wrapper, конфигурации и файл lombok.config
COPY .mvn .mvn
COPY mvnw .
COPY pom.xml .
COPY lombok.config .

# Загружаем все зависимости
RUN ./mvnw dependency:go-offline -B

# Копируем исходный код и собираем проект
COPY src ./src
RUN ./mvnw clean package -DskipTests

# Используем более лёгкий образ с JRE
FROM eclipse-temurin:17-jre
WORKDIR /app

# Копируем скомпилированный JAR и файл lombok.config из предыдущего этапа
COPY --from=build /app/target/*.jar app.jar
COPY --from=build /app/lombok.config /app/lombok.config

# Копируем ресурсы (шаблоны и статические файлы)
COPY resources /app/resources

# Устанавливаем профиль и указываем точку входа
ENTRYPOINT ["java", "-Dspring.profiles.active=prod", "-jar", "/app/app.jar"]
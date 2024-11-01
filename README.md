## [REST API](http://localhost:8080/doc)

## Концепция:

- Spring Modulith
    - [Spring Modulith: достигли ли мы зрелости модульности](https://habr.com/ru/post/701984/)
    - [Introducing Spring Modulith](https://spring.io/blog/2022/10/21/introducing-spring-modulith)
    - [Spring Modulith - Reference documentation](https://docs.spring.io/spring-modulith/docs/current-SNAPSHOT/reference/html/)

```
  url: jdbc:postgresql://localhost:5432/jira
  username: jira
  password: JiraRush
```

- Есть 2 общие таблицы, на которых не fk
    - _Reference_ - справочник. Связь делаем по _code_ (по id нельзя, тк id привязано к окружению-конкретной базе)
    - _UserBelong_ - привязка юзеров с типом (owner, lead, ...) к объекту (таска, проект, спринт, ...). FK вручную будем
      проверять

## Аналоги

- https://java-source.net/open-source/issue-trackers

## Тестирование

- https://habr.com/ru/articles/259055/

# How to Run the Project

To run this project locally, you only need **Docker**. No need to worry about Maven or JVM versions — everything is 
handled automatically via **Maven Wrapper** and a multi-stage Docker build. This setup minimizes compatibility issues 
and keeps the final image efficient and ready for deployment.

## Required Environment Variables

Before running the project, ensure the following environment variables are set on your machine:

- **Database Configuration:**
    - `SPRING_DATASOURCE_URL`
    - `SPRING_DATASOURCE_USERNAME`
    - `SPRING_DATASOURCE_PASSWORD`
- **OAuth2 Configuration:**
    - `GITHUB_CLIENT_ID`
    - `GITHUB_CLIENT_SECRET`
    - `GOOGLE_CLIENT_ID`
    - `GOOGLE_CLIENT_SECRET`
    - `GITLAB_CLIENT_ID`
    - `GITLAB_CLIENT_SECRET`
- **Mail Configuration:**
    - `MAIL_USERNAME`
    - `MAIL_PASSWORD`

## Port Availability

Ensure the following ports are available on your machine, as they will be used by the containers:

- **80** (for Nginx)
- **8080** (for the Spring Boot application)
- **5432** (for the PostgreSQL database)

## Steps to Build and Run

1. **Build the Docker Image:** The `docker-compose build` command will:

- Compile the application using Maven Wrapper.
- Package it into a lightweight Docker image containing only the runtime resources needed to run the application.

```bash
docker-compose build
```

2. **Run the Docker Container:** Start the application within the container:

```bash
docker-compose up
```

3. **Stopping the Application:** To stop the application, use:

```bash
docker-compose down
```

## Why This Setup?

This approach avoids version conflicts by using consistent Maven and JVM versions within Docker, resulting in 
a lightweight image optimized for production.

### List of Completed Tasks:

2. Removed social networks: VK, Yandex.   
3. Moved sensitive information to a separate properties file.
4. Modified tests to use an **in-memory database (H2)** instead of PostgreSQL during testing.
6. Refactored the method `com.javarush.jira.bugtracking.attachment.FileUtil#upload` to use a modern approach for working 
with the file system.
9. Created a `Dockerfile` for the main server.
10. Created a `docker-compose` file to run the server container along with the database and nginx.

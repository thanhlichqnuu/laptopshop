# Laptopshop

## Prerequisites

Before you begin, ensure you have met the following requirements:

*   **Java Development Kit (JDK) 17:** This project requires JDK 17. You can check your Java version by running:

    ```bash
    java --version
    ```

    If you don't have JDK 17 installed, download and install it from [Adoptium](https://adoptium.net/temurin/releases/?version=17) or [Oracle](https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html). Make sure to set your `JAVA_HOME` environment variable correctly.
*   **Maven:** This project uses Maven for dependency management and building. The Maven Wrapper (`mvnw`) is included, so you don't need to install Maven separately.

## Getting Started

Follow these steps to get the project up and running:

### 1. Clone the Repository (If applicable)

```bash
git clone https://github.com/thanhlichqnuu/laptopshop.git
cd laptopshop-master
```

### 2. Build the Project
Use the Maven Wrapper to build the project:

```bash
mvn clean install
```
### 3. Run the Application
After a successful build, you can run the Spring Boot application using:

```bash
mvn spring-boot:run
```
This will start the embedded web server (e.g., Tomcat) and deploy your application. You should see console output indicating that the application has started successfully. You can then access your application, typically at http://localhost:8080 (the default port).

## Contact
If you have any questions or suggestions, feel free to contact us at thanhlich2103gg@gmail.com.

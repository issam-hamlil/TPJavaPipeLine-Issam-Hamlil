pipeline {
    agent {
        docker {
            // Image containing Maven and Git
            image 'my-maven-git:latest'
            // Map Maven cache to speed up builds
            args '-v /root/.m2:/root/.m2' 
        }
    }
    stages {
        stage('Checkout') {
            steps {
                echo '=== Stage: Checkout ==='
                // Clean directory
                sh 'rm -rf *' 
                // Clone Git repository
                sh 'git clone https://github.com/simoks/java-maven.git'
            }
        }
        stage('Build') {
            steps {
                echo '=== Stage: Build ==='
                script {
                    dir('java-maven/maven') {
                        // Execute Maven Build
                        sh 'mvn clean test package'
                    }
                }
            }
        }
        stage('Test') {
            steps {
                echo '=== Stage: Test ==='
                script {
                    dir('java-maven/maven') {
                        // Generate test report
                        sh 'mvn surefire-report:report'
                    }
                }
            }
        }
        stage('Run Application') {
            steps {
                echo '=== Stage: Run Application ==='
                script {
                    dir('java-maven/maven') {
                        // Run the JAR
                        // Note: This runs inside the build container, so it will exit when the pipeline ends.
                        sh 'java -jar target/maven-0.0.1-SNAPSHOT.jar'
                    }
                }
            }
        }
    }
    post {
        success {
            echo '✅ Pipeline executed successfully!'
        }
        failure {
            echo '❌ Pipeline failed.'
        }
    }
}
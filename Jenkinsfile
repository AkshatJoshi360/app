pipeline {

    agent any

    environment {
        IMAGE_NAME = "akshat10001/app"
    }

    stages {

        stage("Clone Code") {
            steps {
                git url: "https://github.com/AkshatJoshi360/app.git", branch: "main"
                echo "Clone done ✅"
            }
        }

        stage("Build Docker Image") {
            steps {
                sh "sudo docker build -t ${IMAGE_NAME}:latest ."
                echo "Build done ✅"
            }
        }

        stage("Push to Docker Hub") {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: "dockerHub",
                    usernameVariable: "DOCKER_USER",
                    passwordVariable: "DOCKER_PASS"
                )]) {
                    sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                    sh "docker push ${IMAGE_NAME}:latest"
                }
                echo "Pushed to DockerHub ✅"
            }
        }

        stage("Deploy") {
            steps {
                sh "docker system prune -f"
                sh "docker container stop app || true"
                sh "docker container rm app || true"
                sh "docker run -d -p 8080:8080 --name app ${IMAGE_NAME}:latest"
                echo "Deployment done ✅"
            }
        }
    }

    post {
        success {
            emailext(
                to: 'akshatjoshi86302@gmail.com',
                subject: "✅ Build Success: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: "Build successful 🚀\n${env.BUILD_URL}"
            )
        }
        failure {
            emailext(
                to: 'akshatjoshi86302@gmail.com',
                subject: "❌ Build Failed: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: "Build failed ⚠️\n${env.BUILD_URL}"
            )
        }
    }
}
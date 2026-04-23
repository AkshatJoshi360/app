pipeline{

    agent {label "Dev1"};

    stages{
        stage("code"){
            steps{
                git url : "https://github.com/AkshatJoshi-18/broadcast-text", branch : "master"
                echo "clone done ...."
            }
        }
        
        stage("build"){
            steps{
                sh "docker build -t akshat8630/broadcast-text:latest -f Dockerfile-multistage ."
                sh "docker build -t akshat8630/database:latest -f Dockerfile-mysql ."
                echo "build done ...."
            }
        }

        stage("docker hub"){
            steps{ withCredentials([usernamePassword(
                credentialsId : "dockerHub",
                passwordVariable : "dockerHubPass",
                usernameVariable : "dockerHubUser"
                )]){
                    sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}"
                    sh "docker image push ${env.dockerHubUser}/broadcast-text:latest"
                    sh "docker image push ${env.dockerHubUser}/database:latest"
                }
            }
        }

        stage("test"){
            steps{
                echo "testing done ...."
            }
        }

        stage("deploy"){
            steps{
                sh "docker system prune"
                sh "docker image prune -f"
                sh "free -h"
                sh "docker compose down "
                sh "docker compose up -d --build flask-app"
                echo "deploy done ...."
            }
        }
        
    }

    post{
        success{
            emailext(
                to : 'akshatjoshi86302@gmail.com',
                subject : "Build Successful: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body : "Good news! Build was successful.\n\nCheck it here: ${env.BUILD_URL}"
            )
        }
        failure{
            emailext(
                to : 'akshatjoshi86302@gmail.com',
                subject : "❌❌Build Failed❌❌: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body : "Bad news! Build was failed.\n\nCheck it here: ${env.BUILD_URL}"
            )
        }
    }
}
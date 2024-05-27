pipeline {
    agent any

    stages {
        stage('Images Build') {
            steps {
                script {
                    // Выполнение команды сборки docker-образа
                    sh 'make docker-image'
                }
            }
        }

        stage('Service Up') {
            steps {
                script {
                    // Выполнение Ansible playbook
                    sh 'make deploy-to-puppet'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Выполнение команды деплоя сервиса
                    sh 'echo service-deploy'
                }
            }
        }
    }
}
pipeline {
    agent any

    environment {
        TF_DIR = 'terraform'
        TF_LOG = 'ERROR'
        AWS_REGION = 'ap-south-1'
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo '📥 Cloning repo...'
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                dir("${TF_DIR}") {
                    echo '🔧 Initializing Terraform...'
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir("${TF_DIR}") {
                    echo '🧪 Validating Terraform...'
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir("${TF_DIR}") {
                    echo '📋 Running Terraform plan...'
                    sh 'terraform plan -out=tfplan.out'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir("${TF_DIR}") {
                    echo '🚀 Applying infrastructure...'
                    sh 'terraform apply -auto-approve tfplan.out'
                }
            }
        }

        stage('Terraform Output') {
            steps {
                dir("${TF_DIR}") {
                    echo '📤 Showing outputs...'
                    sh 'terraform output'
                }
            }
        }
    }

    post {
        success {
            echo '✅ Terraform pipeline completed successfully!'
        }
        failure {
            echo '❌ Pipeline failed. Check logs.'
        }
    }
}

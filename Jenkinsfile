pipeline {
    agent { label 'Terraform' }

    triggers {
        gitlab(triggerOnMergeRequest: true, triggerOnPush: false, branchFilterType: 'NameBasedFilter', includeBranchesSpec: 'main')
    }

    options {
        skipDefaultCheckout()
    }

    stages {
        stage('Checkout Terraform Code') {
            steps {
                // Checkout du code Terraform depuis GitLab
                git credentialsId: 'gitlab-token-cred', url: 'https://gitlab.com/first-project6045903/jenkins-project.git', branch: 'main'
            }
        }
    
        stage('Init Terraform') {
            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-terraform-key']
                ]) {
                    // Initialisation de Terraform
                    sh 'terraform init'
                }
            }
        }

        stage('Plan Terraform') {
            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-terraform-key']
                ]) {
                    // Planification des changements
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Apply Terraform') {
            steps {
                // Demande de confirmation avant application
                input message: 'Souhaitez-vous appliquer les changements Terraform pour déployer l\'EC2 ?'
                
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-terraform-key']
                ]) {
                    // Application des changements
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }
    }

    post {
        success {
            // Message après une exécution réussie du pipeline
            echo 'Instance EC2 créée avec succès'
        }
        failure {
            // Message après un échec du pipeline
            echo 'Erreur dans le pipeline. Vérifiez les logs pour plus de détails.'
        }
        always {
            // Message affiché à la fin de chaque exécution
            echo 'Pipeline Jenkins terminé'
        }
    }
}
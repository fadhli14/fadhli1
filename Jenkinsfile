// This is the complete Jenkins pipeline for your Terraform project.
// It includes a temporary stage to clean up old load balancer resources from the state file.
pipeline {
    agent any

    // Define parameters for controlling the pipeline
    parameters {
        booleanParam(name: 'PLAN_TERRAFORM', defaultValue: true, description: 'Check to run a Terraform plan')
        booleanParam(name: 'APPLY_TERRAFORM', defaultValue: false, description: 'Check to run a Terraform apply')
        booleanParam(name: 'DESTROY_TERRAFORM', defaultValue: false, description: 'Check to run a Terraform destroy')
    }

    stages {
        // This is a TEMPORARY stage to clean up the Terraform state.
        // You should REMOVE this stage after the pipeline has run successfully once.
        stage('Remove Load Balancer State') {
            steps {
                script {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-crendentails-rwagh']]) {
                        // Check if the state file exists before trying to remove resources from it
                        // The '|| true' ensures the pipeline doesn't fail if the resource isn't in the state.
                        dir('infra') {
                            sh 'terraform init'
                            sh 'terraform state rm module.alb.aws_lb.dev_proj_1_alb || true'
                            sh 'terraform state rm module.alb.aws_lb_listener.dev_proj_1_lb_listner || true'
                            sh 'terraform state rm module.alb.aws_lb_listener.dev_proj_1_lb_https_listner || true'
                        }
                    }
                }
            }
        }

        // Stage to initialize Terraform in the 'infra' directory
        stage('Terraform Init') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-crendentails-rwagh']]) {
                    // Ensure to run in the 'infra' directory where your .tf files are located
                    dir('infra') {
                        sh 'echo "=================Terraform Init=================="'
                        sh 'terraform init'
                    }
                }
            }
        }

        // Stage to run a Terraform plan if the parameter is set to true
        stage('Terraform Plan') {
            when {
                expression { return params.PLAN_TERRAFORM }
            }
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-crendentails-rwagh']]) {
                    dir('infra') {
                        sh 'echo "=================Terraform Plan=================="'
                        sh 'terraform plan'
                    }
                }
            }
        }

        // Stage to apply Terraform changes if the parameter is set to true
        stage('Terraform Apply') {
            when {
                expression { return params.APPLY_TERRAFORM }
            }
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-crendentails-rwagh']]) {
                    dir('infra') {
                        sh 'echo "=================Terraform Apply=================="'
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }

        // Stage to destroy the infrastructure if the parameter is set to true
        stage('Terraform Destroy') {
            when {
                expression { return params.DESTROY_TERRAFORM }
            }
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-crendentails-rwagh']]) {
                    dir('infra') {
                        sh 'echo "=================Terraform Destroy=================="'
                        sh 'terraform destroy -auto-approve'
                    }
                }
            }
        }
    }
}

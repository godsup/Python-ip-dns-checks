pipeline {
    agent any
    stages {
        // stage('Checkout') {
        //     steps {
        //     checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/godsup/Python-ip-dns-checks.git']]])            

        //   }
        // }

        stage ("Clone the repository") {
            steps {
                sh ('rm -r Python-ip-dns-checks')
                sh ('git clone https://github.com/godsup/Python-ip-dns-checks.git')
                // sh ('cd /Terraform-ec2-docker-jenkins-pythonscript') 
            }
        }
        stage ("Run python code") {
            steps {
                sh ('python3 checks.py') 
            }
        }
        
        stage ("Add the file and commit it") {
            steps {
                sh ('git add output.csv')
                sh ('git commit -m "automatic commit" output.csv')
                //sh ('git remote add origin https://github.com/godsup/Python-ip-dns-checks.git')
                sh ('git push') 
           }
        }
    }
}
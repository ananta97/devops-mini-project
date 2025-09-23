pipeline {
  agent any

  environment {
    IMAGE = "devops-mini-project:${env.BUILD_NUMBER}"
    CONTAINER_NAME = "devops_app"
    HOST_PORT = "8081"
    CONTAINER_PORT = "5000"
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build Image') {
      steps {
        sh 'docker build -t ${IMAGE} -f docker/Dockerfile .'
      }
    }

    stage('Stop Old Container') {
      steps {
        sh '''
          if [ "$(docker ps -q -f name=${CONTAINER_NAME})" ]; then
            docker stop ${CONTAINER_NAME}
          fi
          if [ "$(docker ps -aq -f name=${CONTAINER_NAME})" ]; then
            docker rm ${CONTAINER_NAME}
          fi
        '''
      }
    }

    stage('Run Container') {
      steps {
        sh 'docker run -d --name ${CONTAINER_NAME} -p ${HOST_PORT}:${CONTAINER_PORT} --restart unless-stopped ${IMAGE}'
      }
    }

    stage('Cleanup Images') {
      steps {
        sh 'docker image prune -f || true'
      }
    }
  }

  post {
    always {
      echo "Build ${env.BUILD_NUMBER} finished."
    }
  }
}

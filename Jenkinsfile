node {
    stage('checkout') {
        git  'https://github.com/Ranjana1984/newproject.git'
    }
    stage('creating infrastructure using terraform') {
        withCredentials([[
        $class: 'AmazonWebServicesCredentialsBinding',
        accessKeyVariable: 'AWS_ACCESS_KEY_ID',
        credentialsId: 'creds-id',
        secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) 
        {
        def terraformPath = "/usr/bin/terraform"
        sh "${terraformPath} init"
        sh "${terraformPath} apply -auto-approve"
        sh "${terraformPath} output test_server_ip > test_ip.txt"
        sh "${terraformPath} output prod_server_ip > prod_ip.txt"
         # sh "${terraformPath} destroy"    
        }
    }
     
    stage('updating ansible file'){
        def testIp = readFile('test_ip.txt').trim().replaceAll('"', '')
        def prodIp = readFile('prod_ip.txt').trim().replaceAll('"', '')
        def ansibleInventoryPath = '/etc/ansible/hosts'
        sh "echo '[test-server]' > ${ansibleInventoryPath}"
        sh "echo '${testIp}' >> ${ansibleInventoryPath}"
        sh "echo '[prod-server]' >> ${ansibleInventoryPath}"
        sh "echo '${prodIp}' >> ${ansibleInventoryPath}"
    }

}

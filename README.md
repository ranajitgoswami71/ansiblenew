## Ansible Provisioning EC2 hosts

**Usage:**

Create a variables file using *ec2_vars/sample.yml* as a template.

E.g. 

    cp ec2_vars/sample.yml ec2_vars/dockeransible.yml
    
After setting all variables, run it:

ansible-playbook -vv -i localhost, -e "type=dockeransible" provision-ec2.yml

Jenkins job configuration :

Github project url:
-------------------
https://github.com/ranajitgoswami71/ansiblenew.git/

Build : execute shell 1
------------------------
id
hostname
cd /home/ubuntu/anspract
sudo rm -rf ansiblenew
sudo /usr/bin/git clone https://github.com/ranajitgoswami71/ansiblenew.git
sudo chown -R ubuntu:ubuntu /home/ubuntu/anspract/ansiblenew
sudo chmod 777 /home/ubuntu/anspract/ansiblenew
cd /home/ubuntu/anspract/ansiblenew
sudo ansible-playbook -vvv -e "type=dockeransible" provision-ec2.yml > /home/ubuntu/anspract/ansiblenew/provision_ec2.log
cat /home/ubuntu/anspract/ansiblenew/provision_ec2.log

Build : execute shell 2
-----------------------
ip=`cat /home/ubuntu/anspract/ansiblenew/provision_ec2.log | grep "public_ip" | head -1 | cut -d ":" -f2 | tr -d '"' | cut -d "," -f1 | tr -d ' '`
scp -i /home/ubuntu/anspract/dockeransible.pem -o StrictHostKeyChecking=no /var/lib/jenkins/.ssh/id_rsa.pub ubuntu@"${ip}":~/.ssh/authorized_keys
host_count=`cat /etc/ansible/hosts|grep -v "localhost"|grep -v "#"|tr -s '\n'|wc -l`
if [ host_count > 2 ]
    then
        sudo sed -i '1d;$d' /etc/ansible/hosts
        sudo echo "${ip} ansible_python_interpreter=python3" >> /etc/ansible/hosts
    else
        sudo echo "${ip} ansible_python_interpreter=python3" >> /etc/ansible/hosts
fi

Build : Invoke Ansible plugin 1
-------------------------------
/home/ubuntu/anspract/ansiblenew/ebsmapping-ec2.yml

Build : Invoke Ansible plugin 2
-------------------------------
/home/ubuntu/anspract/ansiblenew/provision-docker.yml

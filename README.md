# control_repo

Simple Minecraft Java Server agent based on JDK 17 using the puppetlabs java module and Adoptium Temurin (java::adoptium) and a master server to handle web, db, and minecraft server(s).

[Installation]:
- Using Vagrant and Oracle VM VirtualBox, configure the vagrant file and start up the VM.
- Add puppetserver repo using "rpm -Uvh https://yum.puppet.com/puppet7-release-el-7.noarch.rpm"
- Install puppetserver and git for version control "yum install -y puppetserver git"
- Configure the puppetserver service's resource allocation by altering the /etc/sysconfig/puppetserver file to set the desired RAM usage etc.
- Start and enable the puppetserver service "systemctl start puppetserver" and "systemctl enable puppetserver"
- Configure the puppetserver's agent by adding an agent section underneath the master section inside the "/etc/puppetlabs/puppet/puppet.conf" file and setting the server to your machine's hostname. 'master.puppet.vm' in my Vagrant file's case:
>        [server]
>        ...
>        
>        [agent]
>        server = master.puppet.vm
- Install ruby and gem, this can be done by either installing them using the yum and repos or simply adding the already installed puppetserver's binary path to machine's environment to use the built-in ruby and gem from the puppetserver installation. To achieve the second approach, you can add "/opt/puppetlabs/puppet/bin" to the PATH by inserting a second PATH entry to the bash profile file. Change the content of the .bash_profile by executing "vi /root/.bash_profile" and add the following:
>        ...
>        PATH=$PATH:/opt/puppetlabs/puppet/bin \#THIS ONE WILL BE ADDED
>        PATH=$PATH:$HOME/bin
>        ...

run "exec bash" to start a new bash session and load the new bash profile by executing "source /root/.bash_profile". You can make sure it worked by checking "ruby -v" and "gem -v".
- Install r10k by executing "gem install r10k" command for deploying the source code.
- To bind this control repo to the puppetserver on the VM, we'll create a new directory "mkdir /etc/puppetlabs/r10k" and add a .yaml file for configuration of r10k "vi /etc/puppetlabs/r10k/r10k.yaml" with the contents:
>        ---
>        \# The location to use for storing cached Git repos
>        :cachedir: '/var/cache/r10k'
>        
>        \# A list of git repositories to create
>        :sources:
>          \# This will clone the git repository and instantiate an environment per
>          \# branch in /etc/puppetlabs/code/environments
>          :my-org:
>            remote: 'https://github.com/mertdundar/control_repo.git'
>            basedir: '/etc/puppetlabs/code/environments'
- Starting from now on, git repo that is bound in the yaml config file can be deployed using "r10k deploy environment -p" whenever any changes have been made in the source code.
- You can find the branch and its contents under '/etc/puppetlabs/code/environments' to see if deployment was successful.
- Once the deployment in complete puppetserver can be executed using "puppet agent -t" for changes to be effective on the master server and have the docker containers ready to be tested.

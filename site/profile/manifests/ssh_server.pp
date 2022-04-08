class profile::ssh_server {
	package {'openssh-server':
		ensure => present,
	}
	service { 'sshd':
		ensure => 'running',
		enable => 'true',
	}
	ssh_authorized_key { 'root@master.puppet.vm':
		ensure => present,
		user   => 'root',
		type   => 'ssh-rsa',
		key    => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDOXhPosSj8dXagi2YSAKgH2AcfFiVqSYaaLC8qCwU0To2ettttjOi5eenmAMW80nfkZUrp0LMEyPnfeuL4PdWL/j0mSPLBqQbf4gFgjUGIKtliAmMtTca9Pzn/WK9haOQmikHFaDBkcdJX9o5G8M+lq8SGWIIuR7y1heoKMHQDk+2hsE3uxbXqGqXQihMUErDJRmiSlJIzMECY3FCxnaxluz5kzZen1XM023/7xXjWlPPRwshwlda0BUum5+CFl/kX1NfN4rTHUiytrS9X2XVb+UAxUbNK/mfcsKatCkUGPxXOV7hK3LxxVxZB4yG+mDO/4lTCvc1TwPb9ViABLUfH',
	}  
}

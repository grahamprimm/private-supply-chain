clean:
	terraform -chdir=tf/ destroy -input=false -auto-approve -var="vsphere_password=$(VCENTER_PASSWORD)" -var="vsphere_user=$(VCENTER_USER)"
install:
	terraform -chdir=tf/ init
	terraform -chdir=tf/ workspace select ${WORKSPACE} || terraform -chdir=tf/ workspace new ${WORKSPACE}
	terraform -chdir=tf/ apply -input=false -auto-approve -var="vsphere_password=$(VCENTER_PASSWORD)" -var="vsphere_user=$(VCENTER_USER)"
all:
	clean
	install
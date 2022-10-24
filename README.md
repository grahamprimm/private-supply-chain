# big-bang

The start of all services for your local airgap.

The Big Bang in this case will intialize and control the kubernetes clusters, container registries, and RHEL or Debian repositories.

It is mostly the same across every enclave with slight differences shown the 3 different branches.

## Components

- RHEL8 Hardened and STIGed
- Terraform (Declare)
- Ansible (Impair)
- Podman (Container Registry)
- Nginx (Reverse Proxy)
- SmallStep (TLS)

## Steps

1. Create Root CA
2. Create container registry
3. Create rhel8 repository
4. Deploy RKEv2 for gitlab and dev environment
5. Deploy another RKEv2 for services using gitlab cluster
6. PROFIT



## Dependicies

ansible-galaxy collection install ansible.posix

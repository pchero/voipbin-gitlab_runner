# voipbin-gitlab_runner
Basic gitlab-runner for voipbin.

It included below items.
* GCP SDK
* Ansible
* Terraform
* Golang
* Git
* Python3
* GCC
* Kustomize
* alembic(https://alembic.sqlalchemy.org/en/latest/)

# deploy
* docker build -t voipbin/gitlab-runner:release-20211004 .
* docker build -t voipbin/gitlab-runner:latest .
* docker push voipbin/gitlab-runner:release-20211004
* docker push voipbin/gitlab-runner:latest

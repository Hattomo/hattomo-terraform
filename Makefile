.DEFAULT_GOAL := apply

fmt:
	terraform fmt -recursive
.PHONY: fmt

validate: fmt
	terraform validate
.PHONY: validate

plan: validate
	terraform plan
.PHONY: plan

apply: plan
	terraform apply -auto-approve
.PHONY: apply

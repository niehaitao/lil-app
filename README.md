# lil-app

`lil-app` is a simple application for demonstrating the
**[dev](./dev/readme.md) » [ci (docker-image)](#ci-docker-image) » [ci (helm-chart)](#ci-helm-chart) » [manual install](#manual-install) » [cd (gitops-flux)](#cd-gitops-flux)**
process of DevOps

## CI docker-image

To build docker-image `docker.io/haitaonie/lil-app:1.0.1`

- [github-action build](https://github.com/niehaitao/lil-app/actions/workflows/CI.DockerImage.yaml)
- [github-action source](.github/workflows/CI.DockerImage.yaml)

## CI helm-chart

To build helm chart `niehaitao.github.io/helm-charts/lil-app-0.0.1`

- [github-action build](https://github.com/niehaitao/lil-app/actions/workflows/CI.HelmChart.yaml)
- [github-action source](.github/workflows/CI.HelmChart.yaml)

## Manual Install

```bash
helm repo add     niehaitao https://niehaitao.github.io/helm-charts
helm repo update
helm show values  niehaitao/lil-app

jinja2 \
  ops/lil-app.values.yaml.j2        \
  .secret/lil-app.values.yaml | tee \
  .target/lil-app.values.yaml

helm upgrade -i lil-app niehaitao/lil-app -f .target/lil-app.values.yaml
```

## CD GitOps Flux

[ops/helm-release-flux](ops/helm-release-flux)

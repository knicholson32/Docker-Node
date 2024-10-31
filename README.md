[![GitHub Workflow Status (with event)](https://img.shields.io/github/actions/workflow/status/knicholson32/docker-node-template/docker-build.yml)](https://github.com/knicholson32/docker-node-template/actions)
[![Docker Image Size with architecture (latest by date/latest semver)](https://img.shields.io/docker/image-size/keenanrnicholson/docker-node-template)](https://hub.docker.com/r/keenanrnicholson/docker-node-template/tags)
[![Docker Pulls](https://img.shields.io/docker/pulls/keenanrnicholson/docker-node-template)](https://hub.docker.com/r/keenanrnicholson/docker-node-template/tags)

# Introduction
This is a template repository for a Docker container that can run NodeJS, developed with typescript and hot-reloading in a development container.

## Features

- Typescript support
- Development in a docker-container with code hot-reloading
- GitHub actions set to push to `Dockerhub` and `ghcr.io`
- Multiple platforms (`linux/amd64` and `linux/arm64`) by default

# Repo Configuration

The following variables need to be set in the GitHub repo: `Settings → Secrets and variables → Actions`

Name | Type | Description
------------- | ------------- | -----------
`DOCKERHUB_OWNER_TOKEN` | Repository Secret | The password for Dockerhub (repo owner account). Used to update the Dockerhub readme.
`DOCKERHUB_OWNER_USERNAME` | Repository Secret | The username for Dockerhub (repo owner account). Used to update the Dockerhub readme.
`DOCKERHUB_TOKEN` | Repository Secret | A Dockerhub user personal access token for an account with write permissions. Used to push images to Dockerhub.
`DOCKERHUB_USERNAME` | Repository Secret | A Dockerhub username for an account with write permissions. Used to push images to Dockerhub.
`CR_PAT` | Repository Secret | A GitHub Personal Access Token (classic) for the GitHub repo owner. [More Info.](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry#authenticating-with-a-personal-access-token-classic) Used to push images to `ghcr.io`.
`CACHE_REGISTRY_IMAGE` | Repository Variable | Target container repo that cache should be stored to.
`REGISTRY_IMAGE_DOCKER` | Repository Variable | The Dockerhub repo that this project should be pushed to. (`my-repo/my-project`)
`REGISTRY_IMAGE_GHCR` | Repository Variable | The GitHub repo that this project should be pushed to. (`ghcr.io/my-repo/my-project`)


# Development

## Source Code
By default, source code should be located in `/src`, however this can be changed as required by editing the build commands in `package.json`.

The project is bundled and minified by default, with source-maps generated alongside a monolithic export file. `Dev dependencies` are bundled with the export file (as long as they are not removed by `esbuild` via tree-shaking), and `Dependencies` are included in `node_modules` for the production image.

`pnpm` is the default package manager.

## Environment
Development for projects from this template is done inside a developmental Docker image.

Create the dev image and start a local development session:

```shell
# Start dev environment
make dev
```

Create the Docker image and serve it locally:

```shell
# Build the full image and host it locally
make create-local && make local
```

## `node_modules`

During development, a `node_modules` folder is created in the top-level directory. Note that the libraries within are not necessarily compatible with your local machine, as they were installed within the Docker container environment. This means that if `npm i` is ran outside the Docker container, the incorrect libraries will be loaded by the dev environment. If issues are encountered with respect to dependencies, delete the `node_modules` folder and try again to allow the container environment to install the correct libraries.

# `ghcr.io`
You may have to manually push to `ghcr.io` first before this template will auto-update packages:
```bash
docker build --file ./docker/Dockerfile --push -t ghcr.io/knicholson32/docker-node-template:main .
```
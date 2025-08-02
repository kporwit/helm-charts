# helm-charts
Repository for Helm Charts with GH pages for hosting.

## Charts publishing
To create new chart run the commands:
`helm package <chart-name>`
`mv <chart-name>-<chart-version>.tgz docs/`
`helm repo index docs --url https://github.com/kporwit/helm-charts`
After commiting the changes chart should be available through:
`helm repo add <repo-name> https://github.com/kporwit/helm-charts`

## TODO
- automate chart publishing

{{/*
Expand the name of the chart.
*/}}
{{- define "spring-boot-api.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "spring-boot-api.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "spring-boot-api.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "spring-boot-api.labels" -}}
helm.sh/chart: {{ include "spring-boot-api.chart" . }}
{{ include "spring-boot-api.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "spring-boot-api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "spring-boot-api.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/project: "spring"
app.kubernetes.io/environment: {{ .Values.environment }}
{{- end }}

{{/*
Checksum annotations
*/}}
{{- define "spring-boot-api.checksumAnnotations" -}}
app.kubernetes.io/checksum-config: {{ include (print $.Template.BasePath "/configmap.yaml") . | sha256sum }}
app.kubernetes.io/checksum-secret: {{ include (print $.Template.BasePath "/secret.yaml") . | sha256sum }}
{{- end }}
{{/*
Create the name of the service account to use
*/}}
{{- define "spring-boot-api.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "spring-boot-api.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

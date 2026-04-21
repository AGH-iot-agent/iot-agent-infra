#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CHART_PATH="$ROOT_DIR/Universal-Kubernetes-Helm-Charts/charts/deployment"
NAMESPACE="${NAMESPACE:-iotag-dev}"
IMAGE_REPOSITORY_PREFIX="${IMAGE_REPOSITORY_PREFIX:-}"
IMAGE_TAG="${IMAGE_TAG:-}"

SERVICES=(
  iot-agent-mqtt-broker
  iot-agent-authentication
  iot-agent-gateway-api
  iot-agent-alert-api
  iot-agent-device-api
  iot-agent-dashboard-api
  iot-agent-logs
  iot-agent-stream-worker
  iot-agent-sim-devices
  iot-agent-login-screen
  iot-agent-dashboard-ui
)

for service in "${SERVICES[@]}"; do
  values_file="$ROOT_DIR/$service/Helm/values-dev.yaml"
  cmd=(helm upgrade --install "$service" "$CHART_PATH" -f "$values_file" -n "$NAMESPACE")

  if [[ -n "$IMAGE_REPOSITORY_PREFIX" ]]; then
    cmd+=(--set "image.repository=$IMAGE_REPOSITORY_PREFIX/$service")
  fi

  if [[ -n "$IMAGE_TAG" ]]; then
    cmd+=(--set "image.tag=$IMAGE_TAG")
  fi

  echo "Deploying $service to $NAMESPACE"
  "${cmd[@]}"
done
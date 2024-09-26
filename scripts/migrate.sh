#!/usr/bin/env bash

set -eou pipefail

from="$1"
to="$2"

backups="$(kubectl get backup --context "${to}" -n velero -o json | jq -r '.items[].metadata.name')"

count="$(echo "${backups}" | wc -l)"

backup_name="m0001"

if [ "$count" -gt 0 ]; then
  latest="$(echo "${backups}" | sort | tail -n 1)"
  echo "✨ Latest: ${latest}"
  current=${latest//[!0-9]/}
  echo "🔢 Current: ${current}"
  incremented=$((10#$current + 1))
  echo "🔢 Incremented: ${incremented}"
  backup_name=$(printf "m%04d" $incremented)
  echo "🔢 Backup name: ${backup_name}"
fi

velero --kubecontext "${from}" backup create --include-namespaces "sulfoxide-helium,sulfoxide-boron" "${backup_name}" -w

until velero --kubecontext "${to}" backup get "${backup_name}"; do
  sleep 0.5
done

velero --kubecontext "${to}" restore create --from-backup "${backup_name}"

#!/usr/bin/env bash

set -eou pipefail

from="$1"
to="$2"
backup_name="$3"

velero --kubecontext "${from}" backup create --include-namespaces "sulfoxide-helium,sulfoxide-boron" "${backup_name}" -w

until velero --kubecontext "${to}" backup get "${backup_name}"; do
  sleep 0.5
done

velero --kubecontext "${to}" restore create --from-backup "${backup_name}"

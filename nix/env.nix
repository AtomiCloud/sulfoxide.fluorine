{ pkgs, packages }:
with packages;
{
  system = [
    coreutils
    sd
    bash
    jq
    yq-go
  ];

  dev = [
    pls
    git
  ];

  infra = [
    k3d
    helm
    kubectl
  ];

  main = [
    velero
    doppler
  ];

  lint = [
    # core
    treefmt

    helm-docs

    gitlint
    shellcheck
  ];

  releaser = [
    sg
  ];
}

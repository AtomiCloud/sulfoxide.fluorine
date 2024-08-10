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
    gomplate
  ];

  infra = [
    k3d
    helm
    kubectl
  ];

  main = [
    velero
    infisical
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

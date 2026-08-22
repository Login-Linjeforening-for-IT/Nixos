{...}: {
  # Single-node k3s cluster.

  services.k3s = {
    enable = true;
    role = "server";

    clusterInit = true;

    disable = [
      # OpenResty on dev is the edge and terminates TLS. A second ingress (for now)
      "traefik"
    ];

    extraFlags = [
      "--etcd-s3"
      "--etcd-s3-config-secret=k3s-etcd-s3"
      "--etcd-snapshot-schedule-cron=0 */6 * * *"
      "--etcd-snapshot-retention=20"
      "--etcd-snapshot-compress"
    ];
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      6443 # Kubernetes API
    ];
    # NodePort range, so OpenResty on dev can reach services in the cluster.
    allowedTCPPortRanges = [
      {
        from = 30000;
        to = 32767;
      }
    ];
  };
}

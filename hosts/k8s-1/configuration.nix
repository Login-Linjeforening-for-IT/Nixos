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

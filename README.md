<div align="center">

<img src="https://s3.login.no/beehive/img/logo/logo-white-small.svg" alt="Login logo" width="80" height="80" />

<h1>NixOS</h1>

<p>
  <img src="https://img.shields.io/badge/NixOS-fd8738?style=flat-square&logo=nixos&logoColor=white" alt="NixOS" />
</p>

</div>

---

NixOS machine configurations for Login. Each host is declared as a Nix flake and deployed via CI pipelines.

## Adding a New Machine

1. Add a new folder under `hosts/`. The folder name becomes the hostname.
2. Create `configuration.nix` inside the folder.
3. Push to main.
4. Run the install pipeline with the IP of the new VM and the configuration name.

The VM should be created from the `nixos-26.05` ISO with the QEMU guest agent enabled.

## Updating a Machine

1. Push changes to main.
2. Run the update pipeline with the target machine and configuration name.

## Updating the Base ISO

```bash
nixos-rebuild build-image --image-variant iso --flake iso/#iso
```

## Project Structure

- `hosts/` - Per-machine configurations
- `common.nix` - Shared configuration applied to all machines
- `flake.nix` - Flake definition, maps each host directory to a NixOS configuration
- `disk-config.nix` - Disko disk layout
- `iso/` - Custom ISO configuration

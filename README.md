# nixos-vagrant-kit

A simple starter kit to start playing with NixOS on Vagrant.

## Vagrant Box
NixOS images on Vagrant Cloud are very out-dated and the current version of [nixbox](https://github.com/nix-community/nixbox) is currently broken (https://github.com/nix-community/nixbox/pull/53). 
Instead of building your own box you can also trust a random stranger who published a current version: https://app.vagrantup.com/stefandeml/boxes/nixos-19.09-x86_64/


## Requirements

The following tools need to be installed:
* VirtualBox
* Vagrant

## How-Tos

### Start a NixOS environment

First install the Nixos Plugin for Vagrant:
`vagrant plugin install vagrant-nixos-plugin` 

then clone this repo and run:
* Boot the image: `vagrant up`
* Ssh into the box: `vagrant ssh`

You notice that the folder `./shared` on the host is synced with `/vagrant` on the guest system.

### Start first nix-shell

We can now start our first nix shell. 
For this we describe our nix shell configuration on the host: Create `shell.nix` in `./shared` with the following configuration:
```nix
# This imports the nix package collection,
# so we can access the `pkgs` and `stdenv` variables
with import <nixpkgs> {};

# Make a new "derivation" that represents our shell
stdenv.mkDerivation {
  name = "my-environment";

  # The packages in the `buildInputs` list will be added to the PATH in our shell
  buildInputs = [
    # cowsay is an arbitary package
    # see https://nixos.org/nixos/packages.html to search for more
    pkgs.htop pkgs.cmake
  ];
}
```

On the virtual NixOS machine we can now enter this nix shell with:
* change to the shared directory: `cd /vagrant`
* instantiate the nix shell: `nix-shell`

We are now working in the nix environment described by `shell.nix`. Consequently, we have access to:
`htop`
or `cmake --version`

Use `exit` to leave that environment.

### Make changes on the NixOS configuration

We can simply apply changes to descriptive configuration of NixOS running. Just make changes to the `configuration.nix` in the `./config` folder and the run `vagrant provision` to update the running virtual machine.


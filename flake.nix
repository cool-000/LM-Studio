{
  description = "LM Studio";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      packages.${system} = {
        default = pkgs.callPackage ./lmstudio.nix {};
        lmstudio = self.packages.${system}.default;
      };

      overlays.default = final: prev: {
        lmstudio = final.callPackage ./lmstudio.nix {};
      };
    };
}

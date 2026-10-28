{
  description = "Dev shell for the cc-edge macOS Unified Logs pack — delegates to nix-devenv's typescript subflake.";

  # Pin to the typescript SUBFLAKE (?dir=shells/typescript), not the root
  # nix-devenv flake. The root flake imports cachix/devenv to support its
  # Python/AI shells, which drags in a large transitive tree. The typescript
  # subflake has one input — nixpkgs — and the `follows` declaration makes it
  # share our root nixpkgs.
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-25.11-darwin";
    nix-devenv = {
      url = "github:JacobPEvans/nix-devenv?dir=shells/typescript";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nix-devenv,
      ...
    }:
    let
      systems = [
        "aarch64-darwin"
        "x86_64-darwin"
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      # Hook and lint tools come from nixpkgs; nothing is installed from the
      # npm registry. The typescript shell supplies biome.
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            inputsFrom = [ nix-devenv.devShells.${system}.default ];
            packages = with pkgs; [
              lefthook
              yq-go
              jq
              markdownlint-cli2
            ];
          };
        }
      );
    };
}

{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
    depot-js.url = "github:cognitive-engineering-lab/depot";
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay, depot-js }:
  flake-utils.lib.eachDefaultSystem (system:
  let
    overlays = [ (import rust-overlay) ];
    pkgs = import nixpkgs {
      inherit system overlays;
    };
  in {
    devShell = with pkgs; mkShell {
      buildInputs = [
        depot-js.packages.${system}.default
        nodejs_22
        nodePackages.pnpm
				elmPackages.elm
      ] ++ lib.optionals stdenv.isDarwin [
        darwin.apple_sdk.frameworks.SystemConfiguration
      ];
    };
  });
}

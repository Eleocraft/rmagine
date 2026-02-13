{
  description = "C/C++ development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
  flake-utils.lib.eachDefaultSystem (system:
    let
			pkgs = import nixpkgs { inherit system; };
    in {
      devShells.default = pkgs.mkShell.override { inherit (pkgs.llvmPackages_latest) stdenv; } {
				nativeBuildInputs = with pkgs.buildPackages; [ 
					cmake
          embree
          boost
          eigen
          assimp
          pkgs.llvmPackages_latest.openmp
          onetbb
          jsoncpp
          pkg-config
					clang-tools
				];
      };
    }
	);
}


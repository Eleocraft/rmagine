{
  description = "C/C++ development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
  flake-utils.lib.eachDefaultSystem (system:
    let
			pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      devShells.default = pkgs.mkShell.override { inherit (pkgs.llvmPackages_latest) stdenv; } {
				nativeBuildInputs = with pkgs.buildPackages; [ 
					cmake
          ninja

          # cpu
          embree
          
          # GPU
          glslang
          vulkan-tools
          vulkan-headers
          vulkan-validation-layers
          vulkan-volk
          vulkan-loader
          cudaPackages.cudatoolkit
          
          boost
          eigen
          assimp
          pkgs.llvmPackages_latest.openmp
          onetbb
          jsoncpp
          pkg-config
					clang-tools
          linuxPackages_zen.nvidiaPackages.latest
				];
        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (with pkgs; [
          linuxPackages_zen.nvidiaPackages.latest
        ]);
      };
    }
	);
}


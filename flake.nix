{
	description = "compressonator";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

		flake-parts = {
			url = "github:hercules-ci/flake-parts";
			inputs.nixpkgs-lib.follows = "nixpkgs";
		};
	};

	outputs =
		inputs:
		inputs.flake-parts.lib.mkFlake { inherit inputs; } {
			systems = [
				"x86_64-linux"
				"aarch64-linux"
				"x86_64-darwin"
				"aarch64-darwin"
			];

			perSystem = { config, pkgs, ... }: {
				# For customized Nixpkgs config or overlays, override
				# `_module.args.pkgs` with a freshly imported Nixpkgs instance.

				packages.default = pkgs.callPackage ./nix/package.nix { };

				devShells.default = pkgs.mkShell {
					inputsFrom = [
						config.packages.default
					];

					packages = with pkgs; [
						clang-tools
					];
				};
			};
		};
}

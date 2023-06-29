{
  description = "Flake for convenient nix packages";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = {self, nixpkgs } :
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        # config.allowUnfree = true;
      };
      
    in {
      devShell.${system} = pkgs.mkShell {
        
        nativeBuildInputs = [ pkgs.bashInteractive ];
        buildInputs = with pkgs; [ 
          (python311.withPackages(ps: with ps; [ 
            fonttools
            ttfautohint
            skia-pathops
            pyyaml
          ]))
          # add more packages (https://search.nixos.org)
        ];

      };
    };
}

{
  description = "A Rust Dev Shell";

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
          "vscode-with-extensions"
          "vscode"
          "vscode-extension-mhutchie-git-graph"
        ];
      };
    };
  in 
  {
    # You can excute this command with "nix "
    packages.${system} = {
      default = pkgs.writeShellScriptBin "run" ''
        nix develop -c -- codium .
      '';
    };
    

    devShells.${system}.default =
      pkgs.mkShell rec {
        name = "RustDevShell";
        buildInputs = with pkgs; [
          cargo
          rustc
          bashInteractive
          (vscode-with-extensions.override  {
            vscode = pkgs.vscodium;
            vscodeExtensions = with pkgs.vscode-extensions; [
              rust-lang.rust-analyzer
              jnoortheen.nix-ide
              mhutchie.git-graph
              vscodevim.vim
            ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
              # {
              #   name = "vscode-edit-csv";
              #   publisher = "janisdd";
              #   version = "0.8.2";
              #   sha256 = "sha256-DbAGQnizAzvpITtPwG4BHflUwBUrmOWCO7hRDOr/YWQ=";
              # }
            ];
          })

        ];

        shellHook = ''
          export PS1+="${name}> "
          echo "Welcome to the Rust Dev Shell"
        '';
      };
  }; 

}


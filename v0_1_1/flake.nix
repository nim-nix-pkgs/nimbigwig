{
  description = ''libBigWig wrapper for Nim'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-nimbigwig-v0_1_1.flake = false;
  inputs.src-nimbigwig-v0_1_1.owner = "genotrance";
  inputs.src-nimbigwig-v0_1_1.ref   = "refs/tags/v0.1.1";
  inputs.src-nimbigwig-v0_1_1.repo  = "nimbigwig";
  inputs.src-nimbigwig-v0_1_1.type  = "github";
  
  inputs."nimgen".dir   = "nimpkgs/n/nimgen";
  inputs."nimgen".owner = "riinr";
  inputs."nimgen".ref   = "flake-pinning";
  inputs."nimgen".repo  = "flake-nimble";
  inputs."nimgen".type  = "github";
  inputs."nimgen".inputs.nixpkgs.follows = "nixpkgs";
  inputs."nimgen".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-nimbigwig-v0_1_1"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-nimbigwig-v0_1_1";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}
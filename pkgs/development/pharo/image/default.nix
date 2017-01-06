{ stdenv, fetchurl, unzip, runCommand, pharo-vm5 }:

with stdenv;

rec {
  pharo-50-image = mkDerivation rec {
    name = "pharo-image-5.0";

    buildInputs = [ unzip ];

    src = fetchurl {
	name = "pharo-image-5.0-50765.zip";
	url = "http://files.pharo.org/image/50/50765.zip";
	sha256 = "00hkxcj5kcdbp5kxk2b94bk811w1g2z620xq744gx7msh3kvlacc";
    };

    unpackPhase = ''
      unzip $src
    '';

    installPhase = ''
      mkdir -p $out
      cp *.image *.changes $out/
      ln -s $out/*.image $out/Pharo.image
      ln -s $out/*.changes $out/Pharo.changes
    '';
  };

  test = runCommand "test" { buildInputs = [ pharo-vm5 ]; } ''
    pharo-nox
  '';
}


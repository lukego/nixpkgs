{stdenv, fetchgit}:

stdenv.mkDerivation rec {
  name = "snabb-v2015.10";

  src = fetchgit {
    url = "git://github.com/SnabbCo/snabbswitch";
    rev = "20532eff595fef4bf1575d70e7963060a91add45";
    sha256 = "1hp0g9h7l6ps411w5vdlljcbr2ils932ndm4i5yla2ay8lhbbjxj";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp src/snabb $out/bin
  '';

meta = with stdenv.lib; {
    homepage = "https://github.com/SnabbCo/snabbswitch";
    description = "Snabb Switch: simple and fast packet networking toolkit";
    platforms = [ "x86_64-linux" ];
    license = licenses.asl20;
    maintainers = maintainers.lukego;
  };
}


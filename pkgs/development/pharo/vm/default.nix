{ stdenv, callPackage, callPackage_i686, ...} @pkgs:

let
  vms_x86  = callPackage_i686 ./vms.nix {};
  vms_x64  = callPackage ./vms.nix {};
  cogvm = vms_x86.cog;
  spurvm = vms_x86.spur;
  spur64vm = if stdenv.is64bit then vms_x64.spur else "none";
  multi-vm-wrapper  = callPackage ../wrapper { inherit cogvm spurvm spur64vm; };
in

# Return the wrapper that automatically runs the right VM for an image.
multi-vm-wrapper


task :build => 'Dockerfile' do
  sh "docker build -t chocolate ."
end

task :run => 'EFI/BOOT/BOOTX64.EFI' do
  sh "qemu-system-x86_64 -bios /usr/share/ovmf/OVMF.fd -hda fat:rw:fs"
end

task :cleanup do
  sh "docker rm chocolate-build"
end

directory 'fs/EFI/BOOT'
file 'EFI/BOOT/BOOTX64.EFI' => %w(main.c fs/EFI/BOOT) do
  sh "docker run --name chocolate-build chocolate"
  sh "sudo docker cp chocolate-build:/usr/local/efi/main.efi fs/EFI/BOOT/BOOTX64.EFI"
  sh "docker rm chocolate-build"
end

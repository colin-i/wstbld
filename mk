
if [ -z "${linkerflags}" ]; then linkerflags="-O3 -s"; fi
p=wstbld
if [ -z "${1}" ]; then
	if [ -z "${LD}" ]; then
		LD=ld
	else
		echo ld=${LD}
	fi
	if [ -z "${m32}" ]; then
		echo 64bit
		o wsb.oc underscore_pref 1 include_sec 1 ${OFLAGS} ${OFLAGSEXTRA} && \
		ounused wsb.oc.log && \
		${LD} ${linkerflags} wsb.o -entry main --dynamic-linker=/lib64/ld-linux-x86-64.so.2 --build-id -o ${p} -l:libc.so.6  #--build-id for rpm
	else
		o wsb.oc underscore_pref 1 include_sec 1 conv_64 1 ${OFLAGS} ${OFLAGSEXTRA} && \
		ounused wsb.oc.log && \
		#objcopy --redefine-sym _main=main wsb.o  #this will mess and can't use with inplace_reloc false either
		${LD} ${linkerflags} -m elf_i386 wsb.o -entry main --dynamic-linker=/lib/ld-linux.so.2 -o ${p} -lc
	fi
else
	if [ -z "${m32}" ]; then
		o wsb.oc underscore_pref 1 inplace_reloc 0 conv_64 2 && \
		ounused wsb.oc.log && \
		x86_64-w64-mingw32-gcc-win32 ${linkerflags} wsb.o -o ${p}.exe
	else
		o wsb.oc inplace_reloc 0 conv_64 1 && \
		ounused wsb.oc.log && \
		i686-w64-mingw32-gcc-win32 ${linkerflags} wsb.o -o ${p}.exe  #this is not working without uncommenting at win.oc
	fi
fi


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
		echo 32bit
		o wsb.oc underscore_pref 1 include_sec 1 conv_64 1 ${OFLAGS} ${OFLAGSEXTRA} && \
		ounused wsb.oc.log && \
		#objcopy --redefine-sym _main=main wsb.o  #this will mess and can't use with inplace_reloc false either
		${LD} ${linkerflags} -m elf_i386 wsb.o -entry main --dynamic-linker=/lib/ld-linux.so.2 -o ${p} -lc
	fi
else
	if [ -z "${CC}" ]; then
		CC=gcc
	else
		echo cc=${CC}
	fi
	if [ -z "${m32}" ]; then
		${mount}o${ext} wsb.oc underscore_pref 1 inplace_reloc 0 ${OFLAGS} && \
		${mount}ounused${ext} wsb.oc.log && \
		${CC} ${linkerflags} wsb.o -o ${p}.exe
		# x86_64-w64-mingw32-gcc-win32
	else
		${mount}o${ext} wsb.oc inplace_reloc 0 conv_64 1 && \
		${mount}ounused${ext} wsb.oc.log && \
		${CC} ${linkerflags} wsb.o -o ${p}.exe  #this is not working without uncommenting at win.oc
		# i686-w64-mingw32-gcc-win32
	fi
fi

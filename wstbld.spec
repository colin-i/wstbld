
%global _debugsource_template %{nil}

Name: wstbld
Version: 1.2
Release: 0
License: GPLv3
Summary: web site builder
Url: https://github.com/colin-i/wstbld
Source0: %{name}-%{version}.tar.gz
BuildRequires: ocompiler make binutils

%description
command line web site packer with templates

#-- PREP, BUILD & INSTALL -----------------------------------------------------#
%prep
%autosetup

%build
linkerflags="-O3 -g" make  # -g here is important if wanting to have debuginfo package

%install
%make_install

#-- FILES ---------------------------------------------------------------------#
%files
%attr(0755, root, root) "%{_bindir}/wstbld"

#-- CHANGELOG -----------------------------------------------------------------#
%changelog
* Sun Jul 06 2025 Costin Botescu <costin.botescu@gmail.com> 1.2-0
- wstbld (costin.botescu@gmail.com)
- pkg ocompiler (costin.botescu@gmail.com)
- pkg (costin.botescu@gmail.com)
- suse (costin.botescu@gmail.com)

* Sun Jun 29 2025 Costin Botescu <costin.botescu@gmail.com> 1.1-1
- make passed LD

* Sun Jun 29 2025 Costin Botescu <costin.botescu@gmail.com> 1.1-0
- new package built with tito


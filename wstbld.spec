
%global _debugsource_template %{nil}

Name: wstbld
Version: 1
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

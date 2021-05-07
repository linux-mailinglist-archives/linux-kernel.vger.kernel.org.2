Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C17F3769B1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 19:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhEGRvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 13:51:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhEGRvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 13:51:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8CE0061431;
        Fri,  7 May 2021 17:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620409852;
        bh=T8eq30Nf5JU26kRG89p6iI+ercNWcIiKIHUHbwX6fOo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZMnagMd0OSmjoQX1n80N7F8NhFkuDKPBwFF5A0FQAvR1ZE+9hbXkBCXWxZPHRDKLe
         vI3pH34h0PC+RtiYADpfBghLsV55bEiG0HX2a36KJ1Bg7jjqu1W+lirPr+jwLGy/4Z
         gRKRigGn+tses1+iscODqgJVegXoYUnpzNDEqbnx3TC9HW1DIwO/JoM2p9VxwXD761
         HSwl9B/0HKmQPXSmGKkRVsFkBnWl1S3wnlD3TGJLxnjV1XfwaUEe5CVBsWn1I8B75t
         aCYpCbuZTU5uMn56gpw+Mk6sou0llYL133pddo3Fpo0uZpid6uRxkHtJCJpj8EkfJb
         RNtJPu/JFHxcQ==
Date:   Fri, 7 May 2021 12:50:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: drivers/pci/controller/dwc/pcie-tegra194.c:243:27: warning:
 unused variable 'pcie_gen_freq'
Message-ID: <20210507175051.GA1521138@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202105080046.TTuEQIwi-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 08, 2021 at 12:33:52AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   a48b0872e69428d3d02994dcfad3519f01def7fa
> commit: 7f100744749e4fe547dece3bb6557fae5f0a7252 PCI: tegra: Add Tegra194 MCFG quirks for ECAM errata
> date:   3 weeks ago
> config: arm64-randconfig-r013-20210507 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project a3a8a1a15b524d91b5308db68e9d293b34cd88dd)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7f100744749e4fe547dece3bb6557fae5f0a7252
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 7f100744749e4fe547dece3bb6557fae5f0a7252
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=arm64 

Thanks for the report!

Just FYI, I followed the instructions above and got this:

  12:32:35 ~/linux (kbuild)$ COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=arm64
  Compiler will be installed in /home/bjorn/0day
  cd: received redirection to `https://download.01.org/0day-ci/cross-package/'
  lftpget -c https://download.01.org/0day-ci/cross-package/./clang-latest/clang.tar.xz
  tar Jxf clang-latest/clang.tar.xz -C /home/bjorn/0day
  make CONFIG_OF_ALL_DTBS=y CONFIG_DTC=y HOSTCC=/home/bjorn/0day/clang-latest/bin/clang CC=/home/bjorn/0day/clang-latest/bin/clang LD=/home/bjorn/0day/clang-latest/bin/ld.lld HOSTLD=/home/bjorn/0day/clang-latest/bin/ld.lld AR=/home/bjorn/0day/clang-latest/bin/llvm-ar NM=/home/bjorn/0day/clang-latest/bin/llvm-nm STRIP=/home/bjorn/0day/clang-latest/bin/llvm-strip OBJDUMP=/home/bjorn/0day/clang-latest/bin/llvm-objdump OBJSIZE=/home/bjorn/0day/clang-latest/bin/llvm-size READELF=/home/bjorn/0day/clang-latest/bin/llvm-readelf HOSTCXX=/home/bjorn/0day/clang-latest/bin/clang++ HOSTAR=/home/bjorn/0day/clang-latest/bin/llvm-ar CROSS_COMPILE=aarch64-linux-gnu- --jobs=16 W=1 ARCH=arm64
  make: /home/bjorn/0day/clang-latest/bin/clang: Command not found
    SYNC    include/config/auto.conf.cmd
    HOSTCC  scripts/basic/fixdep
  /bin/sh: 1: /home/bjorn/0day/clang-latest/bin/clang: not found
  make[2]: *** [scripts/Makefile.host:95: scripts/basic/fixdep] Error 127
  make[1]: *** [Makefile:533: scripts_basic] Error 2
  make: *** [Makefile:709: include/config/auto.conf.cmd] Error 2
  make: *** [include/config/auto.conf.cmd] Deleting file 'include/generated/autoconf.h'

After adding a symlink "clang-latest -> clang/", it worked as
expected and reproduced the warning.

But I guess I'll wait for Vidya to fix it.

> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from drivers/pci/controller/dwc/pcie-tegra194.c:25:
>    In file included from include/linux/pci-acpi.h:12:
>    In file included from include/linux/acpi.h:35:
>    In file included from include/acpi/acpi_io.h:7:
>    In file included from arch/arm64/include/asm/acpi.h:12:
>    include/linux/efi.h:1093:34: warning: passing 1-byte aligned argument to 4-byte aligned parameter 2 of 'get_var' may result in an unaligned pointer access [-Walign-mismatch]
>            status = get_var(L"SecureBoot", &EFI_GLOBAL_VARIABLE_GUID, NULL, &size,
>                                            ^
>    include/linux/efi.h:1101:24: warning: passing 1-byte aligned argument to 4-byte aligned parameter 2 of 'get_var' may result in an unaligned pointer access [-Walign-mismatch]
>            get_var(L"SetupMode", &EFI_GLOBAL_VARIABLE_GUID, NULL, &size, &setupmode);
>                                  ^
> >> drivers/pci/controller/dwc/pcie-tegra194.c:243:27: warning: unused variable 'pcie_gen_freq' [-Wunused-const-variable]
>    static const unsigned int pcie_gen_freq[] = {
>                              ^
>    drivers/pci/controller/dwc/pcie-tegra194.c:250:18: warning: unused variable 'event_cntr_ctrl_offset' [-Wunused-const-variable]
>    static const u32 event_cntr_ctrl_offset[] = {
>                     ^
>    drivers/pci/controller/dwc/pcie-tegra194.c:259:18: warning: unused variable 'event_cntr_data_offset' [-Wunused-const-variable]
>    static const u32 event_cntr_data_offset[] = {
>                     ^
>    5 warnings generated.
> 
> 
> vim +/pcie_gen_freq +243 drivers/pci/controller/dwc/pcie-tegra194.c
> 
> c57247f940e8ea Vidya Sagar 2020-03-03  242  
> 56e15a238d9278 Vidya Sagar 2019-08-13 @243  static const unsigned int pcie_gen_freq[] = {
> 56e15a238d9278 Vidya Sagar 2019-08-13  244  	GEN1_CORE_CLK_FREQ,
> 56e15a238d9278 Vidya Sagar 2019-08-13  245  	GEN2_CORE_CLK_FREQ,
> 56e15a238d9278 Vidya Sagar 2019-08-13  246  	GEN3_CORE_CLK_FREQ,
> 56e15a238d9278 Vidya Sagar 2019-08-13  247  	GEN4_CORE_CLK_FREQ
> 56e15a238d9278 Vidya Sagar 2019-08-13  248  };
> 56e15a238d9278 Vidya Sagar 2019-08-13  249  
> 
> :::::: The code at line 243 was first introduced by commit
> :::::: 56e15a238d92788a2d09e0c5c26a5de1b3156931 PCI: tegra: Add Tegra194 PCIe support
> 
> :::::: TO: Vidya Sagar <vidyas@nvidia.com>
> :::::: CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



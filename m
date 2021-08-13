Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F483EB72B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 16:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240994AbhHMO6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 10:58:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:54535 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240198AbhHMO6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 10:58:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10075"; a="195841089"
X-IronPort-AV: E=Sophos;i="5.84,319,1620716400"; 
   d="scan'208";a="195841089"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 07:58:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,319,1620716400"; 
   d="scan'208";a="518185420"
Received: from pl-dbox.sh.intel.com (HELO pl-dbox) ([10.239.159.39])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Aug 2021 07:58:03 -0700
Date:   Fri, 13 Aug 2021 22:52:09 +0800
From:   Philip Li <philip.li@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: Error: kernelrelease not valid - run 'make prepare' to update it
Message-ID: <20210813145209.GA1514245@pl-dbox>
References: <202108111155.RvN9J3Hs-lkp@intel.com>
 <5ec75ad9-a861-4402-9c16-ae7cb0aaeaba@infradead.org>
 <CAK7LNATk21qWbgWORfmCLPD3Cieon-fwtuLtFhgOo1XORWJT6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNATk21qWbgWORfmCLPD3Cieon-fwtuLtFhgOo1XORWJT6g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 07:18:45PM +0900, Masahiro Yamada wrote:
> On Wed, Aug 11, 2021 at 12:19 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > On 8/10/21 8:16 PM, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   9e723c5380c6e14fb91a8b6950563d040674afdb
> > > commit: ba64beb17493a4bfec563100c86a462a15926f24 kbuild: check the minimum assembler version in Kconfig
> > > date:   4 months ago
> > > config: riscv-randconfig-r025-20210810 (attached as .config)
> > > compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d39ebdae674c8efc84ebe8dc32716ec353220530)
> > > reproduce (this is a W=1 build):
> > >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >          chmod +x ~/bin/make.cross
> > >          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ba64beb17493a4bfec563100c86a462a15926f24
> > >          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >          git fetch --no-tags linus master
> > >          git checkout ba64beb17493a4bfec563100c86a462a15926f24
> > >          # save the attached .config to linux build tree
> > >          mkdir build_dir
> > >          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross O=build_dir ARCH=riscv prepare
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > >>> Error: kernelrelease not valid - run 'make prepare' to update it
> > > --
> > >     clang --target=riscv64-linux-gnu -no-integrated-as --prefix=riscv64-linux-gnu- -Werror=unknown-warning-option: unknown assembler invoked
> > >     scripts/Kconfig.include:50: Sorry, this assembler is not supported.
> > >     make[3]: *** [scripts/kconfig/Makefile:63: syncconfig] Error 1
> > >     make[2]: *** [Makefile:617: syncconfig] Error 2
> > >     make[1]: *** [Makefile:726: include/config/auto.conf.cmd] Error 2
> > >     make[1]: Failed to remake makefile 'include/config/auto.conf.cmd'.
> > >     make[1]: Failed to remake makefile 'include/config/auto.conf'.
> > >>> Error: kernelrelease not valid - run 'make prepare' to update it
> > >     make[1]: Target 'prepare' not remade because of errors.
> > >     make: *** [Makefile:215: __sub-make] Error 2
> > >     make: Target 'prepare' not remade because of errors.
> >
> > Yes, I have noticed this one and a few other ('static') make targets that
> > should not need a .config file. I have a note to myself to ask about these,
> > so thanks for bringing it up.
> 
> 
> I think it is unrelated.
Sorry for the false report, which is a regression in our tool setup and
make.cross script.

> 
> 
> 
> The 0-day bot has already shown the real reason
> of the error:
Thanks for the detail analysis including below reproduce output, it's our fault
that we didn't notice the breakage of riscv. We will fix it soon.

> 
>    clang --target=riscv64-linux-gnu -no-integrated-as
> --prefix=riscv64-linux-gnu- -Werror=unknown-warning-option: unknown
> assembler invoked
>    scripts/Kconfig.include:50: Sorry, this assembler is not supported.
> 
> 
> 
> 
> This happens when the proper toolchains are not found.
> 
> That is, make.cross passed CROSS_COMPILE=riscv64-linux-gnu-
> to the make command line, but riscv64-linux-gnu binutils
> are not installed on the system.
> 
> 
> 
> Without installing binutils-riscv64-linux-gnu,
> I can see a similar error log.
> 
> 
> 
> 
> 
> masahiro@grover:~/ref/linux$ wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> -O ~/bin/make.cross
> --2021-08-13 18:57:01--
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> Resolving raw.githubusercontent.com (raw.githubusercontent.com)...
> 185.199.110.133, 185.199.109.133, 185.199.111.133, ...
> Connecting to raw.githubusercontent.com
> (raw.githubusercontent.com)|185.199.110.133|:443... connected.
> HTTP request sent, awaiting response... 200 OK
> Length: 9655 (9.4K) [text/plain]
> Saving to: ‘/home/masahiro/bin/make.cross’
> 
> /home/masahiro/bin/make.cross
> 100%[================================================================================================================================================================>]
>   9.43K  --.-KB/s    in 0s
> 
> 2021-08-13 18:57:01 (44.7 MB/s) - ‘/home/masahiro/bin/make.cross’
> saved [9655/9655]
> 
> masahiro@grover:~/ref/linux$ chmod +x ~/bin/make.cross
> masahiro@grover:~/ref/linux$ git checkout
> ba64beb17493a4bfec563100c86a462a15926f24
> HEAD is now at ba64beb17493 kbuild: check the minimum assembler
> version in Kconfig
> masahiro@grover:~/ref/linux$ rm -rf build_dir; mkdir build_dir
> masahiro@grover:~/ref/linux$ zcat  ~/Downloads/config.gz  > build_dir/.config
> masahiro@grover:~/ref/linux$ COMPILER_INSTALL_PATH=$HOME/0day
> COMPILER=clang make.cross O=build_dir ARCH=riscv prepare
> Compiler will be installed in /home/masahiro/0day
> make --keep-going CONFIG_OF_ALL_DTBS=y CONFIG_DTC=y
> HOSTCC=/home/masahiro/0day/clang/bin/clang
> CC=/home/masahiro/0day/clang/bin/clang
> LD=/home/masahiro/0day/clang/bin/ld.lld
> HOSTLD=/home/masahiro/0day/clang/bin/ld.lld AR=llvm-ar NM=llvm-nm
> STRIP=llvm-strip OBJDUMP=llvm-objdump OBJSIZE=llvm-size
> READELF=llvm-readelf HOSTCXX=clang++ HOSTAR=llvm-ar
> CROSS_COMPILE=riscv64-linux-gnu- --jobs=16 O=build_dir ARCH=riscv
> prepare
> make[1]: Entering directory '/home/masahiro/ref/linux/build_dir'
>   SYNC    include/config/auto.conf
>   GEN     Makefile
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/kconfig/conf.o
>   HOSTCC  scripts/kconfig/confdata.o
>   HOSTCC  scripts/kconfig/expr.o
>   LEX     scripts/kconfig/lexer.lex.c
>   YACC    scripts/kconfig/parser.tab.[ch]
>   HOSTCC  scripts/kconfig/preprocess.o
>   HOSTCC  scripts/kconfig/symbol.o
>   HOSTCC  scripts/kconfig/util.o
>   HOSTCC  scripts/kconfig/lexer.lex.o
>   HOSTCC  scripts/kconfig/parser.tab.o
>   HOSTLD  scripts/kconfig/conf
> /home/masahiro/0day/clang/bin/clang --target=riscv64-linux-gnu
> -no-integrated-as --prefix=riscv64-linux-gnu-
> -Werror=unknown-warning-option: unknown assembler invoked
> scripts/Kconfig.include:50: Sorry, this assembler is not supported.
> make[3]: *** [../scripts/kconfig/Makefile:63: syncconfig] Error 1
> make[2]: *** [../Makefile:617: syncconfig] Error 2
> make[1]: *** [/home/masahiro/ref/linux/Makefile:726:
> include/config/auto.conf] Error 2
> make[1]: Failed to remake makefile 'include/config/auto.conf'.
> make[1]: Failed to remake makefile 'include/config/auto.conf.cmd'.
>   GEN     Makefile
>   WRAP    arch/riscv/include/generated/uapi/asm/errno.h
>   WRAP    arch/riscv/include/generated/uapi/asm/fcntl.h
>   WRAP    arch/riscv/include/generated/uapi/asm/ioctl.h
>   WRAP    arch/riscv/include/generated/uapi/asm/ioctls.h
>   WRAP    arch/riscv/include/generated/uapi/asm/ipcbuf.h
>   WRAP    arch/riscv/include/generated/uapi/asm/mman.h
>   WRAP    arch/riscv/include/generated/uapi/asm/msgbuf.h
>   WRAP    arch/riscv/include/generated/uapi/asm/param.h
>   WRAP    arch/riscv/include/generated/uapi/asm/poll.h
>   WRAP    arch/riscv/include/generated/uapi/asm/posix_types.h
>   WRAP    arch/riscv/include/generated/uapi/asm/resource.h
>   WRAP    arch/riscv/include/generated/uapi/asm/sembuf.h
>   WRAP    arch/riscv/include/generated/uapi/asm/setup.h
>   WRAP    arch/riscv/include/generated/uapi/asm/shmbuf.h
>   WRAP    arch/riscv/include/generated/uapi/asm/siginfo.h
>   WRAP    arch/riscv/include/generated/uapi/asm/signal.h
>   WRAP    arch/riscv/include/generated/uapi/asm/socket.h
>   WRAP    arch/riscv/include/generated/uapi/asm/sockios.h
>   WRAP    arch/riscv/include/generated/uapi/asm/stat.h
>   WRAP    arch/riscv/include/generated/uapi/asm/statfs.h
>   WRAP    arch/riscv/include/generated/uapi/asm/swab.h
>   WRAP    arch/riscv/include/generated/uapi/asm/termbits.h
>   WRAP    arch/riscv/include/generated/uapi/asm/termios.h
>   WRAP    arch/riscv/include/generated/uapi/asm/types.h
> Error: kernelrelease not valid - run 'make prepare' to update it
>   UPD     include/config/kernel.release
>   HOSTCC  scripts/dtc/dtc.o
>   HOSTCC  scripts/dtc/flattree.o
>   HOSTCC  scripts/dtc/fstree.o
>   HOSTCC  scripts/dtc/data.o
>   HOSTCC  scripts/dtc/livetree.o
>   HOSTCC  scripts/dtc/treesource.o
>   HOSTCC  scripts/dtc/srcpos.o
>   HOSTCC  scripts/dtc/checks.o
>   HOSTCC  scripts/dtc/util.o
>   UPD     include/generated/uapi/linux/version.h
>   LEX     scripts/dtc/dtc-lexer.lex.c
>   YACC    scripts/dtc/dtc-parser.tab.[ch]
>   HOSTCC  scripts/dtc/yamltree.o
>   HOSTCC  scripts/dtc/libfdt/fdt.o
>   UPD     include/generated/utsrelease.h
>   HOSTCC  scripts/dtc/libfdt/fdt_ro.o
>   HOSTCC  scripts/dtc/libfdt/fdt_wip.o
>   HOSTCC  scripts/dtc/libfdt/fdt_sw.o
>   HOSTCC  scripts/dtc/libfdt/fdt_rw.o
>   WRAP    arch/riscv/include/generated/asm/early_ioremap.h
>   WRAP    arch/riscv/include/generated/asm/extable.h
>   WRAP    arch/riscv/include/generated/asm/flat.h
>   WRAP    arch/riscv/include/generated/asm/kvm_para.h
>   HOSTCC  scripts/dtc/libfdt/fdt_strerror.o
>   WRAP    arch/riscv/include/generated/asm/user.h
>   WRAP    arch/riscv/include/generated/asm/vmlinux.lds.h
>   WRAP    arch/riscv/include/generated/asm/bugs.h
>   WRAP    arch/riscv/include/generated/asm/checksum.h
>   WRAP    arch/riscv/include/generated/asm/compat.h
>   WRAP    arch/riscv/include/generated/asm/device.h
>   WRAP    arch/riscv/include/generated/asm/div64.h
>   WRAP    arch/riscv/include/generated/asm/dma-mapping.h
>   WRAP    arch/riscv/include/generated/asm/dma.h
>   WRAP    arch/riscv/include/generated/asm/emergency-restart.h
>   WRAP    arch/riscv/include/generated/asm/exec.h
>   WRAP    arch/riscv/include/generated/asm/fb.h
>   WRAP    arch/riscv/include/generated/asm/hardirq.h
>   WRAP    arch/riscv/include/generated/asm/hw_irq.h
>   WRAP    arch/riscv/include/generated/asm/irq_regs.h
>   WRAP    arch/riscv/include/generated/asm/kmap_size.h
>   WRAP    arch/riscv/include/generated/asm/local.h
>   WRAP    arch/riscv/include/generated/asm/local64.h
>   WRAP    arch/riscv/include/generated/asm/msi.h
>   HOSTCC  scripts/dtc/libfdt/fdt_empty_tree.o
>   WRAP    arch/riscv/include/generated/asm/percpu.h
>   WRAP    arch/riscv/include/generated/asm/preempt.h
>   HOSTCC  scripts/dtc/libfdt/fdt_addresses.o
>   WRAP    arch/riscv/include/generated/asm/rwonce.h
>   WRAP    arch/riscv/include/generated/asm/serial.h
>   WRAP    arch/riscv/include/generated/asm/shmparam.h
>   WRAP    arch/riscv/include/generated/asm/simd.h
>   WRAP    arch/riscv/include/generated/asm/softirq_stack.h
>   WRAP    arch/riscv/include/generated/asm/topology.h
>   WRAP    arch/riscv/include/generated/asm/trace_clock.h
>   WRAP    arch/riscv/include/generated/asm/unaligned.h
>   HOSTCC  scripts/dtc/libfdt/fdt_overlay.o
>   WRAP    arch/riscv/include/generated/asm/vga.h
>   HOSTCC  scripts/dtc/fdtoverlay.o
>   WRAP    arch/riscv/include/generated/asm/xor.h
>   HOSTCC  scripts/dtc/dtc-lexer.lex.o
>   HOSTCC  scripts/dtc/dtc-parser.tab.o
>   HOSTLD  scripts/dtc/fdtoverlay
>   HOSTLD  scripts/dtc/dtc
> make[1]: Target 'prepare' not remade because of errors.
> make[1]: Leaving directory '/home/masahiro/ref/linux/build_dir'
> make: *** [Makefile:215: __sub-make] Error 2
> make: Target 'prepare' not remade because of errors.
> 
> 
> 
> 
> 
> 
> It can be fixed by installing riscv64-linux-gnu toolchains.
> 
> On debian or its variants,
> 
> you can do it by
> "sudo apt install binutils-riscv64-linux-gnu"
> 
> 
> Or, you can download it from
> https://download.01.org/0day-ci/cross-package/gcc-11.2.0-nolibc/
> 
> 
> 
> Then, the 0day bot command will proceed.
> 
> 
> 
> 
> 
> 
> masahiro@grover:~/ref/linux$ sudo apt install binutils-riscv64-linux-gnu
> Reading package lists... Done
> Building dependency tree... Done
> Reading state information... Done
> The following packages were automatically installed and are no longer required:
>   cpp-10-riscv64-linux-gnu cpp-riscv64-linux-gnu
> gcc-10-riscv64-linux-gnu-base libatomic1-riscv64-cross
> libc6-dev-riscv64-cross libc6-riscv64-cross
> libgcc-10-dev-riscv64-cross
>   libgcc-s1-riscv64-cross libgomp1-riscv64-cross linux-libc-dev-riscv64-cross
> Use 'sudo apt autoremove' to remove them.
> Suggested packages:
>   binutils-doc
> The following NEW packages will be installed:
>   binutils-riscv64-linux-gnu
> 0 upgraded, 1 newly installed, 0 to remove and 9 not upgraded.
> Need to get 1,187 kB of archives.
> After this operation, 8,838 kB of additional disk space will be used.
> Get:1 http://jp.archive.ubuntu.com/ubuntu hirsute/main amd64
> binutils-riscv64-linux-gnu amd64 2.36.1-6ubuntu1 [1,187 kB]
> Fetched 1,187 kB in 0s (4,826 kB/s)
> Selecting previously unselected package binutils-riscv64-linux-gnu.
> (Reading database ... 478665 files and directories currently installed.)
> Preparing to unpack .../binutils-riscv64-linux-gnu_2.36.1-6ubuntu1_amd64.deb ...
> Unpacking binutils-riscv64-linux-gnu (2.36.1-6ubuntu1) ...
> Setting up binutils-riscv64-linux-gnu (2.36.1-6ubuntu1) ...
> Processing triggers for libc-bin (2.33-0ubuntu5) ...
> Processing triggers for man-db (2.9.4-2) ...
> 
> masahiro@grover:~/ref/linux$ COMPILER_INSTALL_PATH=$HOME/0day
> COMPILER=clang make.cross O=build_dir ARCH=riscv prepare
> Compiler will be installed in /home/masahiro/0day
> make --keep-going CONFIG_OF_ALL_DTBS=y CONFIG_DTC=y
> HOSTCC=/home/masahiro/0day/clang/bin/clang
> CC=/home/masahiro/0day/clang/bin/clang
> LD=/home/masahiro/0day/clang/bin/ld.lld
> HOSTLD=/home/masahiro/0day/clang/bin/ld.lld AR=llvm-ar NM=llvm-nm
> STRIP=llvm-strip OBJDUMP=llvm-objdump OBJSIZE=llvm-size
> READELF=llvm-readelf HOSTCXX=clang++ HOSTAR=llvm-ar
> CROSS_COMPILE=riscv64-linux-gnu- --jobs=16 O=build_dir ARCH=riscv
> prepare
> make[1]: Entering directory '/home/masahiro/ref/linux/build_dir'
>   SYNC    include/config/auto.conf
>   GEN     Makefile
> .config:792:warning: symbol value 'm' invalid for MTD_NAND_ECC_SW_HAMMING
> *
> * Restart config...
> *
> *
> * CPU/Task time and stats accounting
> *
> Cputime accounting
>   1. Simple tick based cputime accounting (TICK_CPU_ACCOUNTING)
> > 2. Full dynticks CPU time accounting (VIRT_CPU_ACCOUNTING_GEN)
> choice[1-2?]: 2
> Fine granularity task level IRQ time accounting (IRQ_TIME_ACCOUNTING)
> [N/y/?] (NEW)
> 
> 
> 
> 
> 
> 
> 
> --
> Best Regards
> Masahiro Yamada
> 

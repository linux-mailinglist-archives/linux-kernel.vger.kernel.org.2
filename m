Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E553EB3EF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 12:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240038AbhHMKUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 06:20:32 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:34288 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239176AbhHMKU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 06:20:28 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 17DAJMx8028395
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 19:19:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 17DAJMx8028395
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1628849963;
        bh=QL3jK1zI399ix2VJuNpv//yXsupyM4b2A2ym+GjWElw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CP/Ccpn2uLAl6mWfZHdRUWhAS8+DhssC34nST1+5Xj1d5AZtzv6UmICyHVmAkABJd
         wrHTD19wGKo4luG0vGURbn/OQOS9UaHFSbWBEJUEMIEOBsnWgwM2wUSLGkj+EaqCx/
         qRetECSx7iuuTX6eP+0/2uod+94TzzCTrz+wcuh/XHDLTpCDpq72L2Fb41avWgrteX
         VNRi7tWVPRCf8Rjlyl4tlYP4D8dISSvH4K56C5l3gfThpssgp7uUleESTGyUx0fXWX
         n2yqQcMSbycUfN0MuX5czIEdr3z3JmccIZcos7LC5cUVbkNychFLppNiIw9bdmuRjL
         /WGNdbkbAPj5A==
X-Nifty-SrcIP: [209.85.214.176]
Received: by mail-pl1-f176.google.com with SMTP id q2so11254691plr.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 03:19:23 -0700 (PDT)
X-Gm-Message-State: AOAM533QDnCcL8bD683B9uEt/C2VE43qF/H5FbdrdCeNqTpYWN1zHElA
        AQkZas/9iHRbzW6KJtcV++z5oulf7xIXwKMR560=
X-Google-Smtp-Source: ABdhPJzZe1z26u3q4X1QduEGhpa+GFfdyeEo2OeAUgAZgrSoDrg3XNOf2pxaoxVFZUoPBtOKQLRBrepvUopp5UDleT4=
X-Received: by 2002:a17:902:bc41:b029:12d:3f9b:401e with SMTP id
 t1-20020a170902bc41b029012d3f9b401emr1563543plz.47.1628849962196; Fri, 13 Aug
 2021 03:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <202108111155.RvN9J3Hs-lkp@intel.com> <5ec75ad9-a861-4402-9c16-ae7cb0aaeaba@infradead.org>
In-Reply-To: <5ec75ad9-a861-4402-9c16-ae7cb0aaeaba@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 13 Aug 2021 19:18:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNATk21qWbgWORfmCLPD3Cieon-fwtuLtFhgOo1XORWJT6g@mail.gmail.com>
Message-ID: <CAK7LNATk21qWbgWORfmCLPD3Cieon-fwtuLtFhgOo1XORWJT6g@mail.gmail.com>
Subject: Re: Error: kernelrelease not valid - run 'make prepare' to update it
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 12:19 PM Randy Dunlap <rdunlap@infradead.org> wrote=
:
>
> On 8/10/21 8:16 PM, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master
> > head:   9e723c5380c6e14fb91a8b6950563d040674afdb
> > commit: ba64beb17493a4bfec563100c86a462a15926f24 kbuild: check the mini=
mum assembler version in Kconfig
> > date:   4 months ago
> > config: riscv-randconfig-r025-20210810 (attached as .config)
> > compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d3=
9ebdae674c8efc84ebe8dc32716ec353220530)
> > reproduce (this is a W=3D1 build):
> >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/=
sbin/make.cross -O ~/bin/make.cross
> >          chmod +x ~/bin/make.cross
> >          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/lin=
ux.git/commit/?id=3Dba64beb17493a4bfec563100c86a462a15926f24
> >          git remote add linus https://git.kernel.org/pub/scm/linux/kern=
el/git/torvalds/linux.git
> >          git fetch --no-tags linus master
> >          git checkout ba64beb17493a4bfec563100c86a462a15926f24
> >          # save the attached .config to linux build tree
> >          mkdir build_dir
> >          COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross=
 O=3Dbuild_dir ARCH=3Driscv prepare
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >>> Error: kernelrelease not valid - run 'make prepare' to update it
> > --
> >     clang --target=3Driscv64-linux-gnu -no-integrated-as --prefix=3Dris=
cv64-linux-gnu- -Werror=3Dunknown-warning-option: unknown assembler invoked
> >     scripts/Kconfig.include:50: Sorry, this assembler is not supported.
> >     make[3]: *** [scripts/kconfig/Makefile:63: syncconfig] Error 1
> >     make[2]: *** [Makefile:617: syncconfig] Error 2
> >     make[1]: *** [Makefile:726: include/config/auto.conf.cmd] Error 2
> >     make[1]: Failed to remake makefile 'include/config/auto.conf.cmd'.
> >     make[1]: Failed to remake makefile 'include/config/auto.conf'.
> >>> Error: kernelrelease not valid - run 'make prepare' to update it
> >     make[1]: Target 'prepare' not remade because of errors.
> >     make: *** [Makefile:215: __sub-make] Error 2
> >     make: Target 'prepare' not remade because of errors.
>
> Yes, I have noticed this one and a few other ('static') make targets that
> should not need a .config file. I have a note to myself to ask about thes=
e,
> so thanks for bringing it up.


I think it is unrelated.



The 0-day bot has already shown the real reason
of the error:

   clang --target=3Driscv64-linux-gnu -no-integrated-as
--prefix=3Driscv64-linux-gnu- -Werror=3Dunknown-warning-option: unknown
assembler invoked
   scripts/Kconfig.include:50: Sorry, this assembler is not supported.




This happens when the proper toolchains are not found.

That is, make.cross passed CROSS_COMPILE=3Driscv64-linux-gnu-
to the make command line, but riscv64-linux-gnu binutils
are not installed on the system.



Without installing binutils-riscv64-linux-gnu,
I can see a similar error log.





masahiro@grover:~/ref/linux$ wget
https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
-O ~/bin/make.cross
--2021-08-13 18:57:01--
https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
Resolving raw.githubusercontent.com (raw.githubusercontent.com)...
185.199.110.133, 185.199.109.133, 185.199.111.133, ...
Connecting to raw.githubusercontent.com
(raw.githubusercontent.com)|185.199.110.133|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 9655 (9.4K) [text/plain]
Saving to: =E2=80=98/home/masahiro/bin/make.cross=E2=80=99

/home/masahiro/bin/make.cross
100%[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>]
  9.43K  --.-KB/s    in 0s

2021-08-13 18:57:01 (44.7 MB/s) - =E2=80=98/home/masahiro/bin/make.cross=E2=
=80=99
saved [9655/9655]

masahiro@grover:~/ref/linux$ chmod +x ~/bin/make.cross
masahiro@grover:~/ref/linux$ git checkout
ba64beb17493a4bfec563100c86a462a15926f24
HEAD is now at ba64beb17493 kbuild: check the minimum assembler
version in Kconfig
masahiro@grover:~/ref/linux$ rm -rf build_dir; mkdir build_dir
masahiro@grover:~/ref/linux$ zcat  ~/Downloads/config.gz  > build_dir/.conf=
ig
masahiro@grover:~/ref/linux$ COMPILER_INSTALL_PATH=3D$HOME/0day
COMPILER=3Dclang make.cross O=3Dbuild_dir ARCH=3Driscv prepare
Compiler will be installed in /home/masahiro/0day
make --keep-going CONFIG_OF_ALL_DTBS=3Dy CONFIG_DTC=3Dy
HOSTCC=3D/home/masahiro/0day/clang/bin/clang
CC=3D/home/masahiro/0day/clang/bin/clang
LD=3D/home/masahiro/0day/clang/bin/ld.lld
HOSTLD=3D/home/masahiro/0day/clang/bin/ld.lld AR=3Dllvm-ar NM=3Dllvm-nm
STRIP=3Dllvm-strip OBJDUMP=3Dllvm-objdump OBJSIZE=3Dllvm-size
READELF=3Dllvm-readelf HOSTCXX=3Dclang++ HOSTAR=3Dllvm-ar
CROSS_COMPILE=3Driscv64-linux-gnu- --jobs=3D16 O=3Dbuild_dir ARCH=3Driscv
prepare
make[1]: Entering directory '/home/masahiro/ref/linux/build_dir'
  SYNC    include/config/auto.conf
  GEN     Makefile
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/confdata.o
  HOSTCC  scripts/kconfig/expr.o
  LEX     scripts/kconfig/lexer.lex.c
  YACC    scripts/kconfig/parser.tab.[ch]
  HOSTCC  scripts/kconfig/preprocess.o
  HOSTCC  scripts/kconfig/symbol.o
  HOSTCC  scripts/kconfig/util.o
  HOSTCC  scripts/kconfig/lexer.lex.o
  HOSTCC  scripts/kconfig/parser.tab.o
  HOSTLD  scripts/kconfig/conf
/home/masahiro/0day/clang/bin/clang --target=3Driscv64-linux-gnu
-no-integrated-as --prefix=3Driscv64-linux-gnu-
-Werror=3Dunknown-warning-option: unknown assembler invoked
scripts/Kconfig.include:50: Sorry, this assembler is not supported.
make[3]: *** [../scripts/kconfig/Makefile:63: syncconfig] Error 1
make[2]: *** [../Makefile:617: syncconfig] Error 2
make[1]: *** [/home/masahiro/ref/linux/Makefile:726:
include/config/auto.conf] Error 2
make[1]: Failed to remake makefile 'include/config/auto.conf'.
make[1]: Failed to remake makefile 'include/config/auto.conf.cmd'.
  GEN     Makefile
  WRAP    arch/riscv/include/generated/uapi/asm/errno.h
  WRAP    arch/riscv/include/generated/uapi/asm/fcntl.h
  WRAP    arch/riscv/include/generated/uapi/asm/ioctl.h
  WRAP    arch/riscv/include/generated/uapi/asm/ioctls.h
  WRAP    arch/riscv/include/generated/uapi/asm/ipcbuf.h
  WRAP    arch/riscv/include/generated/uapi/asm/mman.h
  WRAP    arch/riscv/include/generated/uapi/asm/msgbuf.h
  WRAP    arch/riscv/include/generated/uapi/asm/param.h
  WRAP    arch/riscv/include/generated/uapi/asm/poll.h
  WRAP    arch/riscv/include/generated/uapi/asm/posix_types.h
  WRAP    arch/riscv/include/generated/uapi/asm/resource.h
  WRAP    arch/riscv/include/generated/uapi/asm/sembuf.h
  WRAP    arch/riscv/include/generated/uapi/asm/setup.h
  WRAP    arch/riscv/include/generated/uapi/asm/shmbuf.h
  WRAP    arch/riscv/include/generated/uapi/asm/siginfo.h
  WRAP    arch/riscv/include/generated/uapi/asm/signal.h
  WRAP    arch/riscv/include/generated/uapi/asm/socket.h
  WRAP    arch/riscv/include/generated/uapi/asm/sockios.h
  WRAP    arch/riscv/include/generated/uapi/asm/stat.h
  WRAP    arch/riscv/include/generated/uapi/asm/statfs.h
  WRAP    arch/riscv/include/generated/uapi/asm/swab.h
  WRAP    arch/riscv/include/generated/uapi/asm/termbits.h
  WRAP    arch/riscv/include/generated/uapi/asm/termios.h
  WRAP    arch/riscv/include/generated/uapi/asm/types.h
Error: kernelrelease not valid - run 'make prepare' to update it
  UPD     include/config/kernel.release
  HOSTCC  scripts/dtc/dtc.o
  HOSTCC  scripts/dtc/flattree.o
  HOSTCC  scripts/dtc/fstree.o
  HOSTCC  scripts/dtc/data.o
  HOSTCC  scripts/dtc/livetree.o
  HOSTCC  scripts/dtc/treesource.o
  HOSTCC  scripts/dtc/srcpos.o
  HOSTCC  scripts/dtc/checks.o
  HOSTCC  scripts/dtc/util.o
  UPD     include/generated/uapi/linux/version.h
  LEX     scripts/dtc/dtc-lexer.lex.c
  YACC    scripts/dtc/dtc-parser.tab.[ch]
  HOSTCC  scripts/dtc/yamltree.o
  HOSTCC  scripts/dtc/libfdt/fdt.o
  UPD     include/generated/utsrelease.h
  HOSTCC  scripts/dtc/libfdt/fdt_ro.o
  HOSTCC  scripts/dtc/libfdt/fdt_wip.o
  HOSTCC  scripts/dtc/libfdt/fdt_sw.o
  HOSTCC  scripts/dtc/libfdt/fdt_rw.o
  WRAP    arch/riscv/include/generated/asm/early_ioremap.h
  WRAP    arch/riscv/include/generated/asm/extable.h
  WRAP    arch/riscv/include/generated/asm/flat.h
  WRAP    arch/riscv/include/generated/asm/kvm_para.h
  HOSTCC  scripts/dtc/libfdt/fdt_strerror.o
  WRAP    arch/riscv/include/generated/asm/user.h
  WRAP    arch/riscv/include/generated/asm/vmlinux.lds.h
  WRAP    arch/riscv/include/generated/asm/bugs.h
  WRAP    arch/riscv/include/generated/asm/checksum.h
  WRAP    arch/riscv/include/generated/asm/compat.h
  WRAP    arch/riscv/include/generated/asm/device.h
  WRAP    arch/riscv/include/generated/asm/div64.h
  WRAP    arch/riscv/include/generated/asm/dma-mapping.h
  WRAP    arch/riscv/include/generated/asm/dma.h
  WRAP    arch/riscv/include/generated/asm/emergency-restart.h
  WRAP    arch/riscv/include/generated/asm/exec.h
  WRAP    arch/riscv/include/generated/asm/fb.h
  WRAP    arch/riscv/include/generated/asm/hardirq.h
  WRAP    arch/riscv/include/generated/asm/hw_irq.h
  WRAP    arch/riscv/include/generated/asm/irq_regs.h
  WRAP    arch/riscv/include/generated/asm/kmap_size.h
  WRAP    arch/riscv/include/generated/asm/local.h
  WRAP    arch/riscv/include/generated/asm/local64.h
  WRAP    arch/riscv/include/generated/asm/msi.h
  HOSTCC  scripts/dtc/libfdt/fdt_empty_tree.o
  WRAP    arch/riscv/include/generated/asm/percpu.h
  WRAP    arch/riscv/include/generated/asm/preempt.h
  HOSTCC  scripts/dtc/libfdt/fdt_addresses.o
  WRAP    arch/riscv/include/generated/asm/rwonce.h
  WRAP    arch/riscv/include/generated/asm/serial.h
  WRAP    arch/riscv/include/generated/asm/shmparam.h
  WRAP    arch/riscv/include/generated/asm/simd.h
  WRAP    arch/riscv/include/generated/asm/softirq_stack.h
  WRAP    arch/riscv/include/generated/asm/topology.h
  WRAP    arch/riscv/include/generated/asm/trace_clock.h
  WRAP    arch/riscv/include/generated/asm/unaligned.h
  HOSTCC  scripts/dtc/libfdt/fdt_overlay.o
  WRAP    arch/riscv/include/generated/asm/vga.h
  HOSTCC  scripts/dtc/fdtoverlay.o
  WRAP    arch/riscv/include/generated/asm/xor.h
  HOSTCC  scripts/dtc/dtc-lexer.lex.o
  HOSTCC  scripts/dtc/dtc-parser.tab.o
  HOSTLD  scripts/dtc/fdtoverlay
  HOSTLD  scripts/dtc/dtc
make[1]: Target 'prepare' not remade because of errors.
make[1]: Leaving directory '/home/masahiro/ref/linux/build_dir'
make: *** [Makefile:215: __sub-make] Error 2
make: Target 'prepare' not remade because of errors.






It can be fixed by installing riscv64-linux-gnu toolchains.

On debian or its variants,

you can do it by
"sudo apt install binutils-riscv64-linux-gnu"


Or, you can download it from
https://download.01.org/0day-ci/cross-package/gcc-11.2.0-nolibc/



Then, the 0day bot command will proceed.






masahiro@grover:~/ref/linux$ sudo apt install binutils-riscv64-linux-gnu
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following packages were automatically installed and are no longer requi=
red:
  cpp-10-riscv64-linux-gnu cpp-riscv64-linux-gnu
gcc-10-riscv64-linux-gnu-base libatomic1-riscv64-cross
libc6-dev-riscv64-cross libc6-riscv64-cross
libgcc-10-dev-riscv64-cross
  libgcc-s1-riscv64-cross libgomp1-riscv64-cross linux-libc-dev-riscv64-cro=
ss
Use 'sudo apt autoremove' to remove them.
Suggested packages:
  binutils-doc
The following NEW packages will be installed:
  binutils-riscv64-linux-gnu
0 upgraded, 1 newly installed, 0 to remove and 9 not upgraded.
Need to get 1,187 kB of archives.
After this operation, 8,838 kB of additional disk space will be used.
Get:1 http://jp.archive.ubuntu.com/ubuntu hirsute/main amd64
binutils-riscv64-linux-gnu amd64 2.36.1-6ubuntu1 [1,187 kB]
Fetched 1,187 kB in 0s (4,826 kB/s)
Selecting previously unselected package binutils-riscv64-linux-gnu.
(Reading database ... 478665 files and directories currently installed.)
Preparing to unpack .../binutils-riscv64-linux-gnu_2.36.1-6ubuntu1_amd64.de=
b ...
Unpacking binutils-riscv64-linux-gnu (2.36.1-6ubuntu1) ...
Setting up binutils-riscv64-linux-gnu (2.36.1-6ubuntu1) ...
Processing triggers for libc-bin (2.33-0ubuntu5) ...
Processing triggers for man-db (2.9.4-2) ...

masahiro@grover:~/ref/linux$ COMPILER_INSTALL_PATH=3D$HOME/0day
COMPILER=3Dclang make.cross O=3Dbuild_dir ARCH=3Driscv prepare
Compiler will be installed in /home/masahiro/0day
make --keep-going CONFIG_OF_ALL_DTBS=3Dy CONFIG_DTC=3Dy
HOSTCC=3D/home/masahiro/0day/clang/bin/clang
CC=3D/home/masahiro/0day/clang/bin/clang
LD=3D/home/masahiro/0day/clang/bin/ld.lld
HOSTLD=3D/home/masahiro/0day/clang/bin/ld.lld AR=3Dllvm-ar NM=3Dllvm-nm
STRIP=3Dllvm-strip OBJDUMP=3Dllvm-objdump OBJSIZE=3Dllvm-size
READELF=3Dllvm-readelf HOSTCXX=3Dclang++ HOSTAR=3Dllvm-ar
CROSS_COMPILE=3Driscv64-linux-gnu- --jobs=3D16 O=3Dbuild_dir ARCH=3Driscv
prepare
make[1]: Entering directory '/home/masahiro/ref/linux/build_dir'
  SYNC    include/config/auto.conf
  GEN     Makefile
.config:792:warning: symbol value 'm' invalid for MTD_NAND_ECC_SW_HAMMING
*
* Restart config...
*
*
* CPU/Task time and stats accounting
*
Cputime accounting
  1. Simple tick based cputime accounting (TICK_CPU_ACCOUNTING)
> 2. Full dynticks CPU time accounting (VIRT_CPU_ACCOUNTING_GEN)
choice[1-2?]: 2
Fine granularity task level IRQ time accounting (IRQ_TIME_ACCOUNTING)
[N/y/?] (NEW)







--
Best Regards
Masahiro Yamada

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1416739C6EB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 10:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhFEJA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 05:00:58 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:53952 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229864AbhFEJA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 05:00:57 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4Fxtq05hkBzBBMk;
        Sat,  5 Jun 2021 10:59:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QwKEXgcAPbWS; Sat,  5 Jun 2021 10:59:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Fxtq025zyzBBMM;
        Sat,  5 Jun 2021 10:59:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2989E8B775;
        Sat,  5 Jun 2021 10:59:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 2OID4sTNR9EC; Sat,  5 Jun 2021 10:59:08 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8D5808B763;
        Sat,  5 Jun 2021 10:59:07 +0200 (CEST)
Subject: Re: arch/powerpc/mm/mem.c:53:12: error: no previous prototype for
 function 'create_section_mapping'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
References: <202106051109.BB1BLmy7-lkp@intel.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <af3be658-1126-c0ba-62ef-40eacf6c3960@csgroup.eu>
Date:   Sat, 5 Jun 2021 10:59:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202106051109.BB1BLmy7-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 05/06/2021 à 05:11, kernel test robot a écrit :
> Hi Christophe,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   ff6091075a687676d76b3beb24fa77389b387b00
> commit: b26e8f27253a47bff90972b987112fd8396e9b8d powerpc/mem: Move cache flushing functions into mm/cacheflush.c
> date:   7 weeks ago

Fixed by 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/3e5b63bb3daab54a1eb9c20221c2e9528c4db9b3.1622883330.git.christophe.leroy@csgroup.eu/

Christophe


> config: powerpc-randconfig-r005-20210605 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 8ec9aa236e325fd4629cfeefac2919302e14d61a)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # install powerpc cross compiling tool for clang build
>          # apt-get install binutils-powerpc-linux-gnu
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b26e8f27253a47bff90972b987112fd8396e9b8d
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout b26e8f27253a47bff90972b987112fd8396e9b8d
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     ^
>     arch/powerpc/include/asm/io.h:537:62: note: expanded from macro '__do_outl'
>     #define __do_outl(val, port)    writel(val,(PCI_IO_ADDR)_IO_BASE+port);
>                                                ~~~~~~~~~~~~~~~~~~~~~^
>     In file included from arch/powerpc/mm/mem.c:15:
>     In file included from include/linux/memblock.h:14:
>     In file included from arch/powerpc/include/asm/dma.h:22:
>     In file included from arch/powerpc/include/asm/io.h:619:
>     arch/powerpc/include/asm/io-defs.h:43:1: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
>     DEF_PCI_AC_NORET(insb, (unsigned long p, void *b, unsigned long c),
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>                     __do_##name al;                                 \
>                     ^~~~~~~~~~~~~~
>     <scratch space>:200:1: note: expanded from here
>     __do_insb
>     ^
>     arch/powerpc/include/asm/io.h:556:56: note: expanded from macro '__do_insb'
>     #define __do_insb(p, b, n)      readsb((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
>                                            ~~~~~~~~~~~~~~~~~~~~~^
>     In file included from arch/powerpc/mm/mem.c:15:
>     In file included from include/linux/memblock.h:14:
>     In file included from arch/powerpc/include/asm/dma.h:22:
>     In file included from arch/powerpc/include/asm/io.h:619:
>     arch/powerpc/include/asm/io-defs.h:45:1: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
>     DEF_PCI_AC_NORET(insw, (unsigned long p, void *b, unsigned long c),
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>                     __do_##name al;                                 \
>                     ^~~~~~~~~~~~~~
>     <scratch space>:202:1: note: expanded from here
>     __do_insw
>     ^
>     arch/powerpc/include/asm/io.h:557:56: note: expanded from macro '__do_insw'
>     #define __do_insw(p, b, n)      readsw((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
>                                            ~~~~~~~~~~~~~~~~~~~~~^
>     In file included from arch/powerpc/mm/mem.c:15:
>     In file included from include/linux/memblock.h:14:
>     In file included from arch/powerpc/include/asm/dma.h:22:
>     In file included from arch/powerpc/include/asm/io.h:619:
>     arch/powerpc/include/asm/io-defs.h:47:1: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
>     DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>                     __do_##name al;                                 \
>                     ^~~~~~~~~~~~~~
>     <scratch space>:204:1: note: expanded from here
>     __do_insl
>     ^
>     arch/powerpc/include/asm/io.h:558:56: note: expanded from macro '__do_insl'
>     #define __do_insl(p, b, n)      readsl((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
>                                            ~~~~~~~~~~~~~~~~~~~~~^
>     In file included from arch/powerpc/mm/mem.c:15:
>     In file included from include/linux/memblock.h:14:
>     In file included from arch/powerpc/include/asm/dma.h:22:
>     In file included from arch/powerpc/include/asm/io.h:619:
>     arch/powerpc/include/asm/io-defs.h:49:1: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
>     DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>                     __do_##name al;                                 \
>                     ^~~~~~~~~~~~~~
>     <scratch space>:206:1: note: expanded from here
>     __do_outsb
>     ^
>     arch/powerpc/include/asm/io.h:559:58: note: expanded from macro '__do_outsb'
>     #define __do_outsb(p, b, n)     writesb((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
>                                             ~~~~~~~~~~~~~~~~~~~~~^
>     In file included from arch/powerpc/mm/mem.c:15:
>     In file included from include/linux/memblock.h:14:
>     In file included from arch/powerpc/include/asm/dma.h:22:
>     In file included from arch/powerpc/include/asm/io.h:619:
>     arch/powerpc/include/asm/io-defs.h:51:1: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
>     DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>                     __do_##name al;                                 \
>                     ^~~~~~~~~~~~~~
>     <scratch space>:208:1: note: expanded from here
>     __do_outsw
>     ^
>     arch/powerpc/include/asm/io.h:560:58: note: expanded from macro '__do_outsw'
>     #define __do_outsw(p, b, n)     writesw((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
>                                             ~~~~~~~~~~~~~~~~~~~~~^
>     In file included from arch/powerpc/mm/mem.c:15:
>     In file included from include/linux/memblock.h:14:
>     In file included from arch/powerpc/include/asm/dma.h:22:
>     In file included from arch/powerpc/include/asm/io.h:619:
>     arch/powerpc/include/asm/io-defs.h:53:1: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
>     DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     arch/powerpc/include/asm/io.h:616:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>                     __do_##name al;                                 \
>                     ^~~~~~~~~~~~~~
>     <scratch space>:210:1: note: expanded from here
>     __do_outsl
>     ^
>     arch/powerpc/include/asm/io.h:561:58: note: expanded from macro '__do_outsl'
>     #define __do_outsl(p, b, n)     writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
>                                             ~~~~~~~~~~~~~~~~~~~~~^
>>> arch/powerpc/mm/mem.c:53:12: error: no previous prototype for function 'create_section_mapping' [-Werror,-Wmissing-prototypes]
>     int __weak create_section_mapping(unsigned long start, unsigned long end,
>                ^
>     arch/powerpc/mm/mem.c:53:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>     int __weak create_section_mapping(unsigned long start, unsigned long end,
>     ^
>     static
>     14 errors generated.
> 
> 
> vim +/create_section_mapping +53 arch/powerpc/mm/mem.c
> 
> bc02af93dd2bbd Yasunori Goto          2006-06-27  52
> 4e00c5affdd4b0 Logan Gunthorpe        2020-04-10 @53  int __weak create_section_mapping(unsigned long start, unsigned long end,
> 4e00c5affdd4b0 Logan Gunthorpe        2020-04-10  54  				  int nid, pgprot_t prot)
> fecbfabe1dc940 Benjamin Herrenschmidt 2016-07-05  55  {
> fecbfabe1dc940 Benjamin Herrenschmidt 2016-07-05  56  	return -ENODEV;
> fecbfabe1dc940 Benjamin Herrenschmidt 2016-07-05  57  }
> fecbfabe1dc940 Benjamin Herrenschmidt 2016-07-05  58
> 
> :::::: The code at line 53 was first introduced by commit
> :::::: 4e00c5affdd4b04e6392001716333971932f3d0c powerpc/mm: thread pgprot_t through create_section_mapping()
> 
> :::::: TO: Logan Gunthorpe <logang@deltatee.com>
> :::::: CC: Linus Torvalds <torvalds@linux-foundation.org>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

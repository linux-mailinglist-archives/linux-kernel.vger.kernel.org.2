Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2373B5A3D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 10:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhF1IIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 04:08:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:28311 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232318AbhF1IIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 04:08:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10028"; a="206082426"
X-IronPort-AV: E=Sophos;i="5.83,305,1616482800"; 
   d="scan'208";a="206082426"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 01:05:56 -0700
X-IronPort-AV: E=Sophos;i="5.83,305,1616482800"; 
   d="scan'208";a="456226358"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.30.185]) ([10.255.30.185])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 01:05:53 -0700
Subject: Re: [kbuild-all] Re: net/ceph/messenger_v2.c:2808:5: warning: stack
 frame size (2336) exceeds limit (2048) in function 'ceph_con_v2_try_read'
To:     Ilya Dryomov <idryomov@gmail.com>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        LKML <linux-kernel@vger.kernel.org>
References: <202106280955.VUsBSyHq-lkp@intel.com>
 <CAOi1vP-FR2PpqdW4WuhJaaFPZifxthf0B45dV03v00ef66R8wg@mail.gmail.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <a875976b-3117-f001-606b-8e90802bef8a@intel.com>
Date:   Mon, 28 Jun 2021 16:05:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAOi1vP-FR2PpqdW4WuhJaaFPZifxthf0B45dV03v00ef66R8wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/28/2021 4:02 PM, Ilya Dryomov wrote:
> On Mon, Jun 28, 2021 at 3:25 AM kernel test robot <lkp@intel.com> wrote:
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   62fb9874f5da54fdb243003b386128037319b219
>> commit: cd1a677cad994021b19665ed476aea63f5d54f31 libceph, ceph: implement msgr2.1 protocol (crc and secure modes)
>> date:   7 months ago
>> config: powerpc64-randconfig-r034-20210628 (attached as .config)
>> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 59558129276098d62046c8cda92240d292cbfb1c)
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # install powerpc64 cross compiling tool for clang build
>>          # apt-get install binutils-powerpc64-linux-gnu
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cd1a677cad994021b19665ed476aea63f5d54f31
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout cd1a677cad994021b19665ed476aea63f5d54f31
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc64
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     arch/powerpc/include/asm/io.h:601:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>>                     __do_##name al;                                 \
>>                     ^~~~~~~~~~~~~~
>>     <scratch space>:2:1: note: expanded from here
>>     __do_outl
>>     ^
>>     arch/powerpc/include/asm/io.h:522:62: note: expanded from macro '__do_outl'
>>     #define __do_outl(val, port)    writel(val,(PCI_IO_ADDR)_IO_BASE+port);
>>                                                ~~~~~~~~~~~~~~~~~~~~~^
>>     In file included from net/ceph/messenger_v2.c:17:
>>     In file included from include/linux/scatterlist.h:9:
>>     In file included from arch/powerpc/include/asm/io.h:604:
>>     arch/powerpc/include/asm/io-defs.h:43:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>>     DEF_PCI_AC_NORET(insb, (unsigned long p, void *b, unsigned long c),
>>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     arch/powerpc/include/asm/io.h:601:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>>                     __do_##name al;                                 \
>>                     ^~~~~~~~~~~~~~
>>     <scratch space>:30:1: note: expanded from here
>>     __do_insb
>>     ^
>>     arch/powerpc/include/asm/io.h:541:56: note: expanded from macro '__do_insb'
>>     #define __do_insb(p, b, n)      readsb((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
>>                                            ~~~~~~~~~~~~~~~~~~~~~^
>>     In file included from net/ceph/messenger_v2.c:17:
>>     In file included from include/linux/scatterlist.h:9:
>>     In file included from arch/powerpc/include/asm/io.h:604:
>>     arch/powerpc/include/asm/io-defs.h:45:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>>     DEF_PCI_AC_NORET(insw, (unsigned long p, void *b, unsigned long c),
>>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     arch/powerpc/include/asm/io.h:601:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>>                     __do_##name al;                                 \
>>                     ^~~~~~~~~~~~~~
>>     <scratch space>:34:1: note: expanded from here
>>     __do_insw
>>     ^
>>     arch/powerpc/include/asm/io.h:542:56: note: expanded from macro '__do_insw'
>>     #define __do_insw(p, b, n)      readsw((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
>>                                            ~~~~~~~~~~~~~~~~~~~~~^
>>     In file included from net/ceph/messenger_v2.c:17:
>>     In file included from include/linux/scatterlist.h:9:
>>     In file included from arch/powerpc/include/asm/io.h:604:
>>     arch/powerpc/include/asm/io-defs.h:47:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>>     DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
>>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     arch/powerpc/include/asm/io.h:601:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>>                     __do_##name al;                                 \
>>                     ^~~~~~~~~~~~~~
>>     <scratch space>:38:1: note: expanded from here
>>     __do_insl
>>     ^
>>     arch/powerpc/include/asm/io.h:543:56: note: expanded from macro '__do_insl'
>>     #define __do_insl(p, b, n)      readsl((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
>>                                            ~~~~~~~~~~~~~~~~~~~~~^
>>     In file included from net/ceph/messenger_v2.c:17:
>>     In file included from include/linux/scatterlist.h:9:
>>     In file included from arch/powerpc/include/asm/io.h:604:
>>     arch/powerpc/include/asm/io-defs.h:49:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>>     DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
>>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     arch/powerpc/include/asm/io.h:601:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>>                     __do_##name al;                                 \
>>                     ^~~~~~~~~~~~~~
>>     <scratch space>:42:1: note: expanded from here
>>     __do_outsb
>>     ^
>>     arch/powerpc/include/asm/io.h:544:58: note: expanded from macro '__do_outsb'
>>     #define __do_outsb(p, b, n)     writesb((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
>>                                             ~~~~~~~~~~~~~~~~~~~~~^
>>     In file included from net/ceph/messenger_v2.c:17:
>>     In file included from include/linux/scatterlist.h:9:
>>     In file included from arch/powerpc/include/asm/io.h:604:
>>     arch/powerpc/include/asm/io-defs.h:51:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>>     DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
>>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     arch/powerpc/include/asm/io.h:601:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>>                     __do_##name al;                                 \
>>                     ^~~~~~~~~~~~~~
>>     <scratch space>:46:1: note: expanded from here
>>     __do_outsw
>>     ^
>>     arch/powerpc/include/asm/io.h:545:58: note: expanded from macro '__do_outsw'
>>     #define __do_outsw(p, b, n)     writesw((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
>>                                             ~~~~~~~~~~~~~~~~~~~~~^
>>     In file included from net/ceph/messenger_v2.c:17:
>>     In file included from include/linux/scatterlist.h:9:
>>     In file included from arch/powerpc/include/asm/io.h:604:
>>     arch/powerpc/include/asm/io-defs.h:53:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>>     DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
>>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     arch/powerpc/include/asm/io.h:601:3: note: expanded from macro 'DEF_PCI_AC_NORET'
>>                     __do_##name al;                                 \
>>                     ^~~~~~~~~~~~~~
>>     <scratch space>:50:1: note: expanded from here
>>     __do_outsl
>>     ^
>>     arch/powerpc/include/asm/io.h:546:58: note: expanded from macro '__do_outsl'
>>     #define __do_outsl(p, b, n)     writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
>>                                             ~~~~~~~~~~~~~~~~~~~~~^
>>>> net/ceph/messenger_v2.c:2808:5: warning: stack frame size (2336) exceeds limit (2048) in function 'ceph_con_v2_try_read' [-Wframe-larger-than]
> 
> Same as for ceph_con_v1_try_read(), please add this instance to the
> allowlist.

Got it, thanks for the information.

Best Regards,
Rong Chen

> 
> Thanks,
> 
>                  Ilya
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D60E3D31FA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 04:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbhGWCCw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Jul 2021 22:02:52 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7415 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbhGWCCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 22:02:51 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GWD724g9zz7wWf;
        Fri, 23 Jul 2021 10:39:42 +0800 (CST)
Received: from dggemm753-chm.china.huawei.com (10.1.198.59) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Jul 2021 10:43:23 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemm753-chm.china.huawei.com (10.1.198.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 23 Jul 2021 10:43:23 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Fri, 23 Jul 2021 10:43:22 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
CC:     "liuqi (BA)" <liuqi115@huawei.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
        "anil.s.keshavamurthy@intel.com" <anil.s.keshavamurthy@intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] arm64: kprobe: Enable OPTPROBE for arm64
Thread-Topic: [PATCH] arm64: kprobe: Enable OPTPROBE for arm64
Thread-Index: AQHXfJkyPamnf4yoyEqhBrLk7zE456tMmTOAgAIsGRD//9DNAIABRqug
Date:   Fri, 23 Jul 2021 02:43:22 +0000
Message-ID: <6c71c1bba0124dedac9cb09c29465e04@hisilicon.com>
References: <20210719122417.10355-1-liuqi115@huawei.com>
        <20210721174153.34c1898dc9eea135eb0b8be8@kernel.org>
        <332df5b7d7bb4bd096b6521ffefaabe6@hisilicon.com>
 <20210723000318.5594c86e7c454aed82d9465d@kernel.org>
In-Reply-To: <20210723000318.5594c86e7c454aed82d9465d@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.80]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Masami Hiramatsu [mailto:mhiramat@kernel.org]
> Sent: Friday, July 23, 2021 3:03 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: liuqi (BA) <liuqi115@huawei.com>; catalin.marinas@arm.com;
> will@kernel.org; naveen.n.rao@linux.ibm.com; anil.s.keshavamurthy@intel.com;
> davem@davemloft.net; linux-arm-kernel@lists.infradead.org; Zengtao (B)
> <prime.zeng@hisilicon.com>; robin.murphy@arm.com; Linuxarm
> <linuxarm@huawei.com>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] arm64: kprobe: Enable OPTPROBE for arm64
> 
> Hi Song,
> 
> On Thu, 22 Jul 2021 10:24:54 +0000
> "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com> wrote:
> 
> >
> >
> > > -----Original Message-----
> > > From: Masami Hiramatsu [mailto:mhiramat@kernel.org]
> > > Sent: Wednesday, July 21, 2021 8:42 PM
> > > To: liuqi (BA) <liuqi115@huawei.com>
> > > Cc: catalin.marinas@arm.com; will@kernel.org; naveen.n.rao@linux.ibm.com;
> > > anil.s.keshavamurthy@intel.com; davem@davemloft.net;
> > > linux-arm-kernel@lists.infradead.org; Song Bao Hua (Barry Song)
> > > <song.bao.hua@hisilicon.com>; Zengtao (B) <prime.zeng@hisilicon.com>;
> > > robin.murphy@arm.com; Linuxarm <linuxarm@huawei.com>;
> > > linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH] arm64: kprobe: Enable OPTPROBE for arm64
> > >
> > > Hi Qi,
> > >
> > > Thanks for your effort!
> > >
> > > On Mon, 19 Jul 2021 20:24:17 +0800
> > > Qi Liu <liuqi115@huawei.com> wrote:
> > >
> > > > This patch introduce optprobe for ARM64. In optprobe, probed
> > > > instruction is replaced by a branch instruction to detour
> > > > buffer. Detour buffer contains trampoline code and a call to
> > > > optimized_callback(). optimized_callback() calls opt_pre_handler()
> > > > to execute kprobe handler.
> > >
> > > OK so this will replace only one instruction.
> > >
> > > >
> > > > Limitations:
> > > > - We only support !CONFIG_RANDOMIZE_MODULE_REGION_FULL case to
> > > > guarantee the offset between probe point and kprobe pre_handler
> > > > is not larger than 128MiB.
> > >
> > > Hmm, shouldn't we depends on !CONFIG_ARM64_MODULE_PLTS? Or,
> > > allocate an intermediate trampoline area similar to arm optprobe
> > > does.
> >
> > Depending on !CONFIG_ARM64_MODULE_PLTS will totally disable
> > RANDOMIZE_BASE according to arch/arm64/Kconfig:
> > config RANDOMIZE_BASE
> > 	bool "Randomize the address of the kernel image"
> > 	select ARM64_MODULE_PLTS if MODULES
> > 	select RELOCATABLE
> 
> Yes, but why it is required for "RANDOMIZE_BASE"?
> Does that imply the module call might need to use PLT in
> some cases?
> 
> >
> > Depending on !RANDOMIZE_MODULE_REGION_FULL seems to be still
> > allowing RANDOMIZE_BASE via avoiding long jump according to:
> > arch/arm64/Kconfig:
> >
> > config RANDOMIZE_MODULE_REGION_FULL
> > 	bool "Randomize the module region over a 4 GB range"
> > 	depends on RANDOMIZE_BASE
> > 	default y
> > 	help
> > 	  Randomizes the location of the module region inside a 4 GB window
> > 	  covering the core kernel. This way, it is less likely for modules
> > 	  to leak information about the location of core kernel data structures
> > 	  but it does imply that function calls between modules and the core
> > 	  kernel will need to be resolved via veneers in the module PLT.
> >
> > 	  When this option is not set, the module region will be randomized over
> > 	  a limited range that contains the [_stext, _etext] interval of the
> > 	  core kernel, so branch relocations are always in range.
> 
> Hmm, this dependency looks strange. If it always in range, don't we need
> PLT for modules?
> 
> Cataline, would you know why?
> Maybe it's a KASLR's Kconfig issue?

I actually didn't see any problem after making this change:

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e07e7de9ac49..6440671b72e0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1781,7 +1781,6 @@ config RELOCATABLE

 config RANDOMIZE_BASE
        bool "Randomize the address of the kernel image"
-       select ARM64_MODULE_PLTS if MODULES
        select RELOCATABLE
        help
          Randomizes the virtual address at which the kernel image is
@@ -1801,6 +1800,7 @@ config RANDOMIZE_BASE
 config RANDOMIZE_MODULE_REGION_FULL
        bool "Randomize the module region over a 4 GB range"
        depends on RANDOMIZE_BASE
+       select ARM64_MODULE_PLTS if MODULES
        default y
        help
          Randomizes the location of the module region inside a 4 GB window

and having this config:
# zcat /proc/config.gz | grep RANDOMIZE_BASE
CONFIG_RANDOMIZE_BASE=y

# zcat /proc/config.gz | grep RANDOMIZE_MODULE_REGION_FULL
# CONFIG_RANDOMIZE_MODULE_REGION_FULL is not set

# zcat /proc/config.gz | grep ARM64_MODULE_PLTS
# CONFIG_ARM64_MODULE_PLTS is not set

Modules work all good:
# lsmod
Module                  Size  Used by
btrfs                1355776  0
blake2b_generic        20480  0
libcrc32c              16384  1 btrfs
xor                    20480  1 btrfs
xor_neon               16384  1 xor
zstd_compress         163840  1 btrfs
raid6_pq              110592  1 btrfs
ctr                    16384  0
md5                    16384  0
ip_tunnel              32768  0
ipv6                  442368  28


I am not quite sure if there is a corner case. If no,
I would think the kconfig might be some improper.


> 
> >
> > and
> >
> > arch/arm64/kernel/kaslr.c:
> > 	if (IS_ENABLED(CONFIG_RANDOMIZE_MODULE_REGION_FULL)) {
> > 		/*
> > 		 * Randomize the module region over a 2 GB window covering the
> > 		 * kernel. This reduces the risk of modules leaking information
> > 		 * about the address of the kernel itself, but results in
> > 		 * branches between modules and the core kernel that are
> > 		 * resolved via PLTs. (Branches between modules will be
> > 		 * resolved normally.)
> > 		 */
> > 		module_range = SZ_2G - (u64)(_end - _stext);
> > 		module_alloc_base = max((u64)_end + offset - SZ_2G,
> > 					(u64)MODULES_VADDR);
> > 	} else {
> > 		/*
> > 		 * Randomize the module region by setting module_alloc_base to
> > 		 * a PAGE_SIZE multiple in the range [_etext - MODULES_VSIZE,
> > 		 * _stext) . This guarantees that the resulting region still
> > 		 * covers [_stext, _etext], and that all relative branches can
> > 		 * be resolved without veneers.
> > 		 */
> > 		module_range = MODULES_VSIZE - (u64)(_etext - _stext);
> > 		module_alloc_base = (u64)_etext + offset - MODULES_VSIZE;
> > 	}
> >
> > So depending on ! ARM64_MODULE_PLTS seems to narrow the scenarios
> > while depending on ! RANDOMIZE_MODULE_REGION_FULL  permit more
> > machines to use optprobe.
> 
> OK, I see that the code ensures the range will be in the MODULE_VSIZE (=128MB).
> 
> >
> > I am not quite sure I am 100% right but tests seem to back this.
> > hopefully Catalin and Will can correct me.
> >
> > >
> > > >
> > > > Performance of optprobe on Hip08 platform is test using kprobe
> > > > example module[1] to analyze the latency of a kernel function,
> > > > and here is the result:
> > > >
> > > > [1]
> > >
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sa
> > > mples/kprobes/kretprobe_example.c
> > > >
> > > > kprobe before optimized:
> > > > [280709.846380] do_empty returned 0 and took 1530 ns to execute
> > > > [280709.852057] do_empty returned 0 and took 550 ns to execute
> > > > [280709.857631] do_empty returned 0 and took 440 ns to execute
> > > > [280709.863215] do_empty returned 0 and took 380 ns to execute
> > > > [280709.868787] do_empty returned 0 and took 360 ns to execute
> > > > [280709.874362] do_empty returned 0 and took 340 ns to execute
> > > > [280709.879936] do_empty returned 0 and took 320 ns to execute
> > > > [280709.885505] do_empty returned 0 and took 300 ns to execute
> > > > [280709.891075] do_empty returned 0 and took 280 ns to execute
> > > > [280709.896646] do_empty returned 0 and took 290 ns to execute
> > > > [280709.902220] do_empty returned 0 and took 290 ns to execute
> > > > [280709.907807] do_empty returned 0 and took 290 ns to execute
> > > >
> > > > optprobe:
> > > > [ 2965.964572] do_empty returned 0 and took 90 ns to execute
> > > > [ 2965.969952] do_empty returned 0 and took 80 ns to execute
> > > > [ 2965.975332] do_empty returned 0 and took 70 ns to execute
> > > > [ 2965.980714] do_empty returned 0 and took 60 ns to execute
> > > > [ 2965.986128] do_empty returned 0 and took 80 ns to execute
> > > > [ 2965.991507] do_empty returned 0 and took 70 ns to execute
> > > > [ 2965.996884] do_empty returned 0 and took 70 ns to execute
> > > > [ 2966.002262] do_empty returned 0 and took 80 ns to execute
> > > > [ 2966.007642] do_empty returned 0 and took 70 ns to execute
> > > > [ 2966.013020] do_empty returned 0 and took 70 ns to execute
> > > > [ 2966.018400] do_empty returned 0 and took 70 ns to execute
> > > > [ 2966.023779] do_empty returned 0 and took 70 ns to execute
> > > > [ 2966.029158] do_empty returned 0 and took 70 ns to execute
> > >
> > > Great result!
> > > I have other comments on the code below.
> > >
> > > [...]
> > > > diff --git a/arch/arm64/kernel/probes/kprobes.c
> > > b/arch/arm64/kernel/probes/kprobes.c
> > > > index 6dbcc89f6662..83755ad62abe 100644
> > > > --- a/arch/arm64/kernel/probes/kprobes.c
> > > > +++ b/arch/arm64/kernel/probes/kprobes.c
> > > > @@ -11,6 +11,7 @@
> > > >  #include <linux/kasan.h>
> > > >  #include <linux/kernel.h>
> > > >  #include <linux/kprobes.h>
> > > > +#include <linux/moduleloader.h>
> > > >  #include <linux/sched/debug.h>
> > > >  #include <linux/set_memory.h>
> > > >  #include <linux/slab.h>
> > > > @@ -113,9 +114,21 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
> > > >
> > > >  void *alloc_insn_page(void)
> > > >  {
> > > > -	return __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START,
> VMALLOC_END,
> > > > -			GFP_KERNEL, PAGE_KERNEL_ROX, VM_FLUSH_RESET_PERMS,
> > > > -			NUMA_NO_NODE, __builtin_return_address(0));
> > > > +	void *page;
> > > > +
> > > > +	page = module_alloc(PAGE_SIZE);
> > > > +	if (!page)
> > > > +		return NULL;
> > > > +
> > > > +	set_vm_flush_reset_perms(page);
> > > > +	/*
> > > > +	 * First make the page read-only, and only then make it executable
> to
> > > > +	 * prevent it from being W+X in between.
> > > > +	 */
> > > > +	set_memory_ro((unsigned long)page, 1);
> > > > +	set_memory_x((unsigned long)page, 1);
> > > > +
> > > > +	return page;
> > >
> > > Isn't this a separated change? Or any reason why you have to
> > > change this function?
> >
> > As far as I can tell, this is still related with the 128MB
> > short jump limitation.
> > VMALLOC_START, VMALLOC_END is an fixed virtual address area
> > which isn't necessarily modules will be put.
> > So this patch is moving to module_alloc() which will get
> > memory between module_alloc_base and module_alloc_end.
> 
> Ah, I missed that point. Yes, VMALLOC_START and VMALLOC_END
> are not correct range.
> 
> >
> > Together with depending on !RANDOMIZE_MODULE_REGION_FULL,
> > this makes all kernel, module and trampoline in short
> > jmp area.
> >
> > As long as we can figure out a way to support long jmp
> > for optprobe, the change in alloc_insn_page() can be
> > dropped.
> 
> No, I think above change is rather readable, so it is OK.
> 
> >
> > Masami, any reference code from any platform to support long
> > jump for optprobe? For long jmp, we need to put jmp address
> > to a memory and then somehow load the target address
> > to PC. Right now, we are able to replace an instruction
> > only. That is the problem.
> 
> Hmm, I had read a paper about 2-stage jump idea 15years ago. That
> paper allocated an intermediate trampoline (like PLT) which did a long
> jump to the real trampoline on SPARC.
> (something like, "push x0; ldr x0, [pc+8]; br x0; <immediate-addr>" for
> a slot of the intermediate trampoline.)
> 
> For the other (simpler) solution example is optprobe in powerpc
> (arch/powerpc/kernel/optprobes_head.S). That reserves a buffer page
> in the text section, and use it.
> 
> But I think your current implementation is good enough for the
> first step. If someone needs CONFIG_RANDOMIZE_MODULE_REGION_FULL
> and optprobe, we can revisit this point.
> 
> Thank you,
> 
> 

Thanks
Barry


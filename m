Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107E83D220D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbhGVJoy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Jul 2021 05:44:54 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7414 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbhGVJoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:44:32 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GVpQ329mdz7y0K;
        Thu, 22 Jul 2021 18:21:15 +0800 (CST)
Received: from dggpemm000003.china.huawei.com (7.185.36.128) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Jul 2021 18:24:55 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggpemm000003.china.huawei.com (7.185.36.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 22 Jul 2021 18:24:55 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Thu, 22 Jul 2021 18:24:55 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        "liuqi (BA)" <liuqi115@huawei.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
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
Thread-Index: AQHXfJkyPamnf4yoyEqhBrLk7zE456tMmTOAgAIsGRA=
Date:   Thu, 22 Jul 2021 10:24:54 +0000
Message-ID: <332df5b7d7bb4bd096b6521ffefaabe6@hisilicon.com>
References: <20210719122417.10355-1-liuqi115@huawei.com>
 <20210721174153.34c1898dc9eea135eb0b8be8@kernel.org>
In-Reply-To: <20210721174153.34c1898dc9eea135eb0b8be8@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.151]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Masami Hiramatsu [mailto:mhiramat@kernel.org]
> Sent: Wednesday, July 21, 2021 8:42 PM
> To: liuqi (BA) <liuqi115@huawei.com>
> Cc: catalin.marinas@arm.com; will@kernel.org; naveen.n.rao@linux.ibm.com;
> anil.s.keshavamurthy@intel.com; davem@davemloft.net;
> linux-arm-kernel@lists.infradead.org; Song Bao Hua (Barry Song)
> <song.bao.hua@hisilicon.com>; Zengtao (B) <prime.zeng@hisilicon.com>;
> robin.murphy@arm.com; Linuxarm <linuxarm@huawei.com>;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] arm64: kprobe: Enable OPTPROBE for arm64
> 
> Hi Qi,
> 
> Thanks for your effort!
> 
> On Mon, 19 Jul 2021 20:24:17 +0800
> Qi Liu <liuqi115@huawei.com> wrote:
> 
> > This patch introduce optprobe for ARM64. In optprobe, probed
> > instruction is replaced by a branch instruction to detour
> > buffer. Detour buffer contains trampoline code and a call to
> > optimized_callback(). optimized_callback() calls opt_pre_handler()
> > to execute kprobe handler.
> 
> OK so this will replace only one instruction.
> 
> >
> > Limitations:
> > - We only support !CONFIG_RANDOMIZE_MODULE_REGION_FULL case to
> > guarantee the offset between probe point and kprobe pre_handler
> > is not larger than 128MiB.
> 
> Hmm, shouldn't we depends on !CONFIG_ARM64_MODULE_PLTS? Or,
> allocate an intermediate trampoline area similar to arm optprobe
> does.

Depending on !CONFIG_ARM64_MODULE_PLTS will totally disable
RANDOMIZE_BASE according to arch/arm64/Kconfig:
config RANDOMIZE_BASE
	bool "Randomize the address of the kernel image"
	select ARM64_MODULE_PLTS if MODULES
	select RELOCATABLE

Depending on !RANDOMIZE_MODULE_REGION_FULL seems to be still
allowing RANDOMIZE_BASE via avoiding long jump according to:
arch/arm64/Kconfig:

config RANDOMIZE_MODULE_REGION_FULL
	bool "Randomize the module region over a 4 GB range"
	depends on RANDOMIZE_BASE
	default y
	help
	  Randomizes the location of the module region inside a 4 GB window
	  covering the core kernel. This way, it is less likely for modules
	  to leak information about the location of core kernel data structures
	  but it does imply that function calls between modules and the core
	  kernel will need to be resolved via veneers in the module PLT.

	  When this option is not set, the module region will be randomized over
	  a limited range that contains the [_stext, _etext] interval of the
	  core kernel, so branch relocations are always in range.

and

arch/arm64/kernel/kaslr.c:
	if (IS_ENABLED(CONFIG_RANDOMIZE_MODULE_REGION_FULL)) {
		/*
		 * Randomize the module region over a 2 GB window covering the
		 * kernel. This reduces the risk of modules leaking information
		 * about the address of the kernel itself, but results in
		 * branches between modules and the core kernel that are
		 * resolved via PLTs. (Branches between modules will be
		 * resolved normally.)
		 */
		module_range = SZ_2G - (u64)(_end - _stext);
		module_alloc_base = max((u64)_end + offset - SZ_2G,
					(u64)MODULES_VADDR);
	} else {
		/*
		 * Randomize the module region by setting module_alloc_base to
		 * a PAGE_SIZE multiple in the range [_etext - MODULES_VSIZE,
		 * _stext) . This guarantees that the resulting region still
		 * covers [_stext, _etext], and that all relative branches can
		 * be resolved without veneers.
		 */
		module_range = MODULES_VSIZE - (u64)(_etext - _stext);
		module_alloc_base = (u64)_etext + offset - MODULES_VSIZE;
	}

So depending on ! ARM64_MODULE_PLTS seems to narrow the scenarios
while depending on ! RANDOMIZE_MODULE_REGION_FULL  permit more
machines to use optprobe.

I am not quite sure I am 100% right but tests seem to back this.
hopefully Catalin and Will can correct me.

> 
> >
> > Performance of optprobe on Hip08 platform is test using kprobe
> > example module[1] to analyze the latency of a kernel function,
> > and here is the result:
> >
> > [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sa
> mples/kprobes/kretprobe_example.c
> >
> > kprobe before optimized:
> > [280709.846380] do_empty returned 0 and took 1530 ns to execute
> > [280709.852057] do_empty returned 0 and took 550 ns to execute
> > [280709.857631] do_empty returned 0 and took 440 ns to execute
> > [280709.863215] do_empty returned 0 and took 380 ns to execute
> > [280709.868787] do_empty returned 0 and took 360 ns to execute
> > [280709.874362] do_empty returned 0 and took 340 ns to execute
> > [280709.879936] do_empty returned 0 and took 320 ns to execute
> > [280709.885505] do_empty returned 0 and took 300 ns to execute
> > [280709.891075] do_empty returned 0 and took 280 ns to execute
> > [280709.896646] do_empty returned 0 and took 290 ns to execute
> > [280709.902220] do_empty returned 0 and took 290 ns to execute
> > [280709.907807] do_empty returned 0 and took 290 ns to execute
> >
> > optprobe:
> > [ 2965.964572] do_empty returned 0 and took 90 ns to execute
> > [ 2965.969952] do_empty returned 0 and took 80 ns to execute
> > [ 2965.975332] do_empty returned 0 and took 70 ns to execute
> > [ 2965.980714] do_empty returned 0 and took 60 ns to execute
> > [ 2965.986128] do_empty returned 0 and took 80 ns to execute
> > [ 2965.991507] do_empty returned 0 and took 70 ns to execute
> > [ 2965.996884] do_empty returned 0 and took 70 ns to execute
> > [ 2966.002262] do_empty returned 0 and took 80 ns to execute
> > [ 2966.007642] do_empty returned 0 and took 70 ns to execute
> > [ 2966.013020] do_empty returned 0 and took 70 ns to execute
> > [ 2966.018400] do_empty returned 0 and took 70 ns to execute
> > [ 2966.023779] do_empty returned 0 and took 70 ns to execute
> > [ 2966.029158] do_empty returned 0 and took 70 ns to execute
> 
> Great result!
> I have other comments on the code below.
> 
> [...]
> > diff --git a/arch/arm64/kernel/probes/kprobes.c
> b/arch/arm64/kernel/probes/kprobes.c
> > index 6dbcc89f6662..83755ad62abe 100644
> > --- a/arch/arm64/kernel/probes/kprobes.c
> > +++ b/arch/arm64/kernel/probes/kprobes.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/kasan.h>
> >  #include <linux/kernel.h>
> >  #include <linux/kprobes.h>
> > +#include <linux/moduleloader.h>
> >  #include <linux/sched/debug.h>
> >  #include <linux/set_memory.h>
> >  #include <linux/slab.h>
> > @@ -113,9 +114,21 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
> >
> >  void *alloc_insn_page(void)
> >  {
> > -	return __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
> > -			GFP_KERNEL, PAGE_KERNEL_ROX, VM_FLUSH_RESET_PERMS,
> > -			NUMA_NO_NODE, __builtin_return_address(0));
> > +	void *page;
> > +
> > +	page = module_alloc(PAGE_SIZE);
> > +	if (!page)
> > +		return NULL;
> > +
> > +	set_vm_flush_reset_perms(page);
> > +	/*
> > +	 * First make the page read-only, and only then make it executable to
> > +	 * prevent it from being W+X in between.
> > +	 */
> > +	set_memory_ro((unsigned long)page, 1);
> > +	set_memory_x((unsigned long)page, 1);
> > +
> > +	return page;
> 
> Isn't this a separated change? Or any reason why you have to
> change this function?

As far as I can tell, this is still related with the 128MB
short jump limitation.
VMALLOC_START, VMALLOC_END is an fixed virtual address area
which isn't necessarily modules will be put.
So this patch is moving to module_alloc() which will get
memory between module_alloc_base and module_alloc_end.

Together with depending on !RANDOMIZE_MODULE_REGION_FULL,
this makes all kernel, module and trampoline in short
jmp area.

As long as we can figure out a way to support long jmp
for optprobe, the change in alloc_insn_page() can be
dropped.

Masami, any reference code from any platform to support long
jump for optprobe? For long jmp, we need to put jmp address
to a memory and then somehow load the target address
to PC. Right now, we are able to replace an instruction
only. That is the problem.

Thanks
Barry


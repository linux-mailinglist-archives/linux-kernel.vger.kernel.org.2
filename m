Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD1F3DC240
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 03:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbhGaBPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 21:15:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231337AbhGaBPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 21:15:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E021160F48;
        Sat, 31 Jul 2021 01:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627694140;
        bh=9y0Qu65MHqFLZYv8so/ADTZ+tGJuJhnl7xlEmxGbbU8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N6SFAHIvuK6ibPnAcOdL3WHE5asAJlqq+QU4p6LrfP7dZ4PkQEMzy2kqmkILnl9XA
         249Gs5OzmmQNZ/Z+K/slu0S5GE+tQdzO/s6+VjV93bQVxt1bK0JUNdaQV7VRCjP39x
         XLxM/tdSt0+Mr5xi1IZ4aVkDHPbN+0+SdyoAGIF3vHkOueDQQc64wH3zgf379kiYZ+
         nGajqDLpMw/hXxw8uFgBzRVgexq9T7Ba4Ib//RY/EEt0a5tt7V4c/KNdbPKMX4Mp0j
         ZzR+qH9Zr3OqmBO98quNnxURc/KAF4S2wkgTTw9vBGkMohPDSKmEv4+6xmGP2XW1s5
         pDV+9bc81VDNA==
Date:   Sat, 31 Jul 2021 10:15:37 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     "liuqi (BA)" <liuqi115@huawei.com>,
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
Subject: Re: [PATCH] arm64: kprobe: Enable OPTPROBE for arm64
Message-Id: <20210731101537.a64063d84e86d7910bd58a96@kernel.org>
In-Reply-To: <e63531dc8b7040219761e72fb9b1e74a@hisilicon.com>
References: <20210719122417.10355-1-liuqi115@huawei.com>
        <20210721174153.34c1898dc9eea135eb0b8be8@kernel.org>
        <332df5b7d7bb4bd096b6521ffefaabe6@hisilicon.com>
        <20210723000318.5594c86e7c454aed82d9465d@kernel.org>
        <e63531dc8b7040219761e72fb9b1e74a@hisilicon.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jul 2021 10:04:06 +0000
"Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com> wrote:

> > > > >
> > > > > Hi Qi,
> > > > >
> > > > > Thanks for your effort!
> > > > >
> > > > > On Mon, 19 Jul 2021 20:24:17 +0800
> > > > > Qi Liu <liuqi115@huawei.com> wrote:
> > > > >
> > > > > > This patch introduce optprobe for ARM64. In optprobe, probed
> > > > > > instruction is replaced by a branch instruction to detour
> > > > > > buffer. Detour buffer contains trampoline code and a call to
> > > > > > optimized_callback(). optimized_callback() calls opt_pre_handler()
> > > > > > to execute kprobe handler.
> > > > >
> > > > > OK so this will replace only one instruction.
> > > > >
> > > > > >
> > > > > > Limitations:
> > > > > > - We only support !CONFIG_RANDOMIZE_MODULE_REGION_FULL case to
> > > > > > guarantee the offset between probe point and kprobe pre_handler
> > > > > > is not larger than 128MiB.
> > > > >
> > > > > Hmm, shouldn't we depends on !CONFIG_ARM64_MODULE_PLTS? Or,
> > > > > allocate an intermediate trampoline area similar to arm optprobe
> > > > > does.
> > > >
> > > > Depending on !CONFIG_ARM64_MODULE_PLTS will totally disable
> > > > RANDOMIZE_BASE according to arch/arm64/Kconfig:
> > > > config RANDOMIZE_BASE
> > > > 	bool "Randomize the address of the kernel image"
> > > > 	select ARM64_MODULE_PLTS if MODULES
> > > > 	select RELOCATABLE
> > >
> > > Yes, but why it is required for "RANDOMIZE_BASE"?
> > > Does that imply the module call might need to use PLT in
> > > some cases?
> > >
> > > >
> > > > Depending on !RANDOMIZE_MODULE_REGION_FULL seems to be still
> > > > allowing RANDOMIZE_BASE via avoiding long jump according to:
> > > > arch/arm64/Kconfig:
> > > >
> > > > config RANDOMIZE_MODULE_REGION_FULL
> > > > 	bool "Randomize the module region over a 4 GB range"
> > > > 	depends on RANDOMIZE_BASE
> > > > 	default y
> > > > 	help
> > > > 	  Randomizes the location of the module region inside a 4 GB window
> > > > 	  covering the core kernel. This way, it is less likely for modules
> > > > 	  to leak information about the location of core kernel data structures
> > > > 	  but it does imply that function calls between modules and the core
> > > > 	  kernel will need to be resolved via veneers in the module PLT.
> > > >
> > > > 	  When this option is not set, the module region will be randomized over
> > > > 	  a limited range that contains the [_stext, _etext] interval of the
> > > > 	  core kernel, so branch relocations are always in range.
> > >
> > > Hmm, this dependency looks strange. If it always in range, don't we need
> > > PLT for modules?
> > >
> > > Cataline, would you know why?
> > > Maybe it's a KASLR's Kconfig issue?
> > 
> > I actually didn't see any problem after making this change:
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index e07e7de9ac49..6440671b72e0 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -1781,7 +1781,6 @@ config RELOCATABLE
> > 
> >  config RANDOMIZE_BASE
> >         bool "Randomize the address of the kernel image"
> > -       select ARM64_MODULE_PLTS if MODULES
> >         select RELOCATABLE
> >         help
> >           Randomizes the virtual address at which the kernel image is
> > @@ -1801,6 +1800,7 @@ config RANDOMIZE_BASE
> >  config RANDOMIZE_MODULE_REGION_FULL
> >         bool "Randomize the module region over a 4 GB range"
> >         depends on RANDOMIZE_BASE
> > +       select ARM64_MODULE_PLTS if MODULES
> >         default y
> >         help
> >           Randomizes the location of the module region inside a 4 GB window
> > 
> > and having this config:
> > # zcat /proc/config.gz | grep RANDOMIZE_BASE
> > CONFIG_RANDOMIZE_BASE=y
> > 
> > # zcat /proc/config.gz | grep RANDOMIZE_MODULE_REGION_FULL
> > # CONFIG_RANDOMIZE_MODULE_REGION_FULL is not set
> > 
> > # zcat /proc/config.gz | grep ARM64_MODULE_PLTS
> > # CONFIG_ARM64_MODULE_PLTS is not set
> > 
> > Modules work all good:
> > # lsmod
> > Module                  Size  Used by
> > btrfs                1355776  0
> > blake2b_generic        20480  0
> > libcrc32c              16384  1 btrfs
> > xor                    20480  1 btrfs
> > xor_neon               16384  1 xor
> > zstd_compress         163840  1 btrfs
> > raid6_pq              110592  1 btrfs
> > ctr                    16384  0
> > md5                    16384  0
> > ip_tunnel              32768  0
> > ipv6                  442368  28
> > 
> > 
> > I am not quite sure if there is a corner case. If no,
> > I would think the kconfig might be some improper.
> 
> The corner case is that even CONFIG_RANDOMIZE_MODULE_REGION_FULL
> is not enabled, but if CONFIG_ARM64_MODULE_PLTS is enabled, when
> we can't get memory from the 128MB area in case the area is exhausted,
> we will fall back in module_alloc() to a 2GB area as long as either
> of the below two conditions is met:
> 
> 1. KASAN is not enabled
> 2. KASAN is enabled and CONFIG_KASAN_VMALLOC is also enabled.
> 
> void *module_alloc(unsigned long size)
> {
> 	u64 module_alloc_end = module_alloc_base + MODULES_VSIZE;
> 	gfp_t gfp_mask = GFP_KERNEL;
> 	void *p;
> 
> 	/* Silence the initial allocation */
> 	if (IS_ENABLED(CONFIG_ARM64_MODULE_PLTS))
> 		gfp_mask |= __GFP_NOWARN;
> 
> 	if (IS_ENABLED(CONFIG_KASAN_GENERIC) ||
> 	    IS_ENABLED(CONFIG_KASAN_SW_TAGS))
> 		/* don't exceed the static module region - see below */
> 		module_alloc_end = MODULES_END;
> 
> 	p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
> 				module_alloc_end, gfp_mask, PAGE_KERNEL, 0,
> 				NUMA_NO_NODE, __builtin_return_address(0));
> 
> 	if (!p && IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) &&
> 	    (IS_ENABLED(CONFIG_KASAN_VMALLOC) ||
> 	     (!IS_ENABLED(CONFIG_KASAN_GENERIC) &&
> 	      !IS_ENABLED(CONFIG_KASAN_SW_TAGS))))
> 		/*
> 		 * KASAN without KASAN_VMALLOC can only deal with module
> 		 * allocations being served from the reserved module region,
> 		 * since the remainder of the vmalloc region is already
> 		 * backed by zero shadow pages, and punching holes into it
> 		 * is non-trivial. Since the module region is not randomized
> 		 * when KASAN is enabled without KASAN_VMALLOC, it is even
> 		 * less likely that the module region gets exhausted, so we
> 		 * can simply omit this fallback in that case.
> 		 */
> 		p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
> 				module_alloc_base + SZ_2G, GFP_KERNEL,
> 				PAGE_KERNEL, 0, NUMA_NO_NODE,
> 				__builtin_return_address(0));
> 
> 	if (p && (kasan_module_alloc(p, size) < 0)) {
> 		vfree(p);
> 		return NULL;
> 	}
> 
> 	return p;
> }
> 
> This should be happening quite rarely. But maybe arm64's document
> needs some minor fixup, otherwise, it is quite confusing.

OK, so CONFIG_KASAN_VLALLOC=y and CONFIG_ARM64_MODULE_PLTS=y, the module_alloc()
basically returns the memory in 128MB region, but can return the memory in 2GB
region. (This is OK because optprobe can filter it out)
But CONFIG_RANDOMIZE_MODULE_REGION_FULL=y, there is almost no chance to get
the memory in 128MB region.

Hmm, for the optprobe in kernel text, maybe we can define 'optinsn_alloc_start'
by 'module_alloc_base - (SZ_2G - MODULES_VADDR)' and use __vmalloc_node_range()
to avoid this issue. But that is only for the kernel. For the modules, we may
always out of 128MB region.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>

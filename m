Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1923DC5E9
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 14:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbhGaMVv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 31 Jul 2021 08:21:51 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:12435 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbhGaMVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 08:21:49 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GcNZp0lyPzcclC;
        Sat, 31 Jul 2021 20:18:10 +0800 (CST)
Received: from dggema708-chm.china.huawei.com (10.3.20.72) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 31 Jul 2021 20:21:40 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggema708-chm.china.huawei.com (10.3.20.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 31 Jul 2021 20:21:40 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Sat, 31 Jul 2021 20:21:40 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        "liuqi (BA)" <liuqi115@huawei.com>
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
Thread-Index: AQHXfJkyPamnf4yoyEqhBrLk7zE456tMmTOAgAIsGRD//9DNAIABRquggAt7BNCAAHwMgIABNwiA
Date:   Sat, 31 Jul 2021 12:21:40 +0000
Message-ID: <6a97dff6c33c4b84887223de2502bd3d@hisilicon.com>
References: <20210719122417.10355-1-liuqi115@huawei.com>
        <20210721174153.34c1898dc9eea135eb0b8be8@kernel.org>
        <332df5b7d7bb4bd096b6521ffefaabe6@hisilicon.com>
        <20210723000318.5594c86e7c454aed82d9465d@kernel.org>
        <e63531dc8b7040219761e72fb9b1e74a@hisilicon.com>
 <20210731101537.a64063d84e86d7910bd58a96@kernel.org>
In-Reply-To: <20210731101537.a64063d84e86d7910bd58a96@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Masami Hiramatsu [mailto:mhiramat@kernel.org]
> Sent: Saturday, July 31, 2021 1:16 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: liuqi (BA) <liuqi115@huawei.com>; catalin.marinas@arm.com;
> will@kernel.org; naveen.n.rao@linux.ibm.com; anil.s.keshavamurthy@intel.com;
> davem@davemloft.net; linux-arm-kernel@lists.infradead.org; Zengtao (B)
> <prime.zeng@hisilicon.com>; robin.murphy@arm.com; Linuxarm
> <linuxarm@huawei.com>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] arm64: kprobe: Enable OPTPROBE for arm64
> 
> On Fri, 30 Jul 2021 10:04:06 +0000
> "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com> wrote:
> 
> > > > > >
> > > > > > Hi Qi,
> > > > > >
> > > > > > Thanks for your effort!
> > > > > >
> > > > > > On Mon, 19 Jul 2021 20:24:17 +0800
> > > > > > Qi Liu <liuqi115@huawei.com> wrote:
> > > > > >
> > > > > > > This patch introduce optprobe for ARM64. In optprobe, probed
> > > > > > > instruction is replaced by a branch instruction to detour
> > > > > > > buffer. Detour buffer contains trampoline code and a call to
> > > > > > > optimized_callback(). optimized_callback() calls opt_pre_handler()
> > > > > > > to execute kprobe handler.
> > > > > >
> > > > > > OK so this will replace only one instruction.
> > > > > >
> > > > > > >
> > > > > > > Limitations:
> > > > > > > - We only support !CONFIG_RANDOMIZE_MODULE_REGION_FULL case to
> > > > > > > guarantee the offset between probe point and kprobe pre_handler
> > > > > > > is not larger than 128MiB.
> > > > > >
> > > > > > Hmm, shouldn't we depends on !CONFIG_ARM64_MODULE_PLTS? Or,
> > > > > > allocate an intermediate trampoline area similar to arm optprobe
> > > > > > does.
> > > > >
> > > > > Depending on !CONFIG_ARM64_MODULE_PLTS will totally disable
> > > > > RANDOMIZE_BASE according to arch/arm64/Kconfig:
> > > > > config RANDOMIZE_BASE
> > > > > 	bool "Randomize the address of the kernel image"
> > > > > 	select ARM64_MODULE_PLTS if MODULES
> > > > > 	select RELOCATABLE
> > > >
> > > > Yes, but why it is required for "RANDOMIZE_BASE"?
> > > > Does that imply the module call might need to use PLT in
> > > > some cases?
> > > >
> > > > >
> > > > > Depending on !RANDOMIZE_MODULE_REGION_FULL seems to be still
> > > > > allowing RANDOMIZE_BASE via avoiding long jump according to:
> > > > > arch/arm64/Kconfig:
> > > > >
> > > > > config RANDOMIZE_MODULE_REGION_FULL
> > > > > 	bool "Randomize the module region over a 4 GB range"
> > > > > 	depends on RANDOMIZE_BASE
> > > > > 	default y
> > > > > 	help
> > > > > 	  Randomizes the location of the module region inside a 4 GB window
> > > > > 	  covering the core kernel. This way, it is less likely for modules
> > > > > 	  to leak information about the location of core kernel data structures
> > > > > 	  but it does imply that function calls between modules and the core
> > > > > 	  kernel will need to be resolved via veneers in the module PLT.
> > > > >
> > > > > 	  When this option is not set, the module region will be randomized
> over
> > > > > 	  a limited range that contains the [_stext, _etext] interval of the
> > > > > 	  core kernel, so branch relocations are always in range.
> > > >
> > > > Hmm, this dependency looks strange. If it always in range, don't we need
> > > > PLT for modules?
> > > >
> > > > Cataline, would you know why?
> > > > Maybe it's a KASLR's Kconfig issue?
> > >
> > > I actually didn't see any problem after making this change:
> > >
> > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > index e07e7de9ac49..6440671b72e0 100644
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -1781,7 +1781,6 @@ config RELOCATABLE
> > >
> > >  config RANDOMIZE_BASE
> > >         bool "Randomize the address of the kernel image"
> > > -       select ARM64_MODULE_PLTS if MODULES
> > >         select RELOCATABLE
> > >         help
> > >           Randomizes the virtual address at which the kernel image is
> > > @@ -1801,6 +1800,7 @@ config RANDOMIZE_BASE
> > >  config RANDOMIZE_MODULE_REGION_FULL
> > >         bool "Randomize the module region over a 4 GB range"
> > >         depends on RANDOMIZE_BASE
> > > +       select ARM64_MODULE_PLTS if MODULES
> > >         default y
> > >         help
> > >           Randomizes the location of the module region inside a 4 GB window
> > >
> > > and having this config:
> > > # zcat /proc/config.gz | grep RANDOMIZE_BASE
> > > CONFIG_RANDOMIZE_BASE=y
> > >
> > > # zcat /proc/config.gz | grep RANDOMIZE_MODULE_REGION_FULL
> > > # CONFIG_RANDOMIZE_MODULE_REGION_FULL is not set
> > >
> > > # zcat /proc/config.gz | grep ARM64_MODULE_PLTS
> > > # CONFIG_ARM64_MODULE_PLTS is not set
> > >
> > > Modules work all good:
> > > # lsmod
> > > Module                  Size  Used by
> > > btrfs                1355776  0
> > > blake2b_generic        20480  0
> > > libcrc32c              16384  1 btrfs
> > > xor                    20480  1 btrfs
> > > xor_neon               16384  1 xor
> > > zstd_compress         163840  1 btrfs
> > > raid6_pq              110592  1 btrfs
> > > ctr                    16384  0
> > > md5                    16384  0
> > > ip_tunnel              32768  0
> > > ipv6                  442368  28
> > >
> > >
> > > I am not quite sure if there is a corner case. If no,
> > > I would think the kconfig might be some improper.
> >
> > The corner case is that even CONFIG_RANDOMIZE_MODULE_REGION_FULL
> > is not enabled, but if CONFIG_ARM64_MODULE_PLTS is enabled, when
> > we can't get memory from the 128MB area in case the area is exhausted,
> > we will fall back in module_alloc() to a 2GB area as long as either
> > of the below two conditions is met:
> >
> > 1. KASAN is not enabled
> > 2. KASAN is enabled and CONFIG_KASAN_VMALLOC is also enabled.
> >
> > void *module_alloc(unsigned long size)
> > {
> > 	u64 module_alloc_end = module_alloc_base + MODULES_VSIZE;
> > 	gfp_t gfp_mask = GFP_KERNEL;
> > 	void *p;
> >
> > 	/* Silence the initial allocation */
> > 	if (IS_ENABLED(CONFIG_ARM64_MODULE_PLTS))
> > 		gfp_mask |= __GFP_NOWARN;
> >
> > 	if (IS_ENABLED(CONFIG_KASAN_GENERIC) ||
> > 	    IS_ENABLED(CONFIG_KASAN_SW_TAGS))
> > 		/* don't exceed the static module region - see below */
> > 		module_alloc_end = MODULES_END;
> >
> > 	p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
> > 				module_alloc_end, gfp_mask, PAGE_KERNEL, 0,
> > 				NUMA_NO_NODE, __builtin_return_address(0));
> >
> > 	if (!p && IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) &&
> > 	    (IS_ENABLED(CONFIG_KASAN_VMALLOC) ||
> > 	     (!IS_ENABLED(CONFIG_KASAN_GENERIC) &&
> > 	      !IS_ENABLED(CONFIG_KASAN_SW_TAGS))))
> > 		/*
> > 		 * KASAN without KASAN_VMALLOC can only deal with module
> > 		 * allocations being served from the reserved module region,
> > 		 * since the remainder of the vmalloc region is already
> > 		 * backed by zero shadow pages, and punching holes into it
> > 		 * is non-trivial. Since the module region is not randomized
> > 		 * when KASAN is enabled without KASAN_VMALLOC, it is even
> > 		 * less likely that the module region gets exhausted, so we
> > 		 * can simply omit this fallback in that case.
> > 		 */
> > 		p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
> > 				module_alloc_base + SZ_2G, GFP_KERNEL,
> > 				PAGE_KERNEL, 0, NUMA_NO_NODE,
> > 				__builtin_return_address(0));
> >
> > 	if (p && (kasan_module_alloc(p, size) < 0)) {
> > 		vfree(p);
> > 		return NULL;
> > 	}
> >
> > 	return p;
> > }
> >
> > This should be happening quite rarely. But maybe arm64's document
> > needs some minor fixup, otherwise, it is quite confusing.
> 
> OK, so CONFIG_KASAN_VLALLOC=y and CONFIG_ARM64_MODULE_PLTS=y, the
> module_alloc()
> basically returns the memory in 128MB region, but can return the memory in 2GB
> region. (This is OK because optprobe can filter it out)
> But CONFIG_RANDOMIZE_MODULE_REGION_FULL=y, there is almost no chance to get
> the memory in 128MB region.
> 
> Hmm, for the optprobe in kernel text, maybe we can define 'optinsn_alloc_start'
> by 'module_alloc_base - (SZ_2G - MODULES_VADDR)' and use __vmalloc_node_range()
> to avoid this issue. But that is only for the kernel. For the modules, we may
> always out of 128MB region.

If we can have some separate PLT entries in each module for optprobe,
we should be able to short-jump to the PLT entry and then PLT entry
will further long-jump to detour out of the range. That is exactly
the duty of PLT.

Right now, arm64 has support on dynamic_ftrace by adding a
section in module for ftrace PLT.
arch/arm64/include/asm/module.lds.h:
SECTIONS {
#ifdef CONFIG_ARM64_MODULE_PLTS
	.plt 0 (NOLOAD) : { BYTE(0) }
	.init.plt 0 (NOLOAD) : { BYTE(0) }
	.text.ftrace_trampoline 0 (NOLOAD) : { BYTE(0) }
#endif
...
}

arch/arm64/kernel/module.c will initialize some PLT entries
for ftrace:

static int module_init_ftrace_plt(const Elf_Ehdr *hdr,
				  const Elf_Shdr *sechdrs,
				  struct module *mod)
{
#if defined(CONFIG_ARM64_MODULE_PLTS) && defined(CONFIG_DYNAMIC_FTRACE)
	const Elf_Shdr *s;
	struct plt_entry *plts;

	s = find_section(hdr, sechdrs, ".text.ftrace_trampoline");
	if (!s)
		return -ENOEXEC;

	plts = (void *)s->sh_addr;

	__init_plt(&plts[FTRACE_PLT_IDX], FTRACE_ADDR);

	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS))
		__init_plt(&plts[FTRACE_REGS_PLT_IDX], FTRACE_REGS_ADDR);

	mod->arch.ftrace_trampolines = plts;
#endif
	return 0;
}

Ftrace will then use those PLT entries in arch/arm64/kernel/ftrace.c:
static struct plt_entry *get_ftrace_plt(struct module *mod, unsigned long addr)
{
#ifdef CONFIG_ARM64_MODULE_PLTS
	struct plt_entry *plt = mod->arch.ftrace_trampolines;

	if (addr == FTRACE_ADDR)
		return &plt[FTRACE_PLT_IDX];
	if (addr == FTRACE_REGS_ADDR &&
	    IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS))
		return &plt[FTRACE_REGS_PLT_IDX];
#endif
	return NULL;
}

/*
 * Turn on the call to ftrace_caller() in instrumented function
 */
int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
{
	unsigned long pc = rec->ip;
	u32 old, new;
	long offset = (long)pc - (long)addr;

	if (offset < -SZ_128M || offset >= SZ_128M) {
		struct module *mod;
		struct plt_entry *plt;

		if (!IS_ENABLED(CONFIG_ARM64_MODULE_PLTS))
			return -EINVAL;

		/*
		 * On kernels that support module PLTs, the offset between the
		 * branch instruction and its target may legally exceed the
		 * range of an ordinary relative 'bl' opcode. In this case, we
		 * need to branch via a trampoline in the module.
		 *
		 * NOTE: __module_text_address() must be called with preemption
		 * disabled, but we can rely on ftrace_lock to ensure that 'mod'
		 * retains its validity throughout the remainder of this code.
		 */
		preempt_disable();
		mod = __module_text_address(pc);
		preempt_enable();

		if (WARN_ON(!mod))
			return -EINVAL;

		plt = get_ftrace_plt(mod, addr);
		if (!plt) {
			pr_err("ftrace: no module PLT for %ps\n", (void *)addr);
			return -EINVAL;
		}

		addr = (unsigned long)plt;
	}

	old = aarch64_insn_gen_nop();
	new = aarch64_insn_gen_branch_imm(pc, addr, AARCH64_INSN_BRANCH_LINK);

	return ftrace_modify_code(pc, old, new, true);
}

This might be the direction to go later. Anyway, "Rome wasn't built
in a day", for this stage, we might focus on optprobe for the case
of non-randomized module region :-). 

BTW, @liuqi, if users set "nokaslr" in bootargs, will your optprobe
always work and not fall back to normal kprobe even we remove the
dependency on RANDOMIZED_MODULE_REGION_FULL?

> 
> Thank you,
> 
> --
> Masami Hiramatsu <mhiramat@kernel.org>

Thanks
Barry

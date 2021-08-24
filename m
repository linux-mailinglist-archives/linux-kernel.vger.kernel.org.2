Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A8B3F5C5D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 12:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbhHXKvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 06:51:00 -0400
Received: from foss.arm.com ([217.140.110.172]:33778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236297AbhHXKuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:50:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13DF6101E;
        Tue, 24 Aug 2021 03:50:11 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.90.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5FBC3F66F;
        Tue, 24 Aug 2021 03:50:07 -0700 (PDT)
Date:   Tue, 24 Aug 2021 11:50:01 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org,
        linux-arm-kernel@lists.infradead.org, song.bao.hua@hisilicon.com,
        prime.zeng@hisilicon.com, robin.murphy@arm.com,
        f.fangjian@huawei.com, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] arm64: kprobe: Enable OPTPROBE for arm64
Message-ID: <20210824105001.GA96738@C02TD0UTHF1T.local>
References: <20210818073336.59678-1-liuqi115@huawei.com>
 <20210818073336.59678-3-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818073336.59678-3-liuqi115@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a bunch of comments below.

At a high-level, I'm not all that keen on adding yet another set of
trampolines, especially given we have constraints on how we can branch
to them which render this not that useful in common configurations (e.g.
where KASLR and module randomization is enabled).

So importantly, do we actually need this? I don't think the sampel is
that compelling since we can already use ftrace to measure function
latencies.

If we do need this, I think we need to do some more substantial rework
to address those branch range limitations. I know that we could permit
arbitrary branching if we expand the ftrace-with-regs callsites to ~6
instructions, but that interacts rather poorly with stacktracing and
will make the kernel a bit bigger.

On Wed, Aug 18, 2021 at 03:33:36PM +0800, Qi Liu wrote:
> This patch introduce optprobe for ARM64. In optprobe, probed
> instruction is replaced by a branch instruction to detour
> buffer. Detour buffer contains trampoline code and a call to
> optimized_callback(). optimized_callback() calls opt_pre_handler()
> to execute kprobe handler.
> 
> Performance of optprobe on Hip08 platform is test using kprobe
> example module[1] to analyze the latency of a kernel function,
> and here is the result:
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/kprobes/kretprobe_example.c
> 
> kprobe before optimized:
> [280709.846380] do_empty returned 0 and took 1530 ns to execute
> [280709.852057] do_empty returned 0 and took 550 ns to execute
> [280709.857631] do_empty returned 0 and took 440 ns to execute
> [280709.863215] do_empty returned 0 and took 380 ns to execute
> [280709.868787] do_empty returned 0 and took 360 ns to execute
> [280709.874362] do_empty returned 0 and took 340 ns to execute
> [280709.879936] do_empty returned 0 and took 320 ns to execute
> [280709.885505] do_empty returned 0 and took 300 ns to execute
> [280709.891075] do_empty returned 0 and took 280 ns to execute
> [280709.896646] do_empty returned 0 and took 290 ns to execute
> [280709.902220] do_empty returned 0 and took 290 ns to execute
> [280709.907807] do_empty returned 0 and took 290 ns to execute
> 
> optprobe:
> [ 2965.964572] do_empty returned 0 and took 90 ns to execute
> [ 2965.969952] do_empty returned 0 and took 80 ns to execute
> [ 2965.975332] do_empty returned 0 and took 70 ns to execute
> [ 2965.980714] do_empty returned 0 and took 60 ns to execute
> [ 2965.986128] do_empty returned 0 and took 80 ns to execute
> [ 2965.991507] do_empty returned 0 and took 70 ns to execute
> [ 2965.996884] do_empty returned 0 and took 70 ns to execute
> [ 2966.002262] do_empty returned 0 and took 80 ns to execute
> [ 2966.007642] do_empty returned 0 and took 70 ns to execute
> [ 2966.013020] do_empty returned 0 and took 70 ns to execute
> [ 2966.018400] do_empty returned 0 and took 70 ns to execute
> [ 2966.023779] do_empty returned 0 and took 70 ns to execute
> [ 2966.029158] do_empty returned 0 and took 70 ns to execute

Do we have any examples of where this latency matters in practice?

> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> 
> Note:
> To guarantee the offset between probe point and kprobe pre_handler
> is smaller than 128MiB, users should set
> CONFIG_RANDOMIZE_MODULE_REGION_FULL=N or set nokaslr in command line, or
> optprobe will not work and fall back to normal kprobe.

Hmm... I don't think that's something we want to recommend, and
certainly distros *should* use KASLR and
CONFIG_RANDOMIZE_MODULE_REGION_FULL.

What happens with defconfig? Do we always get the fallback behaviour?

> ---
>  arch/arm64/Kconfig                            |   1 +
>  arch/arm64/include/asm/kprobes.h              |  24 ++
>  arch/arm64/kernel/probes/Makefile             |   2 +
>  arch/arm64/kernel/probes/kprobes.c            |  19 +-
>  arch/arm64/kernel/probes/opt_arm64.c          | 276 ++++++++++++++++++
>  .../arm64/kernel/probes/optprobe_trampoline.S |  37 +++
>  6 files changed, 356 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm64/kernel/probes/opt_arm64.c
>  create mode 100644 arch/arm64/kernel/probes/optprobe_trampoline.S
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b5b13a932561..b05d1d275d87 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -200,6 +200,7 @@ config ARM64
>  	select HAVE_STACKPROTECTOR
>  	select HAVE_SYSCALL_TRACEPOINTS
>  	select HAVE_KPROBES
> +	select HAVE_OPTPROBES
>  	select HAVE_KRETPROBES
>  	select HAVE_GENERIC_VDSO
>  	select IOMMU_DMA if IOMMU_SUPPORT
> diff --git a/arch/arm64/include/asm/kprobes.h b/arch/arm64/include/asm/kprobes.h
> index 5d38ff4a4806..6b2fdd2ad7d8 100644
> --- a/arch/arm64/include/asm/kprobes.h
> +++ b/arch/arm64/include/asm/kprobes.h
> @@ -39,6 +39,30 @@ void arch_remove_kprobe(struct kprobe *);
>  int kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr);
>  int kprobe_exceptions_notify(struct notifier_block *self,
>  			     unsigned long val, void *data);
> +
> +#define RELATIVEJUMP_SIZE (4)
> +#define MAX_COPIED_INSN	DIV_ROUND_UP(RELATIVEJUMP_SIZE, sizeof(kprobe_opcode_t))

On arm64, instructions are always 4 bytes, so this can be:

| #define MAX_COPIED_INSN		AARCH64_INSN_SIZE

Note: AARCH64_INSN_SIZE == sizeof(kprobe_opcode_t), so either could be
used here.

> +struct arch_optimized_insn {
> +	kprobe_opcode_t copied_insn[MAX_COPIED_INSN];

This is always a single insn. For clarity, it would be nicer to call
this something like `orig_insn`.

> +	/* detour code buffer */
> +	kprobe_opcode_t *insn;

Could we call this `trampoline`?

> +};
> +
> +/* optinsn template addresses */
> +extern __visible kprobe_opcode_t optprobe_template_entry[];
> +extern __visible kprobe_opcode_t optprobe_template_val[];
> +extern __visible kprobe_opcode_t optprobe_template_call[];
> +extern __visible kprobe_opcode_t optprobe_template_end[];
> +extern __visible kprobe_opcode_t optprobe_template_restore_begin[];
> +extern __visible kprobe_opcode_t optprobe_template_restore_orig_insn[];
> +extern __visible kprobe_opcode_t optprobe_template_restore_end[];
> +extern __visible kprobe_opcode_t optprobe_template_max_length[];

Why is this called "max_length"? It's the end of the template, value
included. Other architectures (e.g. arm) include that between
optprobe_template_entry and optprobe_template_end, so I don't believe we
need to separate that out.

> +
> +#define MAX_OPTIMIZED_LENGTH	4

As above, please define this as either AARCH64_INSN_SIZE or
sizeof(kprobe_opcode_t).

> +#define MAX_OPTINSN_SIZE				\
> +	((unsigned long)optprobe_template_end -	\
> +	 (unsigned long)optprobe_template_entry)

As above, this seems to be the trampoline size minus the size of the
value, which doesn't match other architectures, and doesn't seem right.
The kprobe core code has:

| kprobe_optinsn_slots.insn_size = MAX_OPTINSN_SIZE;

... which IIUC is used to alocate the buffers, so surely we *must* take
the size of the value into account?

> +
>  void kretprobe_trampoline(void);
>  void __kprobes *trampoline_probe_handler(struct pt_regs *regs);
>  
> diff --git a/arch/arm64/kernel/probes/Makefile b/arch/arm64/kernel/probes/Makefile
> index 8e4be92e25b1..07105fd3261d 100644
> --- a/arch/arm64/kernel/probes/Makefile
> +++ b/arch/arm64/kernel/probes/Makefile
> @@ -4,3 +4,5 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o	\
>  				   simulate-insn.o
>  obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o	\
>  				   simulate-insn.o
> +obj-$(CONFIG_OPTPROBES)		+= opt_arm64.o			\
> +				   optprobe_trampoline.o
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index 6dbcc89f6662..83755ad62abe 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -11,6 +11,7 @@
>  #include <linux/kasan.h>
>  #include <linux/kernel.h>
>  #include <linux/kprobes.h>
> +#include <linux/moduleloader.h>
>  #include <linux/sched/debug.h>
>  #include <linux/set_memory.h>
>  #include <linux/slab.h>
> @@ -113,9 +114,21 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  
>  void *alloc_insn_page(void)
>  {
> -	return __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
> -			GFP_KERNEL, PAGE_KERNEL_ROX, VM_FLUSH_RESET_PERMS,
> -			NUMA_NO_NODE, __builtin_return_address(0));
> +	void *page;
> +
> +	page = module_alloc(PAGE_SIZE);
> +	if (!page)
> +		return NULL;
> +
> +	set_vm_flush_reset_perms(page);
> +	/*
> +	 * First make the page read-only, and only then make it executable to
> +	 * prevent it from being W+X in between.
> +	 */
> +	set_memory_ro((unsigned long)page, 1);
> +	set_memory_x((unsigned long)page, 1);
> +
> +	return page;
>  }

Today this is only used for xol pages, which don't need to live in the
module space. Why is this not a separate function?

>  /* arm kprobe: install breakpoint in text */
> diff --git a/arch/arm64/kernel/probes/opt_arm64.c b/arch/arm64/kernel/probes/opt_arm64.c
> new file mode 100644
> index 000000000000..4de535bee534
> --- /dev/null
> +++ b/arch/arm64/kernel/probes/opt_arm64.c
> @@ -0,0 +1,276 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Code for Kernel probes Jump optimization.
> + *
> + * Copyright (C) 2021 Hisilicon Limited
> + */
> +
> +#include <linux/jump_label.h>
> +#include <linux/kprobes.h>
> +
> +#include <asm/cacheflush.h>
> +#include <asm/insn.h>
> +#include <asm/kprobes.h>
> +#include <asm/patching.h>
> +
> +#define TMPL_VAL_IDX \
> +	(optprobe_template_val - optprobe_template_entry)
> +#define TMPL_CALL_BACK \
> +	(optprobe_template_call - optprobe_template_entry)
> +#define TMPL_END_IDX \
> +	(optprobe_template_end - optprobe_template_entry)
> +#define TMPL_RESTORE_ORIGN_INSN \
> +	(optprobe_template_restore_orig_insn - optprobe_template_entry)
> +#define TMPL_RESTORE_END \
> +	(optprobe_template_restore_end - optprobe_template_entry)
> +#define TMPL_MAX_LENGTH \
> +	(optprobe_template_max_length - optprobe_template_entry)
> +#define OPTPROBE_BATCH_SIZE 64

What is batch size, and why is it 64?

> +
> +int arch_check_optimized_kprobe(struct optimized_kprobe *op)
> +{
> +	return 0;
> +}
> +

The core code has the comment:

|	/* Check there is no other kprobes at the optimized instructions */
|	if (arch_check_optimized_kprobe(op) < 0) 
|		return;

... is that comment misleading, or do we need to do something here?

> +int arch_prepared_optinsn(struct arch_optimized_insn *optinsn)
> +{
> +	return optinsn->insn != NULL;
> +}
> +
> +int arch_within_optimized_kprobe(struct optimized_kprobe *op,
> +				unsigned long addr)
> +{
> +	return ((unsigned long)op->kp.addr <= addr &&
> +		(unsigned long)op->kp.addr + RELATIVEJUMP_SIZE > addr);
> +}

Since we have a single instruction, and all instructions are naturally aligned 4 bytes, this can be:

|	return (unsigned long)op->kp.addr == addr;

> +
> +static void
> +optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs)
> +{
> +	/* This is possible if op is under delayed unoptimizing */

I see this is a copy-paste from x86 andor powerpc, but it's a bit hard
to understand, and I'm not sure what it is trying to say. What scenario
is this trying to handle?

I note that arch/arm doesn't seem to do this -- is that a bug?

> +	if (kprobe_disabled(&op->kp))
> +		return;
> +
> +	preempt_disable();
> +
> +	if (kprobe_running()) {
> +		kprobes_inc_nmissed_count(&op->kp);
> +	} else {
> +		__this_cpu_write(current_kprobe, &op->kp);
> +		regs->pc = (unsigned long)op->kp.addr;
> +		get_kprobe_ctlblk()->kprobe_status = KPROBE_HIT_ACTIVE;
> +		opt_pre_handler(&op->kp, regs);
> +		__this_cpu_write(current_kprobe, NULL);
> +	}


The body of this looks like it could be factored out in to the core
kprobes code if we had an arch hook to save any missed registers
(apparently just the pc on arm64).

> +	preempt_enable_no_resched();

Why the `_no_resched` variant? I see that x86 just does a plain
preempt_enable().

> +}
> +NOKPROBE_SYMBOL(optimized_callback)
> +
> +static bool is_offset_in_range(unsigned long start, unsigned long end)
> +{
> +	long offset = end - start;
> +
> +	/*
> +	 * Verify if the address gap is in 128MiB range, because this uses
> +	 * a relative jump.
> +	 *
> +	 * kprobe opt use a 'b' instruction to branch to optinsn.insn.
> +	 * According to ARM manual, branch instruction is:
> +	 *
> +	 *   31  30                  25              0
> +	 *  +----+---+---+---+---+---+---------------+
> +	 *  |cond| 0 | 0 | 1 | 0 | 1 |     imm26     |
> +	 *  +----+---+---+---+---+---+---------------+
> +	 *
> +	 * imm26 is a signed 26 bits integer. The real branch offset is computed
> +	 * by: imm64 = SignExtend(imm26:'00', 64);
> +	 *
> +	 * So the maximum forward branch should be:
> +	 *   (0x01ffffff << 2) = 0x07fffffc
> +	 * The maximum backward branch should be:
> +	 *   (0xfe000000 << 2) = 0xFFFFFFFFF8000000 = -0x08000000
> +	 *
> +	 * We can simply check (rel & 0xf8000003):
> +	 *  if rel is positive, (rel & 0xf8000003) should be 0
> +	 *  if rel is negitive, (rel & 0xf8000003) should be 0xf8000000
> +	 *  the last '3' is used for alignment checking.
> +	 */
> +	return (offset >= -0x8000000 && offset <= 0x7fffffc && !(offset & 0x3));
> +}

Please re-use existing code for this. In insn.c we already have
branch_imm_common() and aarch64_insn_gen_branch_imm(), which we should
be able to refactor for easier usage (and should move ftrace_make_nop()
over to that too).

We could *also* add a aarch64_insn_try_gen_branch_imm() helper that
returns an error code rather than printing an error, which would allow
us to consolidate the checks with the codegen, and would be more robust
if this changes in future.

> +
> +int arch_prepare_optimized_kprobe(struct optimized_kprobe *op,
> +				  struct kprobe *orig)
> +{
> +	kprobe_opcode_t *code, *buf;
> +	void **addrs;
> +	u32 insn;
> +	int ret, i;
> +
> +	addrs = kcalloc(TMPL_MAX_LENGTH, sizeof(void *), GFP_KERNEL);
> +	if (!addrs)
> +		return -ENOMEM;

As a general thing, when using allocators, please use sizeof() on the
pointer being allocated, e.g.

	addrs = kcalloc(TMPL_MAX_LENGTH, sizeof(*addrs), GFP_KERNEL);

... as that ensures the type is always correct, even if the type of the
pointer is changed later.

That said, I don't believe this needs to be allocated from the heap.
It's only used for the duration of this function, it's relatively small,
and we could add a wrapper in insn.c to patch a range of instructions,
which would avoid the need for the array entirely.

> +
> +	buf = kcalloc(TMPL_MAX_LENGTH, sizeof(kprobe_opcode_t), GFP_KERNEL);
> +	if (!buf) {
> +		kfree(addrs);
> +		return -ENOMEM;
> +	}
> +
> +	code = get_optinsn_slot();
> +	if (!code) {
> +		kfree(addrs);
> +		kfree(buf);
> +		return -ENOMEM;
> +	}

You can initialize `ret` to -ENOMEM, and goto `out` here.

> +
> +	if (!is_offset_in_range((unsigned long)code,
> +				(unsigned long)orig->addr + 8)) {
> +		ret = -ERANGE;
> +		goto error;
> +	}
> +
> +	if (!is_offset_in_range((unsigned long)code + TMPL_CALL_BACK,
> +				(unsigned long)optimized_callback)) {
> +		ret = -ERANGE;
> +		goto error;
> +	}
> +
> +	if (!is_offset_in_range((unsigned long)&code[TMPL_RESTORE_END],
> +				(unsigned long)op->kp.addr + 4)) {
> +		ret = -ERANGE;
> +		goto error;
> +	}
> +
> +	memcpy(buf, optprobe_template_entry,
> +	       TMPL_END_IDX * sizeof(kprobe_opcode_t));

Why do we need to copy this into a temporary buffer? Can't we work on it
directly in the destination?

> +
> +	buf[TMPL_VAL_IDX] = FIELD_GET(GENMASK(31, 0), (unsigned long long)op);
> +	buf[TMPL_VAL_IDX + 1] =
> +		FIELD_GET(GENMASK(63, 32), (unsigned long long)op);

This is a 64-bit pointer, and needs to be treated as a single unit. The
above is broken for big-endian kernels.

Rather than using instruction indices (and pretending this pointer is
two instructions), it would be nicer to use byte offsets consistently.

> +	buf[TMPL_RESTORE_ORIGN_INSN] = orig->opcode;
> +
> +	insn = aarch64_insn_gen_branch_imm(
> +		(unsigned long)(&code[TMPL_CALL_BACK]),
> +		(unsigned long)optimized_callback, AARCH64_INSN_BRANCH_LINK);
> +	buf[TMPL_CALL_BACK] = insn;
> +
> +	insn = aarch64_insn_gen_branch_imm(
> +		(unsigned long)(&code[TMPL_RESTORE_END]),
> +		(unsigned long)(op->kp.addr) + 4, AARCH64_INSN_BRANCH_NOLINK);
> +	buf[TMPL_RESTORE_END] = insn;
> +
> +	/* Setup template */
> +	for (i = 0; i < TMPL_MAX_LENGTH; i++)
> +		addrs[i] = code + i;
> +
> +	ret = aarch64_insn_patch_text(addrs, buf, TMPL_MAX_LENGTH);
> +	if (ret < 0)
> +		goto error;

This does a stop_machine(), which isn't strictly necessary here if we
write the buffer *then* swing the direct branch.

> +
> +	flush_icache_range((unsigned long)code,
> +			   (unsigned long)(&code[TMPL_END_IDX]));
> +
> +	/* Set op->optinsn.insn means prepared. */
> +	op->optinsn.insn = code;
> +
> +out:
> +	kfree(addrs);
> +	kfree(buf);
> +	return ret;
> +
> +error:
> +	free_optinsn_slot(code, 0);
> +	goto out;
> +}
> +
> +void arch_optimize_kprobes(struct list_head *oplist)
> +{
> +	struct optimized_kprobe *op, *tmp;
> +	kprobe_opcode_t *insns;
> +	void **addrs;
> +	int i = 0;
> +
> +	addrs = kcalloc(OPTPROBE_BATCH_SIZE, sizeof(void *), GFP_KERNEL);
> +	if (!addrs)
> +		return;
> +
> +	insns = kcalloc(OPTPROBE_BATCH_SIZE, sizeof(kprobe_opcode_t), GFP_KERNEL);
> +	if (!insns) {
> +		kfree(addrs);
> +		return;
> +	}

Why do these need to be dynamically allocated? They have small fixed
sizes.

> +
> +	list_for_each_entry_safe(op, tmp, oplist, list) {
> +		WARN_ON(kprobe_disabled(&op->kp));
> +
> +		/*
> +		 * Backup instructions which will be replaced
> +		 * by jump address
> +		 */
> +		memcpy(op->optinsn.copied_insn, op->kp.addr,
> +			RELATIVEJUMP_SIZE);

Hmmm... how does this end up getting restored? This hasn't been through
an le32_to_cpu(), so if we patch it back with the usual insn functions
we'll restore the wrong thing on a big-endian kernel.

> +		addrs[i] = (void *)op->kp.addr;
> +		insns[i] = aarch64_insn_gen_branch_imm((unsigned long)op->kp.addr,
> +				(unsigned long)op->optinsn.insn,
> +				AARCH64_INSN_BRANCH_NOLINK);
> +
> +		list_del_init(&op->list);
> +		if (++i == OPTPROBE_BATCH_SIZE)
> +			break;
> +	}

What happens if the list was bigger than OPTPROBE_BATCH_SIZE?

> +
> +	aarch64_insn_patch_text(addrs, insns, i);
> +	kfree(addrs);
> +	kfree(insns);
> +}
> +
> +void arch_unoptimize_kprobe(struct optimized_kprobe *op)
> +{
> +	arch_arm_kprobe(&op->kp);
> +}
> +
> +/*
> + * Recover original instructions and breakpoints from relative jumps.
> + * Caller must call with locking kprobe_mutex.
> + */
> +void arch_unoptimize_kprobes(struct list_head *oplist,
> +			    struct list_head *done_list)
> +{
> +	struct optimized_kprobe *op, *tmp;
> +	kprobe_opcode_t *insns;
> +	void **addrs;
> +	int i = 0;
> +
> +	addrs = kcalloc(OPTPROBE_BATCH_SIZE, sizeof(void *), GFP_KERNEL);
> +	if (!addrs)
> +		return;
> +
> +	insns = kcalloc(OPTPROBE_BATCH_SIZE, sizeof(kprobe_opcode_t), GFP_KERNEL);
> +	if (!insns) {
> +		kfree(addrs);
> +		return;
> +	}

Again, I do not think these need to be dynamically allocated.

> +
> +	list_for_each_entry_safe(op, tmp, oplist, list) {
> +		addrs[i] = (void *)op->kp.addr;
> +		insns[i] = BRK64_OPCODE_KPROBES;
> +		list_move(&op->list, done_list);
> +
> +		if (++i == OPTPROBE_BATCH_SIZE)
> +			break;

What happens if the list was larger rthan OPTPROBE_BATCH_SIZE ?

> +	}
> +
> +	aarch64_insn_patch_text(addrs, insns, i);
> +	kfree(addrs);
> +	kfree(insns);
> +}
> +
> +void arch_remove_optimized_kprobe(struct optimized_kprobe *op)
> +{
> +	if (op->optinsn.insn) {
> +		free_optinsn_slot(op->optinsn.insn, 1);
> +		op->optinsn.insn = NULL;
> +	}
> +}
> diff --git a/arch/arm64/kernel/probes/optprobe_trampoline.S b/arch/arm64/kernel/probes/optprobe_trampoline.S
> new file mode 100644
> index 000000000000..24d713d400cd
> --- /dev/null
> +++ b/arch/arm64/kernel/probes/optprobe_trampoline.S
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * trampoline entry and return code for optprobes.
> + */
> +
> +#include <linux/linkage.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/assembler.h>
> +
> +	.global optprobe_template_entry
> +optprobe_template_entry:

Please use SYM_*(); see arch/arm64/kernel/entry-ftrace.S for examples of
how to use that for trampolines.

This should be:

SYM_CODE_START(optprobe_template)

... and note the matching end below.

> +	sub sp, sp, #PT_REGS_SIZE
> +	save_all_base_regs
> +	/* Get parameters to optimized_callback() */
> +	ldr	x0, 1f
> +	mov	x1, sp
> +	/* Branch to optimized_callback() */
> +	.global optprobe_template_call
> +optprobe_template_call:

SYM_INNER_LABEL(optprobe_template_call, SYM_L_GLOBAL)

...and likewise for all the other labels.

> +	nop
> +	restore_all_base_regs
> +	ldr lr, [sp, #S_LR]
> +        add sp, sp, #PT_REGS_SIZE
> +	.global optprobe_template_restore_orig_insn
> +optprobe_template_restore_orig_insn:
> +	nop
> +	.global optprobe_template_restore_end
> +optprobe_template_restore_end:
> +	nop
> +	.global optprobe_template_end
> +optprobe_template_end:
> +	.global optprobe_template_val
> +optprobe_template_val:
> +	1:	.long 0
> +		.long 0
> +	.global optprobe_template_max_length
> +optprobe_template_max_length:

SYM_INNER_LABEL(optprobe_template_end, SYM_L_GLOBAL)
SYM_CODE_END(optprobe_template)

Thanks,
Mark.

> -- 
> 2.17.1
> 

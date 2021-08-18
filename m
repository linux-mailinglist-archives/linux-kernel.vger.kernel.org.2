Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C479C3F0918
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 18:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhHRQ2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 12:28:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229780AbhHRQ2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 12:28:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 973DA610A3;
        Wed, 18 Aug 2021 16:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629304082;
        bh=RF3L8YD4OYNwwqtgTYnKJK056xj3wKi2xHkY8zncXbQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CBa9IZcnee900lXfnI9JbwsihYPK2ump9p3SXN4ELM7qwFVCvRbvjK7XdO6waEj2z
         QrJhdrxEkem+O+PKIS+7fTfYHg1ZOB4A9i9WO5MMHVvq32zZH+1gbPZqm1smeU1WDF
         GI7IQTPTOQCm6/+cRXJ+JVIom4LBRBkZwYC9MXRfAfyZf0oIa1MrnOnje5Mj9otsKK
         t/UAZdZ08xem58MyLpNrcqB4yhcHvTfwTr89Twaf9AA9KX1S4cpZ75SiCWHkHaNKP4
         4xkUhfSayUOFGvsMP7XwzvplPlmVZZzyr/OVDnt6rzUF5UX/SxkP7HS0b9XYQL1Gax
         d1bRBY3QO8CVw==
Date:   Thu, 19 Aug 2021 01:27:57 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <linux-arm-kernel@lists.infradead.org>,
        <song.bao.hua@hisilicon.com>, <prime.zeng@hisilicon.com>,
        <robin.murphy@arm.com>, <f.fangjian@huawei.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] arm64: kprobe: Enable OPTPROBE for arm64
Message-Id: <20210819012757.bf08d4c601cca4d401d5803f@kernel.org>
In-Reply-To: <20210818073336.59678-3-liuqi115@huawei.com>
References: <20210818073336.59678-1-liuqi115@huawei.com>
        <20210818073336.59678-3-liuqi115@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2021 15:33:36 +0800
Qi Liu <liuqi115@huawei.com> wrote:

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
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>

Thanks for updating. This looks good to me. :D

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> Note:
> To guarantee the offset between probe point and kprobe pre_handler
> is smaller than 128MiB, users should set
> CONFIG_RANDOMIZE_MODULE_REGION_FULL=N or set nokaslr in command line, or
> optprobe will not work and fall back to normal kprobe.
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
> +struct arch_optimized_insn {
> +	kprobe_opcode_t copied_insn[MAX_COPIED_INSN];
> +	/* detour code buffer */
> +	kprobe_opcode_t *insn;
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
> +
> +#define MAX_OPTIMIZED_LENGTH	4
> +#define MAX_OPTINSN_SIZE				\
> +	((unsigned long)optprobe_template_end -	\
> +	 (unsigned long)optprobe_template_entry)
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
>  
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
> +
> +int arch_check_optimized_kprobe(struct optimized_kprobe *op)
> +{
> +	return 0;
> +}
> +
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
> +
> +static void
> +optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs)
> +{
> +	/* This is possible if op is under delayed unoptimizing */
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
> +
> +	preempt_enable_no_resched();
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
> +
> +	buf[TMPL_VAL_IDX] = FIELD_GET(GENMASK(31, 0), (unsigned long long)op);
> +	buf[TMPL_VAL_IDX + 1] =
> +		FIELD_GET(GENMASK(63, 32), (unsigned long long)op);
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
> +
> +		addrs[i] = (void *)op->kp.addr;
> +		insns[i] = aarch64_insn_gen_branch_imm((unsigned long)op->kp.addr,
> +				(unsigned long)op->optinsn.insn,
> +				AARCH64_INSN_BRANCH_NOLINK);
> +
> +		list_del_init(&op->list);
> +		if (++i == OPTPROBE_BATCH_SIZE)
> +			break;
> +	}
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
> +
> +	list_for_each_entry_safe(op, tmp, oplist, list) {
> +		addrs[i] = (void *)op->kp.addr;
> +		insns[i] = BRK64_OPCODE_KPROBES;
> +		list_move(&op->list, done_list);
> +
> +		if (++i == OPTPROBE_BATCH_SIZE)
> +			break;
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
> +	sub sp, sp, #PT_REGS_SIZE
> +	save_all_base_regs
> +	/* Get parameters to optimized_callback() */
> +	ldr	x0, 1f
> +	mov	x1, sp
> +	/* Branch to optimized_callback() */
> +	.global optprobe_template_call
> +optprobe_template_call:
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
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

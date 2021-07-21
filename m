Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEEA3D0B1C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 11:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbhGUISX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 04:18:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:51054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234204AbhGUIBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 04:01:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C6CC6101E;
        Wed, 21 Jul 2021 08:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626856917;
        bh=ovW7JYKcii5CsXjPAsAUoCvS36ErsVJmyVkcSFJGnMI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A4G20L0DrxKiVVCdpbXqdOa7dRG/Hc7iEsjGggD8KRomUpHNhJO6H+iC0F/2QFw+x
         ekOEiBjX4J6ejd/4WQQ231NW5jTAlQ42OlsKrkcMqez6tds4yL+W5D333tmi6TTBgc
         1F3VIfEtUdNvAmV3l+/XZGBZJ7DgJ2IVvyb3QdtU4NYxgdBNg0bWNVfHsEHGubjEts
         xihaSEcbZ2UR0P0Ewqqef3fvMGjvJ+/CsBY1heb1DErsKVm9GYKscS9mWy7q3Idifj
         kbNi+FPAF31WlHnYuPpmxpSNqggxjpppsy9UGaguwxPDovtcrx2dQ/vbIeXBnoPkrI
         iddFhPnJwYjeA==
Date:   Wed, 21 Jul 2021 17:41:53 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <linux-arm-kernel@lists.infradead.org>,
        <song.bao.hua@hisilicon.com>, <prime.zeng@hisilicon.com>,
        <robin.murphy@arm.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: kprobe: Enable OPTPROBE for arm64
Message-Id: <20210721174153.34c1898dc9eea135eb0b8be8@kernel.org>
In-Reply-To: <20210719122417.10355-1-liuqi115@huawei.com>
References: <20210719122417.10355-1-liuqi115@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qi,

Thanks for your effort!

On Mon, 19 Jul 2021 20:24:17 +0800
Qi Liu <liuqi115@huawei.com> wrote:

> This patch introduce optprobe for ARM64. In optprobe, probed
> instruction is replaced by a branch instruction to detour
> buffer. Detour buffer contains trampoline code and a call to
> optimized_callback(). optimized_callback() calls opt_pre_handler()
> to execute kprobe handler.

OK so this will replace only one instruction.

> 
> Limitations:
> - We only support !CONFIG_RANDOMIZE_MODULE_REGION_FULL case to
> guarantee the offset between probe point and kprobe pre_handler
> is not larger than 128MiB.

Hmm, shouldn't we depends on !CONFIG_ARM64_MODULE_PLTS? Or,
allocate an intermediate trampoline area similar to arm optprobe
does.

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

Great result!
I have other comments on the code below.

[...]
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

Isn't this a separated change? Or any reason why you have to
change this function?

>  }
>  
>  /* arm kprobe: install breakpoint in text */
> diff --git a/arch/arm64/kernel/probes/opt-arm64.c b/arch/arm64/kernel/probes/opt-arm64.c
> new file mode 100644
> index 000000000000..ff72f6275e71
> --- /dev/null
> +++ b/arch/arm64/kernel/probes/opt-arm64.c
> @@ -0,0 +1,217 @@
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
> +static bool is_offset_in_branch_range(long offset)
> +{
> +	return (offset >= -0x08000000 && offset <= 0x07fffffc && !(offset & 0x3));
> +}
> +
> +int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *orig)
> +{
> +	kprobe_opcode_t *code;
> +	long rel_chk;
> +	u32 insn, size;
> +	int ret, i;
> +	void *addr;
> +
> +	code = get_optinsn_slot();
> +	if (!code)
> +		return -ENOMEM;
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
> +	 *   (0x01ffffff << 2) = 1720x07fffffc =  0x07fffffc
> +	 * The maximum backward branch should be:
> +	 *   (0xfe000000 << 2) = 0xFFFFFFFFF8000000 = -0x08000000
> +	 *
> +	 * We can simply check (rel & 0xf8000003):
> +	 *  if rel is positive, (rel & 0xf8000003) should be 0
> +	 *  if rel is negitive, (rel & 0xf8000003) should be 0xf8000000
> +	 *  the last '3' is used for alignment checking.
> +	 */
> +	rel_chk = (unsigned long)code -
> +			(unsigned long)orig->addr + 8;
> +	if (!is_offset_in_branch_range(rel_chk)) {
> +		pr_err("%s is out of branch range.\n", orig->symbol_name);

Because the optprobe is an optional optimization (it can fail back to
normal kprobe), you don't need to show this message as an error.
pr_debug() or pr_info() will be enough.

> +		free_optinsn_slot(code, 0);
> +		return -ERANGE;
> +	}
> +
> +	/* Setup template */
> +	size = (TMPL_END_IDX * sizeof(kprobe_opcode_t)) / sizeof(int);

Why would you use 'int' instead of 'kprobe_opcode_t' here?

> +	for (i = 0; i < size; i++) {
> +		addr = code + i;
> +		insn = *(optprobe_template_entry + i);
> +		ret = aarch64_insn_patch_text(&addr, &insn, 1);
> +		if (ret < 0) {
> +			free_optinsn_slot(code, 0);
> +			return -ERANGE;
> +		}
> +	}

This is too much calling stop_machine() in the loop.
Please try to allocate an array of addresses and call
aarch64_insn_patch_text() once.
Or, as same as x86, allocate a temporary trampoline buffer and modify code
as you like, and patch it once (with following aarch64_insn_patch_text()
calls.)

> +
> +	/* Set probe information */
> +	addr = code + TMPL_VAL_IDX;
> +	insn =  (unsigned long long)op & 0xffffffff;
> +	aarch64_insn_patch_text(&addr, &insn, 1);
> +
> +	addr = addr + 4;
> +	insn = ((unsigned long long)op & GENMASK_ULL(63, 32)) >> 32;
> +	aarch64_insn_patch_text(&addr, &insn, 1);
> +
> +	addr = code + TMPL_CALL_BACK;
> +	insn =  aarch64_insn_gen_branch_imm((unsigned long)addr,
> +				(unsigned long)optimized_callback,
> +				AARCH64_INSN_BRANCH_LINK);

If you use the branch here (and later), you may also need to
do the branch_range check here too.
(trampoline -> optimized_callback())

> +	aarch64_insn_patch_text(&addr, &insn, 1);
> +
> +	/* The original probed instruction */
> +	addr = code + TMPL_RESTORE_ORIGN_INSN;
> +	insn =  orig->opcode;
> +	aarch64_insn_patch_text(&addr, &insn, 1);
> +
> +	/* Jump back to next instruction */
> +	addr = code + TMPL_RESTORE_END;
> +	insn = aarch64_insn_gen_branch_imm(
> +				(unsigned long)(&code[TMPL_RESTORE_END]),
> +				(unsigned long)(op->kp.addr) + 4,
> +				AARCH64_INSN_BRANCH_NOLINK);
> +	aarch64_insn_patch_text(&addr, &insn, 1);

Ditto.

> +
> +	flush_icache_range((unsigned long)code,
> +			   (unsigned long)(&code[TMPL_END_IDX]));
> +	/* Set op->optinsn.insn means prepared. */
> +	op->optinsn.insn = code;
> +	return 0;
> +}
> +
> +void arch_optimize_kprobes(struct list_head *oplist)
> +{
> +	struct optimized_kprobe *op, *tmp;
> +
> +	list_for_each_entry_safe(op, tmp, oplist, list) {
> +		u32 insn;
> +
> +		WARN_ON(kprobe_disabled(&op->kp));
> +
> +		/*
> +		 * Backup instructions which will be replaced
> +		 * by jump address
> +		 */
> +		memcpy(op->optinsn.copied_insn, op->kp.addr,
> +			RELATIVEJUMP_SIZE);
> +		insn = aarch64_insn_gen_branch_imm((unsigned long)op->kp.addr,
> +				(unsigned long)op->optinsn.insn,
> +				AARCH64_INSN_BRANCH_NOLINK);
> +
> +		WARN_ON(insn == 0);
> +
> +		aarch64_insn_patch_text((void *)&(op->kp.addr), &insn, 1);

Hmm, there is room for improvement.
Since aarch64_insn_patch_text() is a batch patching API, this should
optimize probes in batch instead of calling it on each probe.

Thank you,

> +
> +		list_del_init(&op->list);
> +	}
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
> +
> +	list_for_each_entry_safe(op, tmp, oplist, list) {
> +		arch_unoptimize_kprobe(op);
> +		list_move(&op->list, done_list);
> +	}
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
> index 000000000000..13729cb279b8
> --- /dev/null
> +++ b/arch/arm64/kernel/probes/optprobe_trampoline.S
> @@ -0,0 +1,80 @@
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
> +	stp x0, x1, [sp, #S_X0]
> +	stp x2, x3, [sp, #S_X2]
> +	stp x4, x5, [sp, #S_X4]
> +	stp x6, x7, [sp, #S_X6]
> +	stp x8, x9, [sp, #S_X8]
> +	stp x10, x11, [sp, #S_X10]
> +	stp x12, x13, [sp, #S_X12]
> +	stp x14, x15, [sp, #S_X14]
> +	stp x16, x17, [sp, #S_X16]
> +	stp x18, x19, [sp, #S_X18]
> +	stp x20, x21, [sp, #S_X20]
> +	stp x22, x23, [sp, #S_X22]
> +	stp x24, x25, [sp, #S_X24]
> +	stp x26, x27, [sp, #S_X26]
> +	stp x28, x29, [sp, #S_X28]
> +	add x0, sp, #PT_REGS_SIZE
> +	stp lr, x0, [sp, #S_LR]
> +	/*
> +	 * Construct a useful saved PSTATE
> +	 */
> +	mrs x0, nzcv
> +	mrs x1, daif
> +	orr x0, x0, x1
> +	mrs x1, CurrentEL
> +	orr x0, x0, x1
> +	mrs x1, SPSel
> +	orr x0, x0, x1
> +	stp xzr, x0, [sp, #S_PC]
> +	/* Get parameters to optimized_callback() */
> +	ldr	x0, 1f
> +	mov	x1, sp
> +	/* Branch to optimized_callback() */
> +	.global optprobe_template_call
> +optprobe_template_call:
> +	nop
> +        /* Restore registers */
> +	ldr x0, [sp, #S_PSTATE]
> +	and x0, x0, #(PSR_N_BIT | PSR_Z_BIT | PSR_C_BIT | PSR_V_BIT)
> +	msr nzcv, x0
> +	ldp x0, x1, [sp, #S_X0]
> +	ldp x2, x3, [sp, #S_X2]
> +	ldp x4, x5, [sp, #S_X4]
> +	ldp x6, x7, [sp, #S_X6]
> +	ldp x8, x9, [sp, #S_X8]
> +	ldp x10, x11, [sp, #S_X10]
> +	ldp x12, x13, [sp, #S_X12]
> +	ldp x14, x15, [sp, #S_X14]
> +	ldp x16, x17, [sp, #S_X16]
> +	ldp x18, x19, [sp, #S_X18]
> +	ldp x20, x21, [sp, #S_X20]
> +	ldp x22, x23, [sp, #S_X22]
> +	ldp x24, x25, [sp, #S_X24]
> +	ldp x26, x27, [sp, #S_X26]
> +	ldp x28, x29, [sp, #S_X28]
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



> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

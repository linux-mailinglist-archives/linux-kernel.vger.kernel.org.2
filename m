Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFF33E3EC0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 06:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhHIEQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 00:16:02 -0400
Received: from foss.arm.com ([217.140.110.172]:52216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229483AbhHIEQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 00:16:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAC666D;
        Sun,  8 Aug 2021 21:15:40 -0700 (PDT)
Received: from [10.57.67.185] (unknown [10.57.67.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 535B43F40C;
        Sun,  8 Aug 2021 21:15:36 -0700 (PDT)
Subject: Re: [PATCH v2] arm64: kprobe: Enable OPTPROBE for arm64
To:     Qi Liu <liuqi115@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        mhiramat@kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     song.bao.hua@hisilicon.com, prime.zeng@hisilicon.com,
        robin.murphy@arm.com, f.fangjian@huawei.com, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
References: <20210804060209.95817-1-liuqi115@huawei.com>
From:   Amit Kachhap <amit.kachhap@arm.com>
Message-ID: <2fd3c78f-741a-4693-acae-4ea5465ad798@arm.com>
Date:   Mon, 9 Aug 2021 09:45:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20210804060209.95817-1-liuqi115@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liu,

I am few minor comments.

On 8/4/21 11:32 AM, Qi Liu wrote:
> This patch introduce optprobe for ARM64. In optprobe, probed
> instruction is replaced by a branch instruction to detour
> buffer. Detour buffer contains trampoline code and a call to
> optimized_callback(). optimized_callback() calls opt_pre_handler()
> to execute kprobe handler.
> 
> Limitations:
> - We only support !CONFIG_RANDOMIZE_MODULE_REGION_FULL case to
> guarantee the offset between probe point and kprobe pre_handler
> is not larger than 128MiB.
> 
> Performance of optprobe on Hip08 platform is test using kprobe
> example module[1] to analyze the latency of a kernel function,
> and here is the result:
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/kprobes/kretprobe_example.c

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

7120x07fffffc ? Shouldn't it be just 0x07fffffc.

> +	 * The maximum backward branch should be:
> +	 *   (0xfe000000 << 2) = 0xFFFFFFFFF8000000 = -0x08000000
> +	 *
> +	 * We can simply check (rel & 0xf8000003):
> +	 *  if rel is positive, (rel & 0xf8000003) should be 0
> +	 *  if rel is negitive, (rel & 0xf8000003) should be 0xf8000000
> +	 *  the last '3' is used for alignment checking.
> +	 */
> +	return (offset >= -0x08000000 && offset <= 0x07fffffc && !(offset & 0x3));
> +}
> +
> +int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *orig)
> +{
> +	kprobe_opcode_t *code;
> +	u32 insn;
> +	int ret, i;
> +	void *addrs[TMPL_END_IDX];
> +	void *addr;
> +
> +	code = get_optinsn_slot();
> +	if (!code)
> +		return -ENOMEM;
> +
> +	if (!is_offset_in_range((unsigned long)code,
> +				(unsigned long)orig->addr + 8))
> +		goto error;
> +
> +	if (!is_offset_in_range((unsigned long)code + TMPL_CALL_BACK,
> +				(unsigned long)optimized_callback))
> +		goto error;
> +
> +	if (!is_offset_in_range((unsigned long)&code[TMPL_RESTORE_END],
> +				(unsigned long)op->kp.addr + 4))
> +		goto error;
> +
> +	/* Setup template */
> +	for (i = 0; i < TMPL_END_IDX; i++)
> +		addrs[i] = code + i;
> +
> +	ret = aarch64_insn_patch_text(addrs, optprobe_template_entry,
> +				      TMPL_END_IDX);

Here it copies nops for restore_orig_insn, restore_orig_insn and
again overwrites them with new values below.

> +	if (ret < 0)
> +		goto error;
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
> +	aarch64_insn_patch_text(&addr, &insn, 1);
> +
> +	/* The original probed instruction */
> +	addr = code + TMPL_RESTORE_ORIGN_INSN;
> +	insn =  orig->opcode;
> +	aarch64_insn_patch_text(&addr, &insn, 1);

As commented above.

> +
> +	/* Jump back to next instruction */
> +	addr = code + TMPL_RESTORE_END;
> +	insn = aarch64_insn_gen_branch_imm(
> +				(unsigned long)(&code[TMPL_RESTORE_END]),
> +				(unsigned long)(op->kp.addr) + 4,
> +				AARCH64_INSN_BRANCH_NOLINK);
> +	aarch64_insn_patch_text(&addr, &insn, 1);

As commented above.

> +
> +	flush_icache_range((unsigned long)code,
> +			   (unsigned long)(&code[TMPL_END_IDX]));
> +	/* Set op->optinsn.insn means prepared. */
> +	op->optinsn.insn = code;
> +
> +	return 0;
> +
> +error:
> +	free_optinsn_slot(code, 0);
> +	return -ERANGE;
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
> +		aarch64_insn_patch_text_nosync((void*)op->kp.addr, insn);
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

Most of the codes here are same as save_all_base_regs macro in file
arch/arm64/kernel/probes/kprobes_trampoline.S. May be they
can be made common macros and kept in asm/assembler.h

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

Same as previous comment.

BR.
//Amit

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
> 

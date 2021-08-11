Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB323E8AF1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 09:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbhHKHUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 03:20:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:40328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235109AbhHKHUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 03:20:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB19C604AC;
        Wed, 11 Aug 2021 07:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628666407;
        bh=jHLNoDVtHzRdPq7T+Fru/vbnYiBPoRk9evg5764ZYn8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qDueVASHd94s3W69/F6FIobc5imABhvlcUhpU60eC8Npj9ifiI/VgNnlGJtSdE8Nn
         nJbis3+SVUM+spYN+27u0Vsv7OGf5vnHvxO+W9Dwxe1cOsSMYNPFHMRh6tI4aVY0MQ
         rPszuP+zaV2CY2UWu7eUhFlL5eKf0+jPdUe3QjSSIUC2dAxbsH1vWsrCP6G6F5qSQv
         +QUDdgAjUWNX/BRZ3LIAQKtuLvTx9GSOKTqstiuNXqQcxBCNCT+FiNoflGeC4VkDLN
         UXGD2Z2oBz+Dv0WgYXbqBxqlTbbyEs+459kvuKi/YLZ+5ujomxLGRnYJxYyUeoZz1D
         rEnoLmmwg0TLg==
Date:   Wed, 11 Aug 2021 16:20:04 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <linux-arm-kernel@lists.infradead.org>,
        <song.bao.hua@hisilicon.com>, <prime.zeng@hisilicon.com>,
        <robin.murphy@arm.com>, <f.fangjian@huawei.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] arm64: kprobe: Enable OPTPROBE for arm64
Message-Id: <20210811162004.9b3349e6bda68e74e0a3a4ad@kernel.org>
In-Reply-To: <20210810055330.18924-3-liuqi115@huawei.com>
References: <20210810055330.18924-1-liuqi115@huawei.com>
        <20210810055330.18924-3-liuqi115@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qi,

Thanks for updating.

On Tue, 10 Aug 2021 13:53:30 +0800
Qi Liu <liuqi115@huawei.com> wrote:

[...]
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

OK, this part looks good to me.

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

Can you also reduce the number of aarch64_insn_patch_text() here?
Since arch_optimize_kprobes() running in the workqueue context, you can
allocate memory. Thus, you can do something like this(not cleaned)

#define OPTPROBE_BATCH_SIZE 64

void arch_optimize_kprobes(struct list_head *oplist)
{
	struct optimized_kprobe *op, *tmp;
	void **addrs;
	u32 *insns;
	int i = 0;

	addrs = kcalloc(OPTPROBE_BATCH_SIZE, sizeof(*addrs), GFP_KERNEL);
	insns = kcalloc(OPTPROBE_BATCH_SIZE, sizeof(*insns), GFP_KERNEL);

	list_for_each_entry_safe(op, tmp, oplist, list) {
		memcpy(op->optinsn.copied_insn, op->kp.addr,
			RELATIVEJUMP_SIZE);
		addrs[i] = op->kp.addr;
		insns[i] = aarch64_insn_gen_branch_imm((unsigned long)op->kp.addr,
				(unsigned long)op->optinsn.insn,
				AARCH64_INSN_BRANCH_NOLINK);
		list_del_init(&op->list);
		if (++i == OPTPROBE_BATCH_SIZE)
			break;
	}
	aarch64_insn_patch_text(addrs, insns, i);

	kfree(addrs);
	kfree(insns);
}

Since the stop_machine() penalty is heavier than you think (especially,
if the machine has many cores), it must be avoided as much as possible.


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

Ditto.
You don't need to use arch_arm_kprobe() in this case.

Thank you,

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

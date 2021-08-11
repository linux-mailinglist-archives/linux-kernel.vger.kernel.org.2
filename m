Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366113E8B3E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 09:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbhHKHve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 03:51:34 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:13263 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbhHKHvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 03:51:33 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Gl27K4lcmz1CV4S;
        Wed, 11 Aug 2021 15:50:53 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 11 Aug 2021 15:51:08 +0800
Received: from [127.0.0.1] (10.69.38.203) by dggema757-chm.china.huawei.com
 (10.1.198.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 11
 Aug 2021 15:51:07 +0800
Subject: Re: [PATCH v3 2/2] arm64: kprobe: Enable OPTPROBE for arm64
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Linuxarm <linuxarm@huawei.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <linux-arm-kernel@lists.infradead.org>,
        <song.bao.hua@hisilicon.com>, <prime.zeng@hisilicon.com>,
        <robin.murphy@arm.com>, <f.fangjian@huawei.com>,
        <linux-kernel@vger.kernel.org>
References: <20210810055330.18924-1-liuqi115@huawei.com>
 <20210810055330.18924-3-liuqi115@huawei.com>
 <20210811162004.9b3349e6bda68e74e0a3a4ad@kernel.org>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <d0510f00-4745-add5-a8d9-cde35c296634@huawei.com>
Date:   Wed, 11 Aug 2021 15:51:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210811162004.9b3349e6bda68e74e0a3a4ad@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.203]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masmi,

On 2021/8/11 15:20, Masami Hiramatsu wrote:
> Hi Qi,
> 
> Thanks for updating.
> 
> On Tue, 10 Aug 2021 13:53:30 +0800
> Qi Liu <liuqi115@huawei.com> wrote:
> 

[...]

>> +void arch_optimize_kprobes(struct list_head *oplist)
>> +{
>> +	struct optimized_kprobe *op, *tmp;
>> +
>> +	list_for_each_entry_safe(op, tmp, oplist, list) {
>> +		u32 insn;
>> +
>> +		WARN_ON(kprobe_disabled(&op->kp));
>> +
>> +		/*
>> +		 * Backup instructions which will be replaced
>> +		 * by jump address
>> +		 */
>> +		memcpy(op->optinsn.copied_insn, op->kp.addr,
>> +			RELATIVEJUMP_SIZE);
>> +		insn = aarch64_insn_gen_branch_imm((unsigned long)op->kp.addr,
>> +				(unsigned long)op->optinsn.insn,
>> +				AARCH64_INSN_BRANCH_NOLINK);
>> +
>> +		WARN_ON(insn == 0);
>> +
>> +		aarch64_insn_patch_text((void *)&(op->kp.addr), &insn, 1);
> 
> Can you also reduce the number of aarch64_insn_patch_text() here?
> Since arch_optimize_kprobes() running in the workqueue context, you can
> allocate memory. Thus, you can do something like this(not cleaned)
> 
> #define OPTPROBE_BATCH_SIZE 64
> 
> void arch_optimize_kprobes(struct list_head *oplist)
> {
> 	struct optimized_kprobe *op, *tmp;
> 	void **addrs;
> 	u32 *insns;
> 	int i = 0;
> 
> 	addrs = kcalloc(OPTPROBE_BATCH_SIZE, sizeof(*addrs), GFP_KERNEL);
> 	insns = kcalloc(OPTPROBE_BATCH_SIZE, sizeof(*insns), GFP_KERNEL);
> 
> 	list_for_each_entry_safe(op, tmp, oplist, list) {
> 		memcpy(op->optinsn.copied_insn, op->kp.addr,
> 			RELATIVEJUMP_SIZE);
> 		addrs[i] = op->kp.addr;
> 		insns[i] = aarch64_insn_gen_branch_imm((unsigned long)op->kp.addr,
> 				(unsigned long)op->optinsn.insn,
> 				AARCH64_INSN_BRANCH_NOLINK);
> 		list_del_init(&op->list);
> 		if (++i == OPTPROBE_BATCH_SIZE)
> 			break;
> 	}
> 	aarch64_insn_patch_text(addrs, insns, i);
> 
> 	kfree(addrs);
> 	kfree(insns);
> }
> 
> Since the stop_machine() penalty is heavier than you think (especially,
> if the machine has many cores), it must be avoided as much as possible.
> 

got it, I'll fix this next time.
> 
>> +
>> +		list_del_init(&op->list);
>> +	}
>> +}
>> +
>> +void arch_unoptimize_kprobe(struct optimized_kprobe *op)
>> +{
>> +	arch_arm_kprobe(&op->kp);
>> +}
>> +
>> +/*
>> + * Recover original instructions and breakpoints from relative jumps.
>> + * Caller must call with locking kprobe_mutex.
>> + */
>> +void arch_unoptimize_kprobes(struct list_head *oplist,
>> +			    struct list_head *done_list)
>> +{
>> +	struct optimized_kprobe *op, *tmp;
>> +
>> +	list_for_each_entry_safe(op, tmp, oplist, list) {
>> +		arch_unoptimize_kprobe(op);
>> +		list_move(&op->list, done_list);
>> +	}
>> +}
> 
> Ditto.
> You don't need to use arch_arm_kprobe() in this case.
> 
> Thank you,
> 
thanks, will change this next time.

Qi
>> +
>> +void arch_remove_optimized_kprobe(struct optimized_kprobe *op)
>> +{
>> +	if (op->optinsn.insn) {
>> +		free_optinsn_slot(op->optinsn.insn, 1);
>> +		op->optinsn.insn = NULL;
>> +	}
>> +}
>> diff --git a/arch/arm64/kernel/probes/optprobe_trampoline.S b/arch/arm64/kernel/probes/optprobe_trampoline.S
>> new file mode 100644
>> index 000000000000..24d713d400cd
>> --- /dev/null
>> +++ b/arch/arm64/kernel/probes/optprobe_trampoline.S
>> @@ -0,0 +1,37 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * trampoline entry and return code for optprobes.
>> + */
>> +
>> +#include <linux/linkage.h>
>> +#include <asm/asm-offsets.h>
>> +#include <asm/assembler.h>
>> +
>> +	.global optprobe_template_entry
>> +optprobe_template_entry:
>> +	sub sp, sp, #PT_REGS_SIZE
>> +	save_all_base_regs
>> +	/* Get parameters to optimized_callback() */
>> +	ldr	x0, 1f
>> +	mov	x1, sp
>> +	/* Branch to optimized_callback() */
>> +	.global optprobe_template_call
>> +optprobe_template_call:
>> +	nop
>> +	restore_all_base_regs
>> +	ldr lr, [sp, #S_LR]
>> +        add sp, sp, #PT_REGS_SIZE
>> +	.global optprobe_template_restore_orig_insn
>> +optprobe_template_restore_orig_insn:
>> +	nop
>> +	.global optprobe_template_restore_end
>> +optprobe_template_restore_end:
>> +	nop
>> +	.global optprobe_template_end
>> +optprobe_template_end:
>> +	.global optprobe_template_val
>> +optprobe_template_val:
>> +	1:	.long 0
>> +		.long 0
>> +	.global optprobe_template_max_length
>> +optprobe_template_max_length:
>> -- 
>> 2.17.1
>>
> 
> 


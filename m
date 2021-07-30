Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79AA23DB1F7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 05:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbhG3DdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 23:33:04 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7767 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhG3DdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 23:33:03 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GbXrL4gcyzYdFw;
        Fri, 30 Jul 2021 11:26:58 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 30 Jul 2021 11:32:51 +0800
Received: from [127.0.0.1] (10.69.38.203) by dggema757-chm.china.huawei.com
 (10.1.198.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 30
 Jul 2021 11:32:50 +0800
Subject: Re: [PATCH] arm64: kprobe: Enable OPTPROBE for arm64
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Linuxarm <linuxarm@huawei.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <linux-arm-kernel@lists.infradead.org>,
        <song.bao.hua@hisilicon.com>, <prime.zeng@hisilicon.com>,
        <robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>
References: <20210719122417.10355-1-liuqi115@huawei.com>
 <20210721174153.34c1898dc9eea135eb0b8be8@kernel.org>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <7e8efbd7-dbf7-efda-b187-195d104d2e17@huawei.com>
Date:   Fri, 30 Jul 2021 11:32:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210721174153.34c1898dc9eea135eb0b8be8@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.203]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Masami.
Thanks for reviewing this patch
On 2021/7/21 16:41, Masami Hiramatsu wrote:
> Hi Qi,
> 
> Thanks for your effort!
> 
> On Mon, 19 Jul 2021 20:24:17 +0800
> Qi Liu <liuqi115@huawei.com> wrote:
> 
>> This patch introduce optprobe for ARM64. In optprobe, probed
>> instruction is replaced by a branch instruction to detour
>> buffer. Detour buffer contains trampoline code and a call to
>> optimized_callback(). optimized_callback() calls opt_pre_handler()
>> to execute kprobe handler.
> 
> OK so this will replace only one instruction.
> 
>>
>> Limitations:
>> - We only support !CONFIG_RANDOMIZE_MODULE_REGION_FULL case to
>> guarantee the offset between probe point and kprobe pre_handler
>> is not larger than 128MiB.
> 
> Hmm, shouldn't we depends on !CONFIG_ARM64_MODULE_PLTS? Or,
> allocate an intermediate trampoline area similar to arm optprobe
> does.
> 
>>
>> Performance of optprobe on Hip08 platform is test using kprobe
>> example module[1] to analyze the latency of a kernel function,
>> and here is the result:
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/kprobes/kretprobe_example.c
>>
>> kprobe before optimized:
>> [280709.846380] do_empty returned 0 and took 1530 ns to execute
>> [280709.852057] do_empty returned 0 and took 550 ns to execute
>> [280709.857631] do_empty returned 0 and took 440 ns to execute
>> [280709.863215] do_empty returned 0 and took 380 ns to execute
>> [280709.868787] do_empty returned 0 and took 360 ns to execute
>> [280709.874362] do_empty returned 0 and took 340 ns to execute
>> [280709.879936] do_empty returned 0 and took 320 ns to execute
>> [280709.885505] do_empty returned 0 and took 300 ns to execute
>> [280709.891075] do_empty returned 0 and took 280 ns to execute
>> [280709.896646] do_empty returned 0 and took 290 ns to execute
>> [280709.902220] do_empty returned 0 and took 290 ns to execute
>> [280709.907807] do_empty returned 0 and took 290 ns to execute
>>
>> optprobe:
>> [ 2965.964572] do_empty returned 0 and took 90 ns to execute
>> [ 2965.969952] do_empty returned 0 and took 80 ns to execute
>> [ 2965.975332] do_empty returned 0 and took 70 ns to execute
>> [ 2965.980714] do_empty returned 0 and took 60 ns to execute
>> [ 2965.986128] do_empty returned 0 and took 80 ns to execute
>> [ 2965.991507] do_empty returned 0 and took 70 ns to execute
>> [ 2965.996884] do_empty returned 0 and took 70 ns to execute
>> [ 2966.002262] do_empty returned 0 and took 80 ns to execute
>> [ 2966.007642] do_empty returned 0 and took 70 ns to execute
>> [ 2966.013020] do_empty returned 0 and took 70 ns to execute
>> [ 2966.018400] do_empty returned 0 and took 70 ns to execute
>> [ 2966.023779] do_empty returned 0 and took 70 ns to execute
>> [ 2966.029158] do_empty returned 0 and took 70 ns to execute
> 
> Great result!
> I have other comments on the code below.
> 
> [...]
>> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
>> index 6dbcc89f6662..83755ad62abe 100644
>> --- a/arch/arm64/kernel/probes/kprobes.c
>> +++ b/arch/arm64/kernel/probes/kprobes.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/kasan.h>
>>   #include <linux/kernel.h>
>>   #include <linux/kprobes.h>
>> +#include <linux/moduleloader.h>
>>   #include <linux/sched/debug.h>
>>   #include <linux/set_memory.h>
>>   #include <linux/slab.h>
>> @@ -113,9 +114,21 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>>   
>>   void *alloc_insn_page(void)
>>   {
>> -	return __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
>> -			GFP_KERNEL, PAGE_KERNEL_ROX, VM_FLUSH_RESET_PERMS,
>> -			NUMA_NO_NODE, __builtin_return_address(0));
>> +	void *page;
>> +
>> +	page = module_alloc(PAGE_SIZE);
>> +	if (!page)
>> +		return NULL;
>> +
>> +	set_vm_flush_reset_perms(page);
>> +	/*
>> +	 * First make the page read-only, and only then make it executable to
>> +	 * prevent it from being W+X in between.
>> +	 */
>> +	set_memory_ro((unsigned long)page, 1);
>> +	set_memory_x((unsigned long)page, 1);
>> +
>> +	return page;
> 
> Isn't this a separated change? Or any reason why you have to
> change this function?
> 

As Barry's reply, this is for 128MB short jump limitation.

>>   }
>>   

[...]

>> +int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *orig)
>> +{
>> +	kprobe_opcode_t *code;
>> +	long rel_chk;
>> +	u32 insn, size;
>> +	int ret, i;
>> +	void *addr;
>> +
>> +	code = get_optinsn_slot();
>> +	if (!code)
>> +		return -ENOMEM;
>> +
>> +	/*
>> +	 * Verify if the address gap is in 128MiB range, because this uses
>> +	 * a relative jump.
>> +	 *
>> +	 * kprobe opt use a 'b' instruction to branch to optinsn.insn.
>> +	 * According to ARM manual, branch instruction is:
>> +	 *
>> +	 *   31  30                  25              0
>> +	 *  +----+---+---+---+---+---+---------------+
>> +	 *  |cond| 0 | 0 | 1 | 0 | 1 |     imm26     |
>> +	 *  +----+---+---+---+---+---+---------------+
>> +	 *
>> +	 * imm26 is a signed 26 bits integer. The real branch offset is computed
>> +	 * by: imm64 = SignExtend(imm26:'00', 64);
>> +	 *
>> +	 * So the maximum forward branch should be:
>> +	 *   (0x01ffffff << 2) = 1720x07fffffc =  0x07fffffc
>> +	 * The maximum backward branch should be:
>> +	 *   (0xfe000000 << 2) = 0xFFFFFFFFF8000000 = -0x08000000
>> +	 *
>> +	 * We can simply check (rel & 0xf8000003):
>> +	 *  if rel is positive, (rel & 0xf8000003) should be 0
>> +	 *  if rel is negitive, (rel & 0xf8000003) should be 0xf8000000
>> +	 *  the last '3' is used for alignment checking.
>> +	 */
>> +	rel_chk = (unsigned long)code -
>> +			(unsigned long)orig->addr + 8;
>> +	if (!is_offset_in_branch_range(rel_chk)) {
>> +		pr_err("%s is out of branch range.\n", orig->symbol_name);
> 
> Because the optprobe is an optional optimization (it can fail back to
> normal kprobe), you don't need to show this message as an error.
> pr_debug() or pr_info() will be enough.
> 
ok, I'll change it to pr_debug().thanks.

>> +		free_optinsn_slot(code, 0);
>> +		return -ERANGE;
>> +	}
>> +
>> +	/* Setup template */
>> +	size = (TMPL_END_IDX * sizeof(kprobe_opcode_t)) / sizeof(int);
> 
> Why would you use 'int' instead of 'kprobe_opcode_t' here?
> 
>> +	for (i = 0; i < size; i++) {
>> +		addr = code + i;
>> +		insn = *(optprobe_template_entry + i);
>> +		ret = aarch64_insn_patch_text(&addr, &insn, 1);
>> +		if (ret < 0) {
>> +			free_optinsn_slot(code, 0);
>> +			return -ERANGE;
>> +		}
>> +	}
> 
> This is too much calling stop_machine() in the loop.
> Please try to allocate an array of addresses and call
> aarch64_insn_patch_text() once.
> Or, as same as x86, allocate a temporary trampoline buffer and modify code
> as you like, and patch it once (with following aarch64_insn_patch_text()
> calls.)
ok, I'allocate an array of addresses and call aarch64_insn_patch_text() 
once. thanks.

> 
>> +
>> +	/* Set probe information */
>> +	addr = code + TMPL_VAL_IDX;
>> +	insn =  (unsigned long long)op & 0xffffffff;
>> +	aarch64_insn_patch_text(&addr, &insn, 1);
>> +
>> +	addr = addr + 4;
>> +	insn = ((unsigned long long)op & GENMASK_ULL(63, 32)) >> 32;
>> +	aarch64_insn_patch_text(&addr, &insn, 1);
>> +
>> +	addr = code + TMPL_CALL_BACK;
>> +	insn =  aarch64_insn_gen_branch_imm((unsigned long)addr,
>> +				(unsigned long)optimized_callback,
>> +				AARCH64_INSN_BRANCH_LINK);
> 
> If you use the branch here (and later), you may also need to
> do the branch_range check here too.
> (trampoline -> optimized_callback())
> 
got it, will add check here, thanks.

>> +	aarch64_insn_patch_text(&addr, &insn, 1);
>> +
>> +	/* The original probed instruction */
>> +	addr = code + TMPL_RESTORE_ORIGN_INSN;
>> +	insn =  orig->opcode;
>> +	aarch64_insn_patch_text(&addr, &insn, 1);
>> +
>> +	/* Jump back to next instruction */
>> +	addr = code + TMPL_RESTORE_END;
>> +	insn = aarch64_insn_gen_branch_imm(
>> +				(unsigned long)(&code[TMPL_RESTORE_END]),
>> +				(unsigned long)(op->kp.addr) + 4,
>> +				AARCH64_INSN_BRANCH_NOLINK);
>> +	aarch64_insn_patch_text(&addr, &insn, 1);
> 
> Ditto.
> 
got it, thanks.
>> +
>> +	flush_icache_range((unsigned long)code,
>> +			   (unsigned long)(&code[TMPL_END_IDX]));
>> +	/* Set op->optinsn.insn means prepared. */
>> +	op->optinsn.insn = code;
>> +	return 0;
>> +}
>> +
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
> Hmm, there is room for improvement.
> Since aarch64_insn_patch_text() is a batch patching API, this should
> optimize probes in batch instead of calling it on each probe.
> 

I'm not sure how to replace aarch64_insn_patch_text(), do you mean using 
aarch64_insn_patch_text_nosync() instead of it?

But in arch_arm_kprobe() on each probe, aarch64_insn_patch_text() is 
used to add BRK64_OPCODE_KPROBES instruction...

Thanks,
Qi

> Thank you,
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
>> index 000000000000..13729cb279b8
>> --- /dev/null
>> +++ b/arch/arm64/kernel/probes/optprobe_trampoline.S
>> @@ -0,0 +1,80 @@
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
>> +	stp x0, x1, [sp, #S_X0]
>> +	stp x2, x3, [sp, #S_X2]
>> +	stp x4, x5, [sp, #S_X4]
>> +	stp x6, x7, [sp, #S_X6]
>> +	stp x8, x9, [sp, #S_X8]
>> +	stp x10, x11, [sp, #S_X10]
>> +	stp x12, x13, [sp, #S_X12]
>> +	stp x14, x15, [sp, #S_X14]
>> +	stp x16, x17, [sp, #S_X16]
>> +	stp x18, x19, [sp, #S_X18]
>> +	stp x20, x21, [sp, #S_X20]
>> +	stp x22, x23, [sp, #S_X22]
>> +	stp x24, x25, [sp, #S_X24]
>> +	stp x26, x27, [sp, #S_X26]
>> +	stp x28, x29, [sp, #S_X28]
>> +	add x0, sp, #PT_REGS_SIZE
>> +	stp lr, x0, [sp, #S_LR]
>> +	/*
>> +	 * Construct a useful saved PSTATE
>> +	 */
>> +	mrs x0, nzcv
>> +	mrs x1, daif
>> +	orr x0, x0, x1
>> +	mrs x1, CurrentEL
>> +	orr x0, x0, x1
>> +	mrs x1, SPSel
>> +	orr x0, x0, x1
>> +	stp xzr, x0, [sp, #S_PC]
>> +	/* Get parameters to optimized_callback() */
>> +	ldr	x0, 1f
>> +	mov	x1, sp
>> +	/* Branch to optimized_callback() */
>> +	.global optprobe_template_call
>> +optprobe_template_call:
>> +	nop
>> +        /* Restore registers */
>> +	ldr x0, [sp, #S_PSTATE]
>> +	and x0, x0, #(PSR_N_BIT | PSR_Z_BIT | PSR_C_BIT | PSR_V_BIT)
>> +	msr nzcv, x0
>> +	ldp x0, x1, [sp, #S_X0]
>> +	ldp x2, x3, [sp, #S_X2]
>> +	ldp x4, x5, [sp, #S_X4]
>> +	ldp x6, x7, [sp, #S_X6]
>> +	ldp x8, x9, [sp, #S_X8]
>> +	ldp x10, x11, [sp, #S_X10]
>> +	ldp x12, x13, [sp, #S_X12]
>> +	ldp x14, x15, [sp, #S_X14]
>> +	ldp x16, x17, [sp, #S_X16]
>> +	ldp x18, x19, [sp, #S_X18]
>> +	ldp x20, x21, [sp, #S_X20]
>> +	ldp x22, x23, [sp, #S_X22]
>> +	ldp x24, x25, [sp, #S_X24]
>> +	ldp x26, x27, [sp, #S_X26]
>> +	ldp x28, x29, [sp, #S_X28]
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
> 
> 
> 
>> -- 
>> 2.17.1
>>
> 
> 


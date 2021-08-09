Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DAA3E4066
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 08:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbhHIGp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 02:45:27 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:13252 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbhHIGpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 02:45:24 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Gjmm14XcWz1CTvw;
        Mon,  9 Aug 2021 14:44:49 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 14:44:59 +0800
Received: from [127.0.0.1] (10.69.38.203) by dggema757-chm.china.huawei.com
 (10.1.198.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 9 Aug
 2021 14:44:59 +0800
Subject: Re: [PATCH v2] arm64: kprobe: Enable OPTPROBE for arm64
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Linuxarm <linuxarm@huawei.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
        "anil.s.keshavamurthy@intel.com" <anil.s.keshavamurthy@intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "Fangjian (Jay)" <f.fangjian@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210804060209.95817-1-liuqi115@huawei.com>
 <e59357e126e34a6d97a55113483746f8@hisilicon.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <925da4cb-f45f-fbaf-e0bd-4866690a2b26@huawei.com>
Date:   Mon, 9 Aug 2021 14:44:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <e59357e126e34a6d97a55113483746f8@hisilicon.com>
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


Hi Barry,
On 2021/8/5 16:55, Song Bao Hua (Barry Song) wrote:
> 
> 
>> -----Original Message-----
>> From: liuqi (BA)
>> Sent: Wednesday, August 4, 2021 6:02 PM
>> To: catalin.marinas@arm.com; will@kernel.org; naveen.n.rao@linux.ibm.com;
>> anil.s.keshavamurthy@intel.com; davem@davemloft.net; mhiramat@kernel.org;
>> linux-arm-kernel@lists.infradead.org
>> Cc: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; Zengtao (B)
>> <prime.zeng@hisilicon.com>; robin.murphy@arm.com; Fangjian (Jay)
>> <f.fangjian@huawei.com>; liuqi (BA) <liuqi115@huawei.com>; Linuxarm
>> <linuxarm@huawei.com>; linux-kernel@vger.kernel.org
>> Subject: [PATCH v2] arm64: kprobe: Enable OPTPROBE for arm64
>>
>> This patch introduce optprobe for ARM64. In optprobe, probed
>> instruction is replaced by a branch instruction to detour
>> buffer. Detour buffer contains trampoline code and a call to
>> optimized_callback(). optimized_callback() calls opt_pre_handler()
>> to execute kprobe handler.
>>
>> Limitations:
>> - We only support !CONFIG_RANDOMIZE_MODULE_REGION_FULL case to
>> guarantee the offset between probe point and kprobe pre_handler
>> is not larger than 128MiB.
>>
>> Performance of optprobe on Hip08 platform is test using kprobe
>> example module[1] to analyze the latency of a kernel function,
>> and here is the result:
>>
>> [1]
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sa
>> mples/kprobes/kretprobe_example.c
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

[...]
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index b5b13a932561..3532f0237c71 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -200,6 +200,7 @@ config ARM64
>>   	select HAVE_STACKPROTECTOR
>>   	select HAVE_SYSCALL_TRACEPOINTS
>>   	select HAVE_KPROBES
>> +	select HAVE_OPTPROBES if !RANDOMIZE_MODULE_REGION_FULL
> 
> Any negative side effect if we optprobe doesn't apply and we fall
> back to normal kprobe?
> 
> I mean, normal kprobe without this patch vs. fallback to kprobe
> from optprobe with this patch, any penalty in latency from
> optprobe?
> 

I test this situation on Hip08 platform, and here is the result:
</sys/bus/platform/devices/hello_driver/kprobe_test
[   29.713132] do_empty returned 0 and took 1800 ns to execute
[   29.713726] do_empty returned 0 and took 410 ns to execute
[   29.714296] do_empty returned 0 and took 320 ns to execute
[   29.714846] do_empty returned 0 and took 290 ns to execute
[   29.715388] do_empty returned 0 and took 280 ns to execute
[   29.715932] do_empty returned 0 and took 290 ns to execute
[   29.716472] do_empty returned 0 and took 280 ns to execute
[   29.717028] do_empty returned 0 and took 270 ns to execute
[   29.717578] do_empty returned 0 and took 270 ns to execute
[   29.718142] do_empty returned 0 and took 290 ns to execute
[   29.718700] do_empty returned 0 and took 250 ns to execute
[   29.719246] do_empty returned 0 and took 260 ns to execute
[   29.719797] do_empty returned 0 and took 250 ns to execute
[   29.720355] do_empty returned 0 and took 290 ns to execute
[   29.720915] do_empty returned 0 and took 270 ns to execute
[   29.721484] do_empty returned 0 and took 270 ns to execute
[   29.722032] do_empty returned 0 and took 270 ns to execute
[   29.722612] do_empty returned 0 and took 280 ns to execute
[   29.723161] do_empty returned 0 and took 260 ns to execute
[   29.723712] do_empty returned 0 and took 260 ns to execute
[   29.724266] do_empty returned 0 and took 260 ns to execute
[   29.724823] do_empty returned 0 and took 270 ns to execute
[   29.725423] do_empty returned 0 and took 340 ns to execute
[   29.725968] do_empty returned 0 and took 280 ns to execute

Seems no penalty here.

> If no penalty, I'd rather we remove the dependency of
> RANDOMIZE_MODULE_REGION_FULL since you mentioned
> nokaslr will always make optprobe work. I assume
> in those tests you enabled RANDOMIZE_MODULE_REGION_FULL?
> 

Yes, when I set nokaslr, I also set CONFIG_RANDOMIZE_MODULE_REGION_FULL=y.

ok, I'll remove this depending next version and metion it in commit log.

Thanks,
Qi

> We can mention those issues in commit log rather than statically
> depending on a kconfig option.
> 
>>   	select HAVE_KRETPROBES
>>   	select HAVE_GENERIC_VDSO
>>   	select IOMMU_DMA if IOMMU_SUPPORT
>> diff --git a/arch/arm64/include/asm/kprobes.h
>> b/arch/arm64/include/asm/kprobes.h
>> index 5d38ff4a4806..9e1c492a0c3d 100644
>> --- a/arch/arm64/include/asm/kprobes.h
>> +++ b/arch/arm64/include/asm/kprobes.h
>> @@ -39,6 +39,29 @@ void arch_remove_kprobe(struct kprobe *);
>>   int kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr);
>>   int kprobe_exceptions_notify(struct notifier_block *self,
>>   			     unsigned long val, void *data);
>> +
>> +#define RELATIVEJUMP_SIZE (4)
>> +#define MAX_COPIED_INSN	DIV_ROUND_UP(RELATIVEJUMP_SIZE,
>> sizeof(kprobe_opcode_t))
>> +struct arch_optimized_insn {
>> +	kprobe_opcode_t copied_insn[MAX_COPIED_INSN];
>> +	/* detour code buffer */
>> +	kprobe_opcode_t *insn;
>> +};
>> +
>> +/* optinsn template addresses */
>> +extern __visible kprobe_opcode_t optprobe_template_entry[];
>> +extern __visible kprobe_opcode_t optprobe_template_val[];
>> +extern __visible kprobe_opcode_t optprobe_template_call[];
>> +extern __visible kprobe_opcode_t optprobe_template_end[];
>> +extern __visible kprobe_opcode_t optprobe_template_restore_begin[];
>> +extern __visible kprobe_opcode_t optprobe_template_restore_orig_insn[];
>> +extern __visible kprobe_opcode_t optprobe_template_restore_end[];
>> +
>> +#define MAX_OPTIMIZED_LENGTH	4
>> +#define MAX_OPTINSN_SIZE				\
>> +	((unsigned long)optprobe_template_end -	\
>> +	 (unsigned long)optprobe_template_entry)
>> +
>>   void kretprobe_trampoline(void);
>>   void __kprobes *trampoline_probe_handler(struct pt_regs *regs);
>>
>> diff --git a/arch/arm64/kernel/probes/Makefile
>> b/arch/arm64/kernel/probes/Makefile
>> index 8e4be92e25b1..52cf5d4ffe8a 100644
>> --- a/arch/arm64/kernel/probes/Makefile
>> +++ b/arch/arm64/kernel/probes/Makefile
>> @@ -4,3 +4,5 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o	\
>>   				   simulate-insn.o
>>   obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o	\
>>   				   simulate-insn.o
>> +obj-$(CONFIG_OPTPROBES)		+= opt-arm64.o			\
>> +				   optprobe_trampoline.o
>> diff --git a/arch/arm64/kernel/probes/kprobes.c
>> b/arch/arm64/kernel/probes/kprobes.c
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
>>   }
>>
>>   /* arm kprobe: install breakpoint in text */
>> diff --git a/arch/arm64/kernel/probes/opt-arm64.c
>> b/arch/arm64/kernel/probes/opt-arm64.c
>> new file mode 100644
>> index 000000000000..a0302e3ad62d
>> --- /dev/null
>> +++ b/arch/arm64/kernel/probes/opt-arm64.c
>> @@ -0,0 +1,225 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Code for Kernel probes Jump optimization.
>> + *
>> + * Copyright (C) 2021 Hisilicon Limited
>> + */
>> +
>> +#include <linux/jump_label.h>
>> +#include <linux/kprobes.h>
>> +
>> +#include <asm/cacheflush.h>
>> +#include <asm/insn.h>
>> +#include <asm/kprobes.h>
>> +
>> +
>> +#define TMPL_VAL_IDX \
>> +	(optprobe_template_val - optprobe_template_entry)
>> +#define TMPL_CALL_BACK \
>> +	(optprobe_template_call - optprobe_template_entry)
>> +#define TMPL_END_IDX \
>> +	(optprobe_template_end - optprobe_template_entry)
>> +#define TMPL_RESTORE_ORIGN_INSN \
>> +	(optprobe_template_restore_orig_insn - optprobe_template_entry)
>> +#define TMPL_RESTORE_END \
>> +	(optprobe_template_restore_end - optprobe_template_entry)
>> +
>> +int arch_check_optimized_kprobe(struct optimized_kprobe *op)
>> +{
>> +	return 0;
>> +}
>> +
>> +int arch_prepared_optinsn(struct arch_optimized_insn *optinsn)
>> +{
>> +	return optinsn->insn != NULL;
>> +}
>> +
>> +int arch_within_optimized_kprobe(struct optimized_kprobe *op,
>> +				unsigned long addr)
>> +{
>> +	return ((unsigned long)op->kp.addr <= addr &&
>> +		(unsigned long)op->kp.addr + RELATIVEJUMP_SIZE > addr);
>> +}
>> +
>> +static void
>> +optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs)
>> +{
>> +	/* This is possible if op is under delayed unoptimizing */
>> +	if (kprobe_disabled(&op->kp))
>> +		return;
>> +
>> +	preempt_disable();
>> +
>> +	if (kprobe_running()) {
>> +		kprobes_inc_nmissed_count(&op->kp);
>> +	} else {
>> +		__this_cpu_write(current_kprobe, &op->kp);
>> +		regs->pc = (unsigned long)op->kp.addr;
>> +		get_kprobe_ctlblk()->kprobe_status = KPROBE_HIT_ACTIVE;
>> +		opt_pre_handler(&op->kp, regs);
>> +		__this_cpu_write(current_kprobe, NULL);
>> +	}
>> +
>> +	preempt_enable_no_resched();
>> +}
>> +NOKPROBE_SYMBOL(optimized_callback)
>> +
>> +static bool is_offset_in_range(unsigned long start, unsigned long end)
>> +{
>> +	long offset = end - start;
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
>> +	return (offset >= -0x08000000 && offset <= 0x07fffffc && !(offset & 0x3));
>> +}
>> +
>> +int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe
>> *orig)
>> +{
>> +	kprobe_opcode_t *code;
>> +	u32 insn;
>> +	int ret, i;
>> +	void *addrs[TMPL_END_IDX];
>> +	void *addr;
>> +
>> +	code = get_optinsn_slot();
>> +	if (!code)
>> +		return -ENOMEM;
>> +
>> +	if (!is_offset_in_range((unsigned long)code,
>> +				(unsigned long)orig->addr + 8))
>> +		goto error;
>> +
>> +	if (!is_offset_in_range((unsigned long)code + TMPL_CALL_BACK,
>> +				(unsigned long)optimized_callback))
>> +		goto error;
>> +
>> +	if (!is_offset_in_range((unsigned long)&code[TMPL_RESTORE_END],
>> +				(unsigned long)op->kp.addr + 4))
>> +		goto error;
>> +
>> +	/* Setup template */
>> +	for (i = 0; i < TMPL_END_IDX; i++)
>> +		addrs[i] = code + i;
>> +
>> +	ret = aarch64_insn_patch_text(addrs, optprobe_template_entry,
>> +				      TMPL_END_IDX);
>> +	if (ret < 0)
>> +		goto error;
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
>> +
>> +	flush_icache_range((unsigned long)code,
>> +			   (unsigned long)(&code[TMPL_END_IDX]));
>> +	/* Set op->optinsn.insn means prepared. */
>> +	op->optinsn.insn = code;
>> +
>> +	return 0;
>> +
>> +error:
>> +	free_optinsn_slot(code, 0);
>> +	return -ERANGE;
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
>> +		aarch64_insn_patch_text_nosync((void*)op->kp.addr, insn);
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
>> diff --git a/arch/arm64/kernel/probes/optprobe_trampoline.S
>> b/arch/arm64/kernel/probes/optprobe_trampoline.S
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
>> --
>> 2.17.1
> 
> 
> Thanks
> Barry
> 
> .
> 


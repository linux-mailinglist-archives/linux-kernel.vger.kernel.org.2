Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F89640226C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 05:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhIGDPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 23:15:47 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:15300 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhIGDPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 23:15:46 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4H3VjZ1ZqSz8sqC;
        Tue,  7 Sep 2021 11:14:10 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Tue, 7 Sep 2021 11:14:38 +0800
Received: from [127.0.0.1] (10.69.38.203) by dggema757-chm.china.huawei.com
 (10.1.198.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Tue, 7 Sep
 2021 11:14:37 +0800
Subject: Re: [PATCH v4 2/2] arm64: kprobe: Enable OPTPROBE for arm64
To:     Mark Rutland <mark.rutland@arm.com>, Linuxarm <linuxarm@huawei.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <mhiramat@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <song.bao.hua@hisilicon.com>, <prime.zeng@hisilicon.com>,
        <robin.murphy@arm.com>, <f.fangjian@huawei.com>,
        <linux-kernel@vger.kernel.org>
References: <20210818073336.59678-1-liuqi115@huawei.com>
 <20210818073336.59678-3-liuqi115@huawei.com>
 <20210824105001.GA96738@C02TD0UTHF1T.local>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <30298ee9-4fff-2403-3828-2c2a8089e194@huawei.com>
Date:   Tue, 7 Sep 2021 11:14:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210824105001.GA96738@C02TD0UTHF1T.local>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.203]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mark,
Thanks for reviewing this patch.

On 2021/8/24 18:50, Mark Rutland wrote:
> Hi,
> 
> I have a bunch of comments below.
> 
> At a high-level, I'm not all that keen on adding yet another set of
> trampolines, especially given we have constraints on how we can branch
> to them which render this not that useful in common configurations (e.g.
> where KASLR and module randomization is enabled).
> 
> So importantly, do we actually need this? I don't think the sampel is
> that compelling since we can already use ftrace to measure function
> latencies.
> 
> If we do need this, I think we need to do some more substantial rework
> to address those branch range limitations. I know that we could permit
> arbitrary branching if we expand the ftrace-with-regs callsites to ~6
> instructions, but that interacts rather poorly with stacktracing and
> will make the kernel a bit bigger.
>

As Barry mentioned, kprobe do have some use in commercial scenarios, 
like https://gitee.com/xiebaoyou/diagnosis_tools, an open-source tool 
which is used by alibaba. So reduce the latency of kprobe has some 
practical value.

Branch limitation sometimes will make optprobe fall back to normal 
kprobe, but perhaps we could use this as the first step, and try PLT or 
some other methods to avoid the limitation latter.

> On Wed, Aug 18, 2021 at 03:33:36PM +0800, Qi Liu wrote:
>> This patch introduce optprobe for ARM64. In optprobe, probed
>> instruction is replaced by a branch instruction to detour
>> buffer. Detour buffer contains trampoline code and a call to
>> optimized_callback(). optimized_callback() calls opt_pre_handler()
>> to execute kprobe handler.

[...]

>> diff --git a/arch/arm64/include/asm/kprobes.h b/arch/arm64/include/asm/kprobes.h
>> index 5d38ff4a4806..6b2fdd2ad7d8 100644
>> --- a/arch/arm64/include/asm/kprobes.h
>> +++ b/arch/arm64/include/asm/kprobes.h
>> @@ -39,6 +39,30 @@ void arch_remove_kprobe(struct kprobe *);
>>   int kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr);
>>   int kprobe_exceptions_notify(struct notifier_block *self,
>>   			     unsigned long val, void *data);
>> +
>> +#define RELATIVEJUMP_SIZE (4)
>> +#define MAX_COPIED_INSN	DIV_ROUND_UP(RELATIVEJUMP_SIZE, sizeof(kprobe_opcode_t))
> 
> On arm64, instructions are always 4 bytes, so this can be:
> 
> | #define MAX_COPIED_INSN		AARCH64_INSN_SIZE
> 
> Note: AARCH64_INSN_SIZE == sizeof(kprobe_opcode_t), so either could be
> used here.
> 
got it, will change this.
>> +struct arch_optimized_insn {
>> +	kprobe_opcode_t copied_insn[MAX_COPIED_INSN];
> 
> This is always a single insn. For clarity, it would be nicer to call
> this something like `orig_insn`.
> 
>> +	/* detour code buffer */
>> +	kprobe_opcode_t *insn;
> 
> Could we call this `trampoline`?
> 
ok, will change this, thanks.
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
>> +extern __visible kprobe_opcode_t optprobe_template_max_length[];
> 
> Why is this called "max_length"? It's the end of the template, value
> included. Other architectures (e.g. arm) include that between
> optprobe_template_entry and optprobe_template_end, so I don't believe we
> need to separate that out.
> 
got it, will remove this next time, thanks.
>> +
>> +#define MAX_OPTIMIZED_LENGTH	4
> 
> As above, please define this as either AARCH64_INSN_SIZE or
> sizeof(kprobe_opcode_t).
> 
ok, will change this, thanks.
>> +#define MAX_OPTINSN_SIZE				\
>> +	((unsigned long)optprobe_template_end -	\
>> +	 (unsigned long)optprobe_template_entry)
> 
> As above, this seems to be the trampoline size minus the size of the
> value, which doesn't match other architectures, and doesn't seem right.
> The kprobe core code has:
> 
> | kprobe_optinsn_slots.insn_size = MAX_OPTINSN_SIZE;
> 
> ... which IIUC is used to alocate the buffers, so surely we *must* take
> the size of the value into account?
> >> +
>>   void kretprobe_trampoline(void);
>>   void __kprobes *trampoline_probe_handler(struct pt_regs *regs);
>>   
>> diff --git a/arch/arm64/kernel/probes/Makefile b/arch/arm64/kernel/probes/Makefile
>> index 8e4be92e25b1..07105fd3261d 100644
>> --- a/arch/arm64/kernel/probes/Makefile
>> +++ b/arch/arm64/kernel/probes/Makefile
>> @@ -4,3 +4,5 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o	\
>>   				   simulate-insn.o
>>   obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o	\
>>   				   simulate-insn.o
>> +obj-$(CONFIG_OPTPROBES)		+= opt_arm64.o			\
>> +				   optprobe_trampoline.o
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
>>   }
> 
> Today this is only used for xol pages, which don't need to live in the
> module space. Why is this not a separate function?
> 

I'm not clear about this, do you mean following set can be moved to a 
separate function? thanks.

set_vm_flush_reset_perms(page);
set_memory_ro((unsigned long)page, 1);
set_memory_x((unsigned long)page, 1);

>>   /* arm kprobe: install breakpoint in text */
>> diff --git a/arch/arm64/kernel/probes/opt_arm64.c b/arch/arm64/kernel/probes/opt_arm64.c

[...]
>> +int arch_check_optimized_kprobe(struct optimized_kprobe *op)
>> +{
>> +	return 0;
>> +}
>> +
> 
> The core code has the comment:
> 
> |	/* Check there is no other kprobes at the optimized instructions */
> |	if (arch_check_optimized_kprobe(op) < 0)
> |		return;
> 
> ... is that comment misleading, or do we need to do something here?
> 

In ARM64, kprobe opt always replace one instruction and it is impossible 
to encounter another kprobe in the address range. So always return 0.

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
> 
> Since we have a single instruction, and all instructions are naturally aligned 4 bytes, this can be:
> 
> |	return (unsigned long)op->kp.addr == addr;
> 
got it , will change this next time, thanks.
>> +
>> +static void
>> +optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs)
>> +{
>> +	/* This is possible if op is under delayed unoptimizing */
> 
> I see this is a copy-paste from x86 andor powerpc, but it's a bit hard
> to understand, and I'm not sure what it is trying to say. What scenario
> is this trying to handle?
> 
> I note that arch/arm doesn't seem to do this -- is that a bug?
> 

I think we should check the status of the op, if it is disabled, 
pre-handler should not be called.
And I guess this might be a bug of arm, but not sure...

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
> 
>  > The body of this looks like it could be factored out in to the core
> kprobes code if we had an arch hook to save any missed registers
> (apparently just the pc on arm64).

got it, I'll add a opt_callback() function in core kprobes to factor the 
body of this optimized_callback function. and add a op->set_regs() hook 
for each arch.

> 
>> +	preempt_enable_no_resched();
> 
> Why the `_no_resched` variant? I see that x86 just does a plain
> preempt_enable().
> 
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
>> +	 *   (0x01ffffff << 2) = 0x07fffffc
>> +	 * The maximum backward branch should be:
>> +	 *   (0xfe000000 << 2) = 0xFFFFFFFFF8000000 = -0x08000000
>> +	 *
>> +	 * We can simply check (rel & 0xf8000003):
>> +	 *  if rel is positive, (rel & 0xf8000003) should be 0
>> +	 *  if rel is negitive, (rel & 0xf8000003) should be 0xf8000000
>> +	 *  the last '3' is used for alignment checking.
>> +	 */
>> +	return (offset >= -0x8000000 && offset <= 0x7fffffc && !(offset & 0x3));
>> +}
> 
> Please re-use existing code for this. In insn.c we already have
> branch_imm_common() and aarch64_insn_gen_branch_imm(), which we should
> be able to refactor for easier usage (and should move ftrace_make_nop()
> over to that too).
> 
> We could *also* add a aarch64_insn_try_gen_branch_imm() helper that
> returns an error code rather than printing an error, which would allow
> us to consolidate the checks with the codegen, and would be more robust
> if this changes in future.
> 

Got it, I'll remove this function, and add a 
aarch64_insn_try_gen_branch_imm() in insn.c, like this:

bool aarch64_insn_try_gen_branch_imm(unsigned long pc, unsigned long addr,
				     long range)
{
	long offset;

	offset = branch_imm_common(pc, addr, SZ_128M);
	if (offset >= SZ_128M)
		return -ERANGE;

	return 0;
}

>> +
>> +int arch_prepare_optimized_kprobe(struct optimized_kprobe *op,
>> +				  struct kprobe *orig)
>> +{
>> +	kprobe_opcode_t *code, *buf;
>> +	void **addrs;
>> +	u32 insn;
>> +	int ret, i;
>> +
>> +	addrs = kcalloc(TMPL_MAX_LENGTH, sizeof(void *), GFP_KERNEL);
>> +	if (!addrs)
>> +		return -ENOMEM;
> 
> As a general thing, when using allocators, please use sizeof() on the
> pointer being allocated, e.g.
> 
> 	addrs = kcalloc(TMPL_MAX_LENGTH, sizeof(*addrs), GFP_KERNEL);
> 
> ... as that ensures the type is always correct, even if the type of the
> pointer is changed later.
> 
> That said, I don't believe this needs to be allocated from the heap.
> It's only used for the duration of this function, it's relatively small,
> and we could add a wrapper in insn.c to patch a range of instructions,
> which would avoid the need for the array entirely.
> 

as your comments below, aarch64_insn_patch_text() with stop_machine is 
not nessesary in this function, so addrs[] could be dropped here.

>> +
>> +	buf = kcalloc(TMPL_MAX_LENGTH, sizeof(kprobe_opcode_t), GFP_KERNEL);
>> +	if (!buf) {
>> +		kfree(addrs);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	code = get_optinsn_slot();
>> +	if (!code) {
>> +		kfree(addrs);
>> +		kfree(buf);
>> +		return -ENOMEM;
>> +	}
> 
> You can initialize `ret` to -ENOMEM, and goto `out` here.
> 
got it, thanks
>> +
>> +	if (!is_offset_in_range((unsigned long)code,
>> +				(unsigned long)orig->addr + 8)) {
>> +		ret = -ERANGE;
>> +		goto error;
>> +	}
>> +
>> +	if (!is_offset_in_range((unsigned long)code + TMPL_CALL_BACK,
>> +				(unsigned long)optimized_callback)) {
>> +		ret = -ERANGE;
>> +		goto error;
>> +	}
>> +
>> +	if (!is_offset_in_range((unsigned long)&code[TMPL_RESTORE_END],
>> +				(unsigned long)op->kp.addr + 4)) {
>> +		ret = -ERANGE;
>> +		goto error;
>> +	}
>> +
>> +	memcpy(buf, optprobe_template_entry,
>> +	       TMPL_END_IDX * sizeof(kprobe_opcode_t));
> 
> Why do we need to copy this into a temporary buffer? Can't we work on it
> directly in the destination?
> 

copy directly to destination will call aarch64_insn_patch_text() 
frequently, this will call too much stop_machine() and add delay(as 
Masami said).

>> +
>> +	buf[TMPL_VAL_IDX] = FIELD_GET(GENMASK(31, 0), (unsigned long long)op);
>> +	buf[TMPL_VAL_IDX + 1] =
>> +		FIELD_GET(GENMASK(63, 32), (unsigned long long)op);
> 
> This is a 64-bit pointer, and needs to be treated as a single unit. The
> above is broken for big-endian kernels.
> 
> Rather than using instruction indices (and pretending this pointer is
> two instructions), it would be nicer to use byte offsets consistently.
> 

got it, thanks, so I'll use memcpy here instead, thanks.
>> +	buf[TMPL_RESTORE_ORIGN_INSN] = orig->opcode;
>> +
>> +	insn = aarch64_insn_gen_branch_imm(
>> +		(unsigned long)(&code[TMPL_CALL_BACK]),
>> +		(unsigned long)optimized_callback, AARCH64_INSN_BRANCH_LINK);
>> +	buf[TMPL_CALL_BACK] = insn;
>> +
>> +	insn = aarch64_insn_gen_branch_imm(
>> +		(unsigned long)(&code[TMPL_RESTORE_END]),
>> +		(unsigned long)(op->kp.addr) + 4, AARCH64_INSN_BRANCH_NOLINK);
>> +	buf[TMPL_RESTORE_END] = insn;
>> +
>> +	/* Setup template */
>> +	for (i = 0; i < TMPL_MAX_LENGTH; i++)
>> +		addrs[i] = code + i;
>> +
>> +	ret = aarch64_insn_patch_text(addrs, buf, TMPL_MAX_LENGTH);
>> +	if (ret < 0)
>> +		goto error;
> 
> This does a stop_machine(), which isn't strictly necessary here if we
> write the buffer *then* swing the direct branch.
> 

got it, so I'll use aarch64_insn_patch_text_nosync() instead. thanks.
>> +
>> +	flush_icache_range((unsigned long)code,
>> +			   (unsigned long)(&code[TMPL_END_IDX]));
>> +
>> +	/* Set op->optinsn.insn means prepared. */
>> +	op->optinsn.insn = code;
>> +
>> +out:
>> +	kfree(addrs);
>> +	kfree(buf);
>> +	return ret;
>> +
>> +error:
>> +	free_optinsn_slot(code, 0);
>> +	goto out;
>> +}
>> +
>> +void arch_optimize_kprobes(struct list_head *oplist)
>> +{
>> +	struct optimized_kprobe *op, *tmp;
>> +	kprobe_opcode_t *insns;
>> +	void **addrs;
>> +	int i = 0;
>> +
>> +	addrs = kcalloc(OPTPROBE_BATCH_SIZE, sizeof(void *), GFP_KERNEL);
>> +	if (!addrs)
>> +		return;
>> +
>> +	insns = kcalloc(OPTPROBE_BATCH_SIZE, sizeof(kprobe_opcode_t), GFP_KERNEL);
>> +	if (!insns) {
>> +		kfree(addrs);
>> +		return;
>> +	}
> 
> Why do these need to be dynamically allocated? They have small fixed
> sizes.
> 
got it, will change this next time.
>> +
>> +	list_for_each_entry_safe(op, tmp, oplist, list) {
>> +		WARN_ON(kprobe_disabled(&op->kp));
>> +
>> +		/*
>> +		 * Backup instructions which will be replaced
>> +		 * by jump address
>> +		 */
>> +		memcpy(op->optinsn.copied_insn, op->kp.addr,
>> +			RELATIVEJUMP_SIZE);
> 
> Hmmm... how does this end up getting restored? This hasn't been through
> an le32_to_cpu(), so if we patch it back with the usual insn functions
> we'll restore the wrong thing on a big-endian kernel.

op->optinsn.copied_insn should be a "kprobe_opcode_t copied_insn[1];", 
so we copy a u32 insn to copied_insn[1], and don't need to worry about 
the endian problem here.

> 
>> +		addrs[i] = (void *)op->kp.addr;
>> +		insns[i] = aarch64_insn_gen_branch_imm((unsigned long)op->kp.addr,
>> +				(unsigned long)op->optinsn.insn,
>> +				AARCH64_INSN_BRANCH_NOLINK);
>> +
>> +		list_del_init(&op->list);
>> +		if (++i == OPTPROBE_BATCH_SIZE)
>> +			break;
>> +	}
> 
> What happens if the list was bigger than OPTPROBE_BATCH_SIZE?
> 

Will fall back to normal kprobe.

As Masami's comment in V3 patchset, we add a buffer to store all the 
optprobes' insntructions and call aarch64_insn_patch_text() only once.

https://lore.kernel.org/lkml/20210811162004.9b3349e6bda68e74e0a3a4ad@kernel.org/
>> +
>> +	aarch64_insn_patch_text(addrs, insns, i);
>> +	kfree(addrs);
>> +	kfree(insns);
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
>> +	kprobe_opcode_t *insns;
>> +	void **addrs;
>> +	int i = 0;
>> +
>> +	addrs = kcalloc(OPTPROBE_BATCH_SIZE, sizeof(void *), GFP_KERNEL);
>> +	if (!addrs)
>> +		return;
>> +
>> +	insns = kcalloc(OPTPROBE_BATCH_SIZE, sizeof(kprobe_opcode_t), GFP_KERNEL);
>> +	if (!insns) {
>> +		kfree(addrs);
>> +		return;
>> +	}
> 
> Again, I do not think these need to be dynamically allocated.
> 
got it.
>> +
>> +	list_for_each_entry_safe(op, tmp, oplist, list) {
>> +		addrs[i] = (void *)op->kp.addr;
>> +		insns[i] = BRK64_OPCODE_KPROBES;
>> +		list_move(&op->list, done_list);
>> +
>> +		if (++i == OPTPROBE_BATCH_SIZE)
>> +			break;
> 
> What happens if the list was larger rthan OPTPROBE_BATCH_SIZE ?
> 

Will fall back to normal kprobe.
>> +	}
>> +
>> +	aarch64_insn_patch_text(addrs, insns, i);
>> +	kfree(addrs);
>> +	kfree(insns);
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
> 
> Please use SYM_*(); see arch/arm64/kernel/entry-ftrace.S for examples of
> how to use that for trampolines.
> 
> This should be:
> 
> SYM_CODE_START(optprobe_template)
> 
> ... and note the matching end below.
> 
got it , thanks.
>> +	sub sp, sp, #PT_REGS_SIZE
>> +	save_all_base_regs
>> +	/* Get parameters to optimized_callback() */
>> +	ldr	x0, 1f
>> +	mov	x1, sp
>> +	/* Branch to optimized_callback() */
>> +	.global optprobe_template_call
>> +optprobe_template_call:
> 
> SYM_INNER_LABEL(optprobe_template_call, SYM_L_GLOBAL)
> 
> ...and likewise for all the other labels.
> 
ok, will change this next time.

Thanks for your review,
Qi

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
> 
> SYM_INNER_LABEL(optprobe_template_end, SYM_L_GLOBAL)
> SYM_CODE_END(optprobe_template)
> 
> Thanks,
> Mark.
> 
>> -- 
>> 2.17.1
>>
> .
> 


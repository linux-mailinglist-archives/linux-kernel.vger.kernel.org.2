Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148033E4015
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 08:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbhHIGdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 02:33:41 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8382 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbhHIGdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 02:33:40 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GjmQB4mv8z85TP;
        Mon,  9 Aug 2021 14:29:22 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 14:33:17 +0800
Received: from [127.0.0.1] (10.69.38.203) by dggema757-chm.china.huawei.com
 (10.1.198.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 9 Aug
 2021 14:33:17 +0800
Subject: Re: [PATCH v2] arm64: kprobe: Enable OPTPROBE for arm64
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Linuxarm <linuxarm@huawei.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <linux-arm-kernel@lists.infradead.org>,
        <song.bao.hua@hisilicon.com>, <prime.zeng@hisilicon.com>,
        <robin.murphy@arm.com>, <f.fangjian@huawei.com>,
        <linux-kernel@vger.kernel.org>
References: <20210804060209.95817-1-liuqi115@huawei.com>
 <20210805105401.4acd3217c566b4e3933f355c@kernel.org>
 <d3e0c9ee-19b5-8042-d251-05348e8ac49e@huawei.com>
 <20210806014435.a1b6d7900e0e72599a8e325f@kernel.org>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <7aead513-7ce5-7761-70d0-d83fe127c486@huawei.com>
Date:   Mon, 9 Aug 2021 14:33:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210806014435.a1b6d7900e0e72599a8e325f@kernel.org>
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



On 2021/8/6 0:44, Masami Hiramatsu wrote:
> On Thu, 5 Aug 2021 17:25:17 +0800
> "liuqi (BA)" <liuqi115@huawei.com> wrote:
> 
>>
>> Hi Masami,
>>
>> On 2021/8/5 9:54, Masami Hiramatsu wrote:
>>> On Wed, 4 Aug 2021 14:02:09 +0800
>>> Qi Liu <liuqi115@huawei.com> wrote:
>>>
>>>> This patch introduce optprobe for ARM64. In optprobe, probed
>>>> instruction is replaced by a branch instruction to detour
>>>> buffer. Detour buffer contains trampoline code and a call to
>>>> optimized_callback(). optimized_callback() calls opt_pre_handler()
>>>> to execute kprobe handler.
>>>>
>>>> Limitations:
>>>> - We only support !CONFIG_RANDOMIZE_MODULE_REGION_FULL case to
>>>> guarantee the offset between probe point and kprobe pre_handler
>>>> is not larger than 128MiB.
>>>>
>>>> Performance of optprobe on Hip08 platform is test using kprobe
>>>> example module[1] to analyze the latency of a kernel function,
>>>> and here is the result:
>>>>
>>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/kprobes/kretprobe_example.c
>>>>
>>>> kprobe before optimized:
>>>> [280709.846380] do_empty returned 0 and took 1530 ns to execute
>>>> [280709.852057] do_empty returned 0 and took 550 ns to execute
>>>> [280709.857631] do_empty returned 0 and took 440 ns to execute
>>>> [280709.863215] do_empty returned 0 and took 380 ns to execute
>>>> [280709.868787] do_empty returned 0 and took 360 ns to execute
>>>> [280709.874362] do_empty returned 0 and took 340 ns to execute
>>>> [280709.879936] do_empty returned 0 and took 320 ns to execute
>>>> [280709.885505] do_empty returned 0 and took 300 ns to execute
>>>> [280709.891075] do_empty returned 0 and took 280 ns to execute
>>>> [280709.896646] do_empty returned 0 and took 290 ns to execute
>>>> [280709.902220] do_empty returned 0 and took 290 ns to execute
>>>> [280709.907807] do_empty returned 0 and took 290 ns to execute
>>>>
>>>> optprobe:
>>>> [ 2965.964572] do_empty returned 0 and took 90 ns to execute
>>>> [ 2965.969952] do_empty returned 0 and took 80 ns to execute
>>>> [ 2965.975332] do_empty returned 0 and took 70 ns to execute
>>>> [ 2965.980714] do_empty returned 0 and took 60 ns to execute
>>>> [ 2965.986128] do_empty returned 0 and took 80 ns to execute
>>>> [ 2965.991507] do_empty returned 0 and took 70 ns to execute
>>>> [ 2965.996884] do_empty returned 0 and took 70 ns to execute
>>>> [ 2966.002262] do_empty returned 0 and took 80 ns to execute
>>>> [ 2966.007642] do_empty returned 0 and took 70 ns to execute
>>>> [ 2966.013020] do_empty returned 0 and took 70 ns to execute
>>>> [ 2966.018400] do_empty returned 0 and took 70 ns to execute
>>>> [ 2966.023779] do_empty returned 0 and took 70 ns to execute
>>>> [ 2966.029158] do_empty returned 0 and took 70 ns to execute
>>>>
>>>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>>>>
>>>> ---
>>>>
>>>> Changes since V1:
>>>> - Address the comments from Masami, checks for all branch instructions, and
>>>> use aarch64_insn_patch_text_nosync() instead of aarch64_insn_patch_text()
>>>> in each probe.
>>>
>>> Is it safe for the multicore system? If it is safe because it modifies
>>> just one instruction (modifying 32bit in atomic), I understand it.
>>
>> Seems raw_spin_lock_irqsave is used in aarch64_insn_patch_text_nosync()
>> and spinlock could support a protection in multicore system.
> 
> No, that is not what I meant. stop_machine() will ensure that the all other
> cores parking in the safe area, so the target instruction will never be
> executed while modifying the code.
> Even if you use the spinlock, other cores don't stop unless it tries
> to lock the same spinlock. And they are possible to execute the instruction
> which you are modifying.
> 

got it, thanks, so I think aarch64_insn_patch_text_nosync() is not 
suitable for arch_optimize_kprobes, as stop_machine is indispensables here.
I also checked x86 opt.c, text_poke_bp() is used to modify the 
instruction, seems it calls do_sync_core and make sure other core will 
not execute the modifying instruction.

>>> BTW, anyway, you should use _nosync() variant in arch_prepare_optimized_kprobe()
>>> too, beacause the optprobe insn buffer is not touched until the probed instruction
>>> is optimized by br.
>>>
>> Yes, sounds resonable.
>>> [...]
>>>> +int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *orig)
>>>> +{
>>>> +	kprobe_opcode_t *code;
>>>> +	u32 insn;
>>>> +	int ret, i;
>>>> +	void *addrs[TMPL_END_IDX];
>>>> +	void *addr;
>>>> +
>>>> +	code = get_optinsn_slot();
>>>> +	if (!code)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	if (!is_offset_in_range((unsigned long)code,
>>>> +				(unsigned long)orig->addr + 8))
>>>> +		goto error;
>>>> +
>>>> +	if (!is_offset_in_range((unsigned long)code + TMPL_CALL_BACK,
>>>> +				(unsigned long)optimized_callback))
>>>> +		goto error;
>>>> +
>>>> +	if (!is_offset_in_range((unsigned long)&code[TMPL_RESTORE_END],
>>>> +				(unsigned long)op->kp.addr + 4))
>>>> +		goto error;
>>>> +
>>>> +	/* Setup template */
>>>> +	for (i = 0; i < TMPL_END_IDX; i++)
>>>> +		addrs[i] = code + i;
>>>> +
>>>> +	ret = aarch64_insn_patch_text(addrs, optprobe_template_entry,
>>>> +				      TMPL_END_IDX);
>>>
>>> You should use aarch64_insn_patch_text_nosync() here (and all the
>>> aarch64_insn_patch_text() in this function too), because the insn
>>> buffer must not executed until the probe point is optimized.
>>>
>> aarch64_insn_patch_text() could patch multi instructions to code[] each
>> time and aarch64_insn_patch_text_nosync() could only patch one
>> instruction each time,
> 
> Ah, right.
> 
>> so maybe aarch64_insn_patch_text() is better here.
>>
>> I'll replace other aarch64_insn_patch_text() in this function.
> 
> Could you see x86 optprobe code what it does?
> I prepare another writable buffer and build the trampoline code
> on it. Finally patch the code on the insn buffer at once.
> You can do the same thing here.
> 
> Thank you,
> 

Got it, I'll add this in next version.

Thanks,
Qi
>>
>> Thanks,
>> Qi
>>
>>>> +	if (ret < 0)
>>>> +		goto error;
>>>> +
>>>> +	/* Set probe information */
>>>> +	addr = code + TMPL_VAL_IDX;
>>>> +	insn =  (unsigned long long)op & 0xffffffff;
>>>> +	aarch64_insn_patch_text(&addr, &insn, 1);
>>>> +
>>>> +	addr = addr + 4;
>>>> +	insn = ((unsigned long long)op & GENMASK_ULL(63, 32)) >> 32;
>>>> +	aarch64_insn_patch_text(&addr, &insn, 1);
>>>> +
>>>> +	addr = code + TMPL_CALL_BACK;
>>>> +	insn =  aarch64_insn_gen_branch_imm((unsigned long)addr,
>>>> +				(unsigned long)optimized_callback,
>>>> +				AARCH64_INSN_BRANCH_LINK);
>>>> +	aarch64_insn_patch_text(&addr, &insn, 1);
>>>> +
>>>> +	/* The original probed instruction */
>>>> +	addr = code + TMPL_RESTORE_ORIGN_INSN;
>>>> +	insn =  orig->opcode;
>>>> +	aarch64_insn_patch_text(&addr, &insn, 1);
>>>> +
>>>> +	/* Jump back to next instruction */
>>>> +	addr = code + TMPL_RESTORE_END;
>>>> +	insn = aarch64_insn_gen_branch_imm(
>>>> +				(unsigned long)(&code[TMPL_RESTORE_END]),
>>>> +				(unsigned long)(op->kp.addr) + 4,
>>>> +				AARCH64_INSN_BRANCH_NOLINK);
>>>> +	aarch64_insn_patch_text(&addr, &insn, 1);
>>>> +
>>>> +	flush_icache_range((unsigned long)code,
>>>> +			   (unsigned long)(&code[TMPL_END_IDX]));
>>>> +	/* Set op->optinsn.insn means prepared. */
>>>> +	op->optinsn.insn = code;
>>>> +
>>>> +	return 0;
>>>
>>> Thank you,
>>>
>>>
>>>
>>
> 
> 


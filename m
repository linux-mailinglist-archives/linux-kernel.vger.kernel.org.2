Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46102460F00
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 07:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhK2Gzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 01:55:44 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:28186 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbhK2Gxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 01:53:43 -0500
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4J2bXX2ZStz8vh7;
        Mon, 29 Nov 2021 14:48:28 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 14:50:24 +0800
Received: from [10.67.102.185] (10.67.102.185) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 14:50:23 +0800
Subject: Re: [PATCH v4 2/2] arm64: kprobe: Enable OPTPROBE for arm64
To:     Masami Hiramatsu <mhiramat@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <naveen.n.rao@linux.ibm.com>,
        <anil.s.keshavamurthy@intel.com>, <davem@davemloft.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <song.bao.hua@hisilicon.com>, <prime.zeng@hisilicon.com>,
        <robin.murphy@arm.com>, <f.fangjian@huawei.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
References: <20210818073336.59678-1-liuqi115@huawei.com>
 <20210818073336.59678-3-liuqi115@huawei.com>
 <20210824105001.GA96738@C02TD0UTHF1T.local>
 <aebcfbcb-eded-ff48-9d1f-2a93539575ca@huawei.com>
 <20211127212302.f71345c34e5a62e5e779adb2@kernel.org>
 <4998f219-eb47-a07c-b3ed-c2ae46a77230@huawei.com>
 <20211129140040.87c5f423a72c95c90602c2c6@kernel.org>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <3f8c1754-b677-971c-2e04-a04678206424@huawei.com>
Date:   Mon, 29 Nov 2021 14:50:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20211129140040.87c5f423a72c95c90602c2c6@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.185]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/29 13:00, Masami Hiramatsu wrote:
> On Mon, 29 Nov 2021 09:40:30 +0800
> "liuqi (BA)" <liuqi115@huawei.com> wrote:
> 
>>
>>
>> On 2021/11/27 20:23, Masami Hiramatsu wrote:
>>> On Fri, 26 Nov 2021 18:31:06 +0800
>>> "liuqi (BA)" <liuqi115@huawei.com> wrote:
>>>
>>>>
>>>>
>>>> On 2021/8/24 18:50, Mark Rutland wrote:
>>>>>> diff --git a/arch/arm64/kernel/probes/optprobe_trampoline.S b/arch/arm64/kernel/probes/optprobe_trampoline.S
>>>>>> new file mode 100644
>>>>>> index 000000000000..24d713d400cd
>>>>>> --- /dev/null
>>>>>> +++ b/arch/arm64/kernel/probes/optprobe_trampoline.S
>>>>>> @@ -0,0 +1,37 @@
>>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>>>> +/*
>>>>>> + * trampoline entry and return code for optprobes.
>>>>>> + */
>>>>>> +
>>>>>> +#include <linux/linkage.h>
>>>>>> +#include <asm/asm-offsets.h>
>>>>>> +#include <asm/assembler.h>
>>>>>> +
>>>>>> +	.global optprobe_template_entry
>>>>>> +optprobe_template_entry:
>>>>> Please use SYM_*(); see arch/arm64/kernel/entry-ftrace.S for examples of
>>>>> how to use that for trampolines.
>>>>>
>>>>> This should be:
>>>>>
>>>>> SYM_CODE_START(optprobe_template)
>>>>>
>>>> Hi all,
>>>>
>>>> I meet a problem when I use SYM_CODE_START(optprobe_template) to replace
>>>> optprobe_template_entry.
>>>>
>>>> If SYM_CODE_START is used, all optprobe will share one trampoline space.
>>>> Under this circumstances, if user register two optprobes, trampoline
>>>> will be overwritten by the newer one, and this will cause kernel panic
>>>> when the old optprobe is trigger.
>>>
>>> Hm, this is curious, because the template should be copied to the
>>> trampoline buffer for each optprobe and be modified.
>>>
>>>>
>>>> Using optprobe_template_entry will not have this problem, as each
>>>> optprobe has its own trampoline space (alloced in get_opinsn_slot()).
>>>
>>> Yes, it is designed to do so.
>>>
>>> Thank you,
>>>
>>
>> Hi Masami,
>>
>> Thanks for your reply. But I also met a problem when using
>> get_opinsn_slot() to alloc trampoline buffer.
>>
>> As module_alloc(like x86) is used to alloc buffer, trampoline is in
>> module space, so if origin insn is in kernel space, the range between
>> origin insn and trampoline is out of 128M.
>>
>> As module PLT cannot used here, I have no idea to achieve long jump in
>> this situation. Do you have any good idea?
> 
Hi Masami,

Thanks so much for your reply.

> One possible solution is to use pre-allocated trampoline space in
> the text area, as same as ppc64 does.
> (See arch/powerpc/kernel/optprobes_head.S, it embeds a space at "optinsn_slot")
> 

I find something interesting in arch/powerpc/kernel/optprobes.c, it use 
"optinsn_slot" as a public buffer, and use a static "insn_page_in_use" 
to make sure there is only one optprobe in kernel.

If we use this solution , users could only register one optprobe each 
time. This will also be a limitation for users, what's your opinion 
about this?


> Also, the trampoline can be minimized, since what we need is the
> probed address (and the address of struct optprobe).
> A single trampoline entry will do the following;
> 
> 1. push lr and a victim register (here, x0)
> 2. load the address of optprobe to x0
> 3. call(br) common-optprobe asm code
> 4. pop lr and x0
> 5. jump back to (next to) the original place
> 
> Here the common-optprobe asm code does;
> 
> c1. push all registers on the stack (like save_all_base_regs) for making
>    struct pt_regs.
> c2. set the pt_regs address to x1.
> c3. call optimized_callback()
> c4. return
> 
> Since arm64 will emulate the probed instruction, we can do this.
> (On the other hand, x86 needs to run the probed insn in trampoline
>   code, it will do that between step 4 and 5)
> 

I'll try to minimize the trampoline according to this,

Thanks,
Qi
> The trampoline entry code is just 5 instructions (but may need an
> immediate value (&optprobe) needs to be embedded).
> 
> Thank you,
> 
>>
>> Thanks,
>> Qi
>>
>>>>
>>>> So how to reuse SYM_CODE_START  in this situation, does anyone has a
>>>> good idea?
>>>>
>>>> Thanks,
>>>> Qi
>>>>> ... and note the matching end below.
>>>>>
>>>>>> +	sub sp, sp, #PT_REGS_SIZE
>>>>>> +	save_all_base_regs
>>>>>> +	/* Get parameters to optimized_callback() */
>>>>>> +	ldr	x0, 1f
>>>>>> +	mov	x1, sp
>>>>>> +	/* Branch to optimized_callback() */
>>>>>> +	.global optprobe_template_call
>>>>>> +optprobe_template_call:
>>>>> SYM_INNER_LABEL(optprobe_template_call, SYM_L_GLOBAL)
>>>>>
>>>>> ...and likewise for all the other labels.
>>>>>
>>>>>> +	nop
>>>>>> +	restore_all_base_regs
>>>>>> +	ldr lr, [sp, #S_LR]
>>>>>> +        add sp, sp, #PT_REGS_SIZE
>>>>>> +	.global optprobe_template_restore_orig_insn
>>>>>> +optprobe_template_restore_orig_insn:
>>>>>> +	nop
>>>>>> +	.global optprobe_template_restore_end
>>>>>> +optprobe_template_restore_end:
>>>>>> +	nop
>>>>>> +	.global optprobe_template_end
>>>>>> +optprobe_template_end:
>>>>>> +	.global optprobe_template_val
>>>>>> +optprobe_template_val:
>>>>>> +	1:	.long 0
>>>>>> +		.long 0
>>>>>> +	.global optprobe_template_max_length
>>>>>> +optprobe_template_max_length:
>>>>> SYM_INNER_LABEL(optprobe_template_end, SYM_L_GLOBAL)
>>>>> SYM_CODE_END(optprobe_template)
>>>>>
>>>>> Thanks,
>>>>> Mark.
>>>>>
>>>>>> -- 
>>>
>>>
> 
> 

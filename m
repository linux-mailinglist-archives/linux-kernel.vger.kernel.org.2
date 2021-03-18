Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DE93406C6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 14:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhCRNWy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 18 Mar 2021 09:22:54 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3043 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhCRNWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:22:37 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4F1SKv59cMzWMtk;
        Thu, 18 Mar 2021 21:19:31 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 18 Mar 2021 21:22:34 +0800
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Mar 2021 21:22:34 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2106.013;
 Thu, 18 Mar 2021 21:22:34 +0800
From:   "chenjun (AM)" <chenjun102@huawei.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "will@kernel.org" <will@kernel.org>,
        "Xiangrui (Euler)" <rui.xiang@huawei.com>,
        Mark Brown <broonie@kernel.org>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH 2/2] arm64: stacktrace: Add skip when task == current
Thread-Topic: [PATCH 2/2] arm64: stacktrace: Add skip when task == current
Thread-Index: AQHXGzmzVCWLNYUND0iAKn2NT1sSPA==
Date:   Thu, 18 Mar 2021 13:22:34 +0000
Message-ID: <85a1dd4a5ccf4f9fb419e7ea760d9843@huawei.com>
References: <20210317142050.57712-1-chenjun102@huawei.com>
 <20210317142050.57712-3-chenjun102@huawei.com>
 <20210317183636.GG12269@arm.com> <20210317193416.GB9786@C02TD0UTHF1T.local>
 <75f39d3e2a38438fab5a3ca79e296d73@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.178.53]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2021/3/18 11:31, chenjun (AM) 写道:
> 在 2021/3/18 3:34, Mark Rutland 写道:
>> On Wed, Mar 17, 2021 at 06:36:36PM +0000, Catalin Marinas wrote:
>>> On Wed, Mar 17, 2021 at 02:20:50PM +0000, Chen Jun wrote:
>>>> On ARM64, cat /sys/kernel/debug/page_owner, all pages return the same
>>>> stack:
>>>>    stack_trace_save+0x4c/0x78
>>>>    register_early_stack+0x34/0x70
>>>>    init_page_owner+0x34/0x230
>>>>    page_ext_init+0x1bc/0x1dc
>>>>
>>>> The reason is that:
>>>> check_recursive_alloc always return 1 because that
>>>> entries[0] is always equal to ip (__set_page_owner+0x3c/0x60).
>>>>
>>>> The root cause is that:
>>>> commit 5fc57df2f6fd ("arm64: stacktrace: Convert to ARCH_STACKWALK")
>>>> make the save_trace save 2 more entries.
>>>>
>>>> Add skip in arch_stack_walk when task == current.
>>>>
>>>> Fixes: 5fc57df2f6fd ("arm64: stacktrace: Convert to ARCH_STACKWALK")
>>>> Signed-off-by: Chen Jun <chenjun102@huawei.com>
>>>> ---
>>>>    arch/arm64/kernel/stacktrace.c | 5 +++--
>>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
>>>> index ad20981..c26b0ac 100644
>>>> --- a/arch/arm64/kernel/stacktrace.c
>>>> +++ b/arch/arm64/kernel/stacktrace.c
>>>> @@ -201,11 +201,12 @@ void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
>>>>    
>>>>    	if (regs)
>>>>    		start_backtrace(&frame, regs->regs[29], regs->pc);
>>>> -	else if (task == current)
>>>> +	else if (task == current) {
>>>> +		((struct stacktrace_cookie *)cookie)->skip += 2;
>>>>    		start_backtrace(&frame,
>>>>    				(unsigned long)__builtin_frame_address(0),
>>>>    				(unsigned long)arch_stack_walk);
>>>> -	else
>>>> +	} else
>>>>    		start_backtrace(&frame, thread_saved_fp(task),
>>>>    				thread_saved_pc(task));
>>>
>>> I don't like abusing the cookie here. It's void * as it's meant to be an
>>> opaque type. I'd rather skip the first two frames in walk_stackframe()
>>> instead before invoking fn().
>>
>> I agree that we shouldn't touch cookie here.
>>
>> I don't think that it's right to bodge this inside walk_stackframe(),
>> since that'll add bogus skipping for the case starting with regs in the
>> current task. If we need a bodge, it has to live in arch_stack_walk()
>> where we set up the initial unwinding state.
>>
>> In another thread, we came to the conclusion that arch_stack_walk()
>> should start at its parent, and its parent should add any skipping it
>> requires.
>>
>> Currently, arch_stack_walk() is off-by-one, and we can bodge that by
>> using __builtin_frame_address(1), though I'm waiting for some compiler
>> folk to confirm that's sound. Otherwise we need to add an assembly
>> trampoline to snapshot the FP, which is unfortunastely convoluted.
>>
>> This report suggests that a caller of arch_stack_walk() is off-by-one
>> too, which suggests a larger cross-architecture semantic issue. I'll try
>> to take a look tomorrow.
>>
>> Thanks,
>> Mark.
>>
>>>
>>> Prior to the conversion to ARCH_STACKWALK, we were indeed skipping two
>>> more entries in __save_stack_trace() if tsk == current. Something like
>>> below, completely untested:
>>>
>>> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
>>> index ad20981dfda4..2a9f759aa41a 100644
>>> --- a/arch/arm64/kernel/stacktrace.c
>>> +++ b/arch/arm64/kernel/stacktrace.c
>>> @@ -115,10 +115,15 @@ NOKPROBE_SYMBOL(unwind_frame);
>>>    void notrace walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
>>>    			     bool (*fn)(void *, unsigned long), void *data)
>>>    {
>>> +	/* for the current task, we don't want this function nor its caller */
>>> +	int skip = tsk == current ? 2 : 0;
>>> +
>>>    	while (1) {
>>>    		int ret;
>>>    
>>> -		if (!fn(data, frame->pc))
>>> +		if (skip)
>>> +			skip--;
>>> +		else if (!fn(data, frame->pc))
>>>    			break;
>>>    		ret = unwind_frame(tsk, frame);
>>>    		if (ret < 0)
>>>
>>>
>>> -- 
>>> Catalin
>>
> 
> This change will make kmemleak broken.
> Maybe the reason is what Mark pointed out. I will try to check out.
> 

I make a mistake. kmemleak seems to work good. I will do more tests.

-- 
Regards
Chen Jun

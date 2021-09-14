Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673C140ACCA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 13:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbhINLwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 07:52:14 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:16253 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbhINLuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 07:50:14 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4H81nZ4t72z8t1Z;
        Tue, 14 Sep 2021 19:48:18 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 14 Sep 2021 19:48:54 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 14 Sep 2021 19:48:54 +0800
Subject: Re: [PATCH] arm64: entry: Improve the performance of system calls
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
To:     Mark Rutland <mark.rutland@arm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210903121950.2284-1-thunder.leizhen@huawei.com>
 <20210914095436.GA26544@C02TD0UTHF1T.local>
 <1156204d-b48f-8416-a805-78274463bc81@huawei.com>
Message-ID: <059eeb9e-ad18-d66f-74b9-6f06f5a954d2@huawei.com>
Date:   Tue, 14 Sep 2021 19:48:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1156204d-b48f-8416-a805-78274463bc81@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/9/14 19:23, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/9/14 17:55, Mark Rutland wrote:
>> Hi,
>>
>> On Fri, Sep 03, 2021 at 08:19:50PM +0800, Zhen Lei wrote:
>>> Commit 582f95835a8f ("arm64: entry: convert el0_sync to C") converted lots
>>> of functions from assembly to C, this greatly improves readability. But
>>> el0_svc()/el0_svc_compat() is in response to system call requests from
>>> user mode and may be in the hot path.
>>>
>>> Although the SVC is in the first case of the switch statement in C, the
>>> compiler optimizes the switch statement as a whole, and does not give SVC
>>> a small boost.
>>>
>>> Use "likely()" to help SVC directly invoke its handler after a simple
>>> judgment to avoid entering the switch table lookup process.
>>>
>>> After:
>>> 0000000000000ff0 <el0t_64_sync_handler>:
>>>      ff0:       d503245f        bti     c
>>>      ff4:       d503233f        paciasp
>>>      ff8:       a9bf7bfd        stp     x29, x30, [sp, #-16]!
>>>      ffc:       910003fd        mov     x29, sp
>>>     1000:       d5385201        mrs     x1, esr_el1
>>>     1004:       531a7c22        lsr     w2, w1, #26
>>>     1008:       f100545f        cmp     x2, #0x15
>>>     100c:       540000a1        b.ne    1020 <el0t_64_sync_handler+0x30>
>>>     1010:       97fffe14        bl      860 <el0_svc>
>>>     1014:       a8c17bfd        ldp     x29, x30, [sp], #16
>>>     1018:       d50323bf        autiasp
>>>     101c:       d65f03c0        ret
>>>     1020:       f100705f        cmp     x2, #0x1c
>>
>> It would be helpful if you could state which toolchain and config was
>> used to generate the above.
> 
> gcc version 7.3.0 (GCC), make defconfig
> 
>>
>> For comparison, what was the code generation like before? I assume
>> el0_svc wasn't the target of the first test and branch? Assuming so, how
>> many tests and branches were there before the call to el0_svc()?
> 

Sorry, the old assembly code was not compiled with the latest mainline.
But the key point is no different.

0000000000000fe0 <el0t_64_sync_handler>:
     fe0:       d503233f        paciasp
     fe4:       a9bf7bfd        stp     x29, x30, [sp, #-16]!
     fe8:       910003fd        mov     x29, sp
     fec:       d5385201        mrs     x1, esr_el1
     ff0:       531a7c22        lsr     w2, w1, #26
     ff4:       f100f05f        cmp     x2, #0x3c
     ff8:       54000068        b.hi    1004 <el0t_64_sync_handler+0x24>  // b.pmore
     ffc:       7100f05f        cmp     w2, #0x3c
    1000:       540000c9        b.ls    1018 <el0t_64_sync_handler+0x38>  // b.plast
    1004:       97fffce9        bl      3a8 <el0_inv>
    1008:       a8c17bfd        ldp     x29, x30, [sp], #16
    100c:       d50323bf        autiasp
    1010:       d65f03c0        ret
    1014:       d503201f        nop
    1018:       90000003        adrp    x3, 0 <el0_da>
    101c:       91000063        add     x3, x3, #0x0
    1020:       38624862        ldrb    w2, [x3, w2, uxtw]
    1024:       10000063        adr     x3, 1030 <el0t_64_sync_handler+0x50>
    1028:       8b228862        add     x2, x3, w2, sxtb #2
    102c:       d61f0040        br      x2
    1030:       97fffc3a        bl      118 <el0_dbg>
    1034:       17fffff5        b       1008 <el0t_64_sync_handler+0x28>
    1038:       97fffc96        bl      290 <el0_fpsimd_exc>
    103c:       17fffff3        b       1008 <el0t_64_sync_handler+0x28>
    1040:       97fffc08        bl      60 <el0_sp>
    1044:       17fffff1        b       1008 <el0t_64_sync_handler+0x28>
    1048:       97fffbee        bl      0 <el0_da>
    104c:       17ffffef        b       1008 <el0t_64_sync_handler+0x28>
    1050:       97fffeea        bl      bf8 <el0_pc>
    1054:       17ffffed        b       1008 <el0t_64_sync_handler+0x28>
    1058:       97fffeb2        bl      b20 <el0_ia>
    105c:       17ffffeb        b       1008 <el0t_64_sync_handler+0x28>
    1060:       97fffc46        bl      178 <el0_fpac>
    1064:       17ffffe9        b       1008 <el0t_64_sync_handler+0x28>
    1068:       97fffc72        bl      230 <el0_sve_acc>
    106c:       17ffffe7        b       1008 <el0t_64_sync_handler+0x28>
    1070:       97ffff18        bl      cd0 <el0_svc>
    1074:       17ffffe5        b       1008 <el0t_64_sync_handler+0x28>
    1078:       97fffcb6        bl      350 <el0_bti>
    107c:       17ffffe3        b       1008 <el0t_64_sync_handler+0x28>
    1080:       97fffc54        bl      1d0 <el0_fpsimd_acc>
    1084:       17ffffe1        b       1008 <el0t_64_sync_handler+0x28>
    1088:       97fffc9a        bl      2f0 <el0_sys>
    108c:       17ffffdf        b       1008 <el0t_64_sync_handler+0x28>
    1090:       97fffc0c        bl      c0 <el0_undef>
    1094:       17ffffdd        b       1008 <el0t_64_sync_handler+0x28>

> 
> 
>>
>> At a high-level, I'm not too keen on special-casing things unless
>> necessary.
>>
>> I wonder if we could get similar results without special-casing by using
>> a static const array of handlers indexed by the EC, since (with GCC
>> 11.1.0 from the kernel.org crosstool page) that can result in code like:
>>
>> 0000000000001010 <el0t_64_sync_handler>:
>>     1010:       d503245f        bti     c
>>     1014:       d503233f        paciasp
>>     1018:       a9bf7bfd        stp     x29, x30, [sp, #-16]!
>>     101c:       910003fd        mov     x29, sp
>>     1020:       d5385201        mrs     x1, esr_el1
>>     1024:       90000002        adrp    x2, 0 <el0t_64_sync_handlers>
>>     1028:       531a7c23        lsr     w3, w1, #26
>>     102c:       91000042        add     x2, x2, #:lo12:<el0t_64_sync_handlers>
>>     1030:       f8637842        ldr     x2, [x2, x3, lsl #3]
>>     1034:       d63f0040        blr     x2
>>     1038:       a8c17bfd        ldp     x29, x30, [sp], #16
>>     103c:       d50323bf        autiasp
>>     1040:       d65f03c0        ret
>>
>> ... which might do better by virtue of reducing a chain of potential
>> mispredicts down to a single potential mispredict, and dynamic branch
>> prediction hopefully does a good job of predicting the common case at
>> runtime. That said, the resulting tables will be pretty big...
> 
> 
>  a48:   38624862        ldrb    w2, [x3, w2, uxtw]
>  a4c:   10000063        adr     x3, a58 <el0_sync_handler+0x48>
>  a50:   8b228862        add     x2, x3, w2, sxtb #2
>  a54:   d61f0040        br      x2
> 
> The original implementation also generated a query table, but yours is
> more concise. I will try to test it. Looks like a better solution.
> 
>>
>>>
>>> Execute "./lat_syscall null" on my board (BogoMIPS : 200.00), it can save
>>> about 10ns.
>>>
>>> Before:
>>> Simple syscall: 0.2365 microseconds
>>> Simple syscall: 0.2354 microseconds
>>> Simple syscall: 0.2339 microseconds
>>>
>>> After:
>>> Simple syscall: 0.2255 microseconds
>>> Simple syscall: 0.2254 microseconds
>>> Simple syscall: 0.2256 microseconds
>>
>> I appreciate this can be seen by a microbenchmark, but does this have an
>> impact on a real workload? I'd imagine that real syscall usage will
>> dominate this in practice, and this would fall into the noise.
> 
> The product side has a test plan, but the progress will be slow.
> 
>>
>> Thanks,
>> Mark.
>>
>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>> ---
>>>  arch/arm64/kernel/entry-common.c | 18 ++++++++++++------
>>>  1 file changed, 12 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
>>> index 32f9796c4ffe77b..062eb5a895ec6f3 100644
>>> --- a/arch/arm64/kernel/entry-common.c
>>> +++ b/arch/arm64/kernel/entry-common.c
>>> @@ -607,11 +607,14 @@ static void noinstr el0_fpac(struct pt_regs *regs, unsigned long esr)
>>>  asmlinkage void noinstr el0t_64_sync_handler(struct pt_regs *regs)
>>>  {
>>>  	unsigned long esr = read_sysreg(esr_el1);
>>> +	unsigned long ec = ESR_ELx_EC(esr);
>>>  
>>> -	switch (ESR_ELx_EC(esr)) {
>>> -	case ESR_ELx_EC_SVC64:
>>> +	if (likely(ec == ESR_ELx_EC_SVC64)) {
>>>  		el0_svc(regs);
>>> -		break;
>>> +		return;
>>> +	}
>>> +
>>> +	switch (ec) {
>>>  	case ESR_ELx_EC_DABT_LOW:
>>>  		el0_da(regs, esr);
>>>  		break;
>>> @@ -730,11 +733,14 @@ static void noinstr el0_svc_compat(struct pt_regs *regs)
>>>  asmlinkage void noinstr el0t_32_sync_handler(struct pt_regs *regs)
>>>  {
>>>  	unsigned long esr = read_sysreg(esr_el1);
>>> +	unsigned long ec = ESR_ELx_EC(esr);
>>>  
>>> -	switch (ESR_ELx_EC(esr)) {
>>> -	case ESR_ELx_EC_SVC32:
>>> +	if (likely(ec == ESR_ELx_EC_SVC32)) {
>>>  		el0_svc_compat(regs);
>>> -		break;
>>> +		return;
>>> +	}
>>> +
>>> +	switch (ec) {
>>>  	case ESR_ELx_EC_DABT_LOW:
>>>  		el0_da(regs, esr);
>>>  		break;
>>> -- 
>>> 2.25.1
>>>
>> .
>>

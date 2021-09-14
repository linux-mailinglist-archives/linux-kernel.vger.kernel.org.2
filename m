Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA51E40AC51
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 13:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbhINLY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 07:24:57 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:19973 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbhINLYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 07:24:54 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H818L3TQfzbmLM;
        Tue, 14 Sep 2021 19:19:30 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 14 Sep 2021 19:23:35 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 14 Sep 2021 19:23:35 +0800
Subject: Re: [PATCH] arm64: entry: Improve the performance of system calls
To:     Mark Rutland <mark.rutland@arm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210903121950.2284-1-thunder.leizhen@huawei.com>
 <20210914095436.GA26544@C02TD0UTHF1T.local>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <1156204d-b48f-8416-a805-78274463bc81@huawei.com>
Date:   Tue, 14 Sep 2021 19:23:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210914095436.GA26544@C02TD0UTHF1T.local>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/9/14 17:55, Mark Rutland wrote:
> Hi,
> 
> On Fri, Sep 03, 2021 at 08:19:50PM +0800, Zhen Lei wrote:
>> Commit 582f95835a8f ("arm64: entry: convert el0_sync to C") converted lots
>> of functions from assembly to C, this greatly improves readability. But
>> el0_svc()/el0_svc_compat() is in response to system call requests from
>> user mode and may be in the hot path.
>>
>> Although the SVC is in the first case of the switch statement in C, the
>> compiler optimizes the switch statement as a whole, and does not give SVC
>> a small boost.
>>
>> Use "likely()" to help SVC directly invoke its handler after a simple
>> judgment to avoid entering the switch table lookup process.
>>
>> After:
>> 0000000000000ff0 <el0t_64_sync_handler>:
>>      ff0:       d503245f        bti     c
>>      ff4:       d503233f        paciasp
>>      ff8:       a9bf7bfd        stp     x29, x30, [sp, #-16]!
>>      ffc:       910003fd        mov     x29, sp
>>     1000:       d5385201        mrs     x1, esr_el1
>>     1004:       531a7c22        lsr     w2, w1, #26
>>     1008:       f100545f        cmp     x2, #0x15
>>     100c:       540000a1        b.ne    1020 <el0t_64_sync_handler+0x30>
>>     1010:       97fffe14        bl      860 <el0_svc>
>>     1014:       a8c17bfd        ldp     x29, x30, [sp], #16
>>     1018:       d50323bf        autiasp
>>     101c:       d65f03c0        ret
>>     1020:       f100705f        cmp     x2, #0x1c
> 
> It would be helpful if you could state which toolchain and config was
> used to generate the above.

gcc version 7.3.0 (GCC), make defconfig

> 
> For comparison, what was the code generation like before? I assume
> el0_svc wasn't the target of the first test and branch? Assuming so, how
> many tests and branches were there before the call to el0_svc()?

0000000000000a10 <el0_sync_handler>:
 a10:   a9bf7bfd        stp     x29, x30, [sp, #-16]!
 a14:   910003fd        mov     x29, sp
 a18:   d5385201        mrs     x1, esr_el1
 a1c:   531a7c22        lsr     w2, w1, #26
 a20:   f100f05f        cmp     x2, #0x3c
 a24:   54000068        b.hi    a30 <el0_sync_handler+0x20>  // b.pmore
 a28:   7100f05f        cmp     w2, #0x3c
 a2c:   540000a9        b.ls    a40 <el0_sync_handler+0x30>  // b.plast
 a30:   97ffffc8        bl      950 <el0_inv>
 a34:   a8c17bfd        ldp     x29, x30, [sp], #16
 a38:   d65f03c0        ret
 a3c:   d503201f        nop
 a40:   90000003        adrp    x3, 0 <enter_from_kernel_mode.isra.6>
 a44:   91000063        add     x3, x3, #0x0
 a48:   38624862        ldrb    w2, [x3, w2, uxtw]
 a4c:   10000063        adr     x3, a58 <el0_sync_handler+0x48>
 a50:   8b228862        add     x2, x3, w2, sxtb #2
 a54:   d61f0040        br      x2
 a58:   97ffff9e        bl      8d0 <el0_dbg>
 a5c:   17fffff6        b       a34 <el0_sync_handler+0x24>
 a60:   97ffff2c        bl      710 <el0_fpsimd_exc>
 a64:   17fffff4        b       a34 <el0_sync_handler+0x24>
 a68:   97ffff46        bl      780 <el0_sp>
 a6c:   17fffff2        b       a34 <el0_sync_handler+0x24>
 a70:   97fffece        bl      5a8 <el0_da>
 a74:   17fffff0        b       a34 <el0_sync_handler+0x24>
 a78:   97ffff50        bl      7b8 <el0_pc>
 a7c:   17ffffee        b       a34 <el0_sync_handler+0x24>
 a80:   97fffedc        bl      5f0 <el0_ia>
 a84:   17ffffec        b       a34 <el0_sync_handler+0x24>
 a88:   97ffffa4        bl      918 <el0_fpac>
 a8c:   17ffffea        b       a34 <el0_sync_handler+0x24>
 a90:   97ffff12        bl      6d8 <el0_sve_acc>
 a94:   17ffffe8        b       a34 <el0_sync_handler+0x24>
 a98:   97fffeba        bl      580 <el0_svc>
 a9c:   17ffffe6        b       a34 <el0_sync_handler+0x24>
 aa0:   97ffff80        bl      8a0 <el0_bti>
 aa4:   17ffffe4        b       a34 <el0_sync_handler+0x24>
 aa8:   97fffefe        bl      6a0 <el0_fpsimd_acc>
 aac:   17ffffe2        b       a34 <el0_sync_handler+0x24>
 ab0:   97ffff26        bl      748 <el0_sys>
 ab4:   17ffffe0        b       a34 <el0_sync_handler+0x24>
 ab8:   97ffff6e        bl      870 <el0_undef>
 abc:   17ffffde        b       a34 <el0_sync_handler+0x24>


> 
> At a high-level, I'm not too keen on special-casing things unless
> necessary.
> 
> I wonder if we could get similar results without special-casing by using
> a static const array of handlers indexed by the EC, since (with GCC
> 11.1.0 from the kernel.org crosstool page) that can result in code like:
> 
> 0000000000001010 <el0t_64_sync_handler>:
>     1010:       d503245f        bti     c
>     1014:       d503233f        paciasp
>     1018:       a9bf7bfd        stp     x29, x30, [sp, #-16]!
>     101c:       910003fd        mov     x29, sp
>     1020:       d5385201        mrs     x1, esr_el1
>     1024:       90000002        adrp    x2, 0 <el0t_64_sync_handlers>
>     1028:       531a7c23        lsr     w3, w1, #26
>     102c:       91000042        add     x2, x2, #:lo12:<el0t_64_sync_handlers>
>     1030:       f8637842        ldr     x2, [x2, x3, lsl #3]
>     1034:       d63f0040        blr     x2
>     1038:       a8c17bfd        ldp     x29, x30, [sp], #16
>     103c:       d50323bf        autiasp
>     1040:       d65f03c0        ret
> 
> ... which might do better by virtue of reducing a chain of potential
> mispredicts down to a single potential mispredict, and dynamic branch
> prediction hopefully does a good job of predicting the common case at
> runtime. That said, the resulting tables will be pretty big...


 a48:   38624862        ldrb    w2, [x3, w2, uxtw]
 a4c:   10000063        adr     x3, a58 <el0_sync_handler+0x48>
 a50:   8b228862        add     x2, x3, w2, sxtb #2
 a54:   d61f0040        br      x2

The original implementation also generated a query table, but yours is
more concise. I will try to test it. Looks like a better solution.

> 
>>
>> Execute "./lat_syscall null" on my board (BogoMIPS : 200.00), it can save
>> about 10ns.
>>
>> Before:
>> Simple syscall: 0.2365 microseconds
>> Simple syscall: 0.2354 microseconds
>> Simple syscall: 0.2339 microseconds
>>
>> After:
>> Simple syscall: 0.2255 microseconds
>> Simple syscall: 0.2254 microseconds
>> Simple syscall: 0.2256 microseconds
> 
> I appreciate this can be seen by a microbenchmark, but does this have an
> impact on a real workload? I'd imagine that real syscall usage will
> dominate this in practice, and this would fall into the noise.

The product side has a test plan, but the progress will be slow.

> 
> Thanks,
> Mark.
> 
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  arch/arm64/kernel/entry-common.c | 18 ++++++++++++------
>>  1 file changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
>> index 32f9796c4ffe77b..062eb5a895ec6f3 100644
>> --- a/arch/arm64/kernel/entry-common.c
>> +++ b/arch/arm64/kernel/entry-common.c
>> @@ -607,11 +607,14 @@ static void noinstr el0_fpac(struct pt_regs *regs, unsigned long esr)
>>  asmlinkage void noinstr el0t_64_sync_handler(struct pt_regs *regs)
>>  {
>>  	unsigned long esr = read_sysreg(esr_el1);
>> +	unsigned long ec = ESR_ELx_EC(esr);
>>  
>> -	switch (ESR_ELx_EC(esr)) {
>> -	case ESR_ELx_EC_SVC64:
>> +	if (likely(ec == ESR_ELx_EC_SVC64)) {
>>  		el0_svc(regs);
>> -		break;
>> +		return;
>> +	}
>> +
>> +	switch (ec) {
>>  	case ESR_ELx_EC_DABT_LOW:
>>  		el0_da(regs, esr);
>>  		break;
>> @@ -730,11 +733,14 @@ static void noinstr el0_svc_compat(struct pt_regs *regs)
>>  asmlinkage void noinstr el0t_32_sync_handler(struct pt_regs *regs)
>>  {
>>  	unsigned long esr = read_sysreg(esr_el1);
>> +	unsigned long ec = ESR_ELx_EC(esr);
>>  
>> -	switch (ESR_ELx_EC(esr)) {
>> -	case ESR_ELx_EC_SVC32:
>> +	if (likely(ec == ESR_ELx_EC_SVC32)) {
>>  		el0_svc_compat(regs);
>> -		break;
>> +		return;
>> +	}
>> +
>> +	switch (ec) {
>>  	case ESR_ELx_EC_DABT_LOW:
>>  		el0_da(regs, esr);
>>  		break;
>> -- 
>> 2.25.1
>>
> .
> 

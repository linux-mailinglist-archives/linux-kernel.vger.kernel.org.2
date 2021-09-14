Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC6C40A2FC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 04:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbhINCCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 22:02:47 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:19967 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhINCCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 22:02:46 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H7mgk4kRQzbmW0;
        Tue, 14 Sep 2021 09:57:22 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 14 Sep 2021 10:01:17 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 14 Sep 2021 10:01:16 +0800
Subject: Re: [PATCH] arm64: entry: Improve the performance of system calls
To:     Punit Agrawal <punitagrawal@gmail.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>
References: <20210903121950.2284-1-thunder.leizhen@huawei.com>
 <87o88w84hp.fsf@stealth>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <c11e7b8f-3647-c34e-808a-27c0e83b4b1d@huawei.com>
Date:   Tue, 14 Sep 2021 10:01:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87o88w84hp.fsf@stealth>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/9/14 7:01, Punit Agrawal wrote:
> Hi Zhen Lei,
> 
> Zhen Lei <thunder.leizhen@huawei.com> writes:
> 
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
> I was curious about the impact of the patch on other
> micro-architectures. Following are the results from using the patch
> applied to v5.14 on A72 and A53 on a RK399.
> 
> For the A72 -
> Before:
> Simple syscall: 0.4311 microseconds
> Simple syscall: 0.4311 microseconds
> Simple syscall: 0.4313 microseconds
> 
> After:
> Simple syscall: 0.4249 microseconds
> Simple syscall: 0.4248 microseconds
> Simple syscall: 0.4248 microseconds
> 
> For the A53 -
> Before:
> Simple syscall: 0.4130 microseconds
> Simple syscall: 0.4128 microseconds
> Simple syscall: 0.4124 microseconds
> 
> After:
> Simple syscall: 0.4031 microseconds
> Simple syscall: 0.4078 microseconds
> Simple syscall: 0.4030 microseconds
> 
> Although there is a small benefit, they are not as big as on your board
> / micro-architecture.

Maybe the options are different. A slight performance improvement is also
a good thing with the same functionality and readability.

> 
> Were you able to see any impact on real workloads?

We have a plan to do it on the product side, and it won't come out so quickly.

> 
> I imagine that other code paths in the sync handler would also benefit
> from similar special casing - did you try any others. Page fault
> handling came to mind.

Yes, It would be clearer to apply likely() to ESR_ELx_EC_DABT_LOW as well.
After applying this patch, the compiler stops optimizing branch judgments
into an array. The page fault is also improved.

Other case items are mainly for debugging purposes. It doesn't matter whether
the performance is a bit faster or slower.

> 
> Overall, I feel a little uneasy about the special casing introduced here
> but at the same time see that it does benefit certain workloads.
> 
> One more comment below.
> 
>>
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
> 
> Please include a big fat comment on why SVC (or any other patch) is
> being separated out of the switch case - both here and below.

Okay, I'll add it.

> 
> Thanks,
> Punit
> 
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
> .
> 

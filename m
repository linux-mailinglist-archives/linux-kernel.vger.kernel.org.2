Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B37E33FD35
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 03:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhCRC2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 22:28:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13561 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhCRC2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 22:28:16 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F19qZ0p6wzPjdT;
        Thu, 18 Mar 2021 10:25:46 +0800 (CST)
Received: from [10.67.110.136] (10.67.110.136) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Thu, 18 Mar 2021 10:28:09 +0800
Subject: Re: [PATCH -next] powerpc: kernel/time.c - cleanup warnings
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <npiggin@gmail.com>, <msuchanek@suse.de>,
        <peterz@infradead.org>, <geert+renesas@glider.be>,
        <kernelfans@gmail.com>, <frederic@kernel.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20210317103438.177428-1-heying24@huawei.com>
 <3f4d196b-0a8e-d4c9-cabe-591f5916a2b9@csgroup.eu>
From:   "heying (H)" <heying24@huawei.com>
Message-ID: <5ee06736-7fc4-7993-a8b5-042e1890a6de@huawei.com>
Date:   Thu, 18 Mar 2021 10:28:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <3f4d196b-0a8e-d4c9-cabe-591f5916a2b9@csgroup.eu>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.136]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/3/17 19:16, Christophe Leroy 写道:
>
>
> Le 17/03/2021 à 11:34, He Ying a écrit :
>> We found these warnings in arch/powerpc/kernel/time.c as follows:
>> warning: symbol 'decrementer_max' was not declared. Should it be static?
>> warning: symbol 'rtc_lock' was not declared. Should it be static?
>> warning: symbol 'dtl_consumer' was not declared. Should it be static?
>>
>> Declare 'decrementer_max' in arch/powerpc/include/asm/time.h. And 
>> include
>> proper header in which 'rtc_lock' is declared. Move 'dtl_consumer'
>> definition behind "include <asm/dtl.h>" because 'dtl_consumer' is 
>> declared
>> there.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: He Ying <heying24@huawei.com>
>> ---
>>   arch/powerpc/include/asm/time.h | 1 +
>>   arch/powerpc/kernel/time.c      | 7 +++----
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/time.h 
>> b/arch/powerpc/include/asm/time.h
>> index 8dd3cdb25338..2cd2b50bedda 100644
>> --- a/arch/powerpc/include/asm/time.h
>> +++ b/arch/powerpc/include/asm/time.h
>> @@ -22,6 +22,7 @@ extern unsigned long tb_ticks_per_jiffy;
>>   extern unsigned long tb_ticks_per_usec;
>>   extern unsigned long tb_ticks_per_sec;
>>   extern struct clock_event_device decrementer_clockevent;
>> +extern u64 decrementer_max;
>>       extern void generic_calibrate_decr(void);
>> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
>> index b67d93a609a2..409967713ca6 100644
>> --- a/arch/powerpc/kernel/time.c
>> +++ b/arch/powerpc/kernel/time.c
>> @@ -55,6 +55,7 @@
>>   #include <linux/sched/cputime.h>
>>   #include <linux/sched/clock.h>
>>   #include <linux/processor.h>
>> +#include <linux/mc146818rtc.h>
>
> I don't think that's the good place. It has no link to powerpc, it is 
> only by chance that it has the same name.
>
> As rtc_lock is defined in powerpc time.c, I think you should declare 
> it in powerpc asm/time.h

My first thought was the same as yours. I tried to add declaration in 
powerpc asm/time.h, but got a compiling error:

drivers/rtc/rtc-vr41xx.c:75:24: error: static declaration of ‘rtc_lock’ 
follows non-static declaration
  static DEFINE_SPINLOCK(rtc_lock);

In file included from ./arch/powerpc/include/asm/delay.h:7:0,
                  from ./arch/powerpc/include/asm/io.h:33,
                  from ./include/linux/io.h:13,
                  from drivers/rtc/rtc-vr41xx.c:11:
./arch/powerpc/include/asm/time.h:25:19: note: previous declaration of 
‘rtc_lock’ was here
  extern spinlock_t rtc_lock;

There's a conflict. Perhaps I can rename it in drivers/rtc/rtc-vr41xx.c.


But I find an existing declaration in linux/mc146818rtc.h and there's 
only one definition for 'rtc_lock' in powerpc.

There's some includes of mc146818rtc.h in powperc. I wonder they point 
to the same thing. But I'm not very sure

because the header's name looks a bit strange.

>
>
>>   #include <asm/trace.h>
>>     #include <asm/interrupt.h>
>> @@ -150,10 +151,6 @@ bool tb_invalid;
>>   u64 __cputime_usec_factor;
>>   EXPORT_SYMBOL(__cputime_usec_factor);
>>   -#ifdef CONFIG_PPC_SPLPAR
>> -void (*dtl_consumer)(struct dtl_entry *, u64);
>> -#endif
>> -
>>   static void calc_cputime_factors(void)
>>   {
>>       struct div_result res;
>> @@ -179,6 +176,8 @@ static inline unsigned long read_spurr(unsigned 
>> long tb)
>>     #include <asm/dtl.h>
>>   +void (*dtl_consumer)(struct dtl_entry *, u64);
>> +
>>   /*
>>    * Scan the dispatch trace log and count up the stolen time.
>>    * Should be called with interrupts disabled.
>>
> .

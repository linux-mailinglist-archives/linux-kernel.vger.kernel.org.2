Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C7A34580A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 07:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhCWGxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 02:53:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13664 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhCWGxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 02:53:19 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F4MT16bhjznVHt;
        Tue, 23 Mar 2021 14:50:45 +0800 (CST)
Received: from [10.67.110.136] (10.67.110.136) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Tue, 23 Mar 2021 14:53:11 +0800
Subject: Re: [PATCH -next] powerpc: kernel/time.c - cleanup warnings
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <npiggin@gmail.com>, <msuchanek@suse.de>,
        <peterz@infradead.org>, <geert+renesas@glider.be>,
        <kernelfans@gmail.com>, <frederic@kernel.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20210317103438.177428-1-heying24@huawei.com>
 <3f4d196b-0a8e-d4c9-cabe-591f5916a2b9@csgroup.eu>
 <5ee06736-7fc4-7993-a8b5-042e1890a6de@huawei.com>
 <c6908c07-1814-a7f8-5f48-a4c316fb567c@huawei.com>
 <5f4ec5e0-af9c-ba47-4a01-589b1b724cb9@csgroup.eu>
From:   "heying (H)" <heying24@huawei.com>
Message-ID: <ef45a69e-f6a5-8238-672e-02f35e09e91c@huawei.com>
Date:   Tue, 23 Mar 2021 14:53:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <5f4ec5e0-af9c-ba47-4a01-589b1b724cb9@csgroup.eu>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.136]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Christophe,


在 2021/3/23 14:33, Christophe Leroy 写道:
>
>
> Le 23/03/2021 à 07:21, heying (H) a écrit :
>> Dear Christophe,
>>
>>
>> 在 2021/3/18 10:28, heying (H) 写道:
>>>
>>> 在 2021/3/17 19:16, Christophe Leroy 写道:
>>>>
>>>>
>>>> Le 17/03/2021 à 11:34, He Ying a écrit :
>>>>> We found these warnings in arch/powerpc/kernel/time.c as follows:
>>>>> warning: symbol 'decrementer_max' was not declared. Should it be 
>>>>> static?
>>>>> warning: symbol 'rtc_lock' was not declared. Should it be static?
>>>>> warning: symbol 'dtl_consumer' was not declared. Should it be static?
>>>>>
>>>>> Declare 'decrementer_max' in arch/powerpc/include/asm/time.h. And 
>>>>> include
>>>>> proper header in which 'rtc_lock' is declared. Move 'dtl_consumer'
>>>>> definition behind "include <asm/dtl.h>" because 'dtl_consumer' is 
>>>>> declared
>>>>> there.
>>>>>
>>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>>> Signed-off-by: He Ying <heying24@huawei.com>
>>>>> ---
>>>>>   arch/powerpc/include/asm/time.h | 1 +
>>>>>   arch/powerpc/kernel/time.c      | 7 +++----
>>>>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/arch/powerpc/include/asm/time.h 
>>>>> b/arch/powerpc/include/asm/time.h
>>>>> index 8dd3cdb25338..2cd2b50bedda 100644
>>>>> --- a/arch/powerpc/include/asm/time.h
>>>>> +++ b/arch/powerpc/include/asm/time.h
>>>>> @@ -22,6 +22,7 @@ extern unsigned long tb_ticks_per_jiffy;
>>>>>   extern unsigned long tb_ticks_per_usec;
>>>>>   extern unsigned long tb_ticks_per_sec;
>>>>>   extern struct clock_event_device decrementer_clockevent;
>>>>> +extern u64 decrementer_max;
>>>>>       extern void generic_calibrate_decr(void);
>>>>> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
>>>>> index b67d93a609a2..409967713ca6 100644
>>>>> --- a/arch/powerpc/kernel/time.c
>>>>> +++ b/arch/powerpc/kernel/time.c
>>>>> @@ -55,6 +55,7 @@
>>>>>   #include <linux/sched/cputime.h>
>>>>>   #include <linux/sched/clock.h>
>>>>>   #include <linux/processor.h>
>>>>> +#include <linux/mc146818rtc.h>
>>>>
>>>> I don't think that's the good place. It has no link to powerpc, it 
>>>> is only by chance that it has the same name.
>>>>
>>>> As rtc_lock is defined in powerpc time.c, I think you should 
>>>> declare it in powerpc asm/time.h
>>>
>>> My first thought was the same as yours. I tried to add declaration 
>>> in powerpc asm/time.h, but got a compiling error:
>>>
>>> drivers/rtc/rtc-vr41xx.c:75:24: error: static declaration of 
>>> ‘rtc_lock’ follows non-static declaration
>>>  static DEFINE_SPINLOCK(rtc_lock);
>>>
>>> In file included from ./arch/powerpc/include/asm/delay.h:7:0,
>>>                  from ./arch/powerpc/include/asm/io.h:33,
>>>                  from ./include/linux/io.h:13,
>>>                  from drivers/rtc/rtc-vr41xx.c:11:
>>> ./arch/powerpc/include/asm/time.h:25:19: note: previous declaration 
>>> of ‘rtc_lock’ was here
>>>  extern spinlock_t rtc_lock;
>>>
>>> There's a conflict. Perhaps I can rename it in 
>>> drivers/rtc/rtc-vr41xx.c.
>>>
>>>
>>> But I find an existing declaration in linux/mc146818rtc.h and 
>>> there's only one definition for 'rtc_lock' in powerpc.
>>>
>>> There's some includes of mc146818rtc.h in powperc. I wonder they 
>>> point to the same thing. But I'm not very sure
>>>
>>> because the header's name looks a bit strange.
>>
>> How about including mc146818rtc.h in powperpc kernel/time.c? May I 
>> have your opinions please?
>>
>
> As I said, mc146818rtc.h is not related to powerpc, and if it works 
> that's just chance, and there is no certainty that it will still work 
> in the future.
>
> If you can't find a clean solution, it is better to leave the warning.

OK. I see. Thanks for you relpy. I'll try to find some other better way.


Thanks.



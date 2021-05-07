Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524EB3762E0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 11:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbhEGJc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 05:32:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17145 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhEGJc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 05:32:27 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fc4qr3RyHzqSth;
        Fri,  7 May 2021 17:28:08 +0800 (CST)
Received: from [10.67.110.136] (10.67.110.136) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Fri, 7 May 2021 17:31:22 +0800
Subject: Re: [PATCH v3 03/16] arm64: Allow IPIs to be handled as normal
 interrupts
To:     Marc Zyngier <maz@kernel.org>
CC:     <vincent.guittot@linaro.org>, <Valentin.Schneider@arm.com>,
        <andrew@lunn.ch>, <catalin.marinas@arm.com>,
        <f.fainelli@gmail.com>, <gregory.clement@bootlin.com>,
        <kernel-team@android.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux@arm.linux.org.uk>,
        <saravanak@google.com>, <sumit.garg@linaro.org>,
        <tglx@linutronix.de>, <will@kernel.org>
References: <CAKfTPtD3GkTd+qQvyCmyU7Atu1ictDQ82YbPRdY9a+Kkr2DjvA@mail.gmail.com>
 <c66367b0-e8a0-2b7b-13c3-c9413462357c@huawei.com>
 <87pmy4qe7e.wl-maz@kernel.org>
 <d6936b80-25ad-5e06-5fcc-c211adb70ceb@huawei.com>
 <87lf8qq5vr.wl-maz@kernel.org>
From:   He Ying <heying24@huawei.com>
Message-ID: <46db52fe-b69e-3ea9-4581-858658be8a2c@huawei.com>
Date:   Fri, 7 May 2021 17:31:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87lf8qq5vr.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.136]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/5/7 16:56, Marc Zyngier 写道:
> On Fri, 07 May 2021 08:30:06 +0100,
> He Ying <heying24@huawei.com> wrote:
>>
>> 在 2021/5/6 19:44, Marc Zyngier 写道:
>>> On Thu, 06 May 2021 08:50:42 +0100,
>>> He Ying <heying24@huawei.com> wrote:
>>>> Hello Marc,
>>>>
>>>> We have faced a performance regression for handling ipis since this
>>>> commit. I think it's the same issue reported by Vincent.
>>> Can you share more details on what regression you have observed?
>>> What's the workload, the system, the performance drop?
>> OK. We have just calculated the pmu cycles from the entry of gic_handle_irq
>> to the entry of do_handle_ipi. Here is some more information about our test:
>>
>> CPU: Hisilicon hip05-d02
>>
>> Applying the patch series: 1115 cycles
>> Reverting the patch series: 599 cycles
> And? How is that meaningful? Interrupts are pretty rare compared to
> everything that happens in the system. How does it affect the
> behaviour of the system as a whole?
OK.
>
>>>> I found you pointed out the possible two causes:
>>>>
>>>> (1) irq_enter/exit on the rescheduling IPI means we reschedule much
>>>> more often.
>>> It turned out to be a red herring. We don't reschedule more often, but
>>> we instead suffer from the overhead of irq_enter()/irq_exit().
>>> However, this only matters for silly benchmarks, and no real-life
>>> workload showed any significant regression. Have you identified such
>>> realistic workload?
>> I'm afraid not. We just run some benchmarks and calculated pmu cycle
>> counters.  But we have observed running time from the entry of
>> gic_handle_irq to the entry of do_handle_ipi almost doubles. Doesn't
>> it affect realistic workload?
> Then I'm not that interested. Show me an actual regression in a real
> workload that affects people, and I'll be a bit more sympathetic to
> your complain. But quoting raw numbers do not help.
>
> There is a number of advantages to having IPI as IRQs, as it allows us
> to deal with proper allocation (other subsystem want to use IPIs), and
> eventually NMIs. There is a trade-off, and if that means wasting a few
> cycles, so be it.
OK. I see.
>
>>>> (2) irq_domain lookups add some overhead.
>>> While this is also a potential source of overhead, it turned out not
>>> to be the case.
>> OK.
>>>> But I don't see any following patches in mainline. So, are you still
>>>> working on this issue?  Looking forward to your reply.
>>> See [1]. However, there is probably better things to do than this
>>> low-level specialisation of IPIs, and Thomas outlined what needs to be
>>> done (see v1 of the patch series).
>> OK. I see the patch series. Would it be applied to the mainline
>> someday? I notice that more than 5 months have passed since you sent
>> the patch series.
> I have no plan to merge these patches any time soon, given that nobody
> has shown a measurable regression using something other than a trivial
> benchmark. If you come up with such an example, I will of course
> reconsider this position.

OK. Thanks a lot for all your reply. If I come up with a measurable 
regression

with a realistic workload, I'll contact you again.


Thanks.

>
> Thanks,
>
> 	M.
>

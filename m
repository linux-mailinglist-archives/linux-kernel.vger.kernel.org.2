Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE69376124
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 09:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbhEGHbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 03:31:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17592 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbhEGHbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 03:31:11 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fc28k5WWvz1BJpP;
        Fri,  7 May 2021 15:27:34 +0800 (CST)
Received: from [10.67.110.136] (10.67.110.136) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Fri, 7 May 2021 15:30:06 +0800
Subject: Re: [PATCH v3 03/16] arm64: Allow IPIs to be handled as normal
 interrupts
To:     Marc Zyngier <maz@kernel.org>
CC:     <vincent.guittot@linaro.org>, <Valentin.Schneider@arm.com>,
        <andrew@lunn.ch>, <catalin.marinas@arm.com>,
        <f.fainelli@gmail.com>, <gregory.clement@bootlin.com>,
        <jason@lakedaemon.net>, <kernel-team@android.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux@arm.linux.org.uk>,
        <saravanak@google.com>, <sumit.garg@linaro.org>,
        <tglx@linutronix.de>, <will@kernel.org>
References: <CAKfTPtD3GkTd+qQvyCmyU7Atu1ictDQ82YbPRdY9a+Kkr2DjvA@mail.gmail.com>
 <c66367b0-e8a0-2b7b-13c3-c9413462357c@huawei.com>
 <87pmy4qe7e.wl-maz@kernel.org>
From:   He Ying <heying24@huawei.com>
Message-ID: <d6936b80-25ad-5e06-5fcc-c211adb70ceb@huawei.com>
Date:   Fri, 7 May 2021 15:30:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87pmy4qe7e.wl-maz@kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.136]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/5/6 19:44, Marc Zyngier Ð´µÀ:
> On Thu, 06 May 2021 08:50:42 +0100,
> He Ying <heying24@huawei.com> wrote:
>> Hello Marc,
>>
>> We have faced a performance regression for handling ipis since this
>> commit. I think it's the same issue reported by Vincent.
> Can you share more details on what regression you have observed?
> What's the workload, the system, the performance drop?

OK. We have just calculated the pmu cycles from the entry of gic_handle_irq

to the entry of do_handle_ipi. Here is some more information about our test:

CPU: Hisilicon hip05-d02

Applying the patch series: 1115 cycles

Reverting the patch series: 599 cycles

>
>> I found you pointed out the possible two causes:
>>
>> (1) irq_enter/exit on the rescheduling IPI means we reschedule much
>> more often.
> It turned out to be a red herring. We don't reschedule more often, but
> we instead suffer from the overhead of irq_enter()/irq_exit().
> However, this only matters for silly benchmarks, and no real-life
> workload showed any significant regression. Have you identified such
> realistic workload?

I'm afraid not. We just run some benchmarks and calculated pmu cycle 
counters.

But we have observed running time from the entry of gic_handle_irq to 
the entry

of do_handle_ipi almost doubles. Doesn't it affect realistic workload?

>
>> (2) irq_domain lookups add some overhead.
> While this is also a potential source of overhead, it turned out not
> to be the case.
OK.
>
>> But I don't see any following patches in mainline. So, are you still
>> working on this issue?  Looking forward to your reply.
> See [1]. However, there is probably better things to do than this
> low-level specialisation of IPIs, and Thomas outlined what needs to be
> done (see v1 of the patch series).

OK. I see the patch series. Would it be applied to the mainline someday? 
I notice

that more than 5 months have passed since you sent the patch series.


Thanks.

>
> Thanks,
>
> 	M.
>
> [1] https://lore.kernel.org/lkml/20201124141449.572446-1-maz@kernel.org/
>

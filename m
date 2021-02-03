Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D340630DA96
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 14:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhBCNGR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 3 Feb 2021 08:06:17 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:33942 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231178AbhBCNGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:06:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=chenshiyan@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UNm4EsP_1612357445;
Received: from 30.39.162.59(mailfrom:chenshiyan@linux.alibaba.com fp:SMTPD_---0UNm4EsP_1612357445)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 03 Feb 2021 21:04:06 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH RESEND] nohz: Restart tick before do softirq
From:   chenshiyan <chenshiyan@linux.alibaba.com>
In-Reply-To: <20210201123811.GA41955@lothringen>
Date:   Wed, 3 Feb 2021 21:04:05 +0800
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <B2A33260-1D22-4C29-9811-64F0A68F0D64@linux.alibaba.com>
References: <1612151143-72242-1-git-send-email-chenshiyan@linux.alibaba.com>
 <20210201123811.GA41955@lothringen>
To:     Frederic Weisbecker <frederic@kernel.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederic,

Thanks for replying. Let’s try to clarify:

> On Mon, Feb 01, 2021 at 11:45:43AM +0800, chenshiyan wrote:
>> When the cpu is continuously idle, tick_irq_exit() will count next tick
>> expiry
> 
> What do you mean by counting next tick expiry here? Is is when
> tick_nohz_full_update_tick() reprogramms the next tick?

Yes, tick_nohz_full_update_tick() will reprograms the next tick.

> 
>> with maybe several periodic ticks
> 
> you mean that perhaps it's not going to stop it right now?
> 
I mean after reprogramming, maybe next tick will come in a long time .
That’s normal and the problem is not here.

> 
>> but if it enters softirq before next tick
> 
> Not sure what you mean here.
In irq_exit(), it  may do  softirq handlings for long time, and during that time, there’s no ticks.
That’s the problem.

> 
>> invoke_softirq() is called before tick_irq_exit(),
>> there will be no ticks during softirq.
> 
> Ok the issue happens when an IRQ fires while the tick is stopped, right?

Right.

> 
> 
>> So with sched_clock_irqtime
>> closing, sirq is very low in nohz idle even if the softirq costs much
>> time beause of the sampling ticks missing(sirq will be much higher and
>> seem exact if the cpu is busy).
> 
> But this only happens when sched_clock() is based on jiffies, right?
> Are you working on an architecture that doesn't implement it?

But this only happens when sched_clock() is based on jiffies, right?
-More specifically, this only happens when CONFIG_IRQ_TIME_ACCOUNTING is close.
As above say, there’s no ticks during softirq, so we can’t count how long it takes.

Are you working on an architecture that doesn't implement it?
-No, we test it on x86.

The problem is , when it's doing softirq, but there’s no tick, so we don’t know how long 
It takes. The TOP or some other procs can not show the right value of sirq.

This patch tries to restart tick before softirq. So far it works and we get an accurate value of sirq.
Maybe it’s not the best way to solve this problem and hope you would like to help me.

Thanks.


> 2021年2月1日 下午8:38，Frederic Weisbecker <frederic@kernel.org> 写道：
> 
> Hi,
> 
> I'm a bit confused with the changelog, let's try to clarify:
> 
> On Mon, Feb 01, 2021 at 11:45:43AM +0800, chenshiyan wrote:
>> When the cpu is continuously idle, tick_irq_exit() will count next tick
>> expiry
> 
> What do you mean by counting next tick expiry here? Is is when
> tick_nohz_full_update_tick() reprogramms the next tick?
> 
>> with maybe several periodic ticks
> 
> you mean that perhaps it's not going to stop it right now?
> 
> 
>> but if it enters softirq before next tick
> 
> Not sure what you mean here.
> 
>> invoke_softirq() is called before tick_irq_exit(),
>> there will be no ticks during softirq.
> 
> Ok the issue happens when an IRQ fires while the tick is stopped, right?
> 
> 
>> So with sched_clock_irqtime
>> closing, sirq is very low in nohz idle even if the softirq costs much
>> time beause of the sampling ticks missing(sirq will be much higher and
>> seem exact if the cpu is busy).
> 
> But this only happens when sched_clock() is based on jiffies, right?
> Are you working on an architecture that doesn't implement it?
> 
> Thanks.
> 
>> 
>> Signed-off-by: chenshiyan <chenshiyan@linux.alibaba.com>
>> ---
>> kernel/softirq.c | 1 +
>> 1 file changed, 1 insertion(+)
>> 
>> diff --git a/kernel/softirq.c b/kernel/softirq.c
>> index 9d71046..8f3f71b9 100644
>> --- a/kernel/softirq.c
>> +++ b/kernel/softirq.c
>> @@ -210,6 +210,7 @@ static inline void invoke_softirq(void)
>> 		return;
>> 
>> 	if (!force_irqthreads) {
>> +		tick_nohz_idle_restart_tick();
>> #ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
>> 		/*
>> 		 * We can safely execute softirq on the current stack if
>> -- 
>> 1.8.3.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEEB35A1F9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 17:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbhDIP1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 11:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbhDIP06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 11:26:58 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8A0C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 08:26:45 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id p23so3256033ljn.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 08:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VJaJUAxawNDHaSNSKTZmgfXiPJO0vq4aoaG4doApV44=;
        b=ritcTy0d7O+4PeEh8+atxrp1COnJfvd5SciFUIOfm+4gjZ+Xc9Nx1sJv1ljnNZx0zz
         SV3fRAygWLR7BxAekBCL2C8N9psL+GmcgmV41iOb+Fogf1Ex+NT+EeesvOVJGbMgrshq
         iXhKHjNAJOSuDGmECYM26eE6PwB2tSLErJfXrKwsk4b7n5fsuPqaTrH91cK3VOn86l+5
         TLgpELn9R+pbnHmrTnAF5LOaJnMY1Fb6NGwsNI3ncKA5K9n3kvEYUF4R9DffFM3yWZO6
         u/oMyYjmS8Htt4e22JBihy62VIez/68BD2GNS71b32dtGQF57Da4Y2ahKI7GdCaCKdGd
         B3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VJaJUAxawNDHaSNSKTZmgfXiPJO0vq4aoaG4doApV44=;
        b=TtTbIe+BWQy7vlzSNzqPYdMkLVOJ4NuU6Q4CXq9CSiXOZerQrYF8imsQFr+F6+T6Ak
         LdOyxvQAoA4rpBoxv9YFjh84qdSn22R3l2+CqsLpsP4y7Xrk2cHiFgE5HnEux8cg6Oie
         ManAOd0xoJ66g5xE3RcPtQbl39Liipp4ed0UFhTTLhPIM9gV6GA+9FElCrnPbhuUQM+E
         83DUM6nf+zAqGBZdSbIR6pBM80m1dZ/U0ULXr7AvyYx3836zWkYQpIK5KAXfwMx5rang
         +Gd0TGYJdXLLhHC+XZ1KNOl8PoMzSFsVMgox2x4YMD2TN2u4Wn7CS75rS6XlThXzXI4j
         WJsw==
X-Gm-Message-State: AOAM530QCYwO3dZefWkaFgQkXSzNdfOlg9V/sY5et3CtFExalJSi/b0x
        zO3wZGo+CQr47RY5AByHmkMtxqaSfBykJz/CAwmXzw==
X-Google-Smtp-Source: ABdhPJwL8VSB4QzQ4WKlaOTeEqDKvRbwhN++xyZaoajuOzqOTAKQzopOJO+msX+zdCxhmv90isw96u5SqKuL7LjbEPk=
X-Received: by 2002:a2e:730b:: with SMTP id o11mr9705681ljc.221.1617982003713;
 Fri, 09 Apr 2021 08:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210122154600.1722680-1-joel@joelfernandes.org>
 <CAKfTPtAnzhDKXayicDdymWpK1UswfkTaO8vL-WHxVaoj7DaCFw@mail.gmail.com>
 <YAsjOqmo7TEeXjoj@google.com> <CAKfTPtBWoRuwwkaqQKNgHTnQBE4fevyYqEoeGc5RpCsBbOS1sQ@mail.gmail.com>
 <YBG0W5PFGtGRCEuB@google.com> <CAKfTPtBqj5A_7QmxhhmkNTc3+VT6+AqWgw1GDYrgy1V5+PJMmQ@mail.gmail.com>
 <CAEXW_YRrhEfGcLN5yrLJZm6HrB15M_R5xfpMReG2wE2rSmVWdA@mail.gmail.com>
 <CAKfTPtBvwm9vZb5C=2oTF6N-Ht6Rvip4Lv18yi7O3G8e-_ZWdg@mail.gmail.com>
 <20210129172727.GA30719@vingu-book> <274d8ae5-8f4d-7662-0e04-2fbc92b416fc@linux.intel.com>
 <20210324134437.GA17675@vingu-book> <efad4771-c9d1-5103-de9c-0ec5fa78ee24@linux.intel.com>
 <CAKfTPtDsya_zdUB1ARmoxQs5xWS8o-XrrzyNx5R1iSNrchUXtg@mail.gmail.com>
 <fc0efe4e-0a81-03b8-08cb-029468c57782@linux.intel.com> <CAKfTPtCKavGWja42NdTmb+95ppG-WxYzoTJMmtgkCQcA-btfBw@mail.gmail.com>
 <4aa674d9-db49-83d5-356f-a20f9e2a7935@linux.intel.com>
In-Reply-To: <4aa674d9-db49-83d5-356f-a20f9e2a7935@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 9 Apr 2021 17:26:32 +0200
Message-ID: <CAKfTPtDJaTr_HR2t=9CQ-9x6keu-qzx6okci92AdW5cJG8J9zg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Rate limit calls to update_blocked_averages()
 for NOHZ
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Dietmar Eggeman <dietmar.eggemann@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Apr 2021 at 01:05, Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
>
>
>
> On 4/8/21 7:51 AM, Vincent Guittot wrote:
>
> >> I was suprised to find the overall cpu% consumption of update_blocked_averages
> >> and throughput of the benchmark still didn't change much.  So I took a
> >> peek into the profile and found the update_blocked_averages calls shifted to the idle load balancer.
> >> The call to update_locked_averages was reduced in newidle_balance so the patch did
> >> what we intended.  But the overall rate of calls to
> >
> > At least , we have removed the useless call to update_blocked_averages
> > in newidle_balance when we will not perform any newly idle load
> > balance
> >
> >> update_blocked_averages remain roughly the same, shifting from
> >> newidle_balance to run_rebalance_domains.
> >>
> >>    100.00%  (ffffffff810cf070)
> >>             |
> >>             ---update_blocked_averages
> >>                |
> >>                |--95.47%--run_rebalance_domains
> >>                |          __do_softirq
> >>                |          |
> >>                |          |--94.27%--asm_call_irq_on_stack
> >>                |          |          do_softirq_own_stack
> >
> > The call of  update_blocked_averages mainly comes from SCHED_SOFTIRQ.
> > And as a result, not from the new path
> > do_idle()->nohz_run_idle_balance() which has been added by this patch
> > to defer the call to update_nohz_stats() after newlyidle_balance and
> > before entering idle.
> >
> >>                |          |          |
> >>                |          |          |--93.74%--irq_exit_rcu
> >>                |          |          |          |
> >>                |          |          |          |--88.20%--sysvec_apic_timer_interrupt
> >>                |          |          |          |          asm_sysvec_apic_timer_interrupt
> >>                |          |          |          |          |
> >>                ...
> >>                |
> >>                |
> >>                 --4.53%--newidle_balance
> >>                           pick_next_task_fair
> >>
> >> I was expecting idle load balancer to be rate limited to 60 Hz, which
> >
> > Why 60Hz ?
> >
>
> My thinking is we will trigger load balance only after rq->next_balance.
>
> void trigger_load_balance(struct rq *rq)
> {
>         /* Don't need to rebalance while attached to NULL domain */
>         if (unlikely(on_null_domain(rq)))
>                 return;
>
>         if (time_after_eq(jiffies, rq->next_balance))
>                 raise_softirq(SCHED_SOFTIRQ);
>
>         nohz_balancer_kick(rq);
> }
>
> And it seems like next_balance is set to be 60 Hz
>
> static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
> {
>         int continue_balancing = 1;
>         int cpu = rq->cpu;
>         int busy = idle != CPU_IDLE && !sched_idle_cpu(cpu);
>         unsigned long interval;
>         struct sched_domain *sd;
>         /* Earliest time when we have to do rebalance again */
>         unsigned long next_balance = jiffies + 60*HZ;

This doesn't mean 60 Hz period but 60*HZ with HZ being the number of
jiffies per second. We init next_balance with now + 60 sec to make
sure it's far later than the next balance of the sched_domains

Then, update_next_balance() keeps track of 1st balance to happen next time

>
>
> >> should be 15 jiffies apart on the test system with CONFIG_HZ_250.
> >> When I did a trace on a single CPU, I see that update_blocked_averages
> >> are often called between 1 to 4 jiffies apart, which is at a much higher
> >> rate than I expected.  I haven't taken a closer look yet.  But you may
> >
> > 2 things can trigger a SCHED_SOFTIRQ/run_rebalance_domains:
> > - the need for an update of blocked load which should not happen more
> > than once every 32ms which means a rate of around 30Hz
> > - the need for a load balance of a sched_domain. The min interval for
> > a sched_domain is its weight when the CPU is idle which is usually few
> > jiffies
> >
> > The only idea that I have for now is that we spend less time in
> > newidle_balance which changes the dynamic of your system.
> >
> > In your trace, could you check if update_blocked_averages is called
> > during the tick ? and Is the current task idle task ?
>
> Here's a snapshot of the trace. However I didn't have the current task in my trace.
> You can tell the frequency that update_blocked_averages is called on
> cpu 2 by the jiffies value.  They are quite close together (1 to 3 jiffies apart).
> When I have a chance to get on the machine, I'll take another look
> at the current task and whether we got to trigger_load_balance() from scheduler_tick().
>
>
>      3.505 (         ): probe:update_blocked_averages:(ffffffff810cf070) cpu=2 jiffies=0x1004fb731
>      4.505 (         ): probe:update_blocked_averages:(ffffffff810cf070) cpu=2 jiffies=0x1004fb732
>      6.484 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb733
>      6.506 (         ): probe:update_blocked_averages:(ffffffff810cf070) cpu=2 jiffies=0x1004fb734
>      9.503 (         ): probe:update_blocked_averages:(ffffffff810cf070) cpu=2 jiffies=0x1004fb737
>     11.504 (         ): probe:update_blocked_averages:(ffffffff810cf070) cpu=2 jiffies=0x1004fb739
>     11.602 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb739
>     11.624 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
>     11.642 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
>     11.645 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
>     11.977 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
>     12.003 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
>     12.015 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
>     12.043 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
>     12.567 (         ): probe:update_blocked_averages:(ffffffff810cf070) cpu=2 jiffies=0x1004fb73a
>     13.856 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb73b
>     13.910 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73b
>     14.003 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73b
>     14.159 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73b
>     14.203 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73b
>     14.223 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73b
>     14.301 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73b
>     14.504 (         ): probe:update_blocked_averages:(ffffffff810cf070) cpu=2 jiffies=0x1004fb73c
>     14.637 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb73c
>     14.666 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73c
>     15.059 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73c
>     15.083 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73c
>     15.100 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73c
>     15.103 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73c
>     15.150 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73c
>     15.227 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73c
>     15.248 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73c
>     15.311 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73c
>     15.503 (         ): probe:update_blocked_averages:(ffffffff810cf070) cpu=2 jiffies=0x1004fb73d
>     16.140 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb73d
>     16.185 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73d
>     16.224 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73d
>     16.340 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73d
>     16.384 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73d
>     16.503 (         ): probe:update_blocked_averages:(ffffffff810cf070) cpu=2 jiffies=0x1004fb73e
>     16.993 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb73e
>     17.504 (         ): probe:update_blocked_averages:(ffffffff810cf070) cpu=2 jiffies=0x1004fb73f
>     17.630 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb73f
>     17.830 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73f
>     18.015 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73f
>     18.031 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73f
>     18.036 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73f
>     18.040 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73f
>     18.502 (         ): probe:update_blocked_averages:(ffffffff810cf070) cpu=2 jiffies=0x1004fb740
>

I don't know exactly what you track with "next_balance=" in
probe:newidle_balance but it always starts with the same value
0x1004fb76c in the future to finish with a value 0x1004fb731 in the
past. This would mean that a load balance is needed during the next
tick which explains why we can see then the
probe:update_blocked_averages for each tick.

Also could you check if the tick is stopped when idle. When the
predicted idle time is short and the next wake is expected to happen
before the next tick, the tick is not stopped.

Vincent

> Thanks for taking a look.
>
> Tim

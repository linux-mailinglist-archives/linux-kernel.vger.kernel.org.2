Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D0537AAA6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 17:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhEKP1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 11:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbhEKP1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 11:27:21 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE76C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 08:26:13 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id y9so25626742ljn.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 08:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EmAdyX2bJ52mem7X3IUBM6JVZGsCmdvevL4wJ9wmn84=;
        b=aFSAIinW7rDDz4KQKb7r1nP3+RGYkuVF6PtfMP8j7gPrWPCMfEUaXVX8aFUsGoZYDn
         8RyJM8uJKKpTxTFTXKN2sU6Zw16rGuTX20NmhTb3ec3Q5EP9XWR0fSj/4dpQtiNmyhVN
         XMqJ348E7fHXKw4lEUMhSOH0sYeD759m/K1C5u6rxESFY7xb/EvYhoDn7Xs4VVOu5Evy
         wfdTB887bAouholoExJLwVJ1HmZFWwYmTP07lRivue/u/z0fuSEjYZ1kd86rMMWxSpyU
         VMiYBfavg/vHqstbaAHXt30f1qyzTiLwARuXHlLfHchVIjq8UWiG/WZJ/YPKYe13bbmW
         gw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EmAdyX2bJ52mem7X3IUBM6JVZGsCmdvevL4wJ9wmn84=;
        b=LLb+eXdvhWvMd4h42btF9cWhwbAaphprytX/5kjqJfOWyYzrELHOsuPDWWdpC8zPuf
         Z8Nj7n7sSsP6zKBm6nPjjwcmpx9tH64NwoHruj6Inr9ZaIH7DYvyFMxxAFY2KxfGCUBD
         zD+BL2hc91GinMwVHw0pAbVL/sEBAhKf+lJhdAsv9WhSHBXJI8dHXJ+up4UHt/50BdTB
         g+XkZ8RsZ4TKISM/NjYXD4DELXXzNDDjxo8v08as+6oKVYxI5YcvWrI8WEnUOA4CkRui
         vyvQF12RMLbR1Kv26ktJmUiZ+k+KL4FXEnMS3wK0SevM4mKx+iwTKHPT2CH+Bn62wzoE
         5a+w==
X-Gm-Message-State: AOAM5302TcPzt4DPHmRVXIeTjm8irVCTvZ/9FE0n8ArYdLLI9Q5H0el6
        wfF6nPs2s2LDfkOmlxPW0F5RYlwUxojGJ3GJw7mm7Q==
X-Google-Smtp-Source: ABdhPJwQY4A08YH92xvcWq6PYYiWV5jplsqt6NaXcSe2muW6f0/DBQ3LzT1+EVJDevPs0EKqQeSxHSDEGVtPvjjvS1k=
X-Received: by 2002:a2e:9bd7:: with SMTP id w23mr24367028ljj.401.1620746771589;
 Tue, 11 May 2021 08:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210122154600.1722680-1-joel@joelfernandes.org>
 <YAsjOqmo7TEeXjoj@google.com> <CAKfTPtBWoRuwwkaqQKNgHTnQBE4fevyYqEoeGc5RpCsBbOS1sQ@mail.gmail.com>
 <YBG0W5PFGtGRCEuB@google.com> <CAKfTPtBqj5A_7QmxhhmkNTc3+VT6+AqWgw1GDYrgy1V5+PJMmQ@mail.gmail.com>
 <CAEXW_YRrhEfGcLN5yrLJZm6HrB15M_R5xfpMReG2wE2rSmVWdA@mail.gmail.com>
 <CAKfTPtBvwm9vZb5C=2oTF6N-Ht6Rvip4Lv18yi7O3G8e-_ZWdg@mail.gmail.com>
 <20210129172727.GA30719@vingu-book> <274d8ae5-8f4d-7662-0e04-2fbc92b416fc@linux.intel.com>
 <20210324134437.GA17675@vingu-book> <efad4771-c9d1-5103-de9c-0ec5fa78ee24@linux.intel.com>
 <CAKfTPtDsya_zdUB1ARmoxQs5xWS8o-XrrzyNx5R1iSNrchUXtg@mail.gmail.com>
 <fc0efe4e-0a81-03b8-08cb-029468c57782@linux.intel.com> <CAKfTPtCKavGWja42NdTmb+95ppG-WxYzoTJMmtgkCQcA-btfBw@mail.gmail.com>
 <4aa674d9-db49-83d5-356f-a20f9e2a7935@linux.intel.com> <CAKfTPtDJaTr_HR2t=9CQ-9x6keu-qzx6okci92AdW5cJG8J9zg@mail.gmail.com>
 <2d2294ce-f1d1-f827-754b-4541c1b43be8@linux.intel.com> <ade18978-cd67-6215-28f0-4857c66a99fb@linux.intel.com>
In-Reply-To: <ade18978-cd67-6215-28f0-4857c66a99fb@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 11 May 2021 17:25:59 +0200
Message-ID: <CAKfTPtA8nr-fgt4Nw6XqQyT_TEx4uL3nK-ba0xGfkONO+BPG3Q@mail.gmail.com>
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

Hi Tim,

On Mon, 10 May 2021 at 23:59, Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
>
>
> On 4/9/21 10:59 AM, Tim Chen wrote:
>
> >>>     11.602 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb739
> >>>     11.624 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
> >>>     11.642 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
> >>>     11.645 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
> >>>     11.977 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
> >>>     12.003 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
> >>>     12.015 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
> >>>     12.043 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
> >>>     12.567 (         ): probe:update_blocked_averages:(ffffffff810cf070) cpu=2 jiffies=0x1004fb73a
> >>>     13.856 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb73b
> >>>     13.910 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73b
> >>>     14.003 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73b
> >>>     14.159 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73b
> >>>     14.203 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73b
> >>>     14.223 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73b
> >>>     14.301 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73b
> >>>     14.504 (         ): probe:update_blocked_averages:(ffffffff810cf070) cpu=2 jiffies=0x1004fb73c
>
> >> I don't know exactly what you track with "next_balance=" in
> >
> > It is the rq->next_balance value as we enter the newidle_balance function.
> >
> >> probe:newidle_balance but it always starts with the same value
> >> 0x1004fb76c in the future to finish with a value 0x1004fb731 in the
> >> past.
> >
> > This indeed is odd as the next_balance should move forward and not backward.
>
>
> Vincent,
>
> I found a bug in newidle_balance() that moved the next balance time
> backward.  I fixed it in patch 1 below.  This corrects the
> next_balance time update and we now have proper load balance rate limiting.
>
> After putting in the other two changes previously discussed with you (patch 2 and 3 below),
> I see very good improvement (about +5%) in the database workload I was investigating.
> The costly update_blocked_averages() function is called much less frequently and consumed
> only 0.2% of cpu cycles instead of 2.6% before the changes.

That's a good news

>
> Including all three patches here together for easier review.  The patches
> apply to the tip tree's sched/core branch.
>
> Thanks.
>
> Tim
>
> --->8---
>
> From 848eb8f45b53b45cacf70022c98f632daabefe77 Mon Sep 17 00:00:00 2001
> Message-Id: <848eb8f45b53b45cacf70022c98f632daabefe77.1620677280.git.tim.c.chen@linux.intel.com>
> From: Tim Chen <tim.c.chen@linux.intel.com>
> Date: Fri, 7 May 2021 14:19:47 -0700
> Subject: [PATCH 1/3] sched: Fix rq->next_balance time going backward
>
> In traces on newidle_balance(), this_rq->next_balance
> time goes backward from time to time, e.g.
>
> 11.602 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb739
> 11.624 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
> 13.856 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb73b
> 13.910 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73b
> 14.637 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb73c
> 14.666 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73c
>
> This was due to newidle_balance() updated this_rq->next_balance
> to an earlier time than its current value. The real intention
> was to make sure next_balance move this_rq->next_balance forward
> in its update:

Sometimes, we want to set this_rq->next_balance backward compared to
its current value. When a CPU is busy, the balance interval is
multiplied by busy_factor which is set to 16 by default. On SMT2 sched
domain level, it means that the interval will be 32ms when busy
instead of 2ms. But if a busy load balance happens just before
becoming idle, the this_rq->next_balance will be set 32ms later
whereas it should go down to 2ms as the CPU is now idle. And this
becomes even worse when you have 128 CPUs at die sched_domain level
because the idle CPU will have to wait 2048ms instead of the correct
128ms interval.

>
> out:
>         /* Move the next balance forward */
>         if (time_after(this_rq->next_balance, next_balance))
>                 this_rq->next_balance = next_balance;
>
> The actual outcome was moving this_rq->next_balance backward,
> in the wrong direction.

As explained above, this is intentional.
You are facing a situation where the load balance of sched_domain
level has not run for a while and last_balance is quite old and
generates a next_balance still in the past.

typically:

CPU is busy
CPU runs busy LB at time T so last_balance = T
And next LB  will not happen before T+16*Interval
At time T+15*Interval, CPU enters idle
newidle_balance updates next_balance to last_balance+Interval which is
in the past

>
> Fix the incorrect check on next_balance causing the problem.
>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1d75af1ecfb4..b0b5698b2184 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10681,7 +10681,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>
>  out:
>         /* Move the next balance forward */
> -       if (time_after(this_rq->next_balance, next_balance))
> +       if (time_after(next_balance, this_rq->next_balance))

The current comparison is correct but next_balance should not be in the past.

update_next_balance() is only used in newidle_balance() so we could
modify it to  have:

next = max(jiffies+1, next = sd->last_balance + interval)


>                 this_rq->next_balance = next_balance;
>
>         if (pulled_task)
> --
> 2.20.1
>
>
> From f2c9af4af6438ad79076e1a664003dc01ad4fdf0 Mon Sep 17 00:00:00 2001
> Message-Id: <f2c9af4af6438ad79076e1a664003dc01ad4fdf0.1620677280.git.tim.c.chen@linux.intel.com>
> In-Reply-To: <848eb8f45b53b45cacf70022c98f632daabefe77.1620677280.git.tim.c.chen@linux.intel.com>
> References: <848eb8f45b53b45cacf70022c98f632daabefe77.1620677280.git.tim.c.chen@linux.intel.com>
> From: Vincent Guittot <vincent.guittot@linaro.org>
> Date: Fri, 7 May 2021 14:38:10 -0700
> Subject: [PATCH 2/3] sched: Skip update_blocked_averages if we are defering
>  load balance
>
> In newidle_balance(), the scheduler skips load balance to the new idle cpu when sd is this_rq and when
>
>    this_rq->avg_idle < sd->max_newidle_lb_cost
>
> Doing a costly call to update_blocked_averages() will
> not be useful and simply adds overhead when this condition is true.
>
> Check the condition early in newidle_balance() to skip update_blocked_averages()
> when possible.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  kernel/sched/fair.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b0b5698b2184..f828b75488a0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10612,17 +10612,20 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>          */
>         rq_unpin_lock(this_rq, rf);
>
> +       rcu_read_lock();
> +       sd = rcu_dereference_check_sched_domain(this_rq->sd);
> +
>         if (this_rq->avg_idle < sysctl_sched_migration_cost ||
> -           !READ_ONCE(this_rq->rd->overload)) {
> +           !READ_ONCE(this_rq->rd->overload) ||
> +           (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
>
> -               rcu_read_lock();
> -               sd = rcu_dereference_check_sched_domain(this_rq->sd);
>                 if (sd)
>                         update_next_balance(sd, &next_balance);
>                 rcu_read_unlock();
>
>                 goto out;
>         }
> +       rcu_read_unlock();
>
>         raw_spin_unlock(&this_rq->lock);
>
> --
> 2.20.1
>
>
> From c45d13c6156c3cdc340ef3ba523b8750642a9c50 Mon Sep 17 00:00:00 2001
> Message-Id: <c45d13c6156c3cdc340ef3ba523b8750642a9c50.1620677280.git.tim.c.chen@linux.intel.com>
> In-Reply-To: <848eb8f45b53b45cacf70022c98f632daabefe77.1620677280.git.tim.c.chen@linux.intel.com>
> References: <848eb8f45b53b45cacf70022c98f632daabefe77.1620677280.git.tim.c.chen@linux.intel.com>
> From: Tim Chen <tim.c.chen@linux.intel.com>
> Date: Fri, 7 May 2021 14:54:54 -0700
> Subject: [PATCH 3/3] sched: Rate limit load balance in newidle_balance()
>
> Currently newidle_balance() could do load balancng even if the cpu is not
> due for a load balance.  Make newidle_balance() check the next_balance
> time on the cpu's runqueue so it defers load balancing if it is not
> due for its load balance.
>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  kernel/sched/fair.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f828b75488a0..8e00e1fdd6e0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10617,6 +10617,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>
>         if (this_rq->avg_idle < sysctl_sched_migration_cost ||
>             !READ_ONCE(this_rq->rd->overload) ||
> +           time_before(jiffies, this_rq->next_balance) ||
>             (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
>
>                 if (sd)
> --
> 2.20.1
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BDC3AC8CB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 12:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhFRKbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 06:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhFRKbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 06:31:18 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B735DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 03:29:08 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id m21so15812870lfg.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 03:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z6D2vvq6CYIqKJZzD2AvF+JY31spdNLaL0sBFiKq4gA=;
        b=jvyX3cmpWwlKL+jHalUnn8VcfOevqPnE1knaTaQrThN7w5ZIPFRVtdnyPbgs3e0TdX
         zaGB3EJXk1+nAlffOZSxEWv1ydWJYrlEdi3mOGaY6xg0E3fKLYFDcwEABx6di0rTvfTs
         a1+7j4Y15H1nIZEA+RZk6D7hI06/ISBccpJbFIKaZ2K/xRmbfvgXqPPK4bw1yHa+vYgB
         PwuE/SZGJQR2bm7j0kDx0T3+QdKadBSkg0ORW0EWHKgDvPEF2bFUzTrdkLh/VebHuVCz
         BSXcS5tuaMQdEW2sqADK+LgkpHYIkx6p2B8ikCFepASUc+4rDC90x+TGekFZfeLsBMs2
         lH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z6D2vvq6CYIqKJZzD2AvF+JY31spdNLaL0sBFiKq4gA=;
        b=APhRtoP5stw/zJaJCDmeoEYRJrHBxoW9BuSw5t9B2Pvq0s8EeaGkMZJKo4akVln8M+
         lbsJ66MB5g/A91gEoYe7hNsznqZqaCT/HbxKjXR53dTewbJctxdCKEkqTu8idUJ4E3IC
         4w9HMorZHGcH+abQhadRaIyeEz9JWcX5j+3cFMY3E62Ki9Pz1w9rakk2FnTwUXsnHQmD
         pvrKMXf/9uK4KU/zojmF/PXBNnfbykAM54h4sbUPDRwYWomn6T7Z/YvjAXTmj/gfEzj2
         LgX4Z+mwgYy202FvO/DS8A7QnfAR04g5PpjBY6L5Cq3TOEGR0eKQU6qzpIZF78A5L5PI
         hD6A==
X-Gm-Message-State: AOAM531qDM75XopQG6RxDCAqhjT5jG6Ug9GrWY21t37AtJY/pQYLg5P4
        j9Up37geeTTDAISEOseZpCSKisRKCEjNVki3QDrSSQ==
X-Google-Smtp-Source: ABdhPJxdhLD6z9+L0YgeOyRwFi4+TGvTz+hpJenccvT2lQTilh2p1GytUTwL/mxkwm6C33q07QXxehUiqfcfYdhacLI=
X-Received: by 2002:ac2:4949:: with SMTP id o9mr2691569lfi.254.1624012146987;
 Fri, 18 Jun 2021 03:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <efad4771-c9d1-5103-de9c-0ec5fa78ee24@linux.intel.com>
 <CAKfTPtDsya_zdUB1ARmoxQs5xWS8o-XrrzyNx5R1iSNrchUXtg@mail.gmail.com>
 <fc0efe4e-0a81-03b8-08cb-029468c57782@linux.intel.com> <CAKfTPtCKavGWja42NdTmb+95ppG-WxYzoTJMmtgkCQcA-btfBw@mail.gmail.com>
 <4aa674d9-db49-83d5-356f-a20f9e2a7935@linux.intel.com> <CAKfTPtDJaTr_HR2t=9CQ-9x6keu-qzx6okci92AdW5cJG8J9zg@mail.gmail.com>
 <2d2294ce-f1d1-f827-754b-4541c1b43be8@linux.intel.com> <ade18978-cd67-6215-28f0-4857c66a99fb@linux.intel.com>
 <CAKfTPtA8nr-fgt4Nw6XqQyT_TEx4uL3nK-ba0xGfkONO+BPG3Q@mail.gmail.com>
 <577b0aae-0111-97aa-0c99-c2a2fcfb5e2e@linux.intel.com> <20210512135955.suzvxxfilvwg33y2@e107158-lin.cambridge.arm.com>
 <729718fd-bd2c-2e0e-46f5-8027281e5821@linux.intel.com>
In-Reply-To: <729718fd-bd2c-2e0e-46f5-8027281e5821@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 18 Jun 2021 12:28:55 +0200
Message-ID: <CAKfTPtCYU2AW3sJ-=QJ=hE+tFHS8wUBZ9vSsZp8q2AozxeA5mQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Rate limit calls to update_blocked_averages()
 for NOHZ
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Dietmar Eggeman <dietmar.eggemann@arm.com>,
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

On Fri, 11 Jun 2021 at 22:00, Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
>
>
> On 5/12/21 6:59 AM, Qais Yousef wrote:
> > On 05/11/21 10:25, Tim Chen wrote:
> >>> update_next_balance() is only used in newidle_balance() so we could
> >>> modify it to  have:
> >>>
> >>> next = max(jiffies+1, next = sd->last_balance + interval)
> >>
> >> Is the extra assignment "next = sd->last_balance + interval" needed?
> >> This seems more straight forward:
> >>
> >> next = max(jiffies+1, sd->last_balance + interval)
> >
> > I haven't been following the whole conversation closely, but it's always
> > interesting when manipulating time in non time_*() functions.
> >
> > Is this max() safe against wrapping?
> >
>
> Vincent,
>
> Sorry I haven't got back sooner. I finally was able to get some test
> time on the test system. The fix works to correct the next balance time
> going backwards but the frequency of balancing still remains the same,
> so we don't see performance improvement.
>
> I incorporated Qais' suggestion to take care of the wrap around time
> (see patch #1) in patches below.  This patch by itself prevented
> the next_balance from going backward.  However, most of the time the
> next_balance occurs immediately in the next jiffie after newidle_balance

Which is not really surprising as we don't want to keep a CPU idle if
another one is overloaded.

> occured and we still have the same amount of load balancing as the vanilla
> kernel on the OLTP workload I was looking at.  I didn't see performance
> improvement with just patch#1 and patch#2.
>
> The current logic is when a CPU becomes idle, next_balance occur very
> shortly (usually in the next jiffie) as get_sd_balance_interval returns
> the next_balance in the next jiffie if the CPU is idle.  However, in
> reality, I saw most CPUs are 95% busy on average for my workload and
> a task will wake up on an idle CPU shortly.  So having frequent idle
> balancing towards shortly idle CPUs is counter productive and simply
> increase overhead and does not improve performance.

Just to make sure that I understand your problem correctly:  Your problem is:
- that we have an ilb happening on the idle CPU and consume cycle
- or that the ilb will pull a task on an idle CPU on which a task will
shortly wakeup which ends to 2 tasks competing for the same CPU.

>
> I tried a patch (patch 3) in addition to the other patches. It improved
> performance by 5%, which is quite significant for my OLTP workload.
> The patch considers a CPU busy when average its utilization is more
> than 80% when determining the next_balance interval.  This tweak may
> not be ideal for the case when CPU becomes idle after a CPU intensive
> task dominates a CPU for a long time and will block for a while.
>
> Hopefully we can find a way to make good judgement on whether we have
> a mostly busy CPU that becomes idle, and a task likely to wake up on
> it soon.  For such case, we should push out the next balance time.  Such
> logic is absent today in the idle load balance path.  And such frequent
> load balancing hurt performance when cgroup is turned on. Computing
> update_blocked_averages before load balance becomes expensive. For my
> OLTP workload, we lose 9% of performance when cgroup is turned on.
>
> Tim
>
>
> ----
>
> From 2a5ebdeabbfdf4584532ef0e27d37ed75ca7dbd3 Mon Sep 17 00:00:00 2001
> Message-Id: <2a5ebdeabbfdf4584532ef0e27d37ed75ca7dbd3.1623433293.git.tim.c.chen@linux.intel.com>
> From: Tim Chen <tim.c.chen@linux.intel.com>
> Date: Tue, 11 May 2021 09:55:41 -0700
> Subject: [PATCH 1/3] sched: sched: Fix rq->next_balance time updated to
>  earlier than current time
>
> In traces on newidle_balance(), this_rq->next_balance
> time goes backward and earlier than current time jiffies, e.g.
>
> 11.602 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb739
> 11.624 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
> 13.856 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb73b
> 13.910 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73b
> 14.637 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb73c
> 14.666 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73c
>
> It doesn't make sense to have a next_balance in the past.
> Fix newidle_balance() and update_next_balance() so the next
> balance time is at least jiffies+1.
>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  kernel/sched/fair.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1d75af1ecfb4..740a0572cbf1 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9901,7 +9901,10 @@ update_next_balance(struct sched_domain *sd, unsigned long *next_balance)
>
>         /* used by idle balance, so cpu_busy = 0 */
>         interval = get_sd_balance_interval(sd, 0);
> -       next = sd->last_balance + interval;
> +       if (time_after(jiffies+1, sd->last_balance + interval))
> +               next = jiffies+1;
> +       else
> +               next = sd->last_balance + interval;
>
>         if (time_after(*next_balance, next))
>                 *next_balance = next;
> @@ -10681,6 +10684,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>
>  out:
>         /* Move the next balance forward */
> +       if (time_after(jiffies+1, this_rq->next_balance))
> +               this_rq->next_balance = jiffies+1;
>         if (time_after(this_rq->next_balance, next_balance))
>                 this_rq->next_balance = next_balance;
>
> --
> 2.20.1
>
>
> From 59de98515bda38b8d6faec5f8c68e1c9ec18962e Mon Sep 17 00:00:00 2001
> Message-Id: <59de98515bda38b8d6faec5f8c68e1c9ec18962e.1623433293.git.tim.c.chen@linux.intel.com>
> In-Reply-To: <2a5ebdeabbfdf4584532ef0e27d37ed75ca7dbd3.1623433293.git.tim.c.chen@linux.intel.com>
> References: <2a5ebdeabbfdf4584532ef0e27d37ed75ca7dbd3.1623433293.git.tim.c.chen@linux.intel.com>
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
> index 740a0572cbf1..a69bfc651e55 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10615,17 +10615,20 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
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
> From 4622055d989a5feb446a7893a48fcd31305ec7a7 Mon Sep 17 00:00:00 2001
> Message-Id: <4622055d989a5feb446a7893a48fcd31305ec7a7.1623433293.git.tim.c.chen@linux.intel.com>
> In-Reply-To: <2a5ebdeabbfdf4584532ef0e27d37ed75ca7dbd3.1623433293.git.tim.c.chen@linux.intel.com>
> References: <2a5ebdeabbfdf4584532ef0e27d37ed75ca7dbd3.1623433293.git.tim.c.chen@linux.intel.com>
> From: Tim Chen <tim.c.chen@linux.intel.com>
> Date: Mon, 24 May 2021 13:21:03 -0700
> Subject: [PATCH 3/3] sched: Don't shorten the load balance interval of a 80%
>  or more busy CPU
>
> For a CPU that's busy 80% or more on average, it is quite likely that a task
> will wake up on it very soon. It is better to not shorten the load
> balance interval as if it is completely idle to save on the load
> balancing overhead.
>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  kernel/sched/fair.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a69bfc651e55..7353395d8a3a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9895,12 +9895,11 @@ get_sd_balance_interval(struct sched_domain *sd, int cpu_busy)
>  }
>
>  static inline void
> -update_next_balance(struct sched_domain *sd, unsigned long *next_balance)
> +update_next_balance(struct sched_domain *sd, unsigned long *next_balance, int cpu_busy)
>  {
>         unsigned long interval, next;
>
> -       /* used by idle balance, so cpu_busy = 0 */
> -       interval = get_sd_balance_interval(sd, 0);
> +       interval = get_sd_balance_interval(sd, cpu_busy);
>         if (time_after(jiffies+1, sd->last_balance + interval))
>                 next = jiffies+1;
>         else
> @@ -10593,6 +10592,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>         struct sched_domain *sd;
>         int pulled_task = 0;
>         u64 curr_cost = 0;
> +       int cpu_busy = 0;
>
>         update_misfit_status(NULL, this_rq);
>         /*
> @@ -10618,12 +10618,20 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>         rcu_read_lock();
>         sd = rcu_dereference_check_sched_domain(this_rq->sd);
>
> +       /*
> +        * Consider the cpu busy if it has more than 80% average utilization.
> +        * Idle balance such cpu not as frequently as a task may wake up soon.
> +        */
> +       if ((cpu_util(this_cpu) * 10 > capacity_orig_of(this_cpu) * 8))
> +               cpu_busy = 1;
> +
>         if (this_rq->avg_idle < sysctl_sched_migration_cost ||
>             !READ_ONCE(this_rq->rd->overload) ||
>             (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
>
>                 if (sd)
> -                       update_next_balance(sd, &next_balance);
> +                       update_next_balance(sd, &next_balance, cpu_busy);
> +
>                 rcu_read_unlock();
>
>                 goto out;
> @@ -10639,7 +10647,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>                 u64 t0, domain_cost;
>
>                 if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
> -                       update_next_balance(sd, &next_balance);
> +                       update_next_balance(sd, &next_balance, cpu_busy);
>                         break;
>                 }
>
> @@ -10657,7 +10665,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>                         curr_cost += domain_cost;
>                 }
>
> -               update_next_balance(sd, &next_balance);
> +               update_next_balance(sd, &next_balance, cpu_busy);
>
>                 /*
>                  * Stop searching for tasks to pull if there are
> --
> 2.20.1
>

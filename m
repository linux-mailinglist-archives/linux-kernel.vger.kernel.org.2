Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248AF3A68E6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 16:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbhFNOY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 10:24:26 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:40464 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbhFNOYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 10:24:24 -0400
Received: by mail-lj1-f175.google.com with SMTP id x14so20398768ljp.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 07:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4491qLS7Ug7RQHvCqc+xB0C21Sby+RTFT1BfGwhbNMA=;
        b=Hje/gYbv7CUTUSRR6fZ71Xr0yz1bS6wLAfnqsdnkuq573nENQCk9cRFlcrHb4Jxpd3
         5DZhSb59/cLNJqLWx+x5tniGjJI8039O+pnJ0uYhIJkdFYnM75/LJ2GZR4HXqBc7NQW1
         sJPeRiCsbMkhBENQymmA6buIQNJVocI2RmnP27sAqOTrLpLqs5wuzev4Mz7eyEUOf0mV
         FTl+Ds0ufsA59/RxcSoo0RHNHxAWCKOcWY6tj8QxpLxohJNPj2RS+dEx6s62HTV5Ec5w
         gnSyZFxi1aG948AFYEGKO4OLb4MS6y0BseEDLHtnkJm+40FfceL2tUmQ5FHE1o3wtB9J
         u2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4491qLS7Ug7RQHvCqc+xB0C21Sby+RTFT1BfGwhbNMA=;
        b=cu+mBVNTVfJp/n0/5YlvPd1mNx6W3LEUtSs8PPc+pe5uGlwoantYw9M3v0+Bueiy0C
         lZiyuhd0EPjbT6vIbVtxW/eRWbNkiQtQwuoiDNzS2aM31ys8ZtsakGBwii46+NzWgFPH
         MSd3J1tINMV50lZ5cIAUc/dSuWUQQnxuFIlfTuDJdQVATEqIPn0h0lsylN6OqCRXCk8Y
         SJ8qSOtCmveKFvwrw76+UfJtsQ/JYpeF15uRaAtbFb6a5BkBxlhl4bW/TYwMfi6Ar2bR
         RwxJbPQWUshEVryHguSoOgea+vlJsPIhQgziP2CdtgfkHIBSkYWwVmTX4CHzX1Wmrvyr
         bR3A==
X-Gm-Message-State: AOAM531bOP2R7duYp7VjG8F7NACqlrS2CORxmeseZvcvVJT8qhHeOTST
        0HWuIWYw9YFocCa6dH7jJQeZSULTJ7Pc2EvVQKD/Zg==
X-Google-Smtp-Source: ABdhPJzoFZ523EE6orDMl56v8MhJIfHq5OeV6hT4ltnYy7EOcXNo3qcPPmB9qbrc5VNav8m85oEzUcGQSMIl9w5SiBE=
X-Received: by 2002:a2e:9b07:: with SMTP id u7mr13489488lji.209.1623680468190;
 Mon, 14 Jun 2021 07:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210602122555.10082-1-laoar.shao@gmail.com> <CAKfTPtCS6bVGK1EFUHygj+uZL5N2kEzyyEeoyT4Cuc7r-65yVw@mail.gmail.com>
 <CALOAHbB7Re8ES86bC10vz7KuNjLV1fA7tuLUmJY==sR-fB-+qQ@mail.gmail.com>
In-Reply-To: <CALOAHbB7Re8ES86bC10vz7KuNjLV1fA7tuLUmJY==sR-fB-+qQ@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 14 Jun 2021 16:20:56 +0200
Message-ID: <CAKfTPtBd349eyDhA5ThCAHFd83cGMQKb_LDxD4QvyP-cJOBjqA@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched: do active load balance on the new idle cpu
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jun 2021 at 12:23, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> On Wed, Jun 2, 2021 at 8:37 PM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Wed, 2 Jun 2021 at 14:26, Yafang Shao <laoar.shao@gmail.com> wrote:
> > >
> > > We monitored our latency-sensitive RT tasks are randomly preempted by the
> > > kthreads migration/n, which means to migrate tasks on CPUn to other new
> > > idle CPU. The logical as follows,
> > >
> > >   new idle CPU                          CPU n
> > >   (no task to run)                      (busy running)
> > >   wakeup migration/n                    (busy running)
> > >   (idle)                                migraion/n preempts current task
> > >   run the migrated task                 (busy running)
> >
> > migration thread is only used when we want to migrate the currently
> > running task of the source cpu.
> > This doesn't seem to be your case as it's a RT thread that is
> > currently running so the migration thread should not be woken up as we
> > don't need it to migrate a runnable but not running cfs thread from
> > coin to new idle CPU
> >
> > Do you have more details about the UC. Could it be a race between new
> > idle load balance starting migration thread to pull the cfs running
> > thread and the RT thread waking up and preempting cfs task before
> > migration threads which then preempt your RT threads
> >
>
> Hi Vincent,
>
> When I analyze it on my test server, I find the race really exists. For example,
>
> sensing_node-2511 [007] d... 945.351566: sched_switch:
> prev_comm=sensing_node prev_pid=2511 prev_prio=98 prev_state=S ==>
> next_comm=cat next_pid=2686 next_prio=120
> cat-2686 [007] d... 945.351569: sched_switch: prev_comm=cat
> prev_pid=2686 prev_prio=120 prev_state=R+ ==> next_comm=sensing_node
> next_pid=2512 next_prio=98
> sensing_node-2516 [004] dn.. 945.351571: sched_wakeup:
> comm=migration/7 pid=47 prio=0 target_cpu=007
> sensing_node-2512 [007] d... 945.351572: sched_switch:
> prev_comm=sensing_node prev_pid=2512 prev_prio=98 prev_state=R ==>
> next_comm=migration/7 next_pid=47 next_prio=0
> sensing_node-2516 [004] d... 945.351572: sched_switch:
> prev_comm=sensing_node prev_pid=2516 prev_prio=98 prev_state=S ==>
> next_comm=sensing_node next_pid=2502 next_prio=98
> migration/7-47 [007] d... 945.351580: sched_switch:
> prev_comm=migration/7 prev_pid=47 prev_prio=0 prev_state=S ==>
> next_comm=sensing_node next_pid=2512 next_prio=98
> sensing_node-2502 [004] d... 945.351605: sched_switch:
> prev_comm=sensing_node prev_pid=2502 prev_prio=98 prev_state=S ==>
> next_comm=cat next_pid=2686 next_prio=120
>
> When CPU4 is waking migration/7, the CFS thread 'cat' is running on
> CPU7, but then 'cat' is preempted by a RT task 'sensing_node', and
> then the migration/7 preempts the RT task.

ok the race happens between :
    if (need_active_balance(&env)) {
and
        raw_spin_rq_lock_irqsave(busiest, flags);

>
> What about below patch to improve the race ? It can't avoid the race,
> but it could reduce the race.
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3248e24a90b0..0e8d31e17dc7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9794,6 +9794,20 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>                                 goto out_one_pinned;
>                         }
>
> +                       /*
> +                        * There may be a race between new idle load
> balance starting

s/new idle load/load/

In fact, the same can happen during all kind of  load balance


> +                        * migration thread to pull the cfs running
> thread and the RT
> +                        * thread waking up and preempting cfs task
> before migration
> +                        * threads which then preempt the RT thread.
> +                        * We'd better do the last minute check before starting
> +                        * migration thread to avoid preempting
> latency-sensitive RT thread.
> +                        */
> +                       if (dl_task(busiest->curr) || rt_task(busiest->curr)) {

if(busiest->curr->sched_class != &fair_sched_class)

Reviewing your proposal reminded me a similar discussion with Valentin:
https://lore.kernel.org/lkml/CAKfTPtBygNcVewbb0GQOP5xxO96am3YeTZNP5dK9BxKHJJAL-g@mail.gmail.com/


> +                               raw_spin_unlock_irqrestore(&busiest->lock,
> +                                                          flags);
> +                               goto out_one_pinned;

                               goto out;
is enough because the the task is not pinned


> +                       }
> +
>                         /* Record that we found at least one task that
> could run on this_cpu */
>                         env.flags &= ~LBF_ALL_PINNED;

Your test should be moved after clearing the LBF_ALL_PINNED flag


>
> >
> >
> > >
> > > As the new idle CPU is going to be idle, we'd better move the migration
> > > work on it instead of burdening the busy CPU. After this change, the
> > > logic is,
> > >  new idle CPU                           CPU n
> > >  (no task to run)                       (busy running)
> > >  migrate task from CPU n                (busy running)
> > >  run the migrated task                  (busy running)
> > >
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > ---
> > >  kernel/sched/fair.c | 17 +++++------------
> > >  1 file changed, 5 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 3248e24a90b0..3e8b98b982ff 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -9807,13 +9807,11 @@ static int load_balance(int this_cpu, struct rq *this_rq,
> > >                                 busiest->push_cpu = this_cpu;
> > >                                 active_balance = 1;
> > >                         }
> > > -                       raw_spin_unlock_irqrestore(&busiest->lock, flags);
> > >
> > > -                       if (active_balance) {
> > > -                               stop_one_cpu_nowait(cpu_of(busiest),
> > > -                                       active_load_balance_cpu_stop, busiest,
> > > -                                       &busiest->active_balance_work);
> > > -                       }
> > > +                       if (active_balance)
> > > +                               active_load_balance_cpu_stop(busiest);
> >
> > this doesn't make sense because we reach this point if we want to
> > migrate the current running task of the busiest cpu and in order to do
> > this we need the preempt this current running thread
> >
> > > +
> > > +                       raw_spin_unlock_irqrestore(&busiest->lock, flags);
> > >                 }
> > >         } else {
> > >                 sd->nr_balance_failed = 0;
> > > @@ -9923,7 +9921,6 @@ static int active_load_balance_cpu_stop(void *data)
> > >         struct task_struct *p = NULL;
> > >         struct rq_flags rf;
> > >
> > > -       rq_lock_irq(busiest_rq, &rf);
> > >         /*
> > >          * Between queueing the stop-work and running it is a hole in which
> > >          * CPUs can become inactive. We should not move tasks from or to
> > > @@ -9933,8 +9930,7 @@ static int active_load_balance_cpu_stop(void *data)
> > >                 goto out_unlock;
> > >
> > >         /* Make sure the requested CPU hasn't gone down in the meantime: */
> > > -       if (unlikely(busiest_cpu != smp_processor_id() ||
> > > -                    !busiest_rq->active_balance))
> > > +       if (unlikely(!busiest_rq->active_balance))
> > >                 goto out_unlock;
> > >
> > >         /* Is there any task to move? */
> > > @@ -9981,13 +9977,10 @@ static int active_load_balance_cpu_stop(void *data)
> > >         rcu_read_unlock();
> > >  out_unlock:
> > >         busiest_rq->active_balance = 0;
> > > -       rq_unlock(busiest_rq, &rf);
> > >
> > >         if (p)
> > >                 attach_one_task(target_rq, p);
> > >
> > > -       local_irq_enable();
> > > -
> > >         return 0;
> > >  }
> > >
> > > --
> > > 2.17.1
> > >
>
>
>
> --
> Thanks
> Yafang

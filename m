Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBAB3A6B2E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbhFNQDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:03:42 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:34544 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbhFNQDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:03:36 -0400
Received: by mail-io1-f54.google.com with SMTP id 5so40135717ioe.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 09:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zlw6C4BVeoIektAw0/671uQ7k/dCV4oE7NLeUkepOkE=;
        b=HaZgiP3bTBRc+Ibn1fiQxLPi6aU8sKtv81OPYCze1LRJzEFTc3LGPQ/FvlZzdcR+mB
         gi1trgNgAIU3zDkplS84aH7fk4Ucr6CVJcYSFOQGhtfdUzbWHpJUgrTrwF8IaBPpXphX
         IJNA2uxIXI3p7BObrubu2+Bn1TUBatQZBHfoSE5RfLudXfHG4yce55W6hRE4m6PpITVJ
         jp6XqNpxe89NxZFsjDNehRcBxFpjjvDr+MNhvQl+T3tvptO+eRJUa6WNkbdY2Xt9DPOW
         nG/lPSWCMwc9PI5oraK19xdehwoVQnUsk9kzo/DLyARg2/sZlx1wI1tzvANgMkMaNYSb
         4jTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zlw6C4BVeoIektAw0/671uQ7k/dCV4oE7NLeUkepOkE=;
        b=Syp3UN3er9bGcEMuLlcV6Ff9f1tDQ5DYockvRj51IkbsEJzYe5LTxHHv8MfUcrJFn8
         37h1CKLiHlMhB6v8q8rcmVS2YZQ6YQpBQftsHWKV7aKgzmkMkWNFFzqcoTiAn8pDbRib
         JA8LShYrZv6vrzQ/hK+IN9lxx7kHGyyODaIu3pWdWEptM5NkuSZaP/aCkowAv+frqQM1
         4ungYCSwyE26dvyMFjAHqq2LfA4wP9dJdcSuZb2mk/Cz9isuqtaTyJMUrdoHb0EcslQO
         tAvj5uJ9p5C3Uay6fdD86JfpdXesYMkGnaBIUdxaQzo2DqwcZBrGURuJktfdOu3HHKoD
         1spA==
X-Gm-Message-State: AOAM532jXu6MgI7f1YFhZD+gry3UqUndD7vwocfZ91yKav6LDk2JniM2
        FVomuwJS2LmXUADWBR+M9lDurbtv8RMuqN7T2yE=
X-Google-Smtp-Source: ABdhPJztnup2mlccyKJ1EUT2pRPk+HndDNwp+IvBsm/wg8u6SAyke5cB6IRZRBnUhKL8N8MtBK5pDB6SGJD5Od1c6PA=
X-Received: by 2002:a05:6638:12c1:: with SMTP id v1mr17011505jas.97.1623686432936;
 Mon, 14 Jun 2021 09:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210602122555.10082-1-laoar.shao@gmail.com> <CAKfTPtCS6bVGK1EFUHygj+uZL5N2kEzyyEeoyT4Cuc7r-65yVw@mail.gmail.com>
 <CALOAHbB7Re8ES86bC10vz7KuNjLV1fA7tuLUmJY==sR-fB-+qQ@mail.gmail.com> <CAKfTPtBd349eyDhA5ThCAHFd83cGMQKb_LDxD4QvyP-cJOBjqA@mail.gmail.com>
In-Reply-To: <CAKfTPtBd349eyDhA5ThCAHFd83cGMQKb_LDxD4QvyP-cJOBjqA@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 14 Jun 2021 23:59:56 +0800
Message-ID: <CALOAHbAfF7q8NyKpR+TCF14ZMhjHkrQG9W7wnA_j5Sog36OOiQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched: do active load balance on the new idle cpu
To:     Vincent Guittot <vincent.guittot@linaro.org>
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

On Mon, Jun 14, 2021 at 10:21 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Mon, 14 Jun 2021 at 12:23, Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > On Wed, Jun 2, 2021 at 8:37 PM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Wed, 2 Jun 2021 at 14:26, Yafang Shao <laoar.shao@gmail.com> wrote:
> > > >
> > > > We monitored our latency-sensitive RT tasks are randomly preempted by the
> > > > kthreads migration/n, which means to migrate tasks on CPUn to other new
> > > > idle CPU. The logical as follows,
> > > >
> > > >   new idle CPU                          CPU n
> > > >   (no task to run)                      (busy running)
> > > >   wakeup migration/n                    (busy running)
> > > >   (idle)                                migraion/n preempts current task
> > > >   run the migrated task                 (busy running)
> > >
> > > migration thread is only used when we want to migrate the currently
> > > running task of the source cpu.
> > > This doesn't seem to be your case as it's a RT thread that is
> > > currently running so the migration thread should not be woken up as we
> > > don't need it to migrate a runnable but not running cfs thread from
> > > coin to new idle CPU
> > >
> > > Do you have more details about the UC. Could it be a race between new
> > > idle load balance starting migration thread to pull the cfs running
> > > thread and the RT thread waking up and preempting cfs task before
> > > migration threads which then preempt your RT threads
> > >
> >
> > Hi Vincent,
> >
> > When I analyze it on my test server, I find the race really exists. For example,
> >
> > sensing_node-2511 [007] d... 945.351566: sched_switch:
> > prev_comm=sensing_node prev_pid=2511 prev_prio=98 prev_state=S ==>
> > next_comm=cat next_pid=2686 next_prio=120
> > cat-2686 [007] d... 945.351569: sched_switch: prev_comm=cat
> > prev_pid=2686 prev_prio=120 prev_state=R+ ==> next_comm=sensing_node
> > next_pid=2512 next_prio=98
> > sensing_node-2516 [004] dn.. 945.351571: sched_wakeup:
> > comm=migration/7 pid=47 prio=0 target_cpu=007
> > sensing_node-2512 [007] d... 945.351572: sched_switch:
> > prev_comm=sensing_node prev_pid=2512 prev_prio=98 prev_state=R ==>
> > next_comm=migration/7 next_pid=47 next_prio=0
> > sensing_node-2516 [004] d... 945.351572: sched_switch:
> > prev_comm=sensing_node prev_pid=2516 prev_prio=98 prev_state=S ==>
> > next_comm=sensing_node next_pid=2502 next_prio=98
> > migration/7-47 [007] d... 945.351580: sched_switch:
> > prev_comm=migration/7 prev_pid=47 prev_prio=0 prev_state=S ==>
> > next_comm=sensing_node next_pid=2512 next_prio=98
> > sensing_node-2502 [004] d... 945.351605: sched_switch:
> > prev_comm=sensing_node prev_pid=2502 prev_prio=98 prev_state=S ==>
> > next_comm=cat next_pid=2686 next_prio=120
> >
> > When CPU4 is waking migration/7, the CFS thread 'cat' is running on
> > CPU7, but then 'cat' is preempted by a RT task 'sensing_node', and
> > then the migration/7 preempts the RT task.
>
> ok the race happens between :
>     if (need_active_balance(&env)) {
> and
>         raw_spin_rq_lock_irqsave(busiest, flags);
>

Right.

> >
> > What about below patch to improve the race ? It can't avoid the race,
> > but it could reduce the race.
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 3248e24a90b0..0e8d31e17dc7 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9794,6 +9794,20 @@ static int load_balance(int this_cpu, struct rq *this_rq,
> >                                 goto out_one_pinned;
> >                         }
> >
> > +                       /*
> > +                        * There may be a race between new idle load
> > balance starting
>
> s/new idle load/load/
>
> In fact, the same can happen during all kind of  load balance
>
>
> > +                        * migration thread to pull the cfs running
> > thread and the RT
> > +                        * thread waking up and preempting cfs task
> > before migration
> > +                        * threads which then preempt the RT thread.
> > +                        * We'd better do the last minute check before starting
> > +                        * migration thread to avoid preempting
> > latency-sensitive RT thread.
> > +                        */
> > +                       if (dl_task(busiest->curr) || rt_task(busiest->curr)) {
>
> if(busiest->curr->sched_class != &fair_sched_class)
>

Sure

> Reviewing your proposal reminded me a similar discussion with Valentin:
> https://lore.kernel.org/lkml/CAKfTPtBygNcVewbb0GQOP5xxO96am3YeTZNP5dK9BxKHJJAL-g@mail.gmail.com/
>

Thanks for your information.
Seems that's a similar issue.

>
> > +                               raw_spin_unlock_irqrestore(&busiest->lock,
> > +                                                          flags);
> > +                               goto out_one_pinned;
>
>                                goto out;
> is enough because the the task is not pinned
>

Sure.

>
> > +                       }
> > +
> >                         /* Record that we found at least one task that
> > could run on this_cpu */
> >                         env.flags &= ~LBF_ALL_PINNED;
>
> Your test should be moved after clearing the LBF_ALL_PINNED flag
>

Sure.

I will update the patch.

>
> >
> > >
> > >
> > > >
> > > > As the new idle CPU is going to be idle, we'd better move the migration
> > > > work on it instead of burdening the busy CPU. After this change, the
> > > > logic is,
> > > >  new idle CPU                           CPU n
> > > >  (no task to run)                       (busy running)
> > > >  migrate task from CPU n                (busy running)
> > > >  run the migrated task                  (busy running)
> > > >
> > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > ---
> > > >  kernel/sched/fair.c | 17 +++++------------
> > > >  1 file changed, 5 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index 3248e24a90b0..3e8b98b982ff 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -9807,13 +9807,11 @@ static int load_balance(int this_cpu, struct rq *this_rq,
> > > >                                 busiest->push_cpu = this_cpu;
> > > >                                 active_balance = 1;
> > > >                         }
> > > > -                       raw_spin_unlock_irqrestore(&busiest->lock, flags);
> > > >
> > > > -                       if (active_balance) {
> > > > -                               stop_one_cpu_nowait(cpu_of(busiest),
> > > > -                                       active_load_balance_cpu_stop, busiest,
> > > > -                                       &busiest->active_balance_work);
> > > > -                       }
> > > > +                       if (active_balance)
> > > > +                               active_load_balance_cpu_stop(busiest);
> > >
> > > this doesn't make sense because we reach this point if we want to
> > > migrate the current running task of the busiest cpu and in order to do
> > > this we need the preempt this current running thread
> > >
> > > > +
> > > > +                       raw_spin_unlock_irqrestore(&busiest->lock, flags);
> > > >                 }
> > > >         } else {
> > > >                 sd->nr_balance_failed = 0;
> > > > @@ -9923,7 +9921,6 @@ static int active_load_balance_cpu_stop(void *data)
> > > >         struct task_struct *p = NULL;
> > > >         struct rq_flags rf;
> > > >
> > > > -       rq_lock_irq(busiest_rq, &rf);
> > > >         /*
> > > >          * Between queueing the stop-work and running it is a hole in which
> > > >          * CPUs can become inactive. We should not move tasks from or to
> > > > @@ -9933,8 +9930,7 @@ static int active_load_balance_cpu_stop(void *data)
> > > >                 goto out_unlock;
> > > >
> > > >         /* Make sure the requested CPU hasn't gone down in the meantime: */
> > > > -       if (unlikely(busiest_cpu != smp_processor_id() ||
> > > > -                    !busiest_rq->active_balance))
> > > > +       if (unlikely(!busiest_rq->active_balance))
> > > >                 goto out_unlock;
> > > >
> > > >         /* Is there any task to move? */
> > > > @@ -9981,13 +9977,10 @@ static int active_load_balance_cpu_stop(void *data)
> > > >         rcu_read_unlock();
> > > >  out_unlock:
> > > >         busiest_rq->active_balance = 0;
> > > > -       rq_unlock(busiest_rq, &rf);
> > > >
> > > >         if (p)
> > > >                 attach_one_task(target_rq, p);
> > > >
> > > > -       local_irq_enable();
> > > > -
> > > >         return 0;
> > > >  }
> > > >
> > > > --
> > > > 2.17.1
> > > >
> >
> >
> >
> > --
> > Thanks
> > Yafang



-- 
Thanks
Yafang

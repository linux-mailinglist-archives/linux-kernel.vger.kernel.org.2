Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD54398A27
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 15:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhFBNBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 09:01:43 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:37804 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhFBNBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 09:01:42 -0400
Received: by mail-io1-f48.google.com with SMTP id q7so2426505iob.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 05:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zFeiThzPHXf+49yLol3HZjW73x9uoj+Prq1CGsfJMog=;
        b=lQ3B3UGbL5dZhoucX26OxC2YZ/UrOhrOT2T/VCy9PjaXApBTMLF+ODHnBLrEhP+il9
         YJ/hy6EKd4lpEdyWR+p874jvE1PqLg8mjVQIModNcsneTRoDcUP01+9Vw1jO4nv4ZzFs
         w7+T3D56VUKqtvfRidQX+R1j37PxJk+GxmKWlik/F2mQAYZfDZcy99bZVIKQsAf+t+V6
         Pq5c76vanyxegLV0PoULi6zCVs/9a3ximjuOv0dm9vlqZaC7LseFuosN0BgqcCwL3Dw7
         P6CljZ/U/hs/wv6wXDDDBGcxraEzSyH9WhPA68mUx2l1jxi0T7oSz95eAl0ey4h1GNQU
         x8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zFeiThzPHXf+49yLol3HZjW73x9uoj+Prq1CGsfJMog=;
        b=NpWNBK0qliCudASDVJL20JdLDIbGwv0m9s/7RRhvbmAhDPKnedkZ1eKrbenBGCfrYk
         5NCYJ1Ykyp1+PJgXZEKQn3ynAnQo6U5MK0aYYeygf8ZVcqzzc/0lKEAwSXARZGgkESVs
         VUus3E7WlTQrhhOKM/qXpGQOOmCIru6ogMAdxXQ1UQmLLSqRZgFiZ3uQZEVpytRG1t3g
         B58uhjviLhBgdowQKAfKAh0sGfdW64x4Dbl5I5kj1buja0sLMIuoJYduICnx2Nd+N19g
         lSht4eUlfdO9LU0Ckya/Zupjgw1PnHRzj8g318VDGFqPEH1+UydF1CqL1JiFBhunh84H
         QN4g==
X-Gm-Message-State: AOAM531KXjI7KONP2O3325nhsC8EXMxSiNgNA9wni1YzOwRHCbd9r5XW
        NRj1TLQnUJerLtc/z287SaYA0mHXuhUaTppyozA=
X-Google-Smtp-Source: ABdhPJxuF3VxpxQg4eR6TTwVBpZTCr4UTgwtgX+OQ22wMKjlv/CWcIs6qjq9vSN8ZRZaI1YdiQJqLkrEx0Bk52vuP58=
X-Received: by 2002:a05:6638:34ac:: with SMTP id t44mr29164251jal.97.1622638722861;
 Wed, 02 Jun 2021 05:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210602122555.10082-1-laoar.shao@gmail.com> <CAKfTPtCS6bVGK1EFUHygj+uZL5N2kEzyyEeoyT4Cuc7r-65yVw@mail.gmail.com>
In-Reply-To: <CAKfTPtCS6bVGK1EFUHygj+uZL5N2kEzyyEeoyT4Cuc7r-65yVw@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 2 Jun 2021 20:58:07 +0800
Message-ID: <CALOAHbA=bSVsmJMG_q5vkkk9U+CeoULgdSEgf95RxfzPh9TC2A@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched: do active load balance on the new idle cpu
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.co>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 2, 2021 at 8:37 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Wed, 2 Jun 2021 at 14:26, Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > We monitored our latency-sensitive RT tasks are randomly preempted by the
> > kthreads migration/n, which means to migrate tasks on CPUn to other new
> > idle CPU. The logical as follows,
> >
> >   new idle CPU                          CPU n
> >   (no task to run)                      (busy running)
> >   wakeup migration/n                    (busy running)
> >   (idle)                                migraion/n preempts current task
> >   run the migrated task                 (busy running)
>
> migration thread is only used when we want to migrate the currently
> running task of the source cpu.

Could you pls explain it in detail ?
But I find the migration/n will pick a task from src_rq->cfs_tasks
rather than the current running task, see also detach_one_task():

detach_one_task
    list_for_each_entry_reverse(p, &env->src_rq->cfs_tasks, se.group_node) {
        detach_task(p, env);
   }


> This doesn't seem to be your case as it's a RT thread that is
> currently running so the migration thread should not be woken up as we
> don't need it to migrate a runnable but not running cfs thread from
> coin to new idle CPU
>
> Do you have more details about the UC. Could it be a race between new
> idle load balance starting migration thread to pull the cfs running
> thread and the RT thread waking up and preempting cfs task before
> migration threads which then preempt your RT threads
>
>

No, it is not a race. Below is the detail from sched:sched_swith tracepoint:

sensing_node-8880 [007] d... 4300.544185: sched_switch:
prev_comm=sensing_node prev_pid=8880 prev_prio=98 prev_state=S ==>
next_comm=sensing_node next_pid=8897 next_prio=98
sensing_node-8897 [007] d... 4300.544214: sched_switch:
prev_comm=sensing_node prev_pid=8897 prev_prio=98 prev_state=S ==>
next_comm=sensing_node next_pid=8880 next_prio=98
sensing_node-8880 [007] d... 4300.544506: sched_switch:
prev_comm=sensing_node prev_pid=8880 prev_prio=98 prev_state=R ==>
next_comm=migration/7 next_pid=47 next_prio=0
migration/7-47 [007] d... 4300.544509: sched_switch:
prev_comm=migration/7 prev_pid=47 prev_prio=0 prev_state=S ==>
next_comm=sensing_node next_pid=8880 next_prio=98

sensing_node is a RR task and it was preempted by migration/7.

>
> >
> > As the new idle CPU is going to be idle, we'd better move the migration
> > work on it instead of burdening the busy CPU. After this change, the
> > logic is,
> >  new idle CPU                           CPU n
> >  (no task to run)                       (busy running)
> >  migrate task from CPU n                (busy running)
> >  run the migrated task                  (busy running)
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  kernel/sched/fair.c | 17 +++++------------
> >  1 file changed, 5 insertions(+), 12 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 3248e24a90b0..3e8b98b982ff 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9807,13 +9807,11 @@ static int load_balance(int this_cpu, struct rq *this_rq,
> >                                 busiest->push_cpu = this_cpu;
> >                                 active_balance = 1;
> >                         }
> > -                       raw_spin_unlock_irqrestore(&busiest->lock, flags);
> >
> > -                       if (active_balance) {
> > -                               stop_one_cpu_nowait(cpu_of(busiest),
> > -                                       active_load_balance_cpu_stop, busiest,
> > -                                       &busiest->active_balance_work);
> > -                       }
> > +                       if (active_balance)
> > +                               active_load_balance_cpu_stop(busiest);
>
> this doesn't make sense because we reach this point if we want to
> migrate the current running task of the busiest cpu and in order to do
> this we need the preempt this current running thread
>
> > +
> > +                       raw_spin_unlock_irqrestore(&busiest->lock, flags);
> >                 }
> >         } else {
> >                 sd->nr_balance_failed = 0;
> > @@ -9923,7 +9921,6 @@ static int active_load_balance_cpu_stop(void *data)
> >         struct task_struct *p = NULL;
> >         struct rq_flags rf;
> >
> > -       rq_lock_irq(busiest_rq, &rf);
> >         /*
> >          * Between queueing the stop-work and running it is a hole in which
> >          * CPUs can become inactive. We should not move tasks from or to
> > @@ -9933,8 +9930,7 @@ static int active_load_balance_cpu_stop(void *data)
> >                 goto out_unlock;
> >
> >         /* Make sure the requested CPU hasn't gone down in the meantime: */
> > -       if (unlikely(busiest_cpu != smp_processor_id() ||
> > -                    !busiest_rq->active_balance))
> > +       if (unlikely(!busiest_rq->active_balance))
> >                 goto out_unlock;
> >
> >         /* Is there any task to move? */
> > @@ -9981,13 +9977,10 @@ static int active_load_balance_cpu_stop(void *data)
> >         rcu_read_unlock();
> >  out_unlock:
> >         busiest_rq->active_balance = 0;
> > -       rq_unlock(busiest_rq, &rf);
> >
> >         if (p)
> >                 attach_one_task(target_rq, p);
> >
> > -       local_irq_enable();
> > -
> >         return 0;
> >  }
> >
> > --
> > 2.17.1
> >



-- 
Thanks
Yafang

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9D9398A6B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 15:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhFBN31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 09:29:27 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:45949 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhFBN3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 09:29:22 -0400
Received: by mail-lj1-f176.google.com with SMTP id m3so2540100lji.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 06:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6QUQTM0AkdKdsRfJ9OiMiSDtt7D+DtGJYlIDoQLZ5eE=;
        b=FITduHZYBwuAhxMvOsGB8UcGnqNFIROBY5AKYJA+8U6uoM47yhl4cvux/wb0Vdv3GX
         ltt4xTzrRaDis6EaMb6zIoZipT0b4+1q+VzIgqj3jckULzfF7zwjH43TDAwtk4+47F9S
         kr4TF2VPqyQw4i8J/fAZOn7xSZ8HiRVZgUj2U7QEmRlNHOvZKq52weiJ0fDssn1znsOy
         kGSZmMDgIg3O4f2wByLuPIXbCD0GTd6JiSoY9NLfhJcaP16wo9CdYZI+24ym70JVGwTb
         Gw6kT7VQu8b37DJlLbb1lJafCevO3EjFHVopVMxy6d1/qSe05kb2/YOx91jvVr7xDvHZ
         zd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6QUQTM0AkdKdsRfJ9OiMiSDtt7D+DtGJYlIDoQLZ5eE=;
        b=U0mzasqNzbmdQQdIUvipij8DXUNOYwtBsAeUGfMebBc2Nwz986VwkkdA6El4kISwWk
         aD3750hD3xrmAoL/hOsekJrcaRgzlJvspt2EjqPCnQAkrQRS9rr5RutSFIZaTVIjWJYy
         u+EqyQ5yrPgEvlg7Mq+IwB3Y9EKv525lJqb8pcFilA1wgY4wwNtWb2sAuGM21K06BNjv
         lIRRj9vS3UhFQmlSd3ZPNWQuHnoYj7tHHq3YYs1NQXHOFbUUzOn1DlVIii5kpcV05Rfm
         87SALPRH5AVSU+yfCmtSKmOoSHB1Cpg3idsoYBjci1pGUmgo5mTsLqNqIBD6v9qLqlqA
         W11A==
X-Gm-Message-State: AOAM530FA2P6yq7YZeDLx5w3IeKY42Tp3P7v4AFC7wKG++FpLz6Saf6y
        rbBxGs7nIw2o2srYk+zq9Y17wjyoISGRlmw7XB/hvw==
X-Google-Smtp-Source: ABdhPJzQnwVv5EqjF7hZhROp75GkQ6sl8lugxpN91owLXiluLcCfiYOfnieOF84j6DKSrJYH7XDKO2e+haznsR/3J/E=
X-Received: by 2002:a2e:b4a8:: with SMTP id q8mr13344132ljm.401.1622640397941;
 Wed, 02 Jun 2021 06:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210602122555.10082-1-laoar.shao@gmail.com> <CAKfTPtCS6bVGK1EFUHygj+uZL5N2kEzyyEeoyT4Cuc7r-65yVw@mail.gmail.com>
 <CALOAHbA=bSVsmJMG_q5vkkk9U+CeoULgdSEgf95RxfzPh9TC2A@mail.gmail.com>
In-Reply-To: <CALOAHbA=bSVsmJMG_q5vkkk9U+CeoULgdSEgf95RxfzPh9TC2A@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 2 Jun 2021 15:26:26 +0200
Message-ID: <CAKfTPtDAW_Ttg_hM+GoH87nriATck4yHKE-y7HZbFd9ujLp3YQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched: do active load balance on the new idle cpu
To:     Yafang Shao <laoar.shao@gmail.com>
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

On Wed, 2 Jun 2021 at 14:58, Yafang Shao <laoar.shao@gmail.com> wrote:
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
>
> Could you pls explain it in detail ?

CPU A
become idle
call newidle_balance()
  ...
  load_balance()
    ... CPU B is the busiest cpu
    env.src_cpu = CPU B;

    if (busiest->nr_running > 1) {
      ...
      There is more than 1 runnable threads on CPU B
      Try to migrate cfs runnable but not running tasks from CPU B to CPU A
      in your case, the migration of cfs task should happen here
because the RT task is running

      Handle case of pinned tasks


    if (!ld_moved)
      no runnable but not running task was moved so we might want to
migrate the current running task

      need_active_balance() should not return true in your case
because tasks should have been migrated during the step above

      wake up stop/migration thread to preempt the current running
thread so we can migrate it


so you have has a UC which doesn't migrate task in the 1st step when
trying to pull runnable and not running tasks but it makes
need_active_balance() return true. Woudl be good to know which
condition makes  need_active_balance() to return true


> But I find the migration/n will pick a task from src_rq->cfs_tasks
> rather than the current running task, see also detach_one_task():

The current running task is migration/n one at that time

>
> detach_one_task
>     list_for_each_entry_reverse(p, &env->src_rq->cfs_tasks, se.group_node) {
>         detach_task(p, env);
>    }
>
>
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
> >
>
> No, it is not a race. Below is the detail from sched:sched_swith tracepoint:
>
> sensing_node-8880 [007] d... 4300.544185: sched_switch:
> prev_comm=sensing_node prev_pid=8880 prev_prio=98 prev_state=S ==>
> next_comm=sensing_node next_pid=8897 next_prio=98
> sensing_node-8897 [007] d... 4300.544214: sched_switch:
> prev_comm=sensing_node prev_pid=8897 prev_prio=98 prev_state=S ==>
> next_comm=sensing_node next_pid=8880 next_prio=98
> sensing_node-8880 [007] d... 4300.544506: sched_switch:
> prev_comm=sensing_node prev_pid=8880 prev_prio=98 prev_state=R ==>
> next_comm=migration/7 next_pid=47 next_prio=0
> migration/7-47 [007] d... 4300.544509: sched_switch:
> prev_comm=migration/7 prev_pid=47 prev_prio=0 prev_state=S ==>
> next_comm=sensing_node next_pid=8880 next_prio=98
>
> sensing_node is a RR task and it was preempted by migration/7.
>
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

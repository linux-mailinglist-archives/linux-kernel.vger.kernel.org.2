Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00721399784
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 03:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhFCBb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 21:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhFCBb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 21:31:58 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A08EC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 18:30:05 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id 5so4642655ioe.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 18:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1EPsUK3ZQl7+7uFNMBcrFht4n1vdJ7J24h+88KiwMpc=;
        b=KvuAjAnHVVVRfdZwaDotfcinb83HIkWpWCsSC7O8ghX/HKcwyr0UXcmASSiSQBk/Vg
         oeCwg1ugPS+CvdMdjYU4l/bRYp1BkktHAFO4fMI6ouiYNRxTLnkxeQo0NiL1auj/Y600
         Ao6bH12q5NCUvhBoAEVTzIXrTBfNgY5ldnWl3sxa8xQWS4kv5xF0NfklLhpa0uZwYBS4
         SZQwJ+Jh8auS1WP5QDXydiFKUTmq5AahoKnff7rZ0SEA925/43wNbjh/vFjV5EbPTElw
         WFGjD1dJlO6WaPNuOMkSBR3GA2pqbCZNzi6ezhwSNueTatzHU/o69wxILx9eeB7b3skd
         SiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1EPsUK3ZQl7+7uFNMBcrFht4n1vdJ7J24h+88KiwMpc=;
        b=a1BobB4uT1/5KO+4Ruj48L/aJE+igxUOXV55o4Qx4/cn3vS8M72gEOCpFmWpBaUIfN
         6V+RS5tm1BYNW7IDJpU1PTkBFIhuaoaMfDriQWvnFQdyGapAT+XLvVQDivu83cWEK5WJ
         d8JjDQ4k7C4vpp6uhinA7guBn/Db7vDCizZ4TZeL2sZipjQjQq3cVYHrkMrvRNd+n0dw
         aUa+R2GF2j89m8PSyDUt5R9YezQYHSh+SLr0ltbReC1FAcOqA2lv0x9N1RLooSOsCOpQ
         m15SDiYZhgN0p9GhHKYCPoRm1CbE8L0hXzsRHnC61rKvq+TXamhqBE6gJHKVWmWphp6E
         wUzg==
X-Gm-Message-State: AOAM532eaCF2kYjPpVrZuQ2RyZ0+uKHFfwlg01lNSvvhTzH1VABS8n0n
        9J4KvxHQrTKnPWQW8lXX8BdQdB8gmxIfdS/K7Do=
X-Google-Smtp-Source: ABdhPJyPN8ijrJIbeAIUbnecL1Bof/mESSLz02vwmgD/9X5xR3EoAgO02mQHs/h0SaRAlM5yfugUvOXcVlWv5cCiV5U=
X-Received: by 2002:a05:6602:2bef:: with SMTP id d15mr27361468ioy.13.1622683804926;
 Wed, 02 Jun 2021 18:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210602122555.10082-1-laoar.shao@gmail.com> <CAKfTPtCS6bVGK1EFUHygj+uZL5N2kEzyyEeoyT4Cuc7r-65yVw@mail.gmail.com>
 <CALOAHbA=bSVsmJMG_q5vkkk9U+CeoULgdSEgf95RxfzPh9TC2A@mail.gmail.com> <CAKfTPtDAW_Ttg_hM+GoH87nriATck4yHKE-y7HZbFd9ujLp3YQ@mail.gmail.com>
In-Reply-To: <CAKfTPtDAW_Ttg_hM+GoH87nriATck4yHKE-y7HZbFd9ujLp3YQ@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 3 Jun 2021 09:29:28 +0800
Message-ID: <CALOAHbDbROJyEi=haWT5S0Veae1EOV=4mEX7SkvZyudfFaxaGQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched: do active load balance on the new idle cpu
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 2, 2021 at 9:26 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Wed, 2 Jun 2021 at 14:58, Yafang Shao <laoar.shao@gmail.com> wrote:
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
> >
> > Could you pls explain it in detail ?
>
> CPU A
> become idle
> call newidle_balance()
>   ...
>   load_balance()
>     ... CPU B is the busiest cpu
>     env.src_cpu = CPU B;
>
>     if (busiest->nr_running > 1) {
>       ...
>       There is more than 1 runnable threads on CPU B
>       Try to migrate cfs runnable but not running tasks from CPU B to CPU A
>       in your case, the migration of cfs task should happen here
> because the RT task is running
>
>       Handle case of pinned tasks
>
>
>     if (!ld_moved)
>       no runnable but not running task was moved so we might want to
> migrate the current running task
>
>       need_active_balance() should not return true in your case
> because tasks should have been migrated during the step above
>
>       wake up stop/migration thread to preempt the current running
> thread so we can migrate it
>

Thanks for the explanation.

>
> so you have has a UC which doesn't migrate task in the 1st step when
> trying to pull runnable and not running tasks but it makes
> need_active_balance() return true. Woudl be good to know which
> condition makes  need_active_balance() to return true
>

I will analyze why need_active_balance() returns true.

>
> > But I find the migration/n will pick a task from src_rq->cfs_tasks
> > rather than the current running task, see also detach_one_task():
>
> The current running task is migration/n one at that time
>
> >
> > detach_one_task
> >     list_for_each_entry_reverse(p, &env->src_rq->cfs_tasks, se.group_node) {
> >         detach_task(p, env);
> >    }
> >
> >
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
> > >
> >
> > No, it is not a race. Below is the detail from sched:sched_swith tracepoint:
> >
> > sensing_node-8880 [007] d... 4300.544185: sched_switch:
> > prev_comm=sensing_node prev_pid=8880 prev_prio=98 prev_state=S ==>
> > next_comm=sensing_node next_pid=8897 next_prio=98
> > sensing_node-8897 [007] d... 4300.544214: sched_switch:
> > prev_comm=sensing_node prev_pid=8897 prev_prio=98 prev_state=S ==>
> > next_comm=sensing_node next_pid=8880 next_prio=98
> > sensing_node-8880 [007] d... 4300.544506: sched_switch:
> > prev_comm=sensing_node prev_pid=8880 prev_prio=98 prev_state=R ==>
> > next_comm=migration/7 next_pid=47 next_prio=0
> > migration/7-47 [007] d... 4300.544509: sched_switch:
> > prev_comm=migration/7 prev_pid=47 prev_prio=0 prev_state=S ==>
> > next_comm=sensing_node next_pid=8880 next_prio=98
> >
> > sensing_node is a RR task and it was preempted by migration/7.
> >
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

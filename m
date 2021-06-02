Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F183989C6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 14:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhFBMkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 08:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFBMkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 08:40:19 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14E9C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 05:38:20 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id r5so3151053lfr.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 05:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wFJrqld8s0VdsGWfeRhf3Tb1B05qSSiFGKiTgxiAca8=;
        b=MAFje+goaWx0HJ07mZo0CKBErLR9VUcOVwifVrjlCwHPds9SsXHdiClRqTAdgv1XLb
         IDZo/h26oYz6zzpDmgBMeDFfs+V0EVhIEU3CsNMZ1lgrVbzVoe9g70eRdITED8HJYpT+
         eYmqklVK7qNwgd3q9/NQEByQI32uBeaNRmPDSb1p59iOs1NEsBSOlRPe+okqHAV1BX2c
         GQTwwjGm1lfATjo/AMg0HWrDCgquuvBtX38vB5cHfOX4kH/2AmiOCw0Z6A4h/Rbjtm2b
         kRmS8zV63CUgHyDaXt0EwDuWX3RzbBvxt1Q30RxALxub+SG9k+Q2C4N+7G/5gFaT/dNa
         lFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wFJrqld8s0VdsGWfeRhf3Tb1B05qSSiFGKiTgxiAca8=;
        b=tutTTWeZ3iXwpn5IvjSFMVfCkTT7A+XfxlPlC+CS9mZVX/LxiqZFISOTlyGq3HlVUo
         jh9U1NFn1nT7S1WLhUi7O53A8fLGCnY3HKEW0G4tqvi3iFFFFWgf9hvNlRpCh68QjbU/
         yRlttESbunr2Ou3qp6qgT6MZhR8ZM6mPn4sVONlW6g5BwLK1MfCFKJizrskB+s/z8Zhf
         MkugxVrUHFvo4xbbJB2eZ1DYxiBJ2UUW5F4SRPEHIsiIOvnxYT8AKsZWyD8wQSpHJFGI
         3tmWNni960SJMdH5qlfOLH2aZa3qdM4F9B4l6PmcDeAwA9zQjrKpJppE3Xu9sJB5Ou9I
         UG2w==
X-Gm-Message-State: AOAM532dN38wAl3q+k+C6VR4DHizwdXTLrNm9tWl5hIYzTkBFYHuPwpq
        6L8x5KvK5M65JD/vPI29YOiJNQ3CvZFfiligiT94dg==
X-Google-Smtp-Source: ABdhPJzYgAkLCtfkmfH0uK2T0HD9i/l8x+sZnR8qP1wEsz4lv2CwtGR1340lJXEMr1tfextaF8d3L+LeCQ0V3Rnfi2Q=
X-Received: by 2002:a05:6512:234d:: with SMTP id p13mr22942919lfu.470.1622637498902;
 Wed, 02 Jun 2021 05:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210602122555.10082-1-laoar.shao@gmail.com> <CAKfTPtCS6bVGK1EFUHygj+uZL5N2kEzyyEeoyT4Cuc7r-65yVw@mail.gmail.com>
In-Reply-To: <CAKfTPtCS6bVGK1EFUHygj+uZL5N2kEzyyEeoyT4Cuc7r-65yVw@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 2 Jun 2021 14:38:07 +0200
Message-ID: <CAKfTPtB3YuAM44HA62BAYgsM5UqthqHb_w0XcHYHhT8ghukUaA@mail.gmail.com>
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

On Wed, 2 Jun 2021 at 14:37, Vincent Guittot <vincent.guittot@linaro.org> wrote:
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
> This doesn't seem to be your case as it's a RT thread that is
> currently running so the migration thread should not be woken up as we
> don't need it to migrate a runnable but not running cfs thread from
> coin to new idle CPU

s/coin/CPU n/
>
> Do you have more details about the UC. Could it be a race between new
> idle load balance starting migration thread to pull the cfs running
> thread and the RT thread waking up and preempting cfs task before
> migration threads which then preempt your RT threads
>
>
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

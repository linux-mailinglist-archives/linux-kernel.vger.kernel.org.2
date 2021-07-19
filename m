Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB583CD476
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 14:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236907AbhGSLbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 07:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236896AbhGSLbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 07:31:47 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8D2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 04:27:25 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id b14so15729180ilf.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 05:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ILUF7qjRxTiocP1Zp+X8u/f+lmCGdZuIc0GgBU021os=;
        b=YQi681anoX0pIB4Jii3ZDrwQMz2PA9iYkCP0VerlJqUM9AFuH9CM3qLuLXVLu1n22r
         nKECvsAkuo4B/IGXUYrrD1BMQToItpOldCUA/t9wUr69frZ6peTVrDKMjy0oT/4RiN0x
         P/4Nn60BNX8zd0mLiA3UYyG5YQX8kSRgffRPcBIyWWAoyexO+pUNCTbgUua09D1nfLmk
         2i9RrdDcYaO13Znk9LYBOgjc6DU/a8TIo6qVed8OYzzZp1q5VySzMHZQsAXHZ0YB4C0P
         lHgr/IZXNIAFV6Qiv+hMVXxA50H31zaohpS8lP6ZCII2JcpAxEPOV0SWMwfWmjcTvEzI
         FWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ILUF7qjRxTiocP1Zp+X8u/f+lmCGdZuIc0GgBU021os=;
        b=c+Zy4Fx8/+NfDBN/6yXN3ljsXJBSZxy3DsQGvS5+wtQxws+08EbAGy5H/XOGq4hL0M
         dBwMz5N+RXOcglvBy0hJ8DgMVZNgQ7UUFXL3SFmV2Bj9sMMKQ6hNSMWoQhPMgFG/WLF4
         DJjuqHRibGdRqu06bswyIOWVzlIUUxh13RSyddvVGMzCd9K8yPfEfx29N/Zgozyf0ELp
         Bsa+RyxtO/PDV5w/PNjQddPmFq+LwltAB0TcEo7ml6+GDkCGatsUr1/oN9bXHM4A0bv5
         2XQcTE8a0nE4yMwl5jL9xd9BuyO0LevQLbKxONlEimM5hV4qy9asRLWbzEZ50JATTVBA
         xUhg==
X-Gm-Message-State: AOAM532sSENkPJ/toejYGdln1pXXp0qQz01XxQsjIJykX6vkRylxmRbr
        Y+wjOCwCvkhBvyOrgTAIUX6F9i4YnS3BhP3//G4=
X-Google-Smtp-Source: ABdhPJxQDiUupSHCfHAq9gN5Nlhipomd917y/uOQycCZMABwOzToCTbtI+ydFttSH8eN0CVrqTqkoO/G7zf8lpbdWaI=
X-Received: by 2002:a92:b003:: with SMTP id x3mr16933404ilh.93.1626696746821;
 Mon, 19 Jul 2021 05:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <CALOAHbAS26LP2p9Fe7m6xynZmazYENmx_HfTV4LebwPWr7XLmA@mail.gmail.com>
 <dfbe1030-05bf-3371-bc0a-56f79dcd6f39@arm.com>
In-Reply-To: <dfbe1030-05bf-3371-bc0a-56f79dcd6f39@arm.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 19 Jul 2021 20:11:50 +0800
Message-ID: <CALOAHbBLTwjnYyqdSkAqzT=X9v-NSygM0rfK_Bk5JMwZ6vB_fQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] sched: do active load balance in balance callback
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 10:23 PM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 11/07/2021 09:40, Yafang Shao wrote:
> > The active load balance which means to migrate the CFS task running on
> > the busiest CPU to the new idle CPU has a known issue[1][2] that
> > there are some race window between waking up the migration thread on the
> > busiest CPU and it begins to preempt the current running CFS task.
> > These race window may cause unexpected behavior that the latency
> > sensitive RT tasks may be preempted by the migration thread as it has a
> > higher priority.
> >
> > This RFC patch tries to improve this situation. Instead of waking up the
> > migration thread to do this work, this patch do it in the balance
> > callback as follows,
> >
> >      The New idle CPUm                The target CPUn
> >      find the target task A           CFS task A is running
> >      queue it into the target CPUn    A is scheduling out
> >                                       do balance callback and migrate A to CPUm
> > It avoids two context switches - task A to migration/n and migration/n to
> > task B. And it avoids preempting the RT task if the RT task has already
> > preempted task A before we do the queueing.
> >
> > TODO:
> > - I haven't done some benchmark to measure the impact on performance
> > - To avoid deadlock I have to unlock the busiest_rq->lock before
> >   calling attach_one_task() and lock it again after executing
> >   attach_one_task(). That may re-introduce the issue addressed by
> >   commit 565790d28b1e ("sched: Fix balance_callback()")
> >
> > [1]. https://lore.kernel.org/lkml/CAKfTPtBygNcVewbb0GQOP5xxO96am3YeTZNP5dK9BxKHJJAL-g@mail.gmail.com/
> > [2]. https://lore.kernel.org/lkml/20210615121551.31138-1-laoar.shao@gmail.com/
>
> This didn't apply for me and I guess won't compile on tip/sched/core:
>
> raw_spin_{,un}lock(&busiest_rq->lock) -> raw_spin_rq_{,un}lock(busiest_rq)
>
> p->state == TASK_RUNNING -> p->__state or task_is_running(p)
>

I made this patch based on Linus's tree. I will do it based on tip/sched/core.

> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  kernel/sched/core.c  |  1 +
> >  kernel/sched/fair.c  | 69 ++++++++++++++------------------------------
> >  kernel/sched/sched.h |  6 +++-
> >  3 files changed, 28 insertions(+), 48 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 4ca80df205ce..a0a90a37e746 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -8208,6 +8208,7 @@ void __init sched_init(void)
> >                 rq->cpu_capacity = rq->cpu_capacity_orig = SCHED_CAPACITY_SCALE;
> >                 rq->balance_callback = &balance_push_callback;
> >                 rq->active_balance = 0;
> > +               rq->active_balance_target = NULL;
> >                 rq->next_balance = jiffies;
> >                 rq->push_cpu = 0;
> >                 rq->cpu = i;
>
> [...]
>
> > +DEFINE_PER_CPU(struct callback_head, active_balance_head);
> > +
> >  /*
> >   * Check this_cpu to ensure it is balanced within domain. Attempt to move
> >   * tasks if there is an imbalance.
> > @@ -9845,15 +9817,14 @@ static int load_balance(int this_cpu, struct
> > rq *this_rq,
> >                         if (!busiest->active_balance) {
> >                                 busiest->active_balance = 1;
> >                                 busiest->push_cpu = this_cpu;
> > +                               busiest->active_balance_target = busiest->curr;
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
> > +                               queue_balance_callback(busiest,
> > &per_cpu(active_balance_head, busiest->cpu),
> > active_load_balance_cpu_stop);
>
>
> When you defer the active load balance of p into a balance_callback
> (from __schedule()) p has to stop running on busiest, right?

Right. But p doesn't have to stop running it immediately.

> Deferring active load balance for too long might be defeat the purpose
> of load balance which has to happen now.
>

Maybe we need to do some benchmark to measure whether it is proper to
deter the active load balance.
But I don't know which benchmark is suitable now.

> Also, before balance_callback get invoked,  active balancing might try
> to migrate p again and again but fails because `busiest->active_balance`
> is still 1 (you kept this former synchronization meant for
> active_balance_work). In this case the likelihood increases that one of
> the error condition in active_load_balance_cpu_stop() hit when it's
> finally called.
>

Seems that is a problem. I will think about it.

> What's wrong with the FIFO-1 "stopper" for CFS active lb?
>

We have to introduce another per-cpu kernel thread, but I don't know
whether it is worth doing it.


-- 
Thanks
Yafang

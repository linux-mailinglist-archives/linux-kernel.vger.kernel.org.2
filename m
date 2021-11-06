Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DFD446CE4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 08:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbhKFHn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 03:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbhKFHnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 03:43:25 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B83C061570
        for <linux-kernel@vger.kernel.org>; Sat,  6 Nov 2021 00:40:38 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id j9so8717818qvm.10
        for <linux-kernel@vger.kernel.org>; Sat, 06 Nov 2021 00:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gpXp4kcVbJyf9B0NzNFTWJNT34LWorz5kHIEnrZKzeA=;
        b=iQSpDvnw/OWfD7STO9XYHPhRU++GGvGte4Xlt6LgZ/FH3QLrCNm5ByvSZPa4s3dwcS
         kL6roMKUU0zCNOrIoSPgXUndjpiW9lBBwekW22ffGByf5aqNRomiJf+2ha4+RZ9Xo9dW
         z9SsLxPtRKiW2NYbDQkkDQeB9aF56oplj4vSGpbOa/lk7my9SkUVI8eNliDRfn75+1/F
         Hp18vL89AI5dfJLW+uUgF93ojaOjCkNHbTFOaVVF44frgYZMBdOBHIWsoo45Pzv+62ri
         ZsKfF1tT2mnzf2sbuaVoYXLgfsNhoYsA1NrWScacgS58mY7mNXBkor1eT1dXPtLhFioj
         sXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gpXp4kcVbJyf9B0NzNFTWJNT34LWorz5kHIEnrZKzeA=;
        b=2xurALhJi68MCSrDHYp5DJT7R+YmelCHDD4DuiwmrTQSZ92RPAcg4Fp5VlWX24Qe0z
         hF1xxQwYpkE64hj25Sek6KreIgiyYGv103a9nsyNGy4mXN81nCviq59CcfqqmyNMXTfM
         Ani3q4nB8M45uOQE3dhHseBBOVxKKw+xRNz+pxTUDnMIczCPB2Ovb0fbF+sJAqBI2zPR
         5Ia9ie+EyDXIsNQNQP/54dh6TnH8nrukVLvIUfG/reullcwHnhprIePPSxhHTFvQfPtu
         a2YRB9MaeoSuURZs/Ecna9CUv9niadd4Vkae0CTW0pc9oR6Q+holsLIDyN4HTcymWYuU
         h8zQ==
X-Gm-Message-State: AOAM530xxK2hnj06ZN9EDY5G4gieZpGznXB95fDw1l5WDsRgqMzMzopl
        gYlixA5UbizGw3BPopiiwSfU2PM9mlk7xzC97pX4gD0xRgBf+g==
X-Google-Smtp-Source: ABdhPJwMxXaGs3MjcA99EdOaDR8KotEan+83oDrSqvi3D2X0BYBSqrNb36pUNMjxLMlfPaNZPQ5czpRiuefCV6jhfhY=
X-Received: by 2002:ad4:5f88:: with SMTP id jp8mr58934438qvb.57.1636184437790;
 Sat, 06 Nov 2021 00:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211104145713.4419-1-laoar.shao@gmail.com> <20211104145713.4419-3-laoar.shao@gmail.com>
 <87a6iitu3r.mognet@arm.com>
In-Reply-To: <87a6iitu3r.mognet@arm.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 6 Nov 2021 15:40:02 +0800
Message-ID: <CALOAHbAHQ0UBn2GqRNWQwH32UPOuFo0b550oi6WCKr8+wFgdsw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] sched/fair: Introduce cfs_migration
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 6, 2021 at 1:01 AM Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 04/11/21 14:57, Yafang Shao wrote:
> > A new per-cpu kthread named "cfs_migration/N" is introduced to do
> > cfs specific balance works. It is a FIFO task with priority FIFO-1,
> > which means it can preempt any cfs tasks but can't preempt other FIFO
> > tasks. The kthreads as follows,
> >
> >     PID     COMMAND
> >     13      [cfs_migration/0]
> >     20      [cfs_migration/1]
> >     25      [cfs_migration/2]
> >     32      [cfs_migration/3]
> >     38      [cfs_migration/4]
> >     ...
> >
> >     $ cat /proc/13/sched
> >     ...
> >     policy                                       :                    1
> >     prio                                         :                   98
> >     ...
> >
> >     $ cat /proc/13/status
> >     ...
> >     Cpus_allowed:     0001
> >     Cpus_allowed_list:        0
> >     ...
> >
> > All the works need to be done will be queued into a singly linked list,
> > in which the first queued will be first serviced.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Valentin Schneider <valentin.schneider@arm.com>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > ---
> >  kernel/sched/fair.c | 93 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 93 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 87db481e8a56..56b3fa91828b 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -20,6 +20,8 @@
> >   *  Adaptive scheduling granularity, math enhancements by Peter Zijlstra
> >   *  Copyright (C) 2007 Red Hat, Inc., Peter Zijlstra
> >   */
> > +#include <linux/smpboot.h>
> > +#include <linux/stop_machine.h>
> >  #include "sched.h"
> >
> >  /*
> > @@ -11915,3 +11917,94 @@ int sched_trace_rq_nr_running(struct rq *rq)
> >          return rq ? rq->nr_running : -1;
> >  }
> >  EXPORT_SYMBOL_GPL(sched_trace_rq_nr_running);
> > +
> > +#ifdef CONFIG_SMP
> > +struct cfs_migrater {
> > +     struct task_struct *thread;
> > +     struct list_head works;
> > +     raw_spinlock_t lock;
>
> Hm so the handler of that work queue will now be a SCHED_FIFO task (which
> can block) rather than a CPU stopper (which can't), but AFAICT the
> callsites that would enqueue an item can't block, so having this as a
> raw_spinlock_t should still make sense.
>
> > +};
> > +
> > +DEFINE_PER_CPU(struct cfs_migrater, cfs_migrater);
> > +
> > +static int cfs_migration_should_run(unsigned int cpu)
> > +{
> > +     struct cfs_migrater *migrater = &per_cpu(cfs_migrater, cpu);
> > +     unsigned long flags;
> > +     int run;
> > +
> > +     raw_spin_lock_irqsave(&migrater->lock, flags);
> > +     run = !list_empty(&migrater->works);
> > +     raw_spin_unlock_irqrestore(&migrater->lock, flags);
> > +
> > +     return run;
> > +}
> > +
> > +static void cfs_migration_setup(unsigned int cpu)
> > +{
> > +     /* cfs_migration should have a higher priority than normal tasks,
> > +      * but a lower priority than other FIFO tasks.
> > +      */
> > +     sched_set_fifo_low(current);
> > +}
> > +
> > +static void cfs_migrater_thread(unsigned int cpu)
> > +{
> > +     struct cfs_migrater *migrater = &per_cpu(cfs_migrater, cpu);
> > +     struct cpu_stop_work *work;
> > +
> > +repeat:
> > +     work = NULL;
> > +     raw_spin_lock_irq(&migrater->lock);
> > +     if (!list_empty(&migrater->works)) {
> > +             work = list_first_entry(&migrater->works,
> > +                                     struct cpu_stop_work, list);
> > +             list_del_init(&work->list);
> > +     }
> > +     raw_spin_unlock_irq(&migrater->lock);
> > +
> > +     if (work) {
> > +             struct cpu_stop_done *done = work->done;
> > +             cpu_stop_fn_t fn = work->fn;
> > +             void *arg = work->arg;
> > +             int ret;
> > +
> > +             preempt_count_inc();
> > +             ret = fn(arg);
> > +             if (done) {
> > +                     if (ret)
> > +                             done->ret = ret;
> > +                     cpu_stop_signal_done(done);
> > +             }
> > +             preempt_count_dec();
> > +             goto repeat;
> > +     }
> > +}
>
> You're pretty much copying the CPU stopper setup, but that seems overkill
> for the functionality we're after: migrate a CFS task from one CPU to
> another. This shouldn't need to be able to run any arbitrary callback
> function.
>
> Unfortunately you are tackling both CFS active balancing and NUMA balancing
> at the same time, and right now they're plumbed a bit differently which
> probably drove you to use something a bit for polymorphic. Ideally we
> should be making them use the same paths, but IMO it would be acceptable as
> a first step to just cater to CFS active balancing - folks that really care
> about their RT tasks can disable CONFIG_NUMA_BALANCING, but there is
> nothing to disable CFS active balancing.
>

Right. The code will be more simplified if we only care about CFS
active balancing in this patchset.
We have disabled the numa balancing through
/proc/sys/kernel/numa_balancing, so it is not a critical issue now.

>
> Now, I'm thinking the bare information we need is:
>
> - a task to migrate
> - a CPU to move it to
>
> And then you can do something like...
>
> trigger_migration(task_struct *p, unsigned int dst_cpu)
> {
>         work = { p, dst_cpu };
>         get_task_struct(p);
>         /* queue work + wake migrater + wait for completion */
> }
>
> cfs_migrater_thread()
> {
>         /* ... */
>         p = work->p;
>
>         if (task_rq(p) != this_rq())
>                 goto out;
>
>         /* migrate task to work->dst_cpu */
> out:
>         complete(<some completion struct>);
>         put_task_struct(p);
> }
>

Agreed.

>
> We should also probably add something to prevent the migration from
> happening after it is no longer relevant. Say if we have something like:
>
>   <queue work to migrate p from CPU0 to CPU1>
>   <FIFO-2 task runs for 42 seconds on CPU0>
>   <cfs_migration/0 now gets to run>
>
> p could have moved elsewhere while cfs_migration/0. I'm thinking source CPU
> could be a useful information, but that doesn't tell you if the task moved
> around in the meantime...
>
> WDYT?

Agreed.
It seems we'd better take the patch[1] I sent several weeks back.

[1]. https://lore.kernel.org/lkml/20210615121551.31138-1-laoar.shao@gmail.com/

-- 
Thanks
Yafang

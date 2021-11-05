Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E4C44677E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbhKERD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:03:59 -0400
Received: from foss.arm.com ([217.140.110.172]:33698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234177AbhKERD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:03:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB1292F;
        Fri,  5 Nov 2021 10:01:16 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B5793F7F5;
        Fri,  5 Nov 2021 10:01:15 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Yafang Shao <laoar.shao@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [RFC PATCH 2/4] sched/fair: Introduce cfs_migration
In-Reply-To: <20211104145713.4419-3-laoar.shao@gmail.com>
References: <20211104145713.4419-1-laoar.shao@gmail.com> <20211104145713.4419-3-laoar.shao@gmail.com>
Date:   Fri, 05 Nov 2021 17:01:12 +0000
Message-ID: <87a6iitu3r.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/21 14:57, Yafang Shao wrote:
> A new per-cpu kthread named "cfs_migration/N" is introduced to do
> cfs specific balance works. It is a FIFO task with priority FIFO-1,
> which means it can preempt any cfs tasks but can't preempt other FIFO
> tasks. The kthreads as follows,
>
>     PID     COMMAND
>     13      [cfs_migration/0]
>     20      [cfs_migration/1]
>     25      [cfs_migration/2]
>     32      [cfs_migration/3]
>     38      [cfs_migration/4]
>     ...
>
>     $ cat /proc/13/sched
>     ...
>     policy                                       :                    1
>     prio                                         :                   98
>     ...
>
>     $ cat /proc/13/status
>     ...
>     Cpus_allowed:	0001
>     Cpus_allowed_list:	0
>     ...
>
> All the works need to be done will be queued into a singly linked list,
> in which the first queued will be first serviced.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/fair.c | 93 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 87db481e8a56..56b3fa91828b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -20,6 +20,8 @@
>   *  Adaptive scheduling granularity, math enhancements by Peter Zijlstra
>   *  Copyright (C) 2007 Red Hat, Inc., Peter Zijlstra
>   */
> +#include <linux/smpboot.h>
> +#include <linux/stop_machine.h>
>  #include "sched.h"
>
>  /*
> @@ -11915,3 +11917,94 @@ int sched_trace_rq_nr_running(struct rq *rq)
>          return rq ? rq->nr_running : -1;
>  }
>  EXPORT_SYMBOL_GPL(sched_trace_rq_nr_running);
> +
> +#ifdef CONFIG_SMP
> +struct cfs_migrater {
> +	struct task_struct *thread;
> +	struct list_head works;
> +	raw_spinlock_t lock;

Hm so the handler of that work queue will now be a SCHED_FIFO task (which
can block) rather than a CPU stopper (which can't), but AFAICT the
callsites that would enqueue an item can't block, so having this as a
raw_spinlock_t should still make sense.

> +};
> +
> +DEFINE_PER_CPU(struct cfs_migrater, cfs_migrater);
> +
> +static int cfs_migration_should_run(unsigned int cpu)
> +{
> +	struct cfs_migrater *migrater = &per_cpu(cfs_migrater, cpu);
> +	unsigned long flags;
> +	int run;
> +
> +	raw_spin_lock_irqsave(&migrater->lock, flags);
> +	run = !list_empty(&migrater->works);
> +	raw_spin_unlock_irqrestore(&migrater->lock, flags);
> +
> +	return run;
> +}
> +
> +static void cfs_migration_setup(unsigned int cpu)
> +{
> +	/* cfs_migration should have a higher priority than normal tasks,
> +	 * but a lower priority than other FIFO tasks.
> +	 */
> +	sched_set_fifo_low(current);
> +}
> +
> +static void cfs_migrater_thread(unsigned int cpu)
> +{
> +	struct cfs_migrater *migrater = &per_cpu(cfs_migrater, cpu);
> +	struct cpu_stop_work *work;
> +
> +repeat:
> +	work = NULL;
> +	raw_spin_lock_irq(&migrater->lock);
> +	if (!list_empty(&migrater->works)) {
> +		work = list_first_entry(&migrater->works,
> +					struct cpu_stop_work, list);
> +		list_del_init(&work->list);
> +	}
> +	raw_spin_unlock_irq(&migrater->lock);
> +
> +	if (work) {
> +		struct cpu_stop_done *done = work->done;
> +		cpu_stop_fn_t fn = work->fn;
> +		void *arg = work->arg;
> +		int ret;
> +
> +		preempt_count_inc();
> +		ret = fn(arg);
> +		if (done) {
> +			if (ret)
> +				done->ret = ret;
> +			cpu_stop_signal_done(done);
> +		}
> +		preempt_count_dec();
> +		goto repeat;
> +	}
> +}

You're pretty much copying the CPU stopper setup, but that seems overkill
for the functionality we're after: migrate a CFS task from one CPU to
another. This shouldn't need to be able to run any arbitrary callback
function.

Unfortunately you are tackling both CFS active balancing and NUMA balancing
at the same time, and right now they're plumbed a bit differently which
probably drove you to use something a bit for polymorphic. Ideally we
should be making them use the same paths, but IMO it would be acceptable as
a first step to just cater to CFS active balancing - folks that really care
about their RT tasks can disable CONFIG_NUMA_BALANCING, but there is
nothing to disable CFS active balancing.


Now, I'm thinking the bare information we need is:

- a task to migrate
- a CPU to move it to

And then you can do something like...

trigger_migration(task_struct *p, unsigned int dst_cpu)
{
        work = { p, dst_cpu };
        get_task_struct(p);
        /* queue work + wake migrater + wait for completion */
}

cfs_migrater_thread()
{
        /* ... */
        p = work->p;

        if (task_rq(p) != this_rq())
                goto out;

        /* migrate task to work->dst_cpu */
out:
        complete(<some completion struct>);
        put_task_struct(p);
}


We should also probably add something to prevent the migration from
happening after it is no longer relevant. Say if we have something like:

  <queue work to migrate p from CPU0 to CPU1>
  <FIFO-2 task runs for 42 seconds on CPU0>
  <cfs_migration/0 now gets to run>

p could have moved elsewhere while cfs_migration/0. I'm thinking source CPU
could be a useful information, but that doesn't tell you if the task moved
around in the meantime...

WDYT?

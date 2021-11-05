Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8675044677F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbhKERFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:05:18 -0400
Received: from foss.arm.com ([217.140.110.172]:33734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229926AbhKERFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:05:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51FFA2F;
        Fri,  5 Nov 2021 10:02:33 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE0ED3F7F5;
        Fri,  5 Nov 2021 10:02:31 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Yafang Shao <laoar.shao@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [RFC PATCH 4/4] sched/core: Do numa balance in cfs_migration
In-Reply-To: <20211104145713.4419-5-laoar.shao@gmail.com>
References: <20211104145713.4419-1-laoar.shao@gmail.com> <20211104145713.4419-5-laoar.shao@gmail.com>
Date:   Fri, 05 Nov 2021 17:02:29 +0000
Message-ID: <878ry2tu1m.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/21 14:57, Yafang Shao wrote:
> Similar to active load balance, the numa balance work is also applied to
> cfs tasks only and it should't preempt other FIFO tasks. We'd better assign
> cfs_migration to the numa balance as well.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/core.c  |  2 +-
>  kernel/sched/fair.c  | 13 +++++++++++++
>  kernel/sched/sched.h |  2 ++
>  3 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9cb81ef8acc8..4a37b06715f4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8724,7 +8724,7 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
>       /* TODO: This is not properly updating schedstats */
>
>       trace_sched_move_numa(p, curr_cpu, target_cpu);
> -	return stop_one_cpu(curr_cpu, migration_cpu_stop, &arg);
> +	return wakeup_cfs_migrater(curr_cpu, migration_cpu_stop, &arg);

So that one I find really icky - migration_cpu_stop() really is meant to be
run from a CPU stopper (cf. cpu_stop suffix). IMO this is the opportunity
to make NUMA balancing reuse the logic for CFS active balance here, but per
previous email I'd say it could be done as a second step.

>  }
>
>  /*
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 932f63baeb82..b7a155e05c98 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11960,6 +11960,19 @@ static void wakeup_cfs_migrater_nowait(unsigned int cpu, cpu_stop_fn_t fn, void
>       cfs_migration_queue_work(cpu, work_buf);
>  }
>
> +bool wakeup_cfs_migrater(unsigned int cpu, cpu_stop_fn_t fn, void *arg)
> +{
> +	struct cpu_stop_done done;
> +	struct cpu_stop_work work = { .fn = fn, .arg = arg, .done = &done, .caller = _RET_IP_ };
> +
> +	cpu_stop_init_done(&done, 1);
> +	cfs_migration_queue_work(cpu, &work);
> +	cond_resched();
> +	wait_for_completion(&done.completion);
> +
> +	return done.ret;
> +}
> +
>  static int cfs_migration_should_run(unsigned int cpu)
>  {
>       struct cfs_migrater *migrater = &per_cpu(cfs_migrater, cpu);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index a00fc7057d97..7b242c18a6d8 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3055,6 +3055,8 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
>
>       return true;
>  }
> +
> +bool wakeup_cfs_migrater(unsigned int cpu, cpu_stop_fn_t fn, void *arg);
>  #endif
>
>  extern void swake_up_all_locked(struct swait_queue_head *q);
> --
> 2.17.1

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6061D3C860B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 16:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239418AbhGNO0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 10:26:05 -0400
Received: from foss.arm.com ([217.140.110.172]:35540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232265AbhGNO0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 10:26:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3532231B;
        Wed, 14 Jul 2021 07:23:13 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D9EB3F694;
        Wed, 14 Jul 2021 07:23:11 -0700 (PDT)
Subject: Re: [RFC PATCH 1/1] sched: do active load balance in balance callback
To:     Yafang Shao <laoar.shao@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <CALOAHbAS26LP2p9Fe7m6xynZmazYENmx_HfTV4LebwPWr7XLmA@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <dfbe1030-05bf-3371-bc0a-56f79dcd6f39@arm.com>
Date:   Wed, 14 Jul 2021 16:23:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CALOAHbAS26LP2p9Fe7m6xynZmazYENmx_HfTV4LebwPWr7XLmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2021 09:40, Yafang Shao wrote:
> The active load balance which means to migrate the CFS task running on
> the busiest CPU to the new idle CPU has a known issue[1][2] that
> there are some race window between waking up the migration thread on the
> busiest CPU and it begins to preempt the current running CFS task.
> These race window may cause unexpected behavior that the latency
> sensitive RT tasks may be preempted by the migration thread as it has a
> higher priority.
> 
> This RFC patch tries to improve this situation. Instead of waking up the
> migration thread to do this work, this patch do it in the balance
> callback as follows,
> 
>      The New idle CPUm                The target CPUn
>      find the target task A           CFS task A is running
>      queue it into the target CPUn    A is scheduling out
>                                       do balance callback and migrate A to CPUm
> It avoids two context switches - task A to migration/n and migration/n to
> task B. And it avoids preempting the RT task if the RT task has already
> preempted task A before we do the queueing.
> 
> TODO:
> - I haven't done some benchmark to measure the impact on performance
> - To avoid deadlock I have to unlock the busiest_rq->lock before
>   calling attach_one_task() and lock it again after executing
>   attach_one_task(). That may re-introduce the issue addressed by
>   commit 565790d28b1e ("sched: Fix balance_callback()")
> 
> [1]. https://lore.kernel.org/lkml/CAKfTPtBygNcVewbb0GQOP5xxO96am3YeTZNP5dK9BxKHJJAL-g@mail.gmail.com/
> [2]. https://lore.kernel.org/lkml/20210615121551.31138-1-laoar.shao@gmail.com/

This didn't apply for me and I guess won't compile on tip/sched/core:

raw_spin_{,un}lock(&busiest_rq->lock) -> raw_spin_rq_{,un}lock(busiest_rq)

p->state == TASK_RUNNING -> p->__state or task_is_running(p)

> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/sched/core.c  |  1 +
>  kernel/sched/fair.c  | 69 ++++++++++++++------------------------------
>  kernel/sched/sched.h |  6 +++-
>  3 files changed, 28 insertions(+), 48 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 4ca80df205ce..a0a90a37e746 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8208,6 +8208,7 @@ void __init sched_init(void)
>                 rq->cpu_capacity = rq->cpu_capacity_orig = SCHED_CAPACITY_SCALE;
>                 rq->balance_callback = &balance_push_callback;
>                 rq->active_balance = 0;
> +               rq->active_balance_target = NULL;
>                 rq->next_balance = jiffies;
>                 rq->push_cpu = 0;
>                 rq->cpu = i;

[...]

> +DEFINE_PER_CPU(struct callback_head, active_balance_head);
> +
>  /*
>   * Check this_cpu to ensure it is balanced within domain. Attempt to move
>   * tasks if there is an imbalance.
> @@ -9845,15 +9817,14 @@ static int load_balance(int this_cpu, struct
> rq *this_rq,
>                         if (!busiest->active_balance) {
>                                 busiest->active_balance = 1;
>                                 busiest->push_cpu = this_cpu;
> +                               busiest->active_balance_target = busiest->curr;
>                                 active_balance = 1;
>                         }
> -                       raw_spin_unlock_irqrestore(&busiest->lock, flags);
> 
> -                       if (active_balance) {
> -                               stop_one_cpu_nowait(cpu_of(busiest),
> -                                       active_load_balance_cpu_stop, busiest,
> -                                       &busiest->active_balance_work);
> -                       }
> +                       if (active_balance)
> +                               queue_balance_callback(busiest,
> &per_cpu(active_balance_head, busiest->cpu),
> active_load_balance_cpu_stop);


When you defer the active load balance of p into a balance_callback
(from __schedule()) p has to stop running on busiest, right?
Deferring active load balance for too long might be defeat the purpose
of load balance which has to happen now.

Also, before balance_callback get invoked,  active balancing might try
to migrate p again and again but fails because `busiest->active_balance`
is still 1 (you kept this former synchronization meant for
active_balance_work). In this case the likelihood increases that one of
the error condition in active_load_balance_cpu_stop() hit when it's
finally called.

What's wrong with the FIFO-1 "stopper" for CFS active lb?

[...]

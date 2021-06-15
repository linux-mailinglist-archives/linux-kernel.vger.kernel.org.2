Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02313A8369
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 16:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhFOO5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 10:57:45 -0400
Received: from foss.arm.com ([217.140.110.172]:37730 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231609AbhFOO51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:57:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5714DD6E;
        Tue, 15 Jun 2021 07:55:22 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2A163F70D;
        Tue, 15 Jun 2021 07:55:20 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Yafang Shao <laoar.shao@gmail.com>, vincent.guittot@linaro.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH] sched, fair: try to prevent migration thread from preempting non-cfs task
In-Reply-To: <20210615121551.31138-1-laoar.shao@gmail.com>
References: <20210615121551.31138-1-laoar.shao@gmail.com>
Date:   Tue, 15 Jun 2021 15:55:15 +0100
Message-ID: <87mtrrb2jw.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 15/06/21 20:15, Yafang Shao wrote:

> - Prev version
>   https://lore.kernel.org/lkml/CAKfTPtBd349eyDhA5ThCAHFd83cGMQKb_LDxD4QvyP-cJOBjqA@mail.gmail.com/
>
> - Similar discussion
>   https://lore.kernel.org/lkml/CAKfTPtBygNcVewbb0GQOP5xxO96am3YeTZNP5dK9BxKHJJAL-g@mail.gmail.com/

I knew that sounded familiar :-)

> ---
>  kernel/sched/fair.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3248e24a90b0..597c7a940746 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9797,6 +9797,20 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>                       /* Record that we found at least one task that could run on this_cpu */
>                       env.flags &= ~LBF_ALL_PINNED;
>
> +			/*
> +			 * There may be a race between load balance starting migration
> +			 * thread to pull the cfs running thread and the RT thread
> +			 * waking up and preempting cfs task before migration threads
> +			 * which then preempt the RT thread.
> +			 * We'd better do the last minute check before starting
> +			 * migration thread to avoid preempting latency-sensitive thread.
> +			 */

This can be summarized as in the below, no?

                        /*
                         * Don't cause a higher-than-CFS task to be preempted by
                         * the CPU stopper.
                         */

> +			if (busiest->curr->sched_class != &fair_sched_class) {
> +				raw_spin_unlock_irqrestore(&busiest->lock,
> +							   flags);
> +				goto out;

Since you goto out this could be moved before the

  env.flags &= ~LBF_ALL_PINNED;

above (it only has an impact if you'd goto out_balanced).

> +			}
> +

Other than the above, this looks OK to me.

Back then I had argued that having a >CFS task and holding the remote rq
lock could let us invoke detach_one_task() locally (rather than on the
stopper thread), but realistically if we got to this !ld_moved condition
then the chances of us actually pulling something here are very slim (we'd
depend on enqueues happening between ~detach_tasks() and here).

>                       /*
>                        * ->active_balance synchronizes accesses to
>                        * ->active_balance_work.  Once set, it's cleared
> --
> 2.17.1

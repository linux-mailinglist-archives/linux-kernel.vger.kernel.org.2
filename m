Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA4631CF22
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 18:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhBPRft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 12:35:49 -0500
Received: from foss.arm.com ([217.140.110.172]:39850 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230017AbhBPRfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 12:35:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A5B9101E;
        Tue, 16 Feb 2021 09:35:01 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CEFB3F73B;
        Tue, 16 Feb 2021 09:34:59 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] sched: Fix affine_move_task()
In-Reply-To: <YCfLHxpL+L0BYEyG@hirez.programming.kicks-ass.net>
References: <YCfLHxpL+L0BYEyG@hirez.programming.kicks-ass.net>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Tue, 16 Feb 2021 17:34:55 +0000
Message-ID: <jhjv9arsyps.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/21 13:50, Peter Zijlstra wrote:
> When affine_move_task(p) is called on a running task @p, which is not
> otherwise already changing affinity, we'll first set
> p->migration_pending and then do:
>
> 	 stop_one_cpu(cpu_of_rq(rq), migration_cpu_stop, &arg);
>
> This then gets us to migration_cpu_stop() running on the CPU that was
> previously running our victim task @p.
>
> If we find that our task is no longer on that runqueue (this can
> happen because of a concurrent migration due to load-balance etc.),
> then we'll end up at the:
>
> 	} else if (dest_cpu < 1 || pending) {
>
> branch. Which we'll take because we set pending earlier. Here we first
> check if the task @p has already satisfied the affinity constraints,
> if so we bail early [A]. Otherwise we'll reissue migration_cpu_stop()
> onto the CPU that is now hosting our task @p:
>
> 	stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
> 			    &pending->arg, &pending->stop_work);
>
> Except, we've never initialized pending->arg, which will be all 0s.
>
> This then results in running migration_cpu_stop() on the next CPU with
> arg->p == NULL, which gives the by now obvious result of fireworks.
>
> The cure is to change affine_move_task() to always use pending->arg,
> furthermore we can use the exact same pattern as the
> SCA_MIGRATE_ENABLE case, since we'll block on the pending->done
> completion anyway, no point in adding yet another completion in
> stop_one_cpu().
>
> This then gives a clear distinction between the two
> migration_cpu_stop() use cases:
>
>   - sched_exec() / migrate_task_to() : arg->pending == NULL
>   - affine_move_task() : arg->pending != NULL;
>
> And we can have it ignore p->migration_pending when !arg->pending. Any
> stop work from sched_exec() / migrate_task_to() is in addition to stop
> works from affine_move_task(), which will be sufficient to issue the
> completion.
>
>
> NOTES:
>
>  - I've not been able to reproduce this crash on any of my machines
>    without first removing the early termination condition [A] above.
>    Doing this is a functional NOP but obviously widens up the window.
>

FWIW although I mistakenly didn't model any distinction between arg &
pending->arg, I did "hit" this path in TLA+ [1]

>  - With the check [A] removed I can consistently hit the NULL deref
>    and the below patch reliably cures it.
>
>  - The original reporter says that this patch cures the NULL deref
>    but results in another problem, which I've not yet been able to
>    make sense of and obviously have failed at reproduction as well :/
>

Do you have a link to that? I fumbled around my mails but haven't seen
anything.

> Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

The below looks good to me, I'll whack it into the TLA+ machine and see
where it goes. While at it I need to mention I *have* been cleaning it up
for upstreaming, but have hit [1] in the process...

[1]: http://lore.kernel.org/r/20210127193035.13789-1-valentin.schneider@arm.com

> ---
>  kernel/sched/core.c |   39 ++++++++++++++++++++++++++++-----------
>  1 file changed, 28 insertions(+), 11 deletions(-)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1924,6 +1924,24 @@ static int migration_cpu_stop(void *data
>  	rq_lock(rq, &rf);
>  
>  	pending = p->migration_pending;
> +	if (pending && !arg->pending) {
> +		/*
> +		 * This happens from sched_exec() and migrate_task_to(),
> +		 * neither of them care about pending and just want a task to
> +		 * maybe move about.
> +		 *
> +		 * Even if there is a pending, we can ignore it, since
> +		 * affine_move_task() will have it's own stop_work's in flight
> +		 * which will manage the completion.
> +		 *
> +		 * Notably, pending doesn't need to match arg->pending. This can
> +		 * happen when tripple concurrent affine_move_task() first sets
                               ^^^^^^
                           s/tripple/triple

> +		 * pending, then clears pending and eventually sets another
> +		 * pending.
> +		 */
> +		pending = NULL;
> +	}
> +
>  	/*
>  	 * If task_rq(p) != rq, it cannot be migrated here, because we're
>  	 * holding rq->lock, if p->on_rq == 0 it cannot get enqueued because

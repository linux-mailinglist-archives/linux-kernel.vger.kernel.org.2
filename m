Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A615D3FA6F3
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 19:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhH1RRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 13:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhH1RRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 13:17:46 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD2BC06179A
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 10:16:55 -0700 (PDT)
Date:   Sun, 29 Aug 2021 01:17:39 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1630171012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NC19TIU/UNKx6o1XW6VnMHGmVekrOJOXU9jgYnArCiM=;
        b=hd9ReYfg9fv8DUELLtqS27gAgIqOOQqF8uQaPngrMxeFUF9usLYXIwcD2hG0ofDiLl/oB7
        Ss2uRIfxJ19pKcc4xPjWbmIVNS7wlryyL70h2BLMAnNhfiDdUPGqjO/bgtRyPZUQaZZks7
        JRy8hPkidPkmvu0nsE7v+P6BjluaWJQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH V2] sched: Prevent balance_push() on remote runqueues
Message-ID: <YSpvs5G3X7fJ5FWG@geo.homenetwork>
References: <87tujb0yn1.ffs@tglx>
 <87eeae11cr.ffs@tglx>
 <87zgt1hdw7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgt1hdw7.ffs@tglx>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: tao.zhou@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Sat, Aug 28, 2021 at 03:55:52PM +0200, Thomas Gleixner wrote:

> sched_setscheduler() and rt_mutex_setprio() invoke the run-queue balance
> callback after changing priorities or the scheduling class of a task. The
> run-queue for which the callback is invoked can be local or remote.

Let me say(always with my wrong). When the priority or policy changed, it is
the opportunity to call RT/DL/core_sched callback if they queued.

The corresponding callback is: pull/push_rt_task(), pull/push_dl_task() and
sched_core_balance(). The rq's callback list can be queued from local or
other cpu's callback_head. They defined as per-cpu.

sched_core_balance() do not use stop machine. pull_dl_task(), push/pull_rt_task
use stop machine(push_cpu_stop()) to migrate tasks. SCA is another place to
use stop machine(push_cpu_stop()).

> That's not a problem for the regular rq::push_work which is serialized with
> a busy flag in the run-queue struct, but for the balance_push() work which

So, they use rq::push_busy to serialize as said above.

balance_push() is another call back func that may queue on rq's callback list.
But, it is different from the above ones. It is *global* and more import than
others. If it is already queued on, every other callback will not be queued.
And the points where calling __balance_callbacks() will do the cpu outgoing
things.

sched_setscheduler() and rt_mutex_setprio() are the two points to call
__balance_callbacks(), and the __schedule() also have two points. one
is finish_lock_switch() and another is when prev==next case.

Task switched implys priority or policy changed. More important is for 
stop machine(__balance_push_cpu_stop()) to migrate the tasks..

> is only valid to be invoked on the outgoing CPU that's wrong. It not only

When deactive cpu, set balance_push() call back. The opportunity that
call this func may from other cpus(now see, so the saying warning).

> triggers the debug warning, but also leaves the per CPU variable push_work
> unprotected, which can result in double enqueues on the stop machine list.

Auh, only just use the outgoing cpu to do the stop->task->stop.. migrate tasks..
And, no need to use what to protect the push_work.

Yeah.. my ugly words.. But.

> Remove the warning and validate that the function is invoked on the
> outgoing CPU.
> 
> Fixes: ae7927023243 ("sched: Optimize finish_lock_switch()")
> Reported-by: Sebastian Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
> V2: Use the correct check for the outgoing CPU
> ---
>  kernel/sched/core.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8435,7 +8435,6 @@ static void balance_push(struct rq *rq)
>  	struct task_struct *push_task = rq->curr;
>  
>  	lockdep_assert_rq_held(rq);
> -	SCHED_WARN_ON(rq->cpu != smp_processor_id());
>  
>  	/*
>  	 * Ensure the thing is persistent until balance_push_set(.on = false);
> @@ -8443,9 +8442,10 @@ static void balance_push(struct rq *rq)
>  	rq->balance_callback = &balance_push_callback;
>  
>  	/*
> -	 * Only active while going offline.
> +	 * Only active while going offline and when invoked on the outgoing
> +	 * CPU.
>  	 */
> -	if (!cpu_dying(rq->cpu))
> +	if (!cpu_dying(rq->cpu) || rq != this_rq())
>  		return;
>  
>  	/*



Thanks,
Tao

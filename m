Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA4A324370
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 19:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhBXR77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 12:59:59 -0500
Received: from foss.arm.com ([217.140.110.172]:42482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231701AbhBXR74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 12:59:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46E1E1FB;
        Wed, 24 Feb 2021 09:59:10 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AB563F73B;
        Wed, 24 Feb 2021 09:59:09 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 6/6] sched: Simplify set_affinity_pending refcounts
In-Reply-To: <YDZyIugiyxAq0tVz@hirez.programming.kicks-ass.net>
References: <20210224122439.176543586@infradead.org> <20210224131355.724130207@infradead.org> <YDZyIugiyxAq0tVz@hirez.programming.kicks-ass.net>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Wed, 24 Feb 2021 17:59:01 +0000
Message-ID: <jhjeeh55ouy.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/21 16:34, Peter Zijlstra wrote:
> Elsewhere Valentin argued something like the below ought to be possible.
> I've not drawn diagrams yet, but if I understood his argument right it
> should be possible.
>
> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 1c56ac4df2c9..3ffbd1b76f3e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2204,9 +2204,10 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
>  		 * then complete now.
>  		 */
>  		pending = p->migration_pending;
> -		if (pending && !pending->stop_pending) {
> +		if (pending) {
>  			p->migration_pending = NULL;
> -			complete = true;
> +			if (!pending->stop_pending)
> +				complete = true;
>  		}
>  
>  		task_rq_unlock(rq, p, rf);
> @@ -2286,10 +2287,9 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
>  			if (task_on_rq_queued(p))
>  				rq = move_queued_task(rq, rf, p, dest_cpu);
>  
> -			if (!pending->stop_pending) {
> -				p->migration_pending = NULL;
> +			p->migration_pending = NULL;
> +			if (!pending->stop_pending)
>  				complete = true;
> -			}
>  		}
>  		task_rq_unlock(rq, p, rf);
>  

I was thinking of the "other way around"; i.e. modify migration_cpu_stop()
into:

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9492f8eb242a..9546f0263970 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1926,6 +1926,11 @@ static int migration_cpu_stop(void *data)
 	raw_spin_lock(&p->pi_lock);
 	rq_lock(rq, &rf);
 
+	/*
+	 * If we were passed a pending, then ->stop_pending was set, thus
+	 * p->migration_pending must have remained stable.
+	 */
+	WARN_ON_ONCE(pending && pending != p->migration_pending);
 	/*
 	 * If task_rq(p) != rq, it cannot be migrated here, because we're
 	 * holding rq->lock, if p->on_rq == 0 it cannot get enqueued because
@@ -1936,8 +1941,7 @@ static int migration_cpu_stop(void *data)
 			goto out;
 
 		if (pending) {
-			if (p->migration_pending == pending)
-				p->migration_pending = NULL;
+			p->migration_pending = NULL;
 			complete = true;
 		}
 
@@ -1976,8 +1980,7 @@ static int migration_cpu_stop(void *data)
 		 * somewhere allowed, we're done.
 		 */
 		if (cpumask_test_cpu(task_cpu(p), p->cpus_ptr)) {
-			if (p->migration_pending == pending)
-				p->migration_pending = NULL;
+			p->migration_pending = NULL;
 			complete = true;
 			goto out;
 		}
---

Your change reinstores the "triple SCA" pattern, where a stopper can run
with arg->pending && arg->pending != p->migration_pending, which I was
kinda happy to see go away...

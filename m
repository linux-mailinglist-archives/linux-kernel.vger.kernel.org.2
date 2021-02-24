Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D8D324158
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbhBXPsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:48:50 -0500
Received: from foss.arm.com ([217.140.110.172]:36904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232806AbhBXPgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 10:36:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1050101E;
        Wed, 24 Feb 2021 07:34:53 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A5EE3F70D;
        Wed, 24 Feb 2021 07:34:52 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 6/6] sched: Simplify set_affinity_pending refcounts
In-Reply-To: <20210224131355.724130207@infradead.org>
References: <20210224122439.176543586@infradead.org> <20210224131355.724130207@infradead.org>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Wed, 24 Feb 2021 15:34:49 +0000
Message-ID: <jhjlfbd5vja.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/21 13:24, Peter Zijlstra wrote:
> Now that we have set_affinity_pending::stop_pending to indicate if a
> stopper is in progress, and we have the guarantee that if that stopper
> exists, it will (eventually) complete our @pending we can simplify the
> refcount scheme by no longer counting the stopper thread.
>
> Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> @@ -2199,12 +2199,16 @@ static int affine_move_task(struct rq *r
>                       push_task = get_task_struct(p);
>               }
>
> +		/*
> +		 * If there are pending waiters, but no pending stop_work,
> +		 * then complete now.
> +		 */
>               pending = p->migration_pending;
> -		if (pending) {
> -			refcount_inc(&pending->refs);
> +		if (pending && !pending->stop_pending) {
>                       p->migration_pending = NULL;
>                       complete = true;
>               }
> +
>               task_rq_unlock(rq, p, rf);
>
>               if (push_task) {
> @@ -2213,7 +2217,7 @@ static int affine_move_task(struct rq *r
>               }
>
>               if (complete)
> -			goto do_complete;
> +			complete_all(&pending->done);

We could've done this in the first place, right? I don't think this path
actually needed to deal with the refcounts (at least not since we started
counting the stoppers).

Musings aside, I believe the above means, for migration_cpu_stop():

  (pending != NULL) => (pending == p->migration_pending)

Since, when ->stop_pending, only the stopper can uninstall
p->migration_pending. This could simplify a few if's.

Also, the fatty comment above affine_move_task() probably needs a bit of
gardening:

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9492f8eb242a..6f649aa2795c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2165,16 +2165,21 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
  *
  * (1) In the cases covered above. There is one more where the completion is
  * signaled within affine_move_task() itself: when a subsequent affinity request
- * cancels the need for an active migration. Consider:
+ * occurs after the stopper bailed out due to the targeted task still being
+ * Migrate-Disable. Consider:
  *
  *     Initial conditions: P0->cpus_mask = [0, 1]
  *
- *     P0@CPU0            P1                             P2
- *
- *     migrate_disable();
- *     <preempted>
+ *     CPU0               P1                             P2
+ *     <P0>
+ *       migrate_disable();
+ *       <preempted>
  *                        set_cpus_allowed_ptr(P0, [1]);
  *                          <blocks>
+ *     <migration/0>
+ *       migration_cpu_stop()
+ *         is_migration_disabled()
+ *           <bails>
  *                                                       set_cpus_allowed_ptr(P0, [0, 1]);
  *                                                         <signal completion>
  *                          <awakes>

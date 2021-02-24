Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875F5323FE1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbhBXOZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 09:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbhBXNS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:18:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC4EC061794
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=C682tqdlebuqQLFH1RC7kP6EC2uhTggnSYbBjNMh/vs=; b=d4L4mg8B2ebTeS1vtppu/kWH2Q
        8Sh70cnyhSpnQx3w7rDzxItr+9tUslEk3W8m2XWoA+TGzsDAikQwy+EqwnmCOu1pq+JF3ZlUYwfVE
        uanigcB5y7fRezcS+yfCQjThdEU7ggunaQ0cINPeEN9/6SY2ZUx5+c7mbYGk0P//nYnikmk01tWZz
        E9KbeZ1tqWulpshIS7UMYc/Mahh1lOnWzoRWGY6Hl93nC7um7h5cVb/Yad3rzceKtNjD/lk1S7Z0E
        qG9DYN4Z99nLoerl1p7UPcjqs/jMs6akhWOMDHU/jKsYqMohANcw3gJeIN7+AttICJ8kB7RzZILtF
        2dTswRoA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lEu13-009Qto-BL; Wed, 24 Feb 2021 13:15:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 08C1E301A32;
        Wed, 24 Feb 2021 14:15:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D284B207C3A70; Wed, 24 Feb 2021 14:15:42 +0100 (CET)
Message-ID: <20210224131355.430014682@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 24 Feb 2021 13:24:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 2/6] sched: Simplify migration_cpu_stop()
References: <20210224122439.176543586@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When affine_move_task() issues a migration_cpu_stop(), the purpose of
that function is to complete that @pending, not any random other
p->migration_pending that might have gotten installed since.

This realization much simplifies migration_cpu_stop() and allows
further necessary steps to fix all this as it provides the guarantee
that @pending's stopper will complete @pending (and not some random
other @pending).

Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   56 +++++++---------------------------------------------
 1 file changed, 8 insertions(+), 48 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1898,8 +1898,8 @@ static struct rq *__migrate_task(struct
  */
 static int migration_cpu_stop(void *data)
 {
-	struct set_affinity_pending *pending;
 	struct migration_arg *arg = data;
+	struct set_affinity_pending *pending = arg->pending;
 	struct task_struct *p = arg->task;
 	int dest_cpu = arg->dest_cpu;
 	struct rq *rq = this_rq();
@@ -1921,25 +1921,6 @@ static int migration_cpu_stop(void *data
 	raw_spin_lock(&p->pi_lock);
 	rq_lock(rq, &rf);
 
-	pending = p->migration_pending;
-	if (pending && !arg->pending) {
-		/*
-		 * This happens from sched_exec() and migrate_task_to(),
-		 * neither of them care about pending and just want a task to
-		 * maybe move about.
-		 *
-		 * Even if there is a pending, we can ignore it, since
-		 * affine_move_task() will have it's own stop_work's in flight
-		 * which will manage the completion.
-		 *
-		 * Notably, pending doesn't need to match arg->pending. This can
-		 * happen when tripple concurrent affine_move_task() first sets
-		 * pending, then clears pending and eventually sets another
-		 * pending.
-		 */
-		pending = NULL;
-	}
-
 	/*
 	 * If task_rq(p) != rq, it cannot be migrated here, because we're
 	 * holding rq->lock, if p->on_rq == 0 it cannot get enqueued because
@@ -1950,31 +1931,20 @@ static int migration_cpu_stop(void *data
 			goto out;
 
 		if (pending) {
-			p->migration_pending = NULL;
+			if (p->migration_pending == pending)
+				p->migration_pending = NULL;
 			complete = true;
 		}
 
-		/* migrate_enable() --  we must not race against SCA */
-		if (dest_cpu < 0) {
-			/*
-			 * When this was migrate_enable() but we no longer
-			 * have a @pending, a concurrent SCA 'fixed' things
-			 * and we should be valid again. Nothing to do.
-			 */
-			if (!pending) {
-				WARN_ON_ONCE(!cpumask_test_cpu(task_cpu(p), &p->cpus_mask));
-				goto out;
-			}
-
+		if (dest_cpu < 0)
 			dest_cpu = cpumask_any_distribute(&p->cpus_mask);
-		}
 
 		if (task_on_rq_queued(p))
 			rq = __migrate_task(rq, &rf, p, dest_cpu);
 		else
 			p->wake_cpu = dest_cpu;
 
-	} else if (dest_cpu < 0 || pending) {
+	} else if (pending) {
 		/*
 		 * This happens when we get migrated between migrate_enable()'s
 		 * preempt_enable() and scheduling the stopper task. At that
@@ -1989,23 +1959,14 @@ static int migration_cpu_stop(void *data
 		 * ->pi_lock, so the allowed mask is stable - if it got
 		 * somewhere allowed, we're done.
 		 */
-		if (pending && cpumask_test_cpu(task_cpu(p), p->cpus_ptr)) {
-			p->migration_pending = NULL;
+		if (cpumask_test_cpu(task_cpu(p), p->cpus_ptr)) {
+			if (p->migration_pending == pending)
+				p->migration_pending = NULL;
 			complete = true;
 			goto out;
 		}
 
 		/*
-		 * When this was migrate_enable() but we no longer have an
-		 * @pending, a concurrent SCA 'fixed' things and we should be
-		 * valid again. Nothing to do.
-		 */
-		if (!pending) {
-			WARN_ON_ONCE(!cpumask_test_cpu(task_cpu(p), &p->cpus_mask));
-			goto out;
-		}
-
-		/*
 		 * When migrate_enable() hits a rq mis-match we can't reliably
 		 * determine is_migration_disabled() and so have to chase after
 		 * it.
@@ -2022,7 +1983,6 @@ static int migration_cpu_stop(void *data
 		complete_all(&pending->done);
 
 	/* For pending->{arg,stop_work} */
-	pending = arg->pending;
 	if (pending && refcount_dec_and_test(&pending->refs))
 		wake_up_var(&pending->refs);
 



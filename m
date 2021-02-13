Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E7531AB6A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 13:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhBMMvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 07:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhBMMvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 07:51:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E91C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 04:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=mHNhPIEf/fEyqa/Be3w7fBiVCejj5m5z2qT7VKg/VmI=; b=F7/Gskr/psRk37VtC0K9DzD3OU
        ugR8RAj9/XQHHc4J30UuWoJ4vyFgoZMLEzAXGN1W6W/WrWFYJqTzK9AjlbYUEovkpYVDKJVd2i10y
        WEWTF7m7+7dNeePU5QTVSq/VPXpZIFmt1Vlu+v/uxIzRfRocBqlW66PbKMsAfQuIVuSi+Zi7ysZQc
        FyecH2TFs2APRbFLtQeK6iJOqe51qVa3IBStZMCwUm3XCmXYfZcvpBdQkOlEcEtu/634kzHRYPyGp
        32FbTqBXhuFE/TbA7cbbfexPz/dGkybOwkmaOpqbh88Xog5BJH9+ovV0AVz5nWwMisCux34i7diez
        3mNE19sA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lAuNn-00CvXq-2Z; Sat, 13 Feb 2021 12:50:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E2F52300446;
        Sat, 13 Feb 2021 13:50:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A35D320299B4B; Sat, 13 Feb 2021 13:50:39 +0100 (CET)
Date:   Sat, 13 Feb 2021 13:50:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] sched: Fix affine_move_task()
Message-ID: <YCfLHxpL+L0BYEyG@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


When affine_move_task(p) is called on a running task @p, which is not
otherwise already changing affinity, we'll first set
p->migration_pending and then do:

	 stop_one_cpu(cpu_of_rq(rq), migration_cpu_stop, &arg);

This then gets us to migration_cpu_stop() running on the CPU that was
previously running our victim task @p.

If we find that our task is no longer on that runqueue (this can
happen because of a concurrent migration due to load-balance etc.),
then we'll end up at the:

	} else if (dest_cpu < 1 || pending) {

branch. Which we'll take because we set pending earlier. Here we first
check if the task @p has already satisfied the affinity constraints,
if so we bail early [A]. Otherwise we'll reissue migration_cpu_stop()
onto the CPU that is now hosting our task @p:

	stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
			    &pending->arg, &pending->stop_work);

Except, we've never initialized pending->arg, which will be all 0s.

This then results in running migration_cpu_stop() on the next CPU with
arg->p == NULL, which gives the by now obvious result of fireworks.

The cure is to change affine_move_task() to always use pending->arg,
furthermore we can use the exact same pattern as the
SCA_MIGRATE_ENABLE case, since we'll block on the pending->done
completion anyway, no point in adding yet another completion in
stop_one_cpu().

This then gives a clear distinction between the two
migration_cpu_stop() use cases:

  - sched_exec() / migrate_task_to() : arg->pending == NULL
  - affine_move_task() : arg->pending != NULL;

And we can have it ignore p->migration_pending when !arg->pending. Any
stop work from sched_exec() / migrate_task_to() is in addition to stop
works from affine_move_task(), which will be sufficient to issue the
completion.


NOTES:

 - I've not been able to reproduce this crash on any of my machines
   without first removing the early termination condition [A] above.
   Doing this is a functional NOP but obviously widens up the window.

 - With the check [A] removed I can consistently hit the NULL deref
   and the below patch reliably cures it.

 - The original reporter says that this patch cures the NULL deref
   but results in another problem, which I've not yet been able to
   make sense of and obviously have failed at reproduction as well :/

Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1924,6 +1924,24 @@ static int migration_cpu_stop(void *data
 	rq_lock(rq, &rf);
 
 	pending = p->migration_pending;
+	if (pending && !arg->pending) {
+		/*
+		 * This happens from sched_exec() and migrate_task_to(),
+		 * neither of them care about pending and just want a task to
+		 * maybe move about.
+		 *
+		 * Even if there is a pending, we can ignore it, since
+		 * affine_move_task() will have it's own stop_work's in flight
+		 * which will manage the completion.
+		 *
+		 * Notably, pending doesn't need to match arg->pending. This can
+		 * happen when tripple concurrent affine_move_task() first sets
+		 * pending, then clears pending and eventually sets another
+		 * pending.
+		 */
+		pending = NULL;
+	}
+
 	/*
 	 * If task_rq(p) != rq, it cannot be migrated here, because we're
 	 * holding rq->lock, if p->on_rq == 0 it cannot get enqueued because
@@ -2196,10 +2214,6 @@ static int affine_move_task(struct rq *r
 			    int dest_cpu, unsigned int flags)
 {
 	struct set_affinity_pending my_pending = { }, *pending = NULL;
-	struct migration_arg arg = {
-		.task = p,
-		.dest_cpu = dest_cpu,
-	};
 	bool complete = false;
 
 	/* Can the task run on the task's current CPU? If so, we're done */
@@ -2237,6 +2251,12 @@ static int affine_move_task(struct rq *r
 			/* Install the request */
 			refcount_set(&my_pending.refs, 1);
 			init_completion(&my_pending.done);
+			my_pending.arg = (struct migration_arg) {
+				.task = p,
+				.dest_cpu = -1,
+				.pending = &my_pending,
+			};
+
 			p->migration_pending = &my_pending;
 		} else {
 			pending = p->migration_pending;
@@ -2267,12 +2287,6 @@ static int affine_move_task(struct rq *r
 		p->migration_flags &= ~MDF_PUSH;
 		task_rq_unlock(rq, p, rf);
 
-		pending->arg = (struct migration_arg) {
-			.task = p,
-			.dest_cpu = -1,
-			.pending = pending,
-		};
-
 		stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
 				    &pending->arg, &pending->stop_work);
 
@@ -2285,8 +2299,11 @@ static int affine_move_task(struct rq *r
 		 * is_migration_disabled(p) checks to the stopper, which will
 		 * run on the same CPU as said p.
 		 */
+		refcount_inc(&pending->refs); /* pending->{arg,stop_work} */
 		task_rq_unlock(rq, p, rf);
-		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
+
+		stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
+				    &pending->arg, &pending->stop_work);
 
 	} else {
 

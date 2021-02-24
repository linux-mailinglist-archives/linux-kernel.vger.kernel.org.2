Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A16323FE0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbhBXOY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 09:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbhBXNS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:18:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE92C0617A7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ROZDWadhTAJM+fwXVa9G4naTgOaLGoDbTKwN4LtxPhM=; b=X2Qou+gRQpUSm6XG/E7p582kaZ
        ARA62R3qfN1iaOtkxVCHstSEc2gh20xO720CJ37bbbLlLCjMhbrz5KCSbpsmGxDiyt1HtVMIuKeTW
        kFsS0R1/8Z5Tpu/SBXjudQnWSxlvJ9QIIMQlPd+PpctzCz899Bdfq0aLK+g+2WEC5idUTuXTx0mDZ
        Jq9rWwEwEVhyP8+Fko7/nbF0U6OuQ5nTkjzfISlQpJ+/1R7fx5vv3or5/BCaBQG/LTxhbG+4v9kzw
        jvlALFjsJ0xv1nWqa1Se3V5IOOBV7TC2k8AD0LCpgz6FkYvqxYRHZxF8y5Nko0dQPab+yIvWXCC/W
        Fm7dmeaw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lEu12-009Qti-Be; Wed, 24 Feb 2021 13:15:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2093630477A;
        Wed, 24 Feb 2021 14:15:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CE9B6203BF925; Wed, 24 Feb 2021 14:15:42 +0100 (CET)
Message-ID: <20210224131355.357743989@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 24 Feb 2021 13:24:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 1/6] sched: Fix migration_cpu_stop() requeueing
References: <20210224122439.176543586@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1922,6 +1922,24 @@ static int migration_cpu_stop(void *data
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
@@ -2194,10 +2212,6 @@ static int affine_move_task(struct rq *r
 			    int dest_cpu, unsigned int flags)
 {
 	struct set_affinity_pending my_pending = { }, *pending = NULL;
-	struct migration_arg arg = {
-		.task = p,
-		.dest_cpu = dest_cpu,
-	};
 	bool complete = false;
 
 	/* Can the task run on the task's current CPU? If so, we're done */
@@ -2235,6 +2249,12 @@ static int affine_move_task(struct rq *r
 			/* Install the request */
 			refcount_set(&my_pending.refs, 1);
 			init_completion(&my_pending.done);
+			my_pending.arg = (struct migration_arg) {
+				.task = p,
+				.dest_cpu = -1,		/* any */
+				.pending = &my_pending,
+			};
+
 			p->migration_pending = &my_pending;
 		} else {
 			pending = p->migration_pending;
@@ -2265,12 +2285,6 @@ static int affine_move_task(struct rq *r
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
 
@@ -2283,8 +2297,11 @@ static int affine_move_task(struct rq *r
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
 



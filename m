Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136703C2B20
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 00:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhGIWDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 18:03:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231183AbhGIWDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 18:03:03 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2131F613C2;
        Fri,  9 Jul 2021 22:00:19 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1m1yXi-000CKx-5i; Fri, 09 Jul 2021 18:00:18 -0400
Message-ID: <20210709220018.003428207@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 09 Jul 2021 17:59:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>, stable@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH RT 5/8] sched: Fix affine_move_task() self-concurrency
References: <20210709215953.122804544@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.10.47-rt46-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit 9e81889c7648d48dd5fe13f41cbc99f3c362484a upstream.

Consider:

   sched_setaffinity(p, X);		sched_setaffinity(p, Y);

Then the first will install p->migration_pending = &my_pending; and
issue stop_one_cpu_nowait(pending); and the second one will read
p->migration_pending and _also_ issue: stop_one_cpu_nowait(pending),
the _SAME_ @pending.

This causes stopper list corruption.

Add set_affinity_pending::stop_pending, to indicate if a stopper is in
progress.

Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
Cc: stable@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210224131355.649146419@infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/sched/core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9cbe12d8c5bd..20588a59300d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1900,6 +1900,7 @@ struct migration_arg {
 
 struct set_affinity_pending {
 	refcount_t		refs;
+	unsigned int		stop_pending;
 	struct completion	done;
 	struct cpu_stop_work	stop_work;
 	struct migration_arg	arg;
@@ -2018,12 +2019,15 @@ static int migration_cpu_stop(void *data)
 		 * determine is_migration_disabled() and so have to chase after
 		 * it.
 		 */
+		WARN_ON_ONCE(!pending->stop_pending);
 		task_rq_unlock(rq, p, &rf);
 		stop_one_cpu_nowait(task_cpu(p), migration_cpu_stop,
 				    &pending->arg, &pending->stop_work);
 		return 0;
 	}
 out:
+	if (pending)
+		pending->stop_pending = false;
 	task_rq_unlock(rq, p, &rf);
 
 	if (complete)
@@ -2219,7 +2223,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 			    int dest_cpu, unsigned int flags)
 {
 	struct set_affinity_pending my_pending = { }, *pending = NULL;
-	bool complete = false;
+	bool stop_pending, complete = false;
 
 	/* Can the task run on the task's current CPU? If so, we're done */
 	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask)) {
@@ -2292,14 +2296,19 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		 * anything else we cannot do is_migration_disabled(), punt
 		 * and have the stopper function handle it all race-free.
 		 */
+		stop_pending = pending->stop_pending;
+		if (!stop_pending)
+			pending->stop_pending = true;
 
 		refcount_inc(&pending->refs); /* pending->{arg,stop_work} */
 		if (flags & SCA_MIGRATE_ENABLE)
 			p->migration_flags &= ~MDF_PUSH;
 		task_rq_unlock(rq, p, rf);
 
-		stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
-				    &pending->arg, &pending->stop_work);
+		if (!stop_pending) {
+			stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
+					    &pending->arg, &pending->stop_work);
+		}
 
 		if (flags & SCA_MIGRATE_ENABLE)
 			return 0;
-- 
2.30.2

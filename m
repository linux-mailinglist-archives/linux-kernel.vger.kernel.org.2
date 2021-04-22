Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007EA3680A5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236927AbhDVMj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236340AbhDVMhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:37:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F90C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 05:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=KSSGopshFQpE+RdZAvIRoyyzJbHWO1fesCtFiIh3opE=; b=J8pDMKyWYvjkzid81pEbmMd2yd
        DtCNuO6IEjirrM2VIuTmf8utTQWgNlZ2qYluwUweVnNzJ8NHPLwvZ3b6OmHD0VI2gkM9piclZlSGK
        njZ+qXSaK6VRaDvd6F9zMPQxY+bE8EyZFZzg+51h/3nNmET9zDBA2HyX94CJBUwEeMCdDE59hyYov
        qJbVVytO5MCWtTDqvMt08r1TyoyqV+vFqKiucgHEgaWAzGHkANxWRegoaq8IbN9NsAOSrT9muZkxD
        xaRMTLhCPTRmKF1Ph1z5JwGwU9vT4fui4O+wSA3vAoIuYZDg98nUBa43Gti4cuh5bCVg2ALjEO+re
        09RPSMMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZYZ2-000IC6-FF; Thu, 22 Apr 2021 12:36:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6C85F30030A;
        Thu, 22 Apr 2021 14:35:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 437642C67968D; Thu, 22 Apr 2021 14:35:20 +0200 (CEST)
Message-ID: <20210422123308.437092775@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 22 Apr 2021 14:05:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de,
        Vineeth Remanan Pillai <viremana@linux.microsoft.com>
Subject: [PATCH 08/19] sched: Introduce sched_class::pick_task()
References: <20210422120459.447350175@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because sched_class::pick_next_task() also implies
sched_class::set_next_task() (and possibly put_prev_task() and
newidle_balance) it is not state invariant. This makes it unsuitable
for remote task selection.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[Vineeth: folded fixes]
Signed-off-by: Vineeth Remanan Pillai <viremana@linux.microsoft.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/deadline.c  |   16 ++++++++++++++--
 kernel/sched/fair.c      |   40 +++++++++++++++++++++++++++++++++++++---
 kernel/sched/idle.c      |    8 ++++++++
 kernel/sched/rt.c        |   15 +++++++++++++--
 kernel/sched/sched.h     |    3 +++
 kernel/sched/stop_task.c |   14 ++++++++++++--
 6 files changed, 87 insertions(+), 9 deletions(-)

--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1873,7 +1873,7 @@ static struct sched_dl_entity *pick_next
 	return rb_entry(left, struct sched_dl_entity, rb_node);
 }
 
-static struct task_struct *pick_next_task_dl(struct rq *rq)
+static struct task_struct *pick_task_dl(struct rq *rq)
 {
 	struct sched_dl_entity *dl_se;
 	struct dl_rq *dl_rq = &rq->dl;
@@ -1885,7 +1885,18 @@ static struct task_struct *pick_next_tas
 	dl_se = pick_next_dl_entity(rq, dl_rq);
 	BUG_ON(!dl_se);
 	p = dl_task_of(dl_se);
-	set_next_task_dl(rq, p, true);
+
+	return p;
+}
+
+static struct task_struct *pick_next_task_dl(struct rq *rq)
+{
+	struct task_struct *p;
+
+	p = pick_task_dl(rq);
+	if (p)
+		set_next_task_dl(rq, p, true);
+
 	return p;
 }
 
@@ -2557,6 +2568,7 @@ DEFINE_SCHED_CLASS(dl) = {
 
 #ifdef CONFIG_SMP
 	.balance		= balance_dl,
+	.pick_task		= pick_task_dl,
 	.select_task_rq		= select_task_rq_dl,
 	.migrate_task_rq	= migrate_task_rq_dl,
 	.set_cpus_allowed       = set_cpus_allowed_dl,
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4400,6 +4400,8 @@ check_preempt_tick(struct cfs_rq *cfs_rq
 static void
 set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	clear_buddies(cfs_rq, se);
+
 	/* 'current' is not kept within the tree. */
 	if (se->on_rq) {
 		/*
@@ -4459,7 +4461,7 @@ pick_next_entity(struct cfs_rq *cfs_rq,
 	 * Avoid running the skip buddy, if running something else can
 	 * be done without getting too unfair.
 	 */
-	if (cfs_rq->skip == se) {
+	if (cfs_rq->skip && cfs_rq->skip == se) {
 		struct sched_entity *second;
 
 		if (se == curr) {
@@ -4486,8 +4488,6 @@ pick_next_entity(struct cfs_rq *cfs_rq,
 		se = cfs_rq->last;
 	}
 
-	clear_buddies(cfs_rq, se);
-
 	return se;
 }
 
@@ -7018,6 +7018,39 @@ static void check_preempt_wakeup(struct
 		set_last_buddy(se);
 }
 
+#ifdef CONFIG_SMP
+static struct task_struct *pick_task_fair(struct rq *rq)
+{
+	struct sched_entity *se;
+	struct cfs_rq *cfs_rq;
+
+again:
+	cfs_rq = &rq->cfs;
+	if (!cfs_rq->nr_running)
+		return NULL;
+
+	do {
+		struct sched_entity *curr = cfs_rq->curr;
+
+		/* When we pick for a remote RQ, we'll not have done put_prev_entity() */
+		if (curr) {
+			if (curr->on_rq)
+				update_curr(cfs_rq);
+			else
+				curr = NULL;
+
+			if (unlikely(check_cfs_rq_runtime(cfs_rq)))
+				goto again;
+		}
+
+		se = pick_next_entity(cfs_rq, curr);
+		cfs_rq = group_cfs_rq(se);
+	} while (cfs_rq);
+
+	return task_of(se);
+}
+#endif
+
 struct task_struct *
 pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
@@ -11220,6 +11253,7 @@ DEFINE_SCHED_CLASS(fair) = {
 
 #ifdef CONFIG_SMP
 	.balance		= balance_fair,
+	.pick_task		= pick_task_fair,
 	.select_task_rq		= select_task_rq_fair,
 	.migrate_task_rq	= migrate_task_rq_fair,
 
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -406,6 +406,13 @@ static void set_next_task_idle(struct rq
 	schedstat_inc(rq->sched_goidle);
 }
 
+#ifdef CONFIG_SMP
+static struct task_struct *pick_task_idle(struct rq *rq)
+{
+	return rq->idle;
+}
+#endif
+
 struct task_struct *pick_next_task_idle(struct rq *rq)
 {
 	struct task_struct *next = rq->idle;
@@ -473,6 +480,7 @@ DEFINE_SCHED_CLASS(idle) = {
 
 #ifdef CONFIG_SMP
 	.balance		= balance_idle,
+	.pick_task		= pick_task_idle,
 	.select_task_rq		= select_task_rq_idle,
 	.set_cpus_allowed	= set_cpus_allowed_common,
 #endif
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1626,7 +1626,7 @@ static struct task_struct *_pick_next_ta
 	return rt_task_of(rt_se);
 }
 
-static struct task_struct *pick_next_task_rt(struct rq *rq)
+static struct task_struct *pick_task_rt(struct rq *rq)
 {
 	struct task_struct *p;
 
@@ -1634,7 +1634,17 @@ static struct task_struct *pick_next_tas
 		return NULL;
 
 	p = _pick_next_task_rt(rq);
-	set_next_task_rt(rq, p, true);
+
+	return p;
+}
+
+static struct task_struct *pick_next_task_rt(struct rq *rq)
+{
+	struct task_struct *p = pick_task_rt(rq);
+
+	if (p)
+		set_next_task_rt(rq, p, true);
+
 	return p;
 }
 
@@ -2483,6 +2493,7 @@ DEFINE_SCHED_CLASS(rt) = {
 
 #ifdef CONFIG_SMP
 	.balance		= balance_rt,
+	.pick_task		= pick_task_rt,
 	.select_task_rq		= select_task_rq_rt,
 	.set_cpus_allowed       = set_cpus_allowed_common,
 	.rq_online              = rq_online_rt,
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1839,6 +1839,9 @@ struct sched_class {
 #ifdef CONFIG_SMP
 	int (*balance)(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
 	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int flags);
+
+	struct task_struct * (*pick_task)(struct rq *rq);
+
 	void (*migrate_task_rq)(struct task_struct *p, int new_cpu);
 
 	void (*task_woken)(struct rq *this_rq, struct task_struct *task);
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -34,15 +34,24 @@ static void set_next_task_stop(struct rq
 	stop->se.exec_start = rq_clock_task(rq);
 }
 
-static struct task_struct *pick_next_task_stop(struct rq *rq)
+static struct task_struct *pick_task_stop(struct rq *rq)
 {
 	if (!sched_stop_runnable(rq))
 		return NULL;
 
-	set_next_task_stop(rq, rq->stop, true);
 	return rq->stop;
 }
 
+static struct task_struct *pick_next_task_stop(struct rq *rq)
+{
+	struct task_struct *p = pick_task_stop(rq);
+
+	if (p)
+		set_next_task_stop(rq, p, true);
+
+	return p;
+}
+
 static void
 enqueue_task_stop(struct rq *rq, struct task_struct *p, int flags)
 {
@@ -123,6 +132,7 @@ DEFINE_SCHED_CLASS(stop) = {
 
 #ifdef CONFIG_SMP
 	.balance		= balance_stop,
+	.pick_task		= pick_task_stop,
 	.select_task_rq		= select_task_rq_stop,
 	.set_cpus_allowed	= set_cpus_allowed_common,
 #endif



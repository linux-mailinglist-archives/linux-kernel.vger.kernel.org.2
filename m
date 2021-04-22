Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D1D3680A7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbhDVMjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236392AbhDVMiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:38:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3912DC06138E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 05:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=bSgsxIb478eiV+qIDajoPxU1Jc9TIX4P9BTttgq1sN8=; b=NdgYFan1l8/2D1fCOAhG/86DIq
        jHSPTG00NAqgbVIn9zoRPMosbatIIWQHuVmEFZMOmw/97PbPJRJGSvi8SriFO3GIJ4/GyySJkUdP+
        RCNF5p6iLRioizLoXZCeLWTUj4k7sBGcjjz18msow+rAZhlklkKDEYNQmS6WP5TE01fvO4zjh79cb
        qg+RyKPUkBwdgfNWtAaVdxzzFTbYzJVbAkv2qAL6O5u5huh+NDwPRjBooSpoiWtjUhIwGkD8p/TvS
        gvGbRq1k0+LOiXea5dcKAr9UlWL98zNZQ+Vv5GRyTeyvL6TfLavOfITEXnpfZiJH34NF077qT29Lv
        47e2kfIw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZYZM-000IDa-SP; Thu, 22 Apr 2021 12:36:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7D069300326;
        Thu, 22 Apr 2021 14:35:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 70C2C2C67A905; Thu, 22 Apr 2021 14:35:20 +0200 (CEST)
Message-ID: <20210422123308.919768100@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 22 Apr 2021 14:05:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de
Subject: [PATCH 16/19] sched: Trivial core scheduling cookie management
References: <20210422120459.447350175@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to not have to use pid_struct, create a new, smaller,
structure to manage task cookies for core scheduling.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h     |    6 ++
 kernel/fork.c             |    1 
 kernel/sched/Makefile     |    1 
 kernel/sched/core.c       |    7 +-
 kernel/sched/core_sched.c |  109 ++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h      |   16 ++++++
 6 files changed, 137 insertions(+), 3 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2170,4 +2170,10 @@ int sched_trace_rq_nr_running(struct rq
 
 const struct cpumask *sched_trace_rd_span(struct root_domain *rd);
 
+#ifdef CONFIG_SCHED_CORE
+extern void sched_core_free(struct task_struct *tsk);
+#else
+static inline void sched_core_free(struct task_struct *tsk) { }
+#endif
+
 #endif
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -737,6 +737,7 @@ void __put_task_struct(struct task_struc
 	exit_creds(tsk);
 	delayacct_tsk_free(tsk);
 	put_signal_struct(tsk->signal);
+	sched_core_free(tsk);
 
 	if (!profile_handoff_task(tsk))
 		free_task(tsk);
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -36,3 +36,4 @@ obj-$(CONFIG_CPU_FREQ_GOV_SCHEDUTIL) +=
 obj-$(CONFIG_MEMBARRIER) += membarrier.o
 obj-$(CONFIG_CPU_ISOLATION) += isolation.o
 obj-$(CONFIG_PSI) += psi.o
+obj-$(CONFIG_SCHED_CORE) += core_sched.o
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -157,7 +157,7 @@ static inline int rb_sched_core_cmp(cons
 	return 0;
 }
 
-static void sched_core_enqueue(struct rq *rq, struct task_struct *p)
+void sched_core_enqueue(struct rq *rq, struct task_struct *p)
 {
 	rq->core->core_task_seq++;
 
@@ -167,14 +167,15 @@ static void sched_core_enqueue(struct rq
 	rb_add(&p->core_node, &rq->core_tree, rb_sched_core_less);
 }
 
-static void sched_core_dequeue(struct rq *rq, struct task_struct *p)
+void sched_core_dequeue(struct rq *rq, struct task_struct *p)
 {
 	rq->core->core_task_seq++;
 
-	if (!p->core_cookie)
+	if (!sched_core_enqueued(p))
 		return;
 
 	rb_erase(&p->core_node, &rq->core_tree);
+	RB_CLEAR_NODE(&p->core_node);
 }
 
 /*
--- /dev/null
+++ b/kernel/sched/core_sched.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "sched.h"
+
+/*
+ * A simple wrapper around refcount. An allocated sched_core_cookie's
+ * address is used to compute the cookie of the task.
+ */
+struct sched_core_cookie {
+	refcount_t refcnt;
+};
+
+unsigned long sched_core_alloc_cookie(void)
+{
+	struct sched_core_cookie *ck = kmalloc(sizeof(*ck), GFP_KERNEL);
+	if (!ck)
+		return 0;
+
+	refcount_set(&ck->refcnt, 1);
+	sched_core_get();
+
+	return (unsigned long)ck;
+}
+
+void sched_core_put_cookie(unsigned long cookie)
+{
+	struct sched_core_cookie *ptr = (void *)cookie;
+
+	if (ptr && refcount_dec_and_test(&ptr->refcnt)) {
+		kfree(ptr);
+		sched_core_put();
+	}
+}
+
+unsigned long sched_core_get_cookie(unsigned long cookie)
+{
+	struct sched_core_cookie *ptr = (void *)cookie;
+
+	if (ptr)
+		refcount_inc(&ptr->refcnt);
+
+	return cookie;
+}
+
+/*
+ * sched_core_update_cookie - replace the cookie on a task
+ * @p: the task to update
+ * @cookie: the new cookie
+ *
+ * Effectively exchange the task cookie; caller is responsible for lifetimes on
+ * both ends.
+ *
+ * Returns: the old cookie
+ */
+unsigned long sched_core_update_cookie(struct task_struct *p, unsigned long cookie)
+{
+	unsigned long old_cookie;
+	struct rq_flags rf;
+	struct rq *rq;
+	bool enqueued;
+
+	rq = task_rq_lock(p, &rf);
+
+	/*
+	 * Since creating a cookie implies sched_core_get(), and we cannot set
+	 * a cookie until after we've created it, similarly, we cannot destroy
+	 * a cookie until after we've removed it, we must have core scheduling
+	 * enabled here.
+	 */
+	SCHED_WARN_ON((p->core_cookie || cookie) && !sched_core_enabled(rq));
+
+	enqueued = sched_core_enqueued(p);
+	if (enqueued)
+		sched_core_dequeue(rq, p);
+
+	old_cookie = p->core_cookie;
+	p->core_cookie = cookie;
+
+	if (enqueued)
+		sched_core_enqueue(rq, p);
+
+	/*
+	 * If task is currently running, it may not be compatible anymore after
+	 * the cookie change, so enter the scheduler on its CPU to schedule it
+	 * away.
+	 */
+	if (task_running(rq, p))
+		resched_curr(rq);
+
+	task_rq_unlock(rq, p, &rf);
+
+	return old_cookie;
+}
+
+static unsigned long sched_core_clone_cookie(struct task_struct *p)
+{
+	unsigned long cookie, flags;
+
+	raw_spin_lock_irqsave(&p->pi_lock, flags);
+	cookie = sched_core_get_cookie(p->core_cookie);
+	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+
+	return cookie;
+}
+
+void sched_core_free(struct task_struct *p)
+{
+	sched_core_put_cookie(p->core_cookie);
+}
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1222,6 +1222,22 @@ static inline bool sched_group_cookie_ma
 
 extern void queue_core_balance(struct rq *rq);
 
+static inline bool sched_core_enqueued(struct task_struct *p)
+{
+	return !RB_EMPTY_NODE(&p->core_node);
+}
+
+extern void sched_core_enqueue(struct rq *rq, struct task_struct *p);
+extern void sched_core_dequeue(struct rq *rq, struct task_struct *p);
+
+extern void sched_core_get(void);
+extern void sched_core_put(void);
+
+extern unsigned long sched_core_alloc_cookie(void);
+extern void sched_core_put_cookie(unsigned long cookie);
+extern unsigned long sched_core_get_cookie(unsigned long cookie);
+extern unsigned long sched_core_update_cookie(struct task_struct *p, unsigned long cookie);
+
 #else /* !CONFIG_SCHED_CORE */
 
 static inline bool sched_core_enabled(struct rq *rq)



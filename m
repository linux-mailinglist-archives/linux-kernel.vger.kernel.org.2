Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43199351CC6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236240AbhDASVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbhDASBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:01:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF20C08EC23
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 06:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Pl0Jj3M8khzTjOacjxWaYoCG1jgTuWD17ppzLmFM8lg=; b=ZAOs/RuvdOXlVGx3IqKqXeamhF
        5IgXKcOmagsH7nfhtZ0ayrsEIxj4o+2c4aweuEJEv4w6JhPJ1mX97D/FUrTHW13AszkdztAJoTgor
        /Fg8kSd6PtIcMO8JODH7BxUYJUU8/MjMMOoMwSOc9RxsvlZX9Id2rZv6Sn4A13KVdefwB8UqJiten
        +Xr5hp09fdhw0I9EJvSp4VEQznwQfPffS0LRfHXaSyFO2c4Jn8yUcQ3BxFr6uHLrr2t6x51miR0TL
        FHrpIEGaci88tIsS4fB/M0zb60AvJFEoOtX+q+PmdaoBf1lxx3WN5mUXdffmJqgtp4Cjen6syoWIQ
        cS8SAABA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lRxam-006BoO-CO; Thu, 01 Apr 2021 13:42:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 08E6A3069B1;
        Thu,  1 Apr 2021 15:42:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CDCAD24C1A51F; Thu,  1 Apr 2021 15:42:29 +0200 (CEST)
Message-ID: <20210401133917.231259659@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 01 Apr 2021 15:10:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, tj@kernel.org,
        tglx@linutronix.de
Subject: [PATCH 3/9] sched: Trivial core scheduling cookie management
References: <20210401131012.395311786@infradead.org>
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
 kernel/sched/core.c       |    7 +--
 kernel/sched/core_sched.c |  106 ++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h      |   16 ++++++
 6 files changed, 134 insertions(+), 3 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2169,4 +2169,10 @@ int sched_trace_rq_nr_running(struct rq
 
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
@@ -0,0 +1,106 @@
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
+ * sched_core_update_cookie - Common helper to update a task's core cookie. This
+ * updates the selected cookie field.
+ * @p: The task whose cookie should be updated.
+ * @cookie: The new cookie.
+ * @cookie_type: The cookie field to which the cookie corresponds.
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
+	 * If task is currently running , it may not be compatible anymore after
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



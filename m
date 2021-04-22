Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F15E3680A4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbhDVMjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbhDVMh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:37:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE53C06138F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 05:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=JlRUZ1XyCJ4olyNpw0ayHZKnVHU6elGlBvK3zXCXhR0=; b=VMr1/1nE/QHRodX6KZLpYYxh47
        4aLaK9Jsqot9YbnWWG1yA6D27/QhANn7nb0fwH0r8OY8OhIws9oGYR0Qafui+C2KVAQfsKGSnx7KU
        yGl6JQRbjwhr4Y8Owzs/bZtBZ8y9OodKsItLmNZtMLN96bCoK09bic2fW29qRzAN7v8J3kUaCqTKA
        2ABn8UowNZyJdI00S7TJUFTTwXIqmT39ySkwEapVSc+U2bDXKtKnE31XLPXbM067w4qOUmdMm2uZU
        RH3yfycpVQVlc9D9nprmK+Tji72Ms6E5dUr4JNlwGBYpALLyL0sO0l+aGwVaf4WtGFuMUuY/9mw4F
        a8RVvzHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZYZ2-000ICG-GW; Thu, 22 Apr 2021 12:36:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7D085300327;
        Thu, 22 Apr 2021 14:35:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 62F122C67A903; Thu, 22 Apr 2021 14:35:20 +0200 (CEST)
Message-ID: <20210422123308.800048269@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 22 Apr 2021 14:05:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de
Subject: [PATCH 14/19] sched: Trivial forced-newidle balancer
References: <20210422120459.447350175@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a sibling is forced-idle to match the core-cookie; search for
matching tasks to fill the core.

rcu_read_unlock() can incur an infrequent deadlock in
sched_core_balance(). Fix this by using the RCU-sched flavor instead.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h |    1 
 kernel/sched/core.c   |  130 +++++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/idle.c   |    1 
 kernel/sched/sched.h  |    6 ++
 4 files changed, 137 insertions(+), 1 deletion(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -704,6 +704,7 @@ struct task_struct {
 #ifdef CONFIG_SCHED_CORE
 	struct rb_node			core_node;
 	unsigned long			core_cookie;
+	unsigned int			core_occupation;
 #endif
 
 #ifdef CONFIG_CGROUP_SCHED
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -204,6 +204,21 @@ static struct task_struct *sched_core_fi
 	return __node_2_sc(node);
 }
 
+static struct task_struct *sched_core_next(struct task_struct *p, unsigned long cookie)
+{
+	struct rb_node *node = &p->core_node;
+
+	node = rb_next(node);
+	if (!node)
+		return NULL;
+
+	p = container_of(node, struct task_struct, core_node);
+	if (p->core_cookie != cookie)
+		return NULL;
+
+	return p;
+}
+
 /*
  * Magic required such that:
  *
@@ -5371,8 +5386,8 @@ pick_next_task(struct rq *rq, struct tas
 	const struct sched_class *class;
 	const struct cpumask *smt_mask;
 	bool fi_before = false;
+	int i, j, cpu, occ = 0;
 	bool need_sync;
-	int i, j, cpu;
 
 	if (!sched_core_enabled(rq))
 		return __pick_next_task(rq, prev, rf);
@@ -5494,6 +5509,9 @@ pick_next_task(struct rq *rq, struct tas
 			if (!p)
 				continue;
 
+			if (!is_task_rq_idle(p))
+				occ++;
+
 			rq_i->core_pick = p;
 			if (rq_i->idle == p && rq_i->nr_running) {
 				rq->core->core_forceidle = true;
@@ -5525,6 +5543,7 @@ pick_next_task(struct rq *rq, struct tas
 
 						cpu_rq(j)->core_pick = NULL;
 					}
+					occ = 1;
 					goto again;
 				}
 			}
@@ -5570,6 +5589,8 @@ pick_next_task(struct rq *rq, struct tas
 		if (!(fi_before && rq->core->core_forceidle))
 			task_vruntime_update(rq_i, rq_i->core_pick, rq->core->core_forceidle);
 
+		rq_i->core_pick->core_occupation = occ;
+
 		if (i == cpu) {
 			rq_i->core_pick = NULL;
 			continue;
@@ -5591,6 +5612,113 @@ pick_next_task(struct rq *rq, struct tas
 	return next;
 }
 
+static bool try_steal_cookie(int this, int that)
+{
+	struct rq *dst = cpu_rq(this), *src = cpu_rq(that);
+	struct task_struct *p;
+	unsigned long cookie;
+	bool success = false;
+
+	local_irq_disable();
+	double_rq_lock(dst, src);
+
+	cookie = dst->core->core_cookie;
+	if (!cookie)
+		goto unlock;
+
+	if (dst->curr != dst->idle)
+		goto unlock;
+
+	p = sched_core_find(src, cookie);
+	if (p == src->idle)
+		goto unlock;
+
+	do {
+		if (p == src->core_pick || p == src->curr)
+			goto next;
+
+		if (!cpumask_test_cpu(this, &p->cpus_mask))
+			goto next;
+
+		if (p->core_occupation > dst->idle->core_occupation)
+			goto next;
+
+		p->on_rq = TASK_ON_RQ_MIGRATING;
+		deactivate_task(src, p, 0);
+		set_task_cpu(p, this);
+		activate_task(dst, p, 0);
+		p->on_rq = TASK_ON_RQ_QUEUED;
+
+		resched_curr(dst);
+
+		success = true;
+		break;
+
+next:
+		p = sched_core_next(p, cookie);
+	} while (p);
+
+unlock:
+	double_rq_unlock(dst, src);
+	local_irq_enable();
+
+	return success;
+}
+
+static bool steal_cookie_task(int cpu, struct sched_domain *sd)
+{
+	int i;
+
+	for_each_cpu_wrap(i, sched_domain_span(sd), cpu) {
+		if (i == cpu)
+			continue;
+
+		if (need_resched())
+			break;
+
+		if (try_steal_cookie(cpu, i))
+			return true;
+	}
+
+	return false;
+}
+
+static void sched_core_balance(struct rq *rq)
+{
+	struct sched_domain *sd;
+	int cpu = cpu_of(rq);
+
+	preempt_disable();
+	rcu_read_lock();
+	raw_spin_rq_unlock_irq(rq);
+	for_each_domain(cpu, sd) {
+		if (need_resched())
+			break;
+
+		if (steal_cookie_task(cpu, sd))
+			break;
+	}
+	raw_spin_rq_lock_irq(rq);
+	rcu_read_unlock();
+	preempt_enable();
+}
+
+static DEFINE_PER_CPU(struct callback_head, core_balance_head);
+
+void queue_core_balance(struct rq *rq)
+{
+	if (!sched_core_enabled(rq))
+		return;
+
+	if (!rq->core->core_cookie)
+		return;
+
+	if (!rq->nr_running) /* not forced idle */
+		return;
+
+	queue_balance_callback(rq, &per_cpu(core_balance_head, rq->cpu), sched_core_balance);
+}
+
 static inline void sched_core_cpu_starting(unsigned int cpu)
 {
 	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -437,6 +437,7 @@ static void set_next_task_idle(struct rq
 {
 	update_idle_core(rq);
 	schedstat_inc(rq->sched_goidle);
+	queue_core_balance(rq);
 }
 
 #ifdef CONFIG_SMP
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1170,6 +1170,8 @@ static inline raw_spinlock_t *__rq_lockp
 
 bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool fi);
 
+extern void queue_core_balance(struct rq *rq);
+
 #else /* !CONFIG_SCHED_CORE */
 
 static inline bool sched_core_enabled(struct rq *rq)
@@ -1187,6 +1189,10 @@ static inline raw_spinlock_t *rq_lockp(s
 	return &rq->__lock;
 }
 
+static inline void queue_core_balance(struct rq *rq)
+{
+}
+
 #endif /* CONFIG_SCHED_CORE */
 
 static inline void lockdep_assert_rq_held(struct rq *rq)



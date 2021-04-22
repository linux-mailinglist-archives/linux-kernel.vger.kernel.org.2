Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C973680AB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbhDVMj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236415AbhDVMiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:38:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394E3C061342
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 05:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=bTGaxMgJcWc6sQVgQZBpVTs56K6/LFCNCX90r6KYLMU=; b=bmdWOQe+P0rimz+/Ha7B1EuACI
        dLRV2gcRms1YecrXs2nUgraocnD/doC1Mxu2pUGgjvQoCuskiW6IIa5anRZQAu2QOl28A10/jFKwD
        5ajZmc4XiqM48Gho3UUK87V51HQ48+zICP1CPgdhUJiyEedk1+jT6pqcUg6NyuIi/0YuP8AfY7nfk
        vznACM24MW5me/cL+PYPjeiOg/HnwPGJzoI5R4CoGw0MgF2f09AKkmee7kmTKznbX2naMUHaB+pzr
        XMgVKDo/ALR6qWuhAXIoVEPiH0fNPS+pHKb4KQ6O+eel/oWtx2NLaBr6OD/leJJgtoCiqMfv5tDof
        6hFnZTcA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZYZM-000IDd-TC; Thu, 22 Apr 2021 12:36:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7D50F300328;
        Thu, 22 Apr 2021 14:35:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 69AD42C67A904; Thu, 22 Apr 2021 14:35:20 +0200 (CEST)
Message-ID: <20210422123308.860083871@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 22 Apr 2021 14:05:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, Aubrey Li <aubrey.li@linux.intel.com>
Subject: [PATCH 15/19] sched: Migration changes for core scheduling
References: <20210422120459.447350175@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aubrey Li <aubrey.li@linux.intel.com>

 - Don't migrate if there is a cookie mismatch
     Load balance tries to move task from busiest CPU to the
     destination CPU. When core scheduling is enabled, if the
     task's cookie does not match with the destination CPU's
     core cookie, this task may be skipped by this CPU. This
     mitigates the forced idle time on the destination CPU.

 - Select cookie matched idle CPU
     In the fast path of task wakeup, select the first cookie matched
     idle CPU instead of the first idle CPU.

 - Find cookie matched idlest CPU
     In the slow path of task wakeup, find the idlest CPU whose core
     cookie matches with task's cookie

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c  |   29 ++++++++++++++++----
 kernel/sched/sched.h |   73 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+), 6 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5889,11 +5889,15 @@ find_idlest_group_cpu(struct sched_group
 
 	/* Traverse only the allowed CPUs */
 	for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {
+		struct rq *rq = cpu_rq(i);
+
+		if (!sched_core_cookie_match(rq, p))
+			continue;
+
 		if (sched_idle_cpu(i))
 			return i;
 
 		if (available_idle_cpu(i)) {
-			struct rq *rq = cpu_rq(i);
 			struct cpuidle_state *idle = idle_get_state(rq);
 			if (idle && idle->exit_latency < min_exit_latency) {
 				/*
@@ -5979,9 +5983,10 @@ static inline int find_idlest_cpu(struct
 	return new_cpu;
 }
 
-static inline int __select_idle_cpu(int cpu)
+static inline int __select_idle_cpu(int cpu, struct task_struct *p)
 {
-	if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
+	if ((available_idle_cpu(cpu) || sched_idle_cpu(cpu)) &&
+	    sched_cpu_cookie_match(cpu_rq(cpu), p))
 		return cpu;
 
 	return -1;
@@ -6051,7 +6056,7 @@ static int select_idle_core(struct task_
 	int cpu;
 
 	if (!static_branch_likely(&sched_smt_present))
-		return __select_idle_cpu(core);
+		return __select_idle_cpu(core, p);
 
 	for_each_cpu(cpu, cpu_smt_mask(core)) {
 		if (!available_idle_cpu(cpu)) {
@@ -6107,7 +6112,7 @@ static inline bool test_idle_cores(int c
 
 static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
 {
-	return __select_idle_cpu(core);
+	return __select_idle_cpu(core, p);
 }
 
 static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
@@ -6164,7 +6169,7 @@ static int select_idle_cpu(struct task_s
 		} else {
 			if (!--nr)
 				return -1;
-			idle_cpu = __select_idle_cpu(cpu);
+			idle_cpu = __select_idle_cpu(cpu, p);
 			if ((unsigned int)idle_cpu < nr_cpumask_bits)
 				break;
 		}
@@ -7517,6 +7522,14 @@ static int task_hot(struct task_struct *
 
 	if (sysctl_sched_migration_cost == -1)
 		return 1;
+
+	/*
+	 * Don't migrate task if the task's cookie does not match
+	 * with the destination CPU's core cookie.
+	 */
+	if (!sched_core_cookie_match(cpu_rq(env->dst_cpu), p))
+		return 1;
+
 	if (sysctl_sched_migration_cost == 0)
 		return 0;
 
@@ -8847,6 +8860,10 @@ find_idlest_group(struct sched_domain *s
 					p->cpus_ptr))
 			continue;
 
+		/* Skip over this group if no cookie matched */
+		if (!sched_group_cookie_match(cpu_rq(this_cpu), p, group))
+			continue;
+
 		local_group = cpumask_test_cpu(this_cpu,
 					       sched_group_span(group));
 
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1134,7 +1134,9 @@ static inline bool is_migration_disabled
 #endif
 }
 
+struct sched_group;
 #ifdef CONFIG_SCHED_CORE
+static inline struct cpumask *sched_group_span(struct sched_group *sg);
 
 DECLARE_STATIC_KEY_FALSE(__sched_core_enabled);
 
@@ -1170,6 +1172,61 @@ static inline raw_spinlock_t *__rq_lockp
 
 bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool fi);
 
+/*
+ * Helpers to check if the CPU's core cookie matches with the task's cookie
+ * when core scheduling is enabled.
+ * A special case is that the task's cookie always matches with CPU's core
+ * cookie if the CPU is in an idle core.
+ */
+static inline bool sched_cpu_cookie_match(struct rq *rq, struct task_struct *p)
+{
+	/* Ignore cookie match if core scheduler is not enabled on the CPU. */
+	if (!sched_core_enabled(rq))
+		return true;
+
+	return rq->core->core_cookie == p->core_cookie;
+}
+
+static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
+{
+	bool idle_core = true;
+	int cpu;
+
+	/* Ignore cookie match if core scheduler is not enabled on the CPU. */
+	if (!sched_core_enabled(rq))
+		return true;
+
+	for_each_cpu(cpu, cpu_smt_mask(cpu_of(rq))) {
+		if (!available_idle_cpu(cpu)) {
+			idle_core = false;
+			break;
+		}
+	}
+
+	/*
+	 * A CPU in an idle core is always the best choice for tasks with
+	 * cookies.
+	 */
+	return idle_core || rq->core->core_cookie == p->core_cookie;
+}
+
+static inline bool sched_group_cookie_match(struct rq *rq,
+					    struct task_struct *p,
+					    struct sched_group *group)
+{
+	int cpu;
+
+	/* Ignore cookie match if core scheduler is not enabled on the CPU. */
+	if (!sched_core_enabled(rq))
+		return true;
+
+	for_each_cpu_and(cpu, sched_group_span(group), p->cpus_ptr) {
+		if (sched_core_cookie_match(rq, p))
+			return true;
+	}
+	return false;
+}
+
 extern void queue_core_balance(struct rq *rq);
 
 #else /* !CONFIG_SCHED_CORE */
@@ -1193,6 +1250,22 @@ static inline void queue_core_balance(st
 {
 }
 
+static inline bool sched_cpu_cookie_match(struct rq *rq, struct task_struct *p)
+{
+	return true;
+}
+
+static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
+{
+	return true;
+}
+
+static inline bool sched_group_cookie_match(struct rq *rq,
+					    struct task_struct *p,
+					    struct sched_group *group)
+{
+	return true;
+}
 #endif /* CONFIG_SCHED_CORE */
 
 static inline void lockdep_assert_rq_held(struct rq *rq)



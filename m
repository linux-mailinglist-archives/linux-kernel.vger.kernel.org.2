Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CFA3680A3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbhDVMjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236120AbhDVMh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:37:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD7BC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 05:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=PpXnsI2MXUkOLecT/M4Dce/Yx9QxNWp6ceoPcHW6P/U=; b=rcYbbLxcboJigA08X3s/YJbg3C
        Z/qQL/lcTm1NZuRZx8FsONhdtmIRLY6L/j3uChozY9GrPOY3q4qzbkQNEw621A3WM2G3gpb1fX8kH
        EMKjOQ+zLDMVkRZLGH7Nisia1TOEjcMMPhzDKAa9KAtno/ibSls4e1x2IWiqBn00oBllZJeWcgWSS
        aUpBkxs7TJYTCCECsc2aP2c+1XqLD6t1wOgYDJCUA8laJZu/cN4B3+oODLr18qVJ4VCRpDaTUhon5
        AsTSn7Z6nc0G6IThf/NcfjsAEuooeMwVl6H16t8bXi21vo0gI5EUW+1KDH4VrFkCXY9MI6dI4fFUb
        aISzAjfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZYZ2-000IC7-FD; Thu, 22 Apr 2021 12:36:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6C896300310;
        Thu, 22 Apr 2021 14:35:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4915B2C679692; Thu, 22 Apr 2021 14:35:20 +0200 (CEST)
Message-ID: <20210422123308.496975854@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 22 Apr 2021 14:05:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de
Subject: [PATCH 09/19] sched: Basic tracking of matching tasks
References: <20210422120459.447350175@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce task_struct::core_cookie as an opaque identifier for core
scheduling. When enabled; core scheduling will only allow matching
task to be on the core; where idle matches everything.

When task_struct::core_cookie is set (and core scheduling is enabled)
these tasks are indexed in a second RB-tree, first on cookie value
then on scheduling function, such that matching task selection always
finds the most elegible match.

NOTE: *shudder* at the overhead...

NOTE: *sigh*, a 3rd copy of the scheduling function; the alternative
is per class tracking of cookies and that just duplicates a lot of
stuff for no raisin (the 2nd copy lives in the rt-mutex PI code).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[Joel: folded fixes]
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h |    8 ++
 kernel/sched/core.c   |  152 ++++++++++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/fair.c   |   46 ---------------
 kernel/sched/sched.h  |   55 ++++++++++++++++++
 4 files changed, 210 insertions(+), 51 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -699,10 +699,16 @@ struct task_struct {
 	const struct sched_class	*sched_class;
 	struct sched_entity		se;
 	struct sched_rt_entity		rt;
+	struct sched_dl_entity		dl;
+
+#ifdef CONFIG_SCHED_CORE
+	struct rb_node			core_node;
+	unsigned long			core_cookie;
+#endif
+
 #ifdef CONFIG_CGROUP_SCHED
 	struct task_group		*sched_task_group;
 #endif
-	struct sched_dl_entity		dl;
 
 #ifdef CONFIG_UCLAMP_TASK
 	/*
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -88,6 +88,133 @@ __read_mostly int scheduler_running;
 
 DEFINE_STATIC_KEY_FALSE(__sched_core_enabled);
 
+/* kernel prio, less is more */
+static inline int __task_prio(struct task_struct *p)
+{
+	if (p->sched_class == &stop_sched_class) /* trumps deadline */
+		return -2;
+
+	if (rt_prio(p->prio)) /* includes deadline */
+		return p->prio; /* [-1, 99] */
+
+	if (p->sched_class == &idle_sched_class)
+		return MAX_RT_PRIO + NICE_WIDTH; /* 140 */
+
+	return MAX_RT_PRIO + MAX_NICE; /* 120, squash fair */
+}
+
+/*
+ * l(a,b)
+ * le(a,b) := !l(b,a)
+ * g(a,b)  := l(b,a)
+ * ge(a,b) := !l(a,b)
+ */
+
+/* real prio, less is less */
+static inline bool prio_less(struct task_struct *a, struct task_struct *b)
+{
+
+	int pa = __task_prio(a), pb = __task_prio(b);
+
+	if (-pa < -pb)
+		return true;
+
+	if (-pb < -pa)
+		return false;
+
+	if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
+		return !dl_time_before(a->dl.deadline, b->dl.deadline);
+
+	if (pa == MAX_RT_PRIO + MAX_NICE)  { /* fair */
+		u64 vruntime = b->se.vruntime;
+
+		/*
+		 * Normalize the vruntime if tasks are in different cpus.
+		 */
+		if (task_cpu(a) != task_cpu(b)) {
+			vruntime -= task_cfs_rq(b)->min_vruntime;
+			vruntime += task_cfs_rq(a)->min_vruntime;
+		}
+
+		return !((s64)(a->se.vruntime - vruntime) <= 0);
+	}
+
+	return false;
+}
+
+static inline bool __sched_core_less(struct task_struct *a, struct task_struct *b)
+{
+	if (a->core_cookie < b->core_cookie)
+		return true;
+
+	if (a->core_cookie > b->core_cookie)
+		return false;
+
+	/* flip prio, so high prio is leftmost */
+	if (prio_less(b, a))
+		return true;
+
+	return false;
+}
+
+#define __node_2_sc(node) rb_entry((node), struct task_struct, core_node)
+
+static inline bool rb_sched_core_less(struct rb_node *a, const struct rb_node *b)
+{
+	return __sched_core_less(__node_2_sc(a), __node_2_sc(b));
+}
+
+static inline int rb_sched_core_cmp(const void *key, const struct rb_node *node)
+{
+	const struct task_struct *p = __node_2_sc(node);
+	unsigned long cookie = (unsigned long)key;
+
+	if (cookie < p->core_cookie)
+		return -1;
+
+	if (cookie > p->core_cookie)
+		return 1;
+
+	return 0;
+}
+
+static void sched_core_enqueue(struct rq *rq, struct task_struct *p)
+{
+	rq->core->core_task_seq++;
+
+	if (!p->core_cookie)
+		return;
+
+	rb_add(&p->core_node, &rq->core_tree, rb_sched_core_less);
+}
+
+static void sched_core_dequeue(struct rq *rq, struct task_struct *p)
+{
+	rq->core->core_task_seq++;
+
+	if (!p->core_cookie)
+		return;
+
+	rb_erase(&p->core_node, &rq->core_tree);
+}
+
+/*
+ * Find left-most (aka, highest priority) task matching @cookie.
+ */
+static struct task_struct *sched_core_find(struct rq *rq, unsigned long cookie)
+{
+	struct rb_node *node;
+
+	node = rb_find_first((void *)cookie, &rq->core_tree, rb_sched_core_cmp);
+	/*
+	 * The idle task always matches any cookie!
+	 */
+	if (!node)
+		return idle_sched_class.pick_task(rq);
+
+	return __node_2_sc(node);
+}
+
 /*
  * Magic required such that:
  *
@@ -147,18 +274,24 @@ static void __sched_core_flip(bool enabl
 	cpus_read_unlock();
 }
 
-static void __sched_core_enable(void)
+static void sched_core_assert_empty(void)
 {
-	// XXX verify there are no cookie tasks (yet)
+	int cpu;
 
+	for_each_possible_cpu(cpu)
+		WARN_ON_ONCE(!RB_EMPTY_ROOT(&cpu_rq(cpu)->core_tree));
+}
+
+static void __sched_core_enable(void)
+{
 	static_branch_enable(&__sched_core_enabled);
 	__sched_core_flip(true);
+	sched_core_assert_empty();
 }
 
 static void __sched_core_disable(void)
 {
-	// XXX verify there are no cookie tasks (left)
-
+	sched_core_assert_empty();
 	__sched_core_flip(false);
 	static_branch_disable(&__sched_core_enabled);
 }
@@ -200,6 +333,11 @@ void sched_core_put(void)
 		schedule_work(&_work);
 }
 
+#else /* !CONFIG_SCHED_CORE */
+
+static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
+static inline void sched_core_dequeue(struct rq *rq, struct task_struct *p) { }
+
 #endif /* CONFIG_SCHED_CORE */
 
 /*
@@ -1779,10 +1917,16 @@ static inline void enqueue_task(struct r
 
 	uclamp_rq_inc(rq, p);
 	p->sched_class->enqueue_task(rq, p, flags);
+
+	if (sched_core_enabled(rq))
+		sched_core_enqueue(rq, p);
 }
 
 static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	if (sched_core_enabled(rq))
+		sched_core_dequeue(rq, p);
+
 	if (!(flags & DEQUEUE_NOCLOCK))
 		update_rq_clock(rq);
 
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -268,33 +268,11 @@ const struct sched_class fair_sched_clas
  */
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-static inline struct task_struct *task_of(struct sched_entity *se)
-{
-	SCHED_WARN_ON(!entity_is_task(se));
-	return container_of(se, struct task_struct, se);
-}
 
 /* Walk up scheduling entities hierarchy */
 #define for_each_sched_entity(se) \
 		for (; se; se = se->parent)
 
-static inline struct cfs_rq *task_cfs_rq(struct task_struct *p)
-{
-	return p->se.cfs_rq;
-}
-
-/* runqueue on which this entity is (to be) queued */
-static inline struct cfs_rq *cfs_rq_of(struct sched_entity *se)
-{
-	return se->cfs_rq;
-}
-
-/* runqueue "owned" by this group */
-static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
-{
-	return grp->my_q;
-}
-
 static inline void cfs_rq_tg_path(struct cfs_rq *cfs_rq, char *path, int len)
 {
 	if (!path)
@@ -455,33 +433,9 @@ find_matching_se(struct sched_entity **s
 
 #else	/* !CONFIG_FAIR_GROUP_SCHED */
 
-static inline struct task_struct *task_of(struct sched_entity *se)
-{
-	return container_of(se, struct task_struct, se);
-}
-
 #define for_each_sched_entity(se) \
 		for (; se; se = NULL)
 
-static inline struct cfs_rq *task_cfs_rq(struct task_struct *p)
-{
-	return &task_rq(p)->cfs;
-}
-
-static inline struct cfs_rq *cfs_rq_of(struct sched_entity *se)
-{
-	struct task_struct *p = task_of(se);
-	struct rq *rq = task_rq(p);
-
-	return &rq->cfs;
-}
-
-/* runqueue "owned" by this group */
-static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
-{
-	return NULL;
-}
-
 static inline void cfs_rq_tg_path(struct cfs_rq *cfs_rq, char *path, int len)
 {
 	if (path)
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1080,6 +1080,10 @@ struct rq {
 	/* per rq */
 	struct rq		*core;
 	unsigned int		core_enabled;
+	struct rb_root		core_tree;
+
+	/* shared state */
+	unsigned int		core_task_seq;
 #endif
 };
 
@@ -1238,6 +1242,57 @@ DECLARE_PER_CPU_SHARED_ALIGNED(struct rq
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define raw_rq()		raw_cpu_ptr(&runqueues)
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+static inline struct task_struct *task_of(struct sched_entity *se)
+{
+	SCHED_WARN_ON(!entity_is_task(se));
+	return container_of(se, struct task_struct, se);
+}
+
+static inline struct cfs_rq *task_cfs_rq(struct task_struct *p)
+{
+	return p->se.cfs_rq;
+}
+
+/* runqueue on which this entity is (to be) queued */
+static inline struct cfs_rq *cfs_rq_of(struct sched_entity *se)
+{
+	return se->cfs_rq;
+}
+
+/* runqueue "owned" by this group */
+static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
+{
+	return grp->my_q;
+}
+
+#else
+
+static inline struct task_struct *task_of(struct sched_entity *se)
+{
+	return container_of(se, struct task_struct, se);
+}
+
+static inline struct cfs_rq *task_cfs_rq(struct task_struct *p)
+{
+	return &task_rq(p)->cfs;
+}
+
+static inline struct cfs_rq *cfs_rq_of(struct sched_entity *se)
+{
+	struct task_struct *p = task_of(se);
+	struct rq *rq = task_rq(p);
+
+	return &rq->cfs;
+}
+
+/* runqueue "owned" by this group */
+static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
+{
+	return NULL;
+}
+#endif
+
 extern void update_rq_clock(struct rq *rq);
 
 static inline u64 __rq_clock_broken(struct rq *rq)



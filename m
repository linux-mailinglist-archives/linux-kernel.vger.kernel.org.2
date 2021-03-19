Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92EB3426F2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 21:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhCSUde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 16:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhCSUdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 16:33:04 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB59FC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 13:33:03 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id x9so7800844qto.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 13:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KEJYPN8X4PfWyamY+PvccsD9sFtJ7oR/LD8upAFGp4o=;
        b=ZsPHAKJnpXw7KfX1FGK0JFOjeOD5aCrugEqzZLQGFLxdmBHsxk8TCFt25xbmvdPmJd
         RO2r2B/gO+zKSZziz8Qc4DQZrF6TdMRmzj+8bPVql1Cy3KOKq0i28Ndg2Yseob0schtB
         XHPt9SsBUtz9v4E2WPifI8TfYPZbF0OlT4C8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KEJYPN8X4PfWyamY+PvccsD9sFtJ7oR/LD8upAFGp4o=;
        b=MNzRhnInjoW27xDkCmuKkiNaTNJjrgJZSGt5MYcSvVfznyxNqnhcyXevM8op3hBP9s
         /Vj8xJvE+4IyhG8lijVtgaAx10v7XRZGjbYOEhasXO+cL3rzMf/3W7rktlfXo1mtkBam
         oJjb7W3I1eSqwtxuwZrSaYmcZSUyjlvo5kL7WLEMh/oDF4Tz2jZxBQLL/uzZP4/ZBzpJ
         jmeRiHGDlgBQtr62TtVi7b642GydZcKj9c2G79/yutnAp6960NKraP/yJAhD0jN9pcgz
         gHsrl71UHvfOok8teEZ8kaMW4CkYoElvHwSGb2hXYy7qarD7MaJRxKIN2J/MsTcEZwvB
         1eNg==
X-Gm-Message-State: AOAM530InS+JQFEMl0I9sOG5gDbX+vync/By83h61YV/XgBoFbzf0VLK
        BezEVOkKV6YDSGX1hcTBrhRI+A==
X-Google-Smtp-Source: ABdhPJy5EAZaDqHyj5fvDpUsbscStQrb/QB7BSyAZqGMSovhToMbz4gr8Wbng6+FM7Ockfangel9xA==
X-Received: by 2002:ac8:5c07:: with SMTP id i7mr456204qti.322.1616185982990;
        Fri, 19 Mar 2021 13:33:02 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:7422:5a6f:e616:23c9])
        by smtp.gmail.com with ESMTPSA id j26sm4588187qtp.30.2021.03.19.13.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 13:33:02 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        fweisbec@gmail.com, keescook@chromium.org,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>, chris.hyser@oracle.com,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH 2/6] sched: tagging interface for core scheduling
Date:   Fri, 19 Mar 2021 16:32:49 -0400
Message-Id: <20210319203253.3352417-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210319203253.3352417-1-joel@joelfernandes.org>
References: <20210319203253.3352417-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Don <joshdon@google.com>

Adds per-task and per-cgroup interfaces for specifying which tasks can
co-execute on adjacent SMT hyperthreads via core scheduling.

The per-task interface hooks are implemented here, but are not currently
used. The following patch adds a prctl interface which then takes
advantage of these.

The cgroup interface can be used to toggle a unique cookie value for all
descendent tasks, preventing these tasks from sharing with any others.
See Documentation/admin-guide/hw-vuln/core-scheduling.rst for a full
rundown.

One important property of this interface is that neither the per-task
nor the per-cgroup setting overrides the other. For example, if two
tasks are in different cgroups, and one or both of the cgroups is tagged
using the per-cgroup interface, then these tasks cannot share, even if
they use the per-task interface to attempt to share with one another.

The above is implemented by making the overall core scheduling cookie a
compound structure, containing both a task-level cookie and a
group-level cookie. Two tasks will only be allowed to share if all
fields of their respective cookies match.

Core scheduler has extra overhead.  Enable it only for machines with
more than one SMT hardware thread.

Co-developed-by: Chris Hyser <chris.hyser@oracle.com>
Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Vineeth Remanan Pillai <viremana@linux.microsoft.com>
Signed-off-by: Josh Don <joshdon@google.com>
---
 include/linux/sched.h  |  20 ++-
 kernel/fork.c          |   1 +
 kernel/sched/Makefile  |   1 +
 kernel/sched/core.c    | 172 +++++++++++++-----
 kernel/sched/coretag.c | 397 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/debug.c   |   4 +
 kernel/sched/sched.h   |  85 +++++++--
 7 files changed, 619 insertions(+), 61 deletions(-)
 create mode 100644 kernel/sched/coretag.c

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 344432130b8f..9031aa8fee5b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -629,6 +629,20 @@ struct wake_q_node {
 	struct wake_q_node *next;
 };
 
+#ifdef CONFIG_SCHED_CORE
+struct sched_core_cookie {
+	unsigned long task_cookie;
+	unsigned long group_cookie;
+
+	/* A u64 representation of the cookie used only for display to
+	 * userspace. We avoid exposing the actual cookie contents, which
+	 * are kernel pointers.
+	 */
+	u64 userspace_id;
+};
+#endif
+
+
 struct task_struct {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/*
@@ -687,7 +701,7 @@ struct task_struct {
 
 #ifdef CONFIG_SCHED_CORE
 	struct rb_node			core_node;
-	unsigned long			core_cookie;
+	struct sched_core_cookie	core_cookie;
 	unsigned int			core_occupation;
 #endif
 
@@ -2076,7 +2090,6 @@ int sched_trace_rq_nr_running(struct rq *rq);
 
 const struct cpumask *sched_trace_rd_span(struct root_domain *rd);
 
-#ifdef CONFIG_SCHED_CORE
 enum ht_protect_ctx {
 	HT_PROTECT_SYSCALL,
 	HT_PROTECT_IRQ,
@@ -2084,15 +2097,18 @@ enum ht_protect_ctx {
 	HT_PROTECT_FROM_IDLE
 };
 
+#ifdef CONFIG_SCHED_CORE
 void sched_core_unsafe_enter(enum ht_protect_ctx ctx);
 void sched_core_unsafe_exit(enum ht_protect_ctx ctx);
 bool sched_core_wait_till_safe(unsigned long ti_check);
 bool sched_core_kernel_protected(enum ht_protect_ctx ctx);
+void sched_tsk_free(struct task_struct *tsk);
 #else
 #define sched_core_unsafe_enter(ignore) do { } while (0)
 #define sched_core_unsafe_exit(ignore) do { } while (0)
 #define sched_core_wait_till_safe(ignore) do { } while (0)
 #define sched_core_kernel_protected(ignore) do { } while (0)
+#define sched_tsk_free(tsk) do { } while (0)
 #endif
 
 #endif
diff --git a/kernel/fork.c b/kernel/fork.c
index 7199d359690c..5468c93829c5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -736,6 +736,7 @@ void __put_task_struct(struct task_struct *tsk)
 	exit_creds(tsk);
 	delayacct_tsk_free(tsk);
 	put_signal_struct(tsk->signal);
+	sched_tsk_free(tsk);
 
 	if (!profile_handoff_task(tsk))
 		free_task(tsk);
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 5fc9c9b70862..c526c20adf9d 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -36,3 +36,4 @@ obj-$(CONFIG_CPU_FREQ_GOV_SCHEDUTIL) += cpufreq_schedutil.o
 obj-$(CONFIG_MEMBARRIER) += membarrier.o
 obj-$(CONFIG_CPU_ISOLATION) += isolation.o
 obj-$(CONFIG_PSI) += psi.o
+obj-$(CONFIG_SCHED_CORE) += coretag.o
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 073047b13126..2e3024a6f6e1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -164,11 +164,13 @@ static inline bool prio_less(struct task_struct *a, struct task_struct *b, bool
 
 static inline bool __sched_core_less(struct task_struct *a, struct task_struct *b)
 {
-	if (a->core_cookie < b->core_cookie)
-		return true;
+	int cmp = sched_core_cookie_cmp(&a->core_cookie, &b->core_cookie);
 
-	if (a->core_cookie > b->core_cookie)
-		return false;
+	if (cmp < 0)
+		return true; /* a < b */
+
+	if (cmp > 0)
+		return false; /* a > b */
 
 	/* flip prio, so high prio is leftmost */
 	if (prio_less(b, a, task_rq(a)->core->core_forceidle))
@@ -177,14 +179,19 @@ static inline bool __sched_core_less(struct task_struct *a, struct task_struct *
 	return false;
 }
 
-static void sched_core_enqueue(struct rq *rq, struct task_struct *p)
+static bool sched_core_empty(struct rq *rq)
+{
+	return RB_EMPTY_ROOT(&rq->core_tree);
+}
+
+void sched_core_enqueue(struct rq *rq, struct task_struct *p)
 {
 	struct rb_node *parent, **node;
 	struct task_struct *node_task;
 
 	rq->core->core_task_seq++;
 
-	if (!p->core_cookie)
+	if (sched_core_is_zero_cookie(&p->core_cookie))
 		return;
 
 	node = &rq->core_tree.rb_node;
@@ -204,23 +211,26 @@ static void sched_core_enqueue(struct rq *rq, struct task_struct *p)
 	rb_insert_color(&p->core_node, &rq->core_tree);
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
  * Find left-most (aka, highest priority) task matching @cookie.
  */
-static struct task_struct *sched_core_find(struct rq *rq, unsigned long cookie)
+static struct task_struct *sched_core_find(struct rq *rq,
+		struct sched_core_cookie *cookie)
 {
 	struct rb_node *node = rq->core_tree.rb_node;
 	struct task_struct *node_task, *match;
+	int cmp;
 
 	/*
 	 * The idle task always matches any cookie!
@@ -229,10 +239,11 @@ static struct task_struct *sched_core_find(struct rq *rq, unsigned long cookie)
 
 	while (node) {
 		node_task = container_of(node, struct task_struct, core_node);
+		cmp = sched_core_cookie_cmp(cookie, &node_task->core_cookie);
 
-		if (cookie < node_task->core_cookie) {
+		if (cmp < 0) {
 			node = node->rb_left;
-		} else if (cookie > node_task->core_cookie) {
+		} else if (cmp > 0) {
 			node = node->rb_right;
 		} else {
 			match = node_task;
@@ -243,7 +254,8 @@ static struct task_struct *sched_core_find(struct rq *rq, unsigned long cookie)
 	return match;
 }
 
-static struct task_struct *sched_core_next(struct task_struct *p, unsigned long cookie)
+static struct task_struct *sched_core_next(struct task_struct *p,
+		struct sched_core_cookie *cookie)
 {
 	struct rb_node *node = &p->core_node;
 
@@ -252,7 +264,7 @@ static struct task_struct *sched_core_next(struct task_struct *p, unsigned long
 		return NULL;
 
 	p = container_of(node, struct task_struct, core_node);
-	if (p->core_cookie != cookie)
+	if (sched_core_cookie_not_equal(&p->core_cookie, cookie))
 		return NULL;
 
 	return p;
@@ -275,8 +287,14 @@ static int __sched_core_stopper(void *data)
 	bool enabled = !!(unsigned long)data;
 	int cpu;
 
-	for_each_possible_cpu(cpu)
-		cpu_rq(cpu)->core_enabled = enabled;
+	for_each_possible_cpu(cpu) {
+		struct rq *rq = cpu_rq(cpu);
+
+		WARN_ON_ONCE(enabled == rq->core_enabled);
+
+		if (!enabled || (enabled && cpumask_weight(cpu_smt_mask(cpu)) >= 2))
+			rq->core_enabled = enabled;
+	}
 
 	return 0;
 }
@@ -286,7 +304,11 @@ static int sched_core_count;
 
 static void __sched_core_enable(void)
 {
-	// XXX verify there are no cookie tasks (yet)
+	int cpu;
+
+	/* verify there are no cookie tasks (yet) */
+	for_each_online_cpu(cpu)
+		BUG_ON(!sched_core_empty(cpu_rq(cpu)));
 
 	static_branch_enable(&__sched_core_enabled);
 	stop_machine(__sched_core_stopper, (void *)true, NULL);
@@ -294,8 +316,6 @@ static void __sched_core_enable(void)
 
 static void __sched_core_disable(void)
 {
-	// XXX verify there are no cookie tasks (left)
-
 	stop_machine(__sched_core_stopper, (void *)false, NULL);
 	static_branch_disable(&__sched_core_enabled);
 }
@@ -315,12 +335,6 @@ void sched_core_put(void)
 		__sched_core_disable();
 	mutex_unlock(&sched_core_mutex);
 }
-
-#else /* !CONFIG_SCHED_CORE */
-
-static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
-static inline void sched_core_dequeue(struct rq *rq, struct task_struct *p) { }
-
 #endif /* CONFIG_SCHED_CORE */
 
 /*
@@ -3923,6 +3937,7 @@ static inline void init_schedstats(void) {}
 int sched_fork(unsigned long clone_flags, struct task_struct *p)
 {
 	unsigned long flags;
+	int __maybe_unused ret;
 
 	__sched_fork(clone_flags, p);
 	/*
@@ -3998,6 +4013,13 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 #ifdef CONFIG_SMP
 	plist_node_init(&p->pushable_tasks, MAX_PRIO);
 	RB_CLEAR_NODE(&p->pushable_dl_tasks);
+#endif
+#ifdef CONFIG_SCHED_CORE
+	RB_CLEAR_NODE(&p->core_node);
+
+	ret = sched_core_fork(p, clone_flags);
+	if (ret)
+		return ret;
 #endif
 	return 0;
 }
@@ -5120,9 +5142,11 @@ static inline bool is_task_rq_idle(struct task_struct *t)
 	return (task_rq(t)->idle == t);
 }
 
-static inline bool cookie_equals(struct task_struct *a, unsigned long cookie)
+static inline bool cookie_equals(struct task_struct *a,
+				 struct sched_core_cookie *cookie)
 {
-	return is_task_rq_idle(a) || (a->core_cookie == cookie);
+	return is_task_rq_idle(a) ||
+	       sched_core_cookie_equal(&a->core_cookie, cookie);
 }
 
 static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
@@ -5130,7 +5154,7 @@ static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
 	if (is_task_rq_idle(a) || is_task_rq_idle(b))
 		return true;
 
-	return a->core_cookie == b->core_cookie;
+	return sched_core_cookie_equal(&a->core_cookie, &b->core_cookie);
 }
 
 /*
@@ -5243,7 +5267,7 @@ void sched_core_unsafe_enter(enum ht_protect_ctx ctx)
 		goto ret;
 
 	/* Ensure that on return to user/guest, we check whether to wait. */
-	if (current->core_cookie)
+	if (!sched_core_is_zero_cookie(&current->core_cookie))
 		set_tsk_thread_flag(current, TIF_UNSAFE_RET);
 
 	/* Count unsafe_enter() calls received without unsafe_exit() on this CPU. */
@@ -5288,7 +5312,7 @@ void sched_core_unsafe_enter(enum ht_protect_ctx ctx)
 		goto unlock;
 
 	/* Do nothing more if the core is not tagged. */
-	if (!rq->core->core_cookie)
+	if (sched_core_is_zero_cookie(&rq->core->core_cookie))
 		goto unlock;
 
 	for_each_cpu(i, smt_mask) {
@@ -5301,7 +5325,8 @@ void sched_core_unsafe_enter(enum ht_protect_ctx ctx)
 			continue;
 
 		/* Skip if HT is not running a tagged task. */
-		if (!srq->curr->core_cookie && !srq->core_pick)
+		if (sched_core_is_zero_cookie(&srq->curr->core_cookie) &&
+		    !srq->core_pick)
 			continue;
 
 		/*
@@ -5384,18 +5409,19 @@ static struct task_struct *
 pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *max, bool in_fi)
 {
 	struct task_struct *class_pick, *cookie_pick;
-	unsigned long cookie = rq->core->core_cookie;
+	struct sched_core_cookie *cookie = &rq->core->core_cookie;
 
 	class_pick = class->pick_task(rq);
 	if (!class_pick)
 		return NULL;
 
-	if (!cookie) {
+	if (sched_core_is_zero_cookie(cookie)) {
 		/*
 		 * If class_pick is tagged, return it only if it has
 		 * higher priority than max.
 		 */
-		if (max && class_pick->core_cookie &&
+		if (max &&
+		    !sched_core_is_zero_cookie(&class_pick->core_cookie) &&
 		    prio_less(class_pick, max, in_fi))
 			return idle_sched_class.pick_task(rq);
 
@@ -5477,10 +5503,10 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	put_prev_task_balance(rq, prev, rf);
 
 	smt_mask = cpu_smt_mask(cpu);
-	need_sync = !!rq->core->core_cookie;
+	need_sync = !sched_core_is_zero_cookie(&rq->core->core_cookie);
 
 	/* reset state */
-	rq->core->core_cookie = 0UL;
+	sched_core_cookie_reset(&rq->core->core_cookie);
 	if (rq->core->core_forceidle) {
 		need_sync = true;
 		fi_before = true;
@@ -5510,7 +5536,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 				break;
 		}
 
-		if (!next->core_cookie) {
+		if (sched_core_is_zero_cookie(&next->core_cookie)) {
 			rq->core_pick = NULL;
 			/*
 			 * For robustness, update the min_vruntime_fi for
@@ -5661,14 +5687,14 @@ static bool try_steal_cookie(int this, int that)
 {
 	struct rq *dst = cpu_rq(this), *src = cpu_rq(that);
 	struct task_struct *p;
-	unsigned long cookie;
+	struct sched_core_cookie *cookie;
 	bool success = false;
 
 	local_irq_disable();
 	double_rq_lock(dst, src);
 
-	cookie = dst->core->core_cookie;
-	if (!cookie)
+	cookie = &dst->core->core_cookie;
+	if (sched_core_is_zero_cookie(cookie))
 		goto unlock;
 
 	if (dst->curr != dst->idle)
@@ -5755,7 +5781,7 @@ void queue_core_balance(struct rq *rq)
 	if (!sched_core_enabled(rq))
 		return;
 
-	if (!rq->core->core_cookie)
+	if (sched_core_is_zero_cookie(&rq->core->core_cookie))
 		return;
 
 	if (!rq->nr_running) /* not forced idle */
@@ -8019,6 +8045,9 @@ void init_idle(struct task_struct *idle, int cpu)
 #ifdef CONFIG_SMP
 	sprintf(idle->comm, "%s/%d", INIT_TASK_COMM, cpu);
 #endif
+#ifdef CONFIG_SCHED_CORE
+	RB_CLEAR_NODE(&idle->core_node);
+#endif
 }
 
 #ifdef CONFIG_SMP
@@ -8704,7 +8733,7 @@ void __init sched_init(void)
 		rq->core_tree = RB_ROOT;
 		rq->core_forceidle = false;
 
-		rq->core_cookie = 0UL;
+		sched_core_cookie_reset(&rq->core_cookie);
 #endif
 	}
 
@@ -8972,6 +9001,8 @@ struct task_group *sched_create_group(struct task_group *parent)
 
 	alloc_uclamp_sched_group(tg, parent);
 
+	alloc_sched_core_sched_group(tg);
+
 	return tg;
 
 err:
@@ -9035,6 +9066,11 @@ static void sched_change_group(struct task_struct *tsk, int type)
 	tg = container_of(task_css_check(tsk, cpu_cgrp_id, true),
 			  struct task_group, css);
 	tg = autogroup_task_group(tsk, tg);
+
+#ifdef CONFIG_SCHED_CORE
+	sched_core_change_group(tsk, tg);
+#endif
+
 	tsk->sched_task_group = tg;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -9087,11 +9123,6 @@ void sched_move_task(struct task_struct *tsk)
 	task_rq_unlock(rq, tsk, &rf);
 }
 
-static inline struct task_group *css_tg(struct cgroup_subsys_state *css)
-{
-	return css ? container_of(css, struct task_group, css) : NULL;
-}
-
 static struct cgroup_subsys_state *
 cpu_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 {
@@ -9127,6 +9158,18 @@ static int cpu_cgroup_css_online(struct cgroup_subsys_state *css)
 	return 0;
 }
 
+static void cpu_cgroup_css_offline(struct cgroup_subsys_state *css)
+{
+#ifdef CONFIG_SCHED_CORE
+	struct task_group *tg = css_tg(css);
+
+	if (tg->core_tagged) {
+		sched_core_put();
+		tg->core_tagged = 0;
+	}
+#endif
+}
+
 static void cpu_cgroup_css_released(struct cgroup_subsys_state *css)
 {
 	struct task_group *tg = css_tg(css);
@@ -9161,6 +9204,25 @@ static void cpu_cgroup_fork(struct task_struct *task)
 	task_rq_unlock(rq, task, &rf);
 }
 
+static void cpu_cgroup_exit(struct task_struct *task)
+{
+#ifdef CONFIG_SCHED_CORE
+	/*
+	 * This is possible if task exit races with core sched being
+	 * disabled due to the task's cgroup no longer being tagged, since
+	 * cpu_core_tag_write_u64() will miss dying tasks.
+	 */
+	if (unlikely(sched_core_enqueued(task))) {
+		struct rq *rq;
+		struct rq_flags rf;
+
+		rq = task_rq_lock(task, &rf);
+		sched_core_dequeue(rq, task);
+		task_rq_unlock(rq, task, &rf);
+	}
+#endif
+}
+
 static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
 {
 	struct task_struct *task;
@@ -9728,6 +9790,14 @@ static struct cftype cpu_legacy_files[] = {
 		.write_u64 = cpu_rt_period_write_uint,
 	},
 #endif
+#ifdef CONFIG_SCHED_CORE
+	{
+		.name = "core_tag",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_core_tag_read_u64,
+		.write_u64 = cpu_core_tag_write_u64,
+	},
+#endif
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 	{
 		.name = "uclamp.min",
@@ -9901,6 +9971,14 @@ static struct cftype cpu_files[] = {
 		.write_s64 = cpu_weight_nice_write_s64,
 	},
 #endif
+#ifdef CONFIG_SCHED_CORE
+	{
+		.name = "core_tag",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_core_tag_read_u64,
+		.write_u64 = cpu_core_tag_write_u64,
+	},
+#endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
 		.name = "max",
@@ -9929,10 +10007,12 @@ static struct cftype cpu_files[] = {
 struct cgroup_subsys cpu_cgrp_subsys = {
 	.css_alloc	= cpu_cgroup_css_alloc,
 	.css_online	= cpu_cgroup_css_online,
+	.css_offline	= cpu_cgroup_css_offline,
 	.css_released	= cpu_cgroup_css_released,
 	.css_free	= cpu_cgroup_css_free,
 	.css_extra_stat_show = cpu_extra_stat_show,
 	.fork		= cpu_cgroup_fork,
+	.exit		= cpu_cgroup_exit,
 	.can_attach	= cpu_cgroup_can_attach,
 	.attach		= cpu_cgroup_attach,
 	.legacy_cftypes	= cpu_legacy_files,
diff --git a/kernel/sched/coretag.c b/kernel/sched/coretag.c
new file mode 100644
index 000000000000..e391b0e7b308
--- /dev/null
+++ b/kernel/sched/coretag.c
@@ -0,0 +1,397 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * kernel/sched/coretag.c
+ *
+ * Core-scheduling tagging interface support.
+ */
+
+#include <linux/prctl.h>
+#include "sched.h"
+
+/*
+ * A simple wrapper around refcount. An allocated sched_core_task_cookie's
+ * address is used to compute the cookie of the task.
+ */
+struct sched_core_task_cookie {
+	refcount_t refcnt;
+	u32 id; /* purely for display to userspace */
+	struct work_struct work; /* to free in WQ context. */;
+};
+
+/* Protects creation and assignment of task cookies */
+static DEFINE_MUTEX(sched_core_tasks_mutex);
+
+/*
+ * Returns the following:
+ * a < b  => -1
+ * a == b => 0
+ * a > b  => 1
+ */
+int sched_core_cookie_cmp(const struct sched_core_cookie *a,
+			  const struct sched_core_cookie *b)
+{
+#define COOKIE_CMP_RETURN(field) do {		\
+	if (a->field < b->field)		\
+		return -1;			\
+	else if (a->field > b->field)		\
+		return 1;			\
+} while (0)					\
+
+	COOKIE_CMP_RETURN(task_cookie);
+	COOKIE_CMP_RETURN(group_cookie);
+
+	/* all cookie fields match */
+	return 0;
+
+#undef COOKIE_CMP_RETURN
+}
+
+inline bool sched_core_cookie_equal(const struct sched_core_cookie *a,
+				    const struct sched_core_cookie *b)
+{
+	return !sched_core_cookie_cmp(a, b);
+}
+
+inline bool sched_core_cookie_not_equal(const struct sched_core_cookie *a,
+					const struct sched_core_cookie *b)
+{
+	return !!sched_core_cookie_cmp(a, b);
+}
+
+bool sched_core_is_zero_cookie(const struct sched_core_cookie *cookie)
+{
+	static const struct sched_core_cookie zero_cookie;
+
+	return sched_core_cookie_equal(cookie, &zero_cookie);
+}
+
+inline void sched_core_cookie_reset(struct sched_core_cookie *cookie)
+{
+	memset(cookie, 0, sizeof(*cookie));
+}
+
+static void __sched_core_set_task_cookie(struct sched_core_cookie *cookie,
+					 unsigned long val)
+{
+	struct sched_core_task_cookie *task_cookie =
+		(struct sched_core_task_cookie *)val;
+	u64 task_cookie_id; /* only uses upper 32 bits */
+
+	cookie->task_cookie = val;
+
+	if (task_cookie) {
+		task_cookie_id = task_cookie->id;
+		task_cookie_id <<= 32;
+	} else {
+		task_cookie_id = 0;
+	}
+
+	/* task cookie userspace id is the upper 32 bits */
+	cookie->userspace_id &= 0xffffffff;
+	cookie->userspace_id |= task_cookie_id;
+}
+
+static void __sched_core_set_group_cookie(struct sched_core_cookie *cookie,
+					  unsigned long val)
+{
+	struct task_group *tg = (struct task_group *)val;
+	u64 group_cookie_id; /* only uses lower 32 bits */
+
+	cookie->group_cookie = val;
+
+	if (tg) {
+		group_cookie_id = tg->sched_core_id;
+	} else {
+		group_cookie_id = 0;
+	}
+
+	/* group cookie userspace id is the lower 32 bits */
+	cookie->userspace_id &= 0xffffffff00000000;
+	cookie->userspace_id |= group_cookie_id;
+}
+
+/*
+ * sched_core_update_cookie - Common helper to update a task's core cookie. This
+ * updates the selected cookie field.
+ * @p: The task whose cookie should be updated.
+ * @cookie: The new cookie.
+ * @cookie_type: The cookie field to which the cookie corresponds.
+ */
+static void sched_core_update_cookie(struct task_struct *p, unsigned long cookie,
+				     enum sched_core_cookie_type cookie_type)
+{
+	struct rq *rq;
+	struct rq_flags rf;
+
+	if (!p)
+		return;
+
+	rq = task_rq_lock(p, &rf);
+
+	/* Update cookie under task rq lock */
+	switch (cookie_type) {
+	case sched_core_task_cookie_type:
+		lockdep_assert_held(&sched_core_tasks_mutex);
+		__sched_core_set_task_cookie(&p->core_cookie, cookie);
+		break;
+	case sched_core_group_cookie_type:
+		__sched_core_set_group_cookie(&p->core_cookie, cookie);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+	}
+
+	if (sched_core_enqueued(p))
+		sched_core_dequeue(rq, p);
+
+	if (sched_core_enabled(rq) &&
+	    !sched_core_is_zero_cookie(&p->core_cookie) &&
+	    task_on_rq_queued(p))
+		sched_core_enqueue(task_rq(p), p);
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
+}
+
+#ifdef CONFIG_CGROUP_SCHED
+void alloc_sched_core_sched_group(struct task_group *tg) {
+	static u32 next_id = 1;
+
+	tg->sched_core_id = next_id++;
+	WARN_ON_ONCE(next_id == 0);
+}
+
+static unsigned long cpu_core_get_group_cookie(struct task_group *tg);
+
+void sched_core_change_group(struct task_struct *p, struct task_group *new_tg)
+{
+	lockdep_assert_held(rq_lockp(task_rq(p)));
+
+	/*
+	 * Reading the group cookie can race, but since the task is already
+	 * visible in the group, a concurrent group_cookie update will also
+	 * update this task.
+	 */
+	__sched_core_set_group_cookie(&p->core_cookie,
+			cpu_core_get_group_cookie(new_tg));
+}
+#endif
+
+static void sched_core_free_task_cookie_work(struct work_struct *ws);
+
+static unsigned long sched_core_alloc_task_cookie(void)
+{
+	struct sched_core_task_cookie *ck =
+		kmalloc(sizeof(struct sched_core_task_cookie), GFP_KERNEL);
+	static u32 next_id = 1;
+
+	lockdep_assert_held(&sched_core_tasks_mutex);
+
+	if (!ck)
+		return 0;
+
+	ck->id = next_id++;
+	WARN_ON_ONCE(next_id == 0); /* warn on wrap */
+
+	refcount_set(&ck->refcnt, 1);
+	INIT_WORK(&ck->work, sched_core_free_task_cookie_work);
+
+	/* Each live task_cookie is associated with a single sched_core_get() */
+	sched_core_get();
+
+	return (unsigned long)ck;
+}
+
+static void sched_core_get_task_cookie(unsigned long cookie)
+{
+	struct sched_core_task_cookie *ptr =
+		(struct sched_core_task_cookie *)cookie;
+
+	refcount_inc(&ptr->refcnt);
+}
+
+/* Called when the cookie's refcnt drops to 0. */
+static void __sched_core_free_task_cookie(struct sched_core_task_cookie *cookie)
+{
+	kfree(cookie);
+	sched_core_put();
+}
+
+static void sched_core_free_task_cookie_work(struct work_struct *ws)
+{
+	struct sched_core_task_cookie *ck =
+		container_of(ws, struct sched_core_task_cookie, work);
+
+	__sched_core_free_task_cookie(ck);
+}
+
+static void sched_core_put_task_cookie(unsigned long cookie)
+{
+	struct sched_core_task_cookie *ptr =
+		(struct sched_core_task_cookie *)cookie;
+
+	if (refcount_dec_and_test(&ptr->refcnt))
+		__sched_core_free_task_cookie(ptr);
+}
+
+static void sched_core_put_task_cookie_async(unsigned long cookie)
+{
+	struct sched_core_task_cookie *ptr =
+		(struct sched_core_task_cookie *)cookie;
+
+	if (refcount_dec_and_test(&ptr->refcnt))
+		queue_work(system_wq, &ptr->work);
+}
+
+static inline void sched_core_update_task_cookie(struct task_struct *t,
+						unsigned long c)
+{
+	sched_core_update_cookie(t, c, sched_core_task_cookie_type);
+}
+
+/* CGroup core-scheduling interface support. */
+#ifdef CONFIG_CGROUP_SCHED
+/*
+ * Helper to get the group cookie in a hierarchy. Any ancestor can have a
+ * cookie.
+ *
+ * Can race with an update to tg->core_tagged if sched_core_group_mutex is
+ * not held.
+ */
+static unsigned long cpu_core_get_group_cookie(struct task_group *tg)
+{
+	for (; tg; tg = tg->parent) {
+		if (READ_ONCE(tg->core_tagged))
+			return (unsigned long)tg;
+	}
+
+	return 0;
+}
+
+/* Determine if any group in @tg's children are tagged. */
+static bool cpu_core_check_descendants(struct task_group *tg, bool check_tag)
+{
+	struct task_group *child;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(child, &tg->children, siblings) {
+		if ((child->core_tagged && check_tag)) {
+			rcu_read_unlock();
+			return true;
+		}
+
+		rcu_read_unlock();
+		return cpu_core_check_descendants(child, check_tag);
+	}
+
+	rcu_read_unlock();
+	return false;
+}
+
+u64 cpu_core_tag_read_u64(struct cgroup_subsys_state *css,
+			  struct cftype *cft)
+{
+	return !!css_tg(css)->core_tagged;
+}
+
+int cpu_core_tag_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
+			   u64 val)
+{
+	static DEFINE_MUTEX(sched_core_group_mutex);
+	struct task_group *tg = css_tg(css);
+	struct cgroup_subsys_state *css_tmp;
+	struct task_struct *p;
+	unsigned long group_cookie;
+	int ret = 0;
+
+	if (val > 1)
+		return -ERANGE;
+
+	if (!static_branch_likely(&sched_smt_present))
+		return -EINVAL;
+
+	mutex_lock(&sched_core_group_mutex);
+
+	if (!tg->core_tagged && val) {
+		/* Tag is being set. Check ancestors and descendants. */
+		if (cpu_core_get_group_cookie(tg) ||
+		    cpu_core_check_descendants(tg, true /* tag */)) {
+			ret = -EBUSY;
+			goto out_unlock;
+		}
+	} else if (tg->core_tagged && !val) {
+		/* Tag is being reset. Check descendants. */
+		if (cpu_core_check_descendants(tg, true /* tag */)) {
+			ret = -EBUSY;
+			goto out_unlock;
+		}
+	} else {
+		goto out_unlock;
+	}
+
+	if (val)
+		sched_core_get();
+
+	tg->core_tagged = val;
+	group_cookie = cpu_core_get_group_cookie(tg);
+
+	rcu_read_lock();
+	css_for_each_descendant_pre(css_tmp, css) {
+		struct css_task_iter it;
+
+		css_task_iter_start(css_tmp, 0, &it);
+		/*
+		 * Note: css_task_iter_next will skip dying tasks.
+		 * There could still be dying tasks left in the core queue
+		 * when we set cgroup tag to 0 when the loop is done below.
+		 * We will handle this in cpu_cgroup_exit().
+		 */
+		while ((p = css_task_iter_next(&it))) {
+			sched_core_update_cookie(p, group_cookie,
+					sched_core_group_cookie_type);
+		}
+
+		css_task_iter_end(&it);
+	}
+	rcu_read_unlock();
+
+	if (!val)
+		sched_core_put();
+
+out_unlock:
+	mutex_unlock(&sched_core_group_mutex);
+	return ret;
+}
+#endif
+
+/*
+ * Called from sched_fork().
+ *
+ * NOTE: This might race with a concurrent cgroup cookie update. That's
+ * ok; sched_core_change_group() will handle this post-fork, once the
+ * task is visible.
+ */
+int sched_core_fork(struct task_struct *p, unsigned long clone_flags)
+{
+	/*
+	 * Task cookie is ref counted; avoid an uncounted reference.
+	 */
+	__sched_core_set_task_cookie(&p->core_cookie, 0);
+
+	return 0;
+}
+
+void sched_tsk_free(struct task_struct *tsk)
+{
+	unsigned long task_cookie = tsk->core_cookie.task_cookie;
+
+	if (task_cookie)
+		sched_core_put_task_cookie_async(task_cookie);
+}
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 60a922d3f46f..ab096b74ed31 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1024,6 +1024,10 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		__PS("clock-delta", t1-t0);
 	}
 
+#ifdef CONFIG_SCHED_CORE
+	__PS("core_cookie", p->core_cookie.userspace_id);
+#endif
+
 	sched_show_numa(p, m);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 877f77044b39..5ad494459be1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -377,6 +377,11 @@ struct cfs_bandwidth {
 struct task_group {
 	struct cgroup_subsys_state css;
 
+#ifdef CONFIG_SCHED_CORE
+	int			core_tagged;
+	u32			sched_core_id;
+#endif
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* schedulable entities of this group on each CPU */
 	struct sched_entity	**se;
@@ -425,6 +430,11 @@ struct task_group {
 
 };
 
+static inline struct task_group *css_tg(struct cgroup_subsys_state *css)
+{
+	return css ? container_of(css, struct task_group, css) : NULL;
+}
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 #define ROOT_TASK_GROUP_LOAD	NICE_0_LOAD
 
@@ -1078,12 +1088,12 @@ struct rq {
 	unsigned int		core_this_unsafe_nest;
 
 	/* shared state */
-	unsigned int		core_task_seq;
-	unsigned int		core_pick_seq;
-	unsigned long		core_cookie;
-	unsigned char		core_forceidle;
-	unsigned int		core_forceidle_seq;
-	unsigned int		core_unsafe_nest;
+	unsigned int			core_task_seq;
+	unsigned int			core_pick_seq;
+	struct sched_core_cookie	core_cookie;
+	unsigned char			core_forceidle;
+	unsigned int			core_forceidle_seq;
+	unsigned int			core_unsafe_nest;
 #endif
 };
 
@@ -1127,6 +1137,11 @@ static inline bool is_migration_disabled(struct task_struct *p)
 DECLARE_STATIC_KEY_FALSE(__sched_core_enabled);
 static inline struct cpumask *sched_group_span(struct sched_group *sg);
 
+enum sched_core_cookie_type {
+	sched_core_task_cookie_type,
+	sched_core_group_cookie_type,
+};
+
 static inline bool sched_core_enabled(struct rq *rq)
 {
 	return static_branch_unlikely(&__sched_core_enabled) && rq->core_enabled;
@@ -1142,6 +1157,16 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 
 bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool fi);
 
+int sched_core_cookie_cmp(const struct sched_core_cookie *a,
+			  const struct sched_core_cookie *b);
+bool sched_core_is_zero_cookie(const struct sched_core_cookie *cookie);
+inline bool sched_core_cookie_equal(const struct sched_core_cookie *a,
+				    const struct sched_core_cookie *b);
+inline bool sched_core_cookie_not_equal(const struct sched_core_cookie *a,
+					const struct sched_core_cookie *b);
+inline void sched_core_cookie_reset(struct sched_core_cookie *cookie);
+
+
 /*
  * Helpers to check if the CPU's core cookie matches with the task's cookie
  * when core scheduling is enabled.
@@ -1154,7 +1179,7 @@ static inline bool sched_cpu_cookie_match(struct rq *rq, struct task_struct *p)
 	if (!sched_core_enabled(rq))
 		return true;
 
-	return rq->core->core_cookie == p->core_cookie;
+	return sched_core_cookie_equal(&rq->core->core_cookie, &p->core_cookie);
 }
 
 static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
@@ -1177,7 +1202,8 @@ static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
 	 * A CPU in an idle core is always the best choice for tasks with
 	 * cookies.
 	 */
-	return idle_core || rq->core->core_cookie == p->core_cookie;
+	return idle_core ||
+	       sched_core_cookie_equal(&rq->core->core_cookie, &p->core_cookie);
 }
 
 static inline bool sched_group_cookie_match(struct rq *rq,
@@ -1197,12 +1223,44 @@ static inline bool sched_group_cookie_match(struct rq *rq,
 	return false;
 }
 
-extern void queue_core_balance(struct rq *rq);
+void sched_core_change_group(struct task_struct *p, struct task_group *new_tg);
+int sched_core_fork(struct task_struct *p, unsigned long clone_flags);
+
+static inline bool sched_core_enqueued(struct task_struct *task)
+{
+	return !RB_EMPTY_NODE(&task->core_node);
+}
+
+void queue_core_balance(struct rq *rq);
+
+void sched_core_enqueue(struct rq *rq, struct task_struct *p);
+void sched_core_dequeue(struct rq *rq, struct task_struct *p);
+void sched_core_get(void);
+void sched_core_put(void);
+
+#ifdef CONFIG_CGROUP_SCHED
+u64 cpu_core_tag_read_u64(struct cgroup_subsys_state *css,
+			  struct cftype *cft);
+
+int cpu_core_tag_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
+			   u64 val);
+
+void alloc_sched_core_sched_group(struct task_group *tg);
+#endif
+
+#ifndef TIF_UNSAFE_RET
+#define TIF_UNSAFE_RET (0)
+#define _TIF_UNSAFE_RET (0)
+#endif
 
 bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool fi);
 
 #else /* !CONFIG_SCHED_CORE */
 
+static inline bool sched_core_enqueued(struct task_struct *task) { return false; }
+static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
+static inline void sched_core_dequeue(struct rq *rq, struct task_struct *p) { }
+
 static inline bool sched_core_enabled(struct rq *rq)
 {
 	return false;
@@ -1233,6 +1291,11 @@ static inline bool sched_group_cookie_match(struct rq *rq,
 {
 	return true;
 }
+
+#ifdef CONFIG_CGROUP_SCHED
+void alloc_sched_core_sched_group(struct task_group *tg) {}
+#endif
+
 #endif /* CONFIG_SCHED_CORE */
 
 #ifdef CONFIG_SCHED_SMT
@@ -2899,8 +2962,4 @@ void swake_up_all_locked(struct swait_queue_head *q);
 void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
 
 #ifdef CONFIG_SCHED_CORE
-#ifndef TIF_UNSAFE_RET
-#define TIF_UNSAFE_RET (0)
-#define _TIF_UNSAFE_RET (0)
-#endif
 #endif
-- 
2.31.0.rc2.261.g7f71774620-goog


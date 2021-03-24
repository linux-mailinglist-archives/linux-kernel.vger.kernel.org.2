Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E72B3483E0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 22:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238522AbhCXVkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 17:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhCXVkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 17:40:32 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DB8C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:40:31 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id z10so19661741qkz.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fc7+nWufKrYJthSa8s+aXCH1dq5ySltq0VcbRXJPkdo=;
        b=wG4KlcQgmkXGtFah1LAiTG/h+z5ctJ3jxw60cxyrUUIIcVkH0Ehhk4Lpsgoo3A9PWe
         su0awXcM0bqR5+ipW5mcyzstqPsdi+tPZjV6rv2agXzy0mSFr6O+jHUMnAvQL0E1BRyV
         t51mX7BprCcJjkZ19e+LLjhLISHtWVReLk7t4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fc7+nWufKrYJthSa8s+aXCH1dq5ySltq0VcbRXJPkdo=;
        b=QDAH6gO/e3hAgh6xTATs6vG7VaFEIsrEi5TpyChfxpEoA9uZGF8MyChEA1SlE1Fv2m
         qw43k0pRngxYmymo+e/TEWYr3xMbxupKfDfHpa1gR76mGsO3rD7sAQKfHjieuTmocJOC
         FIvzHLP6hUa6wwZR6G3g99+ucGMuPWWlmHf6qly4Iu6CPhmhhO+Nct9w3nsa3xHXlkMq
         3TWO90L4cJZpcsq9sbBNy07jS/ajzb+IfyZziAiBrLskKgf+8zjV9/1njuEHgCGxyJ/1
         suDAOCQJzz7rzF2NO7N3DbkbFK3fajiGTtRofSTyXu3hQepUp4KLyH9/T/Wtvcd1ynzn
         I4SQ==
X-Gm-Message-State: AOAM531+81hxb3zIpIv5BvHh7874nlJz43L+qUrDULB6U4A3hMzT8aYW
        9kTlmPX85zTmNdIzV5Ln4xo++w==
X-Google-Smtp-Source: ABdhPJw/4kvbuBskAm+A883DnhRP4u9ft/0II/sMg8E56RmHARW3RN9RdalYFUEoIHQUfd6OCV2cHw==
X-Received: by 2002:a37:dcb:: with SMTP id 194mr5447014qkn.4.1616622030496;
        Wed, 24 Mar 2021 14:40:30 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:3177:30e:b1de:1fb4])
        by smtp.gmail.com with ESMTPSA id h75sm2661107qke.80.2021.03.24.14.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 14:40:30 -0700 (PDT)
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
        Tom Lendacky <thomas.lendacky@amd.com>, dhiatt@digitalocean.com
Subject: [PATCH resend 2/8] sched: core scheduling tagging infrastructure
Date:   Wed, 24 Mar 2021 17:40:14 -0400
Message-Id: <20210324214020.34142-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210324214020.34142-1-joel@joelfernandes.org>
References: <20210324214020.34142-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Don <joshdon@google.com>

A single unsigned long is insufficient as a cookie value for core
scheduling. We will minimally have cookie values for a per-task and a
per-group interface, which must be combined into an overall cookie.

This patch adds the infrastructure necessary for setting task and group
cookie. Namely, it reworks the core_cookie into a struct, and provides
interfaces for setting task and group cookie, as well as other
operations (i.e. compare()). Subsequent patches will use these hooks to
provide an API for setting these cookies.

One important property of this interface is that neither the per-task
nor the per-cgroup setting overrides the other. For example, if two
tasks are in different cgroups, and one or both of the cgroups is tagged
using the per-cgroup interface, then these tasks cannot share, even if
they use the per-task interface to attempt to share with one another.

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
 include/linux/sched.h  |  24 +++-
 kernel/fork.c          |   1 +
 kernel/sched/Makefile  |   1 +
 kernel/sched/core.c    | 100 ++++++++++-------
 kernel/sched/coretag.c | 245 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/debug.c   |   4 +
 kernel/sched/sched.h   |  57 ++++++++--
 7 files changed, 384 insertions(+), 48 deletions(-)
 create mode 100644 kernel/sched/coretag.c

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5d91ff1d3a30..833f8d682212 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -645,6 +645,22 @@ struct kmap_ctrl {
 #endif
 };
 
+#ifdef CONFIG_SCHED_CORE
+struct sched_core_cookie {
+	unsigned long task_cookie;
+#ifdef CONFIG_CGROUP_SCHED
+	unsigned long group_cookie;
+#endif
+
+	/*
+	 * A u64 representation of the cookie used only for display to
+	 * userspace. We avoid exposing the actual cookie contents, which
+	 * are kernel pointers.
+	 */
+	u64 userspace_id;
+};
+#endif
+
 struct task_struct {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/*
@@ -703,7 +719,7 @@ struct task_struct {
 
 #ifdef CONFIG_SCHED_CORE
 	struct rb_node			core_node;
-	unsigned long			core_cookie;
+	struct sched_core_cookie	core_cookie;
 	unsigned int			core_occupation;
 #endif
 
@@ -2166,4 +2182,10 @@ int sched_trace_rq_nr_running(struct rq *rq);
 
 const struct cpumask *sched_trace_rd_span(struct root_domain *rd);
 
+#ifdef CONFIG_SCHED_CORE
+void sched_tsk_free(struct task_struct *tsk);
+#else
+#define sched_tsk_free(tsk) do { } while (0)
+#endif
+
 #endif
diff --git a/kernel/fork.c b/kernel/fork.c
index 54cc905e5fe0..cbe461105b10 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -737,6 +737,7 @@ void __put_task_struct(struct task_struct *tsk)
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
index 53d742ed6432..1b07687c53d4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -123,11 +123,13 @@ static inline bool prio_less(struct task_struct *a, struct task_struct *b, bool
 
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
@@ -146,41 +148,49 @@ static inline bool rb_sched_core_less(struct rb_node *a, const struct rb_node *b
 static inline int rb_sched_core_cmp(const void *key, const struct rb_node *node)
 {
 	const struct task_struct *p = __node_2_sc(node);
-	unsigned long cookie = (unsigned long)key;
+	const struct sched_core_cookie *cookie = key;
+	int cmp = sched_core_cookie_cmp(cookie, &p->core_cookie);
 
-	if (cookie < p->core_cookie)
+	if (cmp < 0)
 		return -1;
 
-	if (cookie > p->core_cookie)
+	if (cmp > 0)
 		return 1;
 
 	return 0;
 }
 
-static void sched_core_enqueue(struct rq *rq, struct task_struct *p)
+static bool sched_core_empty(struct rq *rq)
+{
+	return RB_EMPTY_ROOT(&rq->core_tree);
+}
+
+void sched_core_enqueue(struct rq *rq, struct task_struct *p)
 {
 	rq->core->core_task_seq++;
 
-	if (!p->core_cookie)
+	if (sched_core_is_zero_cookie(&p->core_cookie))
 		return;
 
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
  * Find left-most (aka, highest priority) task matching @cookie.
  */
-static struct task_struct *sched_core_find(struct rq *rq, unsigned long cookie)
+static struct task_struct *sched_core_find(struct rq *rq,
+					   struct sched_core_cookie *cookie)
 {
 	struct rb_node *node;
 
@@ -194,7 +204,8 @@ static struct task_struct *sched_core_find(struct rq *rq, unsigned long cookie)
 	return __node_2_sc(node);
 }
 
-static struct task_struct *sched_core_next(struct task_struct *p, unsigned long cookie)
+static struct task_struct *sched_core_next(struct task_struct *p,
+					   struct sched_core_cookie *cookie)
 {
 	struct rb_node *node = &p->core_node;
 
@@ -203,7 +214,7 @@ static struct task_struct *sched_core_next(struct task_struct *p, unsigned long
 		return NULL;
 
 	p = container_of(node, struct task_struct, core_node);
-	if (p->core_cookie != cookie)
+	if (sched_core_cookie_not_equal(&p->core_cookie, cookie))
 		return NULL;
 
 	return p;
@@ -246,8 +257,10 @@ static void __sched_core_flip(bool enabled)
 			raw_spin_lock_nested(&cpu_rq(t)->__lock, i++);
 		}
 
-		for_each_cpu(t, smt_mask)
+		for_each_cpu(t, smt_mask) {
+			WARN_ON_ONCE(cpu_rq(t)->core_enabled == enabled);
 			cpu_rq(t)->core_enabled = enabled;
+		}
 
 		for_each_cpu(t, smt_mask)
 			raw_spin_unlock(&cpu_rq(t)->__lock);
@@ -270,7 +283,12 @@ static void __sched_core_flip(bool enabled)
 
 static void __sched_core_enable(void)
 {
-	// XXX verify there are no cookie tasks (yet)
+	int cpu;
+
+	/* verify there are no cookie tasks (yet) */
+	for_each_online_cpu(cpu) {
+		BUG_ON(!sched_core_empty(cpu_rq(cpu)));
+	}
 
 	static_branch_enable(&__sched_core_enabled);
 	__sched_core_flip(true);
@@ -278,8 +296,6 @@ static void __sched_core_enable(void)
 
 static void __sched_core_disable(void)
 {
-	// XXX verify there are no cookie tasks (left)
-
 	__sched_core_flip(false);
 	static_branch_disable(&__sched_core_enabled);
 }
@@ -299,12 +315,6 @@ void sched_core_put(void)
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
@@ -4016,6 +4026,7 @@ static inline void init_schedstats(void) {}
 int sched_fork(unsigned long clone_flags, struct task_struct *p)
 {
 	unsigned long flags;
+	int __maybe_unused ret;
 
 	__sched_fork(clone_flags, p);
 	/*
@@ -4091,6 +4102,13 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
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
@@ -5222,9 +5240,11 @@ static inline bool is_task_rq_idle(struct task_struct *t)
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
@@ -5232,7 +5252,7 @@ static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
 	if (is_task_rq_idle(a) || is_task_rq_idle(b))
 		return true;
 
-	return a->core_cookie == b->core_cookie;
+	return sched_core_cookie_equal(&a->core_cookie, &b->core_cookie);
 }
 
 // XXX fairness/fwd progress conditions
@@ -5247,18 +5267,19 @@ static struct task_struct *
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
 
@@ -5340,10 +5361,10 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
@@ -5373,7 +5394,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 				break;
 		}
 
-		if (!next->core_cookie) {
+		if (sched_core_is_zero_cookie(&next->core_cookie)) {
 			rq->core_pick = NULL;
 			/*
 			 * For robustness, update the min_vruntime_fi for
@@ -5524,14 +5545,14 @@ static bool try_steal_cookie(int this, int that)
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
@@ -5618,7 +5639,7 @@ void queue_core_balance(struct rq *rq)
 	if (!sched_core_enabled(rq))
 		return;
 
-	if (!rq->core->core_cookie)
+	if (sched_core_is_zero_cookie(&rq->core->core_cookie))
 		return;
 
 	if (!rq->nr_running) /* not forced idle */
@@ -8244,6 +8265,9 @@ void init_idle(struct task_struct *idle, int cpu)
 #ifdef CONFIG_SMP
 	sprintf(idle->comm, "%s/%d", INIT_TASK_COMM, cpu);
 #endif
+#ifdef CONFIG_SCHED_CORE
+	RB_CLEAR_NODE(&idle->core_node);
+#endif
 }
 
 #ifdef CONFIG_SMP
@@ -8995,7 +9019,7 @@ void __init sched_init(void)
 		rq->core_tree = RB_ROOT;
 		rq->core_forceidle = false;
 
-		rq->core_cookie = 0UL;
+		sched_core_cookie_reset(&rq->core_cookie);
 #endif
 	}
 
diff --git a/kernel/sched/coretag.c b/kernel/sched/coretag.c
new file mode 100644
index 000000000000..ba73569237f0
--- /dev/null
+++ b/kernel/sched/coretag.c
@@ -0,0 +1,245 @@
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
+#ifdef CONFIG_CGROUP_SCHED
+	COOKIE_CMP_RETURN(group_cookie);
+#endif
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
+	struct sched_core_task_cookie *task_cookie = (void *)val;
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
+#ifdef CONFIG_CGROUP_SCHED
+static void __sched_core_set_group_cookie(struct sched_core_cookie *cookie,
+					  unsigned long val)
+{
+	cookie->group_cookie = val;
+
+	// XXX incorporate group_cookie into userspace id
+}
+#endif
+
+/*
+ * sched_core_update_cookie - Common helper to update a task's core cookie. This
+ * updates the selected cookie field.
+ * @p: The task whose cookie should be updated.
+ * @cookie: The new cookie.
+ * @cookie_type: The cookie field to which the cookie corresponds.
+ */
+static void sched_core_update_cookie(struct task_struct *p,
+				     unsigned long cookie,
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
+#ifdef CONFIG_CGROUP_SCHED
+	case sched_core_group_cookie_type:
+		__sched_core_set_group_cookie(&p->core_cookie, cookie);
+		break;
+#endif
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
+static void sched_core_free_task_cookie_work(struct work_struct *ws);
+
+static unsigned long sched_core_alloc_task_cookie(void)
+{
+	struct sched_core_task_cookie *ck = kmalloc(sizeof(*ck), GFP_KERNEL);
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
+	struct sched_core_task_cookie *ptr = (void *)cookie;
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
+	struct sched_core_task_cookie *ptr = (void *)cookie;
+
+	if (refcount_dec_and_test(&ptr->refcnt))
+		__sched_core_free_task_cookie(ptr);
+}
+
+static void sched_core_put_task_cookie_async(unsigned long cookie)
+{
+	struct sched_core_task_cookie *ptr = (void *)cookie;
+
+	if (refcount_dec_and_test(&ptr->refcnt))
+		queue_work(system_wq, &ptr->work);
+}
+
+static inline void sched_core_update_task_cookie(struct task_struct *t,
+						 unsigned long c)
+{
+	sched_core_update_cookie(t, c, sched_core_task_cookie_type);
+}
+
+/*
+ * Called from sched_fork().
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
index 3ef9f2bca823..330d1dd8d5a6 100644
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
index 12edfb8f6994..5b49cfaa4a53 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1084,11 +1084,11 @@ struct rq {
 	struct rb_root		core_tree;
 
 	/* shared state */
-	unsigned int		core_task_seq;
-	unsigned int		core_pick_seq;
-	unsigned long		core_cookie;
-	unsigned char		core_forceidle;
-	unsigned int		core_forceidle_seq;
+	unsigned int			core_task_seq;
+	unsigned int			core_pick_seq;
+	struct sched_core_cookie	core_cookie;
+	unsigned char			core_forceidle;
+	unsigned int			core_forceidle_seq;
 #endif
 };
 
@@ -1133,6 +1133,13 @@ struct sched_group;
 DECLARE_STATIC_KEY_FALSE(__sched_core_enabled);
 static inline struct cpumask *sched_group_span(struct sched_group *sg);
 
+enum sched_core_cookie_type {
+	sched_core_task_cookie_type,
+#ifdef CONFIG_CGROUP_SCHED
+	sched_core_group_cookie_type,
+#endif
+};
+
 static inline bool sched_core_enabled(struct rq *rq)
 {
 	return static_branch_unlikely(&__sched_core_enabled) && rq->core_enabled;
@@ -1163,8 +1170,32 @@ static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
 	return &rq->__lock;
 }
 
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
@@ -1177,7 +1208,7 @@ static inline bool sched_cpu_cookie_match(struct rq *rq, struct task_struct *p)
 	if (!sched_core_enabled(rq))
 		return true;
 
-	return rq->core->core_cookie == p->core_cookie;
+	return sched_core_cookie_equal(&rq->core->core_cookie, &p->core_cookie);
 }
 
 static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
@@ -1200,7 +1231,8 @@ static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
 	 * A CPU in an idle core is always the best choice for tasks with
 	 * cookies.
 	 */
-	return idle_core || rq->core->core_cookie == p->core_cookie;
+	return idle_core ||
+	       sched_core_cookie_equal(&rq->core->core_cookie, &p->core_cookie);
 }
 
 static inline bool sched_group_cookie_match(struct rq *rq,
@@ -1220,8 +1252,6 @@ static inline bool sched_group_cookie_match(struct rq *rq,
 	return false;
 }
 
-extern void queue_core_balance(struct rq *rq);
-
 #else /* !CONFIG_SCHED_CORE */
 
 static inline bool sched_core_enabled(struct rq *rq)
@@ -1264,6 +1294,15 @@ static inline bool sched_group_cookie_match(struct rq *rq,
 {
 	return true;
 }
+
+static inline bool sched_core_enqueued(struct task_struct *task)
+{
+	return false;
+}
+
+static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
+static inline void sched_core_dequeue(struct rq *rq, struct task_struct *p) { }
+
 #endif /* CONFIG_SCHED_CORE */
 
 static inline void lockdep_assert_rq_held(struct rq *rq)
-- 
2.31.0.291.g576ba9dcdaf-goog


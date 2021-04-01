Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFA6351906
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 19:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbhDARtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbhDARj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:39:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ED4C08EC3B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 06:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=6KSRs7S4YweZ8o3DqPK161BkSZcXGT2BQw8VyK+l4QY=; b=WcPVGnm7uLqOKW7NJBHTlASNJg
        Dl62CUpquoT1duPgBzuseh5gwFxX//GKS4W0yfMzxlP4TaRGQzMcb8aikv+atG5f+89vSUTy2D0Tg
        G4p7ujxusZcanfeWaP/4uuo5VCo5kev44WvEulis2qMGFyH4EB6PSdt646TiuXrMoKI5V5cgiHs45
        bqQyOxxFLlTiAvc1nW5MxgZyFCB/WfhA4Sf31S6EzqNgwrT1Za9Y00oTLmaJ0pPzLMbIoekdkrfUh
        jfBm4Hr68rukbzf2r+xodzZ+UvTnnWh4ohaQdyCUQ/ypn6MdLfP/xQ3ceselB6dZuNYvM6WbAIRZg
        3a5MywWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lRxag-009isi-Ul; Thu, 01 Apr 2021 13:44:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3E59C307691;
        Thu,  1 Apr 2021 15:42:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E090124C1A53D; Thu,  1 Apr 2021 15:42:29 +0200 (CEST)
Message-ID: <20210401133917.469929784@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 01 Apr 2021 15:10:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, tj@kernel.org,
        tglx@linutronix.de
Subject: [PATCH 7/9] sched: Cgroup core-scheduling interface
References: <20210401131012.395311786@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a basic cgroup core-scheduling interface.

A new cpu.core_sched file is added which takes the values 0,1. When
set, the cgroup and all it's descendants will be granted the same
cookie and thus allowed to share a core with each-other, but not with
system tasks or tasks of other subtrees that might have another
cookie.

The file is hierarchical, and a subtree can again set it to 1, in
which case that subtree will get a different cookie and will no longer
share with the parent tree.

For each task, the nearest core_sched parent 'wins'.

Interaction with the prctl() interface is non-existent and left for a
future patch.

Noteably; this patch somewhat abuses cgroup_mutex. By holding
cgroup_mutex over the write() operation, which sets the cookie, the
cookie is stable in any cgroup callback (that is called with
cgroup_mutex held). A future patch relies on ss->can_attach() and
ss->attach() being 'atomic', which is hard to do without cgroup_mutex.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  |  150 +++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |    7 ++
 2 files changed, 157 insertions(+)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5688,10 +5688,53 @@ static inline void sched_core_cpu_starti
 		}
 	}
 }
+
+void sched_core_cgroup_online(struct task_group *parent, struct task_group *tg)
+{
+	lockdep_assert_held(&cgroup_mutex);
+
+	if (parent->core_parent) {
+		WARN_ON_ONCE(parent->core_cookie);
+		WARN_ON_ONCE(!parent->core_parent->core_cookie);
+		tg->core_parent = parent->core_parent;
+
+	} else if (parent->core_cookie) {
+		WARN_ON_ONCE(parent->core_parent);
+		tg->core_parent = parent;
+	}
+}
+
+void sched_core_cgroup_free(struct task_group *tg)
+{
+	sched_core_put_cookie(tg->core_cookie);
+}
+
+unsigned long sched_core_cgroup_cookie(struct task_group *tg)
+{
+	unsigned long cookie = 0;
+
+	lockdep_assert_held(&cgroup_mutex);
+
+	if (tg->core_cookie)
+		cookie = tg->core_cookie;
+	else if (tg->core_parent)
+		cookie = tg->core_parent->core_cookie;
+
+	return sched_core_get_cookie(cookie);
+}
+
 #else /* !CONFIG_SCHED_CORE */
 
 static inline void sched_core_cpu_starting(unsigned int cpu) {}
 
+static inline void sched_core_cgroup_free(struct task_group *tg) { }
+static inline void sched_core_cgroup_online(struct task_group *parent, struct task_group tg) { }
+
+static inline unsigned long sched_core_cgroup_cookie(struct task_group *tg)
+{
+	return 0;
+}
+
 static struct task_struct *
 pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
@@ -9310,6 +9353,7 @@ static void sched_free_group(struct task
 	free_fair_sched_group(tg);
 	free_rt_sched_group(tg);
 	autogroup_free(tg);
+	sched_core_cgroup_free(tg);
 	kmem_cache_free(task_group_cache, tg);
 }
 
@@ -9353,6 +9397,8 @@ void sched_online_group(struct task_grou
 	spin_unlock_irqrestore(&task_group_lock, flags);
 
 	online_fair_sched_group(tg);
+
+	sched_core_cgroup_online(parent, tg);
 }
 
 /* rcu callback to free various structures associated with a task group */
@@ -9414,6 +9460,7 @@ void sched_move_task(struct task_struct
 {
 	int queued, running, queue_flags =
 		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
+	unsigned long cookie;
 	struct rq_flags rf;
 	struct rq *rq;
 
@@ -9443,6 +9490,10 @@ void sched_move_task(struct task_struct
 	}
 
 	task_rq_unlock(rq, tsk, &rf);
+
+	cookie = sched_core_cgroup_cookie(tsk->sched_task_group);
+	cookie = sched_core_update_cookie(tsk, cookie);
+	sched_core_put_cookie(cookie);
 }
 
 static inline struct task_group *css_tg(struct cgroup_subsys_state *css)
@@ -10050,6 +10101,89 @@ static u64 cpu_rt_period_read_uint(struc
 }
 #endif /* CONFIG_RT_GROUP_SCHED */
 
+#ifdef CONFIG_SCHED_CORE
+u64 cpu_sched_core_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
+{
+	return !!css_tg(css)->core_cookie;
+}
+
+int cpu_sched_core_write_u64(struct cgroup_subsys_state *css, struct cftype *cft, u64 val)
+{
+	unsigned long cookie = 0, old_cookie = 0;
+	struct task_group *tg = css_tg(css);
+	struct cgroup_subsys_state *cssi;
+	struct task_group *parent = NULL;
+	int ret = 0;
+
+	if (val > 1)
+		return -ERANGE;
+
+	if (!static_branch_likely(&sched_smt_present))
+		return -ENODEV;
+
+	mutex_lock(&cgroup_mutex);
+	if (!!val == !!tg->core_cookie)
+		goto unlock;
+
+	old_cookie = tg->core_cookie;
+	if (val) {
+		cookie = sched_core_alloc_cookie();
+		if (!cookie) {
+			ret = -ENOMEM;
+			goto unlock;
+		}
+		WARN_ON_ONCE(old_cookie);
+
+	} else if (tg->parent) {
+		if (tg->parent->core_parent)
+			parent = tg->parent->core_parent;
+		else if (tg->parent->core_cookie)
+			parent = tg->parent;
+	}
+
+	WARN_ON_ONCE(cookie && parent);
+
+	tg->core_cookie = sched_core_get_cookie(cookie);
+	tg->core_parent = parent;
+
+	if (cookie)
+		parent = tg;
+	else if (parent)
+		cookie = sched_core_get_cookie(parent->core_cookie);
+
+	css_for_each_descendant_pre(cssi, css) {
+		struct task_group *tgi = css_tg(cssi);
+		struct css_task_iter it;
+		struct task_struct *p;
+
+		if (tgi != tg) {
+			if (tgi->core_cookie || (tgi->core_parent && tgi->core_parent != tg))
+				continue;
+
+			tgi->core_parent = parent;
+			tgi->core_cookie = 0;
+		}
+
+		css_task_iter_start(cssi, 0, &it);
+		while ((p = css_task_iter_next(&it))) {
+			unsigned long p_cookie;
+
+			cookie = sched_core_get_cookie(cookie);
+			p_cookie = sched_core_update_cookie(p, cookie);
+			sched_core_put_cookie(p_cookie);
+		}
+		css_task_iter_end(&it);
+	}
+
+unlock:
+	mutex_unlock(&cgroup_mutex);
+
+	sched_core_put_cookie(cookie);
+	sched_core_put_cookie(old_cookie);
+	return ret;
+}
+#endif
+
 static struct cftype cpu_legacy_files[] = {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	{
@@ -10100,6 +10234,14 @@ static struct cftype cpu_legacy_files[]
 		.write = cpu_uclamp_max_write,
 	},
 #endif
+#ifdef CONFIG_SCHED_CORE
+	{
+		.name = "core_sched",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_sched_core_read_u64,
+		.write_u64 = cpu_sched_core_write_u64,
+	},
+#endif
 	{ }	/* Terminate */
 };
 
@@ -10281,6 +10423,14 @@ static struct cftype cpu_files[] = {
 		.write = cpu_uclamp_max_write,
 	},
 #endif
+#ifdef CONFIG_SCHED_CORE
+	{
+		.name = "core_sched",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_sched_core_read_u64,
+		.write_u64 = cpu_sched_core_write_u64,
+	},
+#endif
 	{ }	/* terminate */
 };
 
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -431,6 +431,10 @@ struct task_group {
 	struct uclamp_se	uclamp[UCLAMP_CNT];
 #endif
 
+#ifdef CONFIG_SCHED_CORE
+	struct task_group	*core_parent;
+	unsigned long		core_cookie;
+#endif
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -1130,6 +1134,9 @@ static inline bool is_migration_disabled
 
 struct sched_group;
 #ifdef CONFIG_SCHED_CORE
+
+extern struct mutex cgroup_mutex; // XXX
+
 DECLARE_STATIC_KEY_FALSE(__sched_core_enabled);
 static inline struct cpumask *sched_group_span(struct sched_group *sg);
 



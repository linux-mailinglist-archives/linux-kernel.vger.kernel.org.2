Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69633483E2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 22:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbhCXVk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 17:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhCXVkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 17:40:35 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B45C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:40:35 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id x27so163886qvd.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TEt/Q0fyd99CjX8sufoMKgrht6eFmVFNODN9qka8JY4=;
        b=dJmRwlGAYK3+4cb4CNprt6qh4j3A3BNWh9YSM7qs/RBnDBz1OZ/XKfndsALwjnUaKn
         uai3Wbobx9OFmcKRZD2uN0dk5Y7lV7FNNoUjxQLv62WdJvErkjGPdawsc7awv/OA466D
         ZBkWe/YiktQqz45yRo89MzqYPgYfAfw7xVxKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TEt/Q0fyd99CjX8sufoMKgrht6eFmVFNODN9qka8JY4=;
        b=qqS+h25YWhC3snKDiatRe/kCCo+NPscOHi3KsvQmx3F1K9mT7nIYNUug+Y6nSkY7cF
         AdxgmWXls23TF/LmQTOD1Dvjydj1PCZQK/0HZ5Ta6GEr20G3rLxL6xwPDgRv2dDiod5Y
         piqPOimSUtaxTngYRpw1YSSldQcgoAobhxmT3lpTw/wOpqxwmL4ltfgPyZKQImnsLpF8
         TxvVpON4FwV4bKdKPgnaIqskf/KeiizM9WU6FgojsieCsqMhAWynzg0uxaqubHu+JheU
         6iZT6uz/JlSfh1xDMUyshVJppBGk42eR4lJQ9i/C7vCq4Bh8kuyjiD18rWxZ29IsGgt7
         w7yg==
X-Gm-Message-State: AOAM533huHuque3wqUxx02KyodUv4M3KlrGj6k0bSKfXSOy8Rr8sKBaE
        m4XevkhGwBmen3+91wGxEv3zQw==
X-Google-Smtp-Source: ABdhPJwngq+l2E8AX4eV5aT2yrT5tMqkDum+zXWuIZFo9EKDzHdHretvQPxMkQXl14w/5eLdXyvJKw==
X-Received: by 2002:a0c:c248:: with SMTP id w8mr5194917qvh.58.1616622034631;
        Wed, 24 Mar 2021 14:40:34 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:3177:30e:b1de:1fb4])
        by smtp.gmail.com with ESMTPSA id h75sm2661107qke.80.2021.03.24.14.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 14:40:34 -0700 (PDT)
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
Subject: [PATCH resend 5/8] sched: cgroup cookie API for core scheduling
Date:   Wed, 24 Mar 2021 17:40:17 -0400
Message-Id: <20210324214020.34142-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210324214020.34142-1-joel@joelfernandes.org>
References: <20210324214020.34142-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Don <joshdon@google.com>

This adds the API to set/get the cookie for a given cgroup. This
interface lives at cgroup/cpu.core_tag.

The cgroup interface can be used to toggle a unique cookie value for all
descendent tasks, preventing these tasks from sharing with any others.
See Documentation/admin-guide/hw-vuln/core-scheduling.rst for a full
rundown of both this and the per-task API.

Signed-off-by: Josh Don <joshdon@google.com>
---
 kernel/sched/core.c    |  61 ++++++++++++++--
 kernel/sched/coretag.c | 156 ++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h   |  25 +++++++
 3 files changed, 235 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3093cb3414c3..a733891dfe7d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9328,6 +9328,8 @@ struct task_group *sched_create_group(struct task_group *parent)
 
 	alloc_uclamp_sched_group(tg, parent);
 
+	alloc_sched_core_sched_group(tg);
+
 	return tg;
 
 err:
@@ -9391,6 +9393,11 @@ static void sched_change_group(struct task_struct *tsk, int type)
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
@@ -9443,11 +9450,6 @@ void sched_move_task(struct task_struct *tsk)
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
@@ -9483,6 +9485,18 @@ static int cpu_cgroup_css_online(struct cgroup_subsys_state *css)
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
@@ -9517,6 +9531,25 @@ static void cpu_cgroup_fork(struct task_struct *task)
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
@@ -10084,6 +10117,14 @@ static struct cftype cpu_legacy_files[] = {
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
@@ -10257,6 +10298,14 @@ static struct cftype cpu_files[] = {
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
@@ -10285,10 +10334,12 @@ static struct cftype cpu_files[] = {
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
index 550f4975eea2..1498790bc76c 100644
--- a/kernel/sched/coretag.c
+++ b/kernel/sched/coretag.c
@@ -96,9 +96,19 @@ static void __sched_core_set_task_cookie(struct sched_core_cookie *cookie,
 static void __sched_core_set_group_cookie(struct sched_core_cookie *cookie,
 					  unsigned long val)
 {
+	struct task_group *tg = (struct task_group *)val;
+	u64 group_cookie_id; /* only uses lower 32 bits */
+
 	cookie->group_cookie = val;
 
-	// XXX incorporate group_cookie into userspace id
+	if (tg)
+		group_cookie_id = tg->sched_core_id;
+	else
+		group_cookie_id = 0;
+
+	/* group cookie userspace id is the lower 32 bits */
+	cookie->userspace_id &= 0xffffffff00000000;
+	cookie->userspace_id |= group_cookie_id;
 }
 #endif
 
@@ -394,6 +404,142 @@ int sched_core_share_pid(unsigned long flags, pid_t pid, enum pid_type type)
 	return err;
 }
 
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
+						 sched_core_group_cookie_type);
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
+				      cpu_core_get_group_cookie(new_tg));
+}
+
+void alloc_sched_core_sched_group(struct task_group *tg)
+{
+	static u32 next_id = 1;
+
+	tg->sched_core_id = next_id++;
+	WARN_ON_ONCE(next_id == 0);
+}
+#endif
+
 int sched_core_exec(void)
 {
 	int ret = 0;
@@ -408,7 +554,13 @@ int sched_core_exec(void)
 	return ret;
 }
 
-/* Called from sched_fork() */
+/*
+ * Called from sched_fork().
+ *
+ * NOTE: This might race with a concurrent cgroup cookie update. That's
+ * ok; sched_core_change_group() will handle this post-fork, once the
+ * task is visible.
+ */
 int sched_core_fork(struct task_struct *p, unsigned long clone_flags)
 {
 	/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1be86d9cc58f..c3435469ea24 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -385,6 +385,11 @@ struct cfs_bandwidth {
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
@@ -433,6 +438,11 @@ struct task_group {
 
 };
 
+static inline struct task_group *css_tg(struct cgroup_subsys_state *css)
+{
+	return css ? container_of(css, struct task_group, css) : NULL;
+}
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 #define ROOT_TASK_GROUP_LOAD	NICE_0_LOAD
 
@@ -1170,6 +1180,7 @@ static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
 	return &rq->__lock;
 }
 
+void sched_core_change_group(struct task_struct *p, struct task_group *new_tg);
 int sched_core_fork(struct task_struct *p, unsigned long clone_flags);
 
 static inline bool sched_core_enqueued(struct task_struct *task)
@@ -1186,6 +1197,16 @@ void sched_core_put(void);
 
 int sched_core_share_pid(unsigned long flags, pid_t pid, enum pid_type type);
 
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
 bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool fi);
 
 int sched_core_cookie_cmp(const struct sched_core_cookie *a,
@@ -1305,6 +1326,10 @@ static inline bool sched_core_enqueued(struct task_struct *task)
 static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
 static inline void sched_core_dequeue(struct rq *rq, struct task_struct *p) { }
 
+#ifdef CONFIG_CGROUP_SCHED
+void alloc_sched_core_sched_group(struct task_group *tg) {}
+#endif
+
 #endif /* CONFIG_SCHED_CORE */
 
 static inline void lockdep_assert_rq_held(struct rq *rq)
-- 
2.31.0.291.g576ba9dcdaf-goog


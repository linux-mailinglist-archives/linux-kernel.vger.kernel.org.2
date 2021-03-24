Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741683483DE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 22:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbhCXVkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 17:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbhCXVka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 17:40:30 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48AEC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:40:29 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id g24so222072qts.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cBGxdXAidViYmqLrg+YVrWHWnEKRgbmRwrS8nWqZLGY=;
        b=nqxrEr2/oOh45LR4YWHpNFiwTr7N8MQn63KCM2LmEvf83uu5/rfvZkd6Q5XmWsJSFL
         pjxh1I30V7LPNQvTzDVofTHB3/aJeNkAYVWPW9D12CqqAgcDoBYud6PjZD45fM4oTkPt
         fJmzft3iiRr/F8tovHlCZgkbwAt5tLjbf90X8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cBGxdXAidViYmqLrg+YVrWHWnEKRgbmRwrS8nWqZLGY=;
        b=IhkZWV/7l0eX5D4grrX0FA1u/KUFn3cHU/Woyiyi/SEEXTHgXnlaSV3T5X4CI2xYZG
         tCb/mISBuGzdOWcuBysEkDzSyJTIQjGwBFeJQpZbgdPWwFg4dv5fR2MKGV2sT684GzFG
         qzPZl+7nJkkKOaRGTTSipga7olVr1Uch/yvs21WGwJSOwM7aN3wi0QdQVdFHhoCmeGhO
         o6uPKzKIoRGpj1H+nCBCQJPgGziH1IxZFUZpZir7/mzD6P7CO+qXphQu1bBcbcYzDvH3
         B2Ld93mHwW+gEGqUHm0yrgWfyqLcqaCvTgEwuGX2VToOILU61hwfTrsYaazcreQqHwVz
         EA7Q==
X-Gm-Message-State: AOAM533nRgkShJBhZOYUBmlA22Zl6J79nNUxUC8zx2MeZ4ucWL2LQ9y7
        ASicZlP7Go7jimdT7Pu3/VDUhQ==
X-Google-Smtp-Source: ABdhPJx7MBbaUt/fAuAlKk+A5whFI5ALygS2YvediOrGy+znvFfzQhb10fXMnctSE4lzGygxiVV8rQ==
X-Received: by 2002:ac8:6a04:: with SMTP id t4mr5098043qtr.258.1616622028931;
        Wed, 24 Mar 2021 14:40:28 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:3177:30e:b1de:1fb4])
        by smtp.gmail.com with ESMTPSA id h75sm2661107qke.80.2021.03.24.14.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 14:40:28 -0700 (PDT)
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
        Tom Lendacky <thomas.lendacky@amd.com>,
        dhiatt@digitalocean.com, Aubrey Li <aubrey.li@linux.intel.com>
Subject: [PATCH resend 1/8] sched: migration changes for core scheduling
Date:   Wed, 24 Mar 2021 17:40:13 -0400
Message-Id: <20210324214020.34142-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210324214020.34142-1-joel@joelfernandes.org>
References: <20210324214020.34142-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Vineeth Remanan Pillai <viremana@linux.microsoft.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/fair.c  | 29 ++++++++++++++----
 kernel/sched/sched.h | 73 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a03564398605..12030b73a032 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5877,11 +5877,15 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 
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
@@ -5967,9 +5971,10 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
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
@@ -6041,7 +6046,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 	int cpu;
 
 	if (!static_branch_likely(&sched_smt_present))
-		return __select_idle_cpu(core);
+		return __select_idle_cpu(core, p);
 
 	for_each_cpu(cpu, cpu_smt_mask(core)) {
 		if (!available_idle_cpu(cpu)) {
@@ -6079,7 +6084,7 @@ static inline bool test_idle_cores(int cpu, bool def)
 
 static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
 {
-	return __select_idle_cpu(core);
+	return __select_idle_cpu(core, p);
 }
 
 #endif /* CONFIG_SCHED_SMT */
@@ -6132,7 +6137,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 		} else {
 			if (!--nr)
 				return -1;
-			idle_cpu = __select_idle_cpu(cpu);
+			idle_cpu = __select_idle_cpu(cpu, p);
 			if ((unsigned int)idle_cpu < nr_cpumask_bits)
 				break;
 		}
@@ -7473,6 +7478,14 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
 
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
 
@@ -8834,6 +8847,10 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 					p->cpus_ptr))
 			continue;
 
+		/* Skip over this group if no cookie matched */
+		if (!sched_group_cookie_match(cpu_rq(this_cpu), p, group))
+			continue;
+
 		local_group = cpumask_test_cpu(this_cpu,
 					       sched_group_span(group));
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 80abbc0af680..12edfb8f6994 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1128,8 +1128,10 @@ static inline bool is_migration_disabled(struct task_struct *p)
 #endif
 }
 
+struct sched_group;
 #ifdef CONFIG_SCHED_CORE
 DECLARE_STATIC_KEY_FALSE(__sched_core_enabled);
+static inline struct cpumask *sched_group_span(struct sched_group *sg);
 
 static inline bool sched_core_enabled(struct rq *rq)
 {
@@ -1163,6 +1165,61 @@ static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
 
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
@@ -1191,6 +1248,22 @@ static inline void queue_core_balance(struct rq *rq)
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
-- 
2.31.0.291.g576ba9dcdaf-goog


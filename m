Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAEC34415B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 13:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhCVMdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 08:33:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:35411 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231330AbhCVMbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:31:23 -0400
IronPort-SDR: eEHvhf+z+pBSl9aHCTzFrN3rGiT0LEwdnWXWwRRqXne3AcBwDrFpo+JbKVlyl+TQXUIm07TPGf
 OgRFuf3GDH1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9930"; a="251614209"
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; 
   d="scan'208";a="251614209"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 05:31:22 -0700
IronPort-SDR: Qv4JQEGlPZDWQbLq4Ay9nrE+LAUxXHs9tp3Se0K+syJvN9j00Lu5WOUpa+WFdowTWddFzYiaUi
 VLu5LNvENwRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; 
   d="scan'208";a="441152125"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by fmsmga002.fm.intel.com with ESMTP; 22 Mar 2021 05:31:10 -0700
Subject: Re: [PATCH 1/6] sched: migration changes for core scheduling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
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
        Aubrey Li <aubrey.li@intel.com>
References: <20210319203253.3352417-1-joel@joelfernandes.org>
 <20210319203253.3352417-2-joel@joelfernandes.org>
 <20210320153457.GX4746@worktop.programming.kicks-ass.net>
 <28e13609-c526-c6ee-22a3-898652aed5e6@linux.intel.com>
 <YFhL4CMPB+Pfo965@hirez.programming.kicks-ass.net>
 <af3f6ea6-2c71-233f-fc6b-af039b004923@linux.intel.com>
 <YFhcD/jz7kC8jaXa@hirez.programming.kicks-ass.net>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <bb075bed-150c-8ea0-3035-0a8c3c98e572@linux.intel.com>
Date:   Mon, 22 Mar 2021 20:31:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YFhcD/jz7kC8jaXa@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/22 16:57, Peter Zijlstra wrote:

> 
>> Do you have any suggestions before we drop it?
> 
> Yeah, how about you make it part of task_hot() ? Have task_hot() refuse
> migration it the cookie doesn't match.
> 
> task_hot() is a hint and will get ignored when appropriate.
> 

Please let me know if I put cookie match check at the right position
in task_hot(), if so, I'll obtain some performance data of it.

Thanks,
-Aubrey

=======================================================
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7f2fb08..d4bdcf9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1912,6 +1912,13 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 		if (!cpumask_test_cpu(cpu, env->p->cpus_ptr))
 			continue;
 
+		/*
+		 * Skip this cpu if source task's cookie does not match
+		 * with CPU's core cookie.
+		 */
+		if (!sched_core_cookie_match(cpu_rq(cpu), env->p))
+			continue;
+
 		env->dst_cpu = cpu;
 		if (task_numa_compare(env, taskimp, groupimp, maymove))
 			break;
@@ -5847,11 +5854,15 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 
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
@@ -6109,7 +6120,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	for_each_cpu_wrap(cpu, cpus, target) {
 		if (!--nr)
 			return -1;
-		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
+
+		if ((available_idle_cpu(cpu) || sched_idle_cpu(cpu)) &&
+		    sched_cpu_cookie_match(cpu_rq(cpu), p))
 			break;
 	}
 
@@ -7427,6 +7440,14 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
 
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
 
@@ -8771,6 +8792,10 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 					p->cpus_ptr))
 			continue;
 
+		/* Skip over this group if no cookie matched */
+		if (!sched_group_cookie_match(cpu_rq(this_cpu), p, group))
+			continue;
+
 		local_group = cpumask_test_cpu(this_cpu,
 					       sched_group_span(group));
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f094435..13254ea 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1093,6 +1093,7 @@ static inline int cpu_of(struct rq *rq)
 
 #ifdef CONFIG_SCHED_CORE
 DECLARE_STATIC_KEY_FALSE(__sched_core_enabled);
+static inline struct cpumask *sched_group_span(struct sched_group *sg);
 
 static inline bool sched_core_enabled(struct rq *rq)
 {
@@ -1109,6 +1110,61 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 
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
 
 bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool fi);
@@ -1129,6 +1185,22 @@ static inline void queue_core_balance(struct rq *rq)
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
 
 #ifdef CONFIG_SCHED_SMT

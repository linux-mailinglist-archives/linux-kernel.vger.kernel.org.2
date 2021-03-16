Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C207933CCBF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 05:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbhCPEuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 00:50:39 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:65130 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235086AbhCPEu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 00:50:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0US53woy_1615870213;
Received: from localhost(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0US53woy_1615870213)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Mar 2021 12:50:14 +0800
From:   Huaixin Chang <changhuaixin@linux.alibaba.com>
To:     changhuaixin@linux.alibaba.com
Cc:     bsegall@google.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, khlebnikov@yandex-team.ru,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        odin@uged.al, odin@ugedal.com, pauld@redhead.com,
        peterz@infradead.org, pjt@google.com, rostedt@goodmis.org,
        shanpeic@linux.alibaba.com, tj@kernel.org,
        vincent.guittot@linaro.org, xiyou.wangcong@gmail.com
Subject: [PATCH v4 2/4] sched/fair: Make CFS bandwidth controller burstable
Date:   Tue, 16 Mar 2021 12:49:29 +0800
Message-Id: <20210316044931.39733-3-changhuaixin@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
In-Reply-To: <20210316044931.39733-1-changhuaixin@linux.alibaba.com>
References: <20210316044931.39733-1-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accumulate unused quota from previous periods, thus accumulated
bandwidth runtime can be used in the following periods. During
accumulation, take care of runtime overflow. Previous non-burstable
CFS bandwidth controller only assign quota to runtime, that saves a lot.

A sysctl parameter sysctl_sched_cfs_bw_burst_enabled is introduced as a
switch for burst. It is enabled by default.

Co-developed-by: Shanpei Chen <shanpeic@linux.alibaba.com>
Signed-off-by: Shanpei Chen <shanpeic@linux.alibaba.com>
Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
---
 include/linux/sched/sysctl.h |  1 +
 kernel/sched/core.c          |  8 +++---
 kernel/sched/fair.c          | 58 ++++++++++++++++++++++++++++++++++++++------
 kernel/sched/sched.h         |  4 +--
 kernel/sysctl.c              |  9 +++++++
 5 files changed, 66 insertions(+), 14 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 3c31ba88aca5..3cce25485c69 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -72,6 +72,7 @@ extern unsigned int sysctl_sched_uclamp_util_min_rt_default;
 
 #ifdef CONFIG_CFS_BANDWIDTH
 extern unsigned int sysctl_sched_cfs_bandwidth_slice;
+extern unsigned int sysctl_sched_cfs_bw_burst_enabled;
 #endif
 
 #ifdef CONFIG_SCHED_AUTOGROUP
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 708c31e6ce1f..16e23a2499ef 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8948,7 +8948,7 @@ static DEFINE_MUTEX(cfs_constraints_mutex);
 const u64 max_cfs_quota_period = 1 * NSEC_PER_SEC; /* 1s */
 static const u64 min_cfs_quota_period = 1 * NSEC_PER_MSEC; /* 1ms */
 /* More than 203 days if BW_SHIFT equals 20. */
-static const u64 max_cfs_runtime = MAX_BW * NSEC_PER_USEC;
+const u64 max_cfs_runtime = MAX_BW * NSEC_PER_USEC;
 
 static int __cfs_schedulable(struct task_group *tg, u64 period, u64 runtime);
 
@@ -9012,13 +9012,13 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
 	cfs_b->quota = quota;
 	cfs_b->burst = burst;
 
-	__refill_cfs_bandwidth_runtime(cfs_b);
-
 	if (runtime_enabled) {
 		cfs_b->buffer = min(max_cfs_runtime, quota + burst);
+		cfs_b->max_overrun = DIV_ROUND_UP_ULL(max_cfs_runtime, quota);
+		cfs_b->runtime = cfs_b->quota;
 
 		/* Restart the period timer (if active) to handle new period expiry: */
-		start_cfs_bandwidth(cfs_b);
+		start_cfs_bandwidth(cfs_b, 1);
 	}
 
 	raw_spin_unlock_irq(&cfs_b->lock);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 59d816a365f3..c981d4845c96 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -127,6 +127,13 @@ int __weak arch_asym_cpu_priority(int cpu)
  * (default: 5 msec, units: microseconds)
  */
 unsigned int sysctl_sched_cfs_bandwidth_slice		= 5000UL;
+
+/*
+ * A switch for cfs bandwidth burst.
+ *
+ * (default: 1, enabled)
+ */
+unsigned int sysctl_sched_cfs_bw_burst_enabled = 1;
 #endif
 
 static inline void update_load_add(struct load_weight *lw, unsigned long inc)
@@ -4602,10 +4609,23 @@ static inline u64 sched_cfs_bandwidth_slice(void)
  *
  * requires cfs_b->lock
  */
-void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
+static void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b,
+					   u64 overrun)
 {
-	if (cfs_b->quota != RUNTIME_INF)
-		cfs_b->runtime = cfs_b->quota;
+	u64 refill;
+
+	if (cfs_b->quota != RUNTIME_INF) {
+
+		if (!sysctl_sched_cfs_bw_burst_enabled) {
+			cfs_b->runtime = cfs_b->quota;
+			return;
+		}
+
+		overrun = min(overrun, cfs_b->max_overrun);
+		refill = cfs_b->quota * overrun;
+		cfs_b->runtime += refill;
+		cfs_b->runtime = min(cfs_b->runtime, cfs_b->buffer);
+	}
 }
 
 static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
@@ -4627,7 +4647,7 @@ static int __assign_cfs_rq_runtime(struct cfs_bandwidth *cfs_b,
 	if (cfs_b->quota == RUNTIME_INF)
 		amount = min_amount;
 	else {
-		start_cfs_bandwidth(cfs_b);
+		start_cfs_bandwidth(cfs_b, 0);
 
 		if (cfs_b->runtime > 0) {
 			amount = min(cfs_b->runtime, min_amount);
@@ -4973,7 +4993,7 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, u
 	if (cfs_b->idle && !throttled)
 		goto out_deactivate;
 
-	__refill_cfs_bandwidth_runtime(cfs_b);
+	__refill_cfs_bandwidth_runtime(cfs_b, overrun);
 
 	if (!throttled) {
 		/* mark as potentially idle for the upcoming period */
@@ -5194,6 +5214,7 @@ static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
 }
 
 extern const u64 max_cfs_quota_period;
+extern const u64 max_cfs_runtime;
 
 static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 {
@@ -5223,7 +5244,18 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 			new = old * 2;
 			if (new < max_cfs_quota_period) {
 				cfs_b->period = ns_to_ktime(new);
-				cfs_b->quota *= 2;
+				cfs_b->quota = min(cfs_b->quota * 2,
+						   max_cfs_runtime);
+
+				cfs_b->buffer = min(cfs_b->quota + cfs_b->burst,
+						    max_cfs_runtime);
+				/*
+				 * Add 1 in case max_overrun becomes 0.
+				 * 0 max_overrun will cause no runtime being
+				 * refilled in __refill_cfs_bandwidth_runtime().
+				 */
+				cfs_b->max_overrun >>= 1;
+				cfs_b->max_overrun++;
 
 				pr_warn_ratelimited(
 	"cfs_period_timer[cpu%d]: period too short, scaling up (new cfs_period_us = %lld, cfs_quota_us = %lld)\n",
@@ -5272,16 +5304,26 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 	INIT_LIST_HEAD(&cfs_rq->throttled_list);
 }
 
-void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
+void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b, int init)
 {
+	u64 overrun;
+
 	lockdep_assert_held(&cfs_b->lock);
 
 	if (cfs_b->period_active)
 		return;
 
 	cfs_b->period_active = 1;
-	hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
+	overrun = hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
 	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
+
+	/*
+	 * When period timer stops, quota for the following period is not
+	 * refilled, however period timer is already forwarded. We should
+	 * accumulate quota once more than overrun here.
+	 */
+	if (!init)
+		__refill_cfs_bandwidth_runtime(cfs_b, overrun + 1);
 }
 
 static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a4a1c0116d51..efcbbfc31619 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -359,6 +359,7 @@ struct cfs_bandwidth {
 	u64			runtime;
 	u64			burst;
 	u64			buffer;
+	u64			max_overrun;
 	s64			hierarchical_quota;
 
 	u8			idle;
@@ -469,8 +470,7 @@ extern void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 			struct sched_entity *parent);
 extern void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
 
-extern void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b);
-extern void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
+extern void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b, int init);
 extern void unthrottle_cfs_rq(struct cfs_rq *cfs_rq);
 
 extern void free_rt_sched_group(struct task_group *tg);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 62fbd09b5dc1..20d6a5ca9ef3 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1842,6 +1842,15 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ONE,
 	},
+	{
+		.procname	= "sched_cfs_bw_burst_enabled",
+		.data		= &sysctl_sched_cfs_bw_burst_enabled,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 #endif
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 	{
-- 
2.14.4.44.g2045bb6


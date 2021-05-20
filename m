Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586C438AE5E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbhETMgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:36:15 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:46932 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233618AbhETMfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:35:52 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0UZVdWUa_1621514068;
Received: from localhost(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0UZVdWUa_1621514068)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 20 May 2021 20:34:28 +0800
From:   Huaixin Chang <changhuaixin@linux.alibaba.com>
To:     changhuaixin@linux.alibaba.com
Cc:     bsegall@google.com, dietmar.eggemann@arm.com,
        dtcccc@linux.alibaba.com, juri.lelli@redhat.com,
        khlebnikov@yandex-team.ru, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@redhat.com, odin@uged.al, odin@ugedal.com,
        pauld@redhead.com, peterz@infradead.org, pjt@google.com,
        rostedt@goodmis.org, shanpeic@linux.alibaba.com, tj@kernel.org,
        vincent.guittot@linaro.org, xiyou.wangcong@gmail.com
Subject: [PATCH v5 1/3] sched/fair: Introduce the burstable CFS controller
Date:   Thu, 20 May 2021 20:34:17 +0800
Message-Id: <20210520123419.8039-2-changhuaixin@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
In-Reply-To: <20210520123419.8039-1-changhuaixin@linux.alibaba.com>
References: <20210520123419.8039-1-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CFS bandwidth controller limits CPU requests of a task group to
quota during each period. However, parallel workloads might be bursty
so that they get throttled even when their average utilization is under
quota. And they are latency sensitive at the same time so that
throttling them is undesired.

Scaling up period and quota allows greater burst capacity. But it might
cause longer stuck till next refill. Introduce "burst" to allow
accumulating unused quota from previous periods, and to be assigned when
a task group requests more CPU than quota during a specific period.

Introducing burst buffer might also cause interference to other groups.
Thus limit the maximum accumulated buffer by "burst", and limit
the maximum allowed burst by quota, too.

The benefit of burst is seen when testing with schbench:

	echo $$ > /sys/fs/cgroup/cpu/test/cgroup.procs
	echo 600000 > /sys/fs/cgroup/cpu/test/cpu.cfs_quota_us
	echo 100000 > /sys/fs/cgroup/cpu/test/cpu.cfs_period_us
	echo 400000 > /sys/fs/cgroup/cpu/test/cpu.cfs_burst_us

	# The average CPU usage is around 500%, which is 200ms CPU time
	# every 40ms.
	./schbench -m 1 -t 30 -r 10 -c 10000 -R 500

	Without burst:

	Latency percentiles (usec)
	50.0000th: 7
	75.0000th: 8
	90.0000th: 9
	95.0000th: 10
	*99.0000th: 933
	99.5000th: 981
	99.9000th: 3068
	min=0, max=20054
	rps: 498.31 p95 (usec) 10 p99 (usec) 933 p95/cputime 0.10% p99/cputime 9.33%

	With burst:

	Latency percentiles (usec)
	50.0000th: 7
	75.0000th: 8
	90.0000th: 9
	95.0000th: 9
	*99.0000th: 12
	99.5000th: 13
	99.9000th: 19
	min=0, max=406
	rps: 498.36 p95 (usec) 9 p99 (usec) 12 p95/cputime 0.09% p99/cputime 0.12%

The interferenece when using burst is valued by the possibilities for
missing the deadline and the average WCET. Test results showed that when
there many cgroups or CPU is under utilized, the interference is
limited. More details are shown in:
https://lore.kernel.org/lkml/5371BD36-55AE-4F71-B9D7-B86DC32E3D2B@linux.alibaba.com/

Co-developed-by: Shanpei Chen <shanpeic@linux.alibaba.com>
Signed-off-by: Shanpei Chen <shanpeic@linux.alibaba.com>
Co-developed-by: Tianchen Ding <dtcccc@linux.alibaba.com>
Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
---
 include/linux/sched/sysctl.h |  1 +
 kernel/sched/core.c          | 83 ++++++++++++++++++++++++++++++++++++--------
 kernel/sched/fair.c          | 21 ++++++++++-
 kernel/sched/sched.h         |  1 +
 kernel/sysctl.c              |  9 +++++
 5 files changed, 99 insertions(+), 16 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index db2c0f34aaaf..08432aeb742e 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -73,6 +73,7 @@ extern unsigned int sysctl_sched_uclamp_util_min_rt_default;
 
 #ifdef CONFIG_CFS_BANDWIDTH
 extern unsigned int sysctl_sched_cfs_bandwidth_slice;
+extern unsigned int sysctl_sched_cfs_bw_burst_enabled;
 #endif
 
 #ifdef CONFIG_SCHED_AUTOGROUP
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5226cc26a095..7d34b08ee0e5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8962,7 +8962,8 @@ static const u64 max_cfs_runtime = MAX_BW * NSEC_PER_USEC;
 
 static int __cfs_schedulable(struct task_group *tg, u64 period, u64 runtime);
 
-static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
+static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
+				u64 burst)
 {
 	int i, ret = 0, runtime_enabled, runtime_was_enabled;
 	struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
@@ -8992,6 +8993,10 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
 	if (quota != RUNTIME_INF && quota > max_cfs_runtime)
 		return -EINVAL;
 
+	if (quota != RUNTIME_INF && (burst > quota ||
+				     burst + quota > max_cfs_runtime))
+		return -EINVAL;
+
 	/*
 	 * Prevent race between setting of cfs_rq->runtime_enabled and
 	 * unthrottle_offline_cfs_rqs().
@@ -9013,6 +9018,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
 	raw_spin_lock_irq(&cfs_b->lock);
 	cfs_b->period = ns_to_ktime(period);
 	cfs_b->quota = quota;
+	cfs_b->burst = burst;
 
 	__refill_cfs_bandwidth_runtime(cfs_b);
 
@@ -9046,9 +9052,10 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
 
 static int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
 {
-	u64 quota, period;
+	u64 quota, period, burst;
 
 	period = ktime_to_ns(tg->cfs_bandwidth.period);
+	burst = tg->cfs_bandwidth.burst;
 	if (cfs_quota_us < 0)
 		quota = RUNTIME_INF;
 	else if ((u64)cfs_quota_us <= U64_MAX / NSEC_PER_USEC)
@@ -9056,7 +9063,7 @@ static int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
 	else
 		return -EINVAL;
 
-	return tg_set_cfs_bandwidth(tg, period, quota);
+	return tg_set_cfs_bandwidth(tg, period, quota, burst);
 }
 
 static long tg_get_cfs_quota(struct task_group *tg)
@@ -9074,15 +9081,16 @@ static long tg_get_cfs_quota(struct task_group *tg)
 
 static int tg_set_cfs_period(struct task_group *tg, long cfs_period_us)
 {
-	u64 quota, period;
+	u64 quota, period, burst;
 
 	if ((u64)cfs_period_us > U64_MAX / NSEC_PER_USEC)
 		return -EINVAL;
 
 	period = (u64)cfs_period_us * NSEC_PER_USEC;
 	quota = tg->cfs_bandwidth.quota;
+	burst = tg->cfs_bandwidth.burst;
 
-	return tg_set_cfs_bandwidth(tg, period, quota);
+	return tg_set_cfs_bandwidth(tg, period, quota, burst);
 }
 
 static long tg_get_cfs_period(struct task_group *tg)
@@ -9095,6 +9103,30 @@ static long tg_get_cfs_period(struct task_group *tg)
 	return cfs_period_us;
 }
 
+static int tg_set_cfs_burst(struct task_group *tg, long cfs_burst_us)
+{
+	u64 quota, period, burst;
+
+	if ((u64)cfs_burst_us > U64_MAX / NSEC_PER_USEC)
+		return -EINVAL;
+
+	burst = (u64)cfs_burst_us * NSEC_PER_USEC;
+	period = ktime_to_ns(tg->cfs_bandwidth.period);
+	quota = tg->cfs_bandwidth.quota;
+
+	return tg_set_cfs_bandwidth(tg, period, quota, burst);
+}
+
+static long tg_get_cfs_burst(struct task_group *tg)
+{
+	u64 burst_us;
+
+	burst_us = tg->cfs_bandwidth.burst;
+	do_div(burst_us, NSEC_PER_USEC);
+
+	return burst_us;
+}
+
 static s64 cpu_cfs_quota_read_s64(struct cgroup_subsys_state *css,
 				  struct cftype *cft)
 {
@@ -9119,6 +9151,18 @@ static int cpu_cfs_period_write_u64(struct cgroup_subsys_state *css,
 	return tg_set_cfs_period(css_tg(css), cfs_period_us);
 }
 
+static s64 cpu_cfs_burst_read_s64(struct cgroup_subsys_state *css,
+				  struct cftype *cft)
+{
+	return tg_get_cfs_burst(css_tg(css));
+}
+
+static int cpu_cfs_burst_write_s64(struct cgroup_subsys_state *css,
+				   struct cftype *cftype, s64 cfs_burst_us)
+{
+	return tg_set_cfs_burst(css_tg(css), cfs_burst_us);
+}
+
 struct cfs_schedulable_data {
 	struct task_group *tg;
 	u64 period, quota;
@@ -9271,6 +9315,11 @@ static struct cftype cpu_legacy_files[] = {
 		.read_u64 = cpu_cfs_period_read_u64,
 		.write_u64 = cpu_cfs_period_write_u64,
 	},
+	{
+		.name = "cfs_burst_us",
+		.read_s64 = cpu_cfs_burst_read_s64,
+		.write_s64 = cpu_cfs_burst_write_s64,
+	},
 	{
 		.name = "stat",
 		.seq_show = cpu_cfs_stat_show,
@@ -9390,27 +9439,29 @@ static int cpu_weight_nice_write_s64(struct cgroup_subsys_state *css,
 }
 #endif
 
-static void __maybe_unused cpu_period_quota_print(struct seq_file *sf,
-						  long period, long quota)
+static void __maybe_unused
+cpu_period_quota_print(struct seq_file *sf, long period, long quota,
+		       long burst)
 {
 	if (quota < 0)
 		seq_puts(sf, "max");
 	else
 		seq_printf(sf, "%ld", quota);
 
-	seq_printf(sf, " %ld\n", period);
+	seq_printf(sf, " %ld %ld\n", period, burst);
 }
 
-/* caller should put the current value in *@periodp before calling */
-static int __maybe_unused cpu_period_quota_parse(char *buf,
-						 u64 *periodp, u64 *quotap)
+/* caller should put the current value in *@periodp and *@burstp before calling */
+static int __maybe_unused cpu_period_quota_parse(char *buf, u64 *periodp,
+						 u64 *quotap, u64 *burstp)
 {
 	char tok[21];	/* U64_MAX */
 
-	if (sscanf(buf, "%20s %llu", tok, periodp) < 1)
+	if (sscanf(buf, "%20s %llu %llu", tok, periodp, burstp) < 1)
 		return -EINVAL;
 
 	*periodp *= NSEC_PER_USEC;
+	*burstp *= NSEC_PER_USEC;
 
 	if (sscanf(tok, "%llu", quotap))
 		*quotap *= NSEC_PER_USEC;
@@ -9427,7 +9478,8 @@ static int cpu_max_show(struct seq_file *sf, void *v)
 {
 	struct task_group *tg = css_tg(seq_css(sf));
 
-	cpu_period_quota_print(sf, tg_get_cfs_period(tg), tg_get_cfs_quota(tg));
+	cpu_period_quota_print(sf, tg_get_cfs_period(tg), tg_get_cfs_quota(tg),
+			       tg_get_cfs_burst(tg));
 	return 0;
 }
 
@@ -9436,12 +9488,13 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
 {
 	struct task_group *tg = css_tg(of_css(of));
 	u64 period = tg_get_cfs_period(tg);
+	u64 burst = tg_get_cfs_burst(tg);
 	u64 quota;
 	int ret;
 
-	ret = cpu_period_quota_parse(buf, &period, &quota);
+	ret = cpu_period_quota_parse(buf, &period, &quota, &burst);
 	if (!ret)
-		ret = tg_set_cfs_bandwidth(tg, period, quota);
+		ret = tg_set_cfs_bandwidth(tg, period, quota, burst);
 	return ret ?: nbytes;
 }
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3248e24a90b0..48fad5cf0f7a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -134,6 +134,13 @@ int __weak arch_asym_cpu_priority(int cpu)
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
@@ -4628,8 +4635,16 @@ static inline u64 sched_cfs_bandwidth_slice(void)
  */
 void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
 {
-	if (cfs_b->quota != RUNTIME_INF)
+	if (unlikely(cfs_b->quota == RUNTIME_INF))
+		return;
+
+	if (!sysctl_sched_cfs_bw_burst_enabled) {
 		cfs_b->runtime = cfs_b->quota;
+		return;
+	}
+
+	cfs_b->runtime += cfs_b->quota;
+	cfs_b->runtime = min(cfs_b->runtime, cfs_b->quota + cfs_b->burst);
 }
 
 static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
@@ -4651,6 +4666,9 @@ static int __assign_cfs_rq_runtime(struct cfs_bandwidth *cfs_b,
 	if (cfs_b->quota == RUNTIME_INF)
 		amount = min_amount;
 	else {
+		if (!cfs_b->period_active)
+			__refill_cfs_bandwidth_runtime(cfs_b);
+
 		start_cfs_bandwidth(cfs_b);
 
 		if (cfs_b->runtime > 0) {
@@ -5279,6 +5297,7 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 	cfs_b->runtime = 0;
 	cfs_b->quota = RUNTIME_INF;
 	cfs_b->period = ns_to_ktime(default_cfs_period());
+	cfs_b->burst = 0;
 
 	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
 	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a189bec13729..d317ca74a48c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -366,6 +366,7 @@ struct cfs_bandwidth {
 	ktime_t			period;
 	u64			quota;
 	u64			runtime;
+	u64			burst;
 	s64			hierarchical_quota;
 
 	u8			idle;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 14edf84cc571..fb27bae7ace2 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1816,6 +1816,15 @@ static struct ctl_table kern_table[] = {
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


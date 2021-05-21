Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7866038CB5E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 18:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237851AbhEUQ41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 12:56:27 -0400
Received: from foss.arm.com ([217.140.110.172]:51586 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237831AbhEUQ4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 12:56:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7B901515;
        Fri, 21 May 2021 09:54:55 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 75DA63F73D;
        Fri, 21 May 2021 09:54:54 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com
Cc:     linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v2 3/3] PM / EM: Skip inefficient OPPs
Date:   Fri, 21 May 2021 17:54:24 +0100
Message-Id: <1621616064-340235-4-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
References: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SoCs, such as the sd855 have OPPs within the same performance domain,
whose cost is higher than others with a higher frequency. Even though
those OPPs are interesting from a cooling perspective, it makes no sense
to use them when the device can run at full capacity. Those OPPs handicap
the performance domain, when choosing the most energy-efficient CPU and
are wasting energy. They are inefficient.

Hence, add support for such OPPs to the Energy Model. The table can now
be read skipping inefficient performance states (and by extension,
inefficient OPPs).

Currently, the efficient table is used in two paths. Schedutil, and
find_energy_efficient_cpu(). We have to modify both paths in the same
patch so they stay synchronized. The thermal framework still relies on
the full table.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 9be7bde..daaeccf 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -17,13 +17,25 @@
  *		device). It can be a total power: static and dynamic.
  * @cost:	The cost coefficient associated with this level, used during
  *		energy calculation. Equal to: power * max_frequency / frequency
+ * @flags:	see "em_perf_state flags" description below.
  */
 struct em_perf_state {
 	unsigned long frequency;
 	unsigned long power;
 	unsigned long cost;
+	unsigned long flags;
 };
 
+/*
+ * em_perf_state flags:
+ *
+ * EM_PERF_STATE_INEFFICIENT: The performance state is inefficient. There is
+ * in this em_perf_domain, another performance state with a higher frequency
+ * but a lower or equal power cost. Such inefficient states are ignored when
+ * using em_pd_get_efficient_*() functions.
+ */
+#define EM_PERF_STATE_INEFFICIENT BIT(0)
+
 /**
  * em_perf_domain - Performance domain
  * @table:		List of performance states, in ascending order
@@ -52,8 +64,12 @@ struct em_perf_domain {
  *
  *  EM_PERF_DOMAIN_MILLIWATTS: The power values are in milli-Watts or some
  *  other scale.
+ *
+ *  EM_PERF_DOMAIN_INEFFICIENCIES: This perf domain contains inefficient perf
+ *  states.
  */
 #define EM_PERF_DOMAIN_MILLIWATTS BIT(0)
+#define EM_PERF_DOMAIN_INEFFICIENCIES BIT(1)
 
 #define em_span_cpus(em) (to_cpumask((em)->cpus))
 
@@ -93,6 +109,58 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 void em_dev_unregister_perf_domain(struct device *dev);
 
 /**
+ * em_pd_get_efficient_state() - Get an efficient performance state from the EM
+ * @pd   : Performance domain for which we want an efficient frequency
+ * @freq : Frequency to map with the EM
+ *
+ * It is called from the scheduler code quite frequently and as a consequence
+ * doesn't implement any check.
+ *
+ * Return: An efficient performance state, high enough to meet @freq
+ * requirement.
+ */
+static inline
+struct em_perf_state *em_pd_get_efficient_state(struct em_perf_domain *pd,
+						unsigned long freq)
+{
+	struct em_perf_state *ps;
+	int i;
+
+	for (i = 0; i < pd->nr_perf_states; i++) {
+		ps = &pd->table[i];
+		if (ps->flags & EM_PERF_STATE_INEFFICIENT)
+			continue;
+		if (ps->frequency >= freq)
+			break;
+	}
+
+	return ps;
+}
+
+/**
+ * em_pd_get_efficient_freq() - Get the efficient frequency from the EM
+ * @pd	 : Performance domain for which we want an efficient frequency
+ * @freq : Frequency to map with the EM
+ *
+ * This function will return @freq if no inefficiencies have been found for
+ * that @pd. This is to avoid a useless table walk.
+ *
+ * Return: An efficient frequency, high enough to meet @freq requirement.
+ */
+static inline unsigned long em_pd_get_efficient_freq(struct em_perf_domain *pd,
+						     unsigned long freq)
+{
+	struct em_perf_state *ps;
+
+	if (!pd || !(pd->flags & EM_PERF_DOMAIN_INEFFICIENCIES))
+		return freq;
+
+	ps = em_pd_get_efficient_state(pd, freq);
+
+	return ps->frequency;
+}
+
+/**
  * em_cpu_energy() - Estimates the energy consumed by the CPUs of a
 		performance domain
  * @pd		: performance domain for which energy has to be estimated
@@ -111,7 +179,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 {
 	unsigned long freq, scale_cpu;
 	struct em_perf_state *ps;
-	int i, cpu;
+	int cpu;
 
 	if (!sum_util)
 		return 0;
@@ -130,11 +198,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	 * Find the lowest performance state of the Energy Model above the
 	 * requested frequency.
 	 */
-	for (i = 0; i < pd->nr_perf_states; i++) {
-		ps = &pd->table[i];
-		if (ps->frequency >= freq)
-			break;
-	}
+	ps = em_pd_get_efficient_state(pd, freq);
 
 	/*
 	 * The capacity of a CPU in the domain at the performance state (ps)
@@ -224,6 +288,12 @@ static inline int em_pd_nr_perf_states(struct em_perf_domain *pd)
 {
 	return 0;
 }
+
+static inline unsigned long
+em_pd_get_efficient_freq(struct em_perf_domain *pd, unsigned long freq)
+{
+	return freq;
+}
 #endif
 
 #endif
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 638581c..af8d54f 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -2,7 +2,7 @@
 /*
  * Energy Model of devices
  *
- * Copyright (c) 2018-2020, Arm ltd.
+ * Copyright (c) 2018-2021, Arm ltd.
  * Written by: Quentin Perret, Arm ltd.
  * Improvements provided by: Lukasz Luba, Arm ltd.
  */
@@ -42,6 +42,7 @@ static void em_debug_create_ps(struct em_perf_state *ps, struct dentry *pd)
 	debugfs_create_ulong("frequency", 0444, d, &ps->frequency);
 	debugfs_create_ulong("power", 0444, d, &ps->power);
 	debugfs_create_ulong("cost", 0444, d, &ps->cost);
+	debugfs_create_ulong("inefficient", 0444, d, &ps->flags);
 }
 
 static int em_debug_cpus_show(struct seq_file *s, void *unused)
@@ -161,6 +162,8 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 		table[i].cost = div64_u64(fmax * table[i].power,
 					  table[i].frequency);
 		if (table[i].cost >= prev_cost) {
+			table[i].flags = EM_PERF_STATE_INEFFICIENT;
+			pd->flags |= EM_PERF_DOMAIN_INEFFICIENCIES;
 			dev_dbg(dev, "EM: OPP:%lu is inefficient\n",
 				table[i].frequency);
 		} else {
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 4f09afd..5a91a2b 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -10,6 +10,7 @@
 
 #include "sched.h"
 
+#include <linux/energy_model.h>
 #include <linux/sched/cpufreq.h>
 #include <trace/events/power.h>
 
@@ -153,6 +154,9 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 
 	freq = map_util_freq(util, freq, max);
 
+	/* Avoid inefficient performance states */
+	freq = em_pd_get_efficient_freq(em_cpu_get(policy->cpu), freq);
+
 	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
 		return sg_policy->next_freq;
 
-- 
2.7.4


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7E7358B05
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbhDHRLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:11:14 -0400
Received: from foss.arm.com ([217.140.110.172]:55072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232615AbhDHRLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:11:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD4E613A1;
        Thu,  8 Apr 2021 10:10:56 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D27D3F792;
        Thu,  8 Apr 2021 10:10:55 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com
Cc:     linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH] PM / EM: Inefficient OPPs detection
Date:   Thu,  8 Apr 2021 18:10:29 +0100
Message-Id: <1617901829-381963-2-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617901829-381963-1-git-send-email-vincent.donnefort@arm.com>
References: <1617901829-381963-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SoCs, such as the sd855 have OPPs within the same performance domain,
whose cost is higher than others with a higher frequency. Even though
those OPPs are interesting from a cooling perspective, it makes no sense
to use them when the device can run at full capacity. Those OPPs handicap
the performance domain, when choosing the most energy-efficient CPU and
are wasting energy. They are inefficient.

Hence, add support for such OPPs to the Energy Model, which creates for
each OPP a performance state. The Energy Model can now be read using the
regular table, which contains all performance states available, or using
an efficient table, where inefficient performance states (and by
extension, inefficient OPPs) have been removed.

Currently, the efficient table is used in two paths. Schedutil, and
find_energy_efficient_cpu(). We have to modify both paths in the same
patch so they stay synchronized. The thermal framework still relies on
the original table and hence, DevFreq devices won't create the efficient
table.

As used in the hot-path, the efficient table is a lookup table, generated
dynamically when the perf domain is created. The complexity of searching
a performance state is hence changed from O(n) to O(1). This also
speeds-up em_cpu_energy() even if no inefficient OPPs have been found.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 757fc60..90b9cb0 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -17,19 +17,60 @@
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
+};
+
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
+/**
+ * em_efficient_table - Efficient em_perf_state lookup table.
+ * @table:	Lookup table for the efficient em_perf_state
+ * @min_state:  Minimum efficient state for the perf_domain
+ * @max_state:  Maximum state for the perf_domain
+ * @min_freq:	Minimum efficient frequency for the perf_domain
+ * @max_freq:	Maximum frequency for the perf_domain
+ * @shift:	Shift value used to resolve the lookup table
+ *
+ * Resolving a frequency to an efficient em_perf_state is as follows:
+ *
+ *   1. Check frequency against min_freq and max_freq
+ *   2. idx = (frequency - min_freq) >> shift;
+ *   3. idx = table[idx].frequency < frequency ? idx + 1 : idx;
+ *   4. table[idx]
+ *
+ *   3. Intends to resolve undershoot, when an OPP is in the middle of the
+ *   lookup table bin.
+ */
+struct em_efficient_table {
+	struct em_perf_state **table;
+	struct em_perf_state *min_state;
+	struct em_perf_state *max_state;
+	unsigned long min_freq;
+	unsigned long max_freq;
+	int shift;
 };
 
 /**
  * em_perf_domain - Performance domain
  * @table:		List of performance states, in ascending order
+ * @efficient_table:	List of efficient performance states, in a lookup
+ *			table. This is filled only for CPU devices.
  * @nr_perf_states:	Number of performance states
- * @milliwatts:		Flag indicating the power values are in milli-Watts
- *			or some other scale.
+ * @flags:		See "em_perf_domain flags"
  * @cpus:		Cpumask covering the CPUs of the domain. It's here
  *			for performance reasons to avoid potential cache
  *			misses during energy calculations in the scheduler
@@ -43,11 +84,24 @@ struct em_perf_state {
  */
 struct em_perf_domain {
 	struct em_perf_state *table;
+	struct em_efficient_table efficient_table;
 	int nr_perf_states;
-	int milliwatts;
+	int flags;
 	unsigned long cpus[];
 };
 
+/*
+ *  em_perf_domain flags:
+ *
+ *  EM_PERF_DOMAIN_MILLIWATTS: The power values are in milli-Watts or some
+ *  other scale.
+ *
+ *  EM_PERF_DOMAIN_INEFFICIENCIES: This perf domain contains inefficient perf
+ *  states.
+ */
+#define EM_PERF_DOMAIN_MILLIWATTS BIT(0)
+#define EM_PERF_DOMAIN_INEFFICIENCIES BIT(1)
+
 #define em_span_cpus(em) (to_cpumask((em)->cpus))
 
 #ifdef CONFIG_ENERGY_MODEL
@@ -86,6 +140,63 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 void em_dev_unregister_perf_domain(struct device *dev);
 
 /**
+ * em_pd_get_efficient_state() - Get an efficient performance state from the EM
+ * @pd   : Performance domain for which we want an efficient frequency
+ * @freq : Frequency to map with the EM
+ *
+ * This function must be used only for CPU devices. It is called from the
+ * scheduler code quite frequently and as a consequence doesn't implement any
+ * check.
+ *
+ * Return: An efficient performance state, high enough to meet @freq
+ * requirement.
+ */
+static inline
+struct em_perf_state *em_pd_get_efficient_state(struct em_perf_domain *pd,
+						unsigned long freq)
+{
+	struct em_efficient_table *efficients = &pd->efficient_table;
+	int idx;
+
+	if (freq <= efficients->min_freq)
+		return efficients->min_state;
+
+	if (freq >= efficients->max_freq)
+		return efficients->max_state;
+
+	idx = (freq - efficients->min_freq) >> efficients->shift;
+
+	/* Undershoot due to the bin size. Use the higher perf_state */
+	if (efficients->table[idx]->frequency < freq)
+		idx++;
+
+	return efficients->table[idx];
+}
+
+/**
+ * em_pd_get_efficient_freq() - Get the efficient frequency from the EM
+ * @pd	 : Performance domain for which we want an efficient frequency
+ * @freq : Frequency to map with the EM
+ *
+ * This function will return @freq if no inefficiencies have been found for
+ * that @pd. This is to avoid a useless lookup table resolution.
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
@@ -104,7 +215,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 {
 	unsigned long freq, scale_cpu;
 	struct em_perf_state *ps;
-	int i, cpu;
+	int cpu;
 
 	if (!sum_util)
 		return 0;
@@ -123,11 +234,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
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
@@ -217,6 +324,12 @@ static inline int em_pd_nr_perf_states(struct em_perf_domain *pd)
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
index 1358fa4..fcc64eb 100644
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
@@ -55,7 +56,8 @@ DEFINE_SHOW_ATTRIBUTE(em_debug_cpus);
 static int em_debug_units_show(struct seq_file *s, void *unused)
 {
 	struct em_perf_domain *pd = s->private;
-	char *units = pd->milliwatts ? "milliWatts" : "bogoWatts";
+	char *units = (pd->flags & EM_PERF_DOMAIN_MILLIWATTS) ?
+		"milliWatts" : "bogoWatts";
 
 	seq_printf(s, "%s\n", units);
 
@@ -107,7 +109,6 @@ static void em_debug_remove_pd(struct device *dev) {}
 static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 				int nr_states, struct em_data_callback *cb)
 {
-	unsigned long opp_eff, prev_opp_eff = ULONG_MAX;
 	unsigned long power, freq, prev_freq = 0;
 	struct em_perf_state *table;
 	int i, ret;
@@ -153,18 +154,6 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 
 		table[i].power = power;
 		table[i].frequency = prev_freq = freq;
-
-		/*
-		 * The hertz/watts efficiency ratio should decrease as the
-		 * frequency grows on sane platforms. But this isn't always
-		 * true in practice so warn the user if a higher OPP is more
-		 * power efficient than a lower one.
-		 */
-		opp_eff = freq / power;
-		if (opp_eff >= prev_opp_eff)
-			dev_dbg(dev, "EM: hertz/watts ratio non-monotonically decreasing: em_perf_state %d >= em_perf_state%d\n",
-					i, i - 1);
-		prev_opp_eff = opp_eff;
 	}
 
 	/* Compute the cost of each performance state. */
@@ -184,12 +173,88 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
 	return -EINVAL;
 }
 
+static inline int em_create_efficient_table(struct em_perf_domain *pd)
+{
+	unsigned long min_freq, max_freq, min_delta = ULONG_MAX;
+	struct em_perf_state *prev = NULL, *ps, *min_perf_state = NULL;
+	int i, j, nr_entries, shift = 0;
+
+	max_freq = pd->table[pd->nr_perf_states - 1].frequency;
+
+	for (i = 0 ; i < pd->nr_perf_states; i++) {
+		ps  = &pd->table[i];
+		if (ps->flags & EM_PERF_STATE_INEFFICIENT)
+			continue;
+
+		if (!min_perf_state)
+			min_perf_state = ps;
+
+		if (prev) {
+			unsigned long delta = ps->frequency - prev->frequency;
+
+			if (delta < min_delta)
+				min_delta = delta;
+		}
+
+		prev = ps;
+	}
+	min_freq = min_perf_state->frequency;
+
+	/*
+	 * Use, as a bin size, a power of two. This allows lookup table
+	 * resolution with a quick shift, instead of a division. Also, use a
+	 * minimum of 1024kHz to avoid creating to many entries in the table for
+	 * the very unlikely case where two efficient OPPs have a small
+	 * frequency delta.
+	 */
+	min_delta = rounddown_pow_of_two(max(min_delta, 1024UL));
+	shift = ilog2(min_delta);
+	/* +1 for the division remainder below */
+	nr_entries = ((max_freq - min_freq) >> shift) + 1;
+
+	pd->efficient_table.table = kcalloc(nr_entries,
+					sizeof(*pd->efficient_table.table),
+					GFP_KERNEL);
+	if (!pd->efficient_table.table)
+		return -ENOMEM;
+
+	pd->efficient_table.min_freq = min_freq;
+	pd->efficient_table.min_state = min_perf_state;
+	pd->efficient_table.max_freq = max_freq;
+	pd->efficient_table.max_state = &pd->table[pd->nr_perf_states - 1];
+	pd->efficient_table.shift = shift;
+
+	for (i = 0; i < nr_entries; i++) {
+		unsigned long lower_bin_bound = min_freq + ((1 << shift) * i);
+
+		for (j = 0; j < pd->nr_perf_states; j++) {
+			ps = &pd->table[j];
+
+			/*
+			 * The first OPP that covers the lower bound of the bin
+			 * is the right one. It ensures we'll never overshoot.
+			 * Undershoot must be handled during the lookup table
+			 * resolution.
+			 */
+			if (ps->flags & EM_PERF_STATE_INEFFICIENT ||
+			    ps->frequency < lower_bin_bound)
+				continue;
+
+			pd->efficient_table.table[i] = ps;
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static int em_create_pd(struct device *dev, int nr_states,
 			struct em_data_callback *cb, cpumask_t *cpus)
 {
 	struct em_perf_domain *pd;
 	struct device *cpu_dev;
-	int cpu, ret;
+	unsigned int prev_cost;
+	int cpu, ret, i;
 
 	if (_is_cpu_device(dev)) {
 		pd = kzalloc(sizeof(*pd) + cpumask_size(), GFP_KERNEL);
@@ -209,11 +274,35 @@ static int em_create_pd(struct device *dev, int nr_states,
 		return ret;
 	}
 
-	if (_is_cpu_device(dev))
+	if (_is_cpu_device(dev)) {
+		/* Identify inefficient perf states */
+		i = pd->nr_perf_states - 1;
+		prev_cost = pd->table[i].cost;
+		for (--i; i >= 0; i--) {
+			if (pd->table[i].cost >= prev_cost) {
+				pd->table[i].flags = EM_PERF_STATE_INEFFICIENT;
+				pd->flags |= EM_PERF_DOMAIN_INEFFICIENCIES;
+				dev_dbg(dev,
+					"EM: pd%d OPP:%lu is inefficient\n",
+					cpumask_first(to_cpumask(pd->cpus)),
+					pd->table[i].frequency);
+				continue;
+			}
+			prev_cost = pd->table[i].cost;
+		}
+
+		ret = em_create_efficient_table(pd);
+		if (ret) {
+			kfree(pd->table);
+			kfree(pd);
+			return ret;
+		}
+
 		for_each_cpu(cpu, cpus) {
 			cpu_dev = get_cpu_device(cpu);
 			cpu_dev->em_pd = pd;
 		}
+	}
 
 	dev->em_pd = pd;
 
@@ -333,7 +422,8 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 	if (ret)
 		goto unlock;
 
-	dev->em_pd->milliwatts = milliwatts;
+	if (milliwatts)
+		dev->em_pd->flags |= EM_PERF_DOMAIN_MILLIWATTS;
 
 	em_debug_create_pd(dev);
 	dev_info(dev, "EM: created perf domain\n");
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 7cc2e11..3eefd4c 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -10,6 +10,7 @@
 
 #include "sched.h"
 
+#include <linux/energy_model.h>
 #include <linux/sched/cpufreq.h>
 #include <trace/events/power.h>
 
@@ -164,6 +165,9 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 
 	freq = map_util_freq(util, freq, max);
 
+	/* Avoid inefficient performance states */
+	freq = em_pd_get_efficient_freq(em_cpu_get(policy->cpu), freq);
+
 	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
 		return sg_policy->next_freq;
 
-- 
2.7.4


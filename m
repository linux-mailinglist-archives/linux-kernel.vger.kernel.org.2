Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABDE36206C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 15:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242542AbhDPNCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 09:02:23 -0400
Received: from foss.arm.com ([217.140.110.172]:41036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238717AbhDPNCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 09:02:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D8CC1396;
        Fri, 16 Apr 2021 06:01:53 -0700 (PDT)
Received: from e113131-lin.cambridge.arm.com (e113131-lin.cambridge.arm.com [10.1.195.76])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CBD6B3F85F;
        Fri, 16 Apr 2021 06:01:51 -0700 (PDT)
From:   Beata Michalska <beata.michalska@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, valentin.schneider@arm.com,
        dietmar.eggemann@arm.com, corbet@lwn.net, linux-doc@vger.kernel.org
Subject: [RFC PATCH 2/3] sched/topology: Rework CPU capacity asymmetry detection
Date:   Fri, 16 Apr 2021 14:01:24 +0100
Message-Id: <1618578085-29584-3-git-send-email-beata.michalska@arm.com>
In-Reply-To: <1618578085-29584-1-git-send-email-beata.michalska@arm.com>
References: <1618578085-29584-1-git-send-email-beata.michalska@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the CPU capacity asymmetry detection, performed through
asym_cpu_capacity_level, tries to identify the lowest topology level
at which the highest CPU capacity is being observed, not necessarily
finding the level at which all possible capacity values are visible
to all CPUs, which might be bit problematic for some possible/valid
asymmetric topologies i.e.:

DIE      [                                ]
MC       [                       ][       ]

CPU       [0] [1] [2] [3] [4] [5]  [6] [7]
Capacity  |.....| |.....| |.....|  |.....|
	     L	     M       B        B

Where:
 arch_scale_cpu_capacity(L) = 512
 arch_scale_cpu_capacity(M) = 871
 arch_scale_cpu_capacity(B) = 1024

In this particular case, the asymmetric topology level will point
at MC, as all possible CPU  masks for that level do cover the CPU
with the highest capacity. It will work just fine for the first
cluster, not so much for the second one though (consider the
find_energy_efficient_cpu which might end up attempting the energy
aware wake-up for a domain that does not see any asymmetry at all)

Rework the way the capacity asymmetry levels are being detected,
to point to the lowest topology level( for a given CPU), where full
range of available CPU capacities is visible to all CPUs within given
domain. As a result, the per-cpu sd_asym_cpucapacity might differ
across the domains. This will have an impact on EAS wake-up placement
in a way that it might see different range of CPUs to be considered,
depending on the given current and target CPUs.

Additionally, those levels, where any range of asymmetry (not
necessarily full) is being detected will get identified as well.
The selected asymmetric topology level will be denoted by
SD_ASYM_CPUCAPACITY_FULL sched domain flag whereas the 'sub-levels'
would receive the already used SD_ASYM_CPUCAPACITY flag. This allows
maintaining the current behaviour for asymmetric topologies, with
misfit migration operating correctly on lower levels, if applicable,
as any asymmetry is enough to trigger the misfit migration.
The logic there relies on the SD_ASYM_CPUCAPACITY flag and does not
relate to the full asymmetry level denoted by the sd_asym_cpucapacity
pointer.

Signed-off-by: Beata Michalska <beata.michalska@arm.com>
---
 kernel/sched/topology.c | 339 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 299 insertions(+), 40 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 09d3504..9dfa66b 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -675,7 +675,7 @@ static void update_top_cache_domain(int cpu)
 	sd = highest_flag_domain(cpu, SD_ASYM_PACKING);
 	rcu_assign_pointer(per_cpu(sd_asym_packing, cpu), sd);
 
-	sd = lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY);
+	sd = lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY_FULL);
 	rcu_assign_pointer(per_cpu(sd_asym_cpucapacity, cpu), sd);
 }
 
@@ -1958,65 +1958,322 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
 
 	return true;
 }
+/**
+ * Asym capacity bits
+ */
+
+/**
+ * Cached cpu masks for those sched domains, at a given topology level,
+ * that do represent CPUs with asymmetric capacities.
+ *
+ * Each topology level will get the cached data assigned,
+ * with asym cap sched_flags (SD_ASYM_CPUCAPACITY and SD_ASYM_CPUCAPACITY_FULL
+ * accordingly) and the corresponding cpumask for:
+ * - domains that do span CPUs with different capacities
+ * - domains where all CPU capacities are visible for all CPUs within
+ *   the domain
+ *
+ * Within a single topology level there might be domains
+ * with different scope of asymmetry:
+ *	none     -> .
+ *	partial  -> SD_ASYM_CPUCAPACITY
+ *	full     -> SD_ASYM_CPUCAPACITY|SD_ASYM_CPUCAPACITY_FULL
+ */
+struct asym_cache_data {
+
+	struct sched_domain_topology_level *tl;
+	unsigned int			   sched_flags;
+	struct cpumask			   *asym_mask;
+	struct cpumask			   *asym_full_mask;
+};
+
+static inline int asym_cpu_capacity_verify(struct asym_cache_data *data,
+			struct sched_domain_topology_level *tl, int cpu)
+{
+	int flags = 0;
+
+	if (!data)
+		goto leave;
+
+	while (data->tl) {
+		if (data->tl != tl) {
+			++data;
+			continue;
+		}
+
+		if (!data->sched_flags)
+			break;
+		/*
+		 * For topology levels above one, where all CPUs observe
+		 * all available capacities, CPUs mask is not being
+		 * cached for optimization reasons, assuming, that at this
+		 * point, all possible CPUs are being concerned.
+		 * Those levels will have both:
+		 * SD_ASYM_CPUCAPACITY and SD_ASYM_CPUCAPACITY_FULL
+		 * flags set.
+		 */
+		if (data->sched_flags & SD_ASYM_CPUCAPACITY_FULL &&
+		   !data->asym_full_mask) {
+			flags = data->sched_flags;
+			break;
+		}
+
+		if (data->asym_full_mask &&
+		    cpumask_test_cpu(cpu, data->asym_full_mask)) {
+			flags = data->sched_flags;
+			break;
+		}
+		/*
+		 * A given topology level might be marked with
+		 * SD_ASYM_CPUCAPACITY_FULL mask but only for a certain subset
+		 * of CPUs.
+		 * Consider the following:
+		 * #1
+		 *
+		 * DIE [                                ]
+		 * MC  [                       ][       ]
+		 *      [0] [1] [2] [3] [4] [5]  [6] [7]
+		 *      |.....| |.....| |.....|  |.....|
+		 *         L       M       B        B
+		 *
+		 * where:
+		 * arch_scale_cpu_capacity(L) = 512
+		 * arch_scale_cpu_capacity(M) = 871
+		 * arch_scale_cpu_capacity(B) = 1024
+		 *
+		 * MC topology level will be marked with both
+		 * SD_ASYM_CPUCAPACITY flags, but the relevant masks will be:
+		 *	asym_full_mask = [0-5]
+		 *	asym_mask empty (no other asymmetry apart from
+		 *                       already covered [0-5])
+		 *
+		 * #2
+		 *
+		 * DIE [                                        ]
+		 * MC  [                       ][               ]
+		 *      [0] [1] [2] [3] [4] [5]  [6] [7] [8] [9]
+		 *      |.....| |.....| |.....|  |.....| |.....|
+		 *         L       M       B        L       B
+		 *
+		 * MC topology level will be marked with both
+		 * SD_ASYM_CPUCAPACITY flags, but the relevant masks will be:
+		 *	asym_full_mask = [0-5]
+		 *	asym_mask      = [6-9]
+		 */
+		if (data->asym_mask && cpumask_test_cpu(cpu, data->asym_mask))
+			flags = SD_ASYM_CPUCAPACITY;
+		break;
+
+	}
+leave:
+	return flags;
+}
+
+
+static inline void asym_cpu_capacity_release_data(struct asym_cache_data *data)
+{
+	struct asym_cache_data *__data = data;
+
+	if (data) {
+		while (data->tl) {
+			if (!data->sched_flags)
+				goto next;
+			if (data->sched_flags & SD_ASYM_CPUCAPACITY_FULL)
+				kfree(data->asym_full_mask);
+			kfree(data->asym_mask);
+next:
+			++data;
+		};
+		kfree(__data);
+	}
+}
+
+static inline void asym_cpu_capacity_cache_data(struct asym_cache_data *data,
+			unsigned int flags, const struct cpumask *cpumask)
+{
+	struct cpumask **__mask;
+
+	if (!data)
+		return;
 
+	__mask = flags & SD_ASYM_CPUCAPACITY_FULL ? &data->asym_full_mask
+						  : &data->asym_mask;
+
+	if (!(*__mask))
+		*__mask = kzalloc(cpumask_size(), GFP_KERNEL);
+	if (*__mask)
+		cpumask_or(*__mask, *__mask, cpumask);
+	data->sched_flags |= flags;
+}
 /*
  * Find the sched_domain_topology_level where all CPU capacities are visible
  * for all CPUs.
  */
-static struct sched_domain_topology_level
-*asym_cpu_capacity_level(const struct cpumask *cpu_map)
+static struct asym_cache_data
+*asym_cpu_capacity_scan(const struct cpumask *cpu_map)
 {
-	int i, j, asym_level = 0;
-	bool asym = false;
+	/*
+	 * Simple data structure to record all available CPU capacities.
+	 * Additional scan level allows tracking unique capacities per each
+	 * topology level and each separate topology level CPU mask.
+	 * During each scan phase, the scan level will allow to determine,
+	 * whether given capacity has been already accounted for, by syncing
+	 * it with the scan stage id.
+	 */
+	struct capacity_entry {
+		struct list_head link;
+		unsigned long    capacity;
+		unsigned int     scan_level;
+	};
+
 	struct sched_domain_topology_level *tl, *asym_tl = NULL;
-	unsigned long cap;
+	struct asym_cache_data *scan_data = NULL;
+	struct capacity_entry *entry = NULL, *tmp;
+	unsigned int level_count = 0;
+	unsigned int cap_count = 0;
+	unsigned int scan_id = 0;
+	LIST_HEAD(capacity_set);
+	unsigned long capacity;
+	cpumask_var_t cpu_mask;
+	int cpu;
 
-	/* Is there any asymmetry? */
-	cap = arch_scale_cpu_capacity(cpumask_first(cpu_map));
+	/* Build-up a list of all CPU capacities, verifying on the way
+	 * if there is any asymmetry at all
+	 */
+	for_each_cpu(cpu, cpu_map) {
+		unsigned long capacity = arch_scale_cpu_capacity(cpu);
 
-	for_each_cpu(i, cpu_map) {
-		if (arch_scale_cpu_capacity(i) != cap) {
-			asym = true;
-			break;
+		if (entry && capacity == entry->capacity)
+			goto next;
+
+		list_for_each_entry(entry, &capacity_set, link) {
+			if (capacity == entry->capacity)
+				goto next;
+		}
+
+		entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+		if (entry) {
+			entry->capacity = capacity;
+			list_add(&entry->link, &capacity_set);
 		}
+		++cap_count;
+next:
+		;
 	}
 
-	if (!asym)
-		return NULL;
+	/* No asymmetry detected so skip the rest */
+	if (!(cap_count > 1))
+		goto leave;
 
+	if (!alloc_cpumask_var(&cpu_mask, GFP_KERNEL))
+		goto leave;
+
+	/* Get the number of topology levels */
+	for_each_sd_topology(tl) level_count++;
 	/*
-	 * Examine topology from all CPU's point of views to detect the lowest
-	 * sched_domain_topology_level where a highest capacity CPU is visible
-	 * to everyone.
+	 * Allocate an array to store cached data
+	 * per each topology level + sentinel
 	 */
-	for_each_cpu(i, cpu_map) {
-		unsigned long max_capacity = arch_scale_cpu_capacity(i);
-		int tl_id = 0;
+	scan_data = kcalloc(level_count + 1, sizeof(*scan_data), GFP_KERNEL);
+	if (!scan_data) {
+		free_cpumask_var(cpu_mask);
+		goto leave;
+	}
 
-		for_each_sd_topology(tl) {
-			if (tl_id < asym_level)
-				goto next_level;
+	level_count = 0;
+
+	for_each_sd_topology(tl) {
+		unsigned int local_cap_count;
+		bool full_asym = true;
+		const struct cpumask *mask;
+		struct asym_cache_data *data = &scan_data[level_count++];
 
-			for_each_cpu_and(j, tl->mask(i), cpu_map) {
-				unsigned long capacity;
+#ifdef CONFIG_NUMA
+		/*
+		 * For NUMA we might end-up in a sched domain
+		 * that spans numa nodes with cpus with
+		 * different capacities which would not be caught
+		 * by the above scan as those will have
+		 * separate cpumasks - subject to numa level
+		 * @see: sched_domains_curr_level & sd_numa_mask
+		 * Considered to be a no-go
+		 */
+		if (WARN_ON_ONCE(tl->numa_level && !full_asym))
+			goto leave;
+#endif
+		data->tl = tl;
 
-				capacity = arch_scale_cpu_capacity(j);
+		if (asym_tl) {
+			data->sched_flags = SD_ASYM_CPUCAPACITY |
+					    SD_ASYM_CPUCAPACITY_FULL;
+			continue;
+		}
 
-				if (capacity <= max_capacity)
-					continue;
+		cpumask_copy(cpu_mask, cpu_map);
+		cpu = cpumask_first(cpu_mask);
+
+		while (cpu < nr_cpu_ids) {
+			int i;
+
+			/*
+			 * Tracking each CPU capacity 'scan' id
+			 * to distinguish discovered capacity sets
+			 * between different CPU masks at each topology level:
+			 * capturing unique capacity values at each scan stage
+			 */
+			++scan_id;
+			local_cap_count = 0;
+
+			mask = tl->mask(cpu);
+			for_each_cpu_and(i, mask, cpu_map) {
+
+				capacity = arch_scale_cpu_capacity(i);
 
-				max_capacity = capacity;
-				asym_level = tl_id;
-				asym_tl = tl;
+				list_for_each_entry(entry, &capacity_set, link) {
+					if (entry->capacity == capacity
+					&&  entry->scan_level < scan_id) {
+						entry->scan_level = scan_id;
+						++local_cap_count;
+					}
+				}
+				__cpumask_clear_cpu(i, cpu_mask);
+			}
+			if (cap_count != local_cap_count)
+				full_asym = false;
+			if (local_cap_count > 1) {
+				int flags = (cap_count != local_cap_count)
+					 ? SD_ASYM_CPUCAPACITY
+					 : SD_ASYM_CPUCAPACITY
+					 | SD_ASYM_CPUCAPACITY_FULL;
+
+				asym_cpu_capacity_cache_data(data, flags, mask);
 			}
-next_level:
-			tl_id++;
+			cpu = cpumask_first(cpu_mask);
+
 		}
+		/*
+		 * Clear the cached masks from CPUs that are not present
+		 * in cpu_map
+		 */
+		if (data->asym_mask)
+			cpumask_and(data->asym_mask, data->asym_mask, cpu_map);
+		if (data->asym_full_mask)
+			cpumask_and(data->asym_full_mask, data->asym_full_mask,
+				    cpu_map);
+
+		if (full_asym)
+			asym_tl = tl;
 	}
+	free_cpumask_var(cpu_mask);
 
-	return asym_tl;
-}
+leave:
+	list_for_each_entry_safe(entry, tmp, &capacity_set, link) {
+		list_del(&entry->link);
+		kfree(entry);
+	}
 
+	return scan_data;
+}
 
 /*
  * Build sched domains for a given set of CPUs and attach the sched domains
@@ -2025,12 +2282,12 @@ static struct sched_domain_topology_level
 static int
 build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *attr)
 {
+	struct asym_cache_data *asym_scan_data;
 	enum s_alloc alloc_state = sa_none;
 	struct sched_domain *sd;
 	struct s_data d;
 	struct rq *rq = NULL;
 	int i, ret = -ENOMEM;
-	struct sched_domain_topology_level *tl_asym;
 	bool has_asym = false;
 
 	if (WARN_ON(cpumask_empty(cpu_map)))
@@ -2040,7 +2297,7 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	if (alloc_state != sa_rootdomain)
 		goto error;
 
-	tl_asym = asym_cpu_capacity_level(cpu_map);
+	asym_scan_data = asym_cpu_capacity_scan(cpu_map);
 
 	/* Set up domains for CPUs specified by the cpu_map: */
 	for_each_cpu(i, cpu_map) {
@@ -2049,9 +2306,10 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 
 		sd = NULL;
 		for_each_sd_topology(tl) {
-			if (tl == tl_asym) {
-				dflags |= SD_ASYM_CPUCAPACITY;
-				has_asym = true;
+			if (!(dflags & SD_ASYM_CPUCAPACITY_FULL)) {
+				dflags |= asym_cpu_capacity_verify(asym_scan_data,
+								   tl, i);
+				has_asym = dflags & SD_ASYM_CPUCAPACITY;
 			}
 
 			if (WARN_ON(!topology_span_sane(tl, cpu_map, i)))
@@ -2068,6 +2326,7 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 		}
 	}
 
+	asym_cpu_capacity_release_data(asym_scan_data);
 	/* Build the groups for the domains */
 	for_each_cpu(i, cpu_map) {
 		for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
-- 
2.7.4


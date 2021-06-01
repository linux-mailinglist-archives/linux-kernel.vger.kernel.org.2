Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7D3393290
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbhE0Pks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:40:48 -0400
Received: from foss.arm.com ([217.140.110.172]:59512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234141AbhE0Pkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:40:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62DD91516;
        Thu, 27 May 2021 08:39:07 -0700 (PDT)
Received: from e120325.arm.com (unknown [10.57.84.138])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DB47C3F73B;
        Thu, 27 May 2021 08:39:05 -0700 (PDT)
From:   Beata Michalska <beata.michalska@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, valentin.schneider@arm.com,
        dietmar.eggemann@arm.com, corbet@lwn.net, rdunlap@infradead.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v6 2/3] sched/topology: Rework CPU capacity asymmetry detection
Date:   Thu, 27 May 2021 16:38:41 +0100
Message-Id: <20210527153842.17567-3-beata.michalska@arm.com>
In-Reply-To: <20210527153842.17567-1-beata.michalska@arm.com>
References: <20210527153842.17567-1-beata.michalska@arm.com>
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
at MC, as all possible CPU masks for that level do cover the CPU
with the highest capacity. It will work just fine for the first
cluster, not so much for the second one though (consider the
find_energy_efficient_cpu which might end up attempting the energy
aware wake-up for a domain that does not see any asymmetry at all)

Rework the way the capacity asymmetry levels are being detected,
allowing to point to the lowest topology level (for a given CPU), where
full set of available CPU capacities is visible to all CPUs within given
domain. As a result, the per-cpu sd_asym_cpucapacity might differ across
the domains. This will have an impact on EAS wake-up placement in a way
that it might see different range of CPUs to be considered, depending on
the given current and target CPUs.

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

Detecting the CPU capacity asymmetry is being based on a set of
available CPU capacities for all possible CPUs. This data is being
generated upon init and updated once CPU topology changes are being
detected (through arch_update_cpu_topology). As such, any changes
to identified CPU capacities (like initializing cpufreq) need to be
explicitly advertised by corresponding archs to trigger rebuilding
the data.

Additional -dflags- parameter, used when building sched domains, has
been removed as well, as the asymmetry flags are now being set directly
in sd_init.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Beata Michalska <beata.michalska@arm.com>
---
 kernel/sched/topology.c | 194 ++++++++++++++++++++++++----------------
 1 file changed, 118 insertions(+), 76 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 55a0a243e871..77e6f79235ad 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -675,7 +675,7 @@ static void update_top_cache_domain(int cpu)
 	sd = highest_flag_domain(cpu, SD_ASYM_PACKING);
 	rcu_assign_pointer(per_cpu(sd_asym_packing, cpu), sd);
 
-	sd = lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY);
+	sd = lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY_FULL);
 	rcu_assign_pointer(per_cpu(sd_asym_cpucapacity, cpu), sd);
 }
 
@@ -1266,6 +1266,112 @@ static void init_sched_groups_capacity(int cpu, struct sched_domain *sd)
 	update_group_capacity(sd, cpu);
 }
 
+/**
+ * Asymmetric CPU capacity bits
+ */
+struct asym_cap_data {
+	struct list_head link;
+	unsigned long capacity;
+	unsigned long cpus[];
+};
+
+/*
+ * Set of available CPUs grouped by their corresponding capacities
+ * Each list entry contains a CPU mask reflecting CPUs that share the same
+ * capacity.
+ * The lifespan of data is unlimited.
+ */
+static LIST_HEAD(asym_cap_list);
+
+#define cpu_capacity_span(asym_data) to_cpumask((asym_data)->cpus)
+
+/*
+ * Verify whether there is any CPU capacity asymmetry in a given sched domain.
+ * Provides sd_flags reflecting the asymmetry scope.
+ */
+static inline int
+asym_cpu_capacity_classify(struct sched_domain *sd,
+			   const struct cpumask *cpu_map)
+{
+	struct asym_cap_data *entry;
+	int sd_asym_flags = 0;
+	int asym_cap_count = 0;
+	int asym_cap_miss = 0;
+
+	/*
+	 * Count how many unique CPU capacities this domain spans across
+	 * (compare sched_domain CPUs mask with ones representing  available
+	 * CPUs capacities). Take into account CPUs that might be offline:
+	 * skip those.
+	 */
+	list_for_each_entry(entry, &asym_cap_list, link) {
+		if (cpumask_intersects(sched_domain_span(sd),
+				       cpu_capacity_span(entry)))
+			++asym_cap_count;
+		else if (cpumask_intersects(cpu_capacity_span(entry), cpu_map))
+			++asym_cap_miss;
+	}
+	/* No asymmetry detected */
+	if (WARN_ON_ONCE(!asym_cap_count) || asym_cap_count == 1)
+		goto leave;
+
+	sd_asym_flags |= SD_ASYM_CPUCAPACITY;
+
+	/*
+	 * All the available capacities have been found within given sched
+	 * domain: no misses reported.
+	 */
+	if (!asym_cap_miss)
+		sd_asym_flags |= SD_ASYM_CPUCAPACITY_FULL;
+
+leave:
+	return sd_asym_flags;
+}
+
+static inline void asym_cpu_capacity_update_data(int cpu)
+{
+	unsigned long capacity = arch_scale_cpu_capacity(cpu);
+	struct asym_cap_data *entry = NULL;
+
+	list_for_each_entry(entry, &asym_cap_list, link) {
+		if (capacity == entry->capacity)
+			goto done;
+	}
+
+	entry = kzalloc(sizeof(*entry) + cpumask_size(), GFP_KERNEL);
+	if (WARN_ONCE(!entry, "Failed to allocate memory for asymmetry data\n"))
+		return;
+	entry->capacity = capacity;
+	list_add(&entry->link, &asym_cap_list);
+done:
+	__cpumask_set_cpu(cpu, cpu_capacity_span(entry));
+}
+
+/*
+ * Build-up/update list of CPUs grouped by their capacities
+ * An update requires explicit request to rebuild sched domains
+ * with state indicating CPU topology changes.
+ */
+static void asym_cpu_capacity_scan(void)
+{
+	struct asym_cap_data *entry, *next;
+	int cpu;
+
+	list_for_each_entry(entry, &asym_cap_list, link)
+		cpumask_clear(cpu_capacity_span(entry));
+
+	for_each_cpu_and(cpu, cpu_possible_mask,
+			 housekeeping_cpumask(HK_FLAG_DOMAIN))
+		asym_cpu_capacity_update_data(cpu);
+
+	list_for_each_entry_safe(entry, next, &asym_cap_list, link) {
+		if (cpumask_empty(cpu_capacity_span(entry))) {
+			list_del(&entry->link);
+			kfree(entry);
+		}
+	}
+}
+
 /*
  * Initializers for schedule domains
  * Non-inlined to reduce accumulated stack pressure in build_sched_domains()
@@ -1399,7 +1505,7 @@ int __read_mostly		node_reclaim_distance = RECLAIM_DISTANCE;
 static struct sched_domain *
 sd_init(struct sched_domain_topology_level *tl,
 	const struct cpumask *cpu_map,
-	struct sched_domain *child, int dflags, int cpu)
+	struct sched_domain *child, int cpu)
 {
 	struct sd_data *sdd = &tl->data;
 	struct sched_domain *sd = *per_cpu_ptr(sdd->sd, cpu);
@@ -1420,9 +1526,6 @@ sd_init(struct sched_domain_topology_level *tl,
 			"wrong sd_flags in topology description\n"))
 		sd_flags &= TOPOLOGY_SD_FLAGS;
 
-	/* Apply detected topology flags */
-	sd_flags |= dflags;
-
 	*sd = (struct sched_domain){
 		.min_interval		= sd_weight,
 		.max_interval		= 2*sd_weight,
@@ -1457,10 +1560,10 @@ sd_init(struct sched_domain_topology_level *tl,
 	cpumask_and(sched_domain_span(sd), cpu_map, tl->mask(cpu));
 	sd_id = cpumask_first(sched_domain_span(sd));
 
+	sd->flags |= asym_cpu_capacity_classify(sd, cpu_map);
 	/*
 	 * Convert topological properties into behaviour.
 	 */
-
 	/* Don't attempt to spread across CPUs of different capacities. */
 	if ((sd->flags & SD_ASYM_CPUCAPACITY) && sd->child)
 		sd->child->flags &= ~SD_PREFER_SIBLING;
@@ -1926,9 +2029,9 @@ static void __sdt_free(const struct cpumask *cpu_map)
 
 static struct sched_domain *build_sched_domain(struct sched_domain_topology_level *tl,
 		const struct cpumask *cpu_map, struct sched_domain_attr *attr,
-		struct sched_domain *child, int dflags, int cpu)
+		struct sched_domain *child, int cpu)
 {
-	struct sched_domain *sd = sd_init(tl, cpu_map, child, dflags, cpu);
+	struct sched_domain *sd = sd_init(tl, cpu_map, child, cpu);
 
 	if (child) {
 		sd->level = child->level + 1;
@@ -1990,65 +2093,6 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
 	return true;
 }
 
-/*
- * Find the sched_domain_topology_level where all CPU capacities are visible
- * for all CPUs.
- */
-static struct sched_domain_topology_level
-*asym_cpu_capacity_level(const struct cpumask *cpu_map)
-{
-	int i, j, asym_level = 0;
-	bool asym = false;
-	struct sched_domain_topology_level *tl, *asym_tl = NULL;
-	unsigned long cap;
-
-	/* Is there any asymmetry? */
-	cap = arch_scale_cpu_capacity(cpumask_first(cpu_map));
-
-	for_each_cpu(i, cpu_map) {
-		if (arch_scale_cpu_capacity(i) != cap) {
-			asym = true;
-			break;
-		}
-	}
-
-	if (!asym)
-		return NULL;
-
-	/*
-	 * Examine topology from all CPU's point of views to detect the lowest
-	 * sched_domain_topology_level where a highest capacity CPU is visible
-	 * to everyone.
-	 */
-	for_each_cpu(i, cpu_map) {
-		unsigned long max_capacity = arch_scale_cpu_capacity(i);
-		int tl_id = 0;
-
-		for_each_sd_topology(tl) {
-			if (tl_id < asym_level)
-				goto next_level;
-
-			for_each_cpu_and(j, tl->mask(i), cpu_map) {
-				unsigned long capacity;
-
-				capacity = arch_scale_cpu_capacity(j);
-
-				if (capacity <= max_capacity)
-					continue;
-
-				max_capacity = capacity;
-				asym_level = tl_id;
-				asym_tl = tl;
-			}
-next_level:
-			tl_id++;
-		}
-	}
-
-	return asym_tl;
-}
-
-
 /*
  * Build sched domains for a given set of CPUs and attach the sched domains
  * to the individual CPUs
@@ -2061,7 +2105,6 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	struct s_data d;
 	struct rq *rq = NULL;
 	int i, ret = -ENOMEM;
-	struct sched_domain_topology_level *tl_asym;
 	bool has_asym = false;
 
 	if (WARN_ON(cpumask_empty(cpu_map)))
@@ -2071,24 +2114,19 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	if (alloc_state != sa_rootdomain)
 		goto error;
 
-	tl_asym = asym_cpu_capacity_level(cpu_map);
-
 	/* Set up domains for CPUs specified by the cpu_map: */
 	for_each_cpu(i, cpu_map) {
 		struct sched_domain_topology_level *tl;
-		int dflags = 0;
 
 		sd = NULL;
 		for_each_sd_topology(tl) {
-			if (tl == tl_asym) {
-				dflags |= SD_ASYM_CPUCAPACITY;
-				has_asym = true;
-			}
 
 			if (WARN_ON(!topology_span_sane(tl, cpu_map, i)))
 				goto error;
 
-			sd = build_sched_domain(tl, cpu_map, attr, sd, dflags, i);
+			sd = build_sched_domain(tl, cpu_map, attr, sd, i);
+
+			has_asym |= sd->flags & SD_ASYM_CPUCAPACITY;
 
 			if (tl == sched_domain_topology)
 				*per_cpu_ptr(d.sd, i) = sd;
@@ -2217,6 +2255,7 @@ int sched_init_domains(const struct cpumask *cpu_map)
 	zalloc_cpumask_var(&fallback_doms, GFP_KERNEL);
 
 	arch_update_cpu_topology();
+	asym_cpu_capacity_scan();
 	ndoms_cur = 1;
 	doms_cur = alloc_sched_domains(ndoms_cur);
 	if (!doms_cur)
@@ -2299,6 +2338,9 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
 
 	/* Let the architecture update CPU core mappings: */
 	new_topology = arch_update_cpu_topology();
+	/* Trigger rebuilding CPU capacity asymmetry data */
+	if (new_topology)
+		asym_cpu_capacity_scan();
 
 	if (!doms_new) {
 		WARN_ON_ONCE(dattr_new);
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9763826DE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 10:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbhEQIZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 04:25:54 -0400
Received: from foss.arm.com ([217.140.110.172]:45180 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230507AbhEQIZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 04:25:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8CEB106F;
        Mon, 17 May 2021 01:24:36 -0700 (PDT)
Received: from e113131-lin.cambridge.arm.com (e113131-lin.cambridge.arm.com [10.1.195.76])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 67C573F719;
        Mon, 17 May 2021 01:24:35 -0700 (PDT)
From:   Beata Michalska <beata.michalska@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, valentin.schneider@arm.com,
        dietmar.eggemann@arm.com, corbet@lwn.net, rdunlap@infradead.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v4 2/3] sched/topology: Rework CPU capacity asymmetry detection
Date:   Mon, 17 May 2021 09:23:50 +0100
Message-Id: <1621239831-5870-3-git-send-email-beata.michalska@arm.com>
In-Reply-To: <1621239831-5870-1-git-send-email-beata.michalska@arm.com>
References: <1621239831-5870-1-git-send-email-beata.michalska@arm.com>
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
full range of available CPU capacities is visible to all CPUs within given
domain. As a result, the per-cpu sd_asym_cpucapacity might differ across
the domains. This will have an impact on EAS wake-up placement in a way
that it might see different rage of CPUs to be considered, depending on
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

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Beata Michalska <beata.michalska@arm.com>
---
 kernel/sched/topology.c | 129 +++++++++++++++++++++++++++++-------------------
 1 file changed, 79 insertions(+), 50 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 55a0a24..81957f7 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -675,7 +675,7 @@ static void update_top_cache_domain(int cpu)
 	sd = highest_flag_domain(cpu, SD_ASYM_PACKING);
 	rcu_assign_pointer(per_cpu(sd_asym_packing, cpu), sd);
 
-	sd = lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY);
+	sd = lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY_FULL);
 	rcu_assign_pointer(per_cpu(sd_asym_cpucapacity, cpu), sd);
 }
 
@@ -1989,66 +1989,96 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
 
 	return true;
 }
-
+/**
+ * Asym capacity bits
+ */
+struct asym_cap_data {
+	struct list_head link;
+	unsigned long    capacity;
+	struct cpumask   *cpu_mask;
+};
 /*
- * Find the sched_domain_topology_level where all CPU capacities are visible
- * for all CPUs.
+ * Set of available CPUs grouped by their corresponding capacities
+ * Each list entry contains a CPU mask reflecting CPUs that share the same
+ * capacity.
+ * The lifespan of data is unlimited.
  */
-static struct sched_domain_topology_level
-*asym_cpu_capacity_level(const struct cpumask *cpu_map)
-{
-	int i, j, asym_level = 0;
-	bool asym = false;
-	struct sched_domain_topology_level *tl, *asym_tl = NULL;
-	unsigned long cap;
+static LIST_HEAD(asym_cap_list);
 
-	/* Is there any asymmetry? */
-	cap = arch_scale_cpu_capacity(cpumask_first(cpu_map));
-
-	for_each_cpu(i, cpu_map) {
-		if (arch_scale_cpu_capacity(i) != cap) {
-			asym = true;
-			break;
-		}
+/*
+ * Verify whether given CPU at a given topology level belongs to a sched domain
+ * that does span CPUs with different capacities.
+ * Provides sd_flags reflecting the asymmetry scope.
+ */
+static inline int
+asym_cpu_capacity_classify(struct sched_domain_topology_level *tl, int cpu)
+{
+	int sd_asym_flags = SD_ASYM_CPUCAPACITY | SD_ASYM_CPUCAPACITY_FULL;
+	const struct cpumask *tl_mask = tl->mask(cpu);
+	struct asym_cap_data *entry;
+	int asym_cap_count = 0;
+
+	if (list_is_singular(&asym_cap_list))
+		goto leave;
+
+	list_for_each_entry(entry, &asym_cap_list, link) {
+		if (cpumask_intersects(tl_mask, entry->cpu_mask))
+			++asym_cap_count;
+		else
+			sd_asym_flags &= ~SD_ASYM_CPUCAPACITY_FULL;
 	}
+	WARN_ON_ONCE(!asym_cap_count);
+leave:
+	return asym_cap_count > 1 ? sd_asym_flags : 0;
+}
 
-	if (!asym)
-		return NULL;
 
-	/*
-	 * Examine topology from all CPU's point of views to detect the lowest
-	 * sched_domain_topology_level where a highest capacity CPU is visible
-	 * to everyone.
-	 */
-	for_each_cpu(i, cpu_map) {
-		unsigned long max_capacity = arch_scale_cpu_capacity(i);
-		int tl_id = 0;
+/*
+ * Build-up/update list of CPUs grouped by their capacities
+ */
+static void asym_cpu_capacity_scan(const struct cpumask *cpu_map)
+{
+	struct asym_cap_data *entry, *next;
+	int cpu;
 
-		for_each_sd_topology(tl) {
-			if (tl_id < asym_level)
-				goto next_level;
+	if (!list_empty(&asym_cap_list))
+		list_for_each_entry(entry, &asym_cap_list, link)
+			cpumask_clear(entry->cpu_mask);
 
-			for_each_cpu_and(j, tl->mask(i), cpu_map) {
-				unsigned long capacity;
+	entry = list_first_entry_or_null(&asym_cap_list,
+			struct asym_cap_data, link);
 
-				capacity = arch_scale_cpu_capacity(j);
+	for_each_cpu(cpu, cpu_map) {
+		unsigned long capacity = arch_scale_cpu_capacity(cpu);
 
-				if (capacity <= max_capacity)
-					continue;
+		if (entry && capacity == entry->capacity)
+			goto next;
 
-				max_capacity = capacity;
-				asym_level = tl_id;
-				asym_tl = tl;
-			}
-next_level:
-			tl_id++;
+		list_for_each_entry(entry, &asym_cap_list, link)
+			if (capacity == entry->capacity)
+				goto next;
+
+		entry = kzalloc(sizeof(*entry) + cpumask_size(), GFP_KERNEL);
+		if (entry) {
+			entry->capacity = capacity;
+			entry->cpu_mask = (struct cpumask *)((char *)entry +
+					   sizeof(*entry));
+			list_add(&entry->link, &asym_cap_list);
 		}
+		WARN_ONCE(!entry,
+		    "Failed to allocate memory for capacity asymmetry detection\n");
+next:
+		__cpumask_set_cpu(cpu, entry->cpu_mask);
 	}
 
-	return asym_tl;
+	list_for_each_entry_safe(entry, next, &asym_cap_list, link) {
+		if (cpumask_empty(entry->cpu_mask)) {
+			list_del(&entry->link);
+			kfree(entry);
+		}
+	}
 }
 
-
 /*
  * Build sched domains for a given set of CPUs and attach the sched domains
  * to the individual CPUs
@@ -2061,7 +2091,6 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	struct s_data d;
 	struct rq *rq = NULL;
 	int i, ret = -ENOMEM;
-	struct sched_domain_topology_level *tl_asym;
 	bool has_asym = false;
 
 	if (WARN_ON(cpumask_empty(cpu_map)))
@@ -2071,7 +2100,7 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	if (alloc_state != sa_rootdomain)
 		goto error;
 
-	tl_asym = asym_cpu_capacity_level(cpu_map);
+	asym_cpu_capacity_scan(cpu_map);
 
 	/* Set up domains for CPUs specified by the cpu_map: */
 	for_each_cpu(i, cpu_map) {
@@ -2080,9 +2109,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 
 		sd = NULL;
 		for_each_sd_topology(tl) {
-			if (tl == tl_asym) {
-				dflags |= SD_ASYM_CPUCAPACITY;
-				has_asym = true;
+			if (!(dflags & SD_ASYM_CPUCAPACITY_FULL)) {
+				dflags |= asym_cpu_capacity_classify(tl, i);
+				has_asym = dflags & SD_ASYM_CPUCAPACITY;
 			}
 
 			if (WARN_ON(!topology_span_sane(tl, cpu_map, i)))
-- 
2.7.4


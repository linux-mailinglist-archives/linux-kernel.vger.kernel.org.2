Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D84D3193C8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhBKUAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:00:53 -0500
Received: from foss.arm.com ([217.140.110.172]:56460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230412AbhBKT4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:56:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E9AF113E;
        Thu, 11 Feb 2021 11:55:19 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05D123F73B;
        Thu, 11 Feb 2021 11:55:16 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Song Bao Hua \(Barry Song\)" <song.bao.hua@hisilicon.com>
Cc:     "vincent.guittot\@linaro.org" <vincent.guittot@linaro.org>,
        "mgorman\@suse.de" <mgorman@suse.de>,
        "mingo\@kernel.org" <mingo@kernel.org>,
        "dietmar.eggemann\@arm.com" <dietmar.eggemann@arm.com>,
        "morten.rasmussen\@arm.com" <morten.rasmussen@arm.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm\@openeuler.org" <linuxarm@openeuler.org>,
        "xuwei \(O\)" <xuwei5@huawei.com>,
        "Liguozhu \(Kenneth\)" <liguozhu@hisilicon.com>,
        "tiantao \(H\)" <tiantao6@hisilicon.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "guodong.xu\@linaro.org" <guodong.xu@linaro.org>,
        Meelis Roos <mroos@linux.ee>
Subject: Re: [PATCH v2] sched/topology: fix the issue groups don't span domain->span for NUMA diameter > 2
In-Reply-To: <YCPByAdQ+rZFzYWp@hirez.programming.kicks-ass.net>
References: <20210203111201.20720-1-song.bao.hua@hisilicon.com> <YCKGVBnXzRsE6/Er@hirez.programming.kicks-ass.net> <4bdaa3e1a54f445fa8e629ea392e7bce@hisilicon.com> <YCPByAdQ+rZFzYWp@hirez.programming.kicks-ass.net>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Thu, 11 Feb 2021 19:55:11 +0000
Message-ID: <jhjblcqtm5c.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/21 12:21, Peter Zijlstra wrote:
> On Tue, Feb 09, 2021 at 08:58:15PM +0000, Song Bao Hua (Barry Song) wrote:
>> So historically, the code has never tried to make sched_groups result
>> in equal size. And it permits the overlapping of local group and remote
>> groups.
>
> Histrorically groups have (typically) always been the same size though.
>
> The reason I did ask is because when you get one large and a bunch of
> smaller groups, the load-balancing 'pull' is relatively smaller to the
> large groups.
>
> That is, IIRC should_we_balance() ensures only 1 CPU out of the group
> continues the load-balancing pass. So if, for example, we have one group
> of 4 CPUs and one group of 2 CPUs, then the group of 2 CPUs will pull
> 1/2 times, while the group of 4 CPUs will pull 1/4 times.
>
> By making sure all groups are of the same level, and thus of equal size,
> this doesn't happen.

So I hacked something that tries to do this, with the notable exception
that it doesn't change the way the local group is generated. Breaking the
assumption that the local group always spans the child domain doesn't sound
like the best thing to do.

Anywho, the below makes it so all !local NUMA groups are built using the
same sched_domain_topology_level. Some of it is absolutely disgusting
(esp. the sched_domains_curr_level stuff), I didn't bother with handling
domain degeneration yet, and I trigger the WARN_ON in get_group()... But at
least the topology gets built!

AFAICT Barry's topology is handled the same. On that sunfire topology, it
pretty much turns all remote groups into groups spanning a single
node. That does almost double the number of groups for some domains,
compared to Barry's current v3.

If that is really a route we want to go down, I'll try to clean the below.

(deposit your drinks before going any further)
--->8---
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 8f0f778b7c91..e74f48bdd226 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -187,7 +187,10 @@ struct sched_domain_topology_level {
 	sched_domain_mask_f mask;
 	sched_domain_flags_f sd_flags;
 	int		    flags;
+#ifdef CONFIG_NUMA
 	int		    numa_level;
+	int                 numa_sibling_level;
+#endif
 	struct sd_data      data;
 #ifdef CONFIG_SCHED_DEBUG
 	char                *name;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 3c50cc7285c9..5a9e6a4d5d89 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -742,6 +742,34 @@ enum s_alloc {
 	sa_none,
 };
 
+/*
+ * Topology list, bottom-up.
+ */
+static struct sched_domain_topology_level default_topology[] = {
+#ifdef CONFIG_SCHED_SMT
+	{ cpu_smt_mask, cpu_smt_flags, SD_INIT_NAME(SMT) },
+#endif
+#ifdef CONFIG_SCHED_MC
+	{ cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
+#endif
+	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
+	{ NULL, },
+};
+
+static struct sched_domain_topology_level *sched_domain_topology =
+	default_topology;
+
+#define for_each_sd_topology(tl)			\
+	for (tl = sched_domain_topology; tl->mask; tl++)
+
+void set_sched_topology(struct sched_domain_topology_level *tl)
+{
+	if (WARN_ON_ONCE(sched_smp_initialized))
+		return;
+
+	sched_domain_topology = tl;
+}
+
 /*
  * Return the canonical balance CPU for this group, this is the first CPU
  * of this group that's also in the balance mask.
@@ -955,10 +983,12 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
 	struct sched_group *first = NULL, *last = NULL, *sg;
 	const struct cpumask *span = sched_domain_span(sd);
 	struct cpumask *covered = sched_domains_tmpmask;
+	struct sched_domain_topology_level *tl;
 	struct sd_data *sdd = sd->private;
 	struct sched_domain *sibling;
 	int i;
 
+	tl = container_of(sd->private, struct sched_domain_topology_level, data);
 	cpumask_clear(covered);
 
 	for_each_cpu_wrap(i, span, cpu) {
@@ -982,6 +1012,10 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
 		if (!cpumask_test_cpu(i, sched_domain_span(sibling)))
 			continue;
 
+		/* Don't mess up local group being child sched domain */
+		if (tl->numa_sibling_level != sd->level && i != cpu)
+			sibling = *per_cpu_ptr(sched_domain_topology[tl->numa_sibling_level].data.sd, i);
+
 		sg = build_group_from_child_sched_domain(sibling, cpu);
 		if (!sg)
 			goto fail;
@@ -989,7 +1023,7 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
 		sg_span = sched_group_span(sg);
 		cpumask_or(covered, covered, sg_span);
 
-		init_overlap_sched_group(sd, sg);
+		init_overlap_sched_group(sibling, sg);
 
 		if (!first)
 			first = sg;
@@ -1440,34 +1474,6 @@ sd_init(struct sched_domain_topology_level *tl,
 	return sd;
 }
 
-/*
- * Topology list, bottom-up.
- */
-static struct sched_domain_topology_level default_topology[] = {
-#ifdef CONFIG_SCHED_SMT
-	{ cpu_smt_mask, cpu_smt_flags, SD_INIT_NAME(SMT) },
-#endif
-#ifdef CONFIG_SCHED_MC
-	{ cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
-#endif
-	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
-	{ NULL, },
-};
-
-static struct sched_domain_topology_level *sched_domain_topology =
-	default_topology;
-
-#define for_each_sd_topology(tl)			\
-	for (tl = sched_domain_topology; tl->mask; tl++)
-
-void set_sched_topology(struct sched_domain_topology_level *tl)
-{
-	if (WARN_ON_ONCE(sched_smp_initialized))
-		return;
-
-	sched_domain_topology = tl;
-}
-
 #ifdef CONFIG_NUMA
 
 static const struct cpumask *sd_numa_mask(int cpu)
@@ -1566,6 +1572,52 @@ static void init_numa_topology_type(void)
 
 #define NR_DISTANCE_VALUES (1 << DISTANCE_BITS)
 
+void sched_init_numa_siblings(void)
+{
+	struct sched_domain_topology_level *tl;
+	int tl_id = 0, sibling_tl_id = 0;
+	const struct cpumask *mask;
+	int last_written_tl = 0;
+	int n, i, j;
+
+	for_each_sd_topology(tl) {
+		if (!tl->numa_level)
+			goto next;
+
+		for_each_node(n) {
+			/* XXX: this *thing* needs to die */
+			sched_domains_curr_level = tl->numa_level;
+			i = cpumask_first(cpumask_of_node(n));
+			mask = tl->mask(i);
+
+			for_each_cpu_wrap(j, mask, i) {
+				sibling_tl_id = tl_id;
+				sched_domains_curr_level = tl->numa_level;
+
+				/* Not subset? Down we go! */
+				/* XXX bother about degeneration here? */
+				do {
+					sibling_tl_id--;
+					sched_domains_curr_level--;
+				} while (sibling_tl_id > 0 &&
+					 !cpumask_subset(sched_domain_topology[sibling_tl_id].mask(j), mask));
+
+				/* Only write if first write or it lowers level */
+				if (last_written_tl < tl_id ||
+				    tl->numa_sibling_level > sibling_tl_id) {
+					tl->numa_sibling_level = sibling_tl_id;
+					last_written_tl = tl_id;
+				}
+			}
+		}
+next:
+		if (last_written_tl < tl_id)
+			tl->numa_sibling_level = tl_id;
+
+		tl_id++;
+	}
+}
+
 void sched_init_numa(void)
 {
 	struct sched_domain_topology_level *tl;
@@ -1708,6 +1760,8 @@ void sched_init_numa(void)
 	sched_max_numa_distance = sched_domains_numa_distance[nr_levels - 1];
 
 	init_numa_topology_type();
+
+	sched_init_numa_siblings();
 }
 
 void sched_domains_numa_masks_set(unsigned int cpu)

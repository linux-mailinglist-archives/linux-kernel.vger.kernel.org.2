Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16DB3B9356
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 16:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbhGAObX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 10:31:23 -0400
Received: from foss.arm.com ([217.140.110.172]:55110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231698AbhGAObW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 10:31:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86090D6E;
        Thu,  1 Jul 2021 07:28:51 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87BD63F718;
        Thu,  1 Jul 2021 07:28:49 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Geetika Moolchandani <Geetika.Moolchandani1@ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] sched/topology: Skip updating masks for non-online nodes
In-Reply-To: <20210701041552.112072-2-srikar@linux.vnet.ibm.com>
References: <20210701041552.112072-1-srikar@linux.vnet.ibm.com> <20210701041552.112072-2-srikar@linux.vnet.ibm.com>
Date:   Thu, 01 Jul 2021 15:28:45 +0100
Message-ID: <875yxu85wi.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/21 09:45, Srikar Dronamraju wrote:
> @@ -1891,12 +1894,30 @@ void sched_init_numa(void)
>  void sched_domains_numa_masks_set(unsigned int cpu)
>  {
>       int node = cpu_to_node(cpu);
> -	int i, j;
> +	int i, j, empty;
>
> +	empty = cpumask_empty(sched_domains_numa_masks[0][node]);
>       for (i = 0; i < sched_domains_numa_levels; i++) {
>               for (j = 0; j < nr_node_ids; j++) {
> -			if (node_distance(j, node) <= sched_domains_numa_distance[i])
> +			if (!node_online(j))
> +				continue;
> +
> +			if (node_distance(j, node) <= sched_domains_numa_distance[i]) {
>                               cpumask_set_cpu(cpu, sched_domains_numa_masks[i][j]);
> +
> +				/*
> +				 * We skip updating numa_masks for offline
> +				 * nodes. However now that the node is
> +				 * finally online, CPUs that were added
> +				 * earlier, should now be accommodated into
> +				 * newly oneline node's numa mask.
> +				 */
> +				if (node != j && empty) {
> +					cpumask_or(sched_domains_numa_masks[i][node],
> +							sched_domains_numa_masks[i][node],
> +							sched_domains_numa_masks[0][j]);
> +				}
> +			}

Hmph, so we're playing games with masks of offline nodes - is that really
necessary? Your modification of sched_init_numa() still scans all of the
nodes (regardless of their online status) to build the distance map, and
that is never updated (sched_init_numa() is pretty much an __init
function).

So AFAICT this is all to cope with topology_span_sane() not applying
'cpu_map' to its masks. That seemed fine to me back when I wrote it, but in
light of having bogus distance values for offline nodes, not so much...

What about the below instead?

---
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index b77ad49dc14f..c2d9caad4aa6 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2075,6 +2075,7 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
 static bool topology_span_sane(struct sched_domain_topology_level *tl,
 			      const struct cpumask *cpu_map, int cpu)
 {
+	struct cpumask *intersect = sched_domains_tmpmask;
 	int i;
 
 	/* NUMA levels are allowed to overlap */
@@ -2090,14 +2091,17 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
 	for_each_cpu(i, cpu_map) {
 		if (i == cpu)
 			continue;
+
 		/*
-		 * We should 'and' all those masks with 'cpu_map' to exactly
-		 * match the topology we're about to build, but that can only
-		 * remove CPUs, which only lessens our ability to detect
-		 * overlaps
+		 * We shouldn't have to bother with cpu_map here, unfortunately
+		 * some architectures (powerpc says hello) have to deal with
+		 * offline NUMA nodes reporting bogus distance values. This can
+		 * lead to funky NODE domain spans, but since those are offline
+		 * we can mask them out.
 		 */
+		cpumask_and(intersect, tl->mask(cpu), tl->mask(i));
 		if (!cpumask_equal(tl->mask(cpu), tl->mask(i)) &&
-		    cpumask_intersects(tl->mask(cpu), tl->mask(i)))
+		    cpumask_intersects(intersect, cpu_map))
 			return false;
 	}
 

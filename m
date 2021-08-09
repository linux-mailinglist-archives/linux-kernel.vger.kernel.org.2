Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED933E45EF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 14:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbhHIMxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 08:53:11 -0400
Received: from foss.arm.com ([217.140.110.172]:60148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233093AbhHIMxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 08:53:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FB9A6D;
        Mon,  9 Aug 2021 05:52:49 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B1EA3F718;
        Mon,  9 Aug 2021 05:52:47 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Geetika Moolchandani <Geetika.Moolchandani1@ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] sched/topology: Skip updating masks for non-online nodes
In-Reply-To: <20210809065235.GH4072958@linux.vnet.ibm.com>
References: <20210701041552.112072-1-srikar@linux.vnet.ibm.com> <20210701041552.112072-2-srikar@linux.vnet.ibm.com> <875yxu85wi.mognet@arm.com> <20210712124856.GA3836887@linux.vnet.ibm.com> <87zguqmay9.mognet@arm.com> <20210723143914.GI3836887@linux.vnet.ibm.com> <87h7g09bgg.mognet@arm.com> <20210809065235.GH4072958@linux.vnet.ibm.com>
Date:   Mon, 09 Aug 2021 13:52:38 +0100
Message-ID: <875yweaig9.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/21 12:22, Srikar Dronamraju wrote:
> * Valentin Schneider <valentin.schneider@arm.com> [2021-08-08 16:56:47]:
>> Wait, doesn't the distance matrix (without any offline node) say
>>
>>   distance(0, 3) == 40
>>
>> ? We should have at the very least:
>>
>>   node   0   1   2   3
>>     0:  10  20  ??  40
>>     1:  20  20  ??  40
>>     2:  ??  ??  ??  ??
>>     3:  40  40  ??  10
>>
>
> Before onlining node 3 and CPU 3 (node/CPU 0 and 1 are already online)
> Note: Node 2-7 and CPU 2-7 are still offline.
>
> node   0   1   2   3
>   0:  10  20  40  10
>   1:  20  20  40  10
>   2:  40  40  10  10
>   3:  10  10  10  10
>
> NODE->mask(0) == 0
> NODE->mask(1) == 1
> NODE->mask(2) == 0
> NODE->mask(3) == 0
>
> Note: This is with updating Node 2's distance as 40 for figuring out
> the number of numa levels. Since we have all possible distances, we
> dont update Node 3 distance, so it will be as if its local to node 0.
>
> Now when Node 3 and CPU 3 are onlined
> Note: Node 2, 3-7 and CPU 2, 3-7 are still offline.
>
> node   0   1   2   3
>   0:  10  20  40  40
>   1:  20  20  40  40
>   2:  40  40  10  40
>   3:  40  40  40  10
>
> NODE->mask(0) == 0
> NODE->mask(1) == 1
> NODE->mask(2) == 0
> NODE->mask(3) == 0,3
>
> CPU 0 continues to be part of Node->mask(3) because when we online and
> we find the right distance, there is no API to reset the numa mask of
> 3 to remove CPU 0 from the numa masks.
>
> If we had an API to clear/set sched_domains_numa_masks[node][] when
> the node state changes, we could probably plug-in to clear/set the
> node masks whenever node state changes.
>

Gotcha, this is now coming back to me...

[...]

>> Ok, so it looks like we really can't do without that part - even if we get
>> "sensible" distance values for the online nodes, we can't divine values for
>> the offline ones.
>>
>
> Yes
>

Argh, while your approach does take care of the masks, it leaves
sched_numa_topology_type unchanged. You *can* force an update of it, but
yuck :(

I got to the below...

---
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Date: Thu, 1 Jul 2021 09:45:51 +0530
Subject: [PATCH 1/1] sched/topology: Skip updating masks for non-online nodes

The scheduler currently expects NUMA node distances to be stable from init
onwards, and as a consequence builds the related data structures
once-and-for-all at init (see sched_init_numa()).

Unfortunately, on some architectures node distance is unreliable for
offline nodes and may very well change upon onlining.

Skip over offline nodes during sched_init_numa(). Track nodes that have
been onlined at least once, and trigger a build of a node's NUMA masks when
it is first onlined post-init.

Reported-by: Geetika Moolchandani <Geetika.Moolchandani1@ibm.com>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/topology.c | 65 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index b77ad49dc14f..cba95793a9b7 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1482,6 +1482,8 @@ int				sched_max_numa_distance;
 static int			*sched_domains_numa_distance;
 static struct cpumask		***sched_domains_numa_masks;
 int __read_mostly		node_reclaim_distance = RECLAIM_DISTANCE;
+
+static unsigned long __read_mostly *sched_numa_onlined_nodes;
 #endif
 
 /*
@@ -1833,6 +1835,16 @@ void sched_init_numa(void)
 			sched_domains_numa_masks[i][j] = mask;
 
 			for_each_node(k) {
+				/*
+				 * Distance information can be unreliable for
+				 * offline nodes, defer building the node
+				 * masks to its bringup.
+				 * This relies on all unique distance values
+				 * still being visible at init time.
+				 */
+				if (!node_online(j))
+					continue;
+
 				if (sched_debug() && (node_distance(j, k) != node_distance(k, j)))
 					sched_numa_warn("Node-distance not symmetric");
 
@@ -1886,6 +1898,53 @@ void sched_init_numa(void)
 	sched_max_numa_distance = sched_domains_numa_distance[nr_levels - 1];
 
 	init_numa_topology_type();
+
+	sched_numa_onlined_nodes = bitmap_alloc(nr_node_ids, GFP_KERNEL);
+	if (!sched_numa_onlined_nodes)
+		return;
+
+	bitmap_zero(sched_numa_onlined_nodes, nr_node_ids);
+	for_each_online_node(i)
+		bitmap_set(sched_numa_onlined_nodes, i, 1);
+}
+
+void __sched_domains_numa_masks_set(unsigned int node)
+{
+	int i, j;
+
+	/*
+	 * NUMA masks are not built for offline nodes in sched_init_numa().
+	 * Thus, when a CPU of a never-onlined-before node gets plugged in,
+	 * adding that new CPU to the right NUMA masks is not sufficient: the
+	 * masks of that CPU's node must also be updated.
+	 */
+	if (test_bit(node, sched_numa_onlined_nodes))
+		return;
+
+	bitmap_set(sched_numa_onlined_nodes, node, 1);
+
+	for (i = 0; i < sched_domains_numa_levels; i++) {
+		for (j = 0; j < nr_node_ids; j++) {
+			if (!node_online(j) || node == j)
+				continue;
+
+			if (node_distance(j, node) > sched_domains_numa_distance[i])
+				continue;
+
+			/* Add remote nodes in our masks */
+			cpumask_or(sched_domains_numa_masks[i][node],
+				   sched_domains_numa_masks[i][node],
+				   sched_domains_numa_masks[0][j]);
+		}
+	}
+
+	/*
+	 * A new node has been brought up, potentially changing the topology
+	 * classification.
+	 *
+	 * Note that this is racy vs any use of sched_numa_topology_type :/
+	 */
+	init_numa_topology_type();
 }
 
 void sched_domains_numa_masks_set(unsigned int cpu)
@@ -1893,8 +1952,14 @@ void sched_domains_numa_masks_set(unsigned int cpu)
 	int node = cpu_to_node(cpu);
 	int i, j;
 
+	__sched_domains_numa_masks_set(node);
+
 	for (i = 0; i < sched_domains_numa_levels; i++) {
 		for (j = 0; j < nr_node_ids; j++) {
+			if (!node_online(j))
+				continue;
+
+			/* Set ourselves in the remote node's masks */
 			if (node_distance(j, node) <= sched_domains_numa_distance[i])
 				cpumask_set_cpu(cpu, sched_domains_numa_masks[i][j]);
 		}
-- 
2.25.1


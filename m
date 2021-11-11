Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152AE44D2AD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 08:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhKKHvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 02:51:40 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:59040 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229649AbhKKHvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 02:51:36 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Uw0LcS2_1636616925;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Uw0LcS2_1636616925)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Nov 2021 15:48:45 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, ying.huang@intel.com,
        dave.hansen@linux.intel.com
Cc:     ziy@nvidia.com, osalvador@suse.de, shy828301@gmail.com,
        baolin.wang@linux.alibaba.com, zhongjiang-ali@linux.alibaba.com,
        xlpang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mm: migrate: Support multiple target nodes demotion
Date:   Thu, 11 Nov 2021 15:48:34 +0800
Message-Id: <ae040cf8152f085e216c5ad862e03f7d62464c0d.1636616548.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1636616548.git.baolin.wang@linux.alibaba.com>
References: <cover.1636616548.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1636616548.git.baolin.wang@linux.alibaba.com>
References: <cover.1636616548.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have some machines with multiple memory types like below, which
have one fast (DRAM) memory node and two slow (persistent memory) memory
nodes. According to current node demotion policy, if node 0 fills up,
its memory should be migrated to node 1, when node 1 fills up, its
memory will be migrated to node 2: node 0 -> node 1 -> node 2 ->stop.

But this is not efficient and suitbale memory migration route
for our machine with multiple slow memory nodes. Since the distance
between node 0 to node 1 and node 0 to node 2 is equal, and memory
migration between slow memory nodes will increase persistent memory
bandwidth greatly, which will hurt the whole system's performance.

Thus for this case, we can treat the slow memory node 1 and node 2
as a whole slow memory region, and we should migrate memory from
node 0 to node 1 and node 2 if node 0 fills up.

This patch changes the node_demotion data structure to support multiple
target nodes, and establishes the migration path to support multiple
target nodes with validating if the node distance is the best or not.

available: 3 nodes (0-2)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
node 0 size: 62153 MB
node 0 free: 55135 MB
node 1 cpus:
node 1 size: 127007 MB
node 1 free: 126930 MB
node 2 cpus:
node 2 size: 126968 MB
node 2 free: 126878 MB
node distances:
node   0   1   2
  0:  10  20  20
  1:  20  10  20
  2:  20  20  10

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/migrate.c | 138 +++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 102 insertions(+), 36 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index cf25b00..126e9e6 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -50,6 +50,7 @@
 #include <linux/ptrace.h>
 #include <linux/oom.h>
 #include <linux/memory.h>
+#include <linux/random.h>
 
 #include <asm/tlbflush.h>
 
@@ -1119,12 +1120,25 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
  *
  * This is represented in the node_demotion[] like this:
  *
- *	{  1, // Node 0 migrates to 1
- *	   2, // Node 1 migrates to 2
- *	  -1, // Node 2 does not migrate
- *	   4, // Node 3 migrates to 4
- *	   5, // Node 4 migrates to 5
- *	  -1} // Node 5 does not migrate
+ *	{  nr=1, nodes[0]=1 }, // Node 0 migrates to 1
+ *	{  nr=1, nodes[0]=2 }, // Node 1 migrates to 2
+ *	{  nr=0, nodes[0]=-1 }, // Node 2 does not migrate
+ *	{  nr=1, nodes[0]=4 }, // Node 3 migrates to 4
+ *	{  nr=1, nodes[0]=5 }, // Node 4 migrates to 5
+ *	{  nr=0, nodes[0]=-1 }, // Node 5 does not migrate
+ *
+ * Moreover some systems may have multiple slow memory nodes.
+ * Suppose a system has one socket with 3 memory nodes, node 0
+ * is fast memory type, and node 1/2 both are slow memory
+ * type, and the distance between fast memory node and slow
+ * memory node is same. So the migration path should be:
+ *
+ *	0 -> 1/2 -> stop
+ *
+ * This is represented in the node_demotion[] like this:
+ *	{ nr=2, {nodes[0]=1, nodes[1]=2} }, // Node 0 migrates to node 1 and node 2
+ *	{ nr=0, nodes[0]=-1, }, // Node 1 dose not migrate
+ *	{ nr=0, nodes[0]=-1, }, // Node 2 does not migrate
  */
 
 /*
@@ -1135,8 +1149,13 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
  * must be held over all reads to ensure that no cycles are
  * observed.
  */
-static int node_demotion[MAX_NUMNODES] __read_mostly =
-	{[0 ...  MAX_NUMNODES - 1] = NUMA_NO_NODE};
+#define DEFAULT_DEMOTION_TARGET_NODES 15
+struct demotion_nodes {
+	unsigned short nr;
+	short nodes[DEFAULT_DEMOTION_TARGET_NODES];
+};
+
+static struct demotion_nodes node_demotion[MAX_NUMNODES] __read_mostly;
 
 /**
  * next_demotion_node() - Get the next node in the demotion path
@@ -1149,6 +1168,8 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
  */
 int next_demotion_node(int node)
 {
+	struct demotion_nodes *nd = &node_demotion[node];
+	unsigned short target_nr, index;
 	int target;
 
 	/*
@@ -1161,9 +1182,25 @@ int next_demotion_node(int node)
 	 * node_demotion[] reads need to be consistent.
 	 */
 	rcu_read_lock();
-	target = READ_ONCE(node_demotion[node]);
-	rcu_read_unlock();
+	target_nr = READ_ONCE(nd->nr);
+
+	if (target_nr == 0) {
+		target = NUMA_NO_NODE;
+		goto out;
+	} else if (target_nr == 1) {
+		index = 0;
+	} else {
+		/*
+		 * If there are multiple target nodes, just select one
+		 * target node randomly.
+		 */
+		index = get_random_int() % target_nr;
+	}
+
+	target = READ_ONCE(nd->nodes[index]);
 
+out:
+	rcu_read_unlock();
 	return target;
 }
 
@@ -2974,10 +3011,13 @@ void migrate_vma_finalize(struct migrate_vma *migrate)
 /* Disable reclaim-based migration. */
 static void __disable_all_migrate_targets(void)
 {
-	int node;
+	int node, i;
 
-	for_each_online_node(node)
-		node_demotion[node] = NUMA_NO_NODE;
+	for_each_online_node(node) {
+		node_demotion[node].nr = 0;
+		for (i = 0; i < DEFAULT_DEMOTION_TARGET_NODES; i++)
+			node_demotion[node].nodes[i] = NUMA_NO_NODE;
+	}
 }
 
 static void disable_all_migrate_targets(void)
@@ -3004,26 +3044,35 @@ static void disable_all_migrate_targets(void)
  * Failing here is OK.  It might just indicate
  * being at the end of a chain.
  */
-static int establish_migrate_target(int node, nodemask_t *used)
+static int establish_migrate_target(int node, nodemask_t *used,
+				    int best_distance)
 {
-	int migration_target;
+	int migration_target, index, val;
+	struct demotion_nodes *nd = &node_demotion[node];
+
+	migration_target = find_next_best_node(node, used);
+	if (migration_target == NUMA_NO_NODE)
+		return NUMA_NO_NODE;
 
 	/*
-	 * Can not set a migration target on a
-	 * node with it already set.
-	 *
-	 * No need for READ_ONCE() here since this
-	 * in the write path for node_demotion[].
-	 * This should be the only thread writing.
+	 * If the node has been set a migration target node before,
+	 * which means it's the best distance between them. Still
+	 * check if this node can be demoted to other target nodes
+	 * if they have a same best distance.
 	 */
-	if (node_demotion[node] != NUMA_NO_NODE)
-		return NUMA_NO_NODE;
+	if (best_distance != -1) {
+		val = node_distance(node, migration_target);
+		if (val > best_distance)
+			return NUMA_NO_NODE;
+	}
 
-	migration_target = find_next_best_node(node, used);
-	if (migration_target == NUMA_NO_NODE)
+	index = nd->nr;
+	if (WARN_ONCE(index >= DEFAULT_DEMOTION_TARGET_NODES,
+		      "Exceeds maximum demotion target nodes\n"))
 		return NUMA_NO_NODE;
 
-	node_demotion[node] = migration_target;
+	nd->nodes[index] = migration_target;
+	nd->nr++;
 
 	return migration_target;
 }
@@ -3039,7 +3088,9 @@ static int establish_migrate_target(int node, nodemask_t *used)
  *
  * The difference here is that cycles must be avoided.  If
  * node0 migrates to node1, then neither node1, nor anything
- * node1 migrates to can migrate to node0.
+ * node1 migrates to can migrate to node0. Also one node can
+ * be migrated to multiple nodes if the target nodes all have
+ * a same best-distance against the source node.
  *
  * This function can run simultaneously with readers of
  * node_demotion[].  However, it can not run simultaneously
@@ -3051,7 +3102,7 @@ static void __set_migration_target_nodes(void)
 	nodemask_t next_pass	= NODE_MASK_NONE;
 	nodemask_t this_pass	= NODE_MASK_NONE;
 	nodemask_t used_targets = NODE_MASK_NONE;
-	int node;
+	int node, best_distance;
 
 	/*
 	 * Avoid any oddities like cycles that could occur
@@ -3080,18 +3131,33 @@ static void __set_migration_target_nodes(void)
 	 * multiple source nodes to share a destination.
 	 */
 	nodes_or(used_targets, used_targets, this_pass);
-	for_each_node_mask(node, this_pass) {
-		int target_node = establish_migrate_target(node, &used_targets);
 
-		if (target_node == NUMA_NO_NODE)
-			continue;
+	for_each_node_mask(node, this_pass) {
+		best_distance = -1;
 
 		/*
-		 * Visit targets from this pass in the next pass.
-		 * Eventually, every node will have been part of
-		 * a pass, and will become set in 'used_targets'.
+		 * Try to set up the migration path for the node, and the target
+		 * migration nodes can be multiple, so doing a loop to find all
+		 * the target nodes if they all have a best node distance.
 		 */
-		node_set(target_node, next_pass);
+		do {
+			int target_node =
+				establish_migrate_target(node, &used_targets,
+							 best_distance);
+
+			if (target_node == NUMA_NO_NODE)
+				break;
+
+			if (best_distance == -1)
+				best_distance = node_distance(node, target_node);
+
+			/*
+			 * Visit targets from this pass in the next pass.
+			 * Eventually, every node will have been part of
+			 * a pass, and will become set in 'used_targets'.
+			 */
+			node_set(target_node, next_pass);
+		} while (1);
 	}
 	/*
 	 * 'next_pass' contains nodes which became migration
-- 
1.8.3.1


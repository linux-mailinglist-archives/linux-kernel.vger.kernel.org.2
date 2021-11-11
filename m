Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D27244D2AE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 08:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbhKKHvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 02:51:49 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:34766 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231367AbhKKHvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 02:51:37 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Uw0LcSB_1636616926;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Uw0LcSB_1636616926)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Nov 2021 15:48:46 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, ying.huang@intel.com,
        dave.hansen@linux.intel.com
Cc:     ziy@nvidia.com, osalvador@suse.de, shy828301@gmail.com,
        baolin.wang@linux.alibaba.com, zhongjiang-ali@linux.alibaba.com,
        xlpang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mm: migrate: Allocate the node_demotion structure dynamically
Date:   Thu, 11 Nov 2021 15:48:35 +0800
Message-Id: <e39502af91e12ba1a4bef3be4d05b11b2c7a7a9f.1636616548.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1636616548.git.baolin.wang@linux.alibaba.com>
References: <cover.1636616548.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1636616548.git.baolin.wang@linux.alibaba.com>
References: <cover.1636616548.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the worst case (MAX_NUMNODES=1024), the node_demotion structure can
consume 32k bytes, which appears too large, so we can change to allocate
node_demotion dynamically at initialization time. Meanwhile allocating
the target demotion nodes array dynamically to select a suitable size
according to the MAX_NUMNODES.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/migrate.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 126e9e6..0145b38 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1152,10 +1152,11 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 #define DEFAULT_DEMOTION_TARGET_NODES 15
 struct demotion_nodes {
 	unsigned short nr;
-	short nodes[DEFAULT_DEMOTION_TARGET_NODES];
+	short nodes[];
 };
 
-static struct demotion_nodes node_demotion[MAX_NUMNODES] __read_mostly;
+static struct demotion_nodes *node_demotion[MAX_NUMNODES] __read_mostly;
+static unsigned short target_nodes_max;
 
 /**
  * next_demotion_node() - Get the next node in the demotion path
@@ -1168,10 +1169,13 @@ struct demotion_nodes {
  */
 int next_demotion_node(int node)
 {
-	struct demotion_nodes *nd = &node_demotion[node];
+	struct demotion_nodes *nd = node_demotion[node];
 	unsigned short target_nr, index;
 	int target;
 
+	if (!nd)
+		return NUMA_NO_NODE;
+
 	/*
 	 * node_demotion[] is updated without excluding this
 	 * function from running.  RCU doesn't provide any
@@ -3014,9 +3018,9 @@ static void __disable_all_migrate_targets(void)
 	int node, i;
 
 	for_each_online_node(node) {
-		node_demotion[node].nr = 0;
-		for (i = 0; i < DEFAULT_DEMOTION_TARGET_NODES; i++)
-			node_demotion[node].nodes[i] = NUMA_NO_NODE;
+		node_demotion[node]->nr = 0;
+		for (i = 0; i < target_nodes_max; i++)
+			node_demotion[node]->nodes[i] = NUMA_NO_NODE;
 	}
 }
 
@@ -3048,7 +3052,10 @@ static int establish_migrate_target(int node, nodemask_t *used,
 				    int best_distance)
 {
 	int migration_target, index, val;
-	struct demotion_nodes *nd = &node_demotion[node];
+	struct demotion_nodes *nd = node_demotion[node];
+
+	if (WARN_ONCE(!nd, "Can not set up migration path for node:%d\n", node))
+		return NUMA_NO_NODE;
 
 	migration_target = find_next_best_node(node, used);
 	if (migration_target == NUMA_NO_NODE)
@@ -3067,7 +3074,7 @@ static int establish_migrate_target(int node, nodemask_t *used,
 	}
 
 	index = nd->nr;
-	if (WARN_ONCE(index >= DEFAULT_DEMOTION_TARGET_NODES,
+	if (WARN_ONCE(index >= target_nodes_max,
 		      "Exceeds maximum demotion target nodes\n"))
 		return NUMA_NO_NODE;
 
@@ -3256,7 +3263,20 @@ static int migration_offline_cpu(unsigned int cpu)
 
 static int __init migrate_on_reclaim_init(void)
 {
-	int ret;
+	struct demotion_nodes *nd;
+	int ret, node;
+
+	/* Keep the maximum target demotion nodes are less than MAX_NUMNODES. */
+	target_nodes_max = min_t(unsigned short, DEFAULT_DEMOTION_TARGET_NODES,
+				 MAX_NUMNODES - 1);
+	for_each_node(node) {
+		nd = kmalloc(struct_size(nd, nodes, target_nodes_max),
+			     GFP_KERNEL);
+		if (!nd)
+			continue;
+
+		node_demotion[node] = nd;
+	}
 
 	ret = cpuhp_setup_state_nocalls(CPUHP_MM_DEMOTION_DEAD, "mm/demotion:offline",
 					NULL, migration_offline_cpu);
-- 
1.8.3.1


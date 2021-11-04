Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5054450F2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 10:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhKDJQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 05:16:18 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:36814 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230363AbhKDJQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 05:16:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Uv.rX7Z_1636017217;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Uv.rX7Z_1636017217)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 04 Nov 2021 17:13:38 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     ying.huang@intel.com, dave.hansen@linux.intel.com, ziy@nvidia.com,
        osalvador@suse.de, shy828301@gmail.com,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm: migrate: Add new node demotion strategy
Date:   Thu,  4 Nov 2021 17:13:25 +0800
Message-Id: <c02bcbc04faa7a2c852534e9cd58a91c44494657.1636016609.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have some machines with multiple memory types like below, which
have one fast (DRAM) memory node and two slow (persistent memory) memory
nodes. According to current node demotion, if node 0 fills up,
its memory should be migrated to node 1, when node 1 fills up, its
memory will be migrated to node 2: node 0 -> node 1 -> node 2 ->stop.

But this is not efficient and suitbale memory migration route
for our machine with multiple slow memory nodes. Since the distance
between node 0 to node 1 and node 0 to node 2 is equal, and memory
migration between slow memory nodes will increase persistent memory
bandwidth greatly, which will hurt the whole system's performance.

Thus for this case, we can treat the slow memory node 1 and node 2
as a whole slow memory region, and we should migrate memory from
node 0 to node 1 and node 2 if node 0 fills up with a simple round-robin
method to select the target demotion node.

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
 Documentation/ABI/testing/sysfs-kernel-mm-numa |  16 ++++
 mm/migrate.c                                   | 114 ++++++++++++++++++++++++-
 2 files changed, 126 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-numa b/Documentation/ABI/testing/sysfs-kernel-mm-numa
index 77e559d..896e91d 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-numa
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-numa
@@ -22,3 +22,19 @@ Description:	Enable/disable demoting pages during reclaim
 		the guarantees of cpusets.  This should not be enabled
 		on systems which need strict cpuset location
 		guarantees.
+
+What:		/sys/kernel/mm/numa/demotion_mode
+Date:		November 2021
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Set the demotion mode when enabling demoting pages during reclaim
+
+		Specify the demotion mode. "direct" is for the DIRECT_DEMOTION
+		mode if the system's multiple memory types are one to one
+		correspondence, the node distance among the multiple memory types
+		is tiered.
+
+		"multiple" is for the MULTIPLE_DEMOTION mode if the system's
+		multiple memory types are not one to one correspondence, the node
+		distance between fast memory node and slow memory nodes is equal,
+		which means one fast memory node can be demoted to multiple slow
+		memory nodes.
diff --git a/mm/migrate.c b/mm/migrate.c
index a11e948..a43726d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1099,6 +1099,33 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 	return rc;
 }
 
+/*
+ * DIRECT_DEMOTION mode is for the system that multiple
+ * memory types are one to one correspondence, the node
+ * distance among the multiple memory types is tiered.
+ * For example, there are 3 memory types in one system:
+ * fast (node 0), medium (node 1) and slow (node 2). So
+ * the memory migration route should be:
+ * node 0 -> node 1 -> node 2 -> stop.
+ *
+ * MULTIPLE_DEMOTION mode is for the system that multiple
+ * memory types are not one to one correspondence, the node
+ * distance between fast memory node and slow memory nodes
+ * is equal. For example, there are 2 memory types in one
+ * system with 3 memory nodes: fast (node 0), slow (node 1),
+ * slow (node 2), and the distance between node 0 to node 1
+ * and node 0 to node 2 is equal. In this case, we should
+ * not migrate memory among slow memory nodes, instead we
+ * should treat node 1 and node 2 as a whole slow memory,
+ * so the memory migration route should be:
+ * node 0 -> node 1/2 -> stop.
+ */
+enum demotion_mode {
+	DIRECT_DEMOTION,
+	MULTIPLE_DEMOTION,
+};
+
+static enum demotion_mode numa_demotion_mode = DIRECT_DEMOTION;
 
 /*
  * node_demotion[] example:
@@ -1144,6 +1171,13 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 static int node_demotion[MAX_NUMNODES] __read_mostly =
 	{[0 ...  MAX_NUMNODES - 1] = NUMA_NO_NODE};
 
+/*
+ * Used for one fast memory node to multiple slow memory nodes,
+ * to select the next target demotion node.
+ */
+static atomic_t next_demote_node[MAX_NUMNODES] =
+	{[0 ...  MAX_NUMNODES - 1] = ATOMIC_INIT(NUMA_NO_NODE)};
+
 /**
  * next_demotion_node() - Get the next node in the demotion path
  * @node: The starting node to lookup the next node
@@ -1155,7 +1189,8 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
  */
 int next_demotion_node(int node)
 {
-	int target;
+	nodemask_t target_nodes = NODE_MASK_NONE;
+	int target = NUMA_NO_NODE, src = node;
 
 	/*
 	 * node_demotion[] is updated without excluding this
@@ -1166,9 +1201,52 @@ int next_demotion_node(int node)
 	 * Make sure to use RCU over entire code blocks if
 	 * node_demotion[] reads need to be consistent.
 	 */
-	rcu_read_lock();
-	target = READ_ONCE(node_demotion[node]);
-	rcu_read_unlock();
+	switch (numa_demotion_mode) {
+	case DIRECT_DEMOTION:
+		rcu_read_lock();
+		target = READ_ONCE(node_demotion[node]);
+		rcu_read_unlock();
+		break;
+	case MULTIPLE_DEMOTION:
+		/*
+		 * Only fast memory can be demoted to multiple slow
+		 * memory nodes, and slow memory should not be demoted
+		 * among slow nemory nodes.
+		 */
+		if (!node_state(node, N_CPU))
+			return NUMA_NO_NODE;
+
+		rcu_read_lock();
+		do {
+			target = READ_ONCE(node_demotion[src]);
+			if (target == NUMA_NO_NODE)
+				break;
+
+			node_set(target, target_nodes);
+			src = target;
+		} while (1);
+		rcu_read_unlock();
+
+		if (!nodes_empty(target_nodes)) {
+			/*
+			 * When the fast memory can be demoted to multiple
+			 * slow memory nodes, here we choose round-robin
+			 * method to select one target demotion node.
+			 */
+			target = atomic_read(&next_demote_node[node]);
+			if (target == NUMA_NO_NODE)
+				target = first_node(target_nodes);
+			atomic_set(&next_demote_node[node],
+				   next_node_in(target, target_nodes));
+		} else {
+			target = NUMA_NO_NODE;
+		}
+
+		break;
+	default:
+		pr_warn("Invalid demotion mode\n");
+		break;
+	}
 
 	return target;
 }
@@ -3330,12 +3408,40 @@ static ssize_t numa_demotion_enabled_store(struct kobject *kobj,
 	return count;
 }
 
+
+static ssize_t numa_demotion_mode_show(struct kobject *kobj,
+				       struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n",
+			  numa_demotion_mode == DIRECT_DEMOTION ?
+			  "direct" : "multiple");
+}
+
+static ssize_t numa_demotion_mode_store(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					const char *buf, size_t count)
+{
+	if (!strncmp(buf, "direct", 6))
+		numa_demotion_mode = DIRECT_DEMOTION;
+	else if (!strncmp(buf, "multiple", 8))
+		numa_demotion_mode = MULTIPLE_DEMOTION;
+	else
+		return -EINVAL;
+
+	return count;
+}
+
 static struct kobj_attribute numa_demotion_enabled_attr =
 	__ATTR(demotion_enabled, 0644, numa_demotion_enabled_show,
 	       numa_demotion_enabled_store);
 
+static struct kobj_attribute numa_demotion_mode_attr =
+	__ATTR(demotion_mode, 0644, numa_demotion_mode_show,
+	       numa_demotion_mode_store);
+
 static struct attribute *numa_attrs[] = {
 	&numa_demotion_enabled_attr.attr,
+	&numa_demotion_mode_attr.attr,
 	NULL,
 };
 
-- 
1.8.3.1


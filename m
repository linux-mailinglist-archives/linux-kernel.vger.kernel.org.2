Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7589D351F3A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 21:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbhDAS4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:56:50 -0400
Received: from mga05.intel.com ([192.55.52.43]:64078 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239355AbhDASye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:54:34 -0400
IronPort-SDR: N5KH4oy+Lrw1rBhboHlm09gIkMauN4UQC/l0dDeR3YG+xGFJdDzo4HjU/OMMOwzKbuQrqjxv7U
 7Oh6k4cZQh1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="277494283"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="277494283"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 11:35:03 -0700
IronPort-SDR: Y0roNlBaLwmP8lEi19A2FmT1Z4gnlFleFU7X65ylshetlv0eFrmuP77Um1v6XSAHXDK+Pc6mF7
 BKvnN7AGyrbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="384946610"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga007.fm.intel.com with ESMTP; 01 Apr 2021 11:35:02 -0700
Subject: [PATCH 03/10] mm/migrate: update node demotion order during on hotplug events
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>, shy828301@gmail.com,
        weixugc@google.com, rientjes@google.com, ying.huang@intel.com,
        dan.j.williams@intel.com, david@redhat.com, osalvador@suse.de
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 01 Apr 2021 11:32:21 -0700
References: <20210401183216.443C4443@viggo.jf.intel.com>
In-Reply-To: <20210401183216.443C4443@viggo.jf.intel.com>
Message-Id: <20210401183221.977831DE@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

Reclaim-based migration is attempting to optimize data placement in
memory based on the system topology.  If the system changes, so must
the migration ordering.

The implementation is conceptually simple and entirely unoptimized.
On any memory or CPU hotplug events, assume that a node was added or
removed and recalculate all migration targets.  This ensures that the
node_demotion[] array is always ready to be used in case the new
reclaim mode is enabled.

This recalculation is far from optimal, most glaringly that it does
not even attempt to figure out the hotplug event would have some
*actual* effect on the demotion order.  But, given the expected
paucity of hotplug events, this should be fine.

=== What does RCU provide? ===

Imaginge a simple loop which walks down the demotion path looking
for the last node:

        terminal_node = start_node;
        while (node_demotion[terminal_node] != NUMA_NO_NODE) {
                terminal_node = node_demotion[terminal_node];
        }

The initial values are:

        node_demotion[0] = 1;
        node_demotion[1] = NUMA_NO_NODE;

and are updated to:

        node_demotion[0] = NUMA_NO_NODE;
        node_demotion[1] = 0;

What guarantees that the loop did not observe:

        node_demotion[0] = 1;
        node_demotion[1] = 0;

and would loop forever?

With RCU, a rcu_read_lock/unlock() can be placed around the
loop.  Since the write side does a synchronize_rcu(), the loop
that observed the old contents is known to be complete after the
synchronize_rcu() has completed.

RCU, combined with disable_all_migrate_targets(), ensures that
the old migration state is not visible by the time
__set_migration_target_nodes() is called.

=== What does READ_ONCE() provide? ===

READ_ONCE() forbids the compiler from merging or reordering
successive reads of node_demotion[].  This ensures that any
updates are *eventually* observed.

Consider the above loop again.  The compiler could theoretically
read the entirety of node_demotion[] into local storage
(registers) and never go back to memory, and *permanently*
observe bad values for node_demotion[].

Note: RCU does not provide any universal compiler-ordering
guarantees:

	https://lore.kernel.org/lkml/20150921204327.GH4029@linux.vnet.ibm.com/

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Cc: Wei Xu <weixugc@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: osalvador <osalvador@suse.de>

--

Changes since 20210302:
 * remove duplicate synchronize_rcu()
---

 b/mm/migrate.c |  152 ++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 129 insertions(+), 23 deletions(-)

diff -puN mm/migrate.c~enable-numa-demotion mm/migrate.c
--- a/mm/migrate.c~enable-numa-demotion	2021-03-31 15:17:13.056000258 -0700
+++ b/mm/migrate.c	2021-03-31 15:17:13.062000258 -0700
@@ -49,6 +49,7 @@
 #include <linux/sched/mm.h>
 #include <linux/ptrace.h>
 #include <linux/oom.h>
+#include <linux/memory.h>
 
 #include <asm/tlbflush.h>
 
@@ -1198,8 +1199,12 @@ out:
  */
 
 /*
- * Writes to this array occur without locking.  READ_ONCE()
- * is recommended for readers to ensure consistent reads.
+ * Writes to this array occur without locking.  Cycles are
+ * not allowed: Node X demotes to Y which demotes to X...
+ *
+ * If multiple reads are performed, a single rcu_read_lock()
+ * must be held over all reads to ensure that no cycles are
+ * observed.
  */
 static int node_demotion[MAX_NUMNODES] __read_mostly =
 	{[0 ...  MAX_NUMNODES - 1] = NUMA_NO_NODE};
@@ -1215,13 +1220,22 @@ static int node_demotion[MAX_NUMNODES] _
  */
 int next_demotion_node(int node)
 {
+	int target;
+
 	/*
-	 * node_demotion[] is updated without excluding
-	 * this function from running.  READ_ONCE() avoids
-	 * reading multiple, inconsistent 'node' values
-	 * during an update.
+	 * node_demotion[] is updated without excluding this
+	 * function from running.  RCU doesn't provide any
+	 * compiler barriers, so the READ_ONCE() is required
+	 * to avoid compiler reordering or read merging.
+	 *
+	 * Make sure to use RCU over entire code blocks if
+	 * node_demotion[] reads need to be consistent.
 	 */
-	return READ_ONCE(node_demotion[node]);
+	rcu_read_lock();
+	target = READ_ONCE(node_demotion[node]);
+	rcu_read_unlock();
+
+	return target;
 }
 
 /*
@@ -3226,8 +3240,9 @@ void migrate_vma_finalize(struct migrate
 EXPORT_SYMBOL(migrate_vma_finalize);
 #endif /* CONFIG_DEVICE_PRIVATE */
 
+#if defined(CONFIG_MEMORY_HOTPLUG)
 /* Disable reclaim-based migration. */
-static void disable_all_migrate_targets(void)
+static void __disable_all_migrate_targets(void)
 {
 	int node;
 
@@ -3235,6 +3250,25 @@ static void disable_all_migrate_targets(
 		node_demotion[node] = NUMA_NO_NODE;
 }
 
+static void disable_all_migrate_targets(void)
+{
+	__disable_all_migrate_targets();
+
+	/*
+	 * Ensure that the "disable" is visible across the system.
+	 * Readers will see either a combination of before+disable
+	 * state or disable+after.  They will never see before and
+	 * after state together.
+	 *
+	 * The before+after state together might have cycles and
+	 * could cause readers to do things like loop until this
+	 * function finishes.  This ensures they can only see a
+	 * single "bad" read and would, for instance, only loop
+	 * once.
+	 */
+	synchronize_rcu();
+}
+
 /*
  * Find an automatic demotion target for 'node'.
  * Failing here is OK.  It might just indicate
@@ -3297,20 +3331,6 @@ static void __set_migration_target_nodes
 	disable_all_migrate_targets();
 
 	/*
-	 * Ensure that the "disable" is visible across the system.
-	 * Readers will see either a combination of before+disable
-	 * state or disable+after.  They will never see before and
-	 * after state together.
-	 *
-	 * The before+after state together might have cycles and
-	 * could cause readers to do things like loop until this
-	 * function finishes.  This ensures they can only see a
-	 * single "bad" read and would, for instance, only loop
-	 * once.
-	 */
-	smp_wmb();
-
-	/*
 	 * Allocations go close to CPUs, first.  Assume that
 	 * the migration path starts at the nodes with CPUs.
 	 */
@@ -3347,10 +3367,96 @@ again:
 /*
  * For callers that do not hold get_online_mems() already.
  */
-__maybe_unused // <- temporay to prevent warnings during bisects
 static void set_migration_target_nodes(void)
 {
 	get_online_mems();
 	__set_migration_target_nodes();
 	put_online_mems();
 }
+
+/*
+ * React to hotplug events that might affect the migration targets
+ * like events that online or offline NUMA nodes.
+ *
+ * The ordering is also currently dependent on which nodes have
+ * CPUs.  That means we need CPU on/offline notification too.
+ */
+static int migration_online_cpu(unsigned int cpu)
+{
+	set_migration_target_nodes();
+	return 0;
+}
+
+static int migration_offline_cpu(unsigned int cpu)
+{
+	set_migration_target_nodes();
+	return 0;
+}
+
+/*
+ * This leaves migrate-on-reclaim transiently disabled between
+ * the MEM_GOING_OFFLINE and MEM_OFFLINE events.  This runs
+ * whether reclaim-based migration is enabled or not, which
+ * ensures that the user can turn reclaim-based migration at
+ * any time without needing to recalculate migration targets.
+ *
+ * These callbacks already hold get_online_mems().  That is why
+ * __set_migration_target_nodes() can be used as opposed to
+ * set_migration_target_nodes().
+ */
+static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
+						 unsigned long action, void *arg)
+{
+	switch (action) {
+	case MEM_GOING_OFFLINE:
+		/*
+		 * Make sure there are not transient states where
+		 * an offline node is a migration target.  This
+		 * will leave migration disabled until the offline
+		 * completes and the MEM_OFFLINE case below runs.
+		 */
+		disable_all_migrate_targets();
+		break;
+	case MEM_OFFLINE:
+	case MEM_ONLINE:
+		/*
+		 * Recalculate the target nodes once the node
+		 * reaches its final state (online or offline).
+		 */
+		__set_migration_target_nodes();
+		break;
+	case MEM_CANCEL_OFFLINE:
+		/*
+		 * MEM_GOING_OFFLINE disabled all the migration
+		 * targets.  Reenable them.
+		 */
+		__set_migration_target_nodes();
+		break;
+	case MEM_GOING_ONLINE:
+	case MEM_CANCEL_ONLINE:
+		break;
+	}
+
+	return notifier_from_errno(0);
+}
+
+static int __init migrate_on_reclaim_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "migrate on reclaim",
+				migration_online_cpu,
+				migration_offline_cpu);
+	/*
+	 * In the unlikely case that this fails, the automatic
+	 * migration targets may become suboptimal for nodes
+	 * where N_CPU changes.  With such a small impact in a
+	 * rare case, do not bother trying to do anything special.
+	 */
+	WARN_ON(ret < 0);
+
+	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
+	return 0;
+}
+late_initcall(migrate_on_reclaim_init);
+#endif /* CONFIG_MEMORY_HOTPLUG */
_

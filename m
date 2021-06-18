Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1C93AC3BE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 08:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhFRGWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 02:22:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:4815 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233226AbhFRGTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 02:19:19 -0400
IronPort-SDR: Cm6EV3T42ccF9ITmuIpoHDOfFjXEaO81sU1a3/b8JcjnZFO1HT5KaSr/zBMbC7USWrjp2srNTx
 5ehPSewSfGwQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="193815238"
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="193815238"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 23:16:14 -0700
IronPort-SDR: +kvNgZS2RAM3Y/5W3lGx53DcwEVJtUWVpa1c9dUTmXCr+hUba1Q/gv67Wb3FNU7glEmGH9sMRf
 cfn8RCJVN12Q==
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="485573628"
Received: from mzhou6-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.212.155])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 23:16:11 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Wei Xu <weixugc@google.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        osalvador <osalvador@suse.de>
Subject: [PATCH -V8 03/10] mm/migrate: update node demotion order during on hotplug events
Date:   Fri, 18 Jun 2021 14:15:30 +0800
Message-Id: <20210618061537.434999-4-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210618061537.434999-1-ying.huang@intel.com>
References: <20210618061537.434999-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Xu <weixugc@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: osalvador <osalvador@suse.de>

--

Changes since 20210302:
 * remove duplicate synchronize_rcu()
---
 mm/migrate.c | 152 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 129 insertions(+), 23 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 111f8565f75d..0aad54d6c8f9 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -49,6 +49,7 @@
 #include <linux/sched/mm.h>
 #include <linux/ptrace.h>
 #include <linux/oom.h>
+#include <linux/memory.h>
 
 #include <asm/tlbflush.h>
 
@@ -1171,8 +1172,12 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
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
@@ -1188,13 +1193,22 @@ static int node_demotion[MAX_NUMNODES] __read_mostly =
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
@@ -3189,8 +3203,9 @@ void migrate_vma_finalize(struct migrate_vma *migrate)
 EXPORT_SYMBOL(migrate_vma_finalize);
 #endif /* CONFIG_DEVICE_PRIVATE */
 
+#if defined(CONFIG_MEMORY_HOTPLUG)
 /* Disable reclaim-based migration. */
-static void disable_all_migrate_targets(void)
+static void __disable_all_migrate_targets(void)
 {
 	int node;
 
@@ -3198,6 +3213,25 @@ static void disable_all_migrate_targets(void)
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
@@ -3259,20 +3293,6 @@ static void __set_migration_target_nodes(void)
 	 */
 	disable_all_migrate_targets();
 
-	/*
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
 	/*
 	 * Allocations go close to CPUs, first.  Assume that
 	 * the migration path starts at the nodes with CPUs.
@@ -3310,10 +3330,96 @@ static void __set_migration_target_nodes(void)
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
-- 
2.30.2


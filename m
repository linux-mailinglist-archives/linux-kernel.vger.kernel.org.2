Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BF33B3D6B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 09:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhFYHf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 03:35:26 -0400
Received: from mga09.intel.com ([134.134.136.24]:29623 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229616AbhFYHfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 03:35:22 -0400
IronPort-SDR: AO7iqeKXdBxwtcavF5kvM74gVZCNkQlrckFW8PT2prdPE1SwInWZIh4ID5XN87YU/cut8mdQoP
 tm7oP3FGGp6g==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="207562655"
X-IronPort-AV: E=Sophos;i="5.83,298,1616482800"; 
   d="scan'208";a="207562655"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 00:32:56 -0700
IronPort-SDR: 57bFz641bh4+zBWvgoC8b60NzkhaxaEDil/SDzRnWgwXm6rTcyWMllv4Hq2/p2wURgaHbGOaW8
 HlSuzDOUiLrA==
X-IronPort-AV: E=Sophos;i="5.83,298,1616482800"; 
   d="scan'208";a="488085702"
Received: from msun2-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.215.50])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 00:32:50 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>, Wei Xu <weixugc@google.com>,
        Zi Yan <ziy@nvidia.com>, David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH -V9 1/9] mm/numa: add node demotion data structure
Date:   Fri, 25 Jun 2021 15:31:56 +0800
Message-Id: <20210625073204.1005986-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210625073204.1005986-1-ying.huang@intel.com>
References: <20210625073204.1005986-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Hansen <dave.hansen@linux.intel.com>

Prepare for the kernel to auto-migrate pages to other memory nodes
with a node migration table. This allows creating single migration
target for each NUMA node to enable the kernel to do NUMA page
migrations instead of simply discarding colder pages. A node with no
target is a "terminal node", so reclaim acts normally there.  The
migration target does not fundamentally _need_ to be a single node,
but this implementation starts there to limit complexity.

When memory fills up on a node, memory contents can be
automatically migrated to another node.  The biggest problems are
knowing when to migrate and to where the migration should be
targeted.

The most straightforward way to generate the "to where" list would
be to follow the page allocator fallback lists.  Those lists
already tell us if memory is full where to look next.  It would
also be logical to move memory in that order.

But, the allocator fallback lists have a fatal flaw: most nodes
appear in all the lists.  This would potentially lead to migration
cycles (A->B, B->A, A->B, ...).

Instead of using the allocator fallback lists directly, keep a
separate node migration ordering.  But, reuse the same data used
to generate page allocator fallback in the first place:
find_next_best_node().

This means that the firmware data used to populate node distances
essentially dictates the ordering for now.  It should also be
architecture-neutral since all NUMA architectures have a working
find_next_best_node().

RCU is used to allow lock-less read of node_demotion[] and prevent
demotion cycles been observed.  If multiple reads of node_demotion[]
are performed, a single rcu_read_lock() must be held over all reads to
ensure no cycles are observed.  Details are as follows.

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

What guarantees that the cycle is not observed:

        node_demotion[0] = 1;
        node_demotion[1] = 0;

and would loop forever?

With RCU, a rcu_read_lock/unlock() can be placed around the
loop.  Since the write side does a synchronize_rcu(), the loop
that observed the old contents is known to be complete before the
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

This code is unused for now.  It will be called later in the
series.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>

--

Changes from 20210618:
 * Merge patches for data structure definition and initialization
 * Move RCU usage from the next patch in series per Zi's comments

Changes from 20210302:
 * Fix typo in node_demotion[] comment

Changes since 20200122:
 * Make node_demotion[] __read_mostly
 * Add big node_demotion[] comment

Changes in July 2020:
 - Remove loop from next_demotion_node() and get_online_mems().
   This means that the node returned by next_demotion_node()
   might now be offline, but the worst case is that the
   allocation fails.  That's fine since it is transient.
---
 mm/internal.h   |   5 ++
 mm/migrate.c    | 216 ++++++++++++++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c |   2 +-
 3 files changed, 222 insertions(+), 1 deletion(-)

diff --git a/mm/internal.h b/mm/internal.h
index 2f1182948aa6..0344cd78e170 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -522,12 +522,17 @@ static inline void mminit_validate_memmodel_limits(unsigned long *start_pfn,
 
 #ifdef CONFIG_NUMA
 extern int node_reclaim(struct pglist_data *, gfp_t, unsigned int);
+extern int find_next_best_node(int node, nodemask_t *used_node_mask);
 #else
 static inline int node_reclaim(struct pglist_data *pgdat, gfp_t mask,
 				unsigned int order)
 {
 	return NODE_RECLAIM_NOSCAN;
 }
+static inline int find_next_best_node(int node, nodemask_t *used_node_mask)
+{
+	return NUMA_NO_NODE;
+}
 #endif
 
 extern int hwpoison_filter(struct page *p);
diff --git a/mm/migrate.c b/mm/migrate.c
index b234c3f3acb7..a4776eb24cac 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1136,6 +1136,80 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 	return rc;
 }
 
+
+/*
+ * node_demotion[] example:
+ *
+ * Consider a system with two sockets.  Each socket has
+ * three classes of memory attached: fast, medium and slow.
+ * Each memory class is placed in its own NUMA node.  The
+ * CPUs are placed in the node with the "fast" memory.  The
+ * 6 NUMA nodes (0-5) might be split among the sockets like
+ * this:
+ *
+ *	Socket A: 0, 1, 2
+ *	Socket B: 3, 4, 5
+ *
+ * When Node 0 fills up, its memory should be migrated to
+ * Node 1.  When Node 1 fills up, it should be migrated to
+ * Node 2.  The migration path start on the nodes with the
+ * processors (since allocations default to this node) and
+ * fast memory, progress through medium and end with the
+ * slow memory:
+ *
+ *	0 -> 1 -> 2 -> stop
+ *	3 -> 4 -> 5 -> stop
+ *
+ * This is represented in the node_demotion[] like this:
+ *
+ *	{  1, // Node 0 migrates to 1
+ *	   2, // Node 1 migrates to 2
+ *	  -1, // Node 2 does not migrate
+ *	   4, // Node 3 migrates to 4
+ *	   5, // Node 4 migrates to 5
+ *	  -1} // Node 5 does not migrate
+ */
+
+/*
+ * Writes to this array occur without locking.  Cycles are
+ * not allowed: Node X demotes to Y which demotes to X...
+ *
+ * If multiple reads are performed, a single rcu_read_lock()
+ * must be held over all reads to ensure that no cycles are
+ * observed.
+ */
+static int node_demotion[MAX_NUMNODES] __read_mostly =
+	{[0 ...  MAX_NUMNODES - 1] = NUMA_NO_NODE};
+
+/**
+ * next_demotion_node() - Get the next node in the demotion path
+ * @node: The starting node to lookup the next node
+ *
+ * @returns: node id for next memory node in the demotion path hierarchy
+ * from @node; NUMA_NO_NODE if @node is terminal.  This does not keep
+ * @node online or guarantee that it *continues* to be the next demotion
+ * target.
+ */
+int next_demotion_node(int node)
+{
+	int target;
+
+	/*
+	 * node_demotion[] is updated without excluding this
+	 * function from running.  RCU doesn't provide any
+	 * compiler barriers, so the READ_ONCE() is required
+	 * to avoid compiler reordering or read merging.
+	 *
+	 * Make sure to use RCU over entire code blocks if
+	 * node_demotion[] reads need to be consistent.
+	 */
+	rcu_read_lock();
+	target = READ_ONCE(node_demotion[node]);
+	rcu_read_unlock();
+
+	return target;
+}
+
 /*
  * Obtain the lock on page, remove all ptes and migrate the page
  * to the newly allocated page in newpage.
@@ -3127,3 +3201,145 @@ void migrate_vma_finalize(struct migrate_vma *migrate)
 }
 EXPORT_SYMBOL(migrate_vma_finalize);
 #endif /* CONFIG_DEVICE_PRIVATE */
+
+/* Disable reclaim-based migration. */
+static void __disable_all_migrate_targets(void)
+{
+	int node;
+
+	for_each_online_node(node)
+		node_demotion[node] = NUMA_NO_NODE;
+}
+
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
+/*
+ * Find an automatic demotion target for 'node'.
+ * Failing here is OK.  It might just indicate
+ * being at the end of a chain.
+ */
+static int establish_migrate_target(int node, nodemask_t *used)
+{
+	int migration_target;
+
+	/*
+	 * Can not set a migration target on a
+	 * node with it already set.
+	 *
+	 * No need for READ_ONCE() here since this
+	 * in the write path for node_demotion[].
+	 * This should be the only thread writing.
+	 */
+	if (node_demotion[node] != NUMA_NO_NODE)
+		return NUMA_NO_NODE;
+
+	migration_target = find_next_best_node(node, used);
+	if (migration_target == NUMA_NO_NODE)
+		return NUMA_NO_NODE;
+
+	node_demotion[node] = migration_target;
+
+	return migration_target;
+}
+
+/*
+ * When memory fills up on a node, memory contents can be
+ * automatically migrated to another node instead of
+ * discarded at reclaim.
+ *
+ * Establish a "migration path" which will start at nodes
+ * with CPUs and will follow the priorities used to build the
+ * page allocator zonelists.
+ *
+ * The difference here is that cycles must be avoided.  If
+ * node0 migrates to node1, then neither node1, nor anything
+ * node1 migrates to can migrate to node0.
+ *
+ * This function can run simultaneously with readers of
+ * node_demotion[].  However, it can not run simultaneously
+ * with itself.  Exclusion is provided by memory hotplug events
+ * being single-threaded.
+ */
+static void __set_migration_target_nodes(void)
+{
+	nodemask_t next_pass	= NODE_MASK_NONE;
+	nodemask_t this_pass	= NODE_MASK_NONE;
+	nodemask_t used_targets = NODE_MASK_NONE;
+	int node;
+
+	/*
+	 * Avoid any oddities like cycles that could occur
+	 * from changes in the topology.  This will leave
+	 * a momentary gap when migration is disabled.
+	 */
+	disable_all_migrate_targets();
+
+	/*
+	 * Allocations go close to CPUs, first.  Assume that
+	 * the migration path starts at the nodes with CPUs.
+	 */
+	next_pass = node_states[N_CPU];
+again:
+	this_pass = next_pass;
+	next_pass = NODE_MASK_NONE;
+	/*
+	 * To avoid cycles in the migration "graph", ensure
+	 * that migration sources are not future targets by
+	 * setting them in 'used_targets'.  Do this only
+	 * once per pass so that multiple source nodes can
+	 * share a target node.
+	 *
+	 * 'used_targets' will become unavailable in future
+	 * passes.  This limits some opportunities for
+	 * multiple source nodes to share a destination.
+	 */
+	nodes_or(used_targets, used_targets, this_pass);
+	for_each_node_mask(node, this_pass) {
+		int target_node = establish_migrate_target(node, &used_targets);
+
+		if (target_node == NUMA_NO_NODE)
+			continue;
+
+		/*
+		 * Visit targets from this pass in the next pass.
+		 * Eventually, every node will have been part of
+		 * a pass, and will become set in 'used_targets'.
+		 */
+		node_set(target_node, next_pass);
+	}
+	/*
+	 * 'next_pass' contains nodes which became migration
+	 * targets in this pass.  Make additional passes until
+	 * no more migrations targets are available.
+	 */
+	if (!nodes_empty(next_pass))
+		goto again;
+}
+
+/*
+ * For callers that do not hold get_online_mems() already.
+ */
+__maybe_unused // <- temporay to prevent warnings during bisects
+static void set_migration_target_nodes(void)
+{
+	get_online_mems();
+	__set_migration_target_nodes();
+	put_online_mems();
+}
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d1f5de1c1283..e033ae2e8bce 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5973,7 +5973,7 @@ static int node_load[MAX_NUMNODES];
  *
  * Return: node id of the found node or %NUMA_NO_NODE if no node is found.
  */
-static int find_next_best_node(int node, nodemask_t *used_node_mask)
+int find_next_best_node(int node, nodemask_t *used_node_mask)
 {
 	int n, val;
 	int min_val = INT_MAX;
-- 
2.30.2


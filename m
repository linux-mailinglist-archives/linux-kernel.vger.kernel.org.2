Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B1C351F3B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 21:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbhDAS4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:56:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:63825 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239313AbhDASyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:54:33 -0400
IronPort-SDR: PWUZ5tsaRf5MQrrUi5WNB++pLSIyfXx0V64TlDpSW86VlY+WVFmrQamvPvrZHV2dWIKnXkgBj5
 fqFLFo1OQYeg==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="277494274"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="277494274"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 11:35:01 -0700
IronPort-SDR: GvF8PqgzgGMeXNbV8u96S0sPLsm/HU8x3emf/wvnYzKioYTanGTexhjuAs9S9hIWpstVo/g4S0
 mIJj+mtMfY/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="416770156"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga007.jf.intel.com with ESMTP; 01 Apr 2021 11:35:01 -0700
Subject: [PATCH 02/10] mm/numa: automatically generate node migration order
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>, shy828301@gmail.com,
        weixugc@google.com, rientjes@google.com, ying.huang@intel.com,
        dan.j.williams@intel.com, david@redhat.com, osalvador@suse.de
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 01 Apr 2021 11:32:19 -0700
References: <20210401183216.443C4443@viggo.jf.intel.com>
In-Reply-To: <20210401183216.443C4443@viggo.jf.intel.com>
Message-Id: <20210401183219.DC1928FA@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

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

The protocol for node_demotion[] access and writing is not
standard.  It has no specific locking and is intended to be read
locklessly.  Readers must take care to avoid observing changes
that appear incoherent.  This was done so that node_demotion[]
locking has no chance of becoming a bottleneck on large systems
with lots of CPUs in direct reclaim.

This code is unused for now.  It will be called later in the
series.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Cc: Wei Xu <weixugc@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: osalvador <osalvador@suse.de>

--

Changes from 20200122:
 * Add big node_demotion[] comment
Changes from 20210302:
 * Fix typo in node_demotion[] comment
---

 b/mm/internal.h   |    5 +
 b/mm/migrate.c    |  175 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 b/mm/page_alloc.c |    2 
 3 files changed, 180 insertions(+), 2 deletions(-)

diff -puN mm/internal.h~auto-setup-default-migration-path-from-firmware mm/internal.h
--- a/mm/internal.h~auto-setup-default-migration-path-from-firmware	2021-03-31 15:17:11.794000261 -0700
+++ b/mm/internal.h	2021-03-31 15:17:11.816000261 -0700
@@ -515,12 +515,17 @@ static inline void mminit_validate_memmo
 
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
diff -puN mm/migrate.c~auto-setup-default-migration-path-from-firmware mm/migrate.c
--- a/mm/migrate.c~auto-setup-default-migration-path-from-firmware	2021-03-31 15:17:11.798000261 -0700
+++ b/mm/migrate.c	2021-03-31 15:17:11.821000261 -0700
@@ -1163,6 +1163,44 @@ out:
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
+ * Writes to this array occur without locking.  READ_ONCE()
+ * is recommended for readers to ensure consistent reads.
+ */
 static int node_demotion[MAX_NUMNODES] __read_mostly =
 	{[0 ...  MAX_NUMNODES - 1] = NUMA_NO_NODE};
 
@@ -1177,7 +1215,13 @@ static int node_demotion[MAX_NUMNODES] _
  */
 int next_demotion_node(int node)
 {
-	return node_demotion[node];
+	/*
+	 * node_demotion[] is updated without excluding
+	 * this function from running.  READ_ONCE() avoids
+	 * reading multiple, inconsistent 'node' values
+	 * during an update.
+	 */
+	return READ_ONCE(node_demotion[node]);
 }
 
 /*
@@ -3181,3 +3225,132 @@ void migrate_vma_finalize(struct migrate
 }
 EXPORT_SYMBOL(migrate_vma_finalize);
 #endif /* CONFIG_DEVICE_PRIVATE */
+
+/* Disable reclaim-based migration. */
+static void disable_all_migrate_targets(void)
+{
+	int node;
+
+	for_each_online_node(node)
+		node_demotion[node] = NUMA_NO_NODE;
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
+	smp_wmb();
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
+		/* Visit targets from this pass in the next pass: */
+		node_set(target_node, next_pass);
+	}
+	/* Is another pass necessary? */
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
diff -puN mm/page_alloc.c~auto-setup-default-migration-path-from-firmware mm/page_alloc.c
--- a/mm/page_alloc.c~auto-setup-default-migration-path-from-firmware	2021-03-31 15:17:11.811000261 -0700
+++ b/mm/page_alloc.c	2021-03-31 15:17:11.826000261 -0700
@@ -5780,7 +5780,7 @@ static int node_load[MAX_NUMNODES];
  *
  * Return: node id of the found node or %NUMA_NO_NODE if no node is found.
  */
-static int find_next_best_node(int node, nodemask_t *used_node_mask)
+int find_next_best_node(int node, nodemask_t *used_node_mask)
 {
 	int n, val;
 	int min_val = INT_MAX;
_

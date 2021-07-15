Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED403C988B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 07:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239941AbhGOFzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 01:55:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:22887 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239479AbhGOFzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:55:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="197661944"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="197661944"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 22:52:20 -0700
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="505591586"
Received: from yhuang6-mobl1.sh.intel.com ([10.238.6.138])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 22:52:17 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Wei Xu <weixugc@google.com>, Zi Yan <ziy@nvidia.com>,
        osalvador <osalvador@suse.de>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH -V10 2/9] mm/migrate: update node demotion order on hotplug events
Date:   Thu, 15 Jul 2021 13:51:38 +0800
Message-Id: <20210715055145.195411-3-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715055145.195411-1-ying.huang@intel.com>
References: <20210715055145.195411-1-ying.huang@intel.com>
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

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: osalvador <osalvador@suse.de>
Cc: David Rientjes <rientjes@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>

--

Changes since 20210618:
 * moved RCU part to the prev patch in series.

Changes since 20210302:
 * remove duplicate synchronize_rcu()
---
 mm/migrate.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index b7a40ab47648..a40c391f9ca7 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -49,6 +49,7 @@
 #include <linux/sched/mm.h>
 #include <linux/ptrace.h>
 #include <linux/oom.h>
+#include <linux/memory.h>
 
 #include <asm/tlbflush.h>
 
@@ -3057,6 +3058,7 @@ void migrate_vma_finalize(struct migrate_vma *migrate)
 EXPORT_SYMBOL(migrate_vma_finalize);
 #endif /* CONFIG_DEVICE_PRIVATE */
 
+#if defined(CONFIG_MEMORY_HOTPLUG)
 /* Disable reclaim-based migration. */
 static void __disable_all_migrate_targets(void)
 {
@@ -3191,10 +3193,96 @@ static void __set_migration_target_nodes(void)
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B68C336DA8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 09:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhCKIT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 03:19:28 -0500
Received: from mga07.intel.com ([134.134.136.100]:25901 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230513AbhCKITQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 03:19:16 -0500
IronPort-SDR: YFwHdgXLppduSin20oEJv+1DbetpmC4ytc3Y6zsWcqpOHyJQUDRlQjCSwbxnecgGKdb2f/H4gw
 4vZiBAoUlMcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="252649026"
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="252649026"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 00:19:16 -0800
IronPort-SDR: ERncwRO8zMBytZG+JnMFW67NHXDyQpV9ccqpNLtPULJCvp9OERVHVtz7Sgph2lrLiC31YTgxCe
 MNf9C4adG45A==
X-IronPort-AV: E=Sophos;i="5.81,239,1610438400"; 
   d="scan'208";a="410527530"
Received: from yhuang6-mobl1.sh.intel.com ([10.238.6.89])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 00:19:13 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [RFC -V6 2/6] memory tiering: add page promotion counter
Date:   Thu, 11 Mar 2021 16:18:17 +0800
Message-Id: <20210311081821.138467-3-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210311081821.138467-1-ying.huang@intel.com>
References: <20210311081821.138467-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To distinguish the number of the memory tiering promoted pages from
that of the originally inter-socket NUMA balancing migrated pages.
The counter is per-node (count in the target node).  So this can be
used to identify promotion imbalance among the NUMA nodes.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/mmzone.h |  3 +++
 include/linux/node.h   |  5 +++++
 mm/migrate.c           | 10 +++++++++-
 mm/vmstat.c            |  3 +++
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b593316bff3d..42daca801c7f 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -206,6 +206,9 @@ enum node_stat_item {
 	NR_KERNEL_SCS_KB,	/* measured in KiB */
 #endif
 	NR_PAGETABLE,		/* used for pagetables */
+#ifdef CONFIG_NUMA_BALANCING
+	PGPROMOTE_SUCCESS,	/* promote successfully */
+#endif
 	NR_VM_NODE_STAT_ITEMS
 };
 
diff --git a/include/linux/node.h b/include/linux/node.h
index 8e5a29897936..26e96fcc66af 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -181,4 +181,9 @@ static inline void register_hugetlbfs_with_node(node_registration_func_t reg,
 
 #define to_node(device) container_of(device, struct node, dev)
 
+static inline bool node_is_toptier(int node)
+{
+	return node_state(node, N_CPU);
+}
+
 #endif /* _LINUX_NODE_H_ */
diff --git a/mm/migrate.c b/mm/migrate.c
index 51c3f203a78f..f434cff9f30e 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2260,8 +2260,13 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 			putback_lru_page(page);
 		}
 		isolated = 0;
-	} else
+	} else {
 		count_vm_numa_event(NUMA_PAGE_MIGRATE);
+		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
+		    !node_is_toptier(page_to_nid(page)) && node_is_toptier(node))
+			mod_node_page_state(NODE_DATA(node), PGPROMOTE_SUCCESS,
+					    nr_succeeded);
+	}
 	BUG_ON(!list_empty(&migratepages));
 	return isolated;
 
@@ -2389,6 +2394,9 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 	mod_node_page_state(page_pgdat(page),
 			NR_ISOLATED_ANON + page_lru,
 			-HPAGE_PMD_NR);
+	if (!node_is_toptier(page_to_nid(page)) && node_is_toptier(node))
+		mod_node_page_state(NODE_DATA(node), PGPROMOTE_SUCCESS,
+				    HPAGE_PMD_NR);
 	return isolated;
 
 out_fail:
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 0450426e7c23..415a31a3a56e 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1215,6 +1215,9 @@ const char * const vmstat_text[] = {
 	"nr_shadow_call_stack",
 #endif
 	"nr_page_table_pages",
+#ifdef CONFIG_NUMA_BALANCING
+	"pgpromote_success",
+#endif
 
 	/* enum writeback_stat_item counters */
 	"nr_dirty_threshold",
-- 
2.30.1


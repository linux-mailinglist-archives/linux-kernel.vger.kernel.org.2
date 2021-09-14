Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3BD40A298
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 03:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbhINBio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 21:38:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:19808 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234541AbhINBil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 21:38:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="307395553"
X-IronPort-AV: E=Sophos;i="5.85,291,1624345200"; 
   d="scan'208";a="307395553"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 18:37:24 -0700
X-IronPort-AV: E=Sophos;i="5.85,291,1624345200"; 
   d="scan'208";a="543575336"
Received: from yhuang6-desk2.sh.intel.com ([10.239.159.119])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 18:37:21 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org
Subject: [PATCH -V8 2/6] memory tiering: add page promotion counter
Date:   Tue, 14 Sep 2021 09:36:57 +0800
Message-Id: <20210914013701.344956-3-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914013701.344956-1-ying.huang@intel.com>
References: <20210914013701.344956-1-ying.huang@intel.com>
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
Cc: Rik van Riel <riel@surriel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Wei Xu <weixugc@google.com>
Cc: osalvador <osalvador@suse.de>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/mmzone.h |  3 +++
 include/linux/node.h   |  5 +++++
 mm/migrate.c           | 11 +++++++++--
 mm/vmstat.c            |  3 +++
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 6a1d79d84675..37ccd6158765 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -209,6 +209,9 @@ enum node_stat_item {
 	NR_PAGETABLE,		/* used for pagetables */
 #ifdef CONFIG_SWAP
 	NR_SWAPCACHE,
+#endif
+#ifdef CONFIG_NUMA_BALANCING
+	PGPROMOTE_SUCCESS,	/* promote successfully */
 #endif
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
index a159a36dd412..6f7a6e2ef41f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2163,6 +2163,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	pg_data_t *pgdat = NODE_DATA(node);
 	int isolated;
 	int nr_remaining;
+	int nr_succeeded;
 	LIST_HEAD(migratepages);
 	new_page_t *new;
 	bool compound;
@@ -2201,7 +2202,8 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 
 	list_add(&page->lru, &migratepages);
 	nr_remaining = migrate_pages(&migratepages, *new, NULL, node,
-				     MIGRATE_ASYNC, MR_NUMA_MISPLACED, NULL);
+				     MIGRATE_ASYNC, MR_NUMA_MISPLACED,
+				     &nr_succeeded);
 	if (nr_remaining) {
 		if (!list_empty(&migratepages)) {
 			list_del(&page->lru);
@@ -2210,8 +2212,13 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 			putback_lru_page(page);
 		}
 		isolated = 0;
-	} else
+	} else {
 		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_pages);
+		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
+		    !node_is_toptier(page_to_nid(page)) && node_is_toptier(node))
+			mod_node_page_state(NODE_DATA(node), PGPROMOTE_SUCCESS,
+					    nr_succeeded);
+	}
 	BUG_ON(!list_empty(&migratepages));
 	return isolated;
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 8ce2620344b2..fff0ec94d795 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1236,6 +1236,9 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_SWAP
 	"nr_swapcached",
 #endif
+#ifdef CONFIG_NUMA_BALANCING
+	"pgpromote_success",
+#endif
 
 	/* enum writeback_stat_item counters */
 	"nr_dirty_threshold",
-- 
2.30.2


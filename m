Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829B93D0918
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 08:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbhGUGBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 02:01:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:44379 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234158AbhGUF7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 01:59:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="272496378"
X-IronPort-AV: E=Sophos;i="5.84,257,1620716400"; 
   d="scan'208";a="272496378"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 23:39:45 -0700
X-IronPort-AV: E=Sophos;i="5.84,257,1620716400"; 
   d="scan'208";a="511390001"
Received: from yhuang6-desk2.sh.intel.com ([10.239.159.119])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 23:39:42 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>, Wei Xu <weixugc@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Thelen <gthelen@google.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH -V11 4/9] mm/migrate: demote pages during reclaim
Date:   Wed, 21 Jul 2021 14:39:21 +0800
Message-Id: <20210721063926.3024591-4-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210721063926.3024591-1-ying.huang@intel.com>
References: <20210721063926.3024591-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Hansen <dave.hansen@linux.intel.com>

This is mostly derived from a patch from Yang Shi:

	https://lore.kernel.org/linux-mm/1560468577-101178-10-git-send-email-yang.shi@linux.alibaba.com/

Add code to the reclaim path (shrink_page_list()) to "demote" data to
another NUMA node instead of discarding the data.  This always avoids the
cost of I/O needed to read the page back in and sometimes avoids the
writeout cost when the page is dirty.

A second pass through shrink_page_list() will be made if any demotions
fail.  This essentially falls back to normal reclaim behavior in the case
that demotions fail.  Previous versions of this patch may have simply
failed to reclaim pages which were eligible for demotion but were unable
to be demoted in practice.

For some cases, for example, MADV_PAGEOUT, the pages are always discarded
instead of demoted to follow the kernel API definition.  Because
MADV_PAGEOUT is defined as freeing specified pages regardless in which
tier they are.

Note: This just adds the start of infrastructure for migration.  It is
actually disabled next to the FIXME in migrate_demote_page_ok().

Link: https://lkml.kernel.org/r/20210715055145.195411-5-ying.huang@intel.com
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Reviewed-by: Wei Xu <weixugc@google.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Greg Thelen <gthelen@google.com>
Cc: Keith Busch <kbusch@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/migrate.h        |  9 ++++
 include/trace/events/migrate.h |  3 +-
 mm/vmscan.c                    | 85 ++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 8ab88d46318e..326250996b4e 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -28,6 +28,7 @@ enum migrate_reason {
 	MR_NUMA_MISPLACED,
 	MR_CONTIG_RANGE,
 	MR_LONGTERM_PIN,
+	MR_DEMOTION,
 	MR_TYPES
 };
 
@@ -167,6 +168,14 @@ struct migrate_vma {
 int migrate_vma_setup(struct migrate_vma *args);
 void migrate_vma_pages(struct migrate_vma *migrate);
 void migrate_vma_finalize(struct migrate_vma *migrate);
+int next_demotion_node(int node);
+
+#else /* CONFIG_MIGRATION disabled: */
+
+static inline int next_demotion_node(int node)
+{
+	return NUMA_NO_NODE;
+}
 
 #endif /* CONFIG_MIGRATION */
 
diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
index 9fb2a3bbcdfb..779f3fad9ecd 100644
--- a/include/trace/events/migrate.h
+++ b/include/trace/events/migrate.h
@@ -21,7 +21,8 @@
 	EM( MR_MEMPOLICY_MBIND,	"mempolicy_mbind")		\
 	EM( MR_NUMA_MISPLACED,	"numa_misplaced")		\
 	EM( MR_CONTIG_RANGE,	"contig_range")			\
-	EMe(MR_LONGTERM_PIN,	"longterm_pin")
+	EM( MR_LONGTERM_PIN,	"longterm_pin")			\
+	EMe(MR_DEMOTION,	"demotion")
 
 /*
  * First define the enums in the above macros to be exported to userspace
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9e1d66c81e6f..49d03b5e3c18 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -41,6 +41,7 @@
 #include <linux/kthread.h>
 #include <linux/freezer.h>
 #include <linux/memcontrol.h>
+#include <linux/migrate.h>
 #include <linux/delayacct.h>
 #include <linux/sysctl.h>
 #include <linux/oom.h>
@@ -118,6 +119,9 @@ struct scan_control {
 	/* The file pages on the current node are dangerously low */
 	unsigned int file_is_tiny:1;
 
+	/* Always discard instead of demoting to lower tier memory */
+	unsigned int no_demotion:1;
+
 	/* Allocation order */
 	s8 order;
 
@@ -515,6 +519,17 @@ static long add_nr_deferred(long nr, struct shrinker *shrinker,
 	return atomic_long_add_return(nr, &shrinker->nr_deferred[nid]);
 }
 
+static bool can_demote(int nid, struct scan_control *sc)
+{
+	if (sc->no_demotion)
+		return false;
+	if (next_demotion_node(nid) == NUMA_NO_NODE)
+		return false;
+
+	// FIXME: actually enable this later in the series
+	return false;
+}
+
 /*
  * This misses isolated pages which are not accounted for to save counters.
  * As the data only determines if reclaim or compaction continues, it is
@@ -1267,6 +1282,49 @@ static void page_check_dirty_writeback(struct page *page,
 		mapping->a_ops->is_dirty_writeback(page, dirty, writeback);
 }
 
+static struct page *alloc_demote_page(struct page *page, unsigned long node)
+{
+	struct migration_target_control mtc = {
+		/*
+		 * Allocate from 'node', or fail quickly and quietly.
+		 * When this happens, 'page' will likely just be discarded
+		 * instead of migrated.
+		 */
+		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
+			    __GFP_THISNODE  | __GFP_NOWARN |
+			    __GFP_NOMEMALLOC | GFP_NOWAIT,
+		.nid = node
+	};
+
+	return alloc_migration_target(page, (unsigned long)&mtc);
+}
+
+/*
+ * Take pages on @demote_list and attempt to demote them to
+ * another node.  Pages which are not demoted are left on
+ * @demote_pages.
+ */
+static unsigned int demote_page_list(struct list_head *demote_pages,
+				     struct pglist_data *pgdat)
+{
+	int target_nid = next_demotion_node(pgdat->node_id);
+	unsigned int nr_succeeded;
+	int err;
+
+	if (list_empty(demote_pages))
+		return 0;
+
+	if (target_nid == NUMA_NO_NODE)
+		return 0;
+
+	/* Demotion ignores all cpuset and mempolicy settings */
+	err = migrate_pages(demote_pages, alloc_demote_page, NULL,
+			    target_nid, MIGRATE_ASYNC, MR_DEMOTION,
+			    &nr_succeeded);
+
+	return nr_succeeded;
+}
+
 /*
  * shrink_page_list() returns the number of reclaimed pages
  */
@@ -1278,12 +1336,16 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 {
 	LIST_HEAD(ret_pages);
 	LIST_HEAD(free_pages);
+	LIST_HEAD(demote_pages);
 	unsigned int nr_reclaimed = 0;
 	unsigned int pgactivate = 0;
+	bool do_demote_pass;
 
 	memset(stat, 0, sizeof(*stat));
 	cond_resched();
+	do_demote_pass = can_demote(pgdat->node_id, sc);
 
+retry:
 	while (!list_empty(page_list)) {
 		struct address_space *mapping;
 		struct page *page;
@@ -1432,6 +1494,17 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 			; /* try to reclaim the page below */
 		}
 
+		/*
+		 * Before reclaiming the page, try to relocate
+		 * its contents to another node.
+		 */
+		if (do_demote_pass &&
+		    (thp_migration_supported() || !PageTransHuge(page))) {
+			list_add(&page->lru, &demote_pages);
+			unlock_page(page);
+			continue;
+		}
+
 		/*
 		 * Anonymous process memory has backing store?
 		 * Try to allocate it some swap space here.
@@ -1684,6 +1757,17 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 		list_add(&page->lru, &ret_pages);
 		VM_BUG_ON_PAGE(PageLRU(page) || PageUnevictable(page), page);
 	}
+	/* 'page_list' is always empty here */
+
+	/* Migrate pages selected for demotion */
+	nr_reclaimed += demote_page_list(&demote_pages, pgdat);
+	/* Pages that could not be demoted are still in @demote_pages */
+	if (!list_empty(&demote_pages)) {
+		/* Pages which failed to demoted go back on @page_list for retry: */
+		list_splice_init(&demote_pages, page_list);
+		do_demote_pass = false;
+		goto retry;
+	}
 
 	pgactivate = stat->nr_activate[0] + stat->nr_activate[1];
 
@@ -2329,6 +2413,7 @@ unsigned long reclaim_pages(struct list_head *page_list)
 		.may_writepage = 1,
 		.may_unmap = 1,
 		.may_swap = 1,
+		.no_demotion = 1,
 	};
 
 	noreclaim_flag = memalloc_noreclaim_save();
-- 
2.30.2


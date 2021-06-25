Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3A73B3D70
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 09:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhFYHfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 03:35:40 -0400
Received: from mga11.intel.com ([192.55.52.93]:18213 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230021AbhFYHfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 03:35:32 -0400
IronPort-SDR: NkkHlLkvIzItfJNf7zofOAqOlRkvSMDDcWOQDNlX6xmSGysr0TyPqHyqUJVyr7SxlWvz/2wCo0
 T3D5Kp6f5uYA==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="204617535"
X-IronPort-AV: E=Sophos;i="5.83,298,1616482800"; 
   d="scan'208";a="204617535"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 00:33:11 -0700
IronPort-SDR: QWFxLOnjlcv9/wnZOI33qvfFM7KDkn3NJ34RO6zUPJayA4wLuT+quE9prkLaWV1v/EaxuhgDDd
 f32E1QXH5O2w==
X-IronPort-AV: E=Sophos;i="5.83,298,1616482800"; 
   d="scan'208";a="488085794"
Received: from msun2-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.215.50])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 00:33:07 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>, Wei Xu <weixugc@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH -V9 4/9] mm/migrate: demote pages during reclaim
Date:   Fri, 25 Jun 2021 15:31:59 +0800
Message-Id: <20210625073204.1005986-5-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210625073204.1005986-1-ying.huang@intel.com>
References: <20210625073204.1005986-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Hansen <dave.hansen@linux.intel.com>

This is mostly derived from a patch from Yang Shi:

	https://lore.kernel.org/linux-mm/1560468577-101178-10-git-send-email-yang.shi@linux.alibaba.com/

Add code to the reclaim path (shrink_page_list()) to "demote" data
to another NUMA node instead of discarding the data.  This always
avoids the cost of I/O needed to read the page back in and sometimes
avoids the writeout cost when the page is dirty.

A second pass through shrink_page_list() will be made if any demotions
fail.  This essentially falls back to normal reclaim behavior in the
case that demotions fail.  Previous versions of this patch may have
simply failed to reclaim pages which were eligible for demotion but
were unable to be demoted in practice.

For some cases, for example, MADV_PAGEOUT, the pages are always
discarded instead of demoted to follow the kernel API definition.
Because MADV_PAGEOUT is defined as freeing specified pages regardless
in which tier they are.

Note: This just adds the start of infrastructure for migration. It is
actually disabled next to the FIXME in migrate_demote_page_ok().

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Reviewed-by: Wei Xu <weixugc@google.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>

--
changes from 20210618:
 * Fix some typos in comments and patch description.
 * Fix MADV_PAGEOUT behavior per Zi's comments.

changes from 20210122:
 * move from GFP_HIGHUSER -> GFP_HIGHUSER_MOVABLE (Ying)

changes from 202010:
 * add MR_NUMA_MISPLACED to trace MIGRATE_REASON define
 * make migrate_demote_page_ok() static, remove 'sc' arg until
   later patch
 * remove unnecessary alloc_demote_page() hugetlb warning
 * Simplify alloc_demote_page() gfp mask.  Depend on
   __GFP_NORETRY to make it lightweight instead of fancier
   stuff like leaving out __GFP_IO/FS.
 * Allocate migration page with alloc_migration_target()
   instead of allocating directly.
changes from 20200730:
 * Add another pass through shrink_page_list() when demotion
   fails.
changes from 20210302:
 * Use __GFP_THISNODE and revise the comment explaining the
   GFP mask constructionn
---
 include/linux/migrate.h        |  9 ++++
 include/trace/events/migrate.h |  3 +-
 mm/vmscan.c                    | 93 ++++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 166dc1fe4eee..d678e02a27ff 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -28,6 +28,7 @@ enum migrate_reason {
 	MR_NUMA_MISPLACED,
 	MR_CONTIG_RANGE,
 	MR_LONGTERM_PIN,
+	MR_DEMOTION,
 	MR_TYPES
 };
 
@@ -191,6 +192,14 @@ struct migrate_vma {
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
index 5199b9696bab..badaf3d4360d 100644
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
 
@@ -1231,6 +1235,27 @@ static enum page_references page_check_references(struct page *page,
 	return PAGEREF_RECLAIM;
 }
 
+static bool migrate_demote_page_ok(struct page *page,
+				   struct scan_control *sc)
+{
+	int next_nid;
+
+	VM_BUG_ON_PAGE(!PageLocked(page), page);
+	VM_BUG_ON_PAGE(PageHuge(page), page);
+	VM_BUG_ON_PAGE(PageLRU(page), page);
+
+	if (sc->no_demotion)
+		return false;
+	next_nid = next_demotion_node(page_to_nid(page));
+	if (next_nid == NUMA_NO_NODE)
+		return false;
+	if (PageTransHuge(page) && !thp_migration_supported())
+		return false;
+
+	// FIXME: actually enable this later in the series
+	return false;
+}
+
 /* Check if a page is dirty or under writeback */
 static void page_check_dirty_writeback(struct page *page,
 				       bool *dirty, bool *writeback)
@@ -1261,6 +1286,49 @@ static void page_check_dirty_writeback(struct page *page,
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
@@ -1272,12 +1340,15 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 {
 	LIST_HEAD(ret_pages);
 	LIST_HEAD(free_pages);
+	LIST_HEAD(demote_pages);
 	unsigned int nr_reclaimed = 0;
 	unsigned int pgactivate = 0;
+	bool do_demote_pass = true;
 
 	memset(stat, 0, sizeof(*stat));
 	cond_resched();
 
+retry:
 	while (!list_empty(page_list)) {
 		struct address_space *mapping;
 		struct page *page;
@@ -1426,6 +1497,16 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 			; /* try to reclaim the page below */
 		}
 
+		/*
+		 * Before reclaiming the page, try to relocate
+		 * its contents to another node.
+		 */
+		if (do_demote_pass && migrate_demote_page_ok(page, sc)) {
+			list_add(&page->lru, &demote_pages);
+			unlock_page(page);
+			continue;
+		}
+
 		/*
 		 * Anonymous process memory has backing store?
 		 * Try to allocate it some swap space here.
@@ -1676,6 +1757,17 @@ static unsigned int shrink_page_list(struct list_head *page_list,
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
 
@@ -2312,6 +2404,7 @@ unsigned long reclaim_pages(struct list_head *page_list)
 		.may_writepage = 1,
 		.may_unmap = 1,
 		.may_swap = 1,
+		.no_demotion = 1,
 	};
 
 	while (!list_empty(page_list)) {
-- 
2.30.2


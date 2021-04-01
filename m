Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B36351F02
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240494AbhDASvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:51:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:63339 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238724AbhDASfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:35:08 -0400
IronPort-SDR: iKwTb7y6YW4x/e0wjZ3VHtX9Zp92L7rnkAmkpEM8qaA72u0Bwn1hKV/dbHX88PKR608q1ZIi0f
 BcG5OAjo003w==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="192412468"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="192412468"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 11:35:08 -0700
IronPort-SDR: FuczjaOkjpIBLAKeW+4j5STy9zhzNKRb35N03V/HjmNAUK0ddH6LaPa48GdywqxY+TjJhK0mkI
 4e1vxG0zsGRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="446390564"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga002.fm.intel.com with ESMTP; 01 Apr 2021 11:35:06 -0700
Subject: [PATCH 05/10] mm/migrate: demote pages during reclaim
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>, weixugc@google.com,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com, osalvador@suse.de
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 01 Apr 2021 11:32:25 -0700
References: <20210401183216.443C4443@viggo.jf.intel.com>
In-Reply-To: <20210401183216.443C4443@viggo.jf.intel.com>
Message-Id: <20210401183225.2EDC224F@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

This is mostly derived from a patch from Yang Shi:

	https://lore.kernel.org/linux-mm/1560468577-101178-10-git-send-email-yang.shi@linux.alibaba.com/

Add code to the reclaim path (shrink_page_list()) to "demote" data
to another NUMA node instead of discarding the data.  This always
avoids the cost of I/O needed to read the page back in and sometimes
avoids the writeout cost when the pagee is dirty.

A second pass through shrink_page_list() will be made if any demotions
fail.  This essentally falls back to normal reclaim behavior in the
case that demotions fail.  Previous versions of this patch may have
simply failed to reclaim pages which were eligible for demotion but
were unable to be demoted in practice.

Note: This just adds the start of infratructure for migration. It is
actually disabled next to the FIXME in migrate_demote_page_ok().

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: osalvador <osalvador@suse.de>

--
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

 b/include/linux/migrate.h        |    9 ++++
 b/include/trace/events/migrate.h |    3 -
 b/mm/vmscan.c                    |   82 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 1 deletion(-)

diff -puN include/linux/migrate.h~demote-with-migrate_pages include/linux/migrate.h
--- a/include/linux/migrate.h~demote-with-migrate_pages	2021-03-31 15:17:15.842000251 -0700
+++ b/include/linux/migrate.h	2021-03-31 15:17:15.853000251 -0700
@@ -27,6 +27,7 @@ enum migrate_reason {
 	MR_MEMPOLICY_MBIND,
 	MR_NUMA_MISPLACED,
 	MR_CONTIG_RANGE,
+	MR_DEMOTION,
 	MR_TYPES
 };
 
@@ -196,6 +197,14 @@ struct migrate_vma {
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
 
diff -puN include/trace/events/migrate.h~demote-with-migrate_pages include/trace/events/migrate.h
--- a/include/trace/events/migrate.h~demote-with-migrate_pages	2021-03-31 15:17:15.846000251 -0700
+++ b/include/trace/events/migrate.h	2021-03-31 15:17:15.853000251 -0700
@@ -20,7 +20,8 @@
 	EM( MR_SYSCALL,		"syscall_or_cpuset")		\
 	EM( MR_MEMPOLICY_MBIND,	"mempolicy_mbind")		\
 	EM( MR_NUMA_MISPLACED,	"numa_misplaced")		\
-	EMe(MR_CONTIG_RANGE,	"contig_range")
+	EM( MR_CONTIG_RANGE,	"contig_range")			\
+	EMe(MR_DEMOTION,	"demotion")
 
 /*
  * First define the enums in the above macros to be exported to userspace
diff -puN mm/vmscan.c~demote-with-migrate_pages mm/vmscan.c
--- a/mm/vmscan.c~demote-with-migrate_pages	2021-03-31 15:17:15.848000251 -0700
+++ b/mm/vmscan.c	2021-03-31 15:17:15.856000251 -0700
@@ -41,6 +41,7 @@
 #include <linux/kthread.h>
 #include <linux/freezer.h>
 #include <linux/memcontrol.h>
+#include <linux/migrate.h>
 #include <linux/delayacct.h>
 #include <linux/sysctl.h>
 #include <linux/oom.h>
@@ -1035,6 +1036,23 @@ static enum page_references page_check_r
 	return PAGEREF_RECLAIM;
 }
 
+static bool migrate_demote_page_ok(struct page *page)
+{
+	int next_nid = next_demotion_node(page_to_nid(page));
+
+	VM_BUG_ON_PAGE(!PageLocked(page), page);
+	VM_BUG_ON_PAGE(PageHuge(page), page);
+	VM_BUG_ON_PAGE(PageLRU(page), page);
+
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
@@ -1065,6 +1083,46 @@ static void page_check_dirty_writeback(s
 		mapping->a_ops->is_dirty_writeback(page, dirty, writeback);
 }
 
+static struct page *alloc_demote_page(struct page *page, unsigned long node)
+{
+	struct migration_target_control mtc = {
+		/*
+		 * Allocate from 'node', or fail the quickly and quietly.
+		 * When this happens, 'page; will likely just be discarded
+		 * instead of migrated.
+		 */
+		.gfp_mask = GFP_HIGHUSER_MOVABLE | __GFP_NORETRY |
+			    __GFP_THISNODE	 | __GFP_NOWARN,
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
+				     struct pglist_data *pgdat,
+				     struct scan_control *sc)
+{
+	int target_nid = next_demotion_node(pgdat->node_id);
+	unsigned int nr_succeeded = 0;
+	int err;
+
+	if (list_empty(demote_pages))
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
@@ -1076,12 +1134,15 @@ static unsigned int shrink_page_list(str
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
@@ -1231,6 +1292,16 @@ static unsigned int shrink_page_list(str
 		}
 
 		/*
+		 * Before reclaiming the page, try to relocate
+		 * its contents to another node.
+		 */
+		if (do_demote_pass && migrate_demote_page_ok(page)) {
+			list_add(&page->lru, &demote_pages);
+			unlock_page(page);
+			continue;
+		}
+
+		/*
 		 * Anonymous process memory has backing store?
 		 * Try to allocate it some swap space here.
 		 * Lazyfree page could be freed directly
@@ -1480,6 +1551,17 @@ keep:
 		list_add(&page->lru, &ret_pages);
 		VM_BUG_ON_PAGE(PageLRU(page) || PageUnevictable(page), page);
 	}
+	/* 'page_list' is always empty here */
+
+	/* Migrate pages selected for demotion */
+	nr_reclaimed += demote_page_list(&demote_pages, pgdat, sc);
+	/* Pages that could not be demoted are still in @demote_pages */
+	if (!list_empty(&demote_pages)) {
+		/* Pages which failed to demoted go back on @page_list for retry: */
+		list_splice_init(&demote_pages, page_list);
+		do_demote_pass = false;
+		goto retry;
+	}
 
 	pgactivate = stat->nr_activate[0] + stat->nr_activate[1];
 
_

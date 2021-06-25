Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FD13B3D6F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 09:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhFYHfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 03:35:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:18213 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229978AbhFYHf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 03:35:27 -0400
IronPort-SDR: 4v5D2nZB0LVzJGx72fJEZv9ouJU686OrZonrziNdKI7rTDFxKAtxQxwtcrqKZW+AZ4csJzBYHv
 AhMKum4Td0rA==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="204617512"
X-IronPort-AV: E=Sophos;i="5.83,298,1616482800"; 
   d="scan'208";a="204617512"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 00:33:07 -0700
IronPort-SDR: +6gkqjghI6hGSWKOed7AjHcBZwP4afJ5jmBvjSZuvtSUoemcSVRBDK1xf9suwATaFWHlskf6Ch
 mSrDLMNKrHhw==
X-IronPort-AV: E=Sophos;i="5.83,298,1616482800"; 
   d="scan'208";a="488085763"
Received: from msun2-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.215.50])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 00:33:01 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        osalvador <osalvador@suse.de>, Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@suse.com>, Wei Xu <weixugc@google.com>,
        Zi Yan <ziy@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH -V9 3/9] mm/migrate: enable returning precise migrate_pages() success count
Date:   Fri, 25 Jun 2021 15:31:58 +0800
Message-Id: <20210625073204.1005986-4-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210625073204.1005986-1-ying.huang@intel.com>
References: <20210625073204.1005986-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Shi <yang.shi@linux.alibaba.com>

Under normal circumstances, migrate_pages() returns the number of
pages migrated.  In error conditions, it returns an error code.  When
returning an error code, there is no way to know how many pages were
migrated or not migrated.

Make migrate_pages() return how many pages are demoted successfully
for all cases, including when encountering errors.  Page reclaim
behavior will depend on this in subsequent patches.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: osalvador <osalvador@suse.de> [optional parameter]
Reviewed-by: Yang Shi <shy828301@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>

--

Note: Yang Shi originally wrote the patch, thus the SoB.  There was
also a Reviewed-by provided since there were some modifications made
to this after the original work.

Changes since 20210618:
 * Reword some bits of the changelog/subject
 * Allow callers to pass a NULL 'ret_succeeded'.  This ensures that
   callers don't have to declare and pass a dummy variable.

Changes since 20210302:
 * Fix definition of CONFIG_MIGRATION=n stub migrate_pages().  Its
   parameters were wrong, but oddly enough did not generate any
   compile errors.

Changes since 20200122:
 * Fix migrate_pages() to manipulate nr_succeeded *value*
   rather than the pointer.
---
 include/linux/migrate.h |  5 +++--
 mm/compaction.c         |  2 +-
 mm/gup.c                |  2 +-
 mm/memory-failure.c     |  2 +-
 mm/memory_hotplug.c     |  2 +-
 mm/mempolicy.c          |  4 ++--
 mm/migrate.c            | 11 ++++++++---
 mm/page_alloc.c         |  2 +-
 8 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 4bb4e519e3f5..166dc1fe4eee 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -41,7 +41,8 @@ extern int migrate_page(struct address_space *mapping,
 			struct page *newpage, struct page *page,
 			enum migrate_mode mode);
 extern int migrate_pages(struct list_head *l, new_page_t new, free_page_t free,
-		unsigned long private, enum migrate_mode mode, int reason);
+		unsigned long private, enum migrate_mode mode, int reason,
+		unsigned int *ret_succeeded);
 extern struct page *alloc_migration_target(struct page *page, unsigned long private);
 extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
 
@@ -56,7 +57,7 @@ extern int migrate_page_move_mapping(struct address_space *mapping,
 static inline void putback_movable_pages(struct list_head *l) {}
 static inline int migrate_pages(struct list_head *l, new_page_t new,
 		free_page_t free, unsigned long private, enum migrate_mode mode,
-		int reason)
+		int reason, unsigned int *ret_succeeded)
 	{ return -ENOSYS; }
 static inline struct page *alloc_migration_target(struct page *page,
 		unsigned long private)
diff --git a/mm/compaction.c b/mm/compaction.c
index 84fde270ae74..fcaa0dee3a74 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2400,7 +2400,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 
 		err = migrate_pages(&cc->migratepages, compaction_alloc,
 				compaction_free, (unsigned long)cc, cc->mode,
-				MR_COMPACTION);
+				MR_COMPACTION, NULL);
 
 		trace_mm_compaction_migratepages(cc->nr_migratepages, err,
 							&cc->migratepages);
diff --git a/mm/gup.c b/mm/gup.c
index 3ded6a5f26b2..776aebda4901 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1668,7 +1668,7 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 	if (!list_empty(&movable_page_list)) {
 		ret = migrate_pages(&movable_page_list, alloc_migration_target,
 				    NULL, (unsigned long)&mtc, MIGRATE_SYNC,
-				    MR_LONGTERM_PIN);
+				    MR_LONGTERM_PIN, NULL);
 		if (ret && !list_empty(&movable_page_list))
 			putback_movable_pages(&movable_page_list);
 	}
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 85ad98c00fd9..06576cc87098 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1852,7 +1852,7 @@ static int __soft_offline_page(struct page *page)
 
 	if (isolate_page(hpage, &pagelist)) {
 		ret = migrate_pages(&pagelist, alloc_migration_target, NULL,
-			(unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_FAILURE);
+			(unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_FAILURE, NULL);
 		if (!ret) {
 			bool release = !huge;
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 70620d0dd923..5574781f62cc 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1594,7 +1594,7 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		if (nodes_empty(nmask))
 			node_set(mtc.nid, nmask);
 		ret = migrate_pages(&source, alloc_migration_target, NULL,
-			(unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
+			(unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_HOTPLUG, NULL);
 		if (ret) {
 			list_for_each_entry(page, &source, lru) {
 				pr_warn("migrating pfn %lx failed ret:%d ",
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d79fa299b70c..440562239bb6 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1103,7 +1103,7 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
 
 	if (!list_empty(&pagelist)) {
 		err = migrate_pages(&pagelist, alloc_migration_target, NULL,
-				(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL);
+				(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL, NULL);
 		if (err)
 			putback_movable_pages(&pagelist);
 	}
@@ -1357,7 +1357,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 		if (!list_empty(&pagelist)) {
 			WARN_ON_ONCE(flags & MPOL_MF_LAZY);
 			nr_failed = migrate_pages(&pagelist, new_page, NULL,
-				start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND);
+				start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND, NULL);
 			if (nr_failed)
 				putback_movable_pages(&pagelist);
 		}
diff --git a/mm/migrate.c b/mm/migrate.c
index fa44c426f90f..87e04ed2b700 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1466,6 +1466,8 @@ static inline int try_split_thp(struct page *page, struct page **page2,
  * @mode:		The migration mode that specifies the constraints for
  *			page migration, if any.
  * @reason:		The reason for page migration.
+ * @ret_succeeded:	Set to the number of pages migrated successfully if
+ *			the caller passes a non-NULL pointer.
  *
  * The function returns after 10 attempts or if no pages are movable any more
  * because the list has become empty or no retryable pages exist any more.
@@ -1476,7 +1478,7 @@ static inline int try_split_thp(struct page *page, struct page **page2,
  */
 int migrate_pages(struct list_head *from, new_page_t get_new_page,
 		free_page_t put_new_page, unsigned long private,
-		enum migrate_mode mode, int reason)
+		enum migrate_mode mode, int reason, unsigned int *ret_succeeded)
 {
 	int retry = 1;
 	int thp_retry = 1;
@@ -1629,6 +1631,9 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	if (!swapwrite)
 		current->flags &= ~PF_SWAPWRITE;
 
+	if (ret_succeeded)
+		*ret_succeeded = nr_succeeded;
+
 	return rc;
 }
 
@@ -1698,7 +1703,7 @@ static int do_move_pages_to_node(struct mm_struct *mm,
 	};
 
 	err = migrate_pages(pagelist, alloc_migration_target, NULL,
-			(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL);
+		(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL, NULL);
 	if (err)
 		putback_movable_pages(pagelist);
 	return err;
@@ -2196,7 +2201,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	list_add(&page->lru, &migratepages);
 	nr_remaining = migrate_pages(&migratepages, alloc_misplaced_dst_page,
 				     NULL, node, MIGRATE_ASYNC,
-				     MR_NUMA_MISPLACED);
+				     MR_NUMA_MISPLACED, NULL);
 	if (nr_remaining) {
 		if (!list_empty(&migratepages)) {
 			list_del(&page->lru);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e033ae2e8bce..9055136e3f94 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8705,7 +8705,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 		cc->nr_migratepages -= nr_reclaimed;
 
 		ret = migrate_pages(&cc->migratepages, alloc_migration_target,
-				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
+			NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE, NULL);
 
 		/*
 		 * On -ENOMEM, migrate_pages() bails out right away. It is pointless
-- 
2.30.2


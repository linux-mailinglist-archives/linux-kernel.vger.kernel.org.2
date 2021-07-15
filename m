Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87ADB3C988C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 07:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239958AbhGOFzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 01:55:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:22887 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239935AbhGOFzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:55:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="197661947"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="197661947"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 22:52:23 -0700
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="505591601"
Received: from yhuang6-mobl1.sh.intel.com ([10.238.6.138])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 22:52:20 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        osalvador <osalvador@suse.de>, Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@suse.com>, Wei Xu <weixugc@google.com>,
        Zi Yan <ziy@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH -V10 3/9] mm/migrate: enable returning precise migrate_pages() success count
Date:   Thu, 15 Jul 2021 13:51:39 +0800
Message-Id: <20210715055145.195411-4-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715055145.195411-1-ying.huang@intel.com>
References: <20210715055145.195411-1-ying.huang@intel.com>
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
index 23dadf7aeba8..8ab88d46318e 100644
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
index 621508e0ecd5..61fb64f47a06 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2398,7 +2398,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 
 		err = migrate_pages(&cc->migratepages, compaction_alloc,
 				compaction_free, (unsigned long)cc, cc->mode,
-				MR_COMPACTION);
+				MR_COMPACTION, NULL);
 
 		trace_mm_compaction_migratepages(cc->nr_migratepages, err,
 							&cc->migratepages);
diff --git a/mm/gup.c b/mm/gup.c
index 42b8b1fa6521..c4441fc4cfba 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1772,7 +1772,7 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 	if (!list_empty(&movable_page_list)) {
 		ret = migrate_pages(&movable_page_list, alloc_migration_target,
 				    NULL, (unsigned long)&mtc, MIGRATE_SYNC,
-				    MR_LONGTERM_PIN);
+				    MR_LONGTERM_PIN, NULL);
 		if (ret && !list_empty(&movable_page_list))
 			putback_movable_pages(&movable_page_list);
 	}
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index eefd823deb67..3eed65e56f93 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2093,7 +2093,7 @@ static int __soft_offline_page(struct page *page)
 
 	if (isolate_page(hpage, &pagelist)) {
 		ret = migrate_pages(&pagelist, alloc_migration_target, NULL,
-			(unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_FAILURE);
+			(unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_FAILURE, NULL);
 		if (!ret) {
 			bool release = !huge;
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 8cb75b26ea4f..0c46458a3402 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1469,7 +1469,7 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		if (nodes_empty(nmask))
 			node_set(mtc.nid, nmask);
 		ret = migrate_pages(&source, alloc_migration_target, NULL,
-			(unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
+			(unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_HOTPLUG, NULL);
 		if (ret) {
 			list_for_each_entry(page, &source, lru) {
 				if (__ratelimit(&migrate_rs)) {
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index e32360e90274..939eabcaf488 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1084,7 +1084,7 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
 
 	if (!list_empty(&pagelist)) {
 		err = migrate_pages(&pagelist, alloc_migration_target, NULL,
-				(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL);
+				(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL, NULL);
 		if (err)
 			putback_movable_pages(&pagelist);
 	}
@@ -1338,7 +1338,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 		if (!list_empty(&pagelist)) {
 			WARN_ON_ONCE(flags & MPOL_MF_LAZY);
 			nr_failed = migrate_pages(&pagelist, new_page, NULL,
-				start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND);
+				start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND, NULL);
 			if (nr_failed)
 				putback_movable_pages(&pagelist);
 		}
diff --git a/mm/migrate.c b/mm/migrate.c
index a40c391f9ca7..35d34ef837ed 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1429,6 +1429,8 @@ static inline int try_split_thp(struct page *page, struct page **page2,
  * @mode:		The migration mode that specifies the constraints for
  *			page migration, if any.
  * @reason:		The reason for page migration.
+ * @ret_succeeded:	Set to the number of pages migrated successfully if
+ *			the caller passes a non-NULL pointer.
  *
  * The function returns after 10 attempts or if no pages are movable any more
  * because the list has become empty or no retryable pages exist any more.
@@ -1439,7 +1441,7 @@ static inline int try_split_thp(struct page *page, struct page **page2,
  */
 int migrate_pages(struct list_head *from, new_page_t get_new_page,
 		free_page_t put_new_page, unsigned long private,
-		enum migrate_mode mode, int reason)
+		enum migrate_mode mode, int reason, unsigned int *ret_succeeded)
 {
 	int retry = 1;
 	int thp_retry = 1;
@@ -1594,6 +1596,9 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	if (!swapwrite)
 		current->flags &= ~PF_SWAPWRITE;
 
+	if (ret_succeeded)
+		*ret_succeeded = nr_succeeded;
+
 	return rc;
 }
 
@@ -1663,7 +1668,7 @@ static int do_move_pages_to_node(struct mm_struct *mm,
 	};
 
 	err = migrate_pages(pagelist, alloc_migration_target, NULL,
-			(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL);
+		(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL, NULL);
 	if (err)
 		putback_movable_pages(pagelist);
 	return err;
@@ -2178,7 +2183,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 
 	list_add(&page->lru, &migratepages);
 	nr_remaining = migrate_pages(&migratepages, *new, NULL, node,
-				     MIGRATE_ASYNC, MR_NUMA_MISPLACED);
+				     MIGRATE_ASYNC, MR_NUMA_MISPLACED, NULL);
 	if (nr_remaining) {
 		if (!list_empty(&migratepages)) {
 			list_del(&page->lru);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cdb741399886..82ba531ac524 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8960,7 +8960,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 		cc->nr_migratepages -= nr_reclaimed;
 
 		ret = migrate_pages(&cc->migratepages, alloc_migration_target,
-				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
+			NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE, NULL);
 
 		/*
 		 * On -ENOMEM, migrate_pages() bails out right away. It is pointless
-- 
2.30.2


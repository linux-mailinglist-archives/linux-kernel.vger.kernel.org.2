Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA0F3AC3BF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 08:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbhFRGWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 02:22:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:4821 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233631AbhFRGTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 02:19:20 -0400
IronPort-SDR: Q/s45A1UsW1/T1tqgIQ0ofgnEyOfSqEXzasThfLP3rNRC8KMs4VjA3oGjdOu8D3pP7uiwZ7Edd
 FGqANgw3AKjQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="193815245"
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="193815245"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 23:16:17 -0700
IronPort-SDR: RE5TNRj3cjjHqfTn2bqA2CNV+U2CzzMHbGQIfA47uS3vfrey+lqj0285vWbXStLcGldPpAriX0
 c/2lNPeQ6B/A==
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="485573641"
Received: from mzhou6-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.212.155])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 23:16:14 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Wei Xu <weixugc@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        osalvador <osalvador@suse.de>
Subject: [PATCH -V8 04/10] mm/migrate: make migrate_pages() return nr_succeeded
Date:   Fri, 18 Jun 2021 14:15:31 +0800
Message-Id: <20210618061537.434999-5-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210618061537.434999-1-ying.huang@intel.com>
References: <20210618061537.434999-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Shi <yang.shi@linux.alibaba.com>

The migrate_pages() returns the number of pages that were not migrated,
or an error code.  When returning an error code, there is no way to know
how many pages were migrated or not migrated.

In the following patch, migrate_pages() is used to demote pages to PMEM
node, we need account how many pages are reclaimed (demoted) since page
reclaim behavior depends on this.  Add *nr_succeeded parameter to make
migrate_pages() return how many pages are demoted successfully for all
cases.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: osalvador <osalvador@suse.de>

--

Note: Yang Shi originally wrote the patch, thus the SoB.  There was
also a Reviewed-by provided since there were some modifications made
to this after the original work.

Changes since 20210302:
 * Fix definition of CONFIG_MIGRATION=n stub migrate_pages().  Its
   parameters were wrong, but oddly enough did not generate any
   compile errors.

Changes since 20200122:
 * Fix migrate_pages() to manipulate nr_succeeded *value*
   rather than the pointer.
---
 include/linux/migrate.h |  5 +++--
 mm/compaction.c         |  3 ++-
 mm/gup.c                |  3 ++-
 mm/memory-failure.c     |  4 +++-
 mm/memory_hotplug.c     |  4 +++-
 mm/mempolicy.c          |  8 ++++++--
 mm/migrate.c            | 19 +++++++++++--------
 mm/page_alloc.c         |  9 ++++++---
 8 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 4bb4e519e3f5..4a49bb358787 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -41,7 +41,8 @@ extern int migrate_page(struct address_space *mapping,
 			struct page *newpage, struct page *page,
 			enum migrate_mode mode);
 extern int migrate_pages(struct list_head *l, new_page_t new, free_page_t free,
-		unsigned long private, enum migrate_mode mode, int reason);
+		unsigned long private, enum migrate_mode mode, int reason,
+		unsigned int *nr_succeeded);
 extern struct page *alloc_migration_target(struct page *page, unsigned long private);
 extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
 
@@ -56,7 +57,7 @@ extern int migrate_page_move_mapping(struct address_space *mapping,
 static inline void putback_movable_pages(struct list_head *l) {}
 static inline int migrate_pages(struct list_head *l, new_page_t new,
 		free_page_t free, unsigned long private, enum migrate_mode mode,
-		int reason)
+		int reason, unsigned int *nr_succeeded)
 	{ return -ENOSYS; }
 static inline struct page *alloc_migration_target(struct page *page,
 		unsigned long private)
diff --git a/mm/compaction.c b/mm/compaction.c
index 84fde270ae74..43830a025fc1 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2282,6 +2282,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 	unsigned long last_migrated_pfn;
 	const bool sync = cc->mode != MIGRATE_ASYNC;
 	bool update_cached;
+	unsigned int nr_succeeded = 0;
 
 	/*
 	 * These counters track activities during zone compaction.  Initialize
@@ -2400,7 +2401,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 
 		err = migrate_pages(&cc->migratepages, compaction_alloc,
 				compaction_free, (unsigned long)cc, cc->mode,
-				MR_COMPACTION);
+				MR_COMPACTION, &nr_succeeded);
 
 		trace_mm_compaction_migratepages(cc->nr_migratepages, err,
 							&cc->migratepages);
diff --git a/mm/gup.c b/mm/gup.c
index 3ded6a5f26b2..5da01e921142 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1611,6 +1611,7 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 	unsigned long i;
 	unsigned long isolation_error_count = 0;
 	bool drain_allow = true;
+	unsigned int nr_succeeded = 0;
 	LIST_HEAD(movable_page_list);
 	long ret = 0;
 	struct page *prev_head = NULL;
@@ -1668,7 +1669,7 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 	if (!list_empty(&movable_page_list)) {
 		ret = migrate_pages(&movable_page_list, alloc_migration_target,
 				    NULL, (unsigned long)&mtc, MIGRATE_SYNC,
-				    MR_LONGTERM_PIN);
+				    MR_LONGTERM_PIN, &nr_succeeded);
 		if (ret && !list_empty(&movable_page_list))
 			putback_movable_pages(&movable_page_list);
 	}
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 85ad98c00fd9..0c24575ab97f 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1809,6 +1809,7 @@ static int __soft_offline_page(struct page *page)
 	unsigned long pfn = page_to_pfn(page);
 	struct page *hpage = compound_head(page);
 	char const *msg_page[] = {"page", "hugepage"};
+	unsigned int nr_succeeded = 0;
 	bool huge = PageHuge(page);
 	LIST_HEAD(pagelist);
 	struct migration_target_control mtc = {
@@ -1852,7 +1853,8 @@ static int __soft_offline_page(struct page *page)
 
 	if (isolate_page(hpage, &pagelist)) {
 		ret = migrate_pages(&pagelist, alloc_migration_target, NULL,
-			(unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_FAILURE);
+			(unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_FAILURE,
+			&nr_succeeded);
 		if (!ret) {
 			bool release = !huge;
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 70620d0dd923..b6f4ec6b82f5 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1520,6 +1520,7 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 	unsigned long pfn;
 	struct page *page, *head;
 	int ret = 0;
+	unsigned int nr_succeeded = 0;
 	LIST_HEAD(source);
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
@@ -1594,7 +1595,8 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		if (nodes_empty(nmask))
 			node_set(mtc.nid, nmask);
 		ret = migrate_pages(&source, alloc_migration_target, NULL,
-			(unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
+			(unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_HOTPLUG,
+			&nr_succeeded);
 		if (ret) {
 			list_for_each_entry(page, &source, lru) {
 				pr_warn("migrating pfn %lx failed ret:%d ",
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d79fa299b70c..25dceedbb884 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1081,6 +1081,7 @@ static int migrate_page_add(struct page *page, struct list_head *pagelist,
 static int migrate_to_node(struct mm_struct *mm, int source, int dest,
 			   int flags)
 {
+	unsigned int nr_succeeded = 0;
 	nodemask_t nmask;
 	LIST_HEAD(pagelist);
 	int err = 0;
@@ -1103,7 +1104,8 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
 
 	if (!list_empty(&pagelist)) {
 		err = migrate_pages(&pagelist, alloc_migration_target, NULL,
-				(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL);
+				(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL,
+				&nr_succeeded);
 		if (err)
 			putback_movable_pages(&pagelist);
 	}
@@ -1280,6 +1282,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 		     nodemask_t *nmask, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
+	unsigned int nr_succeeded = 0;
 	struct mempolicy *new;
 	unsigned long end;
 	int err;
@@ -1357,7 +1360,8 @@ static long do_mbind(unsigned long start, unsigned long len,
 		if (!list_empty(&pagelist)) {
 			WARN_ON_ONCE(flags & MPOL_MF_LAZY);
 			nr_failed = migrate_pages(&pagelist, new_page, NULL,
-				start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND);
+				start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND,
+				&nr_succeeded);
 			if (nr_failed)
 				putback_movable_pages(&pagelist);
 		}
diff --git a/mm/migrate.c b/mm/migrate.c
index 0aad54d6c8f9..a9b90ec28dfd 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1466,6 +1466,7 @@ static inline int try_split_thp(struct page *page, struct page **page2,
  * @mode:		The migration mode that specifies the constraints for
  *			page migration, if any.
  * @reason:		The reason for page migration.
+ * @nr_succeeded:	The number of pages migrated successfully.
  *
  * The function returns after 10 attempts or if no pages are movable any more
  * because the list has become empty or no retryable pages exist any more.
@@ -1476,12 +1477,11 @@ static inline int try_split_thp(struct page *page, struct page **page2,
  */
 int migrate_pages(struct list_head *from, new_page_t get_new_page,
 		free_page_t put_new_page, unsigned long private,
-		enum migrate_mode mode, int reason)
+		enum migrate_mode mode, int reason, unsigned int *nr_succeeded)
 {
 	int retry = 1;
 	int thp_retry = 1;
 	int nr_failed = 0;
-	int nr_succeeded = 0;
 	int nr_thp_succeeded = 0;
 	int nr_thp_failed = 0;
 	int nr_thp_split = 0;
@@ -1586,10 +1586,10 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 			case MIGRATEPAGE_SUCCESS:
 				if (is_thp) {
 					nr_thp_succeeded++;
-					nr_succeeded += nr_subpages;
+					*nr_succeeded += nr_subpages;
 					break;
 				}
-				nr_succeeded++;
+				(*nr_succeeded)++;
 				break;
 			default:
 				/*
@@ -1618,12 +1618,12 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	 */
 	list_splice(&ret_pages, from);
 
-	count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
+	count_vm_events(PGMIGRATE_SUCCESS, *nr_succeeded);
 	count_vm_events(PGMIGRATE_FAIL, nr_failed);
 	count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
 	count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
 	count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
-	trace_mm_migrate_pages(nr_succeeded, nr_failed, nr_thp_succeeded,
+	trace_mm_migrate_pages(*nr_succeeded, nr_failed, nr_thp_succeeded,
 			       nr_thp_failed, nr_thp_split, mode, reason);
 
 	if (!swapwrite)
@@ -1691,6 +1691,7 @@ static int store_status(int __user *status, int start, int value, int nr)
 static int do_move_pages_to_node(struct mm_struct *mm,
 		struct list_head *pagelist, int node)
 {
+	unsigned int nr_succeeded = 0;
 	int err;
 	struct migration_target_control mtc = {
 		.nid = node,
@@ -1698,7 +1699,8 @@ static int do_move_pages_to_node(struct mm_struct *mm,
 	};
 
 	err = migrate_pages(pagelist, alloc_migration_target, NULL,
-			(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL);
+			(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL,
+			&nr_succeeded);
 	if (err)
 		putback_movable_pages(pagelist);
 	return err;
@@ -2172,6 +2174,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	pg_data_t *pgdat = NODE_DATA(node);
 	int isolated;
 	int nr_remaining;
+	unsigned int nr_succeeded = 0;
 	LIST_HEAD(migratepages);
 
 	/*
@@ -2196,7 +2199,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	list_add(&page->lru, &migratepages);
 	nr_remaining = migrate_pages(&migratepages, alloc_misplaced_dst_page,
 				     NULL, node, MIGRATE_ASYNC,
-				     MR_NUMA_MISPLACED);
+				     MR_NUMA_MISPLACED, &nr_succeeded);
 	if (nr_remaining) {
 		if (!list_empty(&migratepages)) {
 			list_del(&page->lru);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e033ae2e8bce..edd50c46440e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8668,7 +8668,8 @@ static inline void alloc_contig_dump_pages(struct list_head *page_list)
 
 /* [start, end) must belong to a single zone. */
 static int __alloc_contig_migrate_range(struct compact_control *cc,
-					unsigned long start, unsigned long end)
+					unsigned long start, unsigned long end,
+					unsigned int *nr_succeeded)
 {
 	/* This function is based on compact_zone() from compaction.c. */
 	unsigned int nr_reclaimed;
@@ -8705,7 +8706,8 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 		cc->nr_migratepages -= nr_reclaimed;
 
 		ret = migrate_pages(&cc->migratepages, alloc_migration_target,
-				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
+				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE,
+				nr_succeeded);
 
 		/*
 		 * On -ENOMEM, migrate_pages() bails out right away. It is pointless
@@ -8751,6 +8753,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	unsigned long outer_start, outer_end;
 	unsigned int order;
 	int ret = 0;
+	unsigned int nr_succeeded = 0;
 
 	struct compact_control cc = {
 		.nr_migratepages = 0,
@@ -8805,7 +8808,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	 * allocated.  So, if we fall through be sure to clear ret so that
 	 * -EBUSY is not accidentally used or returned to caller.
 	 */
-	ret = __alloc_contig_migrate_range(&cc, start, end);
+	ret = __alloc_contig_migrate_range(&cc, start, end, &nr_succeeded);
 	if (ret && ret != -EBUSY)
 		goto done;
 	ret = 0;
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF8B3CB450
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 10:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238169AbhGPIbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 04:31:51 -0400
Received: from mail-m121142.qiye.163.com ([115.236.121.142]:16416 "EHLO
        mail-m121142.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237069AbhGPIbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 04:31:32 -0400
X-Greylist: delayed 616 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Jul 2021 04:31:32 EDT
DKIM-Signature: a=rsa-sha256;
        b=aOPdwd1jD8z7DnrHrYYPWmp0Y6QFMe30ADAgb3I+UHGfFUMEDmZT9UYQurg2Bcu+wWgCC44c6I52TAseLL8FPM8V6r/UIoNjfGnZgiftZo8cKCIzcX28LqZdy3oL26Oq3CpnbLSurUDjhTG8Tp13ejIz+qmhvui3fSI4ECVNQbY=;
        c=relaxed/relaxed; s=default; d=vivo.com; v=1;
        bh=WLbSxNPKxrOOhLBpC2RFhvhKHqQwJLWtvjlYyYI/Xh8=;
        h=date:mime-version:subject:message-id:from;
Received: from NJ-11133793.vivo.xyz (unknown [36.152.145.180])
        by mail-m121142.qiye.163.com (Hmail) with ESMTPA id B2FC08014E;
        Fri, 16 Jul 2021 16:18:15 +0800 (CST)
From:   Yang Huan <link@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Yang Huan <link@vivo.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     kernel@vivo.com, Wang Qing <wangqing@vivo.com>
Subject: [PATCH] mm/page_alloc: enable alloc bulk when page owner is on
Date:   Fri, 16 Jul 2021 16:17:53 +0800
Message-Id: <20210716081756.25419-1-link@vivo.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUMeGEhWGh9IGRoZGB9MGU
        1OVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mio6EAw4LD9JMg8BFikUTksw
        NU9PFDdVSlVKTUlNT0lIT0JNSEpOVTMWGhIXVRcSFRA7DRINFFUYFBZFWVdZEgtZQVlITVVKTklV
        Sk9OVUpDS1lXWQgBWUFKS0xNSDcG
X-HM-Tid: 0a7aae650d16b037kuuub2fc08014e
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Last alloc bulk version have a bug, when page_owner is on, system maybe
crashed due to alloc bulk invoke prep_new_page in irq disabled context,
and set_page_owner use page_flag(may GFP_KERNEL) to get memory and save
stacktrace.
We fix it by a circumvention plan -- bandon alloc bulk feature when
page_owner is set.
I think both alloc_bulk and page_owner is valuable, so, it's worth to
find a way enable alloc bulk when page owner is on.

The original bug as Zhang, Qiang reported

  BUG: sleeping function called from invalid context at mm/page_alloc.c:5179
  in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
  .....
  __dump_stack lib/dump_stack.c:79 [inline]
  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:96
  ___might_sleep.cold+0x1f1/0x237 kernel/sched/core.c:9153
  prepare_alloc_pages+0x3da/0x580 mm/page_alloc.c:5179
  __alloc_pages+0x12f/0x500 mm/page_alloc.c:5375
  alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2147
  alloc_pages+0x238/0x2a0 mm/mempolicy.c:2270
  stack_depot_save+0x39d/0x4e0 lib/stackdepot.c:303
  save_stack+0x15e/0x1e0 mm/page_owner.c:120
  __set_page_owner+0x50/0x290 mm/page_owner.c:181
  prep_new_page mm/page_alloc.c:2445 [inline]
  __alloc_pages_bulk+0x8b9/0x1870 mm/page_alloc.c:5313
  alloc_pages_bulk_array_node include/linux/gfp.h:557 [inline]
  vm_area_alloc_pages mm/vmalloc.c:2775 [inline]
  __vmalloc_area_node mm/vmalloc.c:2845 [inline]
  __vmalloc_node_range+0x39d/0x960 mm/vmalloc.c:2947
  __vmalloc_node mm/vmalloc.c:2996 [inline]
  vzalloc+0x67/0x80 mm/vmalloc.c:3066

Actually, the problem is caused by set_page_owner alloc memory to save
stack with GFP_KERNEL in local_riq disabled.
So, we just can't assume that alloc flags should be same with new page,
prep_new_page should prep/trace the page gfp, but shouldn't use the same
gfp to get memory, let's depend on caller.
Now, here is two gfp flags, alloc_gfp used to alloc memory, depend on
caller, page_gfp is page's gfp, used to trace/prep itself.
In most situation, alloc_gfp same is ok, in alloc_pages_bulk,
use GFP_ATOMIC, due to irq is disabled.

Notice: GFP_ATOMIC may cause alloc_bulk pages lost page owner stacktrace
when memory get failed due to can't reclaim memory. But, Actually,
we are in irq context, can't relcaim memory is true, use GFP_ATOMIC is
appropriate.

Now that we fixed bug, let's enabled alloc bulk when page_owner is on.

Suggested-by: Wang Qing <wangqing@vivo.com>
Signed-off-by: Yang Huan <link@vivo.com>
---
 include/linux/page_owner.h |  8 ++++----
 mm/compaction.c            |  2 +-
 mm/internal.h              |  2 +-
 mm/page_alloc.c            | 36 ++++++++++++------------------------
 mm/page_owner.c            |  6 +++---
 5 files changed, 21 insertions(+), 33 deletions(-)

diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
index 719bfe5108c5..76669c272b4b 100644
--- a/include/linux/page_owner.h
+++ b/include/linux/page_owner.h
@@ -10,7 +10,7 @@ extern struct page_ext_operations page_owner_ops;
 
 extern void __reset_page_owner(struct page *page, unsigned int order);
 extern void __set_page_owner(struct page *page,
-			unsigned int order, gfp_t gfp_mask);
+			unsigned int order, gfp_t alloc_gfp, gfp_t page_gfp);
 extern void __split_page_owner(struct page *page, unsigned int nr);
 extern void __copy_page_owner(struct page *oldpage, struct page *newpage);
 extern void __set_page_owner_migrate_reason(struct page *page, int reason);
@@ -25,10 +25,10 @@ static inline void reset_page_owner(struct page *page, unsigned int order)
 }
 
 static inline void set_page_owner(struct page *page,
-			unsigned int order, gfp_t gfp_mask)
+			unsigned int order, gfp_t alloc_gfp, gfp_t page_gfp)
 {
 	if (static_branch_unlikely(&page_owner_inited))
-		__set_page_owner(page, order, gfp_mask);
+		__set_page_owner(page, order, alloc_gfp, page_gfp);
 }
 
 static inline void split_page_owner(struct page *page, unsigned int nr)
@@ -56,7 +56,7 @@ static inline void reset_page_owner(struct page *page, unsigned int order)
 {
 }
 static inline void set_page_owner(struct page *page,
-			unsigned int order, gfp_t gfp_mask)
+			unsigned int order, gfp_t alloc_gfp, gfp_t page_gfp)
 {
 }
 static inline void split_page_owner(struct page *page,
diff --git a/mm/compaction.c b/mm/compaction.c
index 79aaf21058da..187869e21690 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -96,7 +96,7 @@ static void split_map_pages(struct list_head *list)
 		order = page_private(page);
 		nr_pages = 1 << order;
 
-		post_alloc_hook(page, order, __GFP_MOVABLE);
+		post_alloc_hook(page, order, __GFP_MOVABLE, __GFP_MOVABLE);
 		if (order)
 			split_page(page, order);
 
diff --git a/mm/internal.h b/mm/internal.h
index cf3cb933eba3..7eaf18b1fa2f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -200,7 +200,7 @@ extern void memblock_free_pages(struct page *page, unsigned long pfn,
 extern void __free_pages_core(struct page *page, unsigned int order);
 extern void prep_compound_page(struct page *page, unsigned int order);
 extern void post_alloc_hook(struct page *page, unsigned int order,
-					gfp_t gfp_flags);
+					gfp_t alloc_gfp, gfp_t page_gfp);
 extern int user_min_free_kbytes;
 
 extern void free_unref_page(struct page *page, unsigned int order);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 62dc229c1dd1..03bcb7f34fa6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2384,7 +2384,7 @@ static bool check_new_pages(struct page *page, unsigned int order)
 }
 
 inline void post_alloc_hook(struct page *page, unsigned int order,
-				gfp_t gfp_flags)
+				gfp_t alloc_gfp, gfp_t page_gfp)
 {
 	set_page_private(page, 0);
 	set_page_refcounted(page);
@@ -2405,25 +2405,25 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 	 * kept together to avoid discrepancies in behavior.
 	 */
 	if (kasan_has_integrated_init()) {
-		kasan_alloc_pages(page, order, gfp_flags);
+		kasan_alloc_pages(page, order, page_gfp);
 	} else {
-		bool init = !want_init_on_free() && want_init_on_alloc(gfp_flags);
+		bool init = !want_init_on_free() && want_init_on_alloc(page_gfp);
 
 		kasan_unpoison_pages(page, order, init);
 		if (init)
 			kernel_init_free_pages(page, 1 << order,
-					       gfp_flags & __GFP_ZEROTAGS);
+					       page_gfp & __GFP_ZEROTAGS);
 	}
 
-	set_page_owner(page, order, gfp_flags);
+	set_page_owner(page, order, alloc_gfp, page_gfp);
 }
 
-static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
-							unsigned int alloc_flags)
+static void prep_new_page(struct page *page, unsigned int order, gfp_t alloc_gfp,
+							gfp_t page_gfp, unsigned int alloc_flags)
 {
-	post_alloc_hook(page, order, gfp_flags);
+	post_alloc_hook(page, order, alloc_gfp, page_gfp);
 
-	if (order && (gfp_flags & __GFP_COMP))
+	if (order && (page_gfp & __GFP_COMP))
 		prep_compound_page(page, order);
 
 	/*
@@ -4149,7 +4149,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		page = rmqueue(ac->preferred_zoneref->zone, zone, order,
 				gfp_mask, alloc_flags, ac->migratetype);
 		if (page) {
-			prep_new_page(page, order, gfp_mask, alloc_flags);
+			prep_new_page(page, order, gfp_mask, gfp_mask, alloc_flags);
 
 			/*
 			 * If this is a high-order atomic allocation then check
@@ -4369,7 +4369,7 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 
 	/* Prep a captured page if available */
 	if (page)
-		prep_new_page(page, order, gfp_mask, alloc_flags);
+		prep_new_page(page, order, gfp_mask, gfp_mask, alloc_flags);
 
 	/* Try get a page from the freelist if available */
 	if (!page)
@@ -5226,18 +5226,6 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	if (nr_pages - nr_populated == 1)
 		goto failed;
 
-#ifdef CONFIG_PAGE_OWNER
-	/*
-	 * PAGE_OWNER may recurse into the allocator to allocate space to
-	 * save the stack with pagesets.lock held. Releasing/reacquiring
-	 * removes much of the performance benefit of bulk allocation so
-	 * force the caller to allocate one page at a time as it'll have
-	 * similar performance to added complexity to the bulk allocator.
-	 */
-	if (static_branch_unlikely(&page_owner_inited))
-		goto failed;
-#endif
-
 	/* May set ALLOC_NOFRAGMENT, fragmentation will return 1 page. */
 	gfp &= gfp_allowed_mask;
 	alloc_gfp = gfp;
@@ -5297,7 +5285,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		}
 		nr_account++;
 
-		prep_new_page(page, 0, gfp, 0);
+		prep_new_page(page, 0, GFP_ATOMIC, gfp, 0);
 		if (page_list)
 			list_add(&page->lru, page_list);
 		else
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 62402d22539b..3c7419b72c76 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -170,7 +170,7 @@ static inline void __set_page_owner_handle(struct page_ext *page_ext,
 }
 
 noinline void __set_page_owner(struct page *page, unsigned int order,
-					gfp_t gfp_mask)
+					gfp_t alloc_gfp, gfp_t page_gfp)
 {
 	struct page_ext *page_ext = lookup_page_ext(page);
 	depot_stack_handle_t handle;
@@ -178,8 +178,8 @@ noinline void __set_page_owner(struct page *page, unsigned int order,
 	if (unlikely(!page_ext))
 		return;
 
-	handle = save_stack(gfp_mask);
-	__set_page_owner_handle(page_ext, handle, order, gfp_mask);
+	handle = save_stack(alloc_gfp);
+	__set_page_owner_handle(page_ext, handle, order, page_gfp);
 }
 
 void __set_page_owner_migrate_reason(struct page *page, int reason)
-- 
2.32.0


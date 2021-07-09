Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928583C214C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 11:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhGIJP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 05:15:59 -0400
Received: from mail-m17640.qiye.163.com ([59.111.176.40]:46538 "EHLO
        mail-m17640.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhGIJP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 05:15:58 -0400
X-Greylist: delayed 405 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Jul 2021 05:15:58 EDT
DKIM-Signature: a=rsa-sha256;
        b=Xt9wipGAWMiJ9pXHz+aFsmxJQRD+yolBK0w8AtRqsZiumJ5o3mEjJhhDTkhmBXFYoRD8AuofLU1GqgF0UnOw4M/rhHAOkedHa3/Eq0ZWLhY6ClvALQ2LchZmOD10t0aU+BoWAq2is4v95ieYhK6ySEvr5k2KaeM1B5ahd+KhxUo=;
        s=default; c=relaxed/relaxed; d=vivo.com; v=1;
        bh=ZZZNtVOIv1C9UEIQGzgOo1slkiojW0ewRwzbOvRPcwU=;
        h=date:mime-version:subject:message-id:from;
Received: from NJ-11133793.vivo.xyz (unknown [36.152.145.180])
        by mail-m17640.qiye.163.com (Hmail) with ESMTPA id 56F28540213;
        Fri,  9 Jul 2021 17:06:27 +0800 (CST)
From:   Yang Huan <link@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yang Huan <link@vivo.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     kernel@vivo.com,
        syzbot+b07d8440edb5f8988eea@syzkaller.appspotmail.com,
        Wang Qing <wangqing@vivo.com>
Subject: [PATCH] mm/page_alloc: fix alloc_pages_bulk/set_page_owner panic on irq disabled
Date:   Fri,  9 Jul 2021 17:05:59 +0800
Message-Id: <20210709090600.9804-1-link@vivo.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQ0xLQ1YfH0kZGUpIS04aTk5VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hOSFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kxw6HCo*SD9NMhI2MR49IxYV
        FjQaCg5VSlVKTUlOQ0lKTkNMQ05IVTMWGhIXVRcSFRA7DRINFFUYFBZFWVdZEgtZQVlITVVKTklV
        Sk9OVUpDS1lXWQgBWUFMTEhINwY+
X-HM-Tid: 0a7a8a84a844d995kuws56f28540213
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is caused by set_page_owner alloc memory to save stack with
GFP_KERNEL in local_riq disabled.
So, we just can't assume that alloc flags should be same with new page,
let's split it. But in most situation, same is ok, in alloc_pages_bulk,
input GFP_ATOMIC when prep_new_pages

Reported-and-tested-by: syzbot+b07d8440edb5f8988eea@syzkaller.appspotmail.com
Suggested-by: Wang Qing <wangqing@vivo.com>
Signed-off-by: Yang Huan <link@vivo.com>
---
 include/linux/page_owner.h |  8 ++++----
 mm/compaction.c            |  2 +-
 mm/internal.h              |  2 +-
 mm/page_alloc.c            | 21 +++++++++++----------
 mm/page_owner.c            |  6 +++---
 5 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
index 3468794f83d2..c930a63e149b 100644
--- a/include/linux/page_owner.h
+++ b/include/linux/page_owner.h
@@ -10,7 +10,7 @@ extern struct page_ext_operations page_owner_ops;
 
 extern void __reset_page_owner(struct page *page, unsigned int order);
 extern void __set_page_owner(struct page *page,
-			unsigned int order, gfp_t gfp_mask);
+			unsigned int order, gfp_t alloc_gfp, gfp_t page_gfp_mask);
 extern void __split_page_owner(struct page *page, unsigned int nr);
 extern void __copy_page_owner(struct page *oldpage, struct page *newpage);
 extern void __set_page_owner_migrate_reason(struct page *page, int reason);
@@ -25,10 +25,10 @@ static inline void reset_page_owner(struct page *page, unsigned int order)
 }
 
 static inline void set_page_owner(struct page *page,
-			unsigned int order, gfp_t gfp_mask)
+			unsigned int order, gfp_t alloc_gfp, gfp_t page_gfp_mask)
 {
 	if (static_branch_unlikely(&page_owner_inited))
-		__set_page_owner(page, order, gfp_mask);
+		__set_page_owner(page, order, alloc_gfp, page_gfp_mask);
 }
 
 static inline void split_page_owner(struct page *page, unsigned int nr)
@@ -56,7 +56,7 @@ static inline void reset_page_owner(struct page *page, unsigned int order)
 {
 }
 static inline void set_page_owner(struct page *page,
-			unsigned int order, gfp_t gfp_mask)
+			unsigned int order, gfp_t alloc_gfp, gfp_t page_gfp_mask)
 {
 }
 static inline void split_page_owner(struct page *page,
diff --git a/mm/compaction.c b/mm/compaction.c
index 84fde270ae74..a3bc69dceb1d 100644
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
index e8fdb531f887..9d0cd0840f58 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -195,7 +195,7 @@ extern void memblock_free_pages(struct page *page, unsigned long pfn,
 extern void __free_pages_core(struct page *page, unsigned int order);
 extern void prep_compound_page(struct page *page, unsigned int order);
 extern void post_alloc_hook(struct page *page, unsigned int order,
-					gfp_t gfp_flags);
+					gfp_t alloc_gfp, gfp_t page_gfp_mask);
 extern int user_min_free_kbytes;
 
 extern void free_unref_page(struct page *page);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d1f5de1c1283..bdd057e20376 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2322,7 +2322,7 @@ static bool check_new_pages(struct page *page, unsigned int order)
 }
 
 inline void post_alloc_hook(struct page *page, unsigned int order,
-				gfp_t gfp_flags)
+				gfp_t alloc_gfp, gfp_t page_gfp_mask)
 {
 	bool init;
 
@@ -2344,20 +2344,21 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 	 * kasan_alloc_pages and kernel_init_free_pages must be
 	 * kept together to avoid discrepancies in behavior.
 	 */
-	init = !want_init_on_free() && want_init_on_alloc(gfp_flags);
+	init = !want_init_on_free() && want_init_on_alloc(page_gfp_mask);
 	kasan_alloc_pages(page, order, init);
 	if (init && !kasan_has_integrated_init())
 		kernel_init_free_pages(page, 1 << order);
 
-	set_page_owner(page, order, gfp_flags);
+	set_page_owner(page, order, alloc_gfp, page_gfp_mask);
 }
 
-static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
-							unsigned int alloc_flags)
+static void prep_new_page(struct page *page, unsigned int order,
+			  gfp_t alloc_gfp, gfp_t page_gfp_mask,
+			  unsigned int alloc_flags)
 {
-	post_alloc_hook(page, order, gfp_flags);
+	post_alloc_hook(page, order, alloc_gfp, page_gfp_mask);
 
-	if (order && (gfp_flags & __GFP_COMP))
+	if (order && (page_gfp_mask & __GFP_COMP))
 		prep_compound_page(page, order);
 
 	/*
@@ -3991,7 +3992,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		page = rmqueue(ac->preferred_zoneref->zone, zone, order,
 				gfp_mask, alloc_flags, ac->migratetype);
 		if (page) {
-			prep_new_page(page, order, gfp_mask, alloc_flags);
+			prep_new_page(page, order, gfp_mask, gfp_mask, alloc_flags);
 
 			/*
 			 * If this is a high-order atomic allocation then check
@@ -4211,7 +4212,7 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 
 	/* Prep a captured page if available */
 	if (page)
-		prep_new_page(page, order, gfp_mask, alloc_flags);
+		prep_new_page(page, order, gfp_mask, gfp_mask, alloc_flags);
 
 	/* Try get a page from the freelist if available */
 	if (!page)
@@ -5127,7 +5128,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		__count_zid_vm_events(PGALLOC, zone_idx(zone), 1);
 		zone_statistics(ac.preferred_zoneref->zone, zone);
 
-		prep_new_page(page, 0, gfp, 0);
+		prep_new_page(page, 0, GFP_ATOMIC, gfp, 0);
 		if (page_list)
 			list_add(&page->lru, page_list);
 		else
diff --git a/mm/page_owner.c b/mm/page_owner.c
index adfabb560eb9..22948724ca64 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -170,7 +170,7 @@ static inline void __set_page_owner_handle(struct page_ext *page_ext,
 }
 
 noinline void __set_page_owner(struct page *page, unsigned int order,
-					gfp_t gfp_mask)
+					gfp_t alloc_gfp, gfp_t page_gfp_mask)
 {
 	struct page_ext *page_ext = lookup_page_ext(page);
 	depot_stack_handle_t handle;
@@ -178,8 +178,8 @@ noinline void __set_page_owner(struct page *page, unsigned int order,
 	if (unlikely(!page_ext))
 		return;
 
-	handle = save_stack(gfp_mask);
-	__set_page_owner_handle(page_ext, handle, order, gfp_mask);
+	handle = save_stack(alloc_gfp);
+	__set_page_owner_handle(page_ext, handle, order, page_gfp_mask);
 }
 
 void __set_page_owner_migrate_reason(struct page *page, int reason)
-- 
2.32.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265283EC0AC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 07:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237035AbhHNF00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 01:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbhHNF0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 01:26:25 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3BBC061575
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 22:25:57 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id nt11so18447398pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 22:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mvg4Ru6OOrx7XzBZqzJfbp8SqJQxo34cv//v2Oh/ogE=;
        b=PjaMCXr/tBJxktavybYNAuh2+QETydbRTzNTgSwoI5BZSjFzlocpe6ZIPVAXfGgVjw
         0ruTlV+TlLVCkUvheXfvaIXlPzzkCysN2wK09r+hxhc0+fSq81eqEa6tWwiSJ3PP0Lvh
         0u117eDiXQylKBmDZA/bTv2wDSwo4gQgY6TGv1q145w1aNO8UeJC17tg3FepAZ1Ib7CP
         oT8L2w+TPja+ECohJnh+9DO+l3dNtdQYaTFcA/jwd6fBnr0oZE0m8q2HQhg+/jVGbvAD
         o31LFEsSQgRAdhMdj1UqvxD3LK4/phGXWzPt6M/hsYgg/jekV/Hl+RWvGuTrc/7voXAL
         4/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mvg4Ru6OOrx7XzBZqzJfbp8SqJQxo34cv//v2Oh/ogE=;
        b=cy7PE5jUq5DjengByAUFh+2NzWyrKWhIN1iJu+3fgDZkXXVeRZTLPNax5JoyFNzGrk
         tIvwprNd/0i+QiG/QS0Nv34adFlOv5fYS1K7fdlMaXNDD+DSKAVmm6n6cnzOTYCxzDAx
         b5FyBITekkTHfIfDAyECOWrNlVWXkp0Ne40ZC6FTXKS+32eABIeOG2R+jmYcHDiYGKW9
         P5HWfY6097rYoPFwwnCHw2qJry7uN9vtd0cEHjvU2Q5q+t87uZCf7oyaYfG++cP+E8dF
         oGZkLKyHSQRYcS1KwNrTR2wJltLrOrkBtHV7skEJgi0Xgp7Fry3k92S0zcGc5rMU2pqF
         tfHA==
X-Gm-Message-State: AOAM531cflqrIt75xJ0kmSPTjojxuZ8uc1ez39GsWcF3EeI5hBC62CQX
        dXI1+rrcd1p/7BmgSpFPspaN1A==
X-Google-Smtp-Source: ABdhPJzrOflGrSuy6eiUo+AH+dxSxM4GEOboB7Uia7lzJ43Ep96CMpPU06BUSLILMUiwhGfjANruXA==
X-Received: by 2002:a62:ee0f:0:b029:335:a681:34f6 with SMTP id e15-20020a62ee0f0000b0290335a68134f6mr5682382pfi.55.1628918756877;
        Fri, 13 Aug 2021 22:25:56 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id s5sm4783133pgp.81.2021.08.13.22.25.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Aug 2021 22:25:56 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v1 04/12] mm: vmscan: rework move_pages_to_lru()
Date:   Sat, 14 Aug 2021 13:25:11 +0800
Message-Id: <20210814052519.86679-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210814052519.86679-1-songmuchun@bytedance.com>
References: <20210814052519.86679-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the later patch, we will reparent the LRU pages. The pages moved to
appropriate LRU list can be reparented during the process of the
move_pages_to_lru(). So holding a lruvec lock by the caller is wrong, we
should use the more general interface of folio_lruvec_relock_irq() to
acquire the correct lruvec lock.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mm.h |  1 +
 mm/vmscan.c        | 49 +++++++++++++++++++++++++------------------------
 2 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ce8fc0fd6d6e..1e7f06bc5f2d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -227,6 +227,7 @@ int overcommit_policy_handler(struct ctl_table *, int, void *, size_t *,
 #define PAGE_ALIGNED(addr)	IS_ALIGNED((unsigned long)(addr), PAGE_SIZE)
 
 #define lru_to_page(head) (list_entry((head)->prev, struct page, lru))
+#define lru_to_folio(head) (list_entry((head)->prev, struct folio, lru))
 
 void setup_initial_init_mm(void *start_code, void *end_code,
 			   void *end_data, void *brk);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 403a175a720f..8ce42858ad5d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2153,23 +2153,28 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
  * move_pages_to_lru() moves pages from private @list to appropriate LRU list.
  * On return, @list is reused as a list of pages to be freed by the caller.
  *
- * Returns the number of pages moved to the given lruvec.
+ * Returns the number of pages moved to the appropriate LRU list.
+ *
+ * Note: The caller must not hold any lruvec lock.
  */
-static unsigned int move_pages_to_lru(struct lruvec *lruvec,
-				      struct list_head *list)
+static unsigned int move_pages_to_lru(struct list_head *list)
 {
-	int nr_pages, nr_moved = 0;
+	int nr_moved = 0;
+	struct lruvec *lruvec = NULL;
 	LIST_HEAD(pages_to_free);
-	struct page *page;
 
 	while (!list_empty(list)) {
-		page = lru_to_page(list);
+		int nr_pages;
+		struct folio *folio = lru_to_folio(list);
+		struct page *page = &folio->page;
+
+		lruvec = folio_lruvec_relock_irq(folio, lruvec);
 		VM_BUG_ON_PAGE(PageLRU(page), page);
 		list_del(&page->lru);
 		if (unlikely(!page_evictable(page))) {
-			spin_unlock_irq(&lruvec->lru_lock);
+			unlock_page_lruvec_irq(lruvec);
 			putback_lru_page(page);
-			spin_lock_irq(&lruvec->lru_lock);
+			lruvec = NULL;
 			continue;
 		}
 
@@ -2190,20 +2195,16 @@ static unsigned int move_pages_to_lru(struct lruvec *lruvec,
 			__clear_page_lru_flags(page);
 
 			if (unlikely(PageCompound(page))) {
-				spin_unlock_irq(&lruvec->lru_lock);
+				unlock_page_lruvec_irq(lruvec);
 				destroy_compound_page(page);
-				spin_lock_irq(&lruvec->lru_lock);
+				lruvec = NULL;
 			} else
 				list_add(&page->lru, &pages_to_free);
 
 			continue;
 		}
 
-		/*
-		 * All pages were isolated from the same lruvec (and isolation
-		 * inhibits memcg migration).
-		 */
-		VM_BUG_ON_PAGE(!folio_matches_lruvec(page_folio(page), lruvec), page);
+		VM_BUG_ON_PAGE(!folio_matches_lruvec(folio, lruvec), page);
 		add_page_to_lru_list(page, lruvec);
 		nr_pages = thp_nr_pages(page);
 		nr_moved += nr_pages;
@@ -2211,6 +2212,8 @@ static unsigned int move_pages_to_lru(struct lruvec *lruvec,
 			workingset_age_nonresident(lruvec, nr_pages);
 	}
 
+	if (lruvec)
+		unlock_page_lruvec_irq(lruvec);
 	/*
 	 * To save our caller's stack, now use input list for pages to free.
 	 */
@@ -2284,16 +2287,16 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 
 	nr_reclaimed = shrink_page_list(&page_list, pgdat, sc, &stat, false);
 
-	spin_lock_irq(&lruvec->lru_lock);
-	move_pages_to_lru(lruvec, &page_list);
+	move_pages_to_lru(&page_list);
 
+	local_irq_disable();
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
 	item = current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
 	if (!cgroup_reclaim(sc))
 		__count_vm_events(item, nr_reclaimed);
 	__count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
 	__count_vm_events(PGSTEAL_ANON + file, nr_reclaimed);
-	spin_unlock_irq(&lruvec->lru_lock);
+	local_irq_enable();
 
 	lru_note_cost(lruvec, file, stat.nr_pageout);
 	mem_cgroup_uncharge_list(&page_list);
@@ -2420,18 +2423,16 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	/*
 	 * Move pages back to the lru list.
 	 */
-	spin_lock_irq(&lruvec->lru_lock);
-
-	nr_activate = move_pages_to_lru(lruvec, &l_active);
-	nr_deactivate = move_pages_to_lru(lruvec, &l_inactive);
+	nr_activate = move_pages_to_lru(&l_active);
+	nr_deactivate = move_pages_to_lru(&l_inactive);
 	/* Keep all free pages in l_active list */
 	list_splice(&l_inactive, &l_active);
 
+	local_irq_disable();
 	__count_vm_events(PGDEACTIVATE, nr_deactivate);
 	__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deactivate);
-
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
-	spin_unlock_irq(&lruvec->lru_lock);
+	local_irq_enable();
 
 	mem_cgroup_uncharge_list(&l_active);
 	free_unref_page_list(&l_active);
-- 
2.11.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC7240DBC9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237425AbhIPNyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237057AbhIPNx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:53:59 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB69AC061766
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:52:38 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id j16so5999356pfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UBgSt1PKBh2hsHiY9dm9Ju+xM0YuuTYqFWANnDJd04w=;
        b=sC4DwSOmtG8p/DcjAo+DdQZMblnuKki6ByjoVl8FPu4OxP4m38XeeVz/I98gt4penv
         sBgbheYhFgFUZ9FVctIio08J/ADuMYA9Muk4DT+R7ztXlUvJvIYKXS+ROs3Rjtl+unnz
         PDLzeJJIGwZ0RQ2xVOvIB9pqICSvqhZ3YfAZ6txMTp1qDwOgVKmcHp8xSGUoFd7+3yl3
         P6SsyV+E3q9QYaiwUVQE5lxyaeF0V6zR337YJxi0o8okqwaMQTo/05Ay05X9OD495ZVG
         kmdZneZgmlxmmSvNZ3bryFTcEZWlTnOB026BN6qgP1hGLOlvanybZLOXcgPIdNznjje2
         tZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UBgSt1PKBh2hsHiY9dm9Ju+xM0YuuTYqFWANnDJd04w=;
        b=efX9ZLkJjZpSxzm0u9GuhHzGCJOENEWO3QFt2k/lH1TYvR8ZcZIpHid6A/qIiBFBLb
         FekfbVfV7RVgzMXTNhGSNvEWLUZOA41alywtY+VUvENuycN9X1wy9v+LNAaJnehYV8gv
         CakVP2xf80CyeEFwqc9sbZlbqz1b/qgJ3I8ed1eYZ3NOKA3rHWWHp+q4VvH9GjgHqnUx
         bNKdwwtITO3kdJ86jdQll4je73r4QdjfKSz6p5EUWcclUKNE9QvPODuOlKUyZwkbYzVK
         bmFb/qiTK5RMbVA6Y43c0B1kpXdnH8ei9oNQbfvNXiYvPQ3thXrn5uOXMy+sG8kTJOZL
         HvKQ==
X-Gm-Message-State: AOAM5335/CD5q5hZaM/RHAKgXs+U8qRlqYWwh1hPavshcvfTrO80DKbR
        0GT1xyp+b1cBtm9Pw7i8XZMN6A==
X-Google-Smtp-Source: ABdhPJwbQyjl6TV4cG+e5RDBIXtNXKmxSSdP72Y+ui6oM1/96GxVXfFHBvyCjYIGLmTOMdog/1SA9w==
X-Received: by 2002:a62:2703:0:b0:42b:5319:cbbc with SMTP id n3-20020a622703000000b0042b5319cbbcmr5612530pfn.66.1631800358312;
        Thu, 16 Sep 2021 06:52:38 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id o9sm3617443pfh.217.2021.09.16.06.52.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Sep 2021 06:52:37 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 05/13] mm: vmscan: rework move_pages_to_lru()
Date:   Thu, 16 Sep 2021 21:47:40 +0800
Message-Id: <20210916134748.67712-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210916134748.67712-1-songmuchun@bytedance.com>
References: <20210916134748.67712-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the later patch, we will reparent the LRU pages. The pages which will
move to appropriate LRU list can be reparented during the process of the
move_pages_to_lru(). So holding a lruvec lock by the caller is wrong, we
should use the more general interface of relock_page_lruvec_irq() to
acquire the correct lruvec lock.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/vmscan.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 74296c2d1fed..6878a6bff2f8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2149,23 +2149,27 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
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
+		struct page *page = lru_to_page(list);
+
+		lruvec = relock_page_lruvec_irq(page, lruvec);
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
 
@@ -2186,19 +2190,15 @@ static unsigned int move_pages_to_lru(struct lruvec *lruvec,
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
 		VM_BUG_ON_PAGE(!page_matches_lruvec(page, lruvec), page);
 		add_page_to_lru_list(page, lruvec);
 		nr_pages = thp_nr_pages(page);
@@ -2207,6 +2207,8 @@ static unsigned int move_pages_to_lru(struct lruvec *lruvec,
 			workingset_age_nonresident(lruvec, nr_pages);
 	}
 
+	if (lruvec)
+		unlock_page_lruvec_irq(lruvec);
 	/*
 	 * To save our caller's stack, now use input list for pages to free.
 	 */
@@ -2280,16 +2282,16 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 
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
@@ -2416,18 +2418,16 @@ static void shrink_active_list(unsigned long nr_to_scan,
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


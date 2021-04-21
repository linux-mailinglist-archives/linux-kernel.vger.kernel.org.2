Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B813665FB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 09:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbhDUHCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 03:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236816AbhDUHCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:02:13 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA1CC061345
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 00:01:40 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id w6so13278875pfc.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 00:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t7t6Q91qk42+laTZEZ/eAgH0IZUsPr/8bu7v1WzbIaM=;
        b=yvI/3QDQhvIQJRf87OwfshrPmJhNfCJkLkh1k9C+ey1K1fIjSITnfWbUaxRsDCQDNk
         ZaRMduBQLtQ5pw9feteaJ6dbFEhaGlvRtdU3xTreLd2gg0NgWryceTRVs8w8RY73MOl1
         q7cfgTN8KqawKQUbr1iVc4v9aqiu/je76YceZiKV8L3yyoiNXeCSCgYZCKo2sNmUvpGR
         3gypTKFhsp5qWwpT9IslB03qPCdKUsZPwz3Y3e934TJPhM56geaT8UauEP302Bod25pc
         EN/PrVkjotHfbxGv3qJ5X05mhYYTV12IDETtv1G7gHNoDlCURf1ja5XbPgfLZYJqsVri
         Pb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t7t6Q91qk42+laTZEZ/eAgH0IZUsPr/8bu7v1WzbIaM=;
        b=E0S1E0BhVJbV7y9vNms+vQ6vQt4H7wO8rWweQdmw2H9tHLLTOQAMiPGlZjhHBviSgc
         DBwmUv0W9TC6ZNumh2H+nMfbe/7OjT4tqPFZGjC3KcpSBUihoCFjrYHFhoO4jTmoTK/N
         JAvN+w7GXVc5/RCDr5X5bK5xSqfU76fcRZfvgh3ag7asRSnp4sNNmNPjVvfBCPz4Mt2m
         MADPVfH8GzklY6fVvdzV0qXiHKhpeCVrhXXnp7gKTyjCwWUgnbTw7N4bE5FC6vucDxuu
         oFhaNQ36Hyto7Mrc3bWt2KJQfQ/sa6rwasZ6cRqaDHdem41o34b/D6Knq4fUBDjvdG7W
         vGrA==
X-Gm-Message-State: AOAM530Mdrn0KCZ4XYnYzJtsMh1mGLy9bZpeyxd+J41egpkMQIibMhqy
        yES1abwyLqnDHA1dKgsnRbXlZw==
X-Google-Smtp-Source: ABdhPJzikyYSkvQ9Zb6NS4R1yjENZ416kpFjoaDvHupnfrgEpihURTAFqcyQrf1Aew2BIY1BLOuOfA==
X-Received: by 2002:a63:10:: with SMTP id 16mr20987411pga.143.1618988499850;
        Wed, 21 Apr 2021 00:01:39 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id c4sm929842pfb.94.2021.04.21.00.01.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Apr 2021 00:01:39 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v3 04/12] mm: vmscan: rework move_pages_to_lru()
Date:   Wed, 21 Apr 2021 15:00:51 +0800
Message-Id: <20210421070059.69361-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210421070059.69361-1-songmuchun@bytedance.com>
References: <20210421070059.69361-1-songmuchun@bytedance.com>
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
index 2d2727b78df9..02d14a377b0e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2012,23 +2012,27 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
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
 
@@ -2049,19 +2053,15 @@ static unsigned int move_pages_to_lru(struct lruvec *lruvec,
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
@@ -2070,6 +2070,8 @@ static unsigned int move_pages_to_lru(struct lruvec *lruvec,
 			workingset_age_nonresident(lruvec, nr_pages);
 	}
 
+	if (lruvec)
+		unlock_page_lruvec_irq(lruvec);
 	/*
 	 * To save our caller's stack, now use input list for pages to free.
 	 */
@@ -2143,16 +2145,16 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 
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
@@ -2279,18 +2281,16 @@ static void shrink_active_list(unsigned long nr_to_scan,
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


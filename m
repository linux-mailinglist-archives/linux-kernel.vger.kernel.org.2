Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1DA392ADD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbhE0Jfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235934AbhE0Jfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:35:48 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED623C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 02:34:14 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id f22so176804pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 02:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6S3VYdwj0I4ndBv5IZcX9wqKGEeDomJn5lWaN+oyebU=;
        b=tFJ4jQpkCtjmisK3bHuyjg9vSnoim9HF8qZj/O3NLTxN/r6CuCGs7h726a5GF+5RuQ
         J3DwlStc0hpKPW8ZBAZzoGLstgpoPOFAi7Dtypzm308dom1xTZbtJheksBzIw2uCorO1
         kEPmkSOBgSFNlApUyEpsVB0x8dhPpBXNTXVXSzpxqeWdbImgfa+eMoSDSlB8dR8A0VXE
         /J52qezsac9XrUMNJs+DomOTX8ZBJ8THtNq6p8r/ZYNpIEDVomKQEqjNHmjaU40HJzJe
         2ws0ESwJvQySp/2ea8mWAsJoi5/uCJlAj9PWde7PiEv6j7g81hdz9jK8N4unRZ90TGaK
         y8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6S3VYdwj0I4ndBv5IZcX9wqKGEeDomJn5lWaN+oyebU=;
        b=NgGcRnNdbgUCUi6M8PbOL59plrcbT14vScKoamtDBtIsVhGzGjftpxVMJhQYy3wmhq
         s5xECF9kcp6lB68QOv/JQMNoKEZZG2o2UaQeuJIT5JHMOVLvixwuxCDtQEVaMoOuUGlx
         ORfsBbMa0IT6eAnWuVxYGJa3BXnLk3y5Mgk5AlChK6mZzPUDTutLDcOV2jUY9A+1YvKf
         K4Mh7si03I72mcozuUus3cnCwyuXH1fsiwfRo3APgKoCms4Z6582Sbr1MYqUqEO1Fffi
         oh3vljR6VfvGS33hIzajeeqj9ijzt9ASGjBx7gvx05+9RZiDvpotEZgZZPEPdDpAyubG
         x63A==
X-Gm-Message-State: AOAM532gRfVNubYBLFRnAuyoeSngD9U8NHPKaAQuIei8iNqDvalV4VAN
        L6+xTHfx5Xm2sqLRUKiuIhW3NA==
X-Google-Smtp-Source: ABdhPJxzYilN8wdhcWYbfyeR9OlWXvIYbGhxnkv9fPjurYaFKr1eUghEA78K7Alidc4+zMAN4MiPag==
X-Received: by 2002:a05:6a00:ac9:b029:2de:a06d:a52f with SMTP id c9-20020a056a000ac9b02902dea06da52fmr2961337pfl.4.1622108054505;
        Thu, 27 May 2021 02:34:14 -0700 (PDT)
Received: from localhost.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id a9sm1418917pfl.57.2021.05.27.02.34.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 May 2021 02:34:14 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v4 04/12] mm: vmscan: rework move_pages_to_lru()
Date:   Thu, 27 May 2021 17:33:28 +0800
Message-Id: <20210527093336.14895-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210527093336.14895-1-songmuchun@bytedance.com>
References: <20210527093336.14895-1-songmuchun@bytedance.com>
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
index 5a15748f9faf..731a8f5a4128 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2013,23 +2013,27 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
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
 
@@ -2050,19 +2054,15 @@ static unsigned int move_pages_to_lru(struct lruvec *lruvec,
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
@@ -2071,6 +2071,8 @@ static unsigned int move_pages_to_lru(struct lruvec *lruvec,
 			workingset_age_nonresident(lruvec, nr_pages);
 	}
 
+	if (lruvec)
+		unlock_page_lruvec_irq(lruvec);
 	/*
 	 * To save our caller's stack, now use input list for pages to free.
 	 */
@@ -2144,16 +2146,16 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 
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
@@ -2280,18 +2282,16 @@ static void shrink_active_list(unsigned long nr_to_scan,
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


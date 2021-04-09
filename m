Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7DA359ECF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbhDIMdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbhDIMdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:33:50 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDDEC061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 05:33:34 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so4906230pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 05:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HQRfNWec2N1yRgKiHLs5smFMX5nNLLYEsEQp4hiL+hM=;
        b=xuxI26YkmKwqfQqtDIVdkctj0nKawNblPrAjBP9MpTrz+4n/x0b3aK4NmG2TXOssIB
         wNG/q6BmfQf8FLCcKyPzA7bBnNZCnJ5qh5vGlZJRPhbC0thJwLaMmfSn77taNAaoyOG8
         VPEVfK5TX+GnhuTfBxT5Y/5iU1NkRD14988/CQjYzzL2JNF7NDKSvtuzn4POz8WsLwiV
         6GgXznX6/JsW51KLtKwP6Yy27XT87SFiv92NQhpNr5oV8ZErYUU8aT73rTOtQ8AyYeOH
         l48BVrj9WpxReoJxs5N7DLEjylMllQ1B6YGsd6ObkqQHCQJvXqquCJL0/wa7MJXEbeZe
         eIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HQRfNWec2N1yRgKiHLs5smFMX5nNLLYEsEQp4hiL+hM=;
        b=f/sJ5FSZS7seh5tKuu/IcYjoLllnNMiA32QGT4fOQgyscLEEUtp6pPjf4BhAGQZbf4
         D115kdnIOT3Xi6+2ZBkZwiZ7xrpyJ3C4wK9TYjF3SBapEWAjf09Py07jIUlK11J9pwQN
         ijgtH8MQvwtOSgEvDvw/FoNgZ4kFHCli/xDyHRS/ORN6Taok15Br/AseoPTRisEkHmCg
         OVSNy+a/9fFVko9H2oQ8AVJOany3FVLHy3XBHpDjMQOIAU2aEMltYNeqDsGkNTjyfmjz
         iaXEhRcwVDkOpQxW9e1Cjxc/N3McYZ2t3fp2JsmJ1FdL8l2L6CfrJLJNuqIRtm0jdjuU
         UvRA==
X-Gm-Message-State: AOAM531uLlScePVT75T+s0HXTtxpewLyVqQiy/++eJfq84tFSJZ0ec8S
        SgAuMmmOuOUixu9RYzf0w0Kk1A==
X-Google-Smtp-Source: ABdhPJypPvBB5/Qa911Z1szSK8iKjPZoCBtRXhKX0kaqMIfb+qQwZPordw2nik/9f4qsPB164WSLSQ==
X-Received: by 2002:a17:90a:156:: with SMTP id z22mr14396117pje.181.1617971613578;
        Fri, 09 Apr 2021 05:33:33 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id t3sm2167785pfg.176.2021.04.09.05.33.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Apr 2021 05:33:33 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v2 18/18] mm: lru: use lruvec lock to serialize memcg changes
Date:   Fri,  9 Apr 2021 20:29:59 +0800
Message-Id: <20210409122959.82264-19-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210409122959.82264-1-songmuchun@bytedance.com>
References: <20210409122959.82264-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described by commit fc574c23558c ("mm/swap.c: serialize memcg
changes in pagevec_lru_move_fn"), TestClearPageLRU() aims to
serialize mem_cgroup_move_account() during pagevec_lru_move_fn().
Now lock_page_lruvec*() has the ability to detect whether page
memcg has been changed. So we can use lruvec lock to serialize
mem_cgroup_move_account() during pagevec_lru_move_fn(). This
change is a partial revert of the commit fc574c23558c ("mm/swap.c:
serialize memcg changes in pagevec_lru_move_fn").

And pagevec_lru_move_fn() is more hot compare with
mem_cgroup_move_account(), removing an atomic operation would be
an optimization. Also this change would not dirty cacheline for a
page which isn't on the LRU.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/compaction.c |  1 +
 mm/memcontrol.c | 31 +++++++++++++++++++++++++++++++
 mm/swap.c       | 41 +++++++++++------------------------------
 mm/vmscan.c     |  9 ++++-----
 4 files changed, 47 insertions(+), 35 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 5fd37e14404f..382e40ccc694 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -531,6 +531,7 @@ compact_lock_page_lruvec_irqsave(struct page *page, unsigned long *flags,
 
 	spin_lock_irqsave(&lruvec->lru_lock, *flags);
 out:
+	/* See the comments in lock_page_lruvec(). */
 	if (unlikely(lruvec_memcg(lruvec) != page_memcg(page))) {
 		spin_unlock_irqrestore(&lruvec->lru_lock, *flags);
 		goto retry;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 403b0743338b..1017e92f1d82 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1323,12 +1323,38 @@ struct lruvec *lock_page_lruvec(struct page *page)
 	lruvec = mem_cgroup_page_lruvec(page);
 	spin_lock(&lruvec->lru_lock);
 
+	/*
+	 * The memcg of the page can be changed by any the following routines:
+	 *
+	 * 1) mem_cgroup_move_account() or
+	 * 2) memcg_reparent_objcgs()
+	 *
+	 * The possible bad scenario would like:
+	 *
+	 * CPU0:                CPU1:                CPU2:
+	 * lruvec = mem_cgroup_page_lruvec()
+	 *
+	 *                      if (!isolate_lru_page())
+	 *                              mem_cgroup_move_account()
+	 *
+	 *                                           memcg_reparent_objcgs()
+	 *
+	 * spin_lock(&lruvec->lru_lock)
+	 *                ^^^^^^
+	 *              wrong lock
+	 *
+	 * Either CPU1 or CPU2 can change page memcg, so we need to check
+	 * whether page memcg is changed, if so, we should reacquire the
+	 * new lruvec lock.
+	 */
 	if (unlikely(lruvec_memcg(lruvec) != page_memcg(page))) {
 		spin_unlock(&lruvec->lru_lock);
 		goto retry;
 	}
 
 	/*
+	 * When we reach here, it means that the page_memcg(page) is stable.
+	 *
 	 * Preemption is disabled in the internal of spin_lock, which can serve
 	 * as RCU read-side critical sections.
 	 */
@@ -1346,6 +1372,7 @@ struct lruvec *lock_page_lruvec_irq(struct page *page)
 	lruvec = mem_cgroup_page_lruvec(page);
 	spin_lock_irq(&lruvec->lru_lock);
 
+	/* See the comments in lock_page_lruvec(). */
 	if (unlikely(lruvec_memcg(lruvec) != page_memcg(page))) {
 		spin_unlock_irq(&lruvec->lru_lock);
 		goto retry;
@@ -1366,6 +1393,7 @@ struct lruvec *lock_page_lruvec_irqsave(struct page *page, unsigned long *flags)
 	lruvec = mem_cgroup_page_lruvec(page);
 	spin_lock_irqsave(&lruvec->lru_lock, *flags);
 
+	/* See the comments in lock_page_lruvec(). */
 	if (unlikely(lruvec_memcg(lruvec) != page_memcg(page))) {
 		spin_unlock_irqrestore(&lruvec->lru_lock, *flags);
 		goto retry;
@@ -5687,7 +5715,10 @@ static int mem_cgroup_move_account(struct page *page,
 	obj_cgroup_get(to->objcg);
 	obj_cgroup_put(from->objcg);
 
+	/* See the comments in lock_page_lruvec(). */
+	spin_lock(&from_vec->lru_lock);
 	page->memcg_data = (unsigned long)to->objcg;
+	spin_unlock(&from_vec->lru_lock);
 
 	__unlock_page_objcg(from->objcg);
 
diff --git a/mm/swap.c b/mm/swap.c
index f3ce307d09fa..48e66a05c913 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -211,14 +211,8 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 	for (i = 0; i < pagevec_count(pvec); i++) {
 		struct page *page = pvec->pages[i];
 
-		/* block memcg migration during page moving between lru */
-		if (!TestClearPageLRU(page))
-			continue;
-
 		lruvec = relock_page_lruvec_irqsave(page, lruvec, &flags);
 		(*move_fn)(page, lruvec);
-
-		SetPageLRU(page);
 	}
 	if (lruvec)
 		unlock_page_lruvec_irqrestore(lruvec, flags);
@@ -228,7 +222,7 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 
 static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec)
 {
-	if (!PageUnevictable(page)) {
+	if (PageLRU(page) && !PageUnevictable(page)) {
 		del_page_from_lru_list(page, lruvec);
 		ClearPageActive(page);
 		add_page_to_lru_list_tail(page, lruvec);
@@ -324,7 +318,7 @@ void lru_note_cost_page(struct page *page)
 
 static void __activate_page(struct page *page, struct lruvec *lruvec)
 {
-	if (!PageActive(page) && !PageUnevictable(page)) {
+	if (PageLRU(page) && !PageActive(page) && !PageUnevictable(page)) {
 		int nr_pages = thp_nr_pages(page);
 
 		del_page_from_lru_list(page, lruvec);
@@ -377,12 +371,9 @@ static void activate_page(struct page *page)
 	struct lruvec *lruvec;
 
 	page = compound_head(page);
-	if (TestClearPageLRU(page)) {
-		lruvec = lock_page_lruvec_irq(page);
-		__activate_page(page, lruvec);
-		unlock_page_lruvec_irq(lruvec);
-		SetPageLRU(page);
-	}
+	lruvec = lock_page_lruvec_irq(page);
+	__activate_page(page, lruvec);
+	unlock_page_lruvec_irq(lruvec);
 }
 #endif
 
@@ -537,6 +528,9 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec)
 	bool active = PageActive(page);
 	int nr_pages = thp_nr_pages(page);
 
+	if (!PageLRU(page))
+		return;
+
 	if (PageUnevictable(page))
 		return;
 
@@ -574,7 +568,7 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec)
 
 static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec)
 {
-	if (PageActive(page) && !PageUnevictable(page)) {
+	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
 		int nr_pages = thp_nr_pages(page);
 
 		del_page_from_lru_list(page, lruvec);
@@ -590,7 +584,7 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec)
 
 static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec)
 {
-	if (PageAnon(page) && PageSwapBacked(page) &&
+	if (PageLRU(page) && PageAnon(page) && PageSwapBacked(page) &&
 	    !PageSwapCache(page) && !PageUnevictable(page)) {
 		int nr_pages = thp_nr_pages(page);
 
@@ -1055,20 +1049,7 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
  */
 void __pagevec_lru_add(struct pagevec *pvec)
 {
-	int i;
-	struct lruvec *lruvec = NULL;
-	unsigned long flags = 0;
-
-	for (i = 0; i < pagevec_count(pvec); i++) {
-		struct page *page = pvec->pages[i];
-
-		lruvec = relock_page_lruvec_irqsave(page, lruvec, &flags);
-		__pagevec_lru_add_fn(page, lruvec);
-	}
-	if (lruvec)
-		unlock_page_lruvec_irqrestore(lruvec, flags);
-	release_pages(pvec->pages, pvec->nr);
-	pagevec_reinit(pvec);
+	pagevec_lru_move_fn(pvec, __pagevec_lru_add_fn);
 }
 
 /**
diff --git a/mm/vmscan.c b/mm/vmscan.c
index af0fc8110bdc..12c2ea6cb6f3 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4469,18 +4469,17 @@ void check_move_unevictable_pages(struct pagevec *pvec)
 		nr_pages = thp_nr_pages(page);
 		pgscanned += nr_pages;
 
-		/* block memcg migration during page moving between lru */
-		if (!TestClearPageLRU(page))
+		lruvec = relock_page_lruvec_irq(page, lruvec);
+
+		if (!PageLRU(page) || !PageUnevictable(page))
 			continue;
 
-		lruvec = relock_page_lruvec_irq(page, lruvec);
-		if (page_evictable(page) && PageUnevictable(page)) {
+		if (page_evictable(page)) {
 			del_page_from_lru_list(page, lruvec);
 			ClearPageUnevictable(page);
 			add_page_to_lru_list(page, lruvec);
 			pgrescued += nr_pages;
 		}
-		SetPageLRU(page);
 	}
 
 	if (lruvec) {
-- 
2.11.0


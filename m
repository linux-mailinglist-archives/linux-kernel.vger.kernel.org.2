Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB13366609
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 09:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237083AbhDUHD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 03:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237019AbhDUHC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:02:58 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108FCC06138D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 00:02:26 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id d10so28867341pgf.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 00:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BJAHJm3WxSe3+llhyrF3h/iI+dQ91A0h6PAGmd2OEFk=;
        b=BeH9IaJf8VdTn4BAiugjYflGK3f6pItsg0TrfNOa1MxaHsQKfj6jg0UE2QvaYoSuCG
         wgmFXLZ8DBrWtGquuBiQMWp5zbNNHUGToDM+d3vVAS2nfLBR+45go56JfFtlUyfwswb4
         vLYbHoL5kwfMpPjb6diPhoTzcW8Me7/HlaJ9R2Pdh8s0/QUPPOepbp7z/uBW3tM7UjrQ
         oR1bpdJgMLNVsiV0jnDDb7la4ruYN1ePHui0wHUzgISwjBzKPYzMEcoqlJExroko1Yri
         t3ddomQky76M0c/NEbSBW1YPNwf6TC66wnBz1J5sUchc2Y9amStwuBFFnXhAn1B+rHYL
         VEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BJAHJm3WxSe3+llhyrF3h/iI+dQ91A0h6PAGmd2OEFk=;
        b=eUiyb/PMYvCEQTrXlLlW8JuJb03ogR6BakjBrnjTeA2s5EuOuQIhI3KbLfqBjnw6MG
         Wm6DF9ai7bw2RyUD5BExToGT6elnv0ZPULYMbAQWsoH1lXZ1d0GrYHMkzsny/Kepf0De
         ompC/HR9tcXxhD4MbCYKZduAPCx/oKgYvjHpX27y3H1xND51PpgUiCLBpqT8LX3ZZ6Oo
         MZR/xXJIz3HVfEDV/UTwrNvaNOo66hXRvNI4of/sJ7mWpawgx75SHQ50wrWzzG97ehZH
         m2agJoo2kRrtfEYSVFppdlDJdDGbtMduwKexUM+IAvyp/w1tWJon/pfj+Z7xPz049ttc
         zePg==
X-Gm-Message-State: AOAM531FFSKWUzqyuUd/LIyprQG2cYCZjMwrJvXzZF42KCS7ps3Nfm8s
        r+LynzVsg9xHeXi5gOnTvyrJnw==
X-Google-Smtp-Source: ABdhPJzeTGvNyWdwdVzov34MZyp9MGcpmAiL3jSAq3rDfYrXFLPV6gEhqI7Dgn5W34gAQp+k2m70Jw==
X-Received: by 2002:a17:90a:f303:: with SMTP id ca3mr9435343pjb.145.1618988545660;
        Wed, 21 Apr 2021 00:02:25 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id c4sm929842pfb.94.2021.04.21.00.02.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Apr 2021 00:02:25 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v3 12/12] mm: lru: use lruvec lock to serialize memcg changes
Date:   Wed, 21 Apr 2021 15:00:59 +0800
Message-Id: <20210421070059.69361-13-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210421070059.69361-1-songmuchun@bytedance.com>
References: <20210421070059.69361-1-songmuchun@bytedance.com>
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
index f88e2731d27c..9421abb64c16 100644
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
index dcab57d2b981..1e68a9992b01 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1303,12 +1303,38 @@ struct lruvec *lock_page_lruvec(struct page *page)
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
@@ -1326,6 +1352,7 @@ struct lruvec *lock_page_lruvec_irq(struct page *page)
 	lruvec = mem_cgroup_page_lruvec(page);
 	spin_lock_irq(&lruvec->lru_lock);
 
+	/* See the comments in lock_page_lruvec(). */
 	if (unlikely(lruvec_memcg(lruvec) != page_memcg(page))) {
 		spin_unlock_irq(&lruvec->lru_lock);
 		goto retry;
@@ -1346,6 +1373,7 @@ struct lruvec *lock_page_lruvec_irqsave(struct page *page, unsigned long *flags)
 	lruvec = mem_cgroup_page_lruvec(page);
 	spin_lock_irqsave(&lruvec->lru_lock, *flags);
 
+	/* See the comments in lock_page_lruvec(). */
 	if (unlikely(lruvec_memcg(lruvec) != page_memcg(page))) {
 		spin_unlock_irqrestore(&lruvec->lru_lock, *flags);
 		goto retry;
@@ -5673,7 +5701,10 @@ static int mem_cgroup_move_account(struct page *page,
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
index 924db107fad7..1e55e337952e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4468,18 +4468,17 @@ void check_move_unevictable_pages(struct pagevec *pvec)
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


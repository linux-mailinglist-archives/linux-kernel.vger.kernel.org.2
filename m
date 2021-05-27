Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4314F392AE5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbhE0Jgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236005AbhE0Jge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:36:34 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0DCC06138A
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 02:35:01 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g24so99943pji.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 02:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3R9N84gM7kQCasDHJd2pwm4qY19zJfOdLxk9Bm5x1RY=;
        b=1h6bUqcQFDhUpWHT5X49ZyDpj+0W/KsRC+H1eq3A+HlCinVVmHIwfiB5+230NhqbZt
         EwrbUhM6Ng11xNGc0vrOGQ99LZOPp2ITf67DaeFfqxMDv8cnkVDek0L0eWgQoLb7UbuE
         CVwrT/0iwmUfrnMOkyAeIEep8RN108/CqE4JGwbsN9Awdjq2ET63kf95eT5GEXRW0Okx
         Jd9sBI00EaMJOFmKbuX72zT63KvaQuPvDHusjNGnixLEb5sNjJMkJTq9QgGZzLd/Wxht
         TBBY50G3tm2vY/DfsSf4LfdlC7mL3Mr5wP8uYNPzH2YsIaOgcZcU4wOBTf2bAjApa640
         V5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3R9N84gM7kQCasDHJd2pwm4qY19zJfOdLxk9Bm5x1RY=;
        b=Xbp7hrxETm2H2kUrybyEV4YK2OceZPLIByB8El9GWLW5Ryjc8+sJu7Seyc4PACllXo
         aGNs5kJAccJAgr9kfPZm6aDI22/xtKJNlFFsd7rfYiLiWHybhhGGkOCKcBa/JnWIr59B
         96cMHprIyzcPVnEyIZuo7dAu8L9RCfeB6JDtcrO0vXbRECBbMty3QYk0WMHAKkITWHIh
         4H045zbXgkult0oTwGih35Z2LlDrTcL/uymL7eYNrKEms6Oi4Kfdyh+nlukqTcNHbA5R
         oILEKlZGP3izvohFjaLPtQAx7PC10fCGYthIdmWl6fKcIQ0rqLAgGJPyFGJ/deRyeqTS
         K5YQ==
X-Gm-Message-State: AOAM531jUxxiaAr3BFoG8hFJ/fGXC4GBR2umxu/PLpAk5jeCt1z+C5Z1
        sPZJOmgjuuVJxOez4WXhR2f6Zw==
X-Google-Smtp-Source: ABdhPJygcJ3M5c5lgVK3g02bjCw7gPzvN2YRDDlBMe271/7AOxs/or5Idi+lfILXatJqVhBi9+ePRQ==
X-Received: by 2002:a17:90a:4d0a:: with SMTP id c10mr8426672pjg.206.1622108100589;
        Thu, 27 May 2021 02:35:00 -0700 (PDT)
Received: from localhost.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id a9sm1418917pfl.57.2021.05.27.02.34.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 May 2021 02:35:00 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v4 12/12] mm: lru: use lruvec lock to serialize memcg changes
Date:   Thu, 27 May 2021 17:33:36 +0800
Message-Id: <20210527093336.14895-13-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210527093336.14895-1-songmuchun@bytedance.com>
References: <20210527093336.14895-1-songmuchun@bytedance.com>
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
index 225e06c63ec1..c8505542c33e 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -531,6 +531,7 @@ static struct lruvec *compact_lock_page_irqsave(struct page *page,
 
 	spin_lock_irqsave(&lruvec->lru_lock, *flags);
 out:
+	/* See the comments in lock_page_lruvec(). */
 	if (unlikely(lruvec_memcg(lruvec) != page_memcg(page))) {
 		spin_unlock_irqrestore(&lruvec->lru_lock, *flags);
 		goto retry;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 33aad9ed5071..289524aaf629 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1318,12 +1318,38 @@ struct lruvec *lock_page_lruvec(struct page *page)
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
@@ -1341,6 +1367,7 @@ struct lruvec *lock_page_lruvec_irq(struct page *page)
 	lruvec = mem_cgroup_page_lruvec(page);
 	spin_lock_irq(&lruvec->lru_lock);
 
+	/* See the comments in lock_page_lruvec(). */
 	if (unlikely(lruvec_memcg(lruvec) != page_memcg(page))) {
 		spin_unlock_irq(&lruvec->lru_lock);
 		goto retry;
@@ -1361,6 +1388,7 @@ struct lruvec *lock_page_lruvec_irqsave(struct page *page, unsigned long *flags)
 	lruvec = mem_cgroup_page_lruvec(page);
 	spin_lock_irqsave(&lruvec->lru_lock, *flags);
 
+	/* See the comments in lock_page_lruvec(). */
 	if (unlikely(lruvec_memcg(lruvec) != page_memcg(page))) {
 		spin_unlock_irqrestore(&lruvec->lru_lock, *flags);
 		goto retry;
@@ -5846,7 +5874,10 @@ static int mem_cgroup_move_account(struct page *page,
 	obj_cgroup_get(to->objcg);
 	obj_cgroup_put(from->objcg);
 
+	/* See the comments in lock_page_lruvec(). */
+	spin_lock(&from_vec->lru_lock);
 	page->memcg_data = (unsigned long)to->objcg;
+	spin_unlock(&from_vec->lru_lock);
 
 	__unlock_page_objcg(from->objcg);
 
diff --git a/mm/swap.c b/mm/swap.c
index 6260e0e11268..a254f0dcfe1d 100644
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
index 5c30dffce768..a16b28da0878 100644
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


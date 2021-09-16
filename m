Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73DE40DBD3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbhIPNzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbhIPNyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:54:55 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4BBC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:53:26 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id t1so6235399pgv.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bEZAbShFT9/AGDoEdWVnP7By+WvjKrjWlaNhUM27Rf4=;
        b=3N+GUfr9XPjof0X7F5chysIJDn4foyS7LT7VQVGGK38nKAUyIWdPNtPVOONliIiyQg
         QhDI5WPPSlAe+bB82BFYrG9+s8QX0XqAl5ktF+7ou0SW6jJBfRIq1RwB/Tf5Rd5A6ehp
         i/2+oQ5pNkx7icbNgJEtmadfKnR9/ZYiSlRtz795E1jS6fjLntIOw3yVbjqY1sv+SZTf
         LNcddoncBWbBmLinB64zLewRXzvQcv6TDlb4vlywjk5AuY0QteMrGQGcUmVRF4sCmO2w
         HPLi6lcZAEQ572sOyF0NsFn2kXqxQCdOgamCGpSvMBRfMAecqNs/BZdK5ikHJy3dePWT
         K2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bEZAbShFT9/AGDoEdWVnP7By+WvjKrjWlaNhUM27Rf4=;
        b=H2eYIn+GIHt2yRzFDFvZWtH/Es5foEyl7btILIY/b89lhcmQesbLuT//dNdygKIR0t
         cZ24kxFZ6J7z2HauiR+COhwdLHewQ5nGYP6gdYu1a7tPoQpNGLDco6k2txWkoVQTk4so
         I05G00KWMtS6QY0zW69W0X11/1kLXoJTr36UigfETFUDLgIzKllnmeyxFf/dkSwDJuUg
         6/GzmU6vQMwl8zSRZTG0u4ZxPuuBlDSVtzdwds8hiTTOJ91xXy4peu91WCZyPjQNCG/9
         vUBStU44wErut4nemD0rKpgDR/mX2Of59zkTeLn4izB5WozMAnFc0N2a96cb3OrZQ1lo
         +UGQ==
X-Gm-Message-State: AOAM533pn3H/H4kQXsmD22aNM2rJSW25o3D2ZvL9+EERK2WEfr9EcXTM
        JW1toSkdUJsYg+uMwZ2oM2WCrg==
X-Google-Smtp-Source: ABdhPJyLFGvZlc7EjoFMDLGWq7+nu0XeRMDLx70MlWsHKWRfFwb/wq5DG37kKh6r7m4bAqo6W+6D9Q==
X-Received: by 2002:a62:a20d:0:b029:35b:73da:dc8d with SMTP id m13-20020a62a20d0000b029035b73dadc8dmr5363626pff.54.1631800405700;
        Thu, 16 Sep 2021 06:53:25 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id o9sm3617443pfh.217.2021.09.16.06.53.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Sep 2021 06:53:25 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 13/13] mm: lru: use lruvec lock to serialize memcg changes
Date:   Thu, 16 Sep 2021 21:47:48 +0800
Message-Id: <20210916134748.67712-14-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210916134748.67712-1-songmuchun@bytedance.com>
References: <20210916134748.67712-1-songmuchun@bytedance.com>
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
index c4ba41de8591..9e74f96f9879 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -529,6 +529,7 @@ static struct lruvec *compact_lock_page_irqsave(struct page *page,
 
 	spin_lock_irqsave(&lruvec->lru_lock, *flags);
 out:
+	/* See the comments in lock_page_lruvec(). */
 	if (unlikely(lruvec_memcg(lruvec) != page_memcg(page))) {
 		spin_unlock_irqrestore(&lruvec->lru_lock, *flags);
 		goto retry;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e46fc01c6164..ab65d1c975cc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1298,12 +1298,38 @@ struct lruvec *lock_page_lruvec(struct page *page)
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
@@ -1321,6 +1347,7 @@ struct lruvec *lock_page_lruvec_irq(struct page *page)
 	lruvec = mem_cgroup_page_lruvec(page);
 	spin_lock_irq(&lruvec->lru_lock);
 
+	/* See the comments in lock_page_lruvec(). */
 	if (unlikely(lruvec_memcg(lruvec) != page_memcg(page))) {
 		spin_unlock_irq(&lruvec->lru_lock);
 		goto retry;
@@ -1341,6 +1368,7 @@ struct lruvec *lock_page_lruvec_irqsave(struct page *page, unsigned long *flags)
 	lruvec = mem_cgroup_page_lruvec(page);
 	spin_lock_irqsave(&lruvec->lru_lock, *flags);
 
+	/* See the comments in lock_page_lruvec(). */
 	if (unlikely(lruvec_memcg(lruvec) != page_memcg(page))) {
 		spin_unlock_irqrestore(&lruvec->lru_lock, *flags);
 		goto retry;
@@ -5841,7 +5869,10 @@ static int mem_cgroup_move_account(struct page *page,
 	obj_cgroup_get(to->objcg);
 	obj_cgroup_put(from->objcg);
 
+	/* See the comments in lock_page_lruvec(). */
+	spin_lock(&from_vec->lru_lock);
 	page->memcg_data = (unsigned long)to->objcg;
+	spin_unlock(&from_vec->lru_lock);
 
 	__unlock_page_objcg(from->objcg);
 
diff --git a/mm/swap.c b/mm/swap.c
index 18d44f978b2e..fa2352f0f9d3 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -189,14 +189,8 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
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
@@ -206,7 +200,7 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 
 static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec)
 {
-	if (!PageUnevictable(page)) {
+	if (PageLRU(page) && !PageUnevictable(page)) {
 		del_page_from_lru_list(page, lruvec);
 		ClearPageActive(page);
 		add_page_to_lru_list_tail(page, lruvec);
@@ -302,7 +296,7 @@ void lru_note_cost_page(struct page *page)
 
 static void __activate_page(struct page *page, struct lruvec *lruvec)
 {
-	if (!PageActive(page) && !PageUnevictable(page)) {
+	if (PageLRU(page) && !PageActive(page) && !PageUnevictable(page)) {
 		int nr_pages = thp_nr_pages(page);
 
 		del_page_from_lru_list(page, lruvec);
@@ -355,12 +349,9 @@ static void activate_page(struct page *page)
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
 
@@ -515,6 +506,9 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec)
 	bool active = PageActive(page);
 	int nr_pages = thp_nr_pages(page);
 
+	if (!PageLRU(page))
+		return;
+
 	if (PageUnevictable(page))
 		return;
 
@@ -552,7 +546,7 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec)
 
 static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec)
 {
-	if (PageActive(page) && !PageUnevictable(page)) {
+	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
 		int nr_pages = thp_nr_pages(page);
 
 		del_page_from_lru_list(page, lruvec);
@@ -568,7 +562,7 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec)
 
 static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec)
 {
-	if (PageAnon(page) && PageSwapBacked(page) &&
+	if (PageLRU(page) && PageAnon(page) && PageSwapBacked(page) &&
 	    !PageSwapCache(page) && !PageUnevictable(page)) {
 		int nr_pages = thp_nr_pages(page);
 
@@ -1033,20 +1027,7 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
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
index f38ec21babf3..e9f4a2360465 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4672,18 +4672,17 @@ void check_move_unevictable_pages(struct pagevec *pvec)
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


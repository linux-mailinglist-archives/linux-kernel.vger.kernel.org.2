Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455273EC0B7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 07:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbhHNF1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 01:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237345AbhHNF1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 01:27:10 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD26C061757
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 22:26:43 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j1so18404938pjv.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 22:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F7om0JAa0251atdQthJaeQsHZPzAeTPpBSU7iFofJt8=;
        b=cpjKGrBcADQ43V3XCL+krFmngOlt6LDMzJ8yojIYlCDgPodVgLxGUqn57l4LwtfCAf
         tIKpZQ8voojunBk1mckjz65YDkE1V6gvVEjXq+IRHBYY8wGX/eMrCISR9NJGArx/luDf
         tnGwv5WxqxOJnCBqsgIFSUnQDAMmmy3Z+Mfruqqq2OIWON0EVhOWpTVrsb+s2QBGwWS+
         OKydRi58D3MLlPpqAodC9EvyJ06Bv3QMLeOu4ZCYfP1+Y4kMLGK/wgawxAcUa6ChGcqE
         fEeKNtpiZnDduu4Z7EcONhCj3OnUH1+WuLGGmuBlIePpr4hB8R0N8cVStnfme1a2ZkBw
         LjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F7om0JAa0251atdQthJaeQsHZPzAeTPpBSU7iFofJt8=;
        b=pX+ACQXOwQJn3q7oJtD9IyN588zot5sf68DQTMuYHuRjAWLeHxzCLwaEeq1/PfKK5E
         CrBtoiFFVCNcjOOcDXjhxljcCv1iEmRMrP55fCmEd5rmAIo9GyltaU04e5e+VejvV2lc
         zTNKlnrG+9N5hhPi7WaO0QWwCHHezWRs0AhTi5CnMm1hltV0n0tEZQ6b1FrIO6Rj1GP4
         wgRoOkywVB3mXJNKFkrZgpgg8y2o9eyX8ibhvNNlvVhDnLp8cb5ImDOS2vVoEhH+atL2
         yvdm9z9DMlAMb8848JltQiQ1Inm3SF+1LG1poSHVUTfzz3qUCc/4bMUwG6UKhQD+vlDf
         3cVQ==
X-Gm-Message-State: AOAM530N/2z9MdcFtv5QslRDpwt9f2+iGO33gl+wsZKywf/kuzZYjLTO
        QWGpEbjUO+vk2VN+mdUK6qG8+A==
X-Google-Smtp-Source: ABdhPJxtyMotRT3YcEMVp8oZNI/9l5Jq9kgUWY3mGX+e67YoWP7YJJfIybQYf6pC/184WHjV0eCAwA==
X-Received: by 2002:a62:1a03:0:b029:3e0:30aa:5172 with SMTP id a3-20020a621a030000b02903e030aa5172mr5737900pfa.69.1628918802677;
        Fri, 13 Aug 2021 22:26:42 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id s5sm4783133pgp.81.2021.08.13.22.26.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Aug 2021 22:26:42 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v1 12/12] mm: lru: use lruvec lock to serialize memcg changes
Date:   Sat, 14 Aug 2021 13:25:19 +0800
Message-Id: <20210814052519.86679-13-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210814052519.86679-1-songmuchun@bytedance.com>
References: <20210814052519.86679-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described by commit fc574c23558c ("mm/swap.c: serialize memcg
changes in pagevec_lru_move_fn"), TestClearPageLRU() aims to
serialize mem_cgroup_move_account() during pagevec_lru_move_fn().
Now folio_lruvec_lock*() has the ability to detect whether page
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
 mm/memcontrol.c | 31 +++++++++++++++++++++++++++++++
 mm/swap.c       | 45 ++++++++++++++-------------------------------
 mm/vmscan.c     |  9 ++++-----
 3 files changed, 49 insertions(+), 36 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9464e6d2d735..7732ccf7d180 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1286,12 +1286,38 @@ struct lruvec *folio_lruvec_lock(struct folio *folio)
 	lruvec = folio_lruvec(folio);
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
+	 * lruvec = folio_lruvec()
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
 	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
 		spin_unlock(&lruvec->lru_lock);
 		goto retry;
 	}
 
 	/*
+	 * When we reach here, it means that the folio_memcg(folio) is stable.
+	 *
 	 * Preemption is disabled in the internal of spin_lock, which can serve
 	 * as RCU read-side critical sections.
 	 */
@@ -1309,6 +1335,7 @@ struct lruvec *folio_lruvec_lock_irq(struct folio *folio)
 	lruvec = folio_lruvec(folio);
 	spin_lock_irq(&lruvec->lru_lock);
 
+	/* See the comments in folio_lruvec_lock(). */
 	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
 		spin_unlock_irq(&lruvec->lru_lock);
 		goto retry;
@@ -1330,6 +1357,7 @@ struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
 	lruvec = folio_lruvec(folio);
 	spin_lock_irqsave(&lruvec->lru_lock, *flags);
 
+	/* See the comments in folio_lruvec_lock(). */
 	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
 		spin_unlock_irqrestore(&lruvec->lru_lock, *flags);
 		goto retry;
@@ -5836,7 +5864,10 @@ static int mem_cgroup_move_account(struct page *page,
 	obj_cgroup_get(to->objcg);
 	obj_cgroup_put(from->objcg);
 
+	/* See the comments in folio_lruvec_lock(). */
+	spin_lock(&from_vec->lru_lock);
 	folio->memcg_data = (unsigned long)to->objcg;
+	spin_unlock(&from_vec->lru_lock);
 
 	__folio_memcg_unlock(from);
 
diff --git a/mm/swap.c b/mm/swap.c
index 9554ff008fe6..00b6776860e8 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -191,14 +191,8 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 		struct page *page = pvec->pages[i];
 		struct folio *folio = page_folio(page);
 
-		/* block memcg migration during page moving between lru */
-		if (!TestClearPageLRU(page))
-			continue;
-
 		lruvec = folio_lruvec_relock_irqsave(folio, lruvec, &flags);
 		(*move_fn)(page, lruvec);
-
-		SetPageLRU(page);
 	}
 	if (lruvec)
 		unlock_page_lruvec_irqrestore(lruvec, flags);
@@ -210,7 +204,7 @@ static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec)
 {
 	struct folio *folio = page_folio(page);
 
-	if (!folio_test_unevictable(folio)) {
+	if (folio_test_lru(folio) && !folio_test_unevictable(folio)) {
 		lruvec_del_folio(lruvec, folio);
 		folio_clear_active(folio);
 		lruvec_add_folio_tail(lruvec, folio);
@@ -305,7 +299,8 @@ void lru_note_cost_folio(struct folio *folio)
 
 static void __folio_activate(struct folio *folio, struct lruvec *lruvec)
 {
-	if (!folio_test_active(folio) && !folio_test_unevictable(folio)) {
+	if (folio_test_lru(folio) && !folio_test_active(folio) &&
+	    !folio_test_unevictable(folio)) {
 		long nr_pages = folio_nr_pages(folio);
 
 		lruvec_del_folio(lruvec, folio);
@@ -362,12 +357,9 @@ static void folio_activate(struct folio *folio)
 {
 	struct lruvec *lruvec;
 
-	if (folio_test_clear_lru(folio)) {
-		lruvec = folio_lruvec_lock_irq(folio);
-		__folio_activate(folio, lruvec);
-		unlock_page_lruvec_irq(lruvec);
-		folio_set_lru(folio);
-	}
+	lruvec = folio_lruvec_lock_irq(folio);
+	__folio_activate(folio, lruvec);
+	unlock_page_lruvec_irq(lruvec);
 }
 #endif
 
@@ -520,6 +512,9 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec)
 	bool active = PageActive(page);
 	int nr_pages = thp_nr_pages(page);
 
+	if (!PageLRU(page))
+		return;
+
 	if (PageUnevictable(page))
 		return;
 
@@ -557,7 +552,7 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec)
 
 static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec)
 {
-	if (PageActive(page) && !PageUnevictable(page)) {
+	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
 		int nr_pages = thp_nr_pages(page);
 
 		del_page_from_lru_list(page, lruvec);
@@ -573,7 +568,7 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec)
 
 static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec)
 {
-	if (PageAnon(page) && PageSwapBacked(page) &&
+	if (PageLRU(page) && PageAnon(page) && PageSwapBacked(page) &&
 	    !PageSwapCache(page) && !PageUnevictable(page)) {
 		int nr_pages = thp_nr_pages(page);
 
@@ -983,8 +978,9 @@ void __pagevec_release(struct pagevec *pvec)
 }
 EXPORT_SYMBOL(__pagevec_release);
 
-static void __pagevec_lru_add_fn(struct folio *folio, struct lruvec *lruvec)
+static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
 {
+	struct folio *folio = page_folio(page);
 	int was_unevictable = folio_test_clear_unevictable(folio);
 	long nr_pages = folio_nr_pages(folio);
 
@@ -1040,20 +1036,7 @@ static void __pagevec_lru_add_fn(struct folio *folio, struct lruvec *lruvec)
  */
 void __pagevec_lru_add(struct pagevec *pvec)
 {
-	int i;
-	struct lruvec *lruvec = NULL;
-	unsigned long flags = 0;
-
-	for (i = 0; i < pagevec_count(pvec); i++) {
-		struct folio *folio = page_folio(pvec->pages[i]);
-
-		lruvec = folio_lruvec_relock_irqsave(folio, lruvec, &flags);
-		__pagevec_lru_add_fn(folio, lruvec);
-	}
-	if (lruvec)
-		unlock_page_lruvec_irqrestore(lruvec, flags);
-	release_pages(pvec->pages, pvec->nr);
-	pagevec_reinit(pvec);
+	pagevec_lru_move_fn(pvec, __pagevec_lru_add_fn);
 }
 
 /**
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 902d36ec91a3..7cff2f748df8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4667,18 +4667,17 @@ void check_move_unevictable_pages(struct pagevec *pvec)
 		nr_pages = thp_nr_pages(page);
 		pgscanned += nr_pages;
 
-		/* block memcg migration during page moving between lru */
-		if (!TestClearPageLRU(page))
+		lruvec = folio_lruvec_relock_irq(folio, lruvec);
+
+		if (!PageLRU(page) || !PageUnevictable(page))
 			continue;
 
-		lruvec = folio_lruvec_relock_irq(folio, lruvec);
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


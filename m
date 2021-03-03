Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEA632BAD6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350176AbhCCMFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1451342AbhCCGCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 01:02:44 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AD3C06178A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 22:02:04 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id ba1so13453034plb.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 22:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q5+aGjYHaG6LkZOIPA7CkmGtW7XLwWM/a6l8CvJ2fGk=;
        b=X8+tXZI0Wsn/l4Jj18Z4z0iyPKupM3Bm0aPndcer52lJMonJnnlt48a0SGVHncNBwK
         V1fKBk7VgHyqvwFSNVyG802EMDi1J6g3B1e7s+IF0Tc1cpPXZNBafsl3AjwCWM5HYx50
         nOPlQJELWtGK4sazM2xNX2c9xIvojyeFtHDNatS/iXdWQGcsucr/Kfg+6eM8TSLVZn1I
         FVh0yBq0S9pgpqi2OSn1N+pGfRqGbqfTEwUAIZ5PcD+7f8cs4zCHqTdnGbAKYsp0sNGQ
         8bTueIfyu7FiLaKO8yzKG8Ude01G67N1H6YTsBNix9iG+qsB0kRYILGQJLMvuCydILJR
         9A3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q5+aGjYHaG6LkZOIPA7CkmGtW7XLwWM/a6l8CvJ2fGk=;
        b=CBkjprGsPoAquE215tfqfVdJrD9aVrqSLwOdfEMvaKu9jyupQ59pq7IMhOGp1zfsxh
         lGsOidWd/JbmEfThIDV+lU6+sy0thgk7sctU32NCA7A2s7BoUBbfzSez7J2yj8CgB67k
         MjlP/e0drjn9ht8I/M4CcHnD8qdke2aXMj0u05vwsZNutEO74ovr41SwHJpoRAcTDiYF
         gQxEou78dC5OZUU9Vm4QX9Sw4XWlXTLoDKC2yGwFl8RF+DXl8aZqGlp0ypwhvIAAXGXE
         mdsKlEiEwYVtwpaLPHKPwdLGHXgxp5ehVAnF1EUpYqf3xaWWo8yeh0TOqpO+GIyA4GTN
         /Y8Q==
X-Gm-Message-State: AOAM531qhXnHZL7Z2x0YJ5kvyEidblMqdmKU9wlBpFoNQ75EuFX1CddZ
        RKMxIEpIlfkhqZyrCO6BNhFsww==
X-Google-Smtp-Source: ABdhPJxz6DLT8GeVYZKMFyoN4BXAy4FjrRYUOZDBGXYJ6tVrV5NnVfsvpH0drfhnrwuCFuolXkOwzQ==
X-Received: by 2002:a17:902:dacb:b029:e5:b538:9ce6 with SMTP id q11-20020a170902dacbb02900e5b5389ce6mr6291099plx.8.1614751323966;
        Tue, 02 Mar 2021 22:02:03 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id x11sm6131088pjh.0.2021.03.02.22.02.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Mar 2021 22:02:03 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 2/5] mm: memcontrol: make page_memcg{_rcu} only applicable for non-kmem page
Date:   Wed,  3 Mar 2021 13:59:14 +0800
Message-Id: <20210303055917.66054-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210303055917.66054-1-songmuchun@bytedance.com>
References: <20210303055917.66054-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to reuse the obj_cgroup APIs to charge the kmem pages when
If we do that, we should store an object cgroup pointer to
page->memcg_data for the kmem pages.

Finally, page->memcg_data can have 3 different meanings.

  1) For the slab pages, page->memcg_data points to an object cgroups
     vector.

  2) For the kmem pages (exclude the slab pages), page->memcg_data
     points to an object cgroup.

  3) For the user pages (e.g. the LRU pages), page->memcg_data points
     to a memory cgroup.

Currently we always get the memory cgroup associated with a page via
page_memcg() or page_memcg_rcu(). page_memcg_check() is special, it
has to be used in cases when it's not known if a page has an
associated memory cgroup pointer or an object cgroups vector. Because
the page->memcg_data of the kmem page is not pointing to a memory
cgroup in the later patch, the page_memcg() and page_memcg_rcu()
cannot be applicable for the kmem pages. In this patch, make
page_memcg() and page_memcg_rcu() no longer apply to the kmem pages.
We do not change the behavior of the page_memcg_check(), it is also
applicable for the kmem pages.

In the end, there are 3 helpers to get the memcg associated with a page.
Usage is as follows.

  1) Get the memory cgroup associated with a non-kmem page (e.g. the LRU
     pages).

     - page_memcg()
     - page_memcg_rcu()

  2) Get the memory cgroup associated with a page. It has to be used in
     cases when it's not known if a page has an associated memory cgroup
     pointer or an object cgroups vector. Returns NULL for slab pages or
     uncharged pages. Otherwise, returns memory cgroup for charged pages
     (e.g. the kmem pages, the LRU pages).

     - page_memcg_check()

In some place, we use page_memcg() to check whether the page is charged.
Now introduce page_memcg_charged() helper to do that.

This is a preparation for reparenting the kmem pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h | 36 ++++++++++++++++++++++++++++--------
 mm/memcontrol.c            | 23 +++++++++++++----------
 mm/page_alloc.c            |  4 ++--
 3 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e6dc793d587d..049b80246cbf 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -358,14 +358,26 @@ enum page_memcg_data_flags {
 
 #define MEMCG_DATA_FLAGS_MASK (__NR_MEMCG_DATA_FLAGS - 1)
 
+/* Return true for charged page, otherwise false. */
+static inline bool page_memcg_charged(struct page *page)
+{
+	unsigned long memcg_data = page->memcg_data;
+
+	VM_BUG_ON_PAGE(PageSlab(page), page);
+	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
+
+	return !!memcg_data;
+}
+
 /*
- * page_memcg - get the memory cgroup associated with a page
+ * page_memcg - get the memory cgroup associated with a non-kmem page
  * @page: a pointer to the page struct
  *
  * Returns a pointer to the memory cgroup associated with the page,
  * or NULL. This function assumes that the page is known to have a
  * proper memory cgroup pointer. It's not safe to call this function
- * against some type of pages, e.g. slab pages or ex-slab pages.
+ * against some type of pages, e.g. slab pages, kmem pages or ex-slab
+ * pages.
  *
  * Any of the following ensures page and memcg binding stability:
  * - the page lock
@@ -378,27 +390,30 @@ static inline struct mem_cgroup *page_memcg(struct page *page)
 	unsigned long memcg_data = page->memcg_data;
 
 	VM_BUG_ON_PAGE(PageSlab(page), page);
-	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
+	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_FLAGS_MASK, page);
 
-	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+	return (struct mem_cgroup *)memcg_data;
 }
 
 /*
- * page_memcg_rcu - locklessly get the memory cgroup associated with a page
+ * page_memcg_rcu - locklessly get the memory cgroup associated with a non-kmem page
  * @page: a pointer to the page struct
  *
  * Returns a pointer to the memory cgroup associated with the page,
  * or NULL. This function assumes that the page is known to have a
  * proper memory cgroup pointer. It's not safe to call this function
- * against some type of pages, e.g. slab pages or ex-slab pages.
+ * against some type of pages, e.g. slab pages, kmem pages or ex-slab
+ * pages.
  */
 static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
 {
+	unsigned long memcg_data = READ_ONCE(page->memcg_data);
+
 	VM_BUG_ON_PAGE(PageSlab(page), page);
+	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_FLAGS_MASK, page);
 	WARN_ON_ONCE(!rcu_read_lock_held());
 
-	return (struct mem_cgroup *)(READ_ONCE(page->memcg_data) &
-				     ~MEMCG_DATA_FLAGS_MASK);
+	return (struct mem_cgroup *)memcg_data;
 }
 
 /*
@@ -1072,6 +1087,11 @@ void mem_cgroup_split_huge_fixup(struct page *head);
 
 struct mem_cgroup;
 
+static inline bool page_memcg_charged(struct page *page)
+{
+	return false;
+}
+
 static inline struct mem_cgroup *page_memcg(struct page *page)
 {
 	return NULL;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index faae16def127..86a8db937ec6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -855,10 +855,11 @@ void __mod_lruvec_page_state(struct page *page, enum node_stat_item idx,
 			     int val)
 {
 	struct page *head = compound_head(page); /* rmap on tail pages */
-	struct mem_cgroup *memcg = page_memcg(head);
+	struct mem_cgroup *memcg;
 	pg_data_t *pgdat = page_pgdat(page);
 	struct lruvec *lruvec;
 
+	memcg = page_memcg_check(head);
 	/* Untracked pages have no memcg, no lruvec. Update only the node */
 	if (!memcg) {
 		__mod_node_page_state(pgdat, idx, val);
@@ -3166,12 +3167,13 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
  */
 void __memcg_kmem_uncharge_page(struct page *page, int order)
 {
-	struct mem_cgroup *memcg = page_memcg(page);
+	struct mem_cgroup *memcg;
 	unsigned int nr_pages = 1 << order;
 
-	if (!memcg)
+	if (!page_memcg_charged(page))
 		return;
 
+	memcg = page_memcg_check(page);
 	VM_BUG_ON_PAGE(mem_cgroup_is_root(memcg), page);
 	__memcg_kmem_uncharge(memcg, nr_pages);
 	page->memcg_data = 0;
@@ -6827,24 +6829,25 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 {
 	unsigned long nr_pages;
+	struct mem_cgroup *memcg;
 
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 
-	if (!page_memcg(page))
+	if (!page_memcg_charged(page))
 		return;
 
 	/*
 	 * Nobody should be changing or seriously looking at
-	 * page_memcg(page) at this point, we have fully
-	 * exclusive access to the page.
+	 * page memcg at this point, we have fully exclusive
+	 * access to the page.
 	 */
-
-	if (ug->memcg != page_memcg(page)) {
+	memcg = page_memcg_check(page);
+	if (ug->memcg != memcg) {
 		if (ug->memcg) {
 			uncharge_batch(ug);
 			uncharge_gather_clear(ug);
 		}
-		ug->memcg = page_memcg(page);
+		ug->memcg = memcg;
 
 		/* pairs with css_put in uncharge_batch */
 		css_get(&ug->memcg->css);
@@ -6877,7 +6880,7 @@ void mem_cgroup_uncharge(struct page *page)
 		return;
 
 	/* Don't touch page->lru of any random page, pre-check: */
-	if (!page_memcg(page))
+	if (!page_memcg_charged(page))
 		return;
 
 	uncharge_gather_clear(&ug);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f10966e3b4a5..bcb58ae15e24 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1124,7 +1124,7 @@ static inline bool page_expected_state(struct page *page,
 	if (unlikely((unsigned long)page->mapping |
 			page_ref_count(page) |
 #ifdef CONFIG_MEMCG
-			(unsigned long)page_memcg(page) |
+			page_memcg_charged(page) |
 #endif
 			(page->flags & check_flags)))
 		return false;
@@ -1149,7 +1149,7 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
 			bad_reason = "PAGE_FLAGS_CHECK_AT_FREE flag(s) set";
 	}
 #ifdef CONFIG_MEMCG
-	if (unlikely(page_memcg(page)))
+	if (unlikely(page_memcg_charged(page)))
 		bad_reason = "page still charged to cgroup";
 #endif
 	return bad_reason;
-- 
2.11.0


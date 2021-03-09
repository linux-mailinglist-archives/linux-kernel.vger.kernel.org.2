Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACD233229E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 11:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhCIKJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 05:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhCIKJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 05:09:07 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE05C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 02:09:07 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 16so2011699pgo.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 02:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5/zxOOlFck4GlBFK2+ckmxR9mJWNjZboWgW6z95uHA0=;
        b=Ry1qrRc+5lI1iGnqqWVM4o17Gn43+ZLX4Fjh/ZhiXcHTUhGi2F8ZTOgb9Sd+veN5a5
         L2OWCkrr0L1E8ufr1WICKVuju21XlWWG2a9vqYSdH8unRX2h6JYDR8RbcuovmMkWng4N
         PRRbTCYooxzYrVJ3YmFpAXrIEdBC7SLhlbKaxUTtabygFdRPE1CjhCKvU8VAO+a5JyAg
         mxG4PlbHrhfhyXBvh5JOqFVBvsgCibil77LD09iPtq83BrI4HPNWTzMggFd0hgyAYxgA
         dOquiJ+yiFcZI5nDV/xrwvbjPJ3En7Oh7I2ANROqFF4BBF/kaOeKMHQ6IBmzIRgwWIQr
         uTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5/zxOOlFck4GlBFK2+ckmxR9mJWNjZboWgW6z95uHA0=;
        b=R2uBSQCo1/I6UK0p3Ny7u7fIosNspPcj/8fkdD+HHtVrMhCOynAZra4YFB/ed0HtxJ
         MCTE2red9LCksb8HzJpKU6jOS4A+09NnugI9Mja67BGqT+VUO0mlqBy5OuIIW+eMsvCT
         abzcalW06VRznaov2epZ2clOKgNRD1ZsCOdq9Y2NKGXO1Wqfc5dY5bPgmv6NT3la98wi
         +vrbjjqocU6BeT4OW4VYBHaWZBe89ZC5L9Y0mux+AP/Q15T9G8ViQD1Dd+oyiZBM7ONk
         5AKRq+pvxVaDWZ5b75011rYuWwHAxXMe3afT5Fr4rlPO71qZiHAn1C9IWH5ijBH522Go
         cWfw==
X-Gm-Message-State: AOAM532RoRqIlp5o571e5NH+KBY4y+dsgvuHcI5l2pMhOlp7UzI8fy29
        zgRc9S3iYvFPUuLMKaxmEb8eWw==
X-Google-Smtp-Source: ABdhPJwZ6+mzvwKJVap7GfMIaRdnbYNCKvspqSspeZGIQo0L9r5nG6rhOHbzHqOBBynBPD6y/NczBg==
X-Received: by 2002:a62:5a43:0:b029:1ed:263a:b05c with SMTP id o64-20020a625a430000b02901ed263ab05cmr24839949pfb.16.1615284547311;
        Tue, 09 Mar 2021 02:09:07 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id a70sm9258424pfa.202.2021.03.09.02.09.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Mar 2021 02:09:06 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 3/4] mm: memcontrol: use obj_cgroup APIs to charge kmem pages
Date:   Tue,  9 Mar 2021 18:07:16 +0800
Message-Id: <20210309100717.253-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210309100717.253-1-songmuchun@bytedance.com>
References: <20210309100717.253-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Roman series "The new cgroup slab memory controller" applied. All
slab objects are charged via the new APIs of obj_cgroup. The new APIs
introduce a struct obj_cgroup to charge slab objects. It prevents
long-living objects from pinning the original memory cgroup in the memory.
But there are still some corner objects (e.g. allocations larger than
order-1 page on SLUB) which are not charged via the new APIs. Those
objects (include the pages which are allocated from buddy allocator
directly) are charged as kmem pages which still hold a reference to
the memory cgroup.

This patch aims to charge the kmem pages by using the new APIs of
obj_cgroup. Finally, the page->memcg_data of the kmem page points to
an object cgroup. We can use the page_objcg() to get the object
cgroup associated with a kmem page. Or we can use page_memcg_check()
to get the memory cgroup associated with a kmem page, but caller must
ensure that the returned memcg won't be released (e.g. acquire the
rcu_read_lock or css_set_lock).

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h |  63 ++++++++++++++++++------
 mm/memcontrol.c            | 119 ++++++++++++++++++++++++++++++---------------
 2 files changed, 128 insertions(+), 54 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 83cbcdcfcc92..07c449af9c0f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -370,6 +370,18 @@ static inline bool page_memcg_charged(struct page *page)
 }
 
 /*
+ * After the initialization objcg->memcg is always pointing at
+ * a valid memcg, but can be atomically swapped to the parent memcg.
+ *
+ * The caller must ensure that the returned memcg won't be released:
+ * e.g. acquire the rcu_read_lock or css_set_lock.
+ */
+static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg)
+{
+	return READ_ONCE(objcg->memcg);
+}
+
+/*
  * page_memcg - get the memory cgroup associated with a non-kmem page
  * @page: a pointer to the page struct
  *
@@ -422,15 +434,19 @@ static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
  * @page: a pointer to the page struct
  *
  * Returns a pointer to the memory cgroup associated with the page,
- * or NULL. This function unlike page_memcg() can take any  page
+ * or NULL. This function unlike page_memcg() can take any page
  * as an argument. It has to be used in cases when it's not known if a page
- * has an associated memory cgroup pointer or an object cgroups vector.
+ * has an associated memory cgroup pointer or an object cgroups vector or
+ * an object cgroup.
  *
  * Any of the following ensures page and memcg binding stability:
  * - the page lock
  * - LRU isolation
  * - lock_page_memcg()
  * - exclusive reference
+ *
+ * Should be called under rcu lock which can protect memcg associated with a
+ * kmem page from being released.
  */
 static inline struct mem_cgroup *page_memcg_check(struct page *page)
 {
@@ -443,6 +459,13 @@ static inline struct mem_cgroup *page_memcg_check(struct page *page)
 	if (memcg_data & MEMCG_DATA_OBJCGS)
 		return NULL;
 
+	if (memcg_data & MEMCG_DATA_KMEM) {
+		struct obj_cgroup *objcg;
+
+		objcg = (void *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+		return obj_cgroup_memcg(objcg);
+	}
+
 	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 }
 
@@ -501,6 +524,25 @@ static inline struct obj_cgroup **page_objcgs_check(struct page *page)
 	return (struct obj_cgroup **)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 }
 
+/*
+ * page_objcg - get the object cgroup associated with a kmem page
+ * @page: a pointer to the page struct
+ *
+ * Returns a pointer to the object cgroup associated with the kmem page,
+ * or NULL. This function assumes that the page is known to have an
+ * associated object cgroup. It's only safe to call this function
+ * against kmem pages (PageMemcgKmem() returns true).
+ */
+static inline struct obj_cgroup *page_objcg(struct page *page)
+{
+	unsigned long memcg_data = page->memcg_data;
+
+	VM_BUG_ON_PAGE(PageSlab(page), page);
+	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
+	VM_BUG_ON_PAGE(!(memcg_data & MEMCG_DATA_KMEM), page);
+
+	return (struct obj_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+}
 #else
 static inline struct obj_cgroup **page_objcgs(struct page *page)
 {
@@ -511,6 +553,11 @@ static inline struct obj_cgroup **page_objcgs_check(struct page *page)
 {
 	return NULL;
 }
+
+static inline struct obj_cgroup *page_objcg(struct page *page)
+{
+	return NULL;
+}
 #endif
 
 static __always_inline bool memcg_stat_item_in_bytes(int idx)
@@ -729,18 +776,6 @@ static inline void obj_cgroup_put(struct obj_cgroup *objcg)
 	percpu_ref_put(&objcg->refcnt);
 }
 
-/*
- * After the initialization objcg->memcg is always pointing at
- * a valid memcg, but can be atomically swapped to the parent memcg.
- *
- * The caller must ensure that the returned memcg won't be released:
- * e.g. acquire the rcu_read_lock or css_set_lock.
- */
-static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg)
-{
-	return READ_ONCE(objcg->memcg);
-}
-
 static inline void mem_cgroup_put(struct mem_cgroup *memcg)
 {
 	if (memcg)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e1dc73ceb98a..38376f9d6659 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -859,15 +859,26 @@ void __mod_lruvec_page_state(struct page *page, enum node_stat_item idx,
 	pg_data_t *pgdat = page_pgdat(page);
 	struct lruvec *lruvec;
 
-	memcg = page_memcg_check(head);
-	/* Untracked pages have no memcg, no lruvec. Update only the node */
-	if (!memcg) {
-		__mod_node_page_state(pgdat, idx, val);
-		return;
+	if (PageMemcgKmem(head)) {
+		rcu_read_lock();
+		memcg = obj_cgroup_memcg(page_objcg(page));
+	} else {
+		memcg = page_memcg(head);
+		/*
+		 * Untracked pages have no memcg, no lruvec. Update only the
+		 * node.
+		 */
+		if (!memcg) {
+			__mod_node_page_state(pgdat, idx, val);
+			return;
+		}
 	}
 
 	lruvec = mem_cgroup_lruvec(memcg, pgdat);
 	__mod_lruvec_state(lruvec, idx, val);
+
+	if (PageMemcgKmem(head))
+		rcu_read_unlock();
 }
 EXPORT_SYMBOL(__mod_lruvec_page_state);
 
@@ -2906,6 +2917,20 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg)
 	page->memcg_data = (unsigned long)memcg;
 }
 
+static inline struct mem_cgroup *obj_cgroup_memcg_get(struct obj_cgroup *objcg)
+{
+	struct mem_cgroup *memcg;
+
+	rcu_read_lock();
+retry:
+	memcg = obj_cgroup_memcg(objcg);
+	if (unlikely(!css_tryget(&memcg->css)))
+		goto retry;
+	rcu_read_unlock();
+
+	return memcg;
+}
+
 #ifdef CONFIG_MEMCG_KMEM
 int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
 				 gfp_t gfp, bool new_page)
@@ -3071,15 +3096,8 @@ static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
 	struct mem_cgroup *memcg;
 	int ret;
 
-	rcu_read_lock();
-retry:
-	memcg = obj_cgroup_memcg(objcg);
-	if (unlikely(!css_tryget(&memcg->css)))
-		goto retry;
-	rcu_read_unlock();
-
+	memcg = obj_cgroup_memcg_get(objcg);
 	ret = __memcg_kmem_charge(memcg, gfp, nr_pages);
-
 	css_put(&memcg->css);
 
 	return ret;
@@ -3144,18 +3162,18 @@ static void __memcg_kmem_uncharge(struct mem_cgroup *memcg, unsigned int nr_page
  */
 int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
 {
-	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
 	int ret = 0;
 
-	memcg = get_mem_cgroup_from_current();
-	if (memcg && !mem_cgroup_is_root(memcg)) {
-		ret = __memcg_kmem_charge(memcg, gfp, 1 << order);
+	objcg = get_obj_cgroup_from_current();
+	if (objcg) {
+		ret = obj_cgroup_charge_pages(objcg, gfp, 1 << order);
 		if (!ret) {
-			page->memcg_data = (unsigned long)memcg |
+			page->memcg_data = (unsigned long)objcg |
 				MEMCG_DATA_KMEM;
 			return 0;
 		}
-		css_put(&memcg->css);
+		obj_cgroup_put(objcg);
 	}
 	return ret;
 }
@@ -3167,17 +3185,16 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
  */
 void __memcg_kmem_uncharge_page(struct page *page, int order)
 {
-	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
 	unsigned int nr_pages = 1 << order;
 
 	if (!page_memcg_charged(page))
 		return;
 
-	memcg = page_memcg_check(page);
-	VM_BUG_ON_PAGE(mem_cgroup_is_root(memcg), page);
-	__memcg_kmem_uncharge(memcg, nr_pages);
+	objcg = page_objcg(page);
+	obj_cgroup_uncharge_pages(objcg, nr_pages);
 	page->memcg_data = 0;
-	css_put(&memcg->css);
+	obj_cgroup_put(objcg);
 }
 
 static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
@@ -6806,11 +6823,23 @@ static inline void uncharge_gather_clear(struct uncharge_gather *ug)
 static void uncharge_batch(const struct uncharge_gather *ug)
 {
 	unsigned long flags;
+	unsigned long nr_pages;
 
-	if (!mem_cgroup_is_root(ug->memcg)) {
-		page_counter_uncharge(&ug->memcg->memory, ug->nr_pages);
+	/*
+	 * The kmem pages can be reparented to the root memcg, in
+	 * order to prevent the memory counter of root memcg from
+	 * increasing indefinitely. We should decrease the memory
+	 * counter when unchange.
+	 */
+	if (mem_cgroup_is_root(ug->memcg))
+		nr_pages = ug->nr_kmem;
+	else
+		nr_pages = ug->nr_pages;
+
+	if (nr_pages) {
+		page_counter_uncharge(&ug->memcg->memory, nr_pages);
 		if (do_memsw_account())
-			page_counter_uncharge(&ug->memcg->memsw, ug->nr_pages);
+			page_counter_uncharge(&ug->memcg->memsw, nr_pages);
 		if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && ug->nr_kmem)
 			page_counter_uncharge(&ug->memcg->kmem, ug->nr_kmem);
 		memcg_oom_recover(ug->memcg);
@@ -6828,7 +6857,7 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 
 static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 {
-	unsigned long nr_pages;
+	unsigned long nr_pages, nr_kmem;
 	struct mem_cgroup *memcg;
 
 	VM_BUG_ON_PAGE(PageLRU(page), page);
@@ -6836,34 +6865,44 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 	if (!page_memcg_charged(page))
 		return;
 
+	nr_pages = compound_nr(page);
 	/*
 	 * Nobody should be changing or seriously looking at
-	 * page memcg at this point, we have fully exclusive
-	 * access to the page.
+	 * page memcg or objcg at this point, we have fully
+	 * exclusive access to the page.
 	 */
-	memcg = page_memcg_check(page);
+	if (PageMemcgKmem(page)) {
+		struct obj_cgroup *objcg;
+
+		objcg = page_objcg(page);
+		memcg = obj_cgroup_memcg_get(objcg);
+
+		page->memcg_data = 0;
+		obj_cgroup_put(objcg);
+		nr_kmem = nr_pages;
+	} else {
+		memcg = page_memcg(page);
+		page->memcg_data = 0;
+		nr_kmem = 0;
+	}
+
 	if (ug->memcg != memcg) {
 		if (ug->memcg) {
 			uncharge_batch(ug);
 			uncharge_gather_clear(ug);
 		}
 		ug->memcg = memcg;
+		ug->dummy_page = page;
 
 		/* pairs with css_put in uncharge_batch */
 		css_get(&ug->memcg->css);
 	}
 
-	nr_pages = compound_nr(page);
 	ug->nr_pages += nr_pages;
+	ug->nr_kmem += nr_kmem;
+	ug->pgpgout += !nr_kmem;
 
-	if (PageMemcgKmem(page))
-		ug->nr_kmem += nr_pages;
-	else
-		ug->pgpgout++;
-
-	ug->dummy_page = page;
-	page->memcg_data = 0;
-	css_put(&ug->memcg->css);
+	css_put(&memcg->css);
 }
 
 /**
-- 
2.11.0


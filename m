Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4AA734043B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 12:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhCRLJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 07:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhCRLIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:08:45 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B29C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 04:08:44 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so4833559pjc.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 04:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=08vyzPUPKvmLNfOadbgAGNQdLOXmbl0LbP58+XW4jVM=;
        b=lJOHSBb8un9AZY5DlX2KQY+f+BrK1KheoJjVbMIQI1taLuqBgAAC79D4bDNNekaNkK
         5dOVtF4X/SgaPxsHRsKwNLC/F+0e6f75k1vwrNkP1aGpDmht/TN7JOIohR12MWxmSGOj
         QRCaI7Wa2X3D2QDtIVMvZkTXozhzTMRZe53uC24myEYqtEUVtiWACelEl3gdAudZNn3D
         g1Sd2TtPBtTamsEnjoCCHmCNA516e9wbQbcoIEbsGDxBhH2MbEvSYAeOAunWyjcOnos0
         2WOtdXDde3C9EtwOwYlz00cNxxUf5JyOSCk9/hPmZjccOuM77a17Wyw4uL5nTVyi49z/
         M1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=08vyzPUPKvmLNfOadbgAGNQdLOXmbl0LbP58+XW4jVM=;
        b=R0Xcc76UyBhnAQfSSKduB2xfsYm2SxH9y4WpVxNoRWwxqXxEJeOOkb8MgRFMPAAuc3
         +FJ9QHiE1SEhfq5SP9YmY4fbKLNILFnJ/iw+lL5NgbWklnFR6vahIFe+60j3q0nEkhm6
         NlGPX7MdW0CqQQVWZEvLNcOF4ftSUV5wuwh2zX5i5haNd3bvlPmmK++L/E+JULsxE/G5
         Q/y/RiAlLKRl8RzyocOsI/R+py/y7cjswdS/6zZ0J1UaXvRkNvn0BPhYMp76i2ZPq4AO
         GjAST8+v7md2+lJkgi3fqyBekRvCdDOBs5plVIFPhoAEWorc3AUrkttlYSpRRNMAd5eg
         NVWQ==
X-Gm-Message-State: AOAM5335FJ3/nDZWLJ2jgyU9M7Udk344yYBDHs6SSrBe6OtQeKXbU9u+
        +84lw7nKr2HvzOf6D+7ymHCYwQ==
X-Google-Smtp-Source: ABdhPJz66Q481dL8WfSeW2L0N6YQirVOEzoQXHkK0DamES8JlQLHZuohYoFAPOn8UCn26YHqpE897g==
X-Received: by 2002:a17:902:ea0e:b029:e4:81d4:ddae with SMTP id s14-20020a170902ea0eb02900e481d4ddaemr9248123plg.12.1616065724143;
        Thu, 18 Mar 2021 04:08:44 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id e21sm1779509pgv.74.2021.03.18.04.08.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Mar 2021 04:08:43 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 4/5] mm: memcontrol: use obj_cgroup APIs to charge kmem pages
Date:   Thu, 18 Mar 2021 19:06:57 +0800
Message-Id: <20210318110658.60892-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210318110658.60892-1-songmuchun@bytedance.com>
References: <20210318110658.60892-1-songmuchun@bytedance.com>
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

We want to reuse the obj_cgroup APIs to charge the kmem pages.
If we do that, we should store an object cgroup pointer to
page->memcg_data for the kmem pages.

Finally, page->memcg_data will have 3 different meanings.

  1) For the slab pages, page->memcg_data points to an object cgroups
     vector.

  2) For the kmem pages (exclude the slab pages), page->memcg_data
     points to an object cgroup.

  3) For the user pages (e.g. the LRU pages), page->memcg_data points
     to a memory cgroup.

We do not change the behavior of page_memcg() and page_memcg_rcu().
They are also suitable for LRU pages and kmem pages. Why?

Because memory allocations pinning memcgs for a long time - it exists
at a larger scale and is causing recurring problems in the real world:
page cache doesn't get reclaimed for a long time, or is used by the
second, third, fourth, ... instance of the same job that was restarted
into a new cgroup every time. Unreclaimable dying cgroups pile up,
waste memory, and make page reclaim very inefficient.

We can convert LRU pages and most other raw memcg pins to the objcg
direction to fix this problem, and then the page->memcg will always
point to an object cgroup pointer. At that time, LRU pages and kmem
pages will be treated the same. The implementation of page_memcg()
will remove the kmem page check.

This patch aims to charge the kmem pages by using the new APIs of
obj_cgroup. Finally, the page->memcg_data of the kmem page points to
an object cgroup. We can use the __page_objcg() to get the object
cgroup associated with a kmem page. Or we can use page_memcg()
to get the memory cgroup associated with a kmem page, but caller must
ensure that the returned memcg won't be released (e.g. acquire the
rcu_read_lock or css_set_lock).

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h | 116 +++++++++++++++++++++++++++++++++++----------
 mm/memcontrol.c            | 101 ++++++++++++++++++++++++---------------
 2 files changed, 156 insertions(+), 61 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e6dc793d587d..395a113e4a3b 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -358,6 +358,62 @@ enum page_memcg_data_flags {
 
 #define MEMCG_DATA_FLAGS_MASK (__NR_MEMCG_DATA_FLAGS - 1)
 
+static inline bool PageMemcgKmem(struct page *page);
+
+/*
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
+ * __page_memcg - get the memory cgroup associated with a non-kmem page
+ * @page: a pointer to the page struct
+ *
+ * Returns a pointer to the memory cgroup associated with the page,
+ * or NULL. This function assumes that the page is known to have a
+ * proper memory cgroup pointer. It's not safe to call this function
+ * against some type of pages, e.g. slab pages or ex-slab pages or
+ * kmem pages.
+ */
+static inline struct mem_cgroup *__page_memcg(struct page *page)
+{
+	unsigned long memcg_data = page->memcg_data;
+
+	VM_BUG_ON_PAGE(PageSlab(page), page);
+	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
+	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_KMEM, page);
+
+	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+}
+
+/*
+ * __page_objcg - get the object cgroup associated with a kmem page
+ * @page: a pointer to the page struct
+ *
+ * Returns a pointer to the object cgroup associated with the page,
+ * or NULL. This function assumes that the page is known to have a
+ * proper object cgroup pointer. It's not safe to call this function
+ * against some type of pages, e.g. slab pages or ex-slab pages or
+ * LRU pages.
+ */
+static inline struct obj_cgroup *__page_objcg(struct page *page)
+{
+	unsigned long memcg_data = page->memcg_data;
+
+	VM_BUG_ON_PAGE(PageSlab(page), page);
+	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
+	VM_BUG_ON_PAGE(!(memcg_data & MEMCG_DATA_KMEM), page);
+
+	return (struct obj_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+}
+
 /*
  * page_memcg - get the memory cgroup associated with a page
  * @page: a pointer to the page struct
@@ -367,20 +423,23 @@ enum page_memcg_data_flags {
  * proper memory cgroup pointer. It's not safe to call this function
  * against some type of pages, e.g. slab pages or ex-slab pages.
  *
- * Any of the following ensures page and memcg binding stability:
+ * For a non-kmem page any of the following ensures page and memcg binding
+ * stability:
+ *
  * - the page lock
  * - LRU isolation
  * - lock_page_memcg()
  * - exclusive reference
+ *
+ * For a kmem page a caller should hold an rcu read lock to protect memcg
+ * associated with a kmem page from being released.
  */
 static inline struct mem_cgroup *page_memcg(struct page *page)
 {
-	unsigned long memcg_data = page->memcg_data;
-
-	VM_BUG_ON_PAGE(PageSlab(page), page);
-	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
-
-	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+	if (PageMemcgKmem(page))
+		return obj_cgroup_memcg(__page_objcg(page));
+	else
+		return __page_memcg(page);
 }
 
 /*
@@ -394,11 +453,19 @@ static inline struct mem_cgroup *page_memcg(struct page *page)
  */
 static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
 {
+	unsigned long memcg_data = READ_ONCE(page->memcg_data);
+
 	VM_BUG_ON_PAGE(PageSlab(page), page);
 	WARN_ON_ONCE(!rcu_read_lock_held());
 
-	return (struct mem_cgroup *)(READ_ONCE(page->memcg_data) &
-				     ~MEMCG_DATA_FLAGS_MASK);
+	if (memcg_data & MEMCG_DATA_KMEM) {
+		struct obj_cgroup *objcg;
+
+		objcg = (void *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+		return obj_cgroup_memcg(objcg);
+	}
+
+	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 }
 
 /*
@@ -406,15 +473,21 @@ static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
  * @page: a pointer to the page struct
  *
  * Returns a pointer to the memory cgroup associated with the page,
- * or NULL. This function unlike page_memcg() can take any  page
+ * or NULL. This function unlike page_memcg() can take any page
  * as an argument. It has to be used in cases when it's not known if a page
- * has an associated memory cgroup pointer or an object cgroups vector.
+ * has an associated memory cgroup pointer or an object cgroups vector or
+ * an object cgroup.
+ *
+ * For a non-kmem page any of the following ensures page and memcg binding
+ * stability:
  *
- * Any of the following ensures page and memcg binding stability:
  * - the page lock
  * - LRU isolation
  * - lock_page_memcg()
  * - exclusive reference
+ *
+ * For a kmem page a caller should hold an rcu read lock to protect memcg
+ * associated with a kmem page from being released.
  */
 static inline struct mem_cgroup *page_memcg_check(struct page *page)
 {
@@ -427,6 +500,13 @@ static inline struct mem_cgroup *page_memcg_check(struct page *page)
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
 
@@ -713,18 +793,6 @@ static inline void obj_cgroup_put(struct obj_cgroup *objcg)
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
index 104bddf21314..1cef20a2f116 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -855,18 +855,22 @@ void __mod_lruvec_page_state(struct page *page, enum node_stat_item idx,
 			     int val)
 {
 	struct page *head = compound_head(page); /* rmap on tail pages */
-	struct mem_cgroup *memcg = page_memcg(head);
+	struct mem_cgroup *memcg;
 	pg_data_t *pgdat = page_pgdat(page);
 	struct lruvec *lruvec;
 
+	rcu_read_lock();
+	memcg = page_memcg(head);
 	/* Untracked pages have no memcg, no lruvec. Update only the node */
 	if (!memcg) {
+		rcu_read_unlock();
 		__mod_node_page_state(pgdat, idx, val);
 		return;
 	}
 
 	lruvec = mem_cgroup_lruvec(memcg, pgdat);
 	__mod_lruvec_state(lruvec, idx, val);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(__mod_lruvec_page_state);
 
@@ -2905,6 +2909,20 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg)
 	page->memcg_data = (unsigned long)memcg;
 }
 
+static inline struct mem_cgroup *get_obj_cgroup_memcg(struct obj_cgroup *objcg)
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
@@ -3070,15 +3088,8 @@ static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
 	struct mem_cgroup *memcg;
 	int ret;
 
-	rcu_read_lock();
-retry:
-	memcg = obj_cgroup_memcg(objcg);
-	if (unlikely(!css_tryget(&memcg->css)))
-		goto retry;
-	rcu_read_unlock();
-
+	memcg = get_obj_cgroup_memcg(objcg);
 	ret = __memcg_kmem_charge(memcg, gfp, nr_pages);
-
 	css_put(&memcg->css);
 
 	return ret;
@@ -3143,18 +3154,18 @@ static void __memcg_kmem_uncharge(struct mem_cgroup *memcg, unsigned int nr_page
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
@@ -3166,16 +3177,16 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
  */
 void __memcg_kmem_uncharge_page(struct page *page, int order)
 {
-	struct mem_cgroup *memcg = page_memcg(page);
+	struct obj_cgroup *objcg;
 	unsigned int nr_pages = 1 << order;
 
-	if (!memcg)
+	if (!PageMemcgKmem(page))
 		return;
 
-	VM_BUG_ON_PAGE(mem_cgroup_is_root(memcg), page);
-	__memcg_kmem_uncharge(memcg, nr_pages);
+	objcg = __page_objcg(page);
+	obj_cgroup_uncharge_pages(objcg, nr_pages);
 	page->memcg_data = 0;
-	css_put(&memcg->css);
+	obj_cgroup_put(objcg);
 }
 
 static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
@@ -6790,7 +6801,7 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
 
 struct uncharge_gather {
 	struct mem_cgroup *memcg;
-	unsigned long nr_pages;
+	unsigned long nr_memory;
 	unsigned long pgpgout;
 	unsigned long nr_kmem;
 	struct page *dummy_page;
@@ -6805,10 +6816,10 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 {
 	unsigned long flags;
 
-	if (!mem_cgroup_is_root(ug->memcg)) {
-		page_counter_uncharge(&ug->memcg->memory, ug->nr_pages);
+	if (ug->nr_memory) {
+		page_counter_uncharge(&ug->memcg->memory, ug->nr_memory);
 		if (do_memsw_account())
-			page_counter_uncharge(&ug->memcg->memsw, ug->nr_pages);
+			page_counter_uncharge(&ug->memcg->memsw, ug->nr_memory);
 		if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && ug->nr_kmem)
 			page_counter_uncharge(&ug->memcg->kmem, ug->nr_kmem);
 		memcg_oom_recover(ug->memcg);
@@ -6816,7 +6827,7 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 
 	local_irq_save(flags);
 	__count_memcg_events(ug->memcg, PGPGOUT, ug->pgpgout);
-	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_pages);
+	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_memory);
 	memcg_check_events(ug->memcg, ug->dummy_page);
 	local_irq_restore(flags);
 
@@ -6827,40 +6838,56 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 {
 	unsigned long nr_pages;
+	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
 
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 
-	if (!page_memcg(page))
-		return;
-
 	/*
 	 * Nobody should be changing or seriously looking at
-	 * page_memcg(page) at this point, we have fully
+	 * page memcg or objcg at this point, we have fully
 	 * exclusive access to the page.
 	 */
+	if (PageMemcgKmem(page)) {
+		objcg = __page_objcg(page);
+		memcg = get_obj_cgroup_memcg(objcg);
+	} else {
+		memcg = __page_memcg(page);
+	}
+
+	if (!memcg)
+		return;
 
-	if (ug->memcg != page_memcg(page)) {
+	if (ug->memcg != memcg) {
 		if (ug->memcg) {
 			uncharge_batch(ug);
 			uncharge_gather_clear(ug);
 		}
-		ug->memcg = page_memcg(page);
+		ug->memcg = memcg;
 		ug->dummy_page = page;
 
 		/* pairs with css_put in uncharge_batch */
-		css_get(&ug->memcg->css);
+		css_get(&memcg->css);
 	}
 
 	nr_pages = compound_nr(page);
-	ug->nr_pages += nr_pages;
 
-	if (PageMemcgKmem(page))
+	if (PageMemcgKmem(page)) {
+		ug->nr_memory += nr_pages;
 		ug->nr_kmem += nr_pages;
-	else
+
+		page->memcg_data = 0;
+		obj_cgroup_put(objcg);
+	} else {
+		/* LRU pages aren't accounted at the root level */
+		if (!mem_cgroup_is_root(memcg))
+			ug->nr_memory += nr_pages;
 		ug->pgpgout++;
 
-	page->memcg_data = 0;
-	css_put(&ug->memcg->css);
+		page->memcg_data = 0;
+	}
+
+	css_put(&memcg->css);
 }
 
 /**
-- 
2.11.0


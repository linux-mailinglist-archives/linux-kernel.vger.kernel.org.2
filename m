Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045A2342213
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 17:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhCSQjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 12:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhCSQi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 12:38:59 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB237C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 09:38:58 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id j25so6277900pfe.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 09:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EmBuA/r+QurHtqpfxW42oGsEG8Apvr3KHhKly1xy83o=;
        b=aZQqcz7JVko6UPPEEBN3nrKpbT45dGZnBrUpOBP61X37n1d9BOG6o0ll5LNlhioyvT
         El2kFYrz2BIEghgNPJgTH3L0KEourUdLmxs9KX9yMCV5PWo5ymul2d3otYD+frUa/g+w
         3zD3e8I9/Vgfvv9uabk4QIfh6trmKEL75AbACojXKKh3ICWUcNoRqOANEAx5x9F4FL9g
         cdrd0eBw+J8+Gn/4vP7D8Lq+fkJU8aDyN9q3lJP5GCITPrADy53rGAeCr63SsUbj7aht
         yuR1F1HZryIBHH2ChCqrweDuSJNOgg7CIdxfoa0ezuwyPO3B/Hlz8GdNKA6zYRNZRA85
         f97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EmBuA/r+QurHtqpfxW42oGsEG8Apvr3KHhKly1xy83o=;
        b=GKihhVHTNXxODfZc37JMNVtyLvVAtfg8cY2x/PFutWz2N4AdS6boZoHqcKw7Y4tSWY
         qUbpEL451QVlD/cV9n3lGwcLUSNdgP0E0/S3xWc9EccngzgIoasRvYcKfELjj+a9hhiU
         8F3dyTpAOO436GyueAAXTlR4zBQXwsFeZRfmh4PSrNxozeypQIkdAT11QwtgEdGHdN/G
         3LaqkweadYdEZzfYlE5Z8bVM0Jm1OaRkafUdScvOqQC3cYjZldPU8ciCb3NOHoMqfPEo
         OVmAGzW13edJuPOCUsWooJKYVUsfAvYwlee+NpsqGO0Z3RmrsVrAe1cw/zom+omMO/rV
         Db6A==
X-Gm-Message-State: AOAM532duehp16J1GfG6IL4OZXcP4So3XG2ezC/HeTpYp3xbBIgf6Y5i
        iRDpoKxO/8d7zXw3LpXXT5tKQA==
X-Google-Smtp-Source: ABdhPJwiLpxAfQjAZYRWBHTDmUFzm2ukdCITd6xH+YrO7TdxTEhp2chmlPPff0OLWeJn32rNjKW8Xw==
X-Received: by 2002:a62:5e05:0:b029:20b:241e:4e18 with SMTP id s5-20020a625e050000b029020b241e4e18mr10016154pfb.1.1616171938301;
        Fri, 19 Mar 2021 09:38:58 -0700 (PDT)
Received: from localhost.bytedance.net ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id z25sm5860239pfn.37.2021.03.19.09.38.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Mar 2021 09:38:58 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 5/7] mm: memcontrol: use obj_cgroup APIs to charge kmem pages
Date:   Sat, 20 Mar 2021 00:38:18 +0800
Message-Id: <20210319163821.20704-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210319163821.20704-1-songmuchun@bytedance.com>
References: <20210319163821.20704-1-songmuchun@bytedance.com>
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
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h | 116 +++++++++++++++++++++++++++++++++++----------
 mm/memcontrol.c            | 110 +++++++++++++++++++++---------------------
 2 files changed, 145 insertions(+), 81 deletions(-)

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
index 8d28a5a2ee58..962499542531 100644
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
 
@@ -1055,20 +1059,6 @@ static __always_inline struct mem_cgroup *active_memcg(void)
 		return current->active_memcg;
 }
 
-static __always_inline struct mem_cgroup *get_active_memcg(void)
-{
-	struct mem_cgroup *memcg;
-
-	rcu_read_lock();
-	memcg = active_memcg();
-	/* remote memcg must hold a ref. */
-	if (memcg && WARN_ON_ONCE(!css_tryget(&memcg->css)))
-		memcg = root_mem_cgroup;
-	rcu_read_unlock();
-
-	return memcg;
-}
-
 static __always_inline bool memcg_kmem_bypass(void)
 {
 	/* Allow remote memcg charging from any context. */
@@ -1083,20 +1073,6 @@ static __always_inline bool memcg_kmem_bypass(void)
 }
 
 /**
- * If active memcg is set, do not fallback to current->mm->memcg.
- */
-static __always_inline struct mem_cgroup *get_mem_cgroup_from_current(void)
-{
-	if (memcg_kmem_bypass())
-		return NULL;
-
-	if (unlikely(active_memcg()))
-		return get_active_memcg();
-
-	return get_mem_cgroup_from_mm(current->mm);
-}
-
-/**
  * mem_cgroup_iter - iterate over memory cgroup hierarchy
  * @root: hierarchy root
  * @prev: previously returned memcg, NULL on first invocation
@@ -3152,18 +3128,18 @@ static void __memcg_kmem_uncharge(struct mem_cgroup *memcg, unsigned int nr_page
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
@@ -3175,16 +3151,16 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
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
@@ -6799,7 +6775,7 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
 
 struct uncharge_gather {
 	struct mem_cgroup *memcg;
-	unsigned long nr_pages;
+	unsigned long nr_memory;
 	unsigned long pgpgout;
 	unsigned long nr_kmem;
 	struct page *dummy_page;
@@ -6814,10 +6790,10 @@ static void uncharge_batch(const struct uncharge_gather *ug)
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
@@ -6825,7 +6801,7 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 
 	local_irq_save(flags);
 	__count_memcg_events(ug->memcg, PGPGOUT, ug->pgpgout);
-	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_pages);
+	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_memory);
 	memcg_check_events(ug->memcg, ug->dummy_page);
 	local_irq_restore(flags);
 
@@ -6836,40 +6812,60 @@ static void uncharge_batch(const struct uncharge_gather *ug)
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
+		/*
+		 * This get matches the put at the end of the function and
+		 * kmem pages do not hold memcg references anymore.
+		 */
+		memcg = get_mem_cgroup_from_objcg(objcg);
+	} else {
+		memcg = __page_memcg(page);
+	}
 
-	if (ug->memcg != page_memcg(page)) {
+	if (!memcg)
+		return;
+
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


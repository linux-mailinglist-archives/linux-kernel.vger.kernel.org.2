Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BF7366600
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 09:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbhDUHC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 03:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236928AbhDUHCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 03:02:41 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44074C06138D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 00:02:09 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id d10so28866646pgf.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 00:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A7xWEHbU3D87OsO8GbRdsFu3vtMK/n8aOOr5dgu5yYc=;
        b=oG8Cpqa1RjhVk/bpRqgLL4p1K7cdQrm7Gqm+EiVLeuj6wmiQ141+Bvy2+9jC8PQVOW
         P4bexGK6fAfXpDPfdFsk2HwkaJcSEWiTnfAE/G/MExsQ/MSKRB+GfSossjry1urCNbc1
         U13QUXBNsqy2svCW63aHNODnCqcEEk5jX4WLZ32yLyDwRGi2ESkP4qh/P3AIghAJYoTT
         QYI8C6I/pklRkDEYXjgSpo+hY1/O0Pq24ctotmdIpTX8niP0O7YxQULwPvq6kopHCztr
         FHkNfoaAxOOHYKCDDyLQcmmzzSZ6cRVUkhjqXXS0+LiIff9S7YKkXMbb7R6wpU7KeJmv
         07KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A7xWEHbU3D87OsO8GbRdsFu3vtMK/n8aOOr5dgu5yYc=;
        b=T4A6pHIMIPyaz39nSdLFYckvzISvbBADrsng2ILF8kOJdYex9sUbZ+bKAS+0FqZBCV
         JS6GRwufPS6eUUOAT68x4gV/vLfq65V6HJ0LYXQ8/RgVnAF6Uovs8XAcMWNERnWDP40/
         bDbjlOoi+djH5uwJMSe6RF/h2FbjGKGeb2S0UVbKYpp37W2hgyPBIeN79jTykaJJfq9F
         8+5U1Z7rF4BXI8tp1zWyPlcenww5vBSDKt6RoMBmPEd9XYPyDAK/NA3SjJ/O9IJv5ict
         xP9MRzlGqhSi42Qdl3r18ES1Gk8yjri53EUx7wLROOWJgn57yoB+CM5st9196gXPlr08
         +FMw==
X-Gm-Message-State: AOAM533roV0Mkha+urZA607GDfwg9DB1+3/XV2ODx65h/+SZLjH/oZeW
        eWuso6VWxmflR/sjqOQndgHFxg==
X-Google-Smtp-Source: ABdhPJywszd28dz5RNIlgvV3ztqVE89D6MfkZ4BlgCSmPOzYG5+PpJNGZKG8t+6L1msz9tL04nOuMw==
X-Received: by 2002:a17:90a:6282:: with SMTP id d2mr9063637pjj.168.1618988528719;
        Wed, 21 Apr 2021 00:02:08 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id c4sm929842pfb.94.2021.04.21.00.02.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Apr 2021 00:02:08 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v3 09/12] mm: memcontrol: use obj_cgroup APIs to charge the LRU pages
Date:   Wed, 21 Apr 2021 15:00:56 +0800
Message-Id: <20210421070059.69361-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210421070059.69361-1-songmuchun@bytedance.com>
References: <20210421070059.69361-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will reuse the obj_cgroup APIs to charge the LRU pages. Finally,
page->memcg_data will have 2 different meanings.

  - For the slab pages, page->memcg_data points to an object cgroups
    vector.

  - For the kmem pages (exclude the slab pages) and the LRU pages,
    page->memcg_data points to an object cgroup.

In this patch, we reuse obj_cgroup APIs to charge LRU pages. In the end,
The page cache cannot prevent long-living objects from pinning the original
memory cgroup in the memory.

At the same time we also changed the rules of page and objcg or memcg
binding stability. The new rules are as follows.

For a page any of the following ensures page and objcg binding stability:

  - the page lock
  - LRU isolation
  - lock_page_memcg()
  - exclusive reference

Based on the stable binding of page and objcg, for a page any of the
following ensures page and memcg binding stability:

  - css_set_lock
  - cgroup_mutex
  - the lruvec lock
  - the split queue lock (only THP page)

If the caller only want to ensure that the page counters of memcg are
updated correctly, ensure that the binding stability of page and objcg
is sufficient.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h |  96 ++++++---------
 mm/huge_memory.c           |  48 ++++++++
 mm/memcontrol.c            | 288 ++++++++++++++++++++++++++++++++-------------
 3 files changed, 293 insertions(+), 139 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index b12847b0be09..756bb4d7d6c1 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -385,8 +385,6 @@ enum page_memcg_data_flags {
 
 #define MEMCG_DATA_FLAGS_MASK (__NR_MEMCG_DATA_FLAGS - 1)
 
-static inline bool PageMemcgKmem(struct page *page);
-
 /*
  * After the initialization objcg->memcg is always pointing at
  * a valid memcg, but can be atomically swapped to the parent memcg.
@@ -400,43 +398,19 @@ static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg)
 }
 
 /*
- * __page_memcg - get the memory cgroup associated with a non-kmem page
- * @page: a pointer to the page struct
- *
- * Returns a pointer to the memory cgroup associated with the page,
- * or NULL. This function assumes that the page is known to have a
- * proper memory cgroup pointer. It's not safe to call this function
- * against some type of pages, e.g. slab pages or ex-slab pages or
- * kmem pages.
- */
-static inline struct mem_cgroup *__page_memcg(struct page *page)
-{
-	unsigned long memcg_data = page->memcg_data;
-
-	VM_BUG_ON_PAGE(PageSlab(page), page);
-	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
-	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_KMEM, page);
-
-	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
-}
-
-/*
- * __page_objcg - get the object cgroup associated with a kmem page
+ * page_objcg - get the object cgroup associated with page
  * @page: a pointer to the page struct
  *
  * Returns a pointer to the object cgroup associated with the page,
  * or NULL. This function assumes that the page is known to have a
- * proper object cgroup pointer. It's not safe to call this function
- * against some type of pages, e.g. slab pages or ex-slab pages or
- * LRU pages.
+ * proper object cgroup pointer.
  */
-static inline struct obj_cgroup *__page_objcg(struct page *page)
+static inline struct obj_cgroup *page_objcg(struct page *page)
 {
 	unsigned long memcg_data = page->memcg_data;
 
 	VM_BUG_ON_PAGE(PageSlab(page), page);
 	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
-	VM_BUG_ON_PAGE(!(memcg_data & MEMCG_DATA_KMEM), page);
 
 	return (struct obj_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 }
@@ -450,23 +424,35 @@ static inline struct obj_cgroup *__page_objcg(struct page *page)
  * proper memory cgroup pointer. It's not safe to call this function
  * against some type of pages, e.g. slab pages or ex-slab pages.
  *
- * For a non-kmem page any of the following ensures page and memcg binding
- * stability:
+ * For a page any of the following ensures page and objcg binding stability:
  *
  * - the page lock
  * - LRU isolation
  * - lock_page_memcg()
  * - exclusive reference
  *
- * For a kmem page a caller should hold an rcu read lock to protect memcg
- * associated with a kmem page from being released.
+ * Based on the stable binding of page and objcg, for a page any of the
+ * following ensures page and memcg binding stability:
+ *
+ * - css_set_lock
+ * - cgroup_mutex
+ * - the lruvec lock
+ * - the split queue lock (only THP page)
+ *
+ * If the caller only want to ensure that the page counters of memcg are
+ * updated correctly, ensure that the binding stability of page and objcg
+ * is sufficient.
+ *
+ * A caller should hold an rcu read lock (In addition, regions of code across
+ * which interrupts, preemption, or softirqs have been disabled also serve as
+ * RCU read-side critical sections) to protect memcg associated with a page
+ * from being released.
  */
 static inline struct mem_cgroup *page_memcg(struct page *page)
 {
-	if (PageMemcgKmem(page))
-		return obj_cgroup_memcg(__page_objcg(page));
-	else
-		return __page_memcg(page);
+	struct obj_cgroup *objcg = page_objcg(page);
+
+	return objcg ? obj_cgroup_memcg(objcg) : NULL;
 }
 
 /*
@@ -479,6 +465,8 @@ static inline struct mem_cgroup *page_memcg(struct page *page)
  * is known to have a proper memory cgroup pointer. It's not safe to call
  * this function against some type of pages, e.g. slab pages or ex-slab
  * pages.
+ *
+ * The page and objcg or memcg binding rules can refer to page_memcg().
  */
 static inline struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
 {
@@ -502,22 +490,20 @@ static inline struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
  * or NULL. This function assumes that the page is known to have a
  * proper memory cgroup pointer. It's not safe to call this function
  * against some type of pages, e.g. slab pages or ex-slab pages.
+ *
+ * The page and objcg or memcg binding rules can refer to page_memcg().
  */
 static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
 {
 	unsigned long memcg_data = READ_ONCE(page->memcg_data);
+	struct obj_cgroup *objcg;
 
 	VM_BUG_ON_PAGE(PageSlab(page), page);
 	WARN_ON_ONCE(!rcu_read_lock_held());
 
-	if (memcg_data & MEMCG_DATA_KMEM) {
-		struct obj_cgroup *objcg;
-
-		objcg = (void *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
-		return obj_cgroup_memcg(objcg);
-	}
+	objcg = (void *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 
-	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+	return objcg ? obj_cgroup_memcg(objcg) : NULL;
 }
 
 /*
@@ -530,16 +516,10 @@ static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
  * has an associated memory cgroup pointer or an object cgroups vector or
  * an object cgroup.
  *
- * For a non-kmem page any of the following ensures page and memcg binding
- * stability:
- *
- * - the page lock
- * - LRU isolation
- * - lock_page_memcg()
- * - exclusive reference
+ * The page and objcg or memcg binding rules can refer to page_memcg().
  *
- * For a kmem page a caller should hold an rcu read lock to protect memcg
- * associated with a kmem page from being released.
+ * A caller should hold an rcu read lock to protect memcg associated with a
+ * page from being released.
  */
 static inline struct mem_cgroup *page_memcg_check(struct page *page)
 {
@@ -548,18 +528,14 @@ static inline struct mem_cgroup *page_memcg_check(struct page *page)
 	 * for slab pages, READ_ONCE() should be used here.
 	 */
 	unsigned long memcg_data = READ_ONCE(page->memcg_data);
+	struct obj_cgroup *objcg;
 
 	if (memcg_data & MEMCG_DATA_OBJCGS)
 		return NULL;
 
-	if (memcg_data & MEMCG_DATA_KMEM) {
-		struct obj_cgroup *objcg;
-
-		objcg = (void *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
-		return obj_cgroup_memcg(objcg);
-	}
+	objcg = (void *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 
-	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+	return objcg ? obj_cgroup_memcg(objcg) : NULL;
 }
 
 #ifdef CONFIG_MEMCG_KMEM
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 25025bf988f8..584a4e97dbde 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -487,6 +487,8 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 }
 
 #ifdef CONFIG_MEMCG
+static struct shrinker deferred_split_shrinker;
+
 static inline struct mem_cgroup *split_queue_to_memcg(struct deferred_split *queue)
 {
 	return container_of(queue, struct mem_cgroup, deferred_split_queue);
@@ -545,6 +547,52 @@ static struct deferred_split *lock_split_queue_irqsave(struct page *page,
 
 	return queue;
 }
+
+static void memcg_reparent_split_queue_lock(struct mem_cgroup *memcg,
+					    struct mem_cgroup *parent)
+{
+	spin_lock(&memcg->deferred_split_queue.split_queue_lock);
+	spin_lock(&parent->deferred_split_queue.split_queue_lock);
+}
+
+static void memcg_reparent_split_queue_unlock(struct mem_cgroup *memcg,
+					      struct mem_cgroup *parent)
+{
+	spin_unlock(&parent->deferred_split_queue.split_queue_lock);
+	spin_unlock(&memcg->deferred_split_queue.split_queue_lock);
+}
+
+static void memcg_reparent_split_queue(struct mem_cgroup *memcg,
+				       struct mem_cgroup *parent)
+{
+	int nid;
+	struct deferred_split *src, *dst;
+
+	src = &memcg->deferred_split_queue;
+	dst = &parent->deferred_split_queue;
+
+	if (!src->split_queue_len)
+		return;
+
+	list_splice_tail_init(&src->split_queue, &dst->split_queue);
+	dst->split_queue_len += src->split_queue_len;
+	src->split_queue_len = 0;
+
+	for_each_node(nid)
+		set_shrinker_bit(parent, nid, deferred_split_shrinker.id);
+}
+
+static struct memcg_reparent_ops split_queue_reparent_ops = {
+	.lock		= memcg_reparent_split_queue_lock,
+	.unlock		= memcg_reparent_split_queue_unlock,
+	.reparent	= memcg_reparent_split_queue,
+};
+
+static void __init split_queue_reparent_init(void)
+{
+	register_memcg_repatent(&split_queue_reparent_ops);
+}
+core_initcall(split_queue_reparent_init);
 #else
 static struct deferred_split *lock_split_queue(struct page *page)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f88fe2f06f5b..7a52a30f2f88 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -75,6 +75,7 @@ struct cgroup_subsys memory_cgrp_subsys __read_mostly;
 EXPORT_SYMBOL(memory_cgrp_subsys);
 
 struct mem_cgroup *root_mem_cgroup __read_mostly;
+static struct obj_cgroup *root_obj_cgroup __read_mostly;
 
 /* Active memory cgroup to use from an interrupt context */
 DEFINE_PER_CPU(struct mem_cgroup *, int_active_memcg);
@@ -254,6 +255,11 @@ struct cgroup_subsys_state *vmpressure_to_css(struct vmpressure *vmpr)
 
 extern spinlock_t css_set_lock;
 
+static inline bool obj_cgroup_is_root(struct obj_cgroup *objcg)
+{
+	return objcg == root_obj_cgroup;
+}
+
 #ifdef CONFIG_MEMCG_KMEM
 static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 				      unsigned int nr_pages);
@@ -330,6 +336,77 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
 	return objcg;
 }
 
+static void memcg_reparent_lruvec_lock(struct mem_cgroup *memcg,
+				       struct mem_cgroup *parent)
+{
+	int nid;
+
+	for_each_node(nid) {
+		spin_lock(&mem_cgroup_lruvec(memcg, NODE_DATA(nid))->lru_lock);
+		spin_lock(&mem_cgroup_lruvec(parent, NODE_DATA(nid))->lru_lock);
+	}
+}
+
+static void memcg_reparent_lruvec_unlock(struct mem_cgroup *memcg,
+					 struct mem_cgroup *parent)
+{
+	int nid;
+
+	for_each_node(nid) {
+		spin_unlock(&mem_cgroup_lruvec(parent, NODE_DATA(nid))->lru_lock);
+		spin_unlock(&mem_cgroup_lruvec(memcg, NODE_DATA(nid))->lru_lock);
+	}
+}
+
+static void lruvec_reparent_lru(struct lruvec *src, struct lruvec *dst,
+				enum lru_list lru)
+{
+	int zid;
+	struct mem_cgroup_per_node *mz_src, *mz_dst;
+
+	mz_src = container_of(src, struct mem_cgroup_per_node, lruvec);
+	mz_dst = container_of(dst, struct mem_cgroup_per_node, lruvec);
+
+	list_splice_tail_init(&src->lists[lru], &dst->lists[lru]);
+
+	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
+		mz_dst->lru_zone_size[zid][lru] += mz_src->lru_zone_size[zid][lru];
+		mz_src->lru_zone_size[zid][lru] = 0;
+	}
+}
+
+static void memcg_reparent_lruvec(struct mem_cgroup *memcg,
+				  struct mem_cgroup *parent)
+{
+	int nid;
+
+	for_each_node(nid) {
+		enum lru_list lru;
+		struct lruvec *src, *dst;
+
+		src = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
+		dst = mem_cgroup_lruvec(parent, NODE_DATA(nid));
+
+		dst->anon_cost += src->anon_cost;
+		dst->file_cost += src->file_cost;
+
+		for_each_lru(lru)
+			lruvec_reparent_lru(src, dst, lru);
+	}
+}
+
+static struct memcg_reparent_ops lruvec_reparent_ops = {
+	.lock		= memcg_reparent_lruvec_lock,
+	.unlock		= memcg_reparent_lruvec_unlock,
+	.reparent	= memcg_reparent_lruvec,
+};
+
+static void __init lruvec_reparent_init(void)
+{
+	register_memcg_repatent(&lruvec_reparent_ops);
+}
+core_initcall(lruvec_reparent_init);
+
 static LIST_HEAD(reparent_ops_head);
 
 static void memcg_reparent_lock(struct mem_cgroup *memcg,
@@ -2778,18 +2855,18 @@ static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
 }
 #endif
 
-static void commit_charge(struct page *page, struct mem_cgroup *memcg)
+static void commit_charge(struct page *page, struct obj_cgroup *objcg)
 {
-	VM_BUG_ON_PAGE(page_memcg(page), page);
+	VM_BUG_ON_PAGE(page_objcg(page), page);
 	/*
-	 * Any of the following ensures page's memcg stability:
+	 * Any of the following ensures page's objcg stability:
 	 *
 	 * - the page lock
 	 * - LRU isolation
 	 * - lock_page_memcg()
 	 * - exclusive reference
 	 */
-	page->memcg_data = (unsigned long)memcg;
+	page->memcg_data = (unsigned long)objcg;
 }
 
 static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
@@ -2806,6 +2883,21 @@ static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
 	return memcg;
 }
 
+static struct obj_cgroup *get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
+{
+	struct obj_cgroup *objcg = NULL;
+
+	rcu_read_lock();
+	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
+		objcg = rcu_dereference(memcg->objcg);
+		if (objcg && obj_cgroup_tryget(objcg))
+			break;
+	}
+	rcu_read_unlock();
+
+	return objcg;
+}
+
 #ifdef CONFIG_MEMCG_KMEM
 int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
 				 gfp_t gfp, bool new_page)
@@ -2903,12 +2995,15 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
 	else
 		memcg = mem_cgroup_from_task(current);
 
-	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
-		objcg = rcu_dereference(memcg->objcg);
-		if (objcg && obj_cgroup_tryget(objcg))
-			break;
+	if (mem_cgroup_is_root(memcg))
+		goto out;
+
+	objcg = get_obj_cgroup_from_memcg(memcg);
+	if (obj_cgroup_is_root(objcg)) {
+		obj_cgroup_put(objcg);
 		objcg = NULL;
 	}
+out:
 	rcu_read_unlock();
 
 	return objcg;
@@ -3051,13 +3146,13 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
  */
 void __memcg_kmem_uncharge_page(struct page *page, int order)
 {
-	struct obj_cgroup *objcg;
+	struct obj_cgroup *objcg = page_objcg(page);
 	unsigned int nr_pages = 1 << order;
 
-	if (!PageMemcgKmem(page))
+	if (!objcg)
 		return;
 
-	objcg = __page_objcg(page);
+	VM_BUG_ON_PAGE(!PageMemcgKmem(page), page);
 	obj_cgroup_uncharge_pages(objcg, nr_pages);
 	page->memcg_data = 0;
 	obj_cgroup_put(objcg);
@@ -3189,23 +3284,20 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
 #endif /* CONFIG_MEMCG_KMEM */
 
 /*
- * Because page_memcg(head) is not set on tails, set it now.
+ * Because page_objcg(head) is not set on tails, set it now.
  */
 void split_page_memcg(struct page *head, unsigned int nr)
 {
-	struct mem_cgroup *memcg = page_memcg(head);
+	struct obj_cgroup *objcg = page_objcg(head);
 	int i;
 
-	if (mem_cgroup_disabled() || !memcg)
+	if (mem_cgroup_disabled() || !objcg)
 		return;
 
 	for (i = 1; i < nr; i++)
 		head[i].memcg_data = head->memcg_data;
 
-	if (PageMemcgKmem(head))
-		obj_cgroup_get_many(__page_objcg(head), nr - 1);
-	else
-		css_get_many(&memcg->css, nr - 1);
+	obj_cgroup_get_many(objcg, nr - 1);
 }
 
 #ifdef CONFIG_MEMCG_SWAP
@@ -5192,6 +5284,9 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	objcg->memcg = memcg;
 	rcu_assign_pointer(memcg->objcg, objcg);
 
+	if (unlikely(mem_cgroup_is_root(memcg)))
+		root_obj_cgroup = objcg;
+
 	/* Online state pins memcg ID, memcg ID pins CSS */
 	refcount_set(&memcg->id.ref, 1);
 	css_get(css);
@@ -5566,10 +5661,10 @@ static int mem_cgroup_move_account(struct page *page,
 	 */
 	smp_mb();
 
-	css_get(&to->css);
-	css_put(&from->css);
+	obj_cgroup_get(to->objcg);
+	obj_cgroup_put(from->objcg);
 
-	page->memcg_data = (unsigned long)to;
+	page->memcg_data = (unsigned long)to->objcg;
 
 	__unlock_page_memcg(from);
 
@@ -6041,6 +6136,42 @@ static void mem_cgroup_move_charge(void)
 
 	mmap_read_unlock(mc.mm);
 	atomic_dec(&mc.from->moving_account);
+
+	/*
+	 * Moving its pages to another memcg is finished. Wait for already
+	 * started RCU-only updates to finish to make sure that the caller
+	 * of lock_page_memcg() can unlock the correct move_lock. The
+	 * possible bad scenario would like:
+	 *
+	 * CPU0:				CPU1:
+	 * mem_cgroup_move_charge()
+	 *     walk_page_range()
+	 *
+	 *					lock_page_memcg(page)
+	 *					    memcg = page_memcg(page)
+	 *					    spin_lock_irqsave(&memcg->move_lock)
+	 *					    memcg->move_lock_task = current
+	 *
+	 *     atomic_dec(&mc.from->moving_account)
+	 *
+	 * mem_cgroup_css_offline()
+	 *     memcg_offline_kmem()
+	 *         memcg_reparent_objcgs() <== reparented
+	 *
+	 *					unlock_page_memcg(page)
+	 *					    memcg = page_memcg(page) <== memcg has been changed
+	 *					    if (memcg->move_lock_task == current) <== false
+	 *					        spin_unlock_irqrestore(&memcg->move_lock)
+	 *
+	 * Once mem_cgroup_move_charge() returns (it means that the cgroup_mutex
+	 * would be released soon), the page can be reparented to its parent
+	 * memcg. When the unlock_page_memcg() is called for the page, we will
+	 * miss unlock the move_lock. So using synchronize_rcu to wait for
+	 * already started RCU-only updates to finish before this function
+	 * returns (mem_cgroup_move_charge() and mem_cgroup_css_offline() are
+	 * serialized by cgroup_mutex).
+	 */
+	synchronize_rcu();
 }
 
 /*
@@ -6596,21 +6727,26 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
 			       gfp_t gfp)
 {
+	struct obj_cgroup *objcg;
 	unsigned int nr_pages = thp_nr_pages(page);
-	int ret;
+	int ret = 0;
 
-	ret = try_charge(memcg, gfp, nr_pages);
+	objcg = get_obj_cgroup_from_memcg(memcg);
+	/* Do not account at the root objcg level. */
+	if (!obj_cgroup_is_root(objcg))
+		ret = try_charge(memcg, gfp, nr_pages);
 	if (ret)
 		goto out;
 
-	css_get(&memcg->css);
-	commit_charge(page, memcg);
+	obj_cgroup_get(objcg);
+	commit_charge(page, objcg);
 
 	local_irq_disable();
 	mem_cgroup_charge_statistics(memcg, page, nr_pages);
 	memcg_check_events(memcg, page);
 	local_irq_enable();
 out:
+	obj_cgroup_put(objcg);
 	return ret;
 }
 
@@ -6711,7 +6847,7 @@ void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry)
 }
 
 struct uncharge_gather {
-	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
 	unsigned long nr_memory;
 	unsigned long pgpgout;
 	unsigned long nr_kmem;
@@ -6726,63 +6862,56 @@ static inline void uncharge_gather_clear(struct uncharge_gather *ug)
 static void uncharge_batch(const struct uncharge_gather *ug)
 {
 	unsigned long flags;
+	struct mem_cgroup *memcg;
 
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(ug->objcg);
 	if (ug->nr_memory) {
-		page_counter_uncharge(&ug->memcg->memory, ug->nr_memory);
+		page_counter_uncharge(&memcg->memory, ug->nr_memory);
 		if (do_memsw_account())
-			page_counter_uncharge(&ug->memcg->memsw, ug->nr_memory);
+			page_counter_uncharge(&memcg->memsw, ug->nr_memory);
 		if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && ug->nr_kmem)
-			page_counter_uncharge(&ug->memcg->kmem, ug->nr_kmem);
-		memcg_oom_recover(ug->memcg);
+			page_counter_uncharge(&memcg->kmem, ug->nr_kmem);
+		memcg_oom_recover(memcg);
 	}
 
 	local_irq_save(flags);
-	__count_memcg_events(ug->memcg, PGPGOUT, ug->pgpgout);
-	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_memory);
-	memcg_check_events(ug->memcg, ug->dummy_page);
+	__count_memcg_events(memcg, PGPGOUT, ug->pgpgout);
+	__this_cpu_add(memcg->vmstats_percpu->nr_page_events, ug->nr_memory);
+	memcg_check_events(memcg, ug->dummy_page);
 	local_irq_restore(flags);
+	rcu_read_unlock();
 
 	/* drop reference from uncharge_page */
-	css_put(&ug->memcg->css);
+	obj_cgroup_put(ug->objcg);
 }
 
 static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 {
 	unsigned long nr_pages;
-	struct mem_cgroup *memcg;
 	struct obj_cgroup *objcg;
 
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 
 	/*
 	 * Nobody should be changing or seriously looking at
-	 * page memcg or objcg at this point, we have fully
-	 * exclusive access to the page.
+	 * page objcg at this point, we have fully exclusive
+	 * access to the page.
 	 */
-	if (PageMemcgKmem(page)) {
-		objcg = __page_objcg(page);
-		/*
-		 * This get matches the put at the end of the function and
-		 * kmem pages do not hold memcg references anymore.
-		 */
-		memcg = get_mem_cgroup_from_objcg(objcg);
-	} else {
-		memcg = __page_memcg(page);
-	}
-
-	if (!memcg)
+	objcg = page_objcg(page);
+	if (!objcg)
 		return;
 
-	if (ug->memcg != memcg) {
-		if (ug->memcg) {
+	if (ug->objcg != objcg) {
+		if (ug->objcg) {
 			uncharge_batch(ug);
 			uncharge_gather_clear(ug);
 		}
-		ug->memcg = memcg;
+		ug->objcg = objcg;
 		ug->dummy_page = page;
 
-		/* pairs with css_put in uncharge_batch */
-		css_get(&memcg->css);
+		/* pairs with obj_cgroup_put in uncharge_batch */
+		obj_cgroup_get(objcg);
 	}
 
 	nr_pages = compound_nr(page);
@@ -6790,19 +6919,15 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 	if (PageMemcgKmem(page)) {
 		ug->nr_memory += nr_pages;
 		ug->nr_kmem += nr_pages;
-
-		page->memcg_data = 0;
-		obj_cgroup_put(objcg);
 	} else {
 		/* LRU pages aren't accounted at the root level */
-		if (!mem_cgroup_is_root(memcg))
+		if (!obj_cgroup_is_root(objcg))
 			ug->nr_memory += nr_pages;
 		ug->pgpgout++;
-
-		page->memcg_data = 0;
 	}
 
-	css_put(&memcg->css);
+	page->memcg_data = 0;
+	obj_cgroup_put(objcg);
 }
 
 /**
@@ -6819,7 +6944,7 @@ void mem_cgroup_uncharge(struct page *page)
 		return;
 
 	/* Don't touch page->lru of any random page, pre-check: */
-	if (!page_memcg(page))
+	if (!page_objcg(page))
 		return;
 
 	uncharge_gather_clear(&ug);
@@ -6845,7 +6970,7 @@ void mem_cgroup_uncharge_list(struct list_head *page_list)
 	uncharge_gather_clear(&ug);
 	list_for_each_entry(page, page_list, lru)
 		uncharge_page(page, &ug);
-	if (ug.memcg)
+	if (ug.objcg)
 		uncharge_batch(&ug);
 }
 
@@ -6862,6 +6987,7 @@ void mem_cgroup_uncharge_list(struct list_head *page_list)
 void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 {
 	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
 	unsigned int nr_pages;
 	unsigned long flags;
 
@@ -6875,32 +7001,34 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 		return;
 
 	/* Page cache replacement: new page already charged? */
-	if (page_memcg(newpage))
+	if (page_objcg(newpage))
 		return;
 
-	memcg = get_mem_cgroup_from_page(oldpage);
-	VM_WARN_ON_ONCE_PAGE(!memcg, oldpage);
-	if (!memcg)
+	objcg = page_objcg(oldpage);
+	VM_WARN_ON_ONCE_PAGE(!objcg, oldpage);
+	if (!objcg)
 		return;
 
 	/* Force-charge the new page. The old one will be freed soon */
 	nr_pages = thp_nr_pages(newpage);
 
-	if (!mem_cgroup_is_root(memcg)) {
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(objcg);
+
+	if (!obj_cgroup_is_root(objcg)) {
 		page_counter_charge(&memcg->memory, nr_pages);
 		if (do_memsw_account())
 			page_counter_charge(&memcg->memsw, nr_pages);
 	}
 
-	css_get(&memcg->css);
-	commit_charge(newpage, memcg);
+	obj_cgroup_get(objcg);
+	commit_charge(newpage, objcg);
 
 	local_irq_save(flags);
 	mem_cgroup_charge_statistics(memcg, newpage, nr_pages);
 	memcg_check_events(memcg, newpage);
 	local_irq_restore(flags);
-
-	css_put(&memcg->css);
+	rcu_read_unlock();
 }
 
 DEFINE_STATIC_KEY_FALSE(memcg_sockets_enabled_key);
@@ -7077,6 +7205,7 @@ static struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg)
 void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 {
 	struct mem_cgroup *memcg, *swap_memcg;
+	struct obj_cgroup *objcg;
 	unsigned int nr_entries;
 	unsigned short oldid;
 
@@ -7089,15 +7218,16 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return;
 
+	objcg = page_objcg(page);
+	VM_WARN_ON_ONCE_PAGE(!objcg, page);
+	if (!objcg)
+		return;
+
 	/*
 	 * Interrupts should be disabled by the caller (see the comments below),
 	 * which can serve as RCU read-side critical sections.
 	 */
-	memcg = page_memcg(page);
-
-	VM_WARN_ON_ONCE_PAGE(!memcg, page);
-	if (!memcg)
-		return;
+	memcg = obj_cgroup_memcg(objcg);
 
 	/*
 	 * In case the memcg owning these pages has been offlined and doesn't
@@ -7116,7 +7246,7 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 
 	page->memcg_data = 0;
 
-	if (!mem_cgroup_is_root(memcg))
+	if (!obj_cgroup_is_root(objcg))
 		page_counter_uncharge(&memcg->memory, nr_entries);
 
 	if (!cgroup_memory_noswap && memcg != swap_memcg) {
@@ -7135,7 +7265,7 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	mem_cgroup_charge_statistics(memcg, page, -nr_entries);
 	memcg_check_events(memcg, page);
 
-	css_put(&memcg->css);
+	obj_cgroup_put(objcg);
 }
 
 /**
-- 
2.11.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA393EC0B1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 07:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237288AbhHNF05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 01:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236925AbhHNF0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 01:26:55 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C097AC061575
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 22:26:25 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id w14so18377234pjh.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 22:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sy4RfaFrUa96arTkfKfOAAECCqypdoUZE3FYwI0uJVw=;
        b=BWxz79DtamTGjYX235WxqKBumLJQyCxloLwB5X8n+0JxTUBuMqZqEK4omZzZsyFswi
         xc/1ndSznpBR4hGLtx565tcD5RMzo/McXwKbvwGLv8USzAMj2vEaLXFsiwL15lgyQ+VY
         Mp91popEeyw4sq0/VsajRcZ7SuaeO0844Nct/xO3dRS/FQeHMaO4SdSJa+z+iEIQqId6
         KsaRySeZ1YgH2neTbm6pxbzmzT4q9mJdT9DjAgy7Bc1KaBNFA6ziG4aLJv1cUbWiyN58
         +pMyAR3MyNP9PrHXmkxv9hal/Y+dldMTF0q9+yHCd1QtLv2FFdjhOfhtgVak1NVi9GHT
         m4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sy4RfaFrUa96arTkfKfOAAECCqypdoUZE3FYwI0uJVw=;
        b=BKHGO/Zp2aZwXIPsQBxnYw2CXqvV60Kkq8EeI9cRW7m3SMncCK3ZNriPnGi/G+YK3S
         sHrN/V59FT/OSZupbAHSyuk1sZHDIO8zQ2IRVhJuiD7LI2F+Yc4I9i8TAb9p9bqCgX0U
         vtxp5UIPn0YcAMokATXqDzExovr/r7Lw3d1OrE8/5zrYWAXZxIKugATZ380m7ixO/DNR
         Ck0pW5W7jFAz0pEqtyFbgIsSBE0p9RAwwBDA7DBiJiXGrod6FLA6hILerIg/YqLslXHz
         Zd5hiRaHsvPVZ9EhszwuhaLwI25eBsitI5hJHP2jYYK/xjGRbCHAz5VDC/1zMY/9c5nH
         2Wrg==
X-Gm-Message-State: AOAM531cCSmuiWal3Cr9s9qF6kIXotNgwth2KizvThp40Yp9CmbLyWm6
        CvsUpGNTEfw/z6t0Dou0jwWe2g==
X-Google-Smtp-Source: ABdhPJxPSem9RUplidgl64wgt0gY2T6IcwLbBAPLlSSIoVY/57aZnVBhCrRQPoxYtUW5HS5luK+uGw==
X-Received: by 2002:a63:214c:: with SMTP id s12mr571575pgm.86.1628918785213;
        Fri, 13 Aug 2021 22:26:25 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id s5sm4783133pgp.81.2021.08.13.22.26.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Aug 2021 22:26:24 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v1 09/12] mm: memcontrol: use obj_cgroup APIs to charge the LRU pages
Date:   Sat, 14 Aug 2021 13:25:16 +0800
Message-Id: <20210814052519.86679-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210814052519.86679-1-songmuchun@bytedance.com>
References: <20210814052519.86679-1-songmuchun@bytedance.com>
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
 include/linux/memcontrol.h |  94 ++++++--------
 mm/huge_memory.c           |  42 +++++++
 mm/memcontrol.c            | 296 ++++++++++++++++++++++++++++++++-------------
 3 files changed, 293 insertions(+), 139 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d85c03f2d76d..92c98a952bab 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -378,8 +378,6 @@ enum page_memcg_data_flags {
 
 #define MEMCG_DATA_FLAGS_MASK (__NR_MEMCG_DATA_FLAGS - 1)
 
-static inline bool folio_memcg_kmem(struct folio *folio);
-
 /*
  * After the initialization objcg->memcg is always pointing at
  * a valid memcg, but can be atomically swapped to the parent memcg.
@@ -393,43 +391,19 @@ static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg)
 }
 
 /*
- * __folio_memcg - Get the memory cgroup associated with a non-kmem folio
- * @folio: Pointer to the folio.
- *
- * Returns a pointer to the memory cgroup associated with the folio,
- * or NULL. This function assumes that the folio is known to have a
- * proper memory cgroup pointer. It's not safe to call this function
- * against some type of folios, e.g. slab folios or ex-slab folios or
- * kmem folios.
- */
-static inline struct mem_cgroup *__folio_memcg(struct folio *folio)
-{
-	unsigned long memcg_data = folio->memcg_data;
-
-	VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
-	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJCGS, folio);
-	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_KMEM, folio);
-
-	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
-}
-
-/*
- * __folio_objcg - get the object cgroup associated with a kmem folio.
+ * folio_objcg - get the object cgroup associated with a folio.
  * @folio: Pointer to the folio.
  *
  * Returns a pointer to the object cgroup associated with the folio,
  * or NULL. This function assumes that the folio is known to have a
- * proper object cgroup pointer. It's not safe to call this function
- * against some type of folios, e.g. slab folios or ex-slab folios or
- * LRU folios.
+ * proper object cgroup pointer.
  */
-static inline struct obj_cgroup *__folio_objcg(struct folio *folio)
+static inline struct obj_cgroup *folio_objcg(struct folio *folio)
 {
 	unsigned long memcg_data = folio->memcg_data;
 
 	VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
 	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJCGS, folio);
-	VM_BUG_ON_FOLIO(!(memcg_data & MEMCG_DATA_KMEM), folio);
 
 	return (struct obj_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 }
@@ -443,7 +417,7 @@ static inline struct obj_cgroup *__folio_objcg(struct folio *folio)
  * proper memory cgroup pointer. It's not safe to call this function
  * against some type of folios, e.g. slab folios or ex-slab folios.
  *
- * For a non-kmem folio any of the following ensures folio and memcg binding
+ * For a folio any of the following ensures folio and memcg binding
  * stability:
  *
  * - the folio lock
@@ -451,14 +425,28 @@ static inline struct obj_cgroup *__folio_objcg(struct folio *folio)
  * - lock_page_memcg()
  * - exclusive reference
  *
- * For a kmem folio a caller should hold an rcu read lock to protect memcg
- * associated with a kmem folio from being released.
+ * Based on the stable binding of folio and objcg, for a folio any of the
+ * following ensures folio and memcg binding stability:
+ *
+ * - css_set_lock
+ * - cgroup_mutex
+ * - the lruvec lock
+ * - the split queue lock (only THP page)
+ *
+ * If the caller only want to ensure that the page counters of memcg are
+ * updated correctly, ensure that the binding stability of folio and objcg
+ * is sufficient.
+ *
+ * A caller should hold an rcu read lock (In addition, regions of code across
+ * which interrupts, preemption, or softirqs have been disabled also serve as
+ * RCU read-side critical sections) to protect memcg associated with a folio
+ * from being released.
  */
 static inline struct mem_cgroup *folio_memcg(struct folio *folio)
 {
-	if (folio_memcg_kmem(folio))
-		return obj_cgroup_memcg(__folio_objcg(folio));
-	return __folio_memcg(folio);
+	struct obj_cgroup *objcg = folio_objcg(folio);
+
+	return objcg ? obj_cgroup_memcg(objcg) : NULL;
 }
 
 static inline struct mem_cgroup *page_memcg(struct page *page)
@@ -476,6 +464,8 @@ static inline struct mem_cgroup *page_memcg(struct page *page)
  * folio is known to have a proper memory cgroup pointer. It's not safe
  * to call this function against some type of pages, e.g. slab pages or
  * ex-slab pages.
+ *
+ * The page and objcg or memcg binding rules can refer to folio_memcg().
  */
 static inline struct mem_cgroup *get_mem_cgroup_from_folio(struct folio *folio)
 {
@@ -506,22 +496,20 @@ static inline struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
  *
  * Return: A pointer to the memory cgroup associated with the folio,
  * or NULL.
+ *
+ * The folio and objcg or memcg binding rules can refer to folio_memcg().
  */
 static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
 {
 	unsigned long memcg_data = READ_ONCE(folio->memcg_data);
+	struct obj_cgroup *objcg;
 
 	VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
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
@@ -534,16 +522,10 @@ static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
  * has an associated memory cgroup pointer or an object cgroups vector or
  * an object cgroup.
  *
- * For a non-kmem page any of the following ensures page and memcg binding
- * stability:
+ * The page and objcg or memcg binding rules can refer to page_memcg().
  *
- * - the page lock
- * - LRU isolation
- * - lock_page_memcg()
- * - exclusive reference
- *
- * For a kmem page a caller should hold an rcu read lock to protect memcg
- * associated with a kmem page from being released.
+ * A caller should hold an rcu read lock to protect memcg associated with a
+ * page from being released.
  */
 static inline struct mem_cgroup *page_memcg_check(struct page *page)
 {
@@ -552,18 +534,14 @@ static inline struct mem_cgroup *page_memcg_check(struct page *page)
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
index 22fbf2c74d49..731e1b894407 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -499,6 +499,8 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 }
 
 #ifdef CONFIG_MEMCG
+static struct shrinker deferred_split_shrinker;
+
 static inline struct mem_cgroup *split_queue_memcg(struct deferred_split *queue)
 {
 	if (mem_cgroup_disabled())
@@ -512,6 +514,46 @@ static inline struct deferred_split *folio_memcg_split_queue(struct folio *folio
 
 	return memcg ? &memcg->deferred_split_queue : NULL;
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
+const struct memcg_reparent_ops split_queue_reparent_ops = {
+	.lock		= memcg_reparent_split_queue_lock,
+	.unlock		= memcg_reparent_split_queue_unlock,
+	.reparent	= memcg_reparent_split_queue,
+};
 #else
 static inline struct mem_cgroup *split_queue_memcg(struct deferred_split *queue)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8cfb4221c36a..52a878081452 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -75,6 +75,7 @@ struct cgroup_subsys memory_cgrp_subsys __read_mostly;
 EXPORT_SYMBOL(memory_cgrp_subsys);
 
 struct mem_cgroup *root_mem_cgroup __read_mostly;
+static struct obj_cgroup *root_obj_cgroup __read_mostly;
 
 /* Active memory cgroup to use from an interrupt context */
 DEFINE_PER_CPU(struct mem_cgroup *, int_active_memcg);
@@ -263,6 +264,11 @@ struct mem_cgroup *vmpressure_to_memcg(struct vmpressure *vmpr)
 
 extern spinlock_t css_set_lock;
 
+static inline bool obj_cgroup_is_root(struct obj_cgroup *objcg)
+{
+	return objcg == root_obj_cgroup;
+}
+
 bool mem_cgroup_kmem_disabled(void)
 {
 	return cgroup_memory_nokmem;
@@ -344,7 +350,81 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
 	return objcg;
 }
 
-static const struct memcg_reparent_ops *memcg_reparent_ops[] = {};
+static void memcg_reparent_lruvec_lock(struct mem_cgroup *memcg,
+				       struct mem_cgroup *parent)
+{
+	int i;
+
+	for_each_node(i) {
+		spin_lock(&mem_cgroup_lruvec(memcg, NODE_DATA(i))->lru_lock);
+		spin_lock(&mem_cgroup_lruvec(parent, NODE_DATA(i))->lru_lock);
+	}
+}
+
+static void memcg_reparent_lruvec_unlock(struct mem_cgroup *memcg,
+					 struct mem_cgroup *parent)
+{
+	int i;
+
+	for_each_node(i) {
+		spin_unlock(&mem_cgroup_lruvec(parent, NODE_DATA(i))->lru_lock);
+		spin_unlock(&mem_cgroup_lruvec(memcg, NODE_DATA(i))->lru_lock);
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
+	int i;
+
+	for_each_node(i) {
+		enum lru_list lru;
+		struct lruvec *src, *dst;
+
+		src = mem_cgroup_lruvec(memcg, NODE_DATA(i));
+		dst = mem_cgroup_lruvec(parent, NODE_DATA(i));
+
+		dst->anon_cost += src->anon_cost;
+		dst->file_cost += src->file_cost;
+
+		for_each_lru(lru)
+			lruvec_reparent_lru(src, dst, lru);
+	}
+}
+
+static const struct memcg_reparent_ops lruvec_reparent_ops = {
+	.lock		= memcg_reparent_lruvec_lock,
+	.unlock		= memcg_reparent_lruvec_unlock,
+	.reparent	= memcg_reparent_lruvec,
+};
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+extern struct memcg_reparent_ops split_queue_reparent_ops;
+#endif
+
+static const struct memcg_reparent_ops *memcg_reparent_ops[] = {
+	&lruvec_reparent_ops,
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	&split_queue_reparent_ops,
+#endif
+};
 
 static void memcg_reparent_lock(struct mem_cgroup *memcg,
 				struct mem_cgroup *parent)
@@ -2799,18 +2879,18 @@ static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
 }
 #endif
 
-static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
+static void commit_charge(struct folio *folio, struct obj_cgroup *objcg)
 {
-	VM_BUG_ON_FOLIO(folio_memcg(folio), folio);
+	VM_BUG_ON_FOLIO(folio_objcg(folio), folio);
 	/*
-	 * Any of the following ensures page's memcg stability:
+	 * Any of the following ensures page's objcg stability:
 	 *
 	 * - the page lock
 	 * - LRU isolation
 	 * - lock_page_memcg()
 	 * - exclusive reference
 	 */
-	folio->memcg_data = (unsigned long)memcg;
+	folio->memcg_data = (unsigned long)objcg;
 }
 
 static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
@@ -2827,6 +2907,21 @@ static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
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
 /*
  * The allocated objcg pointers array is not accounted directly.
@@ -2932,12 +3027,15 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
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
@@ -3081,13 +3179,13 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
 void __memcg_kmem_uncharge_page(struct page *page, int order)
 {
 	struct folio *folio = page_folio(page);
-	struct obj_cgroup *objcg;
+	struct obj_cgroup *objcg = folio_objcg(folio);
 	unsigned int nr_pages = 1 << order;
 
-	if (!folio_memcg_kmem(folio))
+	if (!objcg)
 		return;
 
-	objcg = __folio_objcg(folio);
+	VM_BUG_ON_FOLIO(!folio_memcg_kmem(folio), folio);
 	obj_cgroup_uncharge_pages(objcg, nr_pages);
 	folio->memcg_data = 0;
 	obj_cgroup_put(objcg);
@@ -3319,24 +3417,21 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
 #endif /* CONFIG_MEMCG_KMEM */
 
 /*
- * Because page_memcg(head) is not set on tails, set it now.
+ * Because page_objcg(head) is not set on tails, set it now.
  */
 void split_page_memcg(struct page *head, unsigned int nr)
 {
 	struct folio *folio = page_folio(head);
-	struct mem_cgroup *memcg = folio_memcg(folio);
+	struct obj_cgroup *objcg = folio_objcg(folio);
 	int i;
 
-	if (mem_cgroup_disabled() || !memcg)
+	if (mem_cgroup_disabled() || !objcg)
 		return;
 
 	for (i = 1; i < nr; i++)
 		folio_page(folio, i)->memcg_data = folio->memcg_data;
 
-	if (folio_memcg_kmem(folio))
-		obj_cgroup_get_many(__folio_objcg(folio), nr - 1);
-	else
-		css_get_many(&memcg->css, nr - 1);
+	obj_cgroup_get_many(objcg, nr - 1);
 }
 
 #ifdef CONFIG_MEMCG_SWAP
@@ -5306,6 +5401,9 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	objcg->memcg = memcg;
 	rcu_assign_pointer(memcg->objcg, objcg);
 
+	if (unlikely(mem_cgroup_is_root(memcg)))
+		root_obj_cgroup = objcg;
+
 	/* Online state pins memcg ID, memcg ID pins CSS */
 	refcount_set(&memcg->id.ref, 1);
 	css_get(css);
@@ -5735,10 +5833,10 @@ static int mem_cgroup_move_account(struct page *page,
 	 */
 	smp_mb();
 
-	css_get(&to->css);
-	css_put(&from->css);
+	obj_cgroup_get(to->objcg);
+	obj_cgroup_put(from->objcg);
 
-	folio->memcg_data = (unsigned long)to;
+	folio->memcg_data = (unsigned long)to->objcg;
 
 	__folio_memcg_unlock(from);
 
@@ -6211,6 +6309,42 @@ static void mem_cgroup_move_charge(void)
 
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
+	 *					    memcg = folio_memcg()
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
+	 *					    memcg = folio_memcg() <== memcg has been changed
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
@@ -6768,21 +6902,26 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
 			gfp_t gfp)
 {
+	struct obj_cgroup *objcg;
 	long nr_pages = folio_nr_pages(folio);
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
-	commit_charge(folio, memcg);
+	obj_cgroup_get(objcg);
+	commit_charge(folio, objcg);
 
 	local_irq_disable();
 	mem_cgroup_charge_statistics(memcg, nr_pages);
 	memcg_check_events(memcg, folio_nid(folio));
 	local_irq_enable();
 out:
+	obj_cgroup_put(objcg);
 	return ret;
 }
 
@@ -6882,7 +7021,7 @@ void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry)
 }
 
 struct uncharge_gather {
-	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
 	unsigned long nr_memory;
 	unsigned long pgpgout;
 	unsigned long nr_kmem;
@@ -6897,84 +7036,73 @@ static inline void uncharge_gather_clear(struct uncharge_gather *ug)
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
-	memcg_check_events(ug->memcg, ug->nid);
+	__count_memcg_events(memcg, PGPGOUT, ug->pgpgout);
+	__this_cpu_add(memcg->vmstats_percpu->nr_page_events, ug->nr_memory);
+	memcg_check_events(memcg, ug->nid);
 	local_irq_restore(flags);
+	rcu_read_unlock();
 
 	/* drop reference from uncharge_folio */
-	css_put(&ug->memcg->css);
+	css_put(&memcg->css);
+	obj_cgroup_put(ug->objcg);
 }
 
 static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
 {
 	long nr_pages;
-	struct mem_cgroup *memcg;
 	struct obj_cgroup *objcg;
-	bool use_objcg = folio_memcg_kmem(folio);
 
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 
 	/*
 	 * Nobody should be changing or seriously looking at
-	 * folio memcg or objcg at this point, we have fully
-	 * exclusive access to the folio.
+	 * folio objcg at this point, we have fully exclusive
+	 * access to the folio.
 	 */
-	if (use_objcg) {
-		objcg = __folio_objcg(folio);
-		/*
-		 * This get matches the put at the end of the function and
-		 * kmem pages do not hold memcg references anymore.
-		 */
-		memcg = get_mem_cgroup_from_objcg(objcg);
-	} else {
-		memcg = __folio_memcg(folio);
-	}
-
-	if (!memcg)
+	objcg = folio_objcg(folio);
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
 		ug->nid = folio_nid(folio);
 
-		/* pairs with css_put in uncharge_batch */
-		css_get(&memcg->css);
+		/* pairs with obj_cgroup_put in uncharge_batch */
+		obj_cgroup_get(objcg);
 	}
 
 	nr_pages = folio_nr_pages(folio);
 
-	if (use_objcg) {
+	if (folio_memcg_kmem(folio)) {
 		ug->nr_memory += nr_pages;
 		ug->nr_kmem += nr_pages;
-
-		folio->memcg_data = 0;
-		obj_cgroup_put(objcg);
 	} else {
 		/* LRU pages aren't accounted at the root level */
-		if (!mem_cgroup_is_root(memcg))
+		if (!obj_cgroup_is_root(objcg))
 			ug->nr_memory += nr_pages;
 		ug->pgpgout++;
-
-		folio->memcg_data = 0;
 	}
 
-	css_put(&memcg->css);
+	folio->memcg_data = 0;
+	obj_cgroup_put(objcg);
 }
 
 /**
@@ -6988,7 +7116,7 @@ void __mem_cgroup_uncharge(struct folio *folio)
 	struct uncharge_gather ug;
 
 	/* Don't touch folio->lru of any random page, pre-check: */
-	if (!folio_memcg(folio))
+	if (!folio_objcg(folio))
 		return;
 
 	uncharge_gather_clear(&ug);
@@ -7011,7 +7139,7 @@ void __mem_cgroup_uncharge_list(struct list_head *page_list)
 	uncharge_gather_clear(&ug);
 	list_for_each_entry(folio, page_list, lru)
 		uncharge_folio(folio, &ug);
-	if (ug.memcg)
+	if (ug.objcg)
 		uncharge_batch(&ug);
 }
 
@@ -7028,6 +7156,7 @@ void __mem_cgroup_uncharge_list(struct list_head *page_list)
 void mem_cgroup_migrate(struct folio *old, struct folio *new)
 {
 	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
 	long nr_pages = folio_nr_pages(new);
 	unsigned long flags;
 
@@ -7040,30 +7169,33 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
 		return;
 
 	/* Page cache replacement: new folio already charged? */
-	if (folio_memcg(new))
+	if (folio_objcg(new))
 		return;
 
-	memcg = get_mem_cgroup_from_folio(old);
-	VM_WARN_ON_ONCE_FOLIO(!memcg, old);
-	if (!memcg)
+	objcg = folio_objcg(old);
+	VM_WARN_ON_ONCE_FOLIO(!objcg, old);
+	if (!objcg)
 		return;
 
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(objcg);
+
 	/* Force-charge the new page. The old one will be freed soon */
-	if (!mem_cgroup_is_root(memcg)) {
+	if (!obj_cgroup_is_root(objcg)) {
 		page_counter_charge(&memcg->memory, nr_pages);
 		if (do_memsw_account())
 			page_counter_charge(&memcg->memsw, nr_pages);
 	}
 
-	css_get(&memcg->css);
-	commit_charge(new, memcg);
+	obj_cgroup_get(objcg);
+	commit_charge(new, objcg);
 
 	local_irq_save(flags);
 	mem_cgroup_charge_statistics(memcg, nr_pages);
 	memcg_check_events(memcg, folio_nid(new));
 	local_irq_restore(flags);
 
-	css_put(&memcg->css);
+	rcu_read_unlock();
 }
 
 DEFINE_STATIC_KEY_FALSE(memcg_sockets_enabled_key);
@@ -7240,6 +7372,7 @@ static struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg)
 void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 {
 	struct mem_cgroup *memcg, *swap_memcg;
+	struct obj_cgroup *objcg;
 	unsigned int nr_entries;
 	unsigned short oldid;
 
@@ -7252,15 +7385,16 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return;
 
+	objcg = folio_objcg(page_folio(page));
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
@@ -7279,7 +7413,7 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 
 	page->memcg_data = 0;
 
-	if (!mem_cgroup_is_root(memcg))
+	if (!obj_cgroup_is_root(objcg))
 		page_counter_uncharge(&memcg->memory, nr_entries);
 
 	if (!cgroup_memory_noswap && memcg != swap_memcg) {
@@ -7298,7 +7432,7 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	mem_cgroup_charge_statistics(memcg, -nr_entries);
 	memcg_check_events(memcg, page_to_nid(page));
 
-	css_put(&memcg->css);
+	obj_cgroup_put(objcg);
 }
 
 /**
-- 
2.11.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16B632BAD7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352042AbhCCMFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1451345AbhCCGCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 01:02:49 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478C7C06178B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 22:02:09 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u18so7250044plc.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 22:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oplEqh5eV2GZ+vXN8Na+NKbtehy1/4Xwc42h7dUdrAs=;
        b=zwjWBgnKKdx3RtGLqjpG50StX1guMHqcNEGEkmnoPezr6dlSyKy1KHrlCKV2e5x+FM
         ZYfy+XWMsQ0MTGFzY6D9CfN7USKbaz5ulvFP4mOsbYmEAIWEvWUWRx9vLYbOR7tFEsNE
         1aopf71zceWMqhcynUBb2GKAHxV+T8sbfm0VCReDzsNua8Qro2YBdWfZecPX/OahFS3e
         CMyAK08ESRbD3JlWZLMFAs4p14EQ8zGYGc0Zbs/fQ/bsAIxJ4pRx+UjTURoOWep0Mias
         BSkz6yamu9RZT8AFm8yVZu+dCwenY5U8zd+dfajOJcbzTTRiQVSo58DQD9Zxr7EnOja+
         +8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oplEqh5eV2GZ+vXN8Na+NKbtehy1/4Xwc42h7dUdrAs=;
        b=W6+jFMfIa0iFn2rhoOjYntJSbPclNFnQBSr1mr3WjEk0HsJzgetnfiE9oPDfd+YVHp
         In5RrsNb6DjA8vPL7MrTSL//c1IsPAO61z/y9kXM2SuO+yTeit3kM+yhRnqLtI8SGwef
         VaL8KKjeiShldOZbS3IGTJ8z8Zg4jDcRxrgK7KxLe5cXAL4dgHdqOfFUUkcT+k90t7iN
         q5Cw0pUwYNsZNjjOrPS/iemyS5wcK09+0sIkV73KcUtjRcF1ZZmU0FY+qYYN3xiuHoA+
         /PG3jXh02WDza4+Hkx7JaZnBJ7jYuu/dlPZP64GG8m0+8es8FbcAzZjf+mllenPo667t
         NP7g==
X-Gm-Message-State: AOAM531KIDlktOJpYLuidtN3LC0ZYiR9Y61bBx0FxLX99MYwTOccHe1d
        MK81CzYk6+fVvqiEQfmL9eFqeQ==
X-Google-Smtp-Source: ABdhPJxaErlSOSFTBuKKDyN0xxNxqhWv8qVqBdvv08tIooh0PWvnlvd2ps190khBgEnpHSR08l+kpQ==
X-Received: by 2002:a17:903:304e:b029:e5:d43:9415 with SMTP id u14-20020a170903304eb02900e50d439415mr6858937pla.42.1614751328502;
        Tue, 02 Mar 2021 22:02:08 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id x11sm6131088pjh.0.2021.03.02.22.02.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Mar 2021 22:02:08 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 3/5] mm: memcontrol: charge kmem pages by using obj_cgroup APIs
Date:   Wed,  3 Mar 2021 13:59:15 +0800
Message-Id: <20210303055917.66054-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210303055917.66054-1-songmuchun@bytedance.com>
References: <20210303055917.66054-1-songmuchun@bytedance.com>
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
 include/linux/memcontrol.h |  63 +++++++++++++++++------
 mm/memcontrol.c            | 123 +++++++++++++++++++++++++++++++--------------
 2 files changed, 133 insertions(+), 53 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 049b80246cbf..5911b9d107b0 100644
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
@@ -421,9 +433,10 @@ static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
  * @page: a pointer to the page struct
  *
  * Returns a pointer to the memory cgroup associated with the page,
- * or NULL. This function unlike page_memcg() can take any  page
+ * or NULL. This function unlike page_memcg() can take any non-kmem page
  * as an argument. It has to be used in cases when it's not known if a page
- * has an associated memory cgroup pointer or an object cgroups vector.
+ * has an associated memory cgroup pointer or an object cgroups vector or
+ * an object cgroup.
  *
  * Any of the following ensures page and memcg binding stability:
  * - the page lock
@@ -442,6 +455,17 @@ static inline struct mem_cgroup *page_memcg_check(struct page *page)
 	if (memcg_data & MEMCG_DATA_OBJCGS)
 		return NULL;
 
+	if (memcg_data & MEMCG_DATA_KMEM) {
+		struct obj_cgroup *objcg;
+
+		/*
+		 * The caller must ensure that the returned memcg won't be
+		 * released: e.g. acquire the rcu_read_lock or css_set_lock.
+		 */
+		objcg = (void *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+		return obj_cgroup_memcg(objcg);
+	}
+
 	return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
 }
 
@@ -500,6 +524,24 @@ static inline struct obj_cgroup **page_objcgs_check(struct page *page)
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
+	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
+	VM_BUG_ON_PAGE(!(memcg_data & MEMCG_DATA_KMEM), page);
+
+	return (struct obj_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+}
 #else
 static inline struct obj_cgroup **page_objcgs(struct page *page)
 {
@@ -510,6 +552,11 @@ static inline struct obj_cgroup **page_objcgs_check(struct page *page)
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
@@ -728,18 +775,6 @@ static inline void obj_cgroup_put(struct obj_cgroup *objcg)
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
index 86a8db937ec6..0cf342d22547 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -856,10 +856,16 @@ void __mod_lruvec_page_state(struct page *page, enum node_stat_item idx,
 {
 	struct page *head = compound_head(page); /* rmap on tail pages */
 	struct mem_cgroup *memcg;
-	pg_data_t *pgdat = page_pgdat(page);
+	pg_data_t *pgdat;
 	struct lruvec *lruvec;
 
-	memcg = page_memcg_check(head);
+	if (PageMemcgKmem(head)) {
+		__mod_lruvec_kmem_state(page_to_virt(head), idx, val);
+		return;
+	}
+
+	pgdat = page_pgdat(head);
+	memcg = page_memcg(head);
 	/* Untracked pages have no memcg, no lruvec. Update only the node */
 	if (!memcg) {
 		__mod_node_page_state(pgdat, idx, val);
@@ -3144,18 +3150,18 @@ static void __memcg_kmem_uncharge(struct mem_cgroup *memcg, unsigned int nr_page
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
+		ret = obj_cgroup_charge_page(objcg, gfp, 1 << order);
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
@@ -3167,17 +3173,18 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
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
+	VM_BUG_ON_PAGE(!PageMemcgKmem(page), page);
+
+	objcg = page_objcg(page);
+	obj_cgroup_uncharge_page(objcg, nr_pages);
 	page->memcg_data = 0;
-	css_put(&memcg->css);
+	obj_cgroup_put(objcg);
 }
 
 static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
@@ -6794,8 +6801,12 @@ struct uncharge_gather {
 	struct mem_cgroup *memcg;
 	unsigned long nr_pages;
 	unsigned long pgpgout;
-	unsigned long nr_kmem;
 	struct page *dummy_page;
+
+#ifdef CONFIG_MEMCG_KMEM
+	struct obj_cgroup *objcg;
+	unsigned long nr_kmem;
+#endif
 };
 
 static inline void uncharge_gather_clear(struct uncharge_gather *ug)
@@ -6807,12 +6818,21 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 {
 	unsigned long flags;
 
+#ifdef CONFIG_MEMCG_KMEM
+	if (ug->objcg) {
+		obj_cgroup_uncharge_page(ug->objcg, ug->nr_kmem);
+		/* drop reference from uncharge_kmem_page */
+		obj_cgroup_put(ug->objcg);
+	}
+#endif
+
+	if (!ug->memcg)
+		return;
+
 	if (!mem_cgroup_is_root(ug->memcg)) {
 		page_counter_uncharge(&ug->memcg->memory, ug->nr_pages);
 		if (do_memsw_account())
 			page_counter_uncharge(&ug->memcg->memsw, ug->nr_pages);
-		if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && ug->nr_kmem)
-			page_counter_uncharge(&ug->memcg->kmem, ug->nr_kmem);
 		memcg_oom_recover(ug->memcg);
 	}
 
@@ -6822,26 +6842,40 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 	memcg_check_events(ug->memcg, ug->dummy_page);
 	local_irq_restore(flags);
 
-	/* drop reference from uncharge_page */
+	/* drop reference from uncharge_user_page */
 	css_put(&ug->memcg->css);
 }
 
-static void uncharge_page(struct page *page, struct uncharge_gather *ug)
+#ifdef CONFIG_MEMCG_KMEM
+static void uncharge_kmem_page(struct page *page, struct uncharge_gather *ug)
 {
-	unsigned long nr_pages;
-	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg = page_objcg(page);
 
-	VM_BUG_ON_PAGE(PageLRU(page), page);
+	if (ug->objcg != objcg) {
+		if (ug->objcg) {
+			uncharge_batch(ug);
+			uncharge_gather_clear(ug);
+		}
+		ug->objcg = objcg;
 
-	if (!page_memcg_charged(page))
-		return;
+		/* pairs with obj_cgroup_put in uncharge_batch */
+		obj_cgroup_get(ug->objcg);
+	}
+
+	ug->nr_kmem += compound_nr(page);
+	page->memcg_data = 0;
+	obj_cgroup_put(ug->objcg);
+}
+#else
+static void uncharge_kmem_page(struct page *page, struct uncharge_gather *ug)
+{
+}
+#endif
+
+static void uncharge_user_page(struct page *page, struct uncharge_gather *ug)
+{
+	struct mem_cgroup *memcg = page_memcg(page);
 
-	/*
-	 * Nobody should be changing or seriously looking at
-	 * page memcg at this point, we have fully exclusive
-	 * access to the page.
-	 */
-	memcg = page_memcg_check(page);
 	if (ug->memcg != memcg) {
 		if (ug->memcg) {
 			uncharge_batch(ug);
@@ -6852,18 +6886,30 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 		/* pairs with css_put in uncharge_batch */
 		css_get(&ug->memcg->css);
 	}
+	ug->pgpgout++;
+	ug->dummy_page = page;
+
+	ug->nr_pages += compound_nr(page);
+	page->memcg_data = 0;
+	css_put(&ug->memcg->css);
+}
 
-	nr_pages = compound_nr(page);
-	ug->nr_pages += nr_pages;
+static void uncharge_page(struct page *page, struct uncharge_gather *ug)
+{
+	VM_BUG_ON_PAGE(PageLRU(page), page);
 
+	if (!page_memcg_charged(page))
+		return;
+
+	/*
+	 * Nobody should be changing or seriously looking at
+	 * page memcg at this point, we have fully exclusive
+	 * access to the page.
+	 */
 	if (PageMemcgKmem(page))
-		ug->nr_kmem += nr_pages;
+		uncharge_kmem_page(page, ug);
 	else
-		ug->pgpgout++;
-
-	ug->dummy_page = page;
-	page->memcg_data = 0;
-	css_put(&ug->memcg->css);
+		uncharge_user_page(page, ug);
 }
 
 /**
@@ -6906,8 +6952,7 @@ void mem_cgroup_uncharge_list(struct list_head *page_list)
 	uncharge_gather_clear(&ug);
 	list_for_each_entry(page, page_list, lru)
 		uncharge_page(page, &ug);
-	if (ug.memcg)
-		uncharge_batch(&ug);
+	uncharge_batch(&ug);
 }
 
 /**
-- 
2.11.0


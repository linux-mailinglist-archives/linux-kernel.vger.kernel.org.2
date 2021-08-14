Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6923EC0AF
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 07:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237224AbhHNF0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 01:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbhHNF0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 01:26:41 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F3CC061757
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 22:26:14 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n12so14020532plf.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 22:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cLAFvnxBwAS7OeMZn1+Mlgsj6/dWmzUoMkU4Bk0iQeY=;
        b=fDKQNUhcmgyaHZCVlmnB0/iiINhLlpxL6R9WPDEpkg934YtIERrYga13/x7PvHSC6F
         EA7QHEaYs8xAzL/lcu5hwCwIKj+sUEleXXkwaGnNyFQejkT8KCUDqPMSf57Ly5r4N5Vn
         Df1eJ89uKsRJRfutIU7p8+g8f08nC8xdMfPfeU2MnrPn4uqWaIjtDqtJ6vuovcOEZkYh
         q8uYCWkpvsjUsmiPVUC3bcHrMsIefYWLGYyDaQspo+gAAWAfeOO6FZ3gExg1AMY2d1kg
         l4eh2nvGMzjLgTTBi87W8zJ//3p4ICK/GRk0OpULPPpWuyL9EKmocxKdTaxuDij5BjQh
         j1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cLAFvnxBwAS7OeMZn1+Mlgsj6/dWmzUoMkU4Bk0iQeY=;
        b=nldIH+9B+GM5sZTOxsRCkZEa1vLoHK+emtSFYTVA8WKr+v01m9+hF1cjKfofAQtsQY
         kdsR3AjvMDL8VXPree4kuuw/UlNqe0yOucD/5DV2wMPjA15gXCyWtek9whXQ8E862zXM
         B51X575EWQC4mEmcnyYy4g/CasdaqLeOj/M0NZaa7qEWcVp9m17h7edyvMQiHyRNeihN
         /O/3mWLafP6ac4l85SL/OHp4spa8zGJYV5uKXtZvzE7Yhw5jaEGhCEBIjPyqJ0Ca4/S9
         anpd8RbVQyUnw7nrhHskL4YDzOzOBayoq6YjNSt6Q3POOuB+6lXfyJGTTWUmk7/ortSe
         RuzA==
X-Gm-Message-State: AOAM531F5/uuzQu7b8Gt+301YIG7+RfmANUK0Q0n38ejeYK28Y0tq4Nt
        X1kxriOxQapOP1iSM86jtspujQ==
X-Google-Smtp-Source: ABdhPJzevd6zylVsIAlF2bw09yp/DrKlvr3k0eBij2UZzNZc6xjkh+vyPo9OVFI/xZ9rSPOxorAGJg==
X-Received: by 2002:a65:524a:: with SMTP id q10mr5480742pgp.97.1628918773654;
        Fri, 13 Aug 2021 22:26:13 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id s5sm4783133pgp.81.2021.08.13.22.26.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Aug 2021 22:26:13 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v1 07/12] mm: memcontrol: make all the callers of {folio,page}_memcg() safe
Date:   Sat, 14 Aug 2021 13:25:14 +0800
Message-Id: <20210814052519.86679-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210814052519.86679-1-songmuchun@bytedance.com>
References: <20210814052519.86679-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we use objcg APIs to charge the LRU pages, the page will not hold
a reference to the memcg associated with the page. So the caller of the
{folio,page}_memcg() should hold an rcu read lock or obtain a reference
to the memcg associated with the page to protect memcg from being
released. So introduce get_mem_cgroup_from_{page,folio}() to obtain a
reference to the memory cgroup associated with the page.

In this patch, make all the callers hold an rcu read lock or obtain a
reference to the memcg to protect memcg from being released when the LRU
pages reparented.

We do not need to adjust the callers of {folio,page}_memcg() during
the whole process of mem_cgroup_move_task(). Because the cgroup migration
and memory cgroup offlining are serialized by @cgroup_mutex. In this
routine, the LRU pages cannot be reparented to its parent memory cgroup.
So {folio,page}_memcg() is stable and cannot be released.

This is a preparation for reparenting the LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/buffer.c                |  3 ++-
 fs/fs-writeback.c          | 23 +++++++++++----------
 include/linux/memcontrol.h | 49 ++++++++++++++++++++++++++++++++++++++++++---
 mm/memcontrol.c            | 50 ++++++++++++++++++++++++++++++++++++----------
 mm/migrate.c               |  4 ++++
 mm/page_io.c               |  5 +++--
 6 files changed, 106 insertions(+), 28 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index f5384cff7e0c..88123f84885a 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -823,7 +823,7 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 		gfp |= __GFP_NOFAIL;
 
 	/* The page lock pins the memcg */
-	memcg = page_memcg(page);
+	memcg = get_mem_cgroup_from_page(page);
 	old_memcg = set_active_memcg(memcg);
 
 	head = NULL;
@@ -843,6 +843,7 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 		set_bh_page(bh, page, offset);
 	}
 out:
+	mem_cgroup_put(memcg);
 	set_active_memcg(old_memcg);
 	return head;
 /*
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 81ec192ce067..d9a67fffcc78 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -243,15 +243,13 @@ void __inode_attach_wb(struct inode *inode, struct page *page)
 	if (inode_cgwb_enabled(inode)) {
 		struct cgroup_subsys_state *memcg_css;
 
-		if (page) {
-			memcg_css = mem_cgroup_css_from_page(page);
-			wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
-		} else {
-			/* must pin memcg_css, see wb_get_create() */
+		/* must pin memcg_css, see wb_get_create() */
+		if (page)
+			memcg_css = get_mem_cgroup_css_from_page(page);
+		else
 			memcg_css = task_get_css(current, memory_cgrp_id);
-			wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
-			css_put(memcg_css);
-		}
+		wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
+		css_put(memcg_css);
 	}
 
 	if (!wb)
@@ -866,16 +864,16 @@ void wbc_account_cgroup_owner(struct writeback_control *wbc, struct page *page,
 	if (!wbc->wb || wbc->no_cgroup_owner)
 		return;
 
-	css = mem_cgroup_css_from_page(page);
+	css = get_mem_cgroup_css_from_page(page);
 	/* dead cgroups shouldn't contribute to inode ownership arbitration */
 	if (!(css->flags & CSS_ONLINE))
-		return;
+		goto out;
 
 	id = css->id;
 
 	if (id == wbc->wb_id) {
 		wbc->wb_bytes += bytes;
-		return;
+		goto out;
 	}
 
 	if (id == wbc->wb_lcand_id)
@@ -888,6 +886,9 @@ void wbc_account_cgroup_owner(struct writeback_control *wbc, struct page *page,
 		wbc->wb_tcand_bytes += bytes;
 	else
 		wbc->wb_tcand_bytes -= min(bytes, wbc->wb_tcand_bytes);
+
+out:
+	css_put(css);
 }
 EXPORT_SYMBOL_GPL(wbc_account_cgroup_owner);
 
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 5a8f85bd9bbf..431fc606f6f9 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -378,7 +378,7 @@ static inline bool folio_memcg_kmem(struct folio *folio);
  * a valid memcg, but can be atomically swapped to the parent memcg.
  *
  * The caller must ensure that the returned memcg won't be released:
- * e.g. acquire the rcu_read_lock or css_set_lock.
+ * e.g. acquire the rcu_read_lock or css_set_lock or cgroup_mutex.
  */
 static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg)
 {
@@ -460,6 +460,36 @@ static inline struct mem_cgroup *page_memcg(struct page *page)
 }
 
 /*
+ * get_mem_cgroup_from_folio - Obtain a reference on the memory cgroup
+ *			       associated with a folio.
+ * @folio: Pointer to the folio.
+ *
+ * Returns a pointer to the memory cgroup (and obtain a reference on it)
+ * associated with the folio, or NULL. This function assumes that the
+ * folio is known to have a proper memory cgroup pointer. It's not safe
+ * to call this function against some type of pages, e.g. slab pages or
+ * ex-slab pages.
+ */
+static inline struct mem_cgroup *get_mem_cgroup_from_folio(struct folio *folio)
+{
+	struct mem_cgroup *memcg;
+
+	rcu_read_lock();
+retry:
+	memcg = folio_memcg(folio);
+	if (unlikely(memcg && !css_tryget(&memcg->css)))
+		goto retry;
+	rcu_read_unlock();
+
+	return memcg;
+}
+
+static inline struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
+{
+	return get_mem_cgroup_from_folio(page_folio(page));
+}
+
+/*
  * folio_memcg_rcu - Locklessly get the memory cgroup associated with a folio.
  * @folio: Pointer to the folio.
  *
@@ -893,7 +923,7 @@ static inline bool mm_match_cgroup(struct mm_struct *mm,
 	return match;
 }
 
-struct cgroup_subsys_state *mem_cgroup_css_from_page(struct page *page);
+struct cgroup_subsys_state *get_mem_cgroup_css_from_page(struct page *page);
 ino_t page_cgroup_ino(struct page *page);
 
 static inline bool mem_cgroup_online(struct mem_cgroup *memcg)
@@ -1051,10 +1081,13 @@ static inline void count_memcg_events(struct mem_cgroup *memcg,
 static inline void count_memcg_page_event(struct page *page,
 					  enum vm_event_item idx)
 {
-	struct mem_cgroup *memcg = page_memcg(page);
+	struct mem_cgroup *memcg;
 
+	rcu_read_lock();
+	memcg = page_memcg(page);
 	if (memcg)
 		count_memcg_events(memcg, idx, 1);
+	rcu_read_unlock();
 }
 
 static inline void count_memcg_event_mm(struct mm_struct *mm,
@@ -1133,6 +1166,16 @@ static inline struct mem_cgroup *page_memcg(struct page *page)
 	return NULL;
 }
 
+static inline struct mem_cgroup *get_mem_cgroup_from_folio(struct folio *folio)
+{
+	return NULL;
+}
+
+static inline struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
+{
+	return NULL;
+}
+
 static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
 {
 	WARN_ON_ONCE(!rcu_read_lock_held());
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7955da38e385..0eca3cf6cede 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -424,7 +424,7 @@ EXPORT_SYMBOL(memcg_kmem_enabled_key);
 #endif
 
 /**
- * mem_cgroup_css_from_page - css of the memcg associated with a page
+ * get_mem_cgroup_css_from_page - get css of the memcg associated with a page
  * @page: page of interest
  *
  * If memcg is bound to the default hierarchy, css of the memcg associated
@@ -434,13 +434,15 @@ EXPORT_SYMBOL(memcg_kmem_enabled_key);
  * If memcg is bound to a traditional hierarchy, the css of root_mem_cgroup
  * is returned.
  */
-struct cgroup_subsys_state *mem_cgroup_css_from_page(struct page *page)
+struct cgroup_subsys_state *get_mem_cgroup_css_from_page(struct page *page)
 {
 	struct mem_cgroup *memcg;
 
-	memcg = page_memcg(page);
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return &root_mem_cgroup->css;
 
-	if (!memcg || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
+	memcg = get_mem_cgroup_from_page(page);
+	if (!memcg)
 		memcg = root_mem_cgroup;
 
 	return &memcg->css;
@@ -1983,7 +1985,9 @@ void folio_memcg_lock(struct folio *folio)
 	 * The RCU lock is held throughout the transaction.  The fast
 	 * path can get away without acquiring the memcg->move_lock
 	 * because page moving starts with an RCU grace period.
-         */
+	 *
+	 * The RCU lock also protects the memcg from being freed.
+	 */
 	rcu_read_lock();
 
 	if (mem_cgroup_disabled())
@@ -4553,7 +4557,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 void mem_cgroup_track_foreign_dirty_slowpath(struct folio *folio,
 					     struct bdi_writeback *wb)
 {
-	struct mem_cgroup *memcg = folio_memcg(folio);
+	struct mem_cgroup *memcg = get_mem_cgroup_from_folio(folio);
 	struct memcg_cgwb_frn *frn;
 	u64 now = get_jiffies_64();
 	u64 oldest_at = now;
@@ -4600,6 +4604,7 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct folio *folio,
 		frn->memcg_id = wb->memcg_css->id;
 		frn->at = now;
 	}
+	css_put(&memcg->css);
 }
 
 /* issue foreign writeback flushes for recorded foreign dirtying events */
@@ -6169,6 +6174,14 @@ static void mem_cgroup_move_charge(void)
 	atomic_dec(&mc.from->moving_account);
 }
 
+/*
+ * The cgroup migration and memory cgroup offlining are serialized by
+ * @cgroup_mutex. If we reach here, it means that the LRU pages cannot
+ * be reparented to its parent memory cgroup. So during the whole process
+ * of mem_cgroup_move_task(), page_memcg(page) is stable. So we do not
+ * need to worry about the memcg (returned from page_memcg()) being
+ * released even if we do not hold an rcu read lock.
+ */
 static void mem_cgroup_move_task(void)
 {
 	if (mc.to) {
@@ -6991,7 +7004,7 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
 	if (folio_memcg(new))
 		return;
 
-	memcg = folio_memcg(old);
+	memcg = get_mem_cgroup_from_folio(old);
 	VM_WARN_ON_ONCE_FOLIO(!memcg, old);
 	if (!memcg)
 		return;
@@ -7010,6 +7023,8 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
 	mem_cgroup_charge_statistics(memcg, nr_pages);
 	memcg_check_events(memcg, folio_nid(new));
 	local_irq_restore(flags);
+
+	css_put(&memcg->css);
 }
 
 DEFINE_STATIC_KEY_FALSE(memcg_sockets_enabled_key);
@@ -7198,6 +7213,10 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return;
 
+	/*
+	 * Interrupts should be disabled by the caller (see the comments below),
+	 * which can serve as RCU read-side critical sections.
+	 */
 	memcg = page_memcg(page);
 
 	VM_WARN_ON_ONCE_PAGE(!memcg, page);
@@ -7262,15 +7281,16 @@ int __mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return 0;
 
+	rcu_read_lock();
 	memcg = page_memcg(page);
 
 	VM_WARN_ON_ONCE_PAGE(!memcg, page);
 	if (!memcg)
-		return 0;
+		goto out;
 
 	if (!entry.val) {
 		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
-		return 0;
+		goto out;
 	}
 
 	memcg = mem_cgroup_id_get_online(memcg);
@@ -7280,6 +7300,7 @@ int __mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 		memcg_memory_event(memcg, MEMCG_SWAP_MAX);
 		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
 		mem_cgroup_id_put(memcg);
+		rcu_read_unlock();
 		return -ENOMEM;
 	}
 
@@ -7289,6 +7310,8 @@ int __mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 	oldid = swap_cgroup_record(entry, mem_cgroup_id(memcg), nr_pages);
 	VM_BUG_ON_PAGE(oldid, page);
 	mod_memcg_state(memcg, MEMCG_SWAP, nr_pages);
+out:
+	rcu_read_unlock();
 
 	return 0;
 }
@@ -7343,17 +7366,22 @@ bool mem_cgroup_swap_full(struct page *page)
 	if (cgroup_memory_noswap || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return false;
 
+	rcu_read_lock();
 	memcg = page_memcg(page);
 	if (!memcg)
-		return false;
+		goto out;
 
 	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
 		unsigned long usage = page_counter_read(&memcg->swap);
 
 		if (usage * 2 >= READ_ONCE(memcg->swap.high) ||
-		    usage * 2 >= READ_ONCE(memcg->swap.max))
+		    usage * 2 >= READ_ONCE(memcg->swap.max)) {
+			rcu_read_unlock();
 			return true;
+		}
 	}
+out:
+	rcu_read_unlock();
 
 	return false;
 }
diff --git a/mm/migrate.c b/mm/migrate.c
index 7a03a61bbcd8..cc7f5ecfd4a2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -473,6 +473,10 @@ int folio_migrate_mapping(struct address_space *mapping,
 		struct lruvec *old_lruvec, *new_lruvec;
 		struct mem_cgroup *memcg;
 
+		/*
+		 * Irq is disabled, which can serve as RCU read-side critical
+		 * sections.
+		 */
 		memcg = folio_memcg(folio);
 		old_lruvec = mem_cgroup_lruvec(memcg, oldzone->zone_pgdat);
 		new_lruvec = mem_cgroup_lruvec(memcg, newzone->zone_pgdat);
diff --git a/mm/page_io.c b/mm/page_io.c
index d597bc6e6e45..63014c61932a 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -269,13 +269,14 @@ static void bio_associate_blkg_from_page(struct bio *bio, struct page *page)
 	struct cgroup_subsys_state *css;
 	struct mem_cgroup *memcg;
 
+	rcu_read_lock();
 	memcg = page_memcg(page);
 	if (!memcg)
-		return;
+		goto out;
 
-	rcu_read_lock();
 	css = cgroup_e_css(memcg->css.cgroup, &io_cgrp_subsys);
 	bio_associate_blkg_from_css(bio, css);
+out:
 	rcu_read_unlock();
 }
 #else
-- 
2.11.0


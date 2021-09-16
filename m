Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3775340DBCC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240464AbhIPNyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237892AbhIPNyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:54:17 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB26C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:52:56 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id k23so4634443pji.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ajm3Sm96cZ8KFQqJftDUm/AAk++NS7Ihs73gDHBkIWY=;
        b=QVUY+1OybzlFTfcaJhZKd4XnKFBIxQNhIt9gdvnlhD1mLF8sr4WZznxvmUJt7vwgY1
         Of5WlJDOoRdb2XoAHGdb8pR9Dh5B6DfIDy11sEM7xmK3Io1y2eXN7+QBfnu0b4iI4YXq
         KdIZjfscX0b4xe+lQs0SL10VUNfiBGfvWY02PBaerAEbrs8rGwDPAdBJIb4TlWL5wmDY
         v6CMsZ5OKN0FI/G9G4gaDCvgvscEOIwzdfT96ayVH2QVWyz4xm5CovLrW68kOCWCoRqx
         PDdZ0e1v4b1HIxjXc6RH0ZiXLkxCrEt3bTKl94XtQWHQZlHgfeyhKQdmB4CiHqM+lVc7
         qpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ajm3Sm96cZ8KFQqJftDUm/AAk++NS7Ihs73gDHBkIWY=;
        b=djSXJnGDOFbdo48ENcn7deDaShfOIGeUQx1EfjNPcrG0YFKnihbmorahq9lK27v+d1
         bOynhVRtd0zoD8QP/p8Pxp8JBxqQ035uCK0gcsBxso7/l8sgVYfCTTI0pPktCCh1u1WP
         /Ios2KuM57HHcrzlnUR8rB7LB4fBS0l/IFNGOjoKae50ggEM9FASsJR5jvc4p6KBVmCe
         0C4KPlMx0dhZ1p7EYXji+z8PgaFv465eOE40Uvu3QM2qa+Ua6pKpTaoIz+0TNVsS8NPX
         dwFQJFMJFt4y3UZ+oZplBTzi9U+WM+o7h1T+KtbY2yPFoSlmD9E/L3B2Ixc1YpaGD5cD
         0m8A==
X-Gm-Message-State: AOAM532aj5mgS6+/lmq7EmcbdZ8+66BnSYacKyLAbAj7TQkKJ16wIIvi
        kb5T5mXfz5JBdXeTdoNrCbDP4A==
X-Google-Smtp-Source: ABdhPJwGZdbWfbgEB9c2/uTLk05HGdVg5vbXYnVJcZmspknQjdGZbMw5JKXKvILoBT7Lmm3BkwMjGw==
X-Received: by 2002:a17:90a:b105:: with SMTP id z5mr14723532pjq.64.1631800376272;
        Thu, 16 Sep 2021 06:52:56 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id o9sm3617443pfh.217.2021.09.16.06.52.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Sep 2021 06:52:55 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 08/13] mm: memcontrol: make all the callers of page_memcg() safe
Date:   Thu, 16 Sep 2021 21:47:43 +0800
Message-Id: <20210916134748.67712-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210916134748.67712-1-songmuchun@bytedance.com>
References: <20210916134748.67712-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we use objcg APIs to charge the LRU pages, the page will not hold
a reference to the memcg associated with the page. So the caller of the
page_memcg() should hold an rcu read lock or obtain a reference to the
memcg associated with the page to protect memcg from being released. So
introduce get_mem_cgroup_from_page() to obtain a reference to the memory
cgroup associated with the page.

In this patch, make all the callers hold an rcu read lock or obtain a
reference to the memcg to protect memcg from being released when the LRU
pages reparented.

We do not need to adjust the callers of page_memcg() during the whole
process of mem_cgroup_move_task(). Because the cgroup migration and
memory cgroup offlining are serialized by @cgroup_mutex. In this
routine, the LRU pages cannot be reparented to its parent memory
cgroup. So page_memcg(page) is stable and cannot be released.

This is a preparation for reparenting the LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/buffer.c                |  3 ++-
 fs/fs-writeback.c          | 23 +++++++++++----------
 include/linux/memcontrol.h | 39 ++++++++++++++++++++++++++++++++---
 mm/memcontrol.c            | 51 ++++++++++++++++++++++++++++++++++++----------
 mm/migrate.c               |  4 ++++
 mm/page_io.c               |  5 +++--
 6 files changed, 97 insertions(+), 28 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index ab7573d72dd7..52d257962343 100644
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
index 6c2cb076c1a4..ab3cd844e91d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -376,7 +376,7 @@ static inline bool PageMemcgKmem(struct page *page);
  * a valid memcg, but can be atomically swapped to the parent memcg.
  *
  * The caller must ensure that the returned memcg won't be released:
- * e.g. acquire the rcu_read_lock or css_set_lock.
+ * e.g. acquire the rcu_read_lock or css_set_lock or cgroup_mutex.
  */
 static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg)
 {
@@ -454,6 +454,31 @@ static inline struct mem_cgroup *page_memcg(struct page *page)
 }
 
 /*
+ * get_mem_cgroup_from_page - Obtain a reference on the memory cgroup associated
+ *			      with a page
+ * @page: a pointer to the page struct
+ *
+ * Returns a pointer to the memory cgroup (and obtain a reference on it)
+ * associated with the page, or NULL. This function assumes that the page
+ * is known to have a proper memory cgroup pointer. It's not safe to call
+ * this function against some type of pages, e.g. slab pages or ex-slab
+ * pages.
+ */
+static inline struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
+{
+	struct mem_cgroup *memcg;
+
+	rcu_read_lock();
+retry:
+	memcg = page_memcg(page);
+	if (unlikely(memcg && !css_tryget(&memcg->css)))
+		goto retry;
+	rcu_read_unlock();
+
+	return memcg;
+}
+
+/*
  * page_memcg_rcu - locklessly get the memory cgroup associated with a page
  * @page: a pointer to the page struct
  *
@@ -881,7 +906,7 @@ static inline bool mm_match_cgroup(struct mm_struct *mm,
 	return match;
 }
 
-struct cgroup_subsys_state *mem_cgroup_css_from_page(struct page *page);
+struct cgroup_subsys_state *get_mem_cgroup_css_from_page(struct page *page);
 ino_t page_cgroup_ino(struct page *page);
 
 static inline bool mem_cgroup_online(struct mem_cgroup *memcg)
@@ -1037,10 +1062,13 @@ static inline void count_memcg_events(struct mem_cgroup *memcg,
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
@@ -1114,6 +1142,11 @@ static inline struct mem_cgroup *page_memcg(struct page *page)
 	return NULL;
 }
 
+static inline struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
+{
+	return NULL;
+}
+
 static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
 {
 	WARN_ON_ONCE(!rcu_read_lock_held());
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a57cce0ea24b..16db5b39cb81 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -413,7 +413,7 @@ EXPORT_SYMBOL(memcg_kmem_enabled_key);
 #endif
 
 /**
- * mem_cgroup_css_from_page - css of the memcg associated with a page
+ * get_mem_cgroup_css_from_page - get css of the memcg associated with a page
  * @page: page of interest
  *
  * If memcg is bound to the default hierarchy, css of the memcg associated
@@ -423,13 +423,15 @@ EXPORT_SYMBOL(memcg_kmem_enabled_key);
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
@@ -1995,7 +1997,9 @@ void lock_page_memcg(struct page *page)
 	 * The RCU lock is held throughout the transaction.  The fast
 	 * path can get away without acquiring the memcg->move_lock
 	 * because page moving starts with an RCU grace period.
-         */
+	 *
+	 * The RCU lock also protects the memcg from being freed.
+	 */
 	rcu_read_lock();
 
 	if (mem_cgroup_disabled())
@@ -4549,7 +4553,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 void mem_cgroup_track_foreign_dirty_slowpath(struct page *page,
 					     struct bdi_writeback *wb)
 {
-	struct mem_cgroup *memcg = page_memcg(page);
+	struct mem_cgroup *memcg;
 	struct memcg_cgwb_frn *frn;
 	u64 now = get_jiffies_64();
 	u64 oldest_at = now;
@@ -4558,6 +4562,7 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct page *page,
 
 	trace_track_foreign_dirty(page, wb);
 
+	memcg = get_mem_cgroup_from_page(page);
 	/*
 	 * Pick the slot to use.  If there is already a slot for @wb, keep
 	 * using it.  If not replace the oldest one which isn't being
@@ -4596,6 +4601,7 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct page *page,
 		frn->memcg_id = wb->memcg_css->id;
 		frn->at = now;
 	}
+	css_put(&memcg->css);
 }
 
 /* issue foreign writeback flushes for recorded foreign dirtying events */
@@ -6163,6 +6169,14 @@ static void mem_cgroup_move_charge(void)
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
@@ -6985,7 +6999,7 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 	if (page_memcg(newpage))
 		return;
 
-	memcg = page_memcg(oldpage);
+	memcg = get_mem_cgroup_from_page(oldpage);
 	VM_WARN_ON_ONCE_PAGE(!memcg, oldpage);
 	if (!memcg)
 		return;
@@ -7006,6 +7020,8 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 	mem_cgroup_charge_statistics(memcg, newpage, nr_pages);
 	memcg_check_events(memcg, newpage);
 	local_irq_restore(flags);
+
+	css_put(&memcg->css);
 }
 
 DEFINE_STATIC_KEY_FALSE(memcg_sockets_enabled_key);
@@ -7192,6 +7208,10 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return;
 
+	/*
+	 * Interrupts should be disabled by the caller (see the comments below),
+	 * which can serve as RCU read-side critical sections.
+	 */
 	memcg = page_memcg(page);
 
 	VM_WARN_ON_ONCE_PAGE(!memcg, page);
@@ -7256,15 +7276,16 @@ int __mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
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
@@ -7274,6 +7295,7 @@ int __mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 		memcg_memory_event(memcg, MEMCG_SWAP_MAX);
 		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
 		mem_cgroup_id_put(memcg);
+		rcu_read_unlock();
 		return -ENOMEM;
 	}
 
@@ -7283,6 +7305,8 @@ int __mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 	oldid = swap_cgroup_record(entry, mem_cgroup_id(memcg), nr_pages);
 	VM_BUG_ON_PAGE(oldid, page);
 	mod_memcg_state(memcg, MEMCG_SWAP, nr_pages);
+out:
+	rcu_read_unlock();
 
 	return 0;
 }
@@ -7337,17 +7361,22 @@ bool mem_cgroup_swap_full(struct page *page)
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
index a6a7743ee98f..940eaec234dc 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -472,6 +472,10 @@ int migrate_page_move_mapping(struct address_space *mapping,
 		struct lruvec *old_lruvec, *new_lruvec;
 		struct mem_cgroup *memcg;
 
+		/*
+		 * Irq is disabled, which can serve as RCU read-side critical
+		 * sections.
+		 */
 		memcg = page_memcg(page);
 		old_lruvec = mem_cgroup_lruvec(memcg, oldzone->zone_pgdat);
 		new_lruvec = mem_cgroup_lruvec(memcg, newzone->zone_pgdat);
diff --git a/mm/page_io.c b/mm/page_io.c
index c493ce9ebcf5..81744777ab76 100644
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


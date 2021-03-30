Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522F634E564
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhC3KX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhC3KXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:23:33 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A85CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:23:33 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso9222309pji.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fT0weKC4DEAC+5wWcmHzQMivFqo3ZXEo4WZWR/hlXUA=;
        b=u/1orgfVtogLUV0OALnuu2NoPCBwa8seczxkr+RtaBGXBOZtJ1jgP3GKQMJTAW8mC6
         CONRxw1VpiZ4cME0tZqapqteuKMppgWKpAftOMHbKHNpfGLH1SZWT8+hHU3E3POnUPLY
         0ldx5LKfAzaEhFHbYLEWzxIMMTdN6mNunSx++cnE2xprtZKVZulaNF8Prcgr2lYs3B2v
         WLjywPAPLvmhtnMxWpBXbQEV3EEmS8yr+AZppBRi7i/DRnSiWss8ECtz2SpSiiFLbL1t
         /Yi92Ba+sXnxIXOzxQZD77hwr1yws6beAetsgCln9tL22W2+n8QwbFuOH6Qtz880dVd2
         7O5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fT0weKC4DEAC+5wWcmHzQMivFqo3ZXEo4WZWR/hlXUA=;
        b=AChssnmoDkMpRsU/VKTiaOu2a6k7HbdWj0chjXnRjYDLv/CUMpGelTqkW81put6LiT
         rMziCIAl2IeCE4c2NlrpqEoB/XYNRyFyfA6YSa9gcBK34k6ddZ69jfFpFVcxoeVO1dtm
         kH+aBp08h1FzgXhrF97ckDZuH+njC4WukHQFt8fW4x7I4T2jSLA6RD9NcYinVpsTM10D
         6g78RCVPpyfVgDOyLNLNFio0vEd9knb3sJJ4t8UsU0CDGKLuHsfJyjYAveAJzlFkx27m
         ln52fiNwORCvuZKiISVgCNNyyHSyhTKj4Wg7gezM0wuPHBGDrcXUk7dptOUbhlvqdc0V
         T2XQ==
X-Gm-Message-State: AOAM532NOocgTh4lNzcEt6AI5KDRAgo6DmbfNogHYmjyvj2XfPRFpQDn
        XCPs0XwPB0luBZ6H6ru0WGbL8g==
X-Google-Smtp-Source: ABdhPJy9F8UoZuP7LT1OlYDjJNsmaCuqqa+etWBFX0//1uxYfgub3NBcMG1hlbTr2kKZKz+qdPA8qg==
X-Received: by 2002:a17:90a:c207:: with SMTP id e7mr3536823pjt.188.1617099812967;
        Tue, 30 Mar 2021 03:23:32 -0700 (PDT)
Received: from localhost.localdomain ([2408:8445:ad30:68d8:c87f:ca1b:dc00:4730])
        by smtp.gmail.com with ESMTPSA id k10sm202259pfk.205.2021.03.30.03.23.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 03:23:32 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH 14/15] mm: memcontrol: rename {un}lock_page_memcg() to {un}lock_page_objcg()
Date:   Tue, 30 Mar 2021 18:15:30 +0800
Message-Id: <20210330101531.82752-15-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210330101531.82752-1-songmuchun@bytedance.com>
References: <20210330101531.82752-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the lock_page_memcg() does not lock a page and memcg binding, it
actually lock a page and objcg binding. So rename lock_page_memcg()
to lock_page_objcg().

This is just code cleanup without any functionality changes.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 Documentation/admin-guide/cgroup-v1/memory.rst |  2 +-
 fs/buffer.c                                    | 10 ++--
 fs/iomap/buffered-io.c                         |  4 +-
 include/linux/memcontrol.h                     | 22 +++++----
 mm/filemap.c                                   |  2 +-
 mm/huge_memory.c                               |  4 +-
 mm/memcontrol.c                                | 65 ++++++++++++++++----------
 mm/page-writeback.c                            | 26 +++++------
 mm/rmap.c                                      | 14 +++---
 9 files changed, 85 insertions(+), 64 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 0936412e044e..578823f2c764 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -291,7 +291,7 @@ Lock order is as follows:
 
   Page lock (PG_locked bit of page->flags)
     mm->page_table_lock or split pte_lock
-      lock_page_memcg (memcg->move_lock)
+      lock_page_objcg (memcg->move_lock)
         mapping->i_pages lock
           lruvec->lru_lock.
 
diff --git a/fs/buffer.c b/fs/buffer.c
index 790ba6660d10..8b6d66511690 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -595,7 +595,7 @@ EXPORT_SYMBOL(mark_buffer_dirty_inode);
  * If warn is true, then emit a warning if the page is not uptodate and has
  * not been truncated.
  *
- * The caller must hold lock_page_memcg().
+ * The caller must hold lock_page_objcg().
  */
 void __set_page_dirty(struct page *page, struct address_space *mapping,
 			     int warn)
@@ -660,14 +660,14 @@ int __set_page_dirty_buffers(struct page *page)
 	 * Lock out page's memcg migration to keep PageDirty
 	 * synchronized with per-memcg dirty page counters.
 	 */
-	lock_page_memcg(page);
+	lock_page_objcg(page);
 	newly_dirty = !TestSetPageDirty(page);
 	spin_unlock(&mapping->private_lock);
 
 	if (newly_dirty)
 		__set_page_dirty(page, mapping, 1);
 
-	unlock_page_memcg(page);
+	unlock_page_objcg(page);
 
 	if (newly_dirty)
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
@@ -1168,13 +1168,13 @@ void mark_buffer_dirty(struct buffer_head *bh)
 		struct page *page = bh->b_page;
 		struct address_space *mapping = NULL;
 
-		lock_page_memcg(page);
+		lock_page_objcg(page);
 		if (!TestSetPageDirty(page)) {
 			mapping = page_mapping(page);
 			if (mapping)
 				__set_page_dirty(page, mapping, 0);
 		}
-		unlock_page_memcg(page);
+		unlock_page_objcg(page);
 		if (mapping)
 			__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 	}
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 16a1e82e3aeb..8a3ffd38d9e0 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -653,11 +653,11 @@ iomap_set_page_dirty(struct page *page)
 	 * Lock out page's memcg migration to keep PageDirty
 	 * synchronized with per-memcg dirty page counters.
 	 */
-	lock_page_memcg(page);
+	lock_page_objcg(page);
 	newly_dirty = !TestSetPageDirty(page);
 	if (newly_dirty)
 		__set_page_dirty(page, mapping, 0);
-	unlock_page_memcg(page);
+	unlock_page_objcg(page);
 
 	if (newly_dirty)
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index cd9e9ff6c2bf..688a8e1fa9b6 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -410,11 +410,12 @@ static inline struct obj_cgroup *page_objcg(struct page *page)
  * proper memory cgroup pointer. It's not safe to call this function
  * against some type of pages, e.g. slab pages or ex-slab pages.
  *
- * For a page any of the following ensures page and objcg binding stability:
+ * For a page any of the following ensures page and objcg binding stability
+ * (But the page can be reparented to its parent memcg):
  *
  * - the page lock
  * - LRU isolation
- * - lock_page_memcg()
+ * - lock_page_objcg()
  * - exclusive reference
  *
  * Based on the stable binding of page and objcg, for a page any of the
@@ -947,9 +948,9 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
 extern bool cgroup_memory_noswap;
 #endif
 
-struct mem_cgroup *lock_page_memcg(struct page *page);
-void __unlock_page_memcg(struct mem_cgroup *memcg);
-void unlock_page_memcg(struct page *page);
+struct obj_cgroup *lock_page_objcg(struct page *page);
+void __unlock_page_objcg(struct obj_cgroup *objcg);
+void unlock_page_objcg(struct page *page);
 
 /*
  * idx can be of type enum memcg_stat_item or node_stat_item.
@@ -1155,6 +1156,11 @@ void mem_cgroup_split_huge_fixup(struct page *head);
 
 struct mem_cgroup;
 
+static inline struct obj_cgroup *page_objcg(struct page *page)
+{
+	return NULL;
+}
+
 static inline struct mem_cgroup *page_memcg(struct page *page)
 {
 	return NULL;
@@ -1375,16 +1381,16 @@ mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 {
 }
 
-static inline struct mem_cgroup *lock_page_memcg(struct page *page)
+static inline struct obj_cgroup *lock_page_objcg(struct page *page)
 {
 	return NULL;
 }
 
-static inline void __unlock_page_memcg(struct mem_cgroup *memcg)
+static inline void __unlock_page_objcg(struct obj_cgroup *objcg)
 {
 }
 
-static inline void unlock_page_memcg(struct page *page)
+static inline void unlock_page_objcg(struct page *page)
 {
 }
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 925964b67583..c427de610860 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -110,7 +110,7 @@
  *    ->i_pages lock		(page_remove_rmap->set_page_dirty)
  *    bdi.wb->list_lock		(page_remove_rmap->set_page_dirty)
  *    ->inode->i_lock		(page_remove_rmap->set_page_dirty)
- *    ->memcg->move_lock	(page_remove_rmap->lock_page_memcg)
+ *    ->memcg->move_lock	(page_remove_rmap->lock_page_objcg)
  *    bdi.wb->list_lock		(zap_pte_range->set_page_dirty)
  *    ->inode->i_lock		(zap_pte_range->set_page_dirty)
  *    ->private_lock		(zap_pte_range->__set_page_dirty_buffers)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a47c97a48951..088511eaa326 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2303,7 +2303,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 				atomic_inc(&page[i]._mapcount);
 		}
 
-		lock_page_memcg(page);
+		lock_page_objcg(page);
 		if (atomic_add_negative(-1, compound_mapcount_ptr(page))) {
 			/* Last compound_mapcount is gone. */
 			__mod_lruvec_page_state(page, NR_ANON_THPS,
@@ -2314,7 +2314,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 					atomic_dec(&page[i]._mapcount);
 			}
 		}
-		unlock_page_memcg(page);
+		unlock_page_objcg(page);
 	}
 
 	smp_wmb(); /* make pte visible before pmd */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 71689243242f..442b846dc7bc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1439,7 +1439,7 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
  * These functions are safe to use under any of the following conditions:
  * - page locked
  * - PageLRU cleared
- * - lock_page_memcg()
+ * - lock_page_objcg()
  * - page->_refcount is zero
  */
 struct lruvec *lock_page_lruvec(struct page *page)
@@ -2255,20 +2255,22 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
 }
 
 /**
- * lock_page_memcg - lock a page and memcg binding
+ * lock_page_objcg - lock a page and objcg binding
  * @page: the page
  *
  * This function protects unlocked LRU pages from being moved to
- * another cgroup.
+ * another object cgroup. But the page can be reparented to its
+ * parent memcg.
  *
- * It ensures lifetime of the returned memcg. Caller is responsible
- * for the lifetime of the page; __unlock_page_memcg() is available
+ * It ensures lifetime of the returned objcg. Caller is responsible
+ * for the lifetime of the page; __unlock_page_objcg() is available
  * when @page might get freed inside the locked section.
  */
-struct mem_cgroup *lock_page_memcg(struct page *page)
+struct obj_cgroup *lock_page_objcg(struct page *page)
 {
 	struct page *head = compound_head(page); /* rmap on tail pages */
 	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
 	unsigned long flags;
 
 	/*
@@ -2287,10 +2289,12 @@ struct mem_cgroup *lock_page_memcg(struct page *page)
 	if (mem_cgroup_disabled())
 		return NULL;
 again:
-	memcg = page_memcg(head);
-	if (unlikely(!memcg))
+	objcg = page_objcg(head);
+	if (unlikely(!objcg))
 		return NULL;
 
+	memcg = obj_cgroup_memcg(objcg);
+
 #ifdef CONFIG_PROVE_LOCKING
 	local_irq_save(flags);
 	might_lock(&memcg->move_lock);
@@ -2298,7 +2302,7 @@ struct mem_cgroup *lock_page_memcg(struct page *page)
 #endif
 
 	if (atomic_read(&memcg->moving_account) <= 0)
-		return memcg;
+		return objcg;
 
 	spin_lock_irqsave(&memcg->move_lock, flags);
 	if (memcg != page_memcg(head)) {
@@ -2309,23 +2313,34 @@ struct mem_cgroup *lock_page_memcg(struct page *page)
 	/*
 	 * When charge migration first begins, we can have locked and
 	 * unlocked page stat updates happening concurrently.  Track
-	 * the task who has the lock for unlock_page_memcg().
+	 * the task who has the lock for unlock_page_objcg().
 	 */
 	memcg->move_lock_task = current;
 	memcg->move_lock_flags = flags;
 
-	return memcg;
+	/*
+	 * The cgroup migration and memory cgroup offlining are serialized by
+	 * cgroup_mutex. If we reach here, it means that we are race with cgroup
+	 * migration (or we are cgroup migration) and the @page cannot be
+	 * reparented to its parent memory cgroup. So during the whole process
+	 * from lock_page_objcg(page) to unlock_page_objcg(page), page_memcg(page)
+	 * and obj_cgroup_memcg(objcg) are stable.
+	 */
+
+	return objcg;
 }
-EXPORT_SYMBOL(lock_page_memcg);
+EXPORT_SYMBOL(lock_page_objcg);
 
 /**
- * __unlock_page_memcg - unlock and unpin a memcg
- * @memcg: the memcg
+ * __unlock_page_objcg - unlock and unpin a objcg
+ * @objcg: the objcg
  *
- * Unlock and unpin a memcg returned by lock_page_memcg().
+ * Unlock and unpin a objcg returned by lock_page_objcg().
  */
-void __unlock_page_memcg(struct mem_cgroup *memcg)
+void __unlock_page_objcg(struct obj_cgroup *objcg)
 {
+	struct mem_cgroup *memcg = objcg ? obj_cgroup_memcg(objcg) : NULL;
+
 	if (memcg && memcg->move_lock_task == current) {
 		unsigned long flags = memcg->move_lock_flags;
 
@@ -2339,16 +2354,16 @@ void __unlock_page_memcg(struct mem_cgroup *memcg)
 }
 
 /**
- * unlock_page_memcg - unlock a page and memcg binding
+ * unlock_page_objcg - unlock a page and objcg binding
  * @page: the page
  */
-void unlock_page_memcg(struct page *page)
+void unlock_page_objcg(struct page *page)
 {
 	struct page *head = compound_head(page);
 
-	__unlock_page_memcg(page_memcg(head));
+	__unlock_page_objcg(page_objcg(head));
 }
-EXPORT_SYMBOL(unlock_page_memcg);
+EXPORT_SYMBOL(unlock_page_objcg);
 
 struct memcg_stock_pcp {
 	struct mem_cgroup *cached; /* this never be root cgroup */
@@ -3042,7 +3057,7 @@ static void commit_charge(struct page *page, struct obj_cgroup *objcg)
 	 *
 	 * - the page lock
 	 * - LRU isolation
-	 * - lock_page_memcg()
+	 * - lock_page_objcg()
 	 * - exclusive reference
 	 */
 	page->memcg_data = (unsigned long)objcg;
@@ -5785,7 +5800,7 @@ static int mem_cgroup_move_account(struct page *page,
 	from_vec = mem_cgroup_lruvec(from, pgdat);
 	to_vec = mem_cgroup_lruvec(to, pgdat);
 
-	lock_page_memcg(page);
+	lock_page_objcg(page);
 
 	if (PageAnon(page)) {
 		if (page_mapped(page)) {
@@ -5837,7 +5852,7 @@ static int mem_cgroup_move_account(struct page *page,
 	 * with (un)charging, migration, LRU putback, or anything else
 	 * that would rely on a stable page's memory cgroup.
 	 *
-	 * Note that lock_page_memcg is a memcg lock, not a page lock,
+	 * Note that lock_page_objcg is a memcg lock, not a page lock,
 	 * to save space. As soon as we switch page's memory cgroup to a
 	 * new memcg that isn't locked, the above state can change
 	 * concurrently again. Make sure we're truly done with it.
@@ -5849,7 +5864,7 @@ static int mem_cgroup_move_account(struct page *page,
 
 	page->memcg_data = (unsigned long)to->objcg;
 
-	__unlock_page_memcg(from);
+	__unlock_page_objcg(from->objcg);
 
 	ret = 0;
 
@@ -6291,7 +6306,7 @@ static void mem_cgroup_move_charge(void)
 {
 	lru_add_drain_all();
 	/*
-	 * Signal lock_page_memcg() to take the memcg's move_lock
+	 * Signal lock_page_objcg() to take the memcg's move_lock
 	 * while we're moving its pages to another memcg. Then wait
 	 * for already started RCU-only updates to finish.
 	 */
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index f517e0669924..2a119afbf7fa 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2413,7 +2413,7 @@ int __set_page_dirty_no_writeback(struct page *page)
 /*
  * Helper function for set_page_dirty family.
  *
- * Caller must hold lock_page_memcg().
+ * Caller must hold lock_page_objcg().
  *
  * NOTE: This relies on being atomic wrt interrupts.
  */
@@ -2445,7 +2445,7 @@ void account_page_dirtied(struct page *page, struct address_space *mapping)
 /*
  * Helper function for deaccounting dirty page without writeback.
  *
- * Caller must hold lock_page_memcg().
+ * Caller must hold lock_page_objcg().
  */
 void account_page_cleaned(struct page *page, struct address_space *mapping,
 			  struct bdi_writeback *wb)
@@ -2472,13 +2472,13 @@ void account_page_cleaned(struct page *page, struct address_space *mapping,
  */
 int __set_page_dirty_nobuffers(struct page *page)
 {
-	lock_page_memcg(page);
+	lock_page_objcg(page);
 	if (!TestSetPageDirty(page)) {
 		struct address_space *mapping = page_mapping(page);
 		unsigned long flags;
 
 		if (!mapping) {
-			unlock_page_memcg(page);
+			unlock_page_objcg(page);
 			return 1;
 		}
 
@@ -2489,7 +2489,7 @@ int __set_page_dirty_nobuffers(struct page *page)
 		__xa_set_mark(&mapping->i_pages, page_index(page),
 				   PAGECACHE_TAG_DIRTY);
 		xa_unlock_irqrestore(&mapping->i_pages, flags);
-		unlock_page_memcg(page);
+		unlock_page_objcg(page);
 
 		if (mapping->host) {
 			/* !PageAnon && !swapper_space */
@@ -2497,7 +2497,7 @@ int __set_page_dirty_nobuffers(struct page *page)
 		}
 		return 1;
 	}
-	unlock_page_memcg(page);
+	unlock_page_objcg(page);
 	return 0;
 }
 EXPORT_SYMBOL(__set_page_dirty_nobuffers);
@@ -2630,14 +2630,14 @@ void __cancel_dirty_page(struct page *page)
 		struct bdi_writeback *wb;
 		struct wb_lock_cookie cookie = {};
 
-		lock_page_memcg(page);
+		lock_page_objcg(page);
 		wb = unlocked_inode_to_wb_begin(inode, &cookie);
 
 		if (TestClearPageDirty(page))
 			account_page_cleaned(page, mapping, wb);
 
 		unlocked_inode_to_wb_end(inode, &cookie);
-		unlock_page_memcg(page);
+		unlock_page_objcg(page);
 	} else {
 		ClearPageDirty(page);
 	}
@@ -2722,11 +2722,11 @@ EXPORT_SYMBOL(clear_page_dirty_for_io);
 int test_clear_page_writeback(struct page *page)
 {
 	struct address_space *mapping = page_mapping(page);
-	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
 	struct lruvec *lruvec;
 	int ret;
 
-	memcg = lock_page_memcg(page);
+	objcg = lock_page_objcg(page);
 	lruvec = mem_cgroup_page_lruvec(page);
 	if (mapping && mapping_use_writeback_tags(mapping)) {
 		struct inode *inode = mapping->host;
@@ -2759,7 +2759,7 @@ int test_clear_page_writeback(struct page *page)
 		dec_zone_page_state(page, NR_ZONE_WRITE_PENDING);
 		inc_node_page_state(page, NR_WRITTEN);
 	}
-	__unlock_page_memcg(memcg);
+	__unlock_page_objcg(objcg);
 	return ret;
 }
 
@@ -2768,7 +2768,7 @@ int __test_set_page_writeback(struct page *page, bool keep_write)
 	struct address_space *mapping = page_mapping(page);
 	int ret, access_ret;
 
-	lock_page_memcg(page);
+	lock_page_objcg(page);
 	if (mapping && mapping_use_writeback_tags(mapping)) {
 		XA_STATE(xas, &mapping->i_pages, page_index(page));
 		struct inode *inode = mapping->host;
@@ -2808,7 +2808,7 @@ int __test_set_page_writeback(struct page *page, bool keep_write)
 		inc_lruvec_page_state(page, NR_WRITEBACK);
 		inc_zone_page_state(page, NR_ZONE_WRITE_PENDING);
 	}
-	unlock_page_memcg(page);
+	unlock_page_objcg(page);
 	access_ret = arch_make_page_accessible(page);
 	/*
 	 * If writeback has been triggered on a page that cannot be made
diff --git a/mm/rmap.c b/mm/rmap.c
index b0fc27e77d6d..3c2488e1081c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -31,7 +31,7 @@
  *               swap_lock (in swap_duplicate, swap_info_get)
  *                 mmlist_lock (in mmput, drain_mmlist and others)
  *                 mapping->private_lock (in __set_page_dirty_buffers)
- *                   lock_page_memcg move_lock (in __set_page_dirty_buffers)
+ *                   lock_page_objcg move_lock (in __set_page_dirty_buffers)
  *                     i_pages lock (widely used)
  *                       lruvec->lru_lock (in lock_page_lruvec_irq)
  *                 inode->i_lock (in set_page_dirty's __mark_inode_dirty)
@@ -1127,7 +1127,7 @@ void do_page_add_anon_rmap(struct page *page,
 	bool first;
 
 	if (unlikely(PageKsm(page)))
-		lock_page_memcg(page);
+		lock_page_objcg(page);
 	else
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
 
@@ -1155,7 +1155,7 @@ void do_page_add_anon_rmap(struct page *page,
 	}
 
 	if (unlikely(PageKsm(page))) {
-		unlock_page_memcg(page);
+		unlock_page_objcg(page);
 		return;
 	}
 
@@ -1215,7 +1215,7 @@ void page_add_file_rmap(struct page *page, bool compound)
 	int i, nr = 1;
 
 	VM_BUG_ON_PAGE(compound && !PageTransHuge(page), page);
-	lock_page_memcg(page);
+	lock_page_objcg(page);
 	if (compound && PageTransHuge(page)) {
 		int nr_pages = thp_nr_pages(page);
 
@@ -1244,7 +1244,7 @@ void page_add_file_rmap(struct page *page, bool compound)
 	}
 	__mod_lruvec_page_state(page, NR_FILE_MAPPED, nr);
 out:
-	unlock_page_memcg(page);
+	unlock_page_objcg(page);
 }
 
 static void page_remove_file_rmap(struct page *page, bool compound)
@@ -1345,7 +1345,7 @@ static void page_remove_anon_compound_rmap(struct page *page)
  */
 void page_remove_rmap(struct page *page, bool compound)
 {
-	lock_page_memcg(page);
+	lock_page_objcg(page);
 
 	if (!PageAnon(page)) {
 		page_remove_file_rmap(page, compound);
@@ -1384,7 +1384,7 @@ void page_remove_rmap(struct page *page, bool compound)
 	 * faster for those pages still in swapcache.
 	 */
 out:
-	unlock_page_memcg(page);
+	unlock_page_objcg(page);
 }
 
 /*
-- 
2.11.0


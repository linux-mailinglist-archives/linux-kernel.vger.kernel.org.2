Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A34A40DBD2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbhIPNzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237149AbhIPNyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:54:45 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E13C0613E7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:53:14 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y8so5930591pfa.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EAWQcd3+iSnFgMjA09dHwY1Do+Ap2eL4bKxjuZ/dl64=;
        b=i4Hw57/+75X3uPhhdK62krbcoa6MFZmG7EarqwjYEVIBwnGoPnQrP1HOd2LNjGVRR3
         eTJbiT7+WFUS4Abceq3Dv9M7A5aTFIZIIx21Z/HGy5e472HxhNQjn/BBIxOq2vF2lyQO
         XEYWshLjAiBL+l3ifJma7fI2uopq09Mdy2W31up2sfZ3ykDItHtg9bt0JzaPKoD/jsEq
         clJENg3EiutQ41owuQvUoNYosoP22rsblSq3/ym/9/qRqxXonUF0CMpgP/k/HFv/h90a
         u5W3WSGOHuzDvZ0XNeEK1tlBTa2xTgf3l27NowF0MBmwuoU9Ve+xt1INqMNyaD2zeFDQ
         YnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EAWQcd3+iSnFgMjA09dHwY1Do+Ap2eL4bKxjuZ/dl64=;
        b=r9zEeURPPwnsDXzAx6tRSoOifKNJWG1WEo/8+AHD23n6Y9HbgUumCODCVfliSlnQVT
         qRqh7VJHOUrrzZPnlt0McbjdNF4SXfMIkmPlTcouQslw7Ehuy8XI4QgAwqniYXl80lhM
         EePSltMixP25DeOntfYiaW4WLqRf4XXEUcH9j0Xk8qrtK9NcnU/koYd6KshJ533O8Bik
         KuPxbSAaH4gDF+FdPXQPiKBr1MR4svlAawgb1CSYndaFgkcB4nDFYtFLfkrXUuV9mREQ
         tXvHgoV1LZOmJlYEmwTpgma8+uqD3hzpNxRM6RuQlqwvQuQreM3bHyFnYdqambMXkI+a
         UGVQ==
X-Gm-Message-State: AOAM533ohM9uHjlqu7PPLTaQSf9khN7OfZqaPjCQ2hJVOozLkCjrv8Cn
        eDQMtchlnmr8Ra0YpW9cDoxLuw==
X-Google-Smtp-Source: ABdhPJzD8IrxHC7Hmk/2ELz/2nWF6uyT8Ufdk9FSeyD8Xh848ebbSqqzQ2tLDOwGFhqDgr06Yglj3Q==
X-Received: by 2002:aa7:9731:0:b0:43c:9087:fb40 with SMTP id k17-20020aa79731000000b0043c9087fb40mr5027702pfg.55.1631800393845;
        Thu, 16 Sep 2021 06:53:13 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id o9sm3617443pfh.217.2021.09.16.06.53.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Sep 2021 06:53:13 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 11/13] mm: memcontrol: rename {un}lock_page_memcg() to {un}lock_page_objcg()
Date:   Thu, 16 Sep 2021 21:47:46 +0800
Message-Id: <20210916134748.67712-12-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210916134748.67712-1-songmuchun@bytedance.com>
References: <20210916134748.67712-1-songmuchun@bytedance.com>
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
 fs/buffer.c                                    |  8 ++---
 include/linux/memcontrol.h                     | 18 ++++++----
 mm/filemap.c                                   |  2 +-
 mm/huge_memory.c                               |  4 +--
 mm/memcontrol.c                                | 49 +++++++++++++++-----------
 mm/page-writeback.c                            | 26 +++++++-------
 mm/rmap.c                                      | 14 ++++----
 8 files changed, 69 insertions(+), 54 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 41191b5fb69d..dd582312b91a 100644
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
index 52d257962343..be815d537bdd 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -635,14 +635,14 @@ int __set_page_dirty_buffers(struct page *page)
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
@@ -1102,13 +1102,13 @@ void mark_buffer_dirty(struct buffer_head *bh)
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
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 3d9691395cf3..6c160fa1272a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -415,11 +415,12 @@ static inline struct obj_cgroup *page_objcg(struct page *page)
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
@@ -949,8 +950,8 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
 extern bool cgroup_memory_noswap;
 #endif
 
-void lock_page_memcg(struct page *page);
-void unlock_page_memcg(struct page *page);
+void lock_page_objcg(struct page *page);
+void unlock_page_objcg(struct page *page);
 
 void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val);
 
@@ -1120,6 +1121,11 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 #define MEM_CGROUP_ID_SHIFT	0
 #define MEM_CGROUP_ID_MAX	0
 
+static inline struct obj_cgroup *page_objcg(struct page *page)
+{
+	return NULL;
+}
+
 static inline struct mem_cgroup *page_memcg(struct page *page)
 {
 	return NULL;
@@ -1354,11 +1360,11 @@ mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 {
 }
 
-static inline void lock_page_memcg(struct page *page)
+static inline void lock_page_objcg(struct page *page)
 {
 }
 
-static inline void unlock_page_memcg(struct page *page)
+static inline void unlock_page_objcg(struct page *page)
 {
 }
 
diff --git a/mm/filemap.c b/mm/filemap.c
index dae481293b5d..2df4187cbff7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -112,7 +112,7 @@
  *    ->i_pages lock		(page_remove_rmap->set_page_dirty)
  *    bdi.wb->list_lock		(page_remove_rmap->set_page_dirty)
  *    ->inode->i_lock		(page_remove_rmap->set_page_dirty)
- *    ->memcg->move_lock	(page_remove_rmap->lock_page_memcg)
+ *    ->memcg->move_lock	(page_remove_rmap->lock_page_objcg)
  *    bdi.wb->list_lock		(zap_pte_range->set_page_dirty)
  *    ->inode->i_lock		(zap_pte_range->set_page_dirty)
  *    ->private_lock		(zap_pte_range->__set_page_dirty_buffers)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d6738637feae..74bdc0ebf642 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2227,7 +2227,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 				atomic_inc(&page[i]._mapcount);
 		}
 
-		lock_page_memcg(page);
+		lock_page_objcg(page);
 		if (atomic_add_negative(-1, compound_mapcount_ptr(page))) {
 			/* Last compound_mapcount is gone. */
 			__mod_lruvec_page_state(page, NR_ANON_THPS,
@@ -2238,7 +2238,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 					atomic_dec(&page[i]._mapcount);
 			}
 		}
-		unlock_page_memcg(page);
+		unlock_page_objcg(page);
 	}
 
 	smp_wmb(); /* make pte visible before pmd */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3688651d85c2..e46fc01c6164 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1286,7 +1286,7 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
  * These functions are safe to use under any of the following conditions:
  * - page locked
  * - PageLRU cleared
- * - lock_page_memcg()
+ * - lock_page_objcg()
  * - page->_refcount is zero
  */
 struct lruvec *lock_page_lruvec(struct page *page)
@@ -2097,16 +2097,16 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
 }
 
 /**
- * lock_page_memcg - lock a page and memcg binding
+ * lock_page_objcg - lock a page and objcg binding
  * @page: the page
  *
  * This function protects unlocked LRU pages from being moved to
  * another cgroup.
  *
- * It ensures lifetime of the locked memcg. Caller is responsible
+ * It ensures lifetime of the locked objcg. Caller is responsible
  * for the lifetime of the page.
  */
-void lock_page_memcg(struct page *page)
+void lock_page_objcg(struct page *page)
 {
 	struct page *head = compound_head(page); /* rmap on tail pages */
 	struct mem_cgroup *memcg;
@@ -2144,18 +2144,27 @@ void lock_page_memcg(struct page *page)
 	}
 
 	/*
+	 * The cgroup migration and memory cgroup offlining are serialized by
+	 * cgroup_mutex. If we reach here, it means that we are race with cgroup
+	 * migration (or we are cgroup migration) and the @page cannot be
+	 * reparented to its parent memory cgroup. So during the whole process
+	 * from lock_page_objcg(page) to unlock_page_objcg(page), page_memcg(page)
+	 * and obj_cgroup_memcg(objcg) are stable.
+	 *
 	 * When charge migration first begins, we can have multiple
 	 * critical sections holding the fast-path RCU lock and one
 	 * holding the slowpath move_lock. Track the task who has the
-	 * move_lock for unlock_page_memcg().
+	 * move_lock for unlock_page_objcg().
 	 */
 	memcg->move_lock_task = current;
 	memcg->move_lock_flags = flags;
 }
-EXPORT_SYMBOL(lock_page_memcg);
+EXPORT_SYMBOL(lock_page_objcg);
 
-static void __unlock_page_memcg(struct mem_cgroup *memcg)
+static void __unlock_page_objcg(struct obj_cgroup *objcg)
 {
+	struct mem_cgroup *memcg = objcg ? obj_cgroup_memcg(objcg) : NULL;
+
 	if (memcg && memcg->move_lock_task == current) {
 		unsigned long flags = memcg->move_lock_flags;
 
@@ -2169,16 +2178,16 @@ static void __unlock_page_memcg(struct mem_cgroup *memcg)
 }
 
 /**
- * unlock_page_memcg - unlock a page and memcg binding
+ * unlock_page_objcg - unlock a page and memcg binding
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
 
 struct obj_stock {
 #ifdef CONFIG_MEMCG_KMEM
@@ -2885,7 +2894,7 @@ static void commit_charge(struct page *page, struct obj_cgroup *objcg)
 	 *
 	 * - the page lock
 	 * - LRU isolation
-	 * - lock_page_memcg()
+	 * - lock_page_objcg()
 	 * - exclusive reference
 	 */
 	page->memcg_data = (unsigned long)objcg;
@@ -5770,7 +5779,7 @@ static int mem_cgroup_move_account(struct page *page,
 	from_vec = mem_cgroup_lruvec(from, pgdat);
 	to_vec = mem_cgroup_lruvec(to, pgdat);
 
-	lock_page_memcg(page);
+	lock_page_objcg(page);
 
 	if (PageAnon(page)) {
 		if (page_mapped(page)) {
@@ -5822,7 +5831,7 @@ static int mem_cgroup_move_account(struct page *page,
 	 * with (un)charging, migration, LRU putback, or anything else
 	 * that would rely on a stable page's memory cgroup.
 	 *
-	 * Note that lock_page_memcg is a memcg lock, not a page lock,
+	 * Note that lock_page_objcg is a memcg lock, not a page lock,
 	 * to save space. As soon as we switch page's memory cgroup to a
 	 * new memcg that isn't locked, the above state can change
 	 * concurrently again. Make sure we're truly done with it.
@@ -5834,7 +5843,7 @@ static int mem_cgroup_move_account(struct page *page,
 
 	page->memcg_data = (unsigned long)to->objcg;
 
-	__unlock_page_memcg(from);
+	__unlock_page_objcg(from->objcg);
 
 	ret = 0;
 
@@ -6276,7 +6285,7 @@ static void mem_cgroup_move_charge(void)
 {
 	lru_add_drain_all();
 	/*
-	 * Signal lock_page_memcg() to take the memcg's move_lock
+	 * Signal lock_page_objcg() to take the memcg's move_lock
 	 * while we're moving its pages to another memcg. Then wait
 	 * for already started RCU-only updates to finish.
 	 */
@@ -6308,14 +6317,14 @@ static void mem_cgroup_move_charge(void)
 	/*
 	 * Moving its pages to another memcg is finished. Wait for already
 	 * started RCU-only updates to finish to make sure that the caller
-	 * of lock_page_memcg() can unlock the correct move_lock. The
+	 * of lock_page_objcg() can unlock the correct move_lock. The
 	 * possible bad scenario would like:
 	 *
 	 * CPU0:				CPU1:
 	 * mem_cgroup_move_charge()
 	 *     walk_page_range()
 	 *
-	 *					lock_page_memcg(page)
+	 *					lock_page_objcg(page)
 	 *					    memcg = page_memcg(page)
 	 *					    spin_lock_irqsave(&memcg->move_lock)
 	 *					    memcg->move_lock_task = current
@@ -6326,14 +6335,14 @@ static void mem_cgroup_move_charge(void)
 	 *     memcg_offline_kmem()
 	 *         memcg_reparent_objcgs() <== reparented
 	 *
-	 *					unlock_page_memcg(page)
+	 *					unlock_page_objcg(page)
 	 *					    memcg = page_memcg(page) <== memcg has been changed
 	 *					    if (memcg->move_lock_task == current) <== false
 	 *					        spin_unlock_irqrestore(&memcg->move_lock)
 	 *
 	 * Once mem_cgroup_move_charge() returns (it means that the cgroup_mutex
 	 * would be released soon), the page can be reparented to its parent
-	 * memcg. When the unlock_page_memcg() is called for the page, we will
+	 * memcg. When the unlock_page_objcg() is called for the page, we will
 	 * miss unlock the move_lock. So using synchronize_rcu to wait for
 	 * already started RCU-only updates to finish before this function
 	 * returns (mem_cgroup_move_charge() and mem_cgroup_css_offline() are
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 4812a17b288c..68f9619b8d75 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2434,7 +2434,7 @@ EXPORT_SYMBOL(__set_page_dirty_no_writeback);
 /*
  * Helper function for set_page_dirty family.
  *
- * Caller must hold lock_page_memcg().
+ * Caller must hold lock_page_objcg().
  *
  * NOTE: This relies on being atomic wrt interrupts.
  */
@@ -2467,7 +2467,7 @@ static void account_page_dirtied(struct page *page,
 /*
  * Helper function for deaccounting dirty page without writeback.
  *
- * Caller must hold lock_page_memcg().
+ * Caller must hold lock_page_objcg().
  */
 void account_page_cleaned(struct page *page, struct address_space *mapping,
 			  struct bdi_writeback *wb)
@@ -2487,7 +2487,7 @@ void account_page_cleaned(struct page *page, struct address_space *mapping,
  * If warn is true, then emit a warning if the page is not uptodate and has
  * not been truncated.
  *
- * The caller must hold lock_page_memcg().
+ * The caller must hold lock_page_objcg().
  */
 void __set_page_dirty(struct page *page, struct address_space *mapping,
 			     int warn)
@@ -2518,16 +2518,16 @@ void __set_page_dirty(struct page *page, struct address_space *mapping,
  */
 int __set_page_dirty_nobuffers(struct page *page)
 {
-	lock_page_memcg(page);
+	lock_page_objcg(page);
 	if (!TestSetPageDirty(page)) {
 		struct address_space *mapping = page_mapping(page);
 
 		if (!mapping) {
-			unlock_page_memcg(page);
+			unlock_page_objcg(page);
 			return 1;
 		}
 		__set_page_dirty(page, mapping, !PagePrivate(page));
-		unlock_page_memcg(page);
+		unlock_page_objcg(page);
 
 		if (mapping->host) {
 			/* !PageAnon && !swapper_space */
@@ -2535,7 +2535,7 @@ int __set_page_dirty_nobuffers(struct page *page)
 		}
 		return 1;
 	}
-	unlock_page_memcg(page);
+	unlock_page_objcg(page);
 	return 0;
 }
 EXPORT_SYMBOL(__set_page_dirty_nobuffers);
@@ -2659,14 +2659,14 @@ void __cancel_dirty_page(struct page *page)
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
@@ -2771,7 +2771,7 @@ int test_clear_page_writeback(struct page *page)
 	struct address_space *mapping = page_mapping(page);
 	int ret;
 
-	lock_page_memcg(page);
+	lock_page_objcg(page);
 	if (mapping && mapping_use_writeback_tags(mapping)) {
 		struct inode *inode = mapping->host;
 		struct backing_dev_info *bdi = inode_to_bdi(inode);
@@ -2806,7 +2806,7 @@ int test_clear_page_writeback(struct page *page)
 		dec_zone_page_state(page, NR_ZONE_WRITE_PENDING);
 		inc_node_page_state(page, NR_WRITTEN);
 	}
-	unlock_page_memcg(page);
+	unlock_page_objcg(page);
 	return ret;
 }
 
@@ -2815,7 +2815,7 @@ int __test_set_page_writeback(struct page *page, bool keep_write)
 	struct address_space *mapping = page_mapping(page);
 	int ret, access_ret;
 
-	lock_page_memcg(page);
+	lock_page_objcg(page);
 	if (mapping && mapping_use_writeback_tags(mapping)) {
 		XA_STATE(xas, &mapping->i_pages, page_index(page));
 		struct inode *inode = mapping->host;
@@ -2860,7 +2860,7 @@ int __test_set_page_writeback(struct page *page, bool keep_write)
 		inc_lruvec_page_state(page, NR_WRITEBACK);
 		inc_zone_page_state(page, NR_ZONE_WRITE_PENDING);
 	}
-	unlock_page_memcg(page);
+	unlock_page_objcg(page);
 	access_ret = arch_make_page_accessible(page);
 	/*
 	 * If writeback has been triggered on a page that cannot be made
diff --git a/mm/rmap.c b/mm/rmap.c
index 6aebd1747251..d97aeea017ac 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -32,7 +32,7 @@
  *                 swap_lock (in swap_duplicate, swap_info_get)
  *                   mmlist_lock (in mmput, drain_mmlist and others)
  *                   mapping->private_lock (in __set_page_dirty_buffers)
- *                     lock_page_memcg move_lock (in __set_page_dirty_buffers)
+ *                     lock_page_objcg move_lock (in __set_page_dirty_buffers)
  *                       i_pages lock (widely used)
  *                         lruvec->lru_lock (in lock_page_lruvec_irq)
  *                   inode->i_lock (in set_page_dirty's __mark_inode_dirty)
@@ -1125,7 +1125,7 @@ void do_page_add_anon_rmap(struct page *page,
 	bool first;
 
 	if (unlikely(PageKsm(page)))
-		lock_page_memcg(page);
+		lock_page_objcg(page);
 	else
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
 
@@ -1153,7 +1153,7 @@ void do_page_add_anon_rmap(struct page *page,
 	}
 
 	if (unlikely(PageKsm(page))) {
-		unlock_page_memcg(page);
+		unlock_page_objcg(page);
 		return;
 	}
 
@@ -1213,7 +1213,7 @@ void page_add_file_rmap(struct page *page, bool compound)
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


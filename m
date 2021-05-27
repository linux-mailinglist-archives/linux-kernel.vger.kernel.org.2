Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40A9392AE3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbhE0Jga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbhE0JgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:36:22 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F0AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 02:34:49 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id u7so2056686plq.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 02:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CPb8rkUB+/BA7X8g6jN3Selz5WDf+tUjKtDrS+9kWa0=;
        b=sj48zu8Bw1J+8in08Uc2ELKei5mkagXrozTUzzm680lDobXPM41BXelaN/n91iojOp
         99Nfg+Ik1/KhVOkMS10kfnziiVPn3zKqTOZAoZmDv6Wvf7g9eZCl6UCk0IwxzKeLYonE
         zogM/+77DVZFbVAd1xDUr4i1pjYdDKdEPsu7P4IohSlwH36Xu6mV5X0fNACB9eIdUoh9
         LiDUeJNQCA30fWAUX6DV2X/tGYyD9ajJepPhSfoiwzFJYENAAReyguWkd22MH3cVMcrN
         ZNE7HkR+bVF81bCmnmwwCv4yKih7MnaVMAdnJgHrGq1dXCNeEI5I2fwxAlKRRfsMB3YL
         jnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CPb8rkUB+/BA7X8g6jN3Selz5WDf+tUjKtDrS+9kWa0=;
        b=GH7AzkRQrR/5x7IPnl9C5uamJLtfce3KVRhkvstyXiSW+0Wzc+eG0qgzBQUPIhj03f
         YNbzRkPD+mS9QGAg8arxZ23iDnwA9zFmMzOFbOJ6Tvil7wBx3Z+yq/6KLGdfr1LrM3bH
         SQcuDl60EBl5AprQUnzRoMgsyamHRn5SL3Tzs3lGb6+PaxjyKCdOXzgME9fNNEvz33M8
         UPuKlzaFQ/FPOUozvT0/zzl2dWUs7QQtvu7Cj6TmMet9InYLz+IVKzriG6UiiTNObJrG
         a7UnYd96gaa6c+SGlZsOtFVlsMR88SSDL2QcHHPJnyikxdys980RJobcK7SKoOU9c4ob
         78mw==
X-Gm-Message-State: AOAM531E12qhgsenMAGWQ9bQQBy5FVco/tsFT/PwARF9ewl3FoVP6D0G
        HvlMmFYd5PlCNYJgaWsRf+LLoA==
X-Google-Smtp-Source: ABdhPJxs2xZu7PjGIsD9xXCljJLRfyLzYUR6xGc7/Z/s+2+A3KkVZRdRCXVDObVrxpkO55V8+4W9RA==
X-Received: by 2002:a17:90a:be12:: with SMTP id a18mr2699274pjs.187.1622108089157;
        Thu, 27 May 2021 02:34:49 -0700 (PDT)
Received: from localhost.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id a9sm1418917pfl.57.2021.05.27.02.34.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 May 2021 02:34:48 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v4 10/12] mm: memcontrol: rename {un}lock_page_memcg() to {un}lock_page_objcg()
Date:   Thu, 27 May 2021 17:33:34 +0800
Message-Id: <20210527093336.14895-11-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210527093336.14895-1-songmuchun@bytedance.com>
References: <20210527093336.14895-1-songmuchun@bytedance.com>
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
 fs/buffer.c                                    | 10 +++----
 fs/iomap/buffered-io.c                         |  4 +--
 include/linux/memcontrol.h                     | 18 +++++++----
 mm/filemap.c                                   |  2 +-
 mm/huge_memory.c                               |  4 +--
 mm/memcontrol.c                                | 41 ++++++++++++++++----------
 mm/page-writeback.c                            | 24 +++++++--------
 mm/rmap.c                                      | 14 ++++-----
 9 files changed, 67 insertions(+), 52 deletions(-)

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
index a542a47f6e27..6935f12d23f8 100644
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
@@ -1164,13 +1164,13 @@ void mark_buffer_dirty(struct buffer_head *bh)
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
index 9023717c5188..de6d07fe5e07 100644
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
index 25777e39bc34..76d6b82fec15 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -419,11 +419,12 @@ static inline struct obj_cgroup *page_objcg(struct page *page)
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
@@ -943,8 +944,8 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
 extern bool cgroup_memory_noswap;
 #endif
 
-void lock_page_memcg(struct page *page);
-void unlock_page_memcg(struct page *page);
+void lock_page_objcg(struct page *page);
+void unlock_page_objcg(struct page *page);
 
 void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val);
 
@@ -1113,6 +1114,11 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
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
@@ -1340,11 +1346,11 @@ mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
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
index ba1068a1837f..85a1bdc86d3d 100644
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
index 78cf65c29336..6548c9b8c0b3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2244,7 +2244,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 				atomic_inc(&page[i]._mapcount);
 		}
 
-		lock_page_memcg(page);
+		lock_page_objcg(page);
 		if (atomic_add_negative(-1, compound_mapcount_ptr(page))) {
 			/* Last compound_mapcount is gone. */
 			__mod_lruvec_page_state(page, NR_ANON_THPS,
@@ -2255,7 +2255,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 					atomic_dec(&page[i]._mapcount);
 			}
 		}
-		unlock_page_memcg(page);
+		unlock_page_objcg(page);
 	}
 
 	smp_wmb(); /* make pte visible before pmd */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 48d40764ed49..33aad9ed5071 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1306,7 +1306,7 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
  * These functions are safe to use under any of the following conditions:
  * - page locked
  * - PageLRU cleared
- * - lock_page_memcg()
+ * - lock_page_objcg()
  * - page->_refcount is zero
  */
 struct lruvec *lock_page_lruvec(struct page *page)
@@ -2117,16 +2117,16 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
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
@@ -2164,18 +2164,27 @@ void lock_page_memcg(struct page *page)
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
 
@@ -2189,16 +2198,16 @@ static void __unlock_page_memcg(struct mem_cgroup *memcg)
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
@@ -2930,7 +2939,7 @@ static void commit_charge(struct page *page, struct obj_cgroup *objcg)
 	 *
 	 * - the page lock
 	 * - LRU isolation
-	 * - lock_page_memcg()
+	 * - lock_page_objcg()
 	 * - exclusive reference
 	 */
 	page->memcg_data = (unsigned long)objcg;
@@ -5775,7 +5784,7 @@ static int mem_cgroup_move_account(struct page *page,
 	from_vec = mem_cgroup_lruvec(from, pgdat);
 	to_vec = mem_cgroup_lruvec(to, pgdat);
 
-	lock_page_memcg(page);
+	lock_page_objcg(page);
 
 	if (PageAnon(page)) {
 		if (page_mapped(page)) {
@@ -5827,7 +5836,7 @@ static int mem_cgroup_move_account(struct page *page,
 	 * with (un)charging, migration, LRU putback, or anything else
 	 * that would rely on a stable page's memory cgroup.
 	 *
-	 * Note that lock_page_memcg is a memcg lock, not a page lock,
+	 * Note that lock_page_objcg is a memcg lock, not a page lock,
 	 * to save space. As soon as we switch page's memory cgroup to a
 	 * new memcg that isn't locked, the above state can change
 	 * concurrently again. Make sure we're truly done with it.
@@ -5839,7 +5848,7 @@ static int mem_cgroup_move_account(struct page *page,
 
 	page->memcg_data = (unsigned long)to->objcg;
 
-	__unlock_page_memcg(from);
+	__unlock_page_objcg(from->objcg);
 
 	ret = 0;
 
@@ -6281,7 +6290,7 @@ static void mem_cgroup_move_charge(void)
 {
 	lru_add_drain_all();
 	/*
-	 * Signal lock_page_memcg() to take the memcg's move_lock
+	 * Signal lock_page_objcg() to take the memcg's move_lock
 	 * while we're moving its pages to another memcg. Then wait
 	 * for already started RCU-only updates to finish.
 	 */
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index f3bcd2bb00a6..285ba4e1306a 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2417,7 +2417,7 @@ int __set_page_dirty_no_writeback(struct page *page)
 /*
  * Helper function for set_page_dirty family.
  *
- * Caller must hold lock_page_memcg().
+ * Caller must hold lock_page_objcg().
  *
  * NOTE: This relies on being atomic wrt interrupts.
  */
@@ -2449,7 +2449,7 @@ void account_page_dirtied(struct page *page, struct address_space *mapping)
 /*
  * Helper function for deaccounting dirty page without writeback.
  *
- * Caller must hold lock_page_memcg().
+ * Caller must hold lock_page_objcg().
  */
 void account_page_cleaned(struct page *page, struct address_space *mapping,
 			  struct bdi_writeback *wb)
@@ -2476,13 +2476,13 @@ void account_page_cleaned(struct page *page, struct address_space *mapping,
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
 
@@ -2493,7 +2493,7 @@ int __set_page_dirty_nobuffers(struct page *page)
 		__xa_set_mark(&mapping->i_pages, page_index(page),
 				   PAGECACHE_TAG_DIRTY);
 		xa_unlock_irqrestore(&mapping->i_pages, flags);
-		unlock_page_memcg(page);
+		unlock_page_objcg(page);
 
 		if (mapping->host) {
 			/* !PageAnon && !swapper_space */
@@ -2501,7 +2501,7 @@ int __set_page_dirty_nobuffers(struct page *page)
 		}
 		return 1;
 	}
-	unlock_page_memcg(page);
+	unlock_page_objcg(page);
 	return 0;
 }
 EXPORT_SYMBOL(__set_page_dirty_nobuffers);
@@ -2634,14 +2634,14 @@ void __cancel_dirty_page(struct page *page)
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
@@ -2728,7 +2728,7 @@ int test_clear_page_writeback(struct page *page)
 	struct address_space *mapping = page_mapping(page);
 	int ret;
 
-	lock_page_memcg(page);
+	lock_page_objcg(page);
 	if (mapping && mapping_use_writeback_tags(mapping)) {
 		struct inode *inode = mapping->host;
 		struct backing_dev_info *bdi = inode_to_bdi(inode);
@@ -2760,7 +2760,7 @@ int test_clear_page_writeback(struct page *page)
 		dec_zone_page_state(page, NR_ZONE_WRITE_PENDING);
 		inc_node_page_state(page, NR_WRITTEN);
 	}
-	unlock_page_memcg(page);
+	unlock_page_objcg(page);
 	return ret;
 }
 
@@ -2769,7 +2769,7 @@ int __test_set_page_writeback(struct page *page, bool keep_write)
 	struct address_space *mapping = page_mapping(page);
 	int ret, access_ret;
 
-	lock_page_memcg(page);
+	lock_page_objcg(page);
 	if (mapping && mapping_use_writeback_tags(mapping)) {
 		XA_STATE(xas, &mapping->i_pages, page_index(page));
 		struct inode *inode = mapping->host;
@@ -2809,7 +2809,7 @@ int __test_set_page_writeback(struct page *page, bool keep_write)
 		inc_lruvec_page_state(page, NR_WRITEBACK);
 		inc_zone_page_state(page, NR_ZONE_WRITE_PENDING);
 	}
-	unlock_page_memcg(page);
+	unlock_page_objcg(page);
 	access_ret = arch_make_page_accessible(page);
 	/*
 	 * If writeback has been triggered on a page that cannot be made
diff --git a/mm/rmap.c b/mm/rmap.c
index f3860e46a14d..867ac600286a 100644
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5144A3EC0B2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 07:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237313AbhHNF1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 01:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237305AbhHNF07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 01:26:59 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6FFC061757
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 22:26:31 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso23873394pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 22:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FojWylM23QvkSybRKOwXASlFikLzL4f7BmcJ2ZeU5aE=;
        b=lr/drc26q2fEy29TkkLa6rRjbHgmQkWyV1BF9Zgs3roVb17pWXZecGTPrX8Pby1NML
         nV9mLKmHL1OlwlIjTsJ5OH2NlBtVq27Ijy5X7luv8YTnlqDSF/8PzeFTlmezXNdTDiEO
         irrNaGdS66v7O/wYGlMGIJarx8YzeExZwTnCgEpgynSiYTZPPlmuODCvt8hOxeMqOFQ6
         JWX2Owy9Kj+z/p7xwgnR+oZYovsdGWV7GBFZqOdXoecxfJIVlcJSgTDed3ln6c8UB/BX
         bxKXpWoR3aVf+8DGXgWi6JX2IDWfMPpOmn979+of5ePi/y4fM36QOizBXeSJo4WybOna
         fhjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FojWylM23QvkSybRKOwXASlFikLzL4f7BmcJ2ZeU5aE=;
        b=t8T52qwVTWbXmNJireFGwB6b+Jdt/JPfJawo1HuQ6J47WmHgCfzjpnjRsgTdtp/B5Z
         jPj7ROqLmlDyKF/5vepEKteatafGsw6fqq6jW5IysClx/uHIbKeT8bzdQjMft/zx2iFq
         VbwIF4NQ7b4meo2p9KoaY4eXGNGaUMyWQ4uAM0l8jpDeaHPOEgk4ztay1+Doq0pSxsU2
         HBTC1UXhqdpd+MLh0+NKDomtowyVzAoUcVp58Y2EvOGZprnXNOdisGddEEE7Eg05YlFG
         6C2PkMSCa5Yd61JNsI1eVpGhp8L2NSCGAOXZf/1zQIz9fxZRtXnKOxUyk2DsYE7UbhVZ
         YHnQ==
X-Gm-Message-State: AOAM5322YQUo5KMZ6Ptb/0LDTectVQuWvz4M+0l15T1P8Q74VXE0ABa1
        p9FaDPDTb9IaXLIK6nN5rrwFIg==
X-Google-Smtp-Source: ABdhPJySeKJuLWfO3oSmyhLQwfzmtKMl5FBqy6pjSVZLmeUGhJlU5gofbWu8/zH/HlefGh+M4GscLg==
X-Received: by 2002:a62:864b:0:b029:3c7:7197:59fc with SMTP id x72-20020a62864b0000b02903c7719759fcmr5566254pfd.59.1628918790961;
        Fri, 13 Aug 2021 22:26:30 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id s5sm4783133pgp.81.2021.08.13.22.26.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Aug 2021 22:26:30 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com, alexs@kernel.org,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v1 10/12] mm: memcontrol: rename {un}lock_page_memcg() to {un}lock_page_objcg()
Date:   Sat, 14 Aug 2021 13:25:17 +0800
Message-Id: <20210814052519.86679-11-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210814052519.86679-1-songmuchun@bytedance.com>
References: <20210814052519.86679-1-songmuchun@bytedance.com>
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
 fs/buffer.c                                    |  8 ++++----
 include/linux/memcontrol.h                     | 14 +++++++-------
 mm/filemap.c                                   |  2 +-
 mm/huge_memory.c                               |  4 ++--
 mm/memcontrol.c                                | 24 ++++++++++++------------
 mm/page-writeback.c                            |  6 +++---
 mm/rmap.c                                      | 14 +++++++-------
 8 files changed, 37 insertions(+), 37 deletions(-)

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
index 88123f84885a..c3d20ebb1d0b 100644
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
@@ -1139,13 +1139,13 @@ void mark_buffer_dirty(struct buffer_head *bh)
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
index 92c98a952bab..611e6a6d7b00 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -417,12 +417,12 @@ static inline struct obj_cgroup *folio_objcg(struct folio *folio)
  * proper memory cgroup pointer. It's not safe to call this function
  * against some type of folios, e.g. slab folios or ex-slab folios.
  *
- * For a folio any of the following ensures folio and memcg binding
- * stability:
+ * For a page any of the following ensures page and objcg binding
+ * stability (But the folio can be reparented to its parent memcg):
  *
  * - the folio lock
  * - LRU isolation
- * - lock_page_memcg()
+ * - lock_page_objcg()
  * - exclusive reference
  *
  * Based on the stable binding of folio and objcg, for a folio any of the
@@ -970,8 +970,8 @@ extern bool cgroup_memory_noswap;
 
 void folio_memcg_lock(struct folio *folio);
 void folio_memcg_unlock(struct folio *folio);
-void lock_page_memcg(struct page *page);
-void unlock_page_memcg(struct page *page);
+void lock_page_objcg(struct page *page);
+void unlock_page_objcg(struct page *page);
 
 void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val);
 
@@ -1388,11 +1388,11 @@ mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
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
index 53913fced7ae..b5298fd17d14 100644
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
index 731e1b894407..eb3c07c00d2c 100644
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
index 52a878081452..9464e6d2d735 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2135,18 +2135,18 @@ void folio_memcg_lock(struct folio *folio)
 	 * When charge migration first begins, we can have multiple
 	 * critical sections holding the fast-path RCU lock and one
 	 * holding the slowpath move_lock. Track the task who has the
-	 * move_lock for unlock_page_memcg().
+	 * move_lock for unlock_page_objcg().
 	 */
 	memcg->move_lock_task = current;
 	memcg->move_lock_flags = flags;
 }
 EXPORT_SYMBOL(folio_memcg_lock);
 
-void lock_page_memcg(struct page *page)
+void lock_page_objcg(struct page *page)
 {
 	folio_memcg_lock(page_folio(page));
 }
-EXPORT_SYMBOL(lock_page_memcg);
+EXPORT_SYMBOL(lock_page_objcg);
 
 static void __folio_memcg_unlock(struct mem_cgroup *memcg)
 {
@@ -2176,11 +2176,11 @@ void folio_memcg_unlock(struct folio *folio)
 }
 EXPORT_SYMBOL(folio_memcg_unlock);
 
-void unlock_page_memcg(struct page *page)
+void unlock_page_objcg(struct page *page)
 {
 	folio_memcg_unlock(page_folio(page));
 }
-EXPORT_SYMBOL(unlock_page_memcg);
+EXPORT_SYMBOL(unlock_page_objcg);
 
 struct obj_stock {
 #ifdef CONFIG_MEMCG_KMEM
@@ -2887,7 +2887,7 @@ static void commit_charge(struct folio *folio, struct obj_cgroup *objcg)
 	 *
 	 * - the page lock
 	 * - LRU isolation
-	 * - lock_page_memcg()
+	 * - lock_page_objcg()
 	 * - exclusive reference
 	 */
 	folio->memcg_data = (unsigned long)objcg;
@@ -5826,7 +5826,7 @@ static int mem_cgroup_move_account(struct page *page,
 	 * with (un)charging, migration, LRU putback, or anything else
 	 * that would rely on a stable page's memory cgroup.
 	 *
-	 * Note that lock_page_memcg is a memcg lock, not a page lock,
+	 * Note that lock_page_objcg is a memcg lock, not a page lock,
 	 * to save space. As soon as we switch page's memory cgroup to a
 	 * new memcg that isn't locked, the above state can change
 	 * concurrently again. Make sure we're truly done with it.
@@ -6281,7 +6281,7 @@ static void mem_cgroup_move_charge(void)
 {
 	lru_add_drain_all();
 	/*
-	 * Signal lock_page_memcg() to take the memcg's move_lock
+	 * Signal lock_page_objcg() to take the memcg's move_lock
 	 * while we're moving its pages to another memcg. Then wait
 	 * for already started RCU-only updates to finish.
 	 */
@@ -6313,14 +6313,14 @@ static void mem_cgroup_move_charge(void)
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
+	 *					unlock_page_objcg(page)
 	 *					    memcg = folio_memcg()
 	 *					    spin_lock_irqsave(&memcg->move_lock)
 	 *					    memcg->move_lock_task = current
@@ -6331,14 +6331,14 @@ static void mem_cgroup_move_charge(void)
 	 *     memcg_offline_kmem()
 	 *         memcg_reparent_objcgs() <== reparented
 	 *
-	 *					unlock_page_memcg(page)
+	 *					unlock_page_objcg(page)
 	 *					    memcg = folio_memcg() <== memcg has been changed
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
index 5b171aa067c1..d8fd7308dd39 100644
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
@@ -2468,7 +2468,7 @@ static void folio_account_dirtied(struct folio *folio,
 /*
  * Helper function for deaccounting dirty page without writeback.
  *
- * Caller must hold lock_page_memcg().
+ * Caller must hold lock_page_objcg().
  */
 void folio_account_cleaned(struct folio *folio, struct address_space *mapping,
 			  struct bdi_writeback *wb)
@@ -2489,7 +2489,7 @@ void folio_account_cleaned(struct folio *folio, struct address_space *mapping,
  * If warn is true, then emit a warning if the folio is not uptodate and has
  * not been truncated.
  *
- * The caller must hold lock_page_memcg().
+ * The caller must hold lock_page_objcg().
  */
 void __folio_mark_dirty(struct folio *folio, struct address_space *mapping,
 			     int warn)
diff --git a/mm/rmap.c b/mm/rmap.c
index 09c41e1f44d8..232494888628 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -32,7 +32,7 @@
  *                 swap_lock (in swap_duplicate, swap_info_get)
  *                   mmlist_lock (in mmput, drain_mmlist and others)
  *                   mapping->private_lock (in __set_page_dirty_buffers)
- *                     lock_page_memcg move_lock (in __set_page_dirty_buffers)
+ *                     lock_page_objcg move_lock (in __set_page_dirty_buffers)
  *                       i_pages lock (widely used)
  *                         lruvec->lru_lock (in folio_lruvec_lock_irq)
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
 
@@ -1242,7 +1242,7 @@ void page_add_file_rmap(struct page *page, bool compound)
 	}
 	__mod_lruvec_page_state(page, NR_FILE_MAPPED, nr);
 out:
-	unlock_page_memcg(page);
+	unlock_page_objcg(page);
 }
 
 static void page_remove_file_rmap(struct page *page, bool compound)
@@ -1343,7 +1343,7 @@ static void page_remove_anon_compound_rmap(struct page *page)
  */
 void page_remove_rmap(struct page *page, bool compound)
 {
-	lock_page_memcg(page);
+	lock_page_objcg(page);
 
 	if (!PageAnon(page)) {
 		page_remove_file_rmap(page, compound);
@@ -1382,7 +1382,7 @@ void page_remove_rmap(struct page *page, bool compound)
 	 * faster for those pages still in swapcache.
 	 */
 out:
-	unlock_page_memcg(page);
+	unlock_page_objcg(page);
 }
 
 /*
-- 
2.11.0


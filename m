Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D981359EC8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbhDIMda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbhDIMdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:33:19 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AABC061764
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 05:33:07 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id y32so3774015pga.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 05:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DwlsVPU7gFcFt9ASSURCWwMa14aZM88FM+qjluEVhNA=;
        b=U4GT0KwULoPk5kpdmAlDizB/oFK/SkNhr3iCOKsBqcpvHAoyrDqHh0lcKOwar3crrS
         WbGoBKAlMeKQzZJOe66lIAR2cirN4nP6Z1makFStLw0QC1g9RHKVen76sFC2gpcW6uZT
         Fv3E4C2rSAQN8iZnXeEWknncLPaS7vyZ/OEYrtnoWqq7+mYgxxa/pg0AUvuS6xEqnxe4
         Zov6JbQlub7Qm0saGVYnlYz0DjLc1Xz7oM5769NAmGXGSqBgVugA8kkGjXlrjh7pgVu1
         uvjmA0iCLor1w9h8roc/chymxE/o+v39jsmizfbQSzV421tMyY8qlHqodA7+KSpLRm9F
         uDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DwlsVPU7gFcFt9ASSURCWwMa14aZM88FM+qjluEVhNA=;
        b=dMd26dsrRBO7FwhkgAczlv+mqL1CcQzr4fv96xhGpvIXAYHeR7ht+9Izf+nIoKGRTx
         iFqZ3eLjX5UTAvZeZ1Nk2xRek+bcjh8gxE9TWt1HA4DGST7OPyaOJKfWFET2E/ZrCGrd
         0BD5rrKppJMdWeTU4CZAaRYiHZYO2a+rIk7zW1u+fKz3UYDVw6KiOwy/ZQD4uoxGYdny
         /KqA7ve1l8Xh3vuvNaATXMnH17ixtpuIf4WEerHSOwGbmBn8bIcaTOAcVQl7HPOxDXKe
         vUoImOvwGEPbSv7xaaiX3eNGk46OPLgR6NCGvE/9o/Z/sQ/ggou01O+htnWtPGVZtf4e
         vMoQ==
X-Gm-Message-State: AOAM533Vd2NCd1U5AR69hiOhepAStJtkF0bNRWmfqSfYZGyEbnYDEMck
        qSbgn4KP2l0ryQlCzriadrjL7g==
X-Google-Smtp-Source: ABdhPJw/VL64X2MYSkX6caHOMqxe5I6u3RPNEOm6T6PjZRWgyfTvt3+BXhEvwQ2ygLJsEQ7XSmNeUg==
X-Received: by 2002:a63:925a:: with SMTP id s26mr12348263pgn.216.1617971586541;
        Fri, 09 Apr 2021 05:33:06 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id t3sm2167785pfg.176.2021.04.09.05.33.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Apr 2021 05:33:06 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH v2 13/18] mm: memcontrol: make all the callers of page_memcg() safe
Date:   Fri,  9 Apr 2021 20:29:54 +0800
Message-Id: <20210409122959.82264-14-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210409122959.82264-1-songmuchun@bytedance.com>
References: <20210409122959.82264-1-songmuchun@bytedance.com>
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
 include/linux/memcontrol.h | 34 ++++++++++++++++++++++++++++---
 mm/memcontrol.c            | 51 ++++++++++++++++++++++++++++++++++++----------
 mm/migrate.c               |  4 ++++
 mm/page_io.c               |  5 +++--
 6 files changed, 92 insertions(+), 28 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 673cfbef9eec..a542a47f6e27 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -848,7 +848,7 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 		gfp |= __GFP_NOFAIL;
 
 	/* The page lock pins the memcg */
-	memcg = page_memcg(page);
+	memcg = get_mem_cgroup_from_page(page);
 	old_memcg = set_active_memcg(memcg);
 
 	head = NULL;
@@ -868,6 +868,7 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 		set_bh_page(bh, page, offset);
 	}
 out:
+	mem_cgroup_put(memcg);
 	set_active_memcg(old_memcg);
 	return head;
 /*
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index e91980f49388..3ac002561327 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -255,15 +255,13 @@ void __inode_attach_wb(struct inode *inode, struct page *page)
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
@@ -736,16 +734,16 @@ void wbc_account_cgroup_owner(struct writeback_control *wbc, struct page *page,
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
@@ -758,6 +756,9 @@ void wbc_account_cgroup_owner(struct writeback_control *wbc, struct page *page,
 		wbc->wb_tcand_bytes += bytes;
 	else
 		wbc->wb_tcand_bytes -= min(bytes, wbc->wb_tcand_bytes);
+
+out:
+	css_put(css);
 }
 EXPORT_SYMBOL_GPL(wbc_account_cgroup_owner);
 
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 93aa41600913..7e15be2bd47a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -381,7 +381,7 @@ static inline bool PageMemcgKmem(struct page *page);
  * a valid memcg, but can be atomically swapped to the parent memcg.
  *
  * The caller must ensure that the returned memcg won't be released:
- * e.g. acquire the rcu_read_lock or css_set_lock.
+ * e.g. acquire the rcu_read_lock or css_set_lock or cgroup_mutex.
  */
 static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg)
 {
@@ -459,6 +459,31 @@ static inline struct mem_cgroup *page_memcg(struct page *page)
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
@@ -871,7 +896,7 @@ static inline bool mm_match_cgroup(struct mm_struct *mm,
 	return match;
 }
 
-struct cgroup_subsys_state *mem_cgroup_css_from_page(struct page *page);
+struct cgroup_subsys_state *get_mem_cgroup_css_from_page(struct page *page);
 ino_t page_cgroup_ino(struct page *page);
 
 static inline bool mem_cgroup_online(struct mem_cgroup *memcg)
@@ -1031,10 +1056,13 @@ static inline void count_memcg_events(struct mem_cgroup *memcg,
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
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3a2f5c43aed3..2f4fcb182883 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -440,7 +440,7 @@ EXPORT_SYMBOL(memcg_kmem_enabled_key);
 #endif
 
 /**
- * mem_cgroup_css_from_page - css of the memcg associated with a page
+ * get_mem_cgroup_css_from_page - get css of the memcg associated with a page
  * @page: page of interest
  *
  * If memcg is bound to the default hierarchy, css of the memcg associated
@@ -450,13 +450,15 @@ EXPORT_SYMBOL(memcg_kmem_enabled_key);
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
@@ -2023,7 +2025,9 @@ void lock_page_memcg(struct page *page)
 	 * The RCU lock is held throughout the transaction.  The fast
 	 * path can get away without acquiring the memcg->move_lock
 	 * because page moving starts with an RCU grace period.
-         */
+	 *
+	 * The RCU lock also protects the memcg from being freed.
+	 */
 	rcu_read_lock();
 
 	if (mem_cgroup_disabled())
@@ -4443,7 +4447,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 void mem_cgroup_track_foreign_dirty_slowpath(struct page *page,
 					     struct bdi_writeback *wb)
 {
-	struct mem_cgroup *memcg = page_memcg(page);
+	struct mem_cgroup *memcg;
 	struct memcg_cgwb_frn *frn;
 	u64 now = get_jiffies_64();
 	u64 oldest_at = now;
@@ -4452,6 +4456,7 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct page *page,
 
 	trace_track_foreign_dirty(page, wb);
 
+	memcg = get_mem_cgroup_from_page(page);
 	/*
 	 * Pick the slot to use.  If there is already a slot for @wb, keep
 	 * using it.  If not replace the oldest one which isn't being
@@ -4490,6 +4495,7 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct page *page,
 		frn->memcg_id = wb->memcg_css->id;
 		frn->at = now;
 	}
+	css_put(&memcg->css);
 }
 
 /* issue foreign writeback flushes for recorded foreign dirtying events */
@@ -6014,6 +6020,14 @@ static void mem_cgroup_move_charge(void)
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
@@ -6841,7 +6855,7 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 	if (page_memcg(newpage))
 		return;
 
-	memcg = page_memcg(oldpage);
+	memcg = get_mem_cgroup_from_page(oldpage);
 	VM_WARN_ON_ONCE_PAGE(!memcg, oldpage);
 	if (!memcg)
 		return;
@@ -6862,6 +6876,8 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 	mem_cgroup_charge_statistics(memcg, newpage, nr_pages);
 	memcg_check_events(memcg, newpage);
 	local_irq_restore(flags);
+
+	css_put(&memcg->css);
 }
 
 DEFINE_STATIC_KEY_FALSE(memcg_sockets_enabled_key);
@@ -7050,6 +7066,10 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return;
 
+	/*
+	 * Interrupts should be disabled by the caller (see the comments below),
+	 * which can serve as RCU read-side critical sections.
+	 */
 	memcg = page_memcg(page);
 
 	VM_WARN_ON_ONCE_PAGE(!memcg, page);
@@ -7117,15 +7137,16 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
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
@@ -7135,6 +7156,7 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 		memcg_memory_event(memcg, MEMCG_SWAP_MAX);
 		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
 		mem_cgroup_id_put(memcg);
+		rcu_read_unlock();
 		return -ENOMEM;
 	}
 
@@ -7144,6 +7166,8 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 	oldid = swap_cgroup_record(entry, mem_cgroup_id(memcg), nr_pages);
 	VM_BUG_ON_PAGE(oldid, page);
 	mod_memcg_state(memcg, MEMCG_SWAP, nr_pages);
+out:
+	rcu_read_unlock();
 
 	return 0;
 }
@@ -7198,17 +7222,22 @@ bool mem_cgroup_swap_full(struct page *page)
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
index b234c3f3acb7..9256693a9979 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -463,6 +463,10 @@ int migrate_page_move_mapping(struct address_space *mapping,
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


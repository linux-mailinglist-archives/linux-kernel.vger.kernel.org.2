Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1156134E55C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhC3KW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbhC3KWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:22:48 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5969AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:22:48 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ha17so7516905pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+RRui44YOPJhiRmspahr5RWVyh8BgMk07C75sioBtqk=;
        b=vzfrXfXZ+/XxPREmIiv9MdyNd9I4OeHsfzej7mDnOj15gIzFXMeSsbYqNYXPZ5hwEv
         kY8b7dvMmyOMdi28jQNy/QiXOjRJrpPjf86+xot6OoIu8Xb0bThMVc3Io5nOwz2ax6M6
         IU4cqz0KOTadDamr4O9IaqqGIu1qCssJTV2vzHMq8oMOhBGmljp62iTDYwMuleyqkm+T
         Nzw/RIzqqe73pU2r1dqy8JbQHruhWbiZYMGPLuBoU42A01qTboY8FkNSksaqcl0gDDkO
         99ihm0d1zFVZh68BP5hCgb3AzWNBONbgrFc1bjmhnDtbU52Tn4j5FWQWivB74aEUn8hy
         M1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+RRui44YOPJhiRmspahr5RWVyh8BgMk07C75sioBtqk=;
        b=doz8GwQF0PEpc5RDCsIOHgh0cTQDany2s9vG3SDdnh6pXiZQJk2ayUzvtfpYL7nNQs
         l+1mTlNRkIbsZ5dsaq4LUs82rwLigLj82//wAPG5gFl7+ayOrNvGa6IpHVyGx6Tyizl9
         TJlBaWhaV3LMQO+ZmrIi3Se5bRhhHmhNaoHikMH84MHUx3H6FZ3OV/nAXa8BfOkBG1nk
         raM2h7q+UxS2UKwCfXNM2X0nDos2ER5X8m/Fur45XPOVqxD0H3rAN1CzMP7962jV1O8c
         RHDtCLASABAjPXC96B2nZpCEaqwZVAhRelj0uYjnbKLZGAuNoudRr7GoUGb5nZhZgYLx
         hz7A==
X-Gm-Message-State: AOAM5301+IWF7jLds1V10lnYHbOU5hwwsPGmv6331i3dRFiFmqi+OlwR
        TuW4/cH0h2jH/bdD6RonmBBRSw==
X-Google-Smtp-Source: ABdhPJxPvWJm3OgX91dsEqA4LIOqvgaCwymQOQtQ+qqV31O23dn8D11n5PGy2XIMz4lH61iziy8LQA==
X-Received: by 2002:a17:902:b705:b029:e6:f027:adf8 with SMTP id d5-20020a170902b705b02900e6f027adf8mr33326834pls.72.1617099767458;
        Tue, 30 Mar 2021 03:22:47 -0700 (PDT)
Received: from localhost.localdomain ([2408:8445:ad30:68d8:c87f:ca1b:dc00:4730])
        by smtp.gmail.com with ESMTPSA id k10sm202259pfk.205.2021.03.30.03.22.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 03:22:47 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH 11/15] mm: memcontrol: make all the callers of page_memcg() safe
Date:   Tue, 30 Mar 2021 18:15:27 +0800
Message-Id: <20210330101531.82752-12-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210330101531.82752-1-songmuchun@bytedance.com>
References: <20210330101531.82752-1-songmuchun@bytedance.com>
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
 mm/memcontrol.c            | 50 ++++++++++++++++++++++++++++++++++++----------
 mm/migrate.c               |  4 ++++
 mm/page_io.c               |  5 +++--
 6 files changed, 91 insertions(+), 28 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 591547779dbd..790ba6660d10 100644
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
index 5d7c8a060843..8944115ebf8e 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -367,7 +367,7 @@ static inline bool PageMemcgKmem(struct page *page);
  * a valid memcg, but can be atomically swapped to the parent memcg.
  *
  * The caller must ensure that the returned memcg won't be released:
- * e.g. acquire the rcu_read_lock or css_set_lock.
+ * e.g. acquire the rcu_read_lock or css_set_lock or cgroup_mutex.
  */
 static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg)
 {
@@ -445,6 +445,31 @@ static inline struct mem_cgroup *page_memcg(struct page *page)
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
@@ -870,7 +895,7 @@ static inline bool mm_match_cgroup(struct mm_struct *mm,
 	return match;
 }
 
-struct cgroup_subsys_state *mem_cgroup_css_from_page(struct page *page);
+struct cgroup_subsys_state *get_mem_cgroup_css_from_page(struct page *page);
 ino_t page_cgroup_ino(struct page *page);
 
 static inline bool mem_cgroup_online(struct mem_cgroup *memcg)
@@ -1068,10 +1093,13 @@ static inline void count_memcg_events(struct mem_cgroup *memcg,
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
index 2592e2b072ef..cb650d089d9f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -563,7 +563,7 @@ void memcg_set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
 }
 
 /**
- * mem_cgroup_css_from_page - css of the memcg associated with a page
+ * get_mem_cgroup_css_from_page - get css of the memcg associated with a page
  * @page: page of interest
  *
  * If memcg is bound to the default hierarchy, css of the memcg associated
@@ -573,13 +573,15 @@ void memcg_set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
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
@@ -3332,7 +3334,7 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
  */
 void mem_cgroup_split_huge_fixup(struct page *head)
 {
-	struct mem_cgroup *memcg = page_memcg(head);
+	struct mem_cgroup *memcg = get_mem_cgroup_from_page(head);
 	int i;
 
 	if (mem_cgroup_disabled())
@@ -3342,6 +3344,7 @@ void mem_cgroup_split_huge_fixup(struct page *head)
 		css_get(&memcg->css);
 		head[i].memcg_data = (unsigned long)memcg;
 	}
+	css_put(&memcg->css);
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
@@ -4664,7 +4667,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 void mem_cgroup_track_foreign_dirty_slowpath(struct page *page,
 					     struct bdi_writeback *wb)
 {
-	struct mem_cgroup *memcg = page_memcg(page);
+	struct mem_cgroup *memcg;
 	struct memcg_cgwb_frn *frn;
 	u64 now = get_jiffies_64();
 	u64 oldest_at = now;
@@ -4673,6 +4676,7 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct page *page,
 
 	trace_track_foreign_dirty(page, wb);
 
+	memcg = get_mem_cgroup_from_page(page);
 	/*
 	 * Pick the slot to use.  If there is already a slot for @wb, keep
 	 * using it.  If not replace the oldest one which isn't being
@@ -4711,6 +4715,7 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct page *page,
 		frn->memcg_id = wb->memcg_css->id;
 		frn->at = now;
 	}
+	css_put(&memcg->css);
 }
 
 /* issue foreign writeback flushes for recorded foreign dirtying events */
@@ -6182,6 +6187,14 @@ static void mem_cgroup_move_charge(void)
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
@@ -6977,7 +6990,7 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 	if (page_memcg(newpage))
 		return;
 
-	memcg = page_memcg(oldpage);
+	memcg = get_mem_cgroup_from_page(oldpage);
 	VM_WARN_ON_ONCE_PAGE(!memcg, oldpage);
 	if (!memcg)
 		return;
@@ -6998,6 +7011,8 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 	mem_cgroup_charge_statistics(memcg, newpage, nr_pages);
 	memcg_check_events(memcg, newpage);
 	local_irq_restore(flags);
+
+	css_put(&memcg->css);
 }
 
 DEFINE_STATIC_KEY_FALSE(memcg_sockets_enabled_key);
@@ -7186,6 +7201,10 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return;
 
+	/*
+	 * Interrupts should be disabled by the caller (see the comments below),
+	 * which can serve as RCU read-side critical sections.
+	 */
 	memcg = page_memcg(page);
 
 	VM_WARN_ON_ONCE_PAGE(!memcg, page);
@@ -7253,15 +7272,16 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
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
@@ -7271,6 +7291,7 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 		memcg_memory_event(memcg, MEMCG_SWAP_MAX);
 		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
 		mem_cgroup_id_put(memcg);
+		rcu_read_unlock();
 		return -ENOMEM;
 	}
 
@@ -7280,6 +7301,8 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 	oldid = swap_cgroup_record(entry, mem_cgroup_id(memcg), nr_pages);
 	VM_BUG_ON_PAGE(oldid, page);
 	mod_memcg_state(memcg, MEMCG_SWAP, nr_pages);
+out:
+	rcu_read_unlock();
 
 	return 0;
 }
@@ -7334,17 +7357,22 @@ bool mem_cgroup_swap_full(struct page *page)
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
index 62b81d5257aa..6f5d445949c2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -490,6 +490,10 @@ int migrate_page_move_mapping(struct address_space *mapping,
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


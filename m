Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F36B451D99
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345672AbhKPAbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345676AbhKOT3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:29:02 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B95C06BCEF
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:59:22 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id p18so15189627plf.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3szfw6jRsFyxQTVEG1ikPVQdN5P2dWMh3dSumqMxVhs=;
        b=TijEmTvOjN0UoX3NB3h1bJm6DMUpDGiy+GhYbzr58hhcQCtldQd2SN/8uRdvV/dI9w
         FdCpdTBLg/YV0fwOhXkZ2lK/QaniOE2/K8XO6AldlqknhIZ1M0wjlNDqwBvkqPOgsArr
         jvs26/8SOpjuCbRsdl4CNGCzAkmeP3pgE3O6Ez7LE01zQkIgm+hBF9/nD0m/74MP6ydR
         8q0wrzBsmq2lInmOo2k4m5ctzGK6ZNxEhKy8GGjfZZEXHcJdO0LfEZi9KnItOpLq05Xh
         MztX6TLBBvCyHYfUjzvmXvNXrhaQ7by2I8YtfmCFb5TtAB4wzYIGgpR7XyUYiwbI5cpa
         fZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3szfw6jRsFyxQTVEG1ikPVQdN5P2dWMh3dSumqMxVhs=;
        b=TXlxzRp1apsHZE2J2uls+NX/2PZizkDBS8Bi3P71KIbZ/91vSz2u4WeedTHrvSvZyE
         rY4u0I3RkDx+4dSRGjo1dlP7Fjci0knvwCAzrX3fQf7RoDysaWl2ewF8hWYWhfTOWipj
         xflGFjzjX7zvrQIyHKb4jl4a9vqpe/jbI61wajMHZaH9ObR0KjyO1nV6s5RA92E4V8uz
         gkfCaF4O9RLsy3l0A7sHEEC/b10o5DjqFftE5bKFw1fKIXYmqzAlRbfRZXLXv2u7xaxX
         pTvrNPkddsVZuINYTZceDRQdimCqEOfqMRVFeCnoBfXGdN0vRliCx3fFZQZ1Sqioe9ht
         CjBw==
X-Gm-Message-State: AOAM530m6f9lsLJ8RnyD1HXpqDXRCPRfvfT+90nFDTtrbJLO7aZU9hez
        0+tWgDTTdXnTQUTva1BSp9c=
X-Google-Smtp-Source: ABdhPJxYOuLm/Stm4uY5Ema/Ylcp1xpbFg+jEKlCS2YZJNeg3vH/aVrND2VhZub4h8vKg04Dwo433A==
X-Received: by 2002:a17:902:758b:b0:13e:8b1:e49f with SMTP id j11-20020a170902758b00b0013e08b1e49fmr38558283pll.6.1637002762089;
        Mon, 15 Nov 2021 10:59:22 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:7a54:8083:4365:b23d])
        by smtp.gmail.com with ESMTPSA id c3sm11882941pfv.67.2021.11.15.10.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 10:59:21 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2 8/9] zsmalloc: replace per zpage lock with pool->migrate_lock
Date:   Mon, 15 Nov 2021 10:59:08 -0800
Message-Id: <20211115185909.3949505-9-minchan@kernel.org>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
In-Reply-To: <20211115185909.3949505-1-minchan@kernel.org>
References: <20211115185909.3949505-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The zsmalloc has used a bit for spin_lock in zpage handle to keep
zpage object alive during several operations. However, it causes
the problem for PREEMPT_RT as well as introducing too complicated.

This patch replaces the bit spin_lock with pool->migrate_lock
rwlock. It could make the code simple as well as zsmalloc work
under PREEMPT_RT.

The drawback is the pool->migrate_lock is bigger granuarity than
per zpage lock so the contention would be higher than old when
both IO-related operations(i.e., zsmalloc, zsfree, zs_[map|unmap])
and compaction(page/zpage migration) are going in parallel(*,
the migrate_lock is rwlock and IO related functions are all read
side lock so there is no contention). However, the write-side
is fast enough(dominant overhead is just page copy) so it wouldn't
affect much. If the lock granurity becomes more problem later,
we could introduce table locks based on handle as a hash value.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/zsmalloc.c | 205 +++++++++++++++++++++++---------------------------
 1 file changed, 96 insertions(+), 109 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index b8b098be92fa..5d4c4d254679 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -30,6 +30,14 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+/*
+ * lock ordering:
+ *	page_lock
+ *	pool->migrate_lock
+ *	class->lock
+ *	zspage->lock
+ */
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -100,15 +108,6 @@
 
 #define _PFN_BITS		(MAX_POSSIBLE_PHYSMEM_BITS - PAGE_SHIFT)
 
-/*
- * Memory for allocating for handle keeps object position by
- * encoding <page, obj_idx> and the encoded value has a room
- * in least bit(ie, look at obj_to_location).
- * We use the bit to synchronize between object access by
- * user and migration.
- */
-#define HANDLE_PIN_BIT	0
-
 /*
  * Head in allocated object should have OBJ_ALLOCATED_TAG
  * to identify the object was allocated or not.
@@ -255,6 +254,8 @@ struct zs_pool {
 	struct inode *inode;
 	struct work_struct free_work;
 #endif
+	/* protect page/zspage migration */
+	rwlock_t migrate_lock;
 };
 
 struct zspage {
@@ -297,6 +298,9 @@ static void zs_unregister_migration(struct zs_pool *pool);
 static void migrate_lock_init(struct zspage *zspage);
 static void migrate_read_lock(struct zspage *zspage);
 static void migrate_read_unlock(struct zspage *zspage);
+static void migrate_write_lock(struct zspage *zspage);
+static void migrate_write_lock_nested(struct zspage *zspage);
+static void migrate_write_unlock(struct zspage *zspage);
 static void kick_deferred_free(struct zs_pool *pool);
 static void init_deferred_free(struct zs_pool *pool);
 static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage);
@@ -308,6 +312,9 @@ static void zs_unregister_migration(struct zs_pool *pool) {}
 static void migrate_lock_init(struct zspage *zspage) {}
 static void migrate_read_lock(struct zspage *zspage) {}
 static void migrate_read_unlock(struct zspage *zspage) {}
+static void migrate_write_lock(struct zspage *zspage) {}
+static void migrate_write_lock_nested(struct zspage *zspage) {}
+static void migrate_write_unlock(struct zspage *zspage) {}
 static void kick_deferred_free(struct zs_pool *pool) {}
 static void init_deferred_free(struct zs_pool *pool) {}
 static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage) {}
@@ -359,14 +366,10 @@ static void cache_free_zspage(struct zs_pool *pool, struct zspage *zspage)
 	kmem_cache_free(pool->zspage_cachep, zspage);
 }
 
+/* class->lock(which owns the handle) synchronizes races */
 static void record_obj(unsigned long handle, unsigned long obj)
 {
-	/*
-	 * lsb of @obj represents handle lock while other bits
-	 * represent object value the handle is pointing so
-	 * updating shouldn't do store tearing.
-	 */
-	WRITE_ONCE(*(unsigned long *)handle, obj);
+	*(unsigned long *)handle = obj;
 }
 
 /* zpool driver */
@@ -880,26 +883,6 @@ static bool obj_allocated(struct page *page, void *obj, unsigned long *phandle)
 	return true;
 }
 
-static inline int testpin_tag(unsigned long handle)
-{
-	return bit_spin_is_locked(HANDLE_PIN_BIT, (unsigned long *)handle);
-}
-
-static inline int trypin_tag(unsigned long handle)
-{
-	return bit_spin_trylock(HANDLE_PIN_BIT, (unsigned long *)handle);
-}
-
-static void pin_tag(unsigned long handle) __acquires(bitlock)
-{
-	bit_spin_lock(HANDLE_PIN_BIT, (unsigned long *)handle);
-}
-
-static void unpin_tag(unsigned long handle) __releases(bitlock)
-{
-	bit_spin_unlock(HANDLE_PIN_BIT, (unsigned long *)handle);
-}
-
 static void reset_page(struct page *page)
 {
 	__ClearPageMovable(page);
@@ -968,6 +951,11 @@ static void free_zspage(struct zs_pool *pool, struct size_class *class,
 	VM_BUG_ON(get_zspage_inuse(zspage));
 	VM_BUG_ON(list_empty(&zspage->list));
 
+	/*
+	 * Since zs_free couldn't be sleepable, this function cannot call
+	 * lock_page. The page locks trylock_zspage got will be released
+	 * by __free_zspage.
+	 */
 	if (!trylock_zspage(zspage)) {
 		kick_deferred_free(pool);
 		return;
@@ -1263,15 +1251,20 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	 */
 	BUG_ON(in_interrupt());
 
-	/* From now on, migration cannot move the object */
-	pin_tag(handle);
-
+	/* It guarantees it can get zspage from handle safely */
+	read_lock(&pool->migrate_lock);
 	obj = handle_to_obj(handle);
 	obj_to_location(obj, &page, &obj_idx);
 	zspage = get_zspage(page);
 
-	/* migration cannot move any subpage in this zspage */
+	/*
+	 * migration cannot move any zpages in this zspage. Here, class->lock
+	 * is too heavy since callers would take some time until they calls
+	 * zs_unmap_object API so delegate the locking from class to zspage
+	 * which is smaller granularity.
+	 */
 	migrate_read_lock(zspage);
+	read_unlock(&pool->migrate_lock);
 
 	class = zspage_class(pool, zspage);
 	off = (class->size * obj_idx) & ~PAGE_MASK;
@@ -1330,7 +1323,6 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 	put_cpu_var(zs_map_area);
 
 	migrate_read_unlock(zspage);
-	unpin_tag(handle);
 }
 EXPORT_SYMBOL_GPL(zs_unmap_object);
 
@@ -1424,6 +1416,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	size += ZS_HANDLE_SIZE;
 	class = pool->size_class[get_size_class_index(size)];
 
+	/* class->lock effectively protects the zpage migration */
 	spin_lock(&class->lock);
 	zspage = find_get_zspage(class);
 	if (likely(zspage)) {
@@ -1501,30 +1494,27 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	if (unlikely(!handle))
 		return;
 
-	pin_tag(handle);
+	/*
+	 * The pool->migrate_lock protects the race with zpage's migration
+	 * so it's safe to get the page from handle.
+	 */
+	read_lock(&pool->migrate_lock);
 	obj = handle_to_obj(handle);
 	obj_to_page(obj, &f_page);
 	zspage = get_zspage(f_page);
-
-	migrate_read_lock(zspage);
 	class = zspage_class(pool, zspage);
-
 	spin_lock(&class->lock);
+	read_unlock(&pool->migrate_lock);
+
 	obj_free(class->size, obj);
 	class_stat_dec(class, OBJ_USED, 1);
 	fullness = fix_fullness_group(class, zspage);
-	if (fullness != ZS_EMPTY) {
-		migrate_read_unlock(zspage);
+	if (fullness != ZS_EMPTY)
 		goto out;
-	}
 
-	migrate_read_unlock(zspage);
-	/* If zspage is isolated, zs_page_putback will free the zspage */
 	free_zspage(pool, class, zspage);
 out:
-
 	spin_unlock(&class->lock);
-	unpin_tag(handle);
 	cache_free_handle(pool, handle);
 }
 EXPORT_SYMBOL_GPL(zs_free);
@@ -1608,11 +1598,8 @@ static unsigned long find_alloced_obj(struct size_class *class,
 	offset += class->size * index;
 
 	while (offset < PAGE_SIZE) {
-		if (obj_allocated(page, addr + offset, &handle)) {
-			if (trypin_tag(handle))
-				break;
-			handle = 0;
-		}
+		if (obj_allocated(page, addr + offset, &handle))
+			break;
 
 		offset += class->size;
 		index++;
@@ -1658,7 +1645,6 @@ static int migrate_zspage(struct zs_pool *pool, struct size_class *class,
 
 		/* Stop if there is no more space */
 		if (zspage_full(class, get_zspage(d_page))) {
-			unpin_tag(handle);
 			ret = -ENOMEM;
 			break;
 		}
@@ -1667,15 +1653,7 @@ static int migrate_zspage(struct zs_pool *pool, struct size_class *class,
 		free_obj = obj_malloc(pool, get_zspage(d_page), handle);
 		zs_object_copy(class, free_obj, used_obj);
 		obj_idx++;
-		/*
-		 * record_obj updates handle's value to free_obj and it will
-		 * invalidate lock bit(ie, HANDLE_PIN_BIT) of handle, which
-		 * breaks synchronization using pin_tag(e,g, zs_free) so
-		 * let's keep the lock bit.
-		 */
-		free_obj |= BIT(HANDLE_PIN_BIT);
 		record_obj(handle, free_obj);
-		unpin_tag(handle);
 		obj_free(class->size, used_obj);
 	}
 
@@ -1789,6 +1767,11 @@ static void migrate_write_lock(struct zspage *zspage)
 	write_lock(&zspage->lock);
 }
 
+static void migrate_write_lock_nested(struct zspage *zspage)
+{
+	write_lock_nested(&zspage->lock, SINGLE_DEPTH_NESTING);
+}
+
 static void migrate_write_unlock(struct zspage *zspage)
 {
 	write_unlock(&zspage->lock);
@@ -1856,11 +1839,10 @@ static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
 	struct zspage *zspage;
 	struct page *dummy;
 	void *s_addr, *d_addr, *addr;
-	int offset, pos;
+	int offset;
 	unsigned long handle;
 	unsigned long old_obj, new_obj;
 	unsigned int obj_idx;
-	int ret = -EAGAIN;
 
 	/*
 	 * We cannot support the _NO_COPY case here, because copy needs to
@@ -1873,32 +1855,25 @@ static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
 	VM_BUG_ON_PAGE(!PageMovable(page), page);
 	VM_BUG_ON_PAGE(!PageIsolated(page), page);
 
-	zspage = get_zspage(page);
-
-	/* Concurrent compactor cannot migrate any subpage in zspage */
-	migrate_write_lock(zspage);
 	pool = mapping->private_data;
+
+	/*
+	 * The pool migrate_lock protects the race between zpage migration
+	 * and zs_free.
+	 */
+	write_lock(&pool->migrate_lock);
+	zspage = get_zspage(page);
 	class = zspage_class(pool, zspage);
-	offset = get_first_obj_offset(page);
 
+	/*
+	 * the class lock protects zpage alloc/free in the zspage.
+	 */
 	spin_lock(&class->lock);
-	if (!get_zspage_inuse(zspage)) {
-		/*
-		 * Set "offset" to end of the page so that every loops
-		 * skips unnecessary object scanning.
-		 */
-		offset = PAGE_SIZE;
-	}
+	/* the migrate_write_lock protects zpage access via zs_map_object */
+	migrate_write_lock(zspage);
 
-	pos = offset;
+	offset = get_first_obj_offset(page);
 	s_addr = kmap_atomic(page);
-	while (pos < PAGE_SIZE) {
-		if (obj_allocated(page, s_addr + pos, &handle)) {
-			if (!trypin_tag(handle))
-				goto unpin_objects;
-		}
-		pos += class->size;
-	}
 
 	/*
 	 * Here, any user cannot access all objects in the zspage so let's move.
@@ -1907,25 +1882,30 @@ static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
 	memcpy(d_addr, s_addr, PAGE_SIZE);
 	kunmap_atomic(d_addr);
 
-	for (addr = s_addr + offset; addr < s_addr + pos;
+	for (addr = s_addr + offset; addr < s_addr + PAGE_SIZE;
 					addr += class->size) {
 		if (obj_allocated(page, addr, &handle)) {
-			BUG_ON(!testpin_tag(handle));
 
 			old_obj = handle_to_obj(handle);
 			obj_to_location(old_obj, &dummy, &obj_idx);
 			new_obj = (unsigned long)location_to_obj(newpage,
 								obj_idx);
-			new_obj |= BIT(HANDLE_PIN_BIT);
 			record_obj(handle, new_obj);
 		}
 	}
+	kunmap_atomic(s_addr);
 
 	replace_sub_page(class, zspage, newpage, page);
-	get_page(newpage);
-
+	/*
+	 * Since we complete the data copy and set up new zspage structure,
+	 * it's okay to release migration_lock.
+	 */
+	write_unlock(&pool->migrate_lock);
+	spin_unlock(&class->lock);
 	dec_zspage_isolation(zspage);
+	migrate_write_unlock(zspage);
 
+	get_page(newpage);
 	if (page_zone(newpage) != page_zone(page)) {
 		dec_zone_page_state(page, NR_ZSPAGES);
 		inc_zone_page_state(newpage, NR_ZSPAGES);
@@ -1933,22 +1913,8 @@ static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
 
 	reset_page(page);
 	put_page(page);
-	page = newpage;
-
-	ret = MIGRATEPAGE_SUCCESS;
-unpin_objects:
-	for (addr = s_addr + offset; addr < s_addr + pos;
-						addr += class->size) {
-		if (obj_allocated(page, addr, &handle)) {
-			BUG_ON(!testpin_tag(handle));
-			unpin_tag(handle);
-		}
-	}
-	kunmap_atomic(s_addr);
-	spin_unlock(&class->lock);
-	migrate_write_unlock(zspage);
 
-	return ret;
+	return MIGRATEPAGE_SUCCESS;
 }
 
 static void zs_page_putback(struct page *page)
@@ -2077,8 +2043,13 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 	struct zspage *dst_zspage = NULL;
 	unsigned long pages_freed = 0;
 
+	/* protect the race between zpage migration and zs_free */
+	write_lock(&pool->migrate_lock);
+	/* protect zpage allocation/free */
 	spin_lock(&class->lock);
 	while ((src_zspage = isolate_zspage(class, true))) {
+		/* protect someone accessing the zspage(i.e., zs_map_object) */
+		migrate_write_lock(src_zspage);
 
 		if (!zs_can_compact(class))
 			break;
@@ -2087,6 +2058,8 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 		cc.s_page = get_first_page(src_zspage);
 
 		while ((dst_zspage = isolate_zspage(class, false))) {
+			migrate_write_lock_nested(dst_zspage);
+
 			cc.d_page = get_first_page(dst_zspage);
 			/*
 			 * If there is no more space in dst_page, resched
@@ -2096,6 +2069,10 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 				break;
 
 			putback_zspage(class, dst_zspage);
+			migrate_write_unlock(dst_zspage);
+			dst_zspage = NULL;
+			if (rwlock_is_contended(&pool->migrate_lock))
+				break;
 		}
 
 		/* Stop if we couldn't find slot */
@@ -2103,19 +2080,28 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 			break;
 
 		putback_zspage(class, dst_zspage);
+		migrate_write_unlock(dst_zspage);
+
 		if (putback_zspage(class, src_zspage) == ZS_EMPTY) {
+			migrate_write_unlock(src_zspage);
 			free_zspage(pool, class, src_zspage);
 			pages_freed += class->pages_per_zspage;
-		}
+		} else
+			migrate_write_unlock(src_zspage);
 		spin_unlock(&class->lock);
+		write_unlock(&pool->migrate_lock);
 		cond_resched();
+		write_lock(&pool->migrate_lock);
 		spin_lock(&class->lock);
 	}
 
-	if (src_zspage)
+	if (src_zspage) {
 		putback_zspage(class, src_zspage);
+		migrate_write_unlock(src_zspage);
+	}
 
 	spin_unlock(&class->lock);
+	write_unlock(&pool->migrate_lock);
 
 	return pages_freed;
 }
@@ -2221,6 +2207,7 @@ struct zs_pool *zs_create_pool(const char *name)
 		return NULL;
 
 	init_deferred_free(pool);
+	rwlock_init(&pool->migrate_lock);
 
 	pool->name = kstrdup(name, GFP_KERNEL);
 	if (!pool->name)
-- 
2.34.0.rc1.387.gb447b232ab-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898E9451DA6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346030AbhKPAb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345668AbhKOT3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:29:02 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962AFC06BCEB
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:59:20 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id b68so15833134pfg.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 10:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kp/n3vPVpQpSYjqQfcvRXiRJ5vffvwwCVDv5n3UxcVQ=;
        b=GWM+qeAv8mmsF9bJq0Z9EUbTGn0U1+Q0gaZPyYINVtllBeJfHpYqygPRvOxnB6f/Rf
         JF3ADNjF3AV7uPcXpj6NRwiiA3PqvjdIAWME/JzJ67Jh4n+hHtbfKFJKhb93aqvgkNpm
         QIos1TVXOapoIh2otXxmU5BY1nwmFbzolmHveWnMnrFCw7HNBEixH/27bzlTG95IOkjb
         UryiWmAU6NjK2PQd7Eo2DGYJJHeZ/GH5txIxX3XTYtUcD5tT/JZjsQ9bDVPNKfgzEN4M
         RCF9Q78SfFX16AhSjXnpccxN5OFW0LdHshatOHyEPD9s6TSzCeoeeRaSzNmRlK2g78EF
         Hmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Kp/n3vPVpQpSYjqQfcvRXiRJ5vffvwwCVDv5n3UxcVQ=;
        b=K1jHAb9J4+bdm3bXLC97MJWEzSANjgWCIciZKi4AUXyxbkUFVPqiNtVcgkcZjAPts+
         oi75+0nuHzB3xX7NbAyM8/bwDNKvKxjE7iZYAwcC8NvxEj6A6qwzlyHw7P7Sn9T70lFN
         mjIkR+pc23aVdrZTNTcs+826amXAJMix5UcDR6T1TvOiKnHVefL7ENFzxuf9mrptnj+w
         SBk7uC+YsevbJWfPzpJxliANWtCcJcVwWYpz2hAJinB7q0BKRjMmkmOb5xL5h9J1jTsy
         WfKs/DiS/SpufhgpSpGEyLCEKi8F2BU8+W7yK3LmS7zORp9rXToHlsjcbU6vL0SA9Ab8
         t1GQ==
X-Gm-Message-State: AOAM532RN60SJ+1V89dLarzDcZEwDPZ4WcNcXQOAiZBnwqDnVTrBUOMg
        TxGqwkgm/ypWz8043+cVnxk=
X-Google-Smtp-Source: ABdhPJz2+TmqGTNo8pAmZoqX8FEfs7OnLOY/43EUAUKB68+j6Rp3uv03qMkLLatszPMSl3Aqzv0nKw==
X-Received: by 2002:a63:924c:: with SMTP id s12mr756953pgn.416.1637002760042;
        Mon, 15 Nov 2021 10:59:20 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:7a54:8083:4365:b23d])
        by smtp.gmail.com with ESMTPSA id c3sm11882941pfv.67.2021.11.15.10.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 10:59:19 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2 6/9] zsmalloc: remove zspage isolation for migration
Date:   Mon, 15 Nov 2021 10:59:06 -0800
Message-Id: <20211115185909.3949505-7-minchan@kernel.org>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
In-Reply-To: <20211115185909.3949505-1-minchan@kernel.org>
References: <20211115185909.3949505-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zspage isolation for migration introduced additional exceptions
to be dealt with since the zspage was isolated from class list.
The reason why I isolated zspage from class list was to prevent
race between obj_malloc and page migration via allocating zpage
from the zspage further. However, it couldn't prevent object
freeing from zspage so it needed corner case handling.

This patch removes the whole mess. Now, we are fine since
class->lock and zspage->lock can prevent the race.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/zsmalloc.c | 157 +++-----------------------------------------------
 1 file changed, 8 insertions(+), 149 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 26e571cc354e..b8b098be92fa 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -254,10 +254,6 @@ struct zs_pool {
 #ifdef CONFIG_COMPACTION
 	struct inode *inode;
 	struct work_struct free_work;
-	/* A wait queue for when migration races with async_free_zspage() */
-	struct wait_queue_head migration_wait;
-	atomic_long_t isolated_pages;
-	bool destroying;
 #endif
 };
 
@@ -454,11 +450,6 @@ MODULE_ALIAS("zpool-zsmalloc");
 /* per-cpu VM mapping areas for zspage accesses that cross page boundaries */
 static DEFINE_PER_CPU(struct mapping_area, zs_map_area);
 
-static bool is_zspage_isolated(struct zspage *zspage)
-{
-	return zspage->isolated;
-}
-
 static __maybe_unused int is_first_page(struct page *page)
 {
 	return PagePrivate(page);
@@ -744,7 +735,6 @@ static void remove_zspage(struct size_class *class,
 				enum fullness_group fullness)
 {
 	VM_BUG_ON(list_empty(&class->fullness_list[fullness]));
-	VM_BUG_ON(is_zspage_isolated(zspage));
 
 	list_del_init(&zspage->list);
 	class_stat_dec(class, fullness, 1);
@@ -770,13 +760,9 @@ static enum fullness_group fix_fullness_group(struct size_class *class,
 	if (newfg == currfg)
 		goto out;
 
-	if (!is_zspage_isolated(zspage)) {
-		remove_zspage(class, zspage, currfg);
-		insert_zspage(class, zspage, newfg);
-	}
-
+	remove_zspage(class, zspage, currfg);
+	insert_zspage(class, zspage, newfg);
 	set_zspage_mapping(zspage, class_idx, newfg);
-
 out:
 	return newfg;
 }
@@ -1511,7 +1497,6 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	unsigned long obj;
 	struct size_class *class;
 	enum fullness_group fullness;
-	bool isolated;
 
 	if (unlikely(!handle))
 		return;
@@ -1533,11 +1518,9 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 		goto out;
 	}
 
-	isolated = is_zspage_isolated(zspage);
 	migrate_read_unlock(zspage);
 	/* If zspage is isolated, zs_page_putback will free the zspage */
-	if (likely(!isolated))
-		free_zspage(pool, class, zspage);
+	free_zspage(pool, class, zspage);
 out:
 
 	spin_unlock(&class->lock);
@@ -1718,7 +1701,6 @@ static struct zspage *isolate_zspage(struct size_class *class, bool source)
 		zspage = list_first_entry_or_null(&class->fullness_list[fg[i]],
 							struct zspage, list);
 		if (zspage) {
-			VM_BUG_ON(is_zspage_isolated(zspage));
 			remove_zspage(class, zspage, fg[i]);
 			return zspage;
 		}
@@ -1739,8 +1721,6 @@ static enum fullness_group putback_zspage(struct size_class *class,
 {
 	enum fullness_group fullness;
 
-	VM_BUG_ON(is_zspage_isolated(zspage));
-
 	fullness = get_fullness_group(class, zspage);
 	insert_zspage(class, zspage, fullness);
 	set_zspage_mapping(zspage, class->index, fullness);
@@ -1822,35 +1802,10 @@ static void inc_zspage_isolation(struct zspage *zspage)
 
 static void dec_zspage_isolation(struct zspage *zspage)
 {
+	VM_BUG_ON(zspage->isolated == 0);
 	zspage->isolated--;
 }
 
-static void putback_zspage_deferred(struct zs_pool *pool,
-				    struct size_class *class,
-				    struct zspage *zspage)
-{
-	enum fullness_group fg;
-
-	fg = putback_zspage(class, zspage);
-	if (fg == ZS_EMPTY)
-		schedule_work(&pool->free_work);
-
-}
-
-static inline void zs_pool_dec_isolated(struct zs_pool *pool)
-{
-	VM_BUG_ON(atomic_long_read(&pool->isolated_pages) <= 0);
-	atomic_long_dec(&pool->isolated_pages);
-	/*
-	 * Checking pool->destroying must happen after atomic_long_dec()
-	 * for pool->isolated_pages above. Paired with the smp_mb() in
-	 * zs_unregister_migration().
-	 */
-	smp_mb__after_atomic();
-	if (atomic_long_read(&pool->isolated_pages) == 0 && pool->destroying)
-		wake_up_all(&pool->migration_wait);
-}
-
 static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 				struct page *newpage, struct page *oldpage)
 {
@@ -1876,10 +1831,7 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 
 static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 {
-	struct zs_pool *pool;
-	struct size_class *class;
 	struct zspage *zspage;
-	struct address_space *mapping;
 
 	/*
 	 * Page is locked so zspage couldn't be destroyed. For detail, look at
@@ -1889,39 +1841,9 @@ static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 	VM_BUG_ON_PAGE(PageIsolated(page), page);
 
 	zspage = get_zspage(page);
-
-	mapping = page_mapping(page);
-	pool = mapping->private_data;
-
-	class = zspage_class(pool, zspage);
-
-	spin_lock(&class->lock);
-	if (get_zspage_inuse(zspage) == 0) {
-		spin_unlock(&class->lock);
-		return false;
-	}
-
-	/* zspage is isolated for object migration */
-	if (list_empty(&zspage->list) && !is_zspage_isolated(zspage)) {
-		spin_unlock(&class->lock);
-		return false;
-	}
-
-	/*
-	 * If this is first time isolation for the zspage, isolate zspage from
-	 * size_class to prevent further object allocation from the zspage.
-	 */
-	if (!list_empty(&zspage->list) && !is_zspage_isolated(zspage)) {
-		enum fullness_group fullness;
-		unsigned int class_idx;
-
-		get_zspage_mapping(zspage, &class_idx, &fullness);
-		atomic_long_inc(&pool->isolated_pages);
-		remove_zspage(class, zspage, fullness);
-	}
-
+	migrate_write_lock(zspage);
 	inc_zspage_isolation(zspage);
-	spin_unlock(&class->lock);
+	migrate_write_unlock(zspage);
 
 	return true;
 }
@@ -2004,21 +1926,6 @@ static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
 
 	dec_zspage_isolation(zspage);
 
-	/*
-	 * Page migration is done so let's putback isolated zspage to
-	 * the list if @page is final isolated subpage in the zspage.
-	 */
-	if (!is_zspage_isolated(zspage)) {
-		/*
-		 * We cannot race with zs_destroy_pool() here because we wait
-		 * for isolation to hit zero before we start destroying.
-		 * Also, we ensure that everyone can see pool->destroying before
-		 * we start waiting.
-		 */
-		putback_zspage_deferred(pool, class, zspage);
-		zs_pool_dec_isolated(pool);
-	}
-
 	if (page_zone(newpage) != page_zone(page)) {
 		dec_zone_page_state(page, NR_ZSPAGES);
 		inc_zone_page_state(newpage, NR_ZSPAGES);
@@ -2046,30 +1953,15 @@ static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
 
 static void zs_page_putback(struct page *page)
 {
-	struct zs_pool *pool;
-	struct size_class *class;
-	struct address_space *mapping;
 	struct zspage *zspage;
 
 	VM_BUG_ON_PAGE(!PageMovable(page), page);
 	VM_BUG_ON_PAGE(!PageIsolated(page), page);
 
 	zspage = get_zspage(page);
-	mapping = page_mapping(page);
-	pool = mapping->private_data;
-	class = zspage_class(pool, zspage);
-
-	spin_lock(&class->lock);
+	migrate_write_lock(zspage);
 	dec_zspage_isolation(zspage);
-	if (!is_zspage_isolated(zspage)) {
-		/*
-		 * Due to page_lock, we cannot free zspage immediately
-		 * so let's defer.
-		 */
-		putback_zspage_deferred(pool, class, zspage);
-		zs_pool_dec_isolated(pool);
-	}
-	spin_unlock(&class->lock);
+	migrate_write_unlock(zspage);
 }
 
 static const struct address_space_operations zsmalloc_aops = {
@@ -2091,36 +1983,8 @@ static int zs_register_migration(struct zs_pool *pool)
 	return 0;
 }
 
-static bool pool_isolated_are_drained(struct zs_pool *pool)
-{
-	return atomic_long_read(&pool->isolated_pages) == 0;
-}
-
-/* Function for resolving migration */
-static void wait_for_isolated_drain(struct zs_pool *pool)
-{
-
-	/*
-	 * We're in the process of destroying the pool, so there are no
-	 * active allocations. zs_page_isolate() fails for completely free
-	 * zspages, so we need only wait for the zs_pool's isolated
-	 * count to hit zero.
-	 */
-	wait_event(pool->migration_wait,
-		   pool_isolated_are_drained(pool));
-}
-
 static void zs_unregister_migration(struct zs_pool *pool)
 {
-	pool->destroying = true;
-	/*
-	 * We need a memory barrier here to ensure global visibility of
-	 * pool->destroying. Thus pool->isolated pages will either be 0 in which
-	 * case we don't care, or it will be > 0 and pool->destroying will
-	 * ensure that we wake up once isolation hits 0.
-	 */
-	smp_mb();
-	wait_for_isolated_drain(pool); /* This can block */
 	flush_work(&pool->free_work);
 	iput(pool->inode);
 }
@@ -2150,7 +2014,6 @@ static void async_free_zspage(struct work_struct *work)
 		spin_unlock(&class->lock);
 	}
 
-
 	list_for_each_entry_safe(zspage, tmp, &free_pages, list) {
 		list_del(&zspage->list);
 		lock_zspage(zspage);
@@ -2363,10 +2226,6 @@ struct zs_pool *zs_create_pool(const char *name)
 	if (!pool->name)
 		goto err;
 
-#ifdef CONFIG_COMPACTION
-	init_waitqueue_head(&pool->migration_wait);
-#endif
-
 	if (create_cache(pool))
 		goto err;
 
-- 
2.34.0.rc1.387.gb447b232ab-goog


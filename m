Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A420F3608AC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 13:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhDOL45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 07:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbhDOL4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 07:56:53 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D22C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 04:56:27 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id v6so35151056ejo.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 04:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mmzr1BXITN8/WsQtuIlDuVTV5ipAk7FG2VM5j+Bi1So=;
        b=QvQMXegx4Q6FfPIpt3BYD7d/rIzGJpkhRMRMpxNI2Jc9ovzo2ea9Po/pjK9xcot10J
         qfrgGeGvDxK0UtoQelPc859qvv3lCo3V+I61eOMYlY8VoruRr/1VzBriz8TYVT38gXGi
         bKsI+0K3iURKjYw5ibQslYc04LzCB2HkYJNOWtQdeJtmREQywEIO3U6qpcFFSzp1UUSr
         dtudZ7kiiIBbHYxn6lznMpdvme+RuMnAyO8YBP/JdG6KqY3gxKnonMJ2xQr0SQ3k8UEY
         6eAqAWXS/841WW5UHmuMlxOhssYyTS1s5DnIKzXWT6WFbvJt2mBq4t3ivxQ5Rtr6d49m
         ObjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mmzr1BXITN8/WsQtuIlDuVTV5ipAk7FG2VM5j+Bi1So=;
        b=QJUHW5BX2HoYYgf6TfPknoBHOCs+jGmVNLFU4VyqhQxXP6H+3tJyPNvHiLMiMRbDN7
         WFRQEK2iUnmnCkRnwTNWXhXHEQFrb589v8mBBHoRVGgt1jhz/Yrwoe5TtdMddAStL9tc
         h1TlVaOAP4v4LS10bcqC7/fQ9AJZ8JfisHdlkZfXXrrFHkm2RFlcR1MwMlTSfoYJ4nhJ
         x/WtX0gPhwVBQMH6YjMymJ+KTg4EC26ojN5IHg+Qz2iKSWim4hGk/Ttu4F5oYcVYVQN7
         QV0kDb6XwLVd+OEclqNcY1ExFrnMy3is8wmNnWamcI3BMrQpBojiaNJZLgc5KtR8JGPB
         oR0A==
X-Gm-Message-State: AOAM531ElvOBC9V8zwRq2fy0xMlTutPQIGZG3DL0osrPt+1kP7C4RHl6
        l8GDKHjryH3Jdcz61k/pTZ4=
X-Google-Smtp-Source: ABdhPJyRvFr8GCcyp6cP4pUhEHuqjgAxms+Re3dD8oeMsGnJsnFn3mLckPuF7TSkfuSpiaA2RZVQPA==
X-Received: by 2002:a17:906:278e:: with SMTP id j14mr3012533ejc.224.1618487786343;
        Thu, 15 Apr 2021 04:56:26 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:3ba1:ccd9:cd93:a8ed])
        by smtp.gmail.com with ESMTPSA id s9sm2182461edd.16.2021.04.15.04.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 04:56:26 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     vbabka@suse.cz, daniel@ffwll.ch, ray.huang@amd.com,
        akpm@linux-foundation.org
Subject: [PATCH 2/2] drm/ttm: optimize the pool shrinker a bit v2
Date:   Thu, 15 Apr 2021 13:56:24 +0200
Message-Id: <20210415115624.2904-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415115624.2904-1-christian.koenig@amd.com>
References: <20210415115624.2904-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch back to using a spinlock again by moving the IOMMU unmap outside
of the locked region.

v2: Add a comment explaining why we need sync_shrinkers().

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 44 +++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index cb38b1a17b09..955836d569cc 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -70,7 +70,7 @@ static struct ttm_pool_type global_uncached[MAX_ORDER];
 static struct ttm_pool_type global_dma32_write_combined[MAX_ORDER];
 static struct ttm_pool_type global_dma32_uncached[MAX_ORDER];
 
-static struct mutex shrinker_lock;
+static spinlock_t shrinker_lock;
 static struct list_head shrinker_list;
 static struct shrinker mm_shrinker;
 
@@ -263,9 +263,9 @@ static void ttm_pool_type_init(struct ttm_pool_type *pt, struct ttm_pool *pool,
 	spin_lock_init(&pt->lock);
 	INIT_LIST_HEAD(&pt->pages);
 
-	mutex_lock(&shrinker_lock);
+	spin_lock(&shrinker_lock);
 	list_add_tail(&pt->shrinker_list, &shrinker_list);
-	mutex_unlock(&shrinker_lock);
+	spin_unlock(&shrinker_lock);
 }
 
 /* Remove a pool_type from the global shrinker list and free all pages */
@@ -273,9 +273,9 @@ static void ttm_pool_type_fini(struct ttm_pool_type *pt)
 {
 	struct page *p;
 
-	mutex_lock(&shrinker_lock);
+	spin_lock(&shrinker_lock);
 	list_del(&pt->shrinker_list);
-	mutex_unlock(&shrinker_lock);
+	spin_unlock(&shrinker_lock);
 
 	while ((p = ttm_pool_type_take(pt)))
 		ttm_pool_free_page(pt->pool, pt->caching, pt->order, p);
@@ -313,24 +313,19 @@ static struct ttm_pool_type *ttm_pool_select_type(struct ttm_pool *pool,
 static unsigned int ttm_pool_shrink(void)
 {
 	struct ttm_pool_type *pt;
-	unsigned int num_freed;
 	struct page *p;
 
-	mutex_lock(&shrinker_lock);
+	spin_lock(&shrinker_lock);
 	pt = list_first_entry(&shrinker_list, typeof(*pt), shrinker_list);
+	list_move_tail(&pt->shrinker_list, &shrinker_list);
+	spin_unlock(&shrinker_lock);
 
 	p = ttm_pool_type_take(pt);
-	if (p) {
-		ttm_pool_free_page(pt->pool, pt->caching, pt->order, p);
-		num_freed = 1 << pt->order;
-	} else {
-		num_freed = 0;
-	}
-
-	list_move_tail(&pt->shrinker_list, &shrinker_list);
-	mutex_unlock(&shrinker_lock);
+	if (!p)
+		return 0;
 
-	return num_freed;
+	ttm_pool_free_page(pt->pool, pt->caching, pt->order, p);
+	return 1 << pt->order;
 }
 
 /* Return the allocation order based for a page */
@@ -530,6 +525,11 @@ void ttm_pool_fini(struct ttm_pool *pool)
 			for (j = 0; j < MAX_ORDER; ++j)
 				ttm_pool_type_fini(&pool->caching[i].orders[j]);
 	}
+
+	/* We removed the pool types from the LRU, but we need to also make sure
+	 * that no shrinker is concurrently freeing pages from the pool.
+	 */
+	sync_shrinkers();
 }
 
 /* As long as pages are available make sure to release at least one */
@@ -604,7 +604,7 @@ static int ttm_pool_debugfs_globals_show(struct seq_file *m, void *data)
 {
 	ttm_pool_debugfs_header(m);
 
-	mutex_lock(&shrinker_lock);
+	spin_lock(&shrinker_lock);
 	seq_puts(m, "wc\t:");
 	ttm_pool_debugfs_orders(global_write_combined, m);
 	seq_puts(m, "uc\t:");
@@ -613,7 +613,7 @@ static int ttm_pool_debugfs_globals_show(struct seq_file *m, void *data)
 	ttm_pool_debugfs_orders(global_dma32_write_combined, m);
 	seq_puts(m, "uc 32\t:");
 	ttm_pool_debugfs_orders(global_dma32_uncached, m);
-	mutex_unlock(&shrinker_lock);
+	spin_unlock(&shrinker_lock);
 
 	ttm_pool_debugfs_footer(m);
 
@@ -640,7 +640,7 @@ int ttm_pool_debugfs(struct ttm_pool *pool, struct seq_file *m)
 
 	ttm_pool_debugfs_header(m);
 
-	mutex_lock(&shrinker_lock);
+	spin_lock(&shrinker_lock);
 	for (i = 0; i < TTM_NUM_CACHING_TYPES; ++i) {
 		seq_puts(m, "DMA ");
 		switch (i) {
@@ -656,7 +656,7 @@ int ttm_pool_debugfs(struct ttm_pool *pool, struct seq_file *m)
 		}
 		ttm_pool_debugfs_orders(pool->caching[i].orders, m);
 	}
-	mutex_unlock(&shrinker_lock);
+	spin_unlock(&shrinker_lock);
 
 	ttm_pool_debugfs_footer(m);
 	return 0;
@@ -693,7 +693,7 @@ int ttm_pool_mgr_init(unsigned long num_pages)
 	if (!page_pool_size)
 		page_pool_size = num_pages;
 
-	mutex_init(&shrinker_lock);
+	spin_lock_init(&shrinker_lock);
 	INIT_LIST_HEAD(&shrinker_list);
 
 	for (i = 0; i < MAX_ORDER; ++i) {
-- 
2.25.1


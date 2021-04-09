Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CEA359632
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 09:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhDIHRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 03:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhDIHRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 03:17:41 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA41C061761
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 00:17:28 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h10so5307663edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 00:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gbjvidtHezwGj4SvL2Dc9DE4DP5+DorOADCoNSePk0o=;
        b=r5imc+noURb/sXKErdXVdbUdGts2IWxjfj5so6adBwjlq4IAcXJeNbVW/IydyIy8OE
         /ZvbzxhoSjZIJV8g3P3QepUFZSpKDDI+DbQJb2QHBnYlNkP6yByWo0arkonzdJRLYO6w
         juj+aswm7fZYfMB9yeZooUD2jpvciU2nweFoe3A2EeoCHr52pdDRQMTK1XzGU5Ntj+/e
         3gApRInc3hLv+qTx0pwI91QTLvAJ7RJYti7IJSVTrBM09paQbZwEKVSDb+s4dA0fqkRg
         1oUeeSfJJzvJQ3eLQwuWZFgsq895QmaCLfL080HYqTo8gZBp3teFwrPqQz55ckn8ZuEA
         riEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gbjvidtHezwGj4SvL2Dc9DE4DP5+DorOADCoNSePk0o=;
        b=Q8GIXvyeZzGsk6bYHwWgw+VTJdE/9oWEs1f7GZaemBfXji4321LffJzAVGy9u0uENY
         Akw/oK0eyqE2v7NcL4mx9ZBg1iovtJkjxjwSXqT8rF2DHZpNfn/x8irXhFyxl+QA2rIz
         XDTLVQp2hw2wnGB2PhVgB4bhIsNnwLx20uMozCLhEOX5on69Zw/cgymEK+kNnahKvH3y
         bkQZvp6uFgBTPOSbQI36Q6EGoaNGpTIw2gCEOZBBB5JPixWwp7Xr7RteslNWh4Ib6Tl4
         dX/4dxrpvesDlxIzD1vRgQU+LhRCm10BhT5jEm7YGUKeMPTbk95W4FA3r8PdiD5crnpc
         /NCQ==
X-Gm-Message-State: AOAM532/eWWyOfz+NXZHD0ZA+CqAvvFyCbBeFnDL48eQDT374smSc0ZB
        +NQKdKwXljqGnoId8COnEKk=
X-Google-Smtp-Source: ABdhPJwY0JBCnC6/OSxNGZjnksFU03VbvOIrPRv9gylJl43S3ie4aCAulRekCGDv/19tTtCYZA7oFg==
X-Received: by 2002:a05:6402:2786:: with SMTP id b6mr16140557ede.310.1617952647643;
        Fri, 09 Apr 2021 00:17:27 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:216f:9340:7a2b:4f98])
        by smtp.gmail.com with ESMTPSA id w1sm905369edt.89.2021.04.09.00.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 00:17:27 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     ray.huang@amd.com, daniel@ffwll.ch, akpm@linux-foundation.org
Subject: [PATCH 2/2] drm/ttm: optimize the pool shrinker a bit
Date:   Fri,  9 Apr 2021 09:17:25 +0200
Message-Id: <20210409071725.1532-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409071725.1532-1-christian.koenig@amd.com>
References: <20210409071725.1532-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch back to using a spinlock again by moving the IOMMU unmap outside
of the locked region.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 40 +++++++++++++++-------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index cb38b1a17b09..a8b4abe687ce 100644
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
@@ -530,6 +525,7 @@ void ttm_pool_fini(struct ttm_pool *pool)
 			for (j = 0; j < MAX_ORDER; ++j)
 				ttm_pool_type_fini(&pool->caching[i].orders[j]);
 	}
+	sync_shrinkers();
 }
 
 /* As long as pages are available make sure to release at least one */
@@ -604,7 +600,7 @@ static int ttm_pool_debugfs_globals_show(struct seq_file *m, void *data)
 {
 	ttm_pool_debugfs_header(m);
 
-	mutex_lock(&shrinker_lock);
+	spin_lock(&shrinker_lock);
 	seq_puts(m, "wc\t:");
 	ttm_pool_debugfs_orders(global_write_combined, m);
 	seq_puts(m, "uc\t:");
@@ -613,7 +609,7 @@ static int ttm_pool_debugfs_globals_show(struct seq_file *m, void *data)
 	ttm_pool_debugfs_orders(global_dma32_write_combined, m);
 	seq_puts(m, "uc 32\t:");
 	ttm_pool_debugfs_orders(global_dma32_uncached, m);
-	mutex_unlock(&shrinker_lock);
+	spin_unlock(&shrinker_lock);
 
 	ttm_pool_debugfs_footer(m);
 
@@ -640,7 +636,7 @@ int ttm_pool_debugfs(struct ttm_pool *pool, struct seq_file *m)
 
 	ttm_pool_debugfs_header(m);
 
-	mutex_lock(&shrinker_lock);
+	spin_lock(&shrinker_lock);
 	for (i = 0; i < TTM_NUM_CACHING_TYPES; ++i) {
 		seq_puts(m, "DMA ");
 		switch (i) {
@@ -656,7 +652,7 @@ int ttm_pool_debugfs(struct ttm_pool *pool, struct seq_file *m)
 		}
 		ttm_pool_debugfs_orders(pool->caching[i].orders, m);
 	}
-	mutex_unlock(&shrinker_lock);
+	spin_unlock(&shrinker_lock);
 
 	ttm_pool_debugfs_footer(m);
 	return 0;
@@ -693,7 +689,7 @@ int ttm_pool_mgr_init(unsigned long num_pages)
 	if (!page_pool_size)
 		page_pool_size = num_pages;
 
-	mutex_init(&shrinker_lock);
+	spin_lock_init(&shrinker_lock);
 	INIT_LIST_HEAD(&shrinker_list);
 
 	for (i = 0; i < MAX_ORDER; ++i) {
-- 
2.25.1


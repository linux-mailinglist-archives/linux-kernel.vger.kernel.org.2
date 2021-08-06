Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0187C3E28BA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 12:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245203AbhHFKf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 06:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245171AbhHFKfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 06:35:38 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C864C061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 03:35:22 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso17005180pjo.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 03:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IKCQ/okr5iljJwePP0m6CAMoXsbobtPnkjD6W+skqyo=;
        b=eO3i6t1P19bT8xob7l1GtOgvBlYOJjPxPvCEe6QH8sDLzYH/N3Xs7zLwoTM9RGG2+l
         r1N9WGCdM5RGB1cG6IG4UCA3ldUUw7skzyfXs1mvjNMeRTOXiR/NbGBggbdn0zU8QGmf
         q775bS7B9mZYsnBw5XRxcGeN1vOHASB0N/C9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IKCQ/okr5iljJwePP0m6CAMoXsbobtPnkjD6W+skqyo=;
        b=gcRi27oZJ5yUdKUHvja0KV/4dpFvSse60qpTMn5UfwWUxgROFWojhkwOfznqWak4QN
         irNpLk0v17/OZuYYk2beJh7bGf+ALcqIiVtn/aObIIje4B0j+g7hiWHrXMdtoMRQHh3B
         TGbrc85NnrSEBdCfcA2T1QzYhoj7GM4IRgD6bIQctktQLDA4oeQD9SUrHTmnzWPPRsWQ
         aPFrdZUVTGAfTOius/Pg6yU5sbqxzFA38lTW0NAicyTJPRhWzzgJcY3JBlV0zq6cUAjs
         /EOzHkW9cv4y6M59sCuYBumWcx0+giAYANBe4QP/G6/KtPIdx/40WOPlI1fGtoiJN2Yw
         pY+A==
X-Gm-Message-State: AOAM532SpJs5Wo5ZrZOrE6/aqpZ6bY+glJeJJHr9/w3d3wBm/trQ3TBO
        uPtMzsUAqD5unRovTSY2taGCDw==
X-Google-Smtp-Source: ABdhPJwlW9WSlnPrPnSbmSpQncK8C7B1iQBbkoI5GacfulnWrhGr/EcYL5ZNFJzvZtjW5EPKcRTdvQ==
X-Received: by 2002:a17:902:da8d:b029:12c:5241:c24e with SMTP id j13-20020a170902da8db029012c5241c24emr7907911plx.35.1628246122040;
        Fri, 06 Aug 2021 03:35:22 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:6f20:cf00:347a:afc2])
        by smtp.gmail.com with UTF8SMTPSA id 20sm10253358pfi.170.2021.08.06.03.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 03:35:21 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH v2 7/9] dma-iommu: support iommu bounce buffer optimization
Date:   Fri,  6 Aug 2021 19:34:21 +0900
Message-Id: <20210806103423.3341285-8-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
In-Reply-To: <20210806103423.3341285-1-stevensd@google.com>
References: <20210806103423.3341285-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

Add config that uses IOMMU bounce buffer pools to avoid IOMMU
interactions as much as possible for relatively small streaming DMA
operations. This can lead to significant performance improvements on
systems where IOMMU map/unmap operations are very slow, such as when
running virtualized.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/Kconfig             | 11 +++++
 drivers/iommu/dma-iommu.c         |  5 ++-
 drivers/iommu/io-bounce-buffers.c | 70 +++++++++++++++++++++----------
 drivers/iommu/io-buffer-manager.c | 17 +++++---
 drivers/iommu/io-buffer-manager.h |  8 ++--
 include/linux/dma-iommu.h         |  2 +
 6 files changed, 81 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 07b7c25cbed8..e573b5c276dc 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -422,4 +422,15 @@ config SPRD_IOMMU
 
 	  Say Y here if you want to use the multimedia devices listed above.
 
+config IOMMU_BOUNCE_BUFFERS
+	bool "Use IOMMU bounce buffers"
+	depends on IOMMU_DMA
+	default n
+	help
+	  Use bounce buffers for small, streaming DMA operations. This may
+	  have performance benefits on systems where establishing IOMMU mappings
+	  is particularly expensive, such as when running as a guest.
+
+	  If unsure, say N here.
+
 endif # IOMMU_SUPPORT
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 42f85b7a90f0..965bc0a2f140 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -324,7 +324,7 @@ static void iommu_dma_flush_iotlb_all(struct iova_domain *iovad)
 	domain->ops->flush_iotlb_all(domain);
 }
 
-static bool dev_is_untrusted(struct device *dev)
+bool dev_is_untrusted(struct device *dev)
 {
 	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
 }
@@ -402,7 +402,8 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 
 	ret = iova_reserve_iommu_regions(dev, domain);
 
-	if (ret == 0 && dev_is_untrusted(dev)) {
+	if (ret == 0 && (dev_is_untrusted(dev) ||
+			 IS_ENABLED(CONFIG_IOMMU_BOUNCE_BUFFERS))) {
 		cookie->bounce_buffers =
 			io_bounce_buffers_init(dev, domain, iovad);
 		if (IS_ERR(cookie->bounce_buffers))
diff --git a/drivers/iommu/io-bounce-buffers.c b/drivers/iommu/io-bounce-buffers.c
index 8af8e1546d5f..af8c2a51eeed 100644
--- a/drivers/iommu/io-bounce-buffers.c
+++ b/drivers/iommu/io-bounce-buffers.c
@@ -20,10 +20,20 @@
 static unsigned int buffer_pool_size = 1024;
 module_param(buffer_pool_size, uint, 0);
 
+#ifdef CONFIG_IOMMU_BOUNCE_BUFFERS
+// All buffers at most this size will always use bounce buffers if there
+// are slots of the appropriate size available.
+static unsigned int always_bounce_limit = PAGE_SIZE;
+module_param(always_bounce_limit, uint, 0644);
+#else
+static const unsigned int always_bounce_limit;
+#endif
+
 struct io_bounce_buffers {
 	struct iommu_domain *domain;
 	struct iova_domain *iovad;
 	unsigned int nid;
+	bool untrusted;
 	struct io_buffer_manager manager;
 };
 
@@ -56,6 +66,7 @@ struct io_bounce_buffers *io_bounce_buffers_init(struct device *dev,
 	buffers->domain = domain;
 	buffers->iovad = iovad;
 	buffers->nid = dev_to_node(dev);
+	buffers->untrusted = dev_is_untrusted(dev);
 
 	return buffers;
 }
@@ -201,7 +212,8 @@ bool io_bounce_buffers_sync_single(struct io_bounce_buffers *buffers,
 	void *orig_buffer;
 	int prot;
 
-	if (!io_buffer_manager_find_buffer(&buffers->manager, dma_handle, &info,
+	if (!io_buffer_manager_find_buffer(&buffers->manager, dma_handle,
+					   buffers->untrusted, &info,
 					   &orig_buffer, &prot))
 		return false;
 
@@ -237,9 +249,9 @@ bool io_bounce_buffers_sync_sg(struct io_bounce_buffers *buffers,
 	void *orig_buffer;
 	int prot;
 
-	if (!io_buffer_manager_find_buffer(&buffers->manager,
-					   sg_dma_address(sgl), &info,
-					   &orig_buffer, &prot))
+	if (!io_buffer_manager_find_buffer(
+		    &buffers->manager, sg_dma_address(sgl), buffers->untrusted,
+		    &info, &orig_buffer, &prot))
 		return false;
 
 	// In the non bounce buffer case, iommu_dma_map_sg syncs before setting
@@ -291,7 +303,7 @@ bool io_bounce_buffers_unmap_page(struct io_bounce_buffers *buffers,
 
 	return io_buffer_manager_release_buffer(
 		&buffers->manager, buffers->domain, handle, true,
-		io_bounce_buffers_unmap_page_sync, &args);
+		buffers->untrusted, io_bounce_buffers_unmap_page_sync, &args);
 }
 
 static void io_bounce_buffers_unmap_sg_sync(struct io_bounce_buffer_info *info,
@@ -318,7 +330,7 @@ bool io_bounce_buffers_unmap_sg(struct io_bounce_buffers *buffers,
 
 	return io_buffer_manager_release_buffer(
 		&buffers->manager, buffers->domain, sg_dma_address(sgl), true,
-		io_bounce_buffers_unmap_sg_sync, &args);
+		buffers->untrusted, io_bounce_buffers_unmap_sg_sync, &args);
 }
 
 static void io_bounce_buffers_clear_padding(struct io_bounce_buffer_info *info,
@@ -370,7 +382,8 @@ static bool io_bounce_buffers_map_buffer(struct io_bounce_buffers *buffers,
 	struct sg_table sgt;
 	size_t mapped;
 
-	if (offset || offset + orig_size < info->size || skiped_sync) {
+	if (buffers->untrusted &&
+	    (offset || offset + orig_size < info->size || skiped_sync)) {
 		// Ensure that nothing is leaked to untrusted devices when
 		// mapping the buffer by clearing any part of the bounce buffer
 		// that wasn't already cleared by syncing.
@@ -396,6 +409,15 @@ static bool io_bounce_buffers_map_buffer(struct io_bounce_buffers *buffers,
 	return mapped >= info->size;
 }
 
+static bool use_bounce_buffer(bool force_bounce, size_t size)
+{
+	if (IS_ENABLED(CONFIG_IOMMU_BOUNCE_BUFFERS) &&
+	    size <= always_bounce_limit)
+		return true;
+
+	return force_bounce;
+}
+
 bool io_bounce_buffers_map_page(struct io_bounce_buffers *buffers,
 				struct device *dev, struct page *page,
 				unsigned long offset, size_t size, int prot,
@@ -404,16 +426,17 @@ bool io_bounce_buffers_map_page(struct io_bounce_buffers *buffers,
 {
 	bool new_buffer, skip_cpu_sync = attrs & DMA_ATTR_SKIP_CPU_SYNC;
 	struct io_bounce_buffer_info info;
-	bool force_bounce = iova_offset(buffers->iovad, offset | size);
+	bool force_bounce = buffers->untrusted &&
+			    iova_offset(buffers->iovad, offset | size);
 
-	if (!force_bounce)
+	if (!use_bounce_buffer(force_bounce, size))
 		return false;
 
 	*handle = DMA_MAPPING_ERROR;
 	if (!io_buffer_manager_alloc_buffer(&buffers->manager, dev, page,
-					    offset + size, prot, buffers->nid,
-					    &info, &new_buffer))
-		return true;
+					    offset + size, prot, force_bounce,
+					    buffers->nid, &info, &new_buffer))
+		return force_bounce;
 
 	if (!skip_cpu_sync)
 		io_bounce_buffers_do_sync(buffers, info.bounce_buffer, offset,
@@ -424,8 +447,9 @@ bool io_bounce_buffers_map_page(struct io_bounce_buffers *buffers,
 					  offset, size)) {
 		io_buffer_manager_release_buffer(&buffers->manager,
 						 buffers->domain, info.iova,
-						 false, NULL, NULL);
-		return true;
+						 false, force_bounce, NULL,
+						 NULL);
+		return force_bounce;
 	}
 
 	*handle = info.iova + offset;
@@ -447,18 +471,19 @@ bool io_bounce_buffers_map_sg(struct io_bounce_buffers *buffers,
 
 	for_each_sg(sgl, iter, nents, i) {
 		size += iter->length;
-		force_bounce |= iova_offset(buffers->iovad,
-					    iter->offset | iter->length);
+		if (buffers->untrusted)
+			force_bounce |= iova_offset(
+				buffers->iovad, iter->offset | iter->length);
 	}
 
-	if (!force_bounce)
+	if (!use_bounce_buffer(force_bounce, size))
 		return false;
 
 	*out_nents = 0;
 	if (!io_buffer_manager_alloc_buffer(&buffers->manager, dev, sgl, size,
-					    prot, buffers->nid, &info,
-					    &new_buffer))
-		return true;
+					    prot, force_bounce, buffers->nid,
+					    &info, &new_buffer))
+		return force_bounce;
 
 	if (!skip_cpu_sync)
 		__io_bounce_buffers_sync_sg(buffers, sgl, nents,
@@ -470,8 +495,9 @@ bool io_bounce_buffers_map_sg(struct io_bounce_buffers *buffers,
 					  0, size)) {
 		io_buffer_manager_release_buffer(&buffers->manager,
 						 buffers->domain, info.iova,
-						 false, NULL, NULL);
-		return true;
+						 false, force_bounce, NULL,
+						 NULL);
+		return force_bounce;
 	}
 
 	i = 0;
diff --git a/drivers/iommu/io-buffer-manager.c b/drivers/iommu/io-buffer-manager.c
index 1c69df08603c..0f7f003b53bb 100644
--- a/drivers/iommu/io-buffer-manager.c
+++ b/drivers/iommu/io-buffer-manager.c
@@ -324,7 +324,8 @@ static bool io_buffer_manager_alloc_slot(struct io_buffer_manager *manager,
 
 bool io_buffer_manager_alloc_buffer(struct io_buffer_manager *manager,
 				    struct device *dev, void *orig_buffer,
-				    size_t size, int prot, unsigned int nid,
+				    size_t size, int prot, bool require_bounce,
+				    unsigned int nid,
 				    struct io_bounce_buffer_info *info,
 				    bool *new_buffer)
 {
@@ -336,6 +337,9 @@ bool io_buffer_manager_alloc_buffer(struct io_buffer_manager *manager,
 					 nid, info, new_buffer))
 		return true;
 
+	if (!require_bounce)
+		return false;
+
 	node = kzalloc(sizeof(*node), GFP_ATOMIC);
 	if (!node)
 		return false;
@@ -401,7 +405,7 @@ static bool __io_buffer_manager_find_slot(struct io_buffer_manager *manager,
 }
 
 bool io_buffer_manager_find_buffer(struct io_buffer_manager *manager,
-				   dma_addr_t handle,
+				   dma_addr_t handle, bool may_use_fallback,
 				   struct io_bounce_buffer_info *info,
 				   void **orig_buffer, int *prot)
 {
@@ -415,7 +419,8 @@ bool io_buffer_manager_find_buffer(struct io_buffer_manager *manager,
 		*orig_buffer = slot->orig_buffer;
 		*prot = slot->prot;
 		return true;
-	}
+	} else if (!may_use_fallback)
+		return false;
 
 	spin_lock_irqsave(&manager->fallback_lock, flags);
 	node = find_fallback_node(&manager->fallback_buffers, handle);
@@ -433,7 +438,8 @@ bool io_buffer_manager_find_buffer(struct io_buffer_manager *manager,
 bool io_buffer_manager_release_buffer(struct io_buffer_manager *manager,
 				      struct iommu_domain *domain,
 				      dma_addr_t handle, bool inited,
-				      prerelease_cb cb, void *ctx)
+				      bool may_use_fallback, prerelease_cb cb,
+				      void *ctx)
 {
 	struct io_buffer_slot *slot, **cache;
 	struct io_buffer_pool *pool;
@@ -472,7 +478,8 @@ bool io_buffer_manager_release_buffer(struct io_buffer_manager *manager,
 
 		spin_unlock_irqrestore(&pool->lock, flags);
 		return true;
-	}
+	} else if (!may_use_fallback)
+		return false;
 
 	spin_lock_irqsave(&manager->fallback_lock, flags);
 	node = find_fallback_node(&manager->fallback_buffers, handle);
diff --git a/drivers/iommu/io-buffer-manager.h b/drivers/iommu/io-buffer-manager.h
index 2aa3b9afcb3d..3d32f9366536 100644
--- a/drivers/iommu/io-buffer-manager.h
+++ b/drivers/iommu/io-buffer-manager.h
@@ -57,12 +57,13 @@ struct io_bounce_buffer_info {
 
 bool io_buffer_manager_alloc_buffer(struct io_buffer_manager *manager,
 				    struct device *dev, void *orig_buffer,
-				    size_t size, int prot, unsigned int nid,
+				    size_t size, int prot, bool use_fallback,
+				    unsigned int nid,
 				    struct io_bounce_buffer_info *info,
 				    bool *new_buffer);
 
 bool io_buffer_manager_find_buffer(struct io_buffer_manager *manager,
-				   dma_addr_t handle,
+				   dma_addr_t handle, bool may_use_fallback,
 				   struct io_bounce_buffer_info *info,
 				   void **orig_buffer, int *prot);
 
@@ -72,7 +73,8 @@ typedef void (*prerelease_cb)(struct io_bounce_buffer_info *info, int prot,
 bool io_buffer_manager_release_buffer(struct io_buffer_manager *manager,
 				      struct iommu_domain *domain,
 				      dma_addr_t handle, bool inited,
-				      prerelease_cb cb, void *ctx);
+				      bool may_use_fallback, prerelease_cb cb,
+				      void *ctx);
 
 int io_buffer_manager_init(struct io_buffer_manager *manager,
 			   struct device *dev, struct iova_domain *iovad,
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 944fd491d94f..70bed650d5d1 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -52,6 +52,8 @@ void __iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
 u64 __iommu_dma_limit(struct iommu_domain *domain,
 		      struct device *dev, u64 mask);
 
+bool dev_is_untrusted(struct device *dev);
+
 #else /* CONFIG_IOMMU_DMA */
 
 struct iommu_domain;
-- 
2.32.0.605.g8dce9f2422-goog


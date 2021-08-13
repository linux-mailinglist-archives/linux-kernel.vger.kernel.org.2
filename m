Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0CC3EB1DC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 09:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239479AbhHMHqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 03:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239726AbhHMHnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:43:53 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49372C06121D
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 00:42:45 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id q2so10767554plr.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 00:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rIU9X3CBq/5AqsD6O3iRvIx9yS+jn8jnQi951pLbz+Y=;
        b=CpWrapi04Qe3TlO+IfIPfGbmUXcMyRbAR+4u4GqI7kXEjimMNk3JQqXp2z6exXyUIi
         KCqsWNYbOmOUbo+1d+i18P4ga6EthnyczN+5BLJwq4D+z+qlagCgb37zV4aKLNguBtos
         tSaziCRjCyNfEZ62Ii7PVbcLp/euQgUbxe9bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rIU9X3CBq/5AqsD6O3iRvIx9yS+jn8jnQi951pLbz+Y=;
        b=lKdYfaqIFWKI3iyc8tayaWLoux0ejPUMJ7kwSKsYlKrBxtyjxU46R8cypbFS0fvTVw
         +kGUvJLZj6i5ZAjq7L9tSYrlfX8asElqzKs8LZoaq0dWBMaITun9NhE/FN/8/bhhuJwY
         Lej3EHeOia2f+jBd1xjcUP5iEUxuTfDe/NAmzjfnEft+Ps7rdyW4ruFRqdhSHaP4NUhC
         2JEVIU5SIJmvV5FilWPhcrT8GxwpB70H+SVSth0SEcS7fJ1hDJZIP+4pgPcsKL7Q/klm
         ZXFxl/PlwKbNMa/0c3va5t0wZSGbMqlBXRUiPYgwy91Lp1jR1xDoSs8wB0/NJkVDdf+1
         dQqg==
X-Gm-Message-State: AOAM530Xy4UBD0q5lmPePAkX+ig+cuIkbdYr1XnHlTK95Y/3mbVVQayQ
        MWFpKhhHKxhMvFbkpRHqgXuxUA==
X-Google-Smtp-Source: ABdhPJwxO/YyLMkdVX0p9Wg82OhRawlZrko1pQV28/p0kuQAJn+b1Qt9U1a17S7lCdRmtYeH2UGRAA==
X-Received: by 2002:a17:90a:9411:: with SMTP id r17mr1308830pjo.49.1628840564914;
        Fri, 13 Aug 2021 00:42:44 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:cbc8:5998:527e:5f43])
        by smtp.gmail.com with UTF8SMTPSA id g5sm1164326pfm.209.2021.08.13.00.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 00:42:44 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH v4 3/6] dma-iommu: skip extra sync during unmap w/swiotlb
Date:   Fri, 13 Aug 2021 16:38:36 +0900
Message-Id: <20210813073839.1562438-4-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
In-Reply-To: <20210813073839.1562438-1-stevensd@google.com>
References: <20210813073839.1562438-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

Calling the iommu_dma_sync_*_for_cpu functions during unmap can cause
two copies out of the swiotlb buffer. Fold __iommu_dma_unmap_swiotlb
into iommu_dma_unmap_page, and directly call arch_sync_dma_for_cpu
instead of iommu_dma_sync_single_for_cpu to avoid this double sync. With
this refactor, calling iommu_dma_sync_sg_for_cpu for untrusted devices
in iommu_dma_unmap_sg is also no longer necessary, so move that
invocation later in the function.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/dma-iommu.c | 42 +++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index e9119ff93535..f7da4934f7e6 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -493,23 +493,6 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
 	iommu_dma_free_iova(cookie, dma_addr, size, iotlb_gather.freelist);
 }
 
-static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
-		size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
-{
-	struct iommu_domain *domain = iommu_get_dma_domain(dev);
-	phys_addr_t phys;
-
-	phys = iommu_iova_to_phys(domain, dma_addr);
-	if (WARN_ON(!phys))
-		return;
-
-	__iommu_dma_unmap(dev, dma_addr, size);
-
-	if (unlikely(is_swiotlb_buffer(phys)))
-		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
-}
-
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 		size_t size, int prot, u64 dma_mask)
 {
@@ -845,9 +828,20 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
-	__iommu_dma_unmap_swiotlb(dev, dma_handle, size, dir, attrs);
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	phys_addr_t phys;
+
+	phys = iommu_iova_to_phys(domain, dma_handle);
+	if (WARN_ON(!phys))
+		return;
+
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) && !dev_is_dma_coherent(dev))
+		arch_sync_dma_for_cpu(phys, size, dir);
+
+	__iommu_dma_unmap(dev, dma_handle, size);
+
+	if (unlikely(is_swiotlb_buffer(phys)))
+		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
 }
 
 /*
@@ -932,7 +926,7 @@ static void iommu_dma_unmap_sg_swiotlb(struct device *dev, struct scatterlist *s
 	int i;
 
 	for_each_sg(sg, s, nents, i)
-		__iommu_dma_unmap_swiotlb(dev, sg_dma_address(s),
+		iommu_dma_unmap_page(dev, sg_dma_address(s),
 				sg_dma_len(s), dir, attrs);
 }
 
@@ -1053,14 +1047,14 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 	struct scatterlist *tmp;
 	int i;
 
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		iommu_dma_sync_sg_for_cpu(dev, sg, nents, dir);
-
 	if (dev_is_untrusted(dev)) {
 		iommu_dma_unmap_sg_swiotlb(dev, sg, nents, dir, attrs);
 		return;
 	}
 
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		iommu_dma_sync_sg_for_cpu(dev, sg, nents, dir);
+
 	/*
 	 * The scatterlist segments are mapped into a single
 	 * contiguous IOVA allocation, so this is incredibly easy.
-- 
2.33.0.rc1.237.g0d66db33f3-goog


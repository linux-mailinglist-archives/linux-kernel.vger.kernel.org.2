Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF64D41BCCB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 04:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243839AbhI2CfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 22:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243838AbhI2CfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 22:35:08 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FB6C061753
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 19:33:26 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id m26so687013pff.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 19:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iUall3U24zYRMxZTLu8QMiLAqNLbI9ECfniKcDwoTIk=;
        b=U6WCe0JD5h2qhkJ++CB96pGEtGWB1/F87pkVQv21QiLs3xgSNc3aRewG0x/j3yWuQg
         yFY8/CtwyaDGgWdL2NN3UQMcUh/wWNnpYPRzzCx16GuzK9uoLeQ60BVKh7il8hYXZloN
         q+zVwprx99aqCYhM2jrLu3qaiB1yAo4tOxtc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iUall3U24zYRMxZTLu8QMiLAqNLbI9ECfniKcDwoTIk=;
        b=J+hMcC7zXZwJxVTaPICwEwzAGmn9mf/tcFn/GYxRdLnD+dbGf0HccVMZOV4g+4mvs3
         2tzsE4JL8/12tMevQ4JSVvpZajpR8jU4vYIFBO0PHUKrg/slGacD1Crcp61BtEo94gaO
         Sal+FhMfLFwBHlVcotDEiO1D5RFzGDj2r01HQy2oNQ5+0g2ZbKAwnq7DxdE0ERvdGTjW
         2fr2I+PpeeXmEiRyskm32SGlqcOhKYW62IxRNNRNSTVx37DF93k1eogLg9rSB0rYGYhD
         w2dkD70V8+z1woa6TSl8YGRnDDROuW/JCQUeXcjzdeWRDLdIZXz+B0qoCFji61pDdSAy
         PgeA==
X-Gm-Message-State: AOAM533dTCf2XncOFW76uSNWeLZ0GY8Gm6Q04qGOrkmp7xA7JfamAwFv
        3tU9MoX2vR406/j8Lakf0DqaKQ==
X-Google-Smtp-Source: ABdhPJyaRXccGofSKYzMfOoRR3mP9Rg9/ZlL1e4fiIrckBhZWP0W8hFkn/6q2YxueaVpOnj1RhIArQ==
X-Received: by 2002:a63:b54b:: with SMTP id u11mr7492398pgo.163.1632882806082;
        Tue, 28 Sep 2021 19:33:26 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:f818:368:93ef:fa36])
        by smtp.gmail.com with UTF8SMTPSA id y15sm415897pfq.32.2021.09.28.19.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 19:33:25 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, Rajat Jain <rajatja@google.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH v8 4/7] dma-iommu: fold _swiotlb helpers into callers
Date:   Wed, 29 Sep 2021 11:32:57 +0900
Message-Id: <20210929023300.335969-5-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210929023300.335969-1-stevensd@google.com>
References: <20210929023300.335969-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

Fold the _swiotlb helper functions into the respective _page functions,
since recent fixes have moved all logic from the _page functions to the
_swiotlb functions.

Signed-off-by: David Stevens <stevensd@chromium.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 135 +++++++++++++++++---------------------
 1 file changed, 59 insertions(+), 76 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 027b489714b7..4f77c44eaf14 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -510,26 +510,6 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
 	iommu_dma_free_iova(cookie, dma_addr, size, &iotlb_gather);
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
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) && !dev_is_dma_coherent(dev))
-		arch_sync_dma_for_cpu(phys, size, dir);
-
-	__iommu_dma_unmap(dev, dma_addr, size);
-
-	if (unlikely(is_swiotlb_buffer(dev, phys)))
-		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
-}
-
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 		size_t size, int prot, u64 dma_mask)
 {
@@ -556,55 +536,6 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 	return iova + iova_off;
 }
 
-static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
-		size_t org_size, dma_addr_t dma_mask, bool coherent,
-		enum dma_data_direction dir, unsigned long attrs)
-{
-	int prot = dma_info_to_prot(dir, coherent, attrs);
-	struct iommu_domain *domain = iommu_get_dma_domain(dev);
-	struct iommu_dma_cookie *cookie = domain->iova_cookie;
-	struct iova_domain *iovad = &cookie->iovad;
-	size_t aligned_size = org_size;
-	void *padding_start;
-	size_t padding_size;
-	dma_addr_t iova;
-
-	/*
-	 * If both the physical buffer start address and size are
-	 * page aligned, we don't need to use a bounce page.
-	 */
-	if (IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev) &&
-	    iova_offset(iovad, phys | org_size)) {
-		aligned_size = iova_align(iovad, org_size);
-		phys = swiotlb_tbl_map_single(dev, phys, org_size,
-					      aligned_size, dir, attrs);
-
-		if (phys == DMA_MAPPING_ERROR)
-			return DMA_MAPPING_ERROR;
-
-		/* Cleanup the padding area. */
-		padding_start = phys_to_virt(phys);
-		padding_size = aligned_size;
-
-		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
-		    (dir == DMA_TO_DEVICE ||
-		     dir == DMA_BIDIRECTIONAL)) {
-			padding_start += org_size;
-			padding_size -= org_size;
-		}
-
-		memset(padding_start, 0, padding_size);
-	}
-
-	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		arch_sync_dma_for_device(phys, org_size, dir);
-
-	iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
-	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(dev, phys))
-		swiotlb_tbl_unmap_single(dev, phys, org_size, dir, attrs);
-	return iova;
-}
-
 static void __iommu_dma_free_pages(struct page **pages, int count)
 {
 	while (count--)
@@ -866,15 +797,68 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 {
 	phys_addr_t phys = page_to_phys(page) + offset;
 	bool coherent = dev_is_dma_coherent(dev);
+	int prot = dma_info_to_prot(dir, coherent, attrs);
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
+	size_t aligned_size = size;
+	dma_addr_t iova, dma_mask = dma_get_mask(dev);
+
+	/*
+	 * If both the physical buffer start address and size are
+	 * page aligned, we don't need to use a bounce page.
+	 */
+	if (IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev) &&
+	    iova_offset(iovad, phys | size)) {
+		void *padding_start;
+		size_t padding_size;
+
+		aligned_size = iova_align(iovad, size);
+		phys = swiotlb_tbl_map_single(dev, phys, size,
+					      aligned_size, dir, attrs);
+
+		if (phys == DMA_MAPPING_ERROR)
+			return DMA_MAPPING_ERROR;
 
-	return __iommu_dma_map_swiotlb(dev, phys, size, dma_get_mask(dev),
-			coherent, dir, attrs);
+		/* Cleanup the padding area. */
+		padding_start = phys_to_virt(phys);
+		padding_size = aligned_size;
+
+		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+		    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)) {
+			padding_start += size;
+			padding_size -= size;
+		}
+
+		memset(padding_start, 0, padding_size);
+	}
+
+	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		arch_sync_dma_for_device(phys, size, dir);
+
+	iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
+	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(dev, phys))
+		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
+	return iova;
 }
 
 static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
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
+	if (unlikely(is_swiotlb_buffer(dev, phys)))
+		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
 }
 
 /*
@@ -959,7 +943,7 @@ static void iommu_dma_unmap_sg_swiotlb(struct device *dev, struct scatterlist *s
 	int i;
 
 	for_each_sg(sg, s, nents, i)
-		__iommu_dma_unmap_swiotlb(dev, sg_dma_address(s),
+		iommu_dma_unmap_page(dev, sg_dma_address(s),
 				sg_dma_len(s), dir, attrs);
 }
 
@@ -970,9 +954,8 @@ static int iommu_dma_map_sg_swiotlb(struct device *dev, struct scatterlist *sg,
 	int i;
 
 	for_each_sg(sg, s, nents, i) {
-		sg_dma_address(s) = __iommu_dma_map_swiotlb(dev, sg_phys(s),
-				s->length, dma_get_mask(dev),
-				dev_is_dma_coherent(dev), dir, attrs);
+		sg_dma_address(s) = iommu_dma_map_page(dev, sg_page(s),
+				s->offset, s->length, dir, attrs);
 		if (sg_dma_address(s) == DMA_MAPPING_ERROR)
 			goto out_unmap;
 		sg_dma_len(s) = s->length;
-- 
2.33.0.685.g46640cef36-goog


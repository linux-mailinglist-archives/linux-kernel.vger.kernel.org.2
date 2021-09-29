Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7373641BCCD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 04:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243813AbhI2CfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 22:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243815AbhI2CfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 22:35:10 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B00C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 19:33:30 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id om12-20020a17090b3a8c00b0019eff43daf5so693915pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 19:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Avq5RbT/lx2fFWwn1+oBZcpxY4DeWLbxCwAyQKZBr6Q=;
        b=RsreUQtZHkHMdFYzbWrJEWkO7v8DByvMn1Cm55K01vrJ1BdE5FqMiOk5XvGjmjn13/
         wSIaJmMt0JynoNYnAzFDSVZrdZYO3yC+c5NuctFmkYv98pT7ka6WOlQwreGFcPNdDx0z
         s0hS+MgpU3CYbpJ+OckbEQsOtASV0wdfMOErM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Avq5RbT/lx2fFWwn1+oBZcpxY4DeWLbxCwAyQKZBr6Q=;
        b=pDMW5NzQ23Bhoi26OlJRFb1tPF0QUHaNcWIsF4SybxplE8OBDrPQRYDTOa8CEtmXUD
         xg0ubP6yRF8nt1SIxmK9z8LbSFemVPZ7utw6hkYJogHU8Hmd6U2xncu3cY9e81vEx+V4
         dFa8ndbkXewb/ARCf3V0YfdJVUyAJVmnmK9/6+X5PhynKP788cux4HTWXKJAylvOqz3l
         Xc/9SopkPWYp5wAI9K6kF9imRQuPNMnD8tksDUlHIz/zZ/t7lYuOpWzP7MXxSc6leobp
         x6TSABBaSYyGrFQXAT2+i6EevjRa2hKxzclIOWxdaliP+1slBd19Baqinz7XzpFZeY4e
         BsqA==
X-Gm-Message-State: AOAM533PgcEVLmpe4GzhrYKYl7N3dnNojYetEEtWpjYPDTZqhrroeriB
        NmHWK5TaWwvGL0Zo/HJtFnJECg==
X-Google-Smtp-Source: ABdhPJyoSPNVeVmBl31+olu0YXEa5foZN5sfKsQOK+2mvMYcLDsnB8Wy+WaCIoBB0kmqTaWZjrbMdw==
X-Received: by 2002:a17:90a:49:: with SMTP id 9mr3654873pjb.80.1632882810263;
        Tue, 28 Sep 2021 19:33:30 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:f818:368:93ef:fa36])
        by smtp.gmail.com with UTF8SMTPSA id k3sm27354pjg.43.2021.09.28.19.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 19:33:30 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, Rajat Jain <rajatja@google.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH v8 5/7] dma-iommu: Check CONFIG_SWIOTLB more broadly
Date:   Wed, 29 Sep 2021 11:32:58 +0900
Message-Id: <20210929023300.335969-6-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210929023300.335969-1-stevensd@google.com>
References: <20210929023300.335969-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

Introduce a new dev_use_swiotlb function to guard swiotlb code, instead
of overloading dev_is_untrusted. This allows CONFIG_SWIOTLB to be
checked more broadly, so the swiotlb related code can be removed more
aggressively.

Signed-off-by: David Stevens <stevensd@chromium.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 4f77c44eaf14..85a005b268f6 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -317,6 +317,11 @@ static bool dev_is_untrusted(struct device *dev)
 	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
 }
 
+static bool dev_use_swiotlb(struct device *dev)
+{
+	return IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev);
+}
+
 /* sysfs updates are serialised by the mutex of the group owning @domain */
 int iommu_dma_init_fq(struct iommu_domain *domain)
 {
@@ -731,7 +736,7 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
 {
 	phys_addr_t phys;
 
-	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
+	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
@@ -747,7 +752,7 @@ static void iommu_dma_sync_single_for_device(struct device *dev,
 {
 	phys_addr_t phys;
 
-	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
+	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
@@ -765,7 +770,7 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	if (dev_is_untrusted(dev))
+	if (dev_use_swiotlb(dev))
 		for_each_sg(sgl, sg, nelems, i)
 			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
 						      sg->length, dir);
@@ -781,7 +786,7 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	if (dev_is_untrusted(dev))
+	if (dev_use_swiotlb(dev))
 		for_each_sg(sgl, sg, nelems, i)
 			iommu_dma_sync_single_for_device(dev,
 							 sg_dma_address(sg),
@@ -808,8 +813,7 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	 * If both the physical buffer start address and size are
 	 * page aligned, we don't need to use a bounce page.
 	 */
-	if (IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev) &&
-	    iova_offset(iovad, phys | size)) {
+	if (dev_use_swiotlb(dev) && iova_offset(iovad, phys | size)) {
 		void *padding_start;
 		size_t padding_size;
 
@@ -994,7 +998,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		goto out;
 	}
 
-	if (dev_is_untrusted(dev))
+	if (dev_use_swiotlb(dev))
 		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
 
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
@@ -1072,7 +1076,7 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 	struct scatterlist *tmp;
 	int i;
 
-	if (dev_is_untrusted(dev)) {
+	if (dev_use_swiotlb(dev)) {
 		iommu_dma_unmap_sg_swiotlb(dev, sg, nents, dir, attrs);
 		return;
 	}
-- 
2.33.0.685.g46640cef36-goog


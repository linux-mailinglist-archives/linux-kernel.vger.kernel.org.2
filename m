Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215FB3B9C0D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 07:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhGBFoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 01:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhGBFoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 01:44:20 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC5BC061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 22:41:48 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id a14so4799743pls.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 22:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D7zlF8y2JuYoUJhE1oS1iaGOUuZ9xQp++/xChxOT/IQ=;
        b=CAndttSGtAP+dzCgzlXnCQnfyHTh00G3Un/RT6vLy88Zq7jP1mUVl/TctvWNlbpUeO
         cWmUCCPHo3kGrZ0s/pAI5odjreiYA/OlzonX/6GB4NQ5I0euxSkytDq04sN2FmKJq0eK
         aTrNrWgopIDaT8JIzGsu8esAr4uWcnvo8yOFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D7zlF8y2JuYoUJhE1oS1iaGOUuZ9xQp++/xChxOT/IQ=;
        b=UEXgQUFOg42DeCBHKVJai0jqkrbHt35nB2NmNtqhz+ouiGy0+auRm9BqFNuo4qNY8R
         uZVx0a4NZWoUv1QDOb4cUOeFQBQDO/0GiwWIierVehTWnzbQF0ikKf/QDqExqwmPFD2b
         K+DwDGmhsn6k6qsH2Y/9QWsosHpTP3nb1hmSaL/pgdPlKXc5DkyiLQqitmouV5p5OAj6
         a0Ny7H93+iD7UUEW8qSW7xNNM3n2mkrzR2KX2gN0kk77na/PDeLhx+qqiCVSD6bgLOC9
         QX34+zEL33tiS9OlJYPXzHni51TdZgDMpqd2hdplz/KswCR030YHz9XV+zw3najWWIKz
         +npA==
X-Gm-Message-State: AOAM5316kSY8qqOMmCLUSc0iOlKRDp+JiBnU8owBWD0LmPopPt4QJlYl
        FAo4XIiI6qZNzTPAxd/H5f4cWA==
X-Google-Smtp-Source: ABdhPJxi/f+AQb94i0BZjuuD2GzHRRZEWoXuyNGP1UE+QuaGaQnRl0oSvWTnSbgt2900nHst8ZFcEA==
X-Received: by 2002:a17:902:ab8e:b029:125:e6a0:fea2 with SMTP id f14-20020a170902ab8eb0290125e6a0fea2mr3150377plr.41.1625204507886;
        Thu, 01 Jul 2021 22:41:47 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:21b7:6cc1:2d7d:b4])
        by smtp.gmail.com with UTF8SMTPSA id d127sm1887619pfc.50.2021.07.01.22.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 22:41:47 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, Tom Murphy <murphyt7@tcd.ie>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH 2/2] dma-iommu: Check CONFIG_SWIOTLB more broadly
Date:   Fri,  2 Jul 2021 14:37:42 +0900
Message-Id: <20210702053742.842850-2-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210702053742.842850-1-stevensd@google.com>
References: <20210702053742.842850-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

Add check for CONFIG_SWIOTLB to dev_is_untrusted, so that swiotlb
related code can be removed more aggressively.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/dma-iommu.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 24d1042cd052..614f0dd86b08 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -310,9 +310,10 @@ static void iommu_dma_flush_iotlb_all(struct iova_domain *iovad)
 	domain->ops->flush_iotlb_all(domain);
 }
 
-static bool dev_is_untrusted(struct device *dev)
+static bool dev_use_swiotlb(struct device *dev)
 {
-	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
+	return IS_ENABLED(CONFIG_SWIOTLB) &&
+	       dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
 }
 
 /**
@@ -368,7 +369,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 
 	init_iova_domain(iovad, 1UL << order, base_pfn);
 
-	if (!cookie->fq_domain && (!dev || !dev_is_untrusted(dev)) &&
+	if (!cookie->fq_domain && (!dev || !dev_use_swiotlb(dev)) &&
 	    domain->ops->flush_iotlb_all && !iommu_get_dma_strict(domain)) {
 		if (init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all,
 					  iommu_dma_entry_dtor))
@@ -553,8 +554,7 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
 	 * If both the physical buffer start address and size are
 	 * page aligned, we don't need to use a bounce page.
 	 */
-	if (IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev) &&
-	    iova_offset(iovad, phys | org_size)) {
+	if (dev_use_swiotlb(dev) && iova_offset(iovad, phys | org_size)) {
 		aligned_size = iova_align(iovad, org_size);
 		phys = swiotlb_tbl_map_single(dev, phys, org_size,
 					      aligned_size, dir,
@@ -779,7 +779,7 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
 {
 	phys_addr_t phys;
 
-	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
+	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
@@ -794,7 +794,7 @@ static void __iommu_dma_sync_single_for_device(struct device *dev,
 		dma_addr_t dma_handle, size_t size,
 		enum dma_data_direction dir, phys_addr_t phys)
 {
-	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
+	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
 		return;
 
 	if (phys == 0)
@@ -821,10 +821,10 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
+	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
 		return;
 
-	if (dev_is_untrusted(dev))
+	if (dev_use_swiotlb(dev))
 		for_each_sg(sgl, sg, nelems, i)
 			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
 						      sg->length, dir);
@@ -840,10 +840,10 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
+	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
 		return;
 
-	if (dev_is_untrusted(dev))
+	if (dev_use_swiotlb(dev))
 		for_each_sg(sgl, sg, nelems, i)
 			__iommu_dma_sync_single_for_device(dev,
 							   sg_dma_address(sg),
@@ -1010,7 +1010,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	    iommu_deferred_attach(dev, domain))
 		return 0;
 
-	if (dev_is_untrusted(dev)) {
+	if (dev_use_swiotlb(dev)) {
 		early_mapped = iommu_dma_map_sg_swiotlb(dev, sg, nents,
 							dir, attrs);
 		if (!early_mapped)
@@ -1092,7 +1092,7 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_sg_for_cpu(dev, sg, nents, dir);
 
-	if (dev_is_untrusted(dev)) {
+	if (dev_use_swiotlb(dev)) {
 		iommu_dma_unmap_sg_swiotlb(dev, sg, nents, dir, attrs);
 		return;
 	}
-- 
2.32.0.93.g670b81a890-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC78B3B9C0C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 07:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhGBFoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 01:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhGBFoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 01:44:17 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4899EC061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 22:41:45 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 21so8041277pfp.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 22:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zAwD45KsI2uIcfr8Yqj6+SKk/uIGvPhpEyAUZslXh6M=;
        b=PlnDwwWqNVV8/2utfWGm8o1PTATjGBuFM9pG3Q6ARMsRIUFXv5uvavoHguUIgKibh5
         036Q5eUayl6uJm4l3UWTelUXVAWCuFBW4UbLutIROyzigIRjXXOY98igBKVRW2qozlg+
         DTnS5z+aio+fKtiW2ZoaazGQLDcxeQuAAf3I0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zAwD45KsI2uIcfr8Yqj6+SKk/uIGvPhpEyAUZslXh6M=;
        b=rhEqXlojOET0buHQCKOR0jIiBL0XH7MhNzR26bQLRQBsAGr/ci/cpf1gSnl4nPyyqi
         CkLkHgsYaMJK/hXGLuKKu5y0XygcAR3Rms6zzuj2jEsDiAyKpRu95eyehPBvB75xIAS7
         LCuzMrGoddK08ieH8pcPkP7Qf7CPduA0Z9Vy+I1A5Z9rWOQYoUU4BhX4g4lyLxIY6rcB
         Btde1jSnUfYV0nri+zdf+wjnGc7PbiHxgmtEB1s3eiKXq3zBd1Lvetkgq0vNUBao0xv3
         rLyU7K3ayCLugPuHpl09bBxn8/yiqs3uNatbIlAPdUY6482zbqSP8ERMrOx47qd/MklD
         Jc5g==
X-Gm-Message-State: AOAM533QkAQYIRijAK2dw2rVKC2bBwk1RlhFMbGcBAFbAQoeVsSU/BHV
        AedoOS/ZxU+L5NHZKbnC8srIOCliBOb8ug==
X-Google-Smtp-Source: ABdhPJx4B9mCHjbOyCg2uapQgRRYladp7cHV/uj4+NV3dZmkMlotMTsoG/WZMZotQAs0TujbrhRwVQ==
X-Received: by 2002:aa7:9586:0:b029:30f:a816:a5ef with SMTP id z6-20020aa795860000b029030fa816a5efmr3743120pfj.27.1625204504496;
        Thu, 01 Jul 2021 22:41:44 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:21b7:6cc1:2d7d:b4])
        by smtp.gmail.com with UTF8SMTPSA id h3sm1916647pfe.186.2021.07.01.22.41.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 22:41:43 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, Tom Murphy <murphyt7@tcd.ie>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH 1/2] dma-iommu: fix swiotlb SKIP_CPU_SYNC and arch sync
Date:   Fri,  2 Jul 2021 14:37:41 +0900
Message-Id: <20210702053742.842850-1-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

Make map_swiotlb and unmap_swiotlb only for mapping, and consistently
use sync_single_for and sync_sg_for functions for swiotlb sync and arch
sync. This ensures that the same code path is responsible for syncing
regardless of whether or not SKIP_CPU_SYNC is set. In the process, fix
various places where the original physical address and swiotlb tlb_addr
are mixed up:
  - Make sync_sg functions call sync_single functions for untrusted
    devices, so they use tlb_addr when checking is_swiotlb_buffer and
    when doing arch sync if necessary.
  - Use tlb_addr for arch sync in map_page if necessary.
  - In map_sg, map before syncing so that arch sync can target the
    bounce buffer if necessary.
  - Pass SKIP_CPU_SYNC to swiotlb map and unmap to avoid double syncing
    the swiotlb. This had previously only happened in the unmap_page
    case, but is now necessary for all swiotlb cases.

Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/dma-iommu.c | 82 ++++++++++++++++++++++++---------------
 1 file changed, 51 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7bcdd1205535..24d1042cd052 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -505,7 +505,8 @@ static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
 	__iommu_dma_unmap(dev, dma_addr, size);
 
 	if (unlikely(is_swiotlb_buffer(phys)))
-		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
+		swiotlb_tbl_unmap_single(dev, phys, size, dir,
+					 attrs | DMA_ATTR_SKIP_CPU_SYNC);
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
@@ -536,7 +537,8 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 
 static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
 		size_t org_size, dma_addr_t dma_mask, bool coherent,
-		enum dma_data_direction dir, unsigned long attrs)
+		enum dma_data_direction dir, unsigned long attrs,
+		phys_addr_t *adj_phys)
 {
 	int prot = dma_info_to_prot(dir, coherent, attrs);
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
@@ -555,7 +557,8 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
 	    iova_offset(iovad, phys | org_size)) {
 		aligned_size = iova_align(iovad, org_size);
 		phys = swiotlb_tbl_map_single(dev, phys, org_size,
-					      aligned_size, dir, attrs);
+					      aligned_size, dir,
+					      attrs | DMA_ATTR_SKIP_CPU_SYNC);
 
 		if (phys == DMA_MAPPING_ERROR)
 			return DMA_MAPPING_ERROR;
@@ -573,6 +576,8 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
 
 		memset(padding_start, 0, padding_size);
 	}
+	if (adj_phys)
+		*adj_phys = phys;
 
 	iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
 	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(phys))
@@ -785,15 +790,17 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
 		swiotlb_sync_single_for_cpu(dev, phys, size, dir);
 }
 
-static void iommu_dma_sync_single_for_device(struct device *dev,
-		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
+static void __iommu_dma_sync_single_for_device(struct device *dev,
+		dma_addr_t dma_handle, size_t size,
+		enum dma_data_direction dir, phys_addr_t phys)
 {
-	phys_addr_t phys;
-
 	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
 		return;
 
-	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
+	if (phys == 0)
+		phys = iommu_iova_to_phys(iommu_get_dma_domain(dev),
+					  dma_handle);
+
 	if (is_swiotlb_buffer(phys))
 		swiotlb_sync_single_for_device(dev, phys, size, dir);
 
@@ -801,6 +808,12 @@ static void iommu_dma_sync_single_for_device(struct device *dev,
 		arch_sync_dma_for_device(phys, size, dir);
 }
 
+static void iommu_dma_sync_single_for_device(struct device *dev,
+		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
+{
+	__iommu_dma_sync_single_for_device(dev, dma_handle, size, dir, 0);
+}
+
 static void iommu_dma_sync_sg_for_cpu(struct device *dev,
 		struct scatterlist *sgl, int nelems,
 		enum dma_data_direction dir)
@@ -811,14 +824,13 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
 	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
 		return;
 
-	for_each_sg(sgl, sg, nelems, i) {
-		if (!dev_is_dma_coherent(dev))
+	if (dev_is_untrusted(dev))
+		for_each_sg(sgl, sg, nelems, i)
+			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
+						      sg->length, dir);
+	else
+		for_each_sg(sgl, sg, nelems, i)
 			arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
-
-		if (is_swiotlb_buffer(sg_phys(sg)))
-			swiotlb_sync_single_for_cpu(dev, sg_phys(sg),
-						    sg->length, dir);
-	}
 }
 
 static void iommu_dma_sync_sg_for_device(struct device *dev,
@@ -831,29 +843,30 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
 		return;
 
-	for_each_sg(sgl, sg, nelems, i) {
-		if (is_swiotlb_buffer(sg_phys(sg)))
-			swiotlb_sync_single_for_device(dev, sg_phys(sg),
-						       sg->length, dir);
-
-		if (!dev_is_dma_coherent(dev))
+	if (dev_is_untrusted(dev))
+		for_each_sg(sgl, sg, nelems, i)
+			__iommu_dma_sync_single_for_device(dev,
+							   sg_dma_address(sg),
+							   sg->length, dir, 0);
+	else
+		for_each_sg(sgl, sg, nelems, i)
 			arch_sync_dma_for_device(sg_phys(sg), sg->length, dir);
-	}
 }
 
 static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, enum dma_data_direction dir,
 		unsigned long attrs)
 {
-	phys_addr_t phys = page_to_phys(page) + offset;
+	phys_addr_t phys = page_to_phys(page) + offset, adj_phys;
 	bool coherent = dev_is_dma_coherent(dev);
 	dma_addr_t dma_handle;
 
-	dma_handle = __iommu_dma_map_swiotlb(dev, phys, size, dma_get_mask(dev),
-			coherent, dir, attrs);
-	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+	dma_handle = __iommu_dma_map_swiotlb(dev, phys, size,
+			dma_get_mask(dev), coherent, dir, attrs, &adj_phys);
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    dma_handle != DMA_MAPPING_ERROR)
-		arch_sync_dma_for_device(phys, size, dir);
+		__iommu_dma_sync_single_for_device(dev, dma_handle, size,
+						   dir, adj_phys);
 	return dma_handle;
 }
 
@@ -960,7 +973,7 @@ static int iommu_dma_map_sg_swiotlb(struct device *dev, struct scatterlist *sg,
 	for_each_sg(sg, s, nents, i) {
 		sg_dma_address(s) = __iommu_dma_map_swiotlb(dev, sg_phys(s),
 				s->length, dma_get_mask(dev),
-				dev_is_dma_coherent(dev), dir, attrs);
+				dev_is_dma_coherent(dev), dir, attrs, NULL);
 		if (sg_dma_address(s) == DMA_MAPPING_ERROR)
 			goto out_unmap;
 		sg_dma_len(s) = s->length;
@@ -991,17 +1004,24 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	dma_addr_t iova;
 	size_t iova_len = 0;
 	unsigned long mask = dma_get_seg_boundary(dev);
-	int i;
+	int i, early_mapped = 0;
 
 	if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
 	    iommu_deferred_attach(dev, domain))
 		return 0;
 
+	if (dev_is_untrusted(dev)) {
+		early_mapped = iommu_dma_map_sg_swiotlb(dev, sg, nents,
+							dir, attrs);
+		if (!early_mapped)
+			return 0;
+	}
+
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_sg_for_device(dev, sg, nents, dir);
 
-	if (dev_is_untrusted(dev))
-		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
+	if (early_mapped)
+		return early_mapped;
 
 	/*
 	 * Work out how much IOVA space we need, and align the segments to
-- 
2.32.0.93.g670b81a890-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF533EB1D7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 09:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239663AbhHMHoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 03:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239652AbhHMHoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:44:00 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C559DC06122E
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 00:42:56 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id a20so10853732plm.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 00:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tBsX0MVHwtbJoJcOekTIeXMGpx0HIEfEiJde7/PcK80=;
        b=OmALWYXMW8a4RIeVEpkPuSzowOM17UfLHCl7A8woHWDiUnqiMEb/dnd9S9b9OfPDDh
         pFQOxURfwi4vrcRQsb3n5uFdBlbwXlnXgdiRXUsSM6V3CnRYoWmBU/UNv8dC1DURp/Io
         35X3hEW1qK3Y9Hb3FLtbu/OVA9dCGRkbT4WnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tBsX0MVHwtbJoJcOekTIeXMGpx0HIEfEiJde7/PcK80=;
        b=XhbcPDoczg+tsKmVwyb0B8do80mTyxl+cAGhdtkj61h/dSwQxJofnpo2w8VRTr04wJ
         cexJruxOm4hFE5zcBgXgmi1Vo49xJZzG+PMGdPMEkmREsGAzDSOSe3P2a+R571fR85ei
         NHJcTx5GzF+hPKMUSDQSv8OS0XDLwatA5mC102uDbmnLrT+c0usIH4WiLDlt7rucvqsK
         BWs9yem2xAh9DXDvWccebSxciBXEO9vHUPLCP6KiY+aBLZ5ClHf/m7GiLUHCVJp1++gH
         lUVhSrhF4sACZST4DQwtcuEXhX9+LpT/osDFli/bBM8blBpVEXSpueCWNG3yFGn6ICMv
         l78g==
X-Gm-Message-State: AOAM532SH6BTBXbO7I1ih+aGJEqTwcAq9e2L1OH7M4u6NCup+dzGeLDW
        kkkfzeBImZkO0uk1Ck20ZgcHhA==
X-Google-Smtp-Source: ABdhPJx4DgrNW9FkJnyV1CwX0zsYlc9O2kkn4hO3RVn6NxwFOFMmSXfXqcLcSPIXABh5/bAjaFy84g==
X-Received: by 2002:a63:594e:: with SMTP id j14mr1181232pgm.249.1628840576305;
        Fri, 13 Aug 2021 00:42:56 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:cbc8:5998:527e:5f43])
        by smtp.gmail.com with UTF8SMTPSA id nn18sm640606pjb.21.2021.08.13.00.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 00:42:55 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH v4 6/6] dma-iommu: account for min_align_mask
Date:   Fri, 13 Aug 2021 16:38:39 +0900
Message-Id: <20210813073839.1562438-7-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
In-Reply-To: <20210813073839.1562438-1-stevensd@google.com>
References: <20210813073839.1562438-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

For devices which set min_align_mask, swiotlb preserves the offset of
the original physical address within that mask. Since __iommu_dma_map
accounts for non-aligned addresses, passing a non-aligned swiotlb
address with the swiotlb aligned size results in the offset being
accounted for twice in the size passed to iommu_map_atomic. The extra
page exposed to DMA is also not cleaned up by __iommu_dma_unmap, since
that function unmaps with the correct size. This causes mapping failures
if the iova gets reused, due to collisions in the iommu page tables.

To fix this, pass the original size to __iommu_dma_map, since that
function already handles alignment.

Additionally, when swiotlb returns non-aligned addresses, there is
padding at the start of the bounce buffer that needs to be cleared.

Fixes: 1f221a0d0dbf ("swiotlb: respect min_align_mask")
Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/dma-iommu.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index b1b0327cc2f6..b44b367839c2 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -788,7 +788,6 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
-	size_t aligned_size = size;
 	dma_addr_t iova, dma_mask = dma_get_mask(dev);
 
 	/*
@@ -797,8 +796,8 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	 */
 	if (IS_ENABLED(CONFIG_SWIOTLB) && dev_use_swiotlb(dev) &&
 	    iova_offset(iovad, phys | size)) {
-		void *padding_start;
-		size_t padding_size;
+		void *tlb_start;
+		size_t aligned_size, iova_off, mapping_end_off;
 
 		aligned_size = iova_align(iovad, size);
 		phys = swiotlb_tbl_map_single(dev, phys, size, aligned_size,
@@ -807,24 +806,27 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 		if (phys == DMA_MAPPING_ERROR)
 			return DMA_MAPPING_ERROR;
 
-		/* Cleanup the padding area. */
-		padding_start = phys_to_virt(phys);
-		padding_size = aligned_size;
+		iova_off = iova_offset(iovad, phys);
+		tlb_start = phys_to_virt(phys - iova_off);
 
 		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 		    (dir == DMA_TO_DEVICE ||
 		     dir == DMA_BIDIRECTIONAL)) {
-			padding_start += size;
-			padding_size -= size;
+			/* Cleanup the padding area. */
+			mapping_end_off = iova_off + size;
+			memset(tlb_start, 0, iova_off);
+			memset(tlb_start + mapping_end_off, 0,
+			       aligned_size - mapping_end_off);
+		} else {
+			/* Nothing was sync'ed, so clear the whole buffer. */
+			memset(tlb_start, 0, aligned_size);
 		}
-
-		memset(padding_start, 0, padding_size);
 	}
 
 	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		arch_sync_dma_for_device(phys, size, dir);
 
-	iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
+	iova = __iommu_dma_map(dev, phys, size, prot, dma_mask);
 	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(phys))
 		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
 	return iova;
-- 
2.33.0.rc1.237.g0d66db33f3-goog


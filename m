Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9250D41BCCF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 04:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243858AbhI2CfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 22:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243840AbhI2CfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 22:35:14 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E88C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 19:33:34 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id g2so671688pfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 19:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bifqveMoD+L7a+BkifhXbHMP299/fP3BA6FwcjHOu8U=;
        b=Qfi0+r5tVULanmJv+N99Q1ew1u31Dv6gEoof70sEQMS8lLpXoeSMIg0eQfypX1XUlr
         GJYy94surBh+efHLDOSECMlumtC1qqv0Ci5zcqbwYCysAU10SQ/muyxqnHfy99nzjZQ6
         YL9laEnGqREwlEhBoMl6qip6osiIio0K6vWIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bifqveMoD+L7a+BkifhXbHMP299/fP3BA6FwcjHOu8U=;
        b=CiTNeUuNaHwrteds3r1CPxZZSKWFsRVlcvxXgO66Qe0nQia1VUVAt/50wdrlvbxlSH
         HMVXuGMFrPRFJOgo2g60BH1lkHsx9tAfFltBNtiPoQoZnOrYR7QkuoA/VWo5HOVZvGUG
         DQbmZF71PFFCjqbIKKkkBPr8dHR/fASs1nBnqdSLOad/R8e79MnMdoBKxJUBTneKZ2Y2
         /xxfM+NF3Uy0lnuwiWwE2VJmROX7Vv54uhRiDh0QI54y+2nJLjJEWx3/27H0/iA4AAWU
         DOXSltbV7nw59kuepBrPNugFdv6+X+GkodhNbwFIxpsh/Ey+S3n4QfH4jpbuhMXC8AV/
         MeGw==
X-Gm-Message-State: AOAM532GIY+LbNHpD4Ev8aTasamdyMn6qIQdq1VemRR2BG2T8AhtWEtW
        HGA/lvy8qj8BjOX8sRfoZhUMXA==
X-Google-Smtp-Source: ABdhPJw27pMB23kgpmhVZX2L2AIGhZtQaqqAMV/LtgNMVaKj3LNpYLnEy3RtB8rB+h/QUo2m93QOuA==
X-Received: by 2002:aa7:9d02:0:b0:43d:ea96:5882 with SMTP id k2-20020aa79d02000000b0043dea965882mr8696404pfp.23.1632882814085;
        Tue, 28 Sep 2021 19:33:34 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:f818:368:93ef:fa36])
        by smtp.gmail.com with UTF8SMTPSA id t6sm27379pjr.36.2021.09.28.19.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 19:33:33 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, Rajat Jain <rajatja@google.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH v8 6/7] swiotlb: support aligned swiotlb buffers
Date:   Wed, 29 Sep 2021 11:32:59 +0900
Message-Id: <20210929023300.335969-7-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210929023300.335969-1-stevensd@google.com>
References: <20210929023300.335969-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

Add an argument to swiotlb_tbl_map_single that specifies the desired
alignment of the allocated buffer. This is used by dma-iommu to ensure
the buffer is aligned to the iova granule size when using swiotlb with
untrusted sub-granule mappings. This addresses an issue where adjacent
slots could be exposed to the untrusted device if IO_TLB_SIZE < iova
granule < PAGE_SIZE.

Signed-off-by: David Stevens <stevensd@chromium.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c |  4 ++--
 drivers/xen/swiotlb-xen.c |  2 +-
 include/linux/swiotlb.h   |  3 ++-
 kernel/dma/swiotlb.c      | 13 ++++++++-----
 4 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 85a005b268f6..289c49ead01a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -818,8 +818,8 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 		size_t padding_size;
 
 		aligned_size = iova_align(iovad, size);
-		phys = swiotlb_tbl_map_single(dev, phys, size,
-					      aligned_size, dir, attrs);
+		phys = swiotlb_tbl_map_single(dev, phys, size, aligned_size,
+					      iova_mask(iovad), dir, attrs);
 
 		if (phys == DMA_MAPPING_ERROR)
 			return DMA_MAPPING_ERROR;
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index e56a5faac395..cbdff8979980 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -380,7 +380,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 	 */
 	trace_swiotlb_bounced(dev, dev_addr, size, swiotlb_force);
 
-	map = swiotlb_tbl_map_single(dev, phys, size, size, dir, attrs);
+	map = swiotlb_tbl_map_single(dev, phys, size, size, 0, dir, attrs);
 	if (map == (phys_addr_t)DMA_MAPPING_ERROR)
 		return DMA_MAPPING_ERROR;
 
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index b0cb2a9973f4..569272871375 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -45,7 +45,8 @@ extern void __init swiotlb_update_mem_attributes(void);
 
 phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t phys,
 		size_t mapping_size, size_t alloc_size,
-		enum dma_data_direction dir, unsigned long attrs);
+		unsigned int alloc_aligned_mask, enum dma_data_direction dir,
+		unsigned long attrs);
 
 extern void swiotlb_tbl_unmap_single(struct device *hwdev,
 				     phys_addr_t tlb_addr,
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 87c40517e822..019672b3da1d 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -459,7 +459,7 @@ static unsigned int wrap_index(struct io_tlb_mem *mem, unsigned int index)
  * allocate a buffer from that IO TLB pool.
  */
 static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
-			      size_t alloc_size)
+			      size_t alloc_size, unsigned int alloc_align_mask)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	unsigned long boundary_mask = dma_get_seg_boundary(dev);
@@ -483,6 +483,7 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 	stride = (iotlb_align_mask >> IO_TLB_SHIFT) + 1;
 	if (alloc_size >= PAGE_SIZE)
 		stride = max(stride, stride << (PAGE_SHIFT - IO_TLB_SHIFT));
+	stride = max(stride, (alloc_align_mask >> IO_TLB_SHIFT) + 1);
 
 	spin_lock_irqsave(&mem->lock, flags);
 	if (unlikely(nslots > mem->nslabs - mem->used))
@@ -541,7 +542,8 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 
 phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		size_t mapping_size, size_t alloc_size,
-		enum dma_data_direction dir, unsigned long attrs)
+		unsigned int alloc_align_mask, enum dma_data_direction dir,
+		unsigned long attrs)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
@@ -561,7 +563,8 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		return (phys_addr_t)DMA_MAPPING_ERROR;
 	}
 
-	index = swiotlb_find_slots(dev, orig_addr, alloc_size + offset);
+	index = swiotlb_find_slots(dev, orig_addr,
+				   alloc_size + offset, alloc_align_mask);
 	if (index == -1) {
 		if (!(attrs & DMA_ATTR_NO_WARN))
 			dev_warn_ratelimited(dev,
@@ -675,7 +678,7 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
 	trace_swiotlb_bounced(dev, phys_to_dma(dev, paddr), size,
 			      swiotlb_force);
 
-	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, size, dir,
+	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, size, 0, dir,
 			attrs);
 	if (swiotlb_addr == (phys_addr_t)DMA_MAPPING_ERROR)
 		return DMA_MAPPING_ERROR;
@@ -759,7 +762,7 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
 	if (!mem)
 		return NULL;
 
-	index = swiotlb_find_slots(dev, 0, size);
+	index = swiotlb_find_slots(dev, 0, size, 0);
 	if (index == -1)
 		return NULL;
 
-- 
2.33.0.685.g46640cef36-goog


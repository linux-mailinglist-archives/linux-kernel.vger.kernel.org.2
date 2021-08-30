Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C913FB0A9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 07:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhH3FBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 01:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbhH3FBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 01:01:31 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BADC0612E7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 22:00:35 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c4so7815111plh.7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 22:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qJyHOvrGmzqaEJuP2+sKnDXbmHMGvrcvxnYLz7HnOUs=;
        b=bkvIYEfQm3cuzqyPdrzZ2ZneZYaPfTukGW2BJJadyr2kbZx+YpkCKMmOkAzIzXdZYW
         X2MKOBnkdETzOlc6jT9LPUxlooD9cEMNHybcrlFBU4wF8WldUOn12WDIXTumngjGvQrL
         911JGkwyyXlKa5Df1VNSsr8eIw+FYNJ1F76V8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qJyHOvrGmzqaEJuP2+sKnDXbmHMGvrcvxnYLz7HnOUs=;
        b=WtEjBo9a2UCpjZsv4TNZsUo6tAL62/xqYZ2GePWcGqaERu48Kw8VyiHJPaKetYOpLg
         ZuW7jDXQpDYXGfT1bKMbsp7taShwSkJnPSs3Dv4ftEMGACegZbw6244VrsB8uuoL/7xj
         YJ5nXlhVyIYJywUjYr7MKYB5xgcxKWR/BxyI2MHHYOrpSqYhtNRz2DwQkMfq2It1Y5AA
         q/JKOvxPivNLnsoLopTC6jVo/FB4zWpihOsTsMhYmksY2ZrMmGWC6ABYBtWEQpEIsJJ5
         URiv1HMYkcMkNNmld5Z2CivQXkxFwIIDUFww6SHZD5JzE1zOBf4qdxz5yp2djwYx6qmM
         ylPQ==
X-Gm-Message-State: AOAM5313XY/IpKlGNVGG6BTMusCzsm+POhfMehPVDLW/2bYtQiqG7FuW
        1R5bQXey7I7ubxKM1Aqori1CTg==
X-Google-Smtp-Source: ABdhPJxvW0RS5t2xwhNQGJg07sEArvQLBDYP/RhPnYS+HQ/YmoihaKPgutSxMNOGVINLzPbjNtk/cA==
X-Received: by 2002:a17:90a:a087:: with SMTP id r7mr37215191pjp.84.1630299634969;
        Sun, 29 Aug 2021 22:00:34 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:28a5:1b9f:af1d:5542])
        by smtp.gmail.com with UTF8SMTPSA id k189sm2785564pfd.76.2021.08.29.22.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Aug 2021 22:00:34 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, Rajat Jain <rajatja@google.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH v7 6/7] swiotlb: support aligned swiotlb buffers
Date:   Mon, 30 Aug 2021 13:59:24 +0900
Message-Id: <20210830045925.4163412-7-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
In-Reply-To: <20210830045925.4163412-1-stevensd@google.com>
References: <20210830045925.4163412-1-stevensd@google.com>
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
 kernel/dma/swiotlb.c      | 11 +++++++----
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 714bec7a53c2..9b8c17c3d29b 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -817,8 +817,8 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 		size_t padding_size;
 
 		aligned_size = iova_align(iovad, size);
-		phys = swiotlb_tbl_map_single(dev, phys, size,
-					      aligned_size, dir, attrs);
+		phys = swiotlb_tbl_map_single(dev, phys, size, aligned_size,
+					      iova_mask(iovad), dir, attrs);
 
 		if (phys == DMA_MAPPING_ERROR)
 			return DMA_MAPPING_ERROR;
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 24d11861ac7d..8b03d2c93428 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -382,7 +382,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 	 */
 	trace_swiotlb_bounced(dev, dev_addr, size, swiotlb_force);
 
-	map = swiotlb_tbl_map_single(dev, phys, size, size, dir, attrs);
+	map = swiotlb_tbl_map_single(dev, phys, size, size, 0, dir, attrs);
 	if (map == (phys_addr_t)DMA_MAPPING_ERROR)
 		return DMA_MAPPING_ERROR;
 
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 216854a5e513..93d82e43eb3a 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -44,7 +44,8 @@ extern void __init swiotlb_update_mem_attributes(void);
 
 phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t phys,
 		size_t mapping_size, size_t alloc_size,
-		enum dma_data_direction dir, unsigned long attrs);
+		unsigned int alloc_aligned_mask, enum dma_data_direction dir,
+		unsigned long attrs);
 
 extern void swiotlb_tbl_unmap_single(struct device *hwdev,
 				     phys_addr_t tlb_addr,
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index e50df8d8f87e..d4c45d8cd1fa 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -427,7 +427,7 @@ static unsigned int wrap_index(struct io_tlb_mem *mem, unsigned int index)
  * allocate a buffer from that IO TLB pool.
  */
 static int find_slots(struct device *dev, phys_addr_t orig_addr,
-		size_t alloc_size)
+		size_t alloc_size, unsigned int alloc_align_mask)
 {
 	struct io_tlb_mem *mem = io_tlb_default_mem;
 	unsigned long boundary_mask = dma_get_seg_boundary(dev);
@@ -450,6 +450,7 @@ static int find_slots(struct device *dev, phys_addr_t orig_addr,
 	stride = (iotlb_align_mask >> IO_TLB_SHIFT) + 1;
 	if (alloc_size >= PAGE_SIZE)
 		stride = max(stride, stride << (PAGE_SHIFT - IO_TLB_SHIFT));
+	stride = max(stride, (alloc_align_mask >> IO_TLB_SHIFT) + 1);
 
 	spin_lock_irqsave(&mem->lock, flags);
 	if (unlikely(nslots > mem->nslabs - mem->used))
@@ -504,7 +505,8 @@ static int find_slots(struct device *dev, phys_addr_t orig_addr,
 
 phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		size_t mapping_size, size_t alloc_size,
-		enum dma_data_direction dir, unsigned long attrs)
+		unsigned int alloc_align_mask, enum dma_data_direction dir,
+		unsigned long attrs)
 {
 	struct io_tlb_mem *mem = io_tlb_default_mem;
 	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
@@ -524,7 +526,8 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		return (phys_addr_t)DMA_MAPPING_ERROR;
 	}
 
-	index = find_slots(dev, orig_addr, alloc_size + offset);
+	index = find_slots(dev, orig_addr,
+			   alloc_size + offset, alloc_align_mask);
 	if (index == -1) {
 		if (!(attrs & DMA_ATTR_NO_WARN))
 			dev_warn_ratelimited(dev,
@@ -636,7 +639,7 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
 	trace_swiotlb_bounced(dev, phys_to_dma(dev, paddr), size,
 			      swiotlb_force);
 
-	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, size, dir,
+	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, size, 0, dir,
 			attrs);
 	if (swiotlb_addr == (phys_addr_t)DMA_MAPPING_ERROR)
 		return DMA_MAPPING_ERROR;
-- 
2.33.0.259.gc128427fd7-goog


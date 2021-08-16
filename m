Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A3F3ECCE1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 04:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbhHPDAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 23:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbhHPDAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 23:00:15 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC05C0613C1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 19:59:45 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id oa17so24279548pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 19:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZnFl+xdo71Tt1OS25RNTp96pnNYmddalrajAnAJVj/U=;
        b=Y0Bs4lCya/WZf4GisoxE1NHE5Se0ImWO0UZz2Vna68y9iYM/bzi77WJ6tC+jc71zD8
         AVqsAMXJwiqnHoJU96mjPBxDoFlMBD7LR6Oh/kdj+Y3mSUjfxG6fOLkD+E8Kbwxss8cH
         4NhNs9SAIe7JonzQ12dyuEDjFcgY6Rkife1MU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZnFl+xdo71Tt1OS25RNTp96pnNYmddalrajAnAJVj/U=;
        b=YAevAdesDMRV+IQsUB9mmksfH8yunYUa35Ax35NP9UOUUUK9u1tMzh08P7eaOBFLRz
         jM7pjZAF/OIHl8iZkbVh+hNcIjopXgf1nHTbbanqncesRGtzGjXbCQAq4dQVxIvyQzvm
         ksgGNLHLr5oBfd+Mzjauen1U/EGBjvv6d9Y9HPQBPfW0jCiZV0ekSe6MzXBAtgtdOnc5
         KHdpWwOJsVgy+pnLjuKQGpKVXr22Fm9ZYnNbtO/GFYziKukAFJfLwYtVkTzofLEkw5rL
         sgIoxReMyIAMG+uoyHtCF2U5KqRQ/y5r8eEnaAYmfJzN0S+/zHKqfbO3y/MyvkNmQDSg
         ipIg==
X-Gm-Message-State: AOAM530DcGZzT56YWyGaLhoG543e3OLPGF+dX1jgAvkD0CyrBa81ErT1
        RQAnAa/Ta7qbBbhRus6L12fGPQ==
X-Google-Smtp-Source: ABdhPJxdkhyLesEUJ69U0aZQTuFpRIPo2GHTMyHHq5FiIgzT5BLjuaLXoyikkZjo1zEn1oHSezM8LQ==
X-Received: by 2002:a63:1e4b:: with SMTP id p11mr13947460pgm.295.1629082784839;
        Sun, 15 Aug 2021 19:59:44 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:17b8:f07a:2a52:317a])
        by smtp.gmail.com with UTF8SMTPSA id 21sm9196396pfh.103.2021.08.15.19.59.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Aug 2021 19:59:44 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH v5 6/7] swiotlb: support aligned swiotlb buffers
Date:   Mon, 16 Aug 2021 11:57:54 +0900
Message-Id: <20210816025755.2906695-7-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
In-Reply-To: <20210816025755.2906695-1-stevensd@google.com>
References: <20210816025755.2906695-1-stevensd@google.com>
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
index bad813d63ea6..b1b0327cc2f6 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -801,8 +801,8 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
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
2.33.0.rc1.237.g0d66db33f3-goog


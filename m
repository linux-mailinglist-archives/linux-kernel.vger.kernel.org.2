Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5396841BCD1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 04:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243863AbhI2CfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 22:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243849AbhI2CfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 22:35:18 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF8FC061745
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 19:33:38 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r2so1119671pgl.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 19:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ncVgCXT4Z1CIhR1u88HEHYmVpIWXoD+MY9qQieZl6fM=;
        b=BnNXrs7L3mIdN4nBUghOyR1aiYFnymhBVsC3hBZb3jzWR+4uEv6x4GXD4oOmN/USYy
         pdrOMcdzx1FXbnTbDmaX2dzbnXMmafc80Lq+Qa7vHz86WpWQi7CstZVXULvxOYNLAXb2
         3NqnB3HlTxHveX784+oZREdLW9Z3IyZWxiyos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ncVgCXT4Z1CIhR1u88HEHYmVpIWXoD+MY9qQieZl6fM=;
        b=PxmIV3CiKlNS3p7lr/r/i66dnF2fj/D7dadFIA/4dEPe8aFyUFAuGgAHM+Gr47/knT
         5tIB5uErRE5JNlnTM76iNtGbXP1QTnBCA8aKRtCDk8+0fiH4+9R9vbvsAs+FpgFj+fbc
         WPpowQLB1jRPSBh5/FmRg/CHzBfqhMGqtJlX/bDzxY276ulQDVq5+ZFBekdCQD/BtCcS
         Ff7ikM8XDdE/RDpD7WA9XFqjClEUfKU1/Q4+eM2ZAYW0N6dqMGlt8A5CaLcgaL/bkkO5
         i1fvaUC2hlsRc4PpBGgDItGFhpxo3uQeItR2ROiJzsQ40lnERuMZX4hFHUVw2HOxxOAL
         51Tw==
X-Gm-Message-State: AOAM530+yWAt/Ug6U9rrg8HnICR7g0RnIt4mUR0CoGhj0paRyTkxRxg9
        yPc1EBJyqMFfb2IMiybEns/LNQ==
X-Google-Smtp-Source: ABdhPJxa5WFK6hbd7FlHUYRoJD1f7XQ8pIFVG+qn2L5VwqQEXX3JkmUoEZcxr9jOkCOYHy0n1iiPAQ==
X-Received: by 2002:a62:3606:0:b0:445:38d5:98bf with SMTP id d6-20020a623606000000b0044538d598bfmr1003479pfa.4.1632882818209;
        Tue, 28 Sep 2021 19:33:38 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:f818:368:93ef:fa36])
        by smtp.gmail.com with UTF8SMTPSA id x19sm503568pgk.37.2021.09.28.19.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 19:33:37 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, Rajat Jain <rajatja@google.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH v8 7/7] dma-iommu: account for min_align_mask w/swiotlb
Date:   Wed, 29 Sep 2021 11:33:00 +0900
Message-Id: <20210929023300.335969-8-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210929023300.335969-1-stevensd@google.com>
References: <20210929023300.335969-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

Pass the non-aligned size to __iommu_dma_map when using swiotlb bounce
buffers in iommu_dma_map_page, to account for min_align_mask.

To deal with granule alignment, __iommu_dma_map maps iova_align(size +
iova_off) bytes starting at phys - iova_off. If iommu_dma_map_page
passes aligned size when using swiotlb, then this becomes
iova_align(iova_align(orig_size) + iova_off). Normally iova_off will be
zero when using swiotlb. However, this is not the case for devices that
set min_align_mask. When iova_off is non-zero, __iommu_dma_map ends up
mapping an extra page at the end of the buffer. Beyond just being a
security issue, the extra page is not cleaned up by __iommu_dma_unmap.
This causes problems when the IOVA is reused, due to collisions in the
iommu driver.  Just passing the original size is sufficient, since
__iommu_dma_map will take care of granule alignment.

Fixes: 1f221a0d0dbf ("swiotlb: respect min_align_mask")
Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/dma-iommu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 289c49ead01a..342359727a59 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -806,7 +806,6 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
-	size_t aligned_size = size;
 	dma_addr_t iova, dma_mask = dma_get_mask(dev);
 
 	/*
@@ -815,7 +814,7 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	 */
 	if (dev_use_swiotlb(dev) && iova_offset(iovad, phys | size)) {
 		void *padding_start;
-		size_t padding_size;
+		size_t padding_size, aligned_size;
 
 		aligned_size = iova_align(iovad, size);
 		phys = swiotlb_tbl_map_single(dev, phys, size, aligned_size,
@@ -840,7 +839,7 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		arch_sync_dma_for_device(phys, size, dir);
 
-	iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
+	iova = __iommu_dma_map(dev, phys, size, prot, dma_mask);
 	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(dev, phys))
 		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
 	return iova;
-- 
2.33.0.685.g46640cef36-goog


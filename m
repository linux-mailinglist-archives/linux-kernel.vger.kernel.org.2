Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C8F3EE3DB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 03:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbhHQBkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 21:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236345AbhHQBkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 21:40:16 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894A8C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 18:39:42 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id q2so22843983plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 18:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q9XB86DIe6440U7Wgn53Q54Y7DGoSwATnF9snUA3Icc=;
        b=TuSFkK3uO0HniVv/r5ufTbTIiD3OJgHt1f5UO/HGLUtUckfYJ+OPELuyBrA+OqWjo5
         CyOGnh5lvCuk0t1/E7DOv3nPDLz/1cpWnAZ5EEoQTgniXPH2/FQN3LG/rjbw7JveSUv4
         hdmmaxvK2Vnh+6DRY8Q/a+PxkU2Xz2m9P4xSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q9XB86DIe6440U7Wgn53Q54Y7DGoSwATnF9snUA3Icc=;
        b=UgHeRXErnxlUwTs0SIxCtgg6eMg5Bf+5jKmrUoEkPrUrKP8xlSBeH9xtomfeKfiwXT
         VSja3dpnLVFPnCZr2Vi6xPVyA8O/o9AQgCKQea4bpJ+3TDB7EWcQhaC2GUbcRAIioNPC
         QXjZdOjw33whd3BpXvSs+4iEi8cS8L+an9zWzf/DHvPaJtCikMk4Zf+0dNUBhF2uYjg9
         4PQRpnXBAVpTsD6XTMG+0nY9G3TY10+c1+zzdpjc8phCMfj6gBwgeAJuZuajtmo6Sqgg
         Y7O9m3yiBlrfYknsJQht//ji3vrmAHHmqwO02z06TUYT4jA8eDQLBzLlL4k/GNjJ46gx
         FdmA==
X-Gm-Message-State: AOAM531tgxJ4jHzptYGiFM+3DUR2ktkxKEy9/IpkS9e2kIXdizb2KZRj
        +nwP+VY4LihYK21Hgw14krwZ9A==
X-Google-Smtp-Source: ABdhPJziVMZGAz3+/7NmsxzmGWn1PVMenahFvVaOfrANZvx0kOhStJye2gVjIh1y+8PDzwytb9iAwg==
X-Received: by 2002:a17:90a:cf8e:: with SMTP id i14mr870389pju.136.1629164382105;
        Mon, 16 Aug 2021 18:39:42 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:6864:767c:2ff8:749d])
        by smtp.gmail.com with UTF8SMTPSA id l14sm331970pjq.13.2021.08.16.18.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 18:39:41 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH v6 7/7] dma-iommu: account for min_align_mask
Date:   Tue, 17 Aug 2021 10:38:52 +0900
Message-Id: <20210817013852.3222824-8-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
In-Reply-To: <20210817013852.3222824-1-stevensd@google.com>
References: <20210817013852.3222824-1-stevensd@google.com>
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
index 6738420fc081..f2fb360c2907 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -788,7 +788,6 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
-	size_t aligned_size = size;
 	dma_addr_t iova, dma_mask = dma_get_mask(dev);
 
 	/*
@@ -796,8 +795,8 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	 * page aligned, we don't need to use a bounce page.
 	 */
 	if (dev_use_swiotlb(dev) && iova_offset(iovad, phys | size)) {
-		void *padding_start;
-		size_t padding_size;
+		void *tlb_start;
+		size_t aligned_size, iova_off, mapping_end_off;
 
 		aligned_size = iova_align(iovad, size);
 		phys = swiotlb_tbl_map_single(dev, phys, size, aligned_size,
@@ -806,23 +805,26 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 		if (phys == DMA_MAPPING_ERROR)
 			return DMA_MAPPING_ERROR;
 
-		/* Cleanup the padding area. */
-		padding_start = phys_to_virt(phys);
-		padding_size = aligned_size;
+		iova_off = iova_offset(iovad, phys);
+		tlb_start = phys_to_virt(phys - iova_off);
 
 		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 		    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)) {
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


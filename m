Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3617B3FB0A6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 07:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhH3FBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 01:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhH3FBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 01:01:12 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CF7C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 22:00:19 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id n18so12248580pgm.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 22:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O2/T1jKK+0ZNqmT85i+JS6j9girurjGsDL4JkolN6OE=;
        b=l/AK/qHX+E7qAyQfpc2PyFX3XcLeuoTo5mI3m2ltXN8wPHan26C4iVutgNVecKS3RW
         OMJOTnMVad943OqmlA9pQ6LBWGQ8oUngw2pq/xgfYe2V7VHmQ5FoHgMQEuuorfhN1F7r
         XXa6rJhkuA1YQ9+hmTZbHHLYzYxzf5q6etk/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O2/T1jKK+0ZNqmT85i+JS6j9girurjGsDL4JkolN6OE=;
        b=uC7hCYeg4rTvPCX8PyI+yeai+rubgLYy3f8n0fqKB4a7K4YPP+kqW7Vxq0EeCKL1Q3
         Z71qe5spL7oU2NJcnkRQOMuDalWOVw5nsVCvqpv2w2HtoWSVgzIdpZpDVsQThGWI5XQn
         RdrlpNnO3/JBve8IbZ2E02b87u81eL0qpjsQaPFqVnOva11Gdr6VJgfAx+cSWAOTBXmB
         DAdy4msnedFE2NcNQjTcSPICSSYv6LpNKqwZPTjfyJ2zdlEj5mrSFHVy3wUqpz4L0bGt
         ciuNpw1BxLGRxy4B2xUwm52Cm3k6tILlgIB9e0H1JTjm/DoR/KGR1pmKZA1Xyqc5UxcF
         6MSQ==
X-Gm-Message-State: AOAM532Qa4711Ih7cHA3N7hHZ8Zs/BXMuuHMyFCSaEYVcwmljuE2vHSN
        vqF7QcAzmRVPudPxgcjC+gy1Vg==
X-Google-Smtp-Source: ABdhPJy05HJbfQAzreZQxtTRdv7GN1lj5/vB+XjmPxqQ+I82YQr15/0hUqGorVP4sQFq9CoJBDELVg==
X-Received: by 2002:a63:d40a:: with SMTP id a10mr18194740pgh.7.1630299618817;
        Sun, 29 Aug 2021 22:00:18 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:28a5:1b9f:af1d:5542])
        by smtp.gmail.com with UTF8SMTPSA id h9sm20432303pjg.9.2021.08.29.22.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Aug 2021 22:00:18 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, Rajat Jain <rajatja@google.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH v7 2/7] dma-iommu: fix arch_sync_dma for map
Date:   Mon, 30 Aug 2021 13:59:20 +0900
Message-Id: <20210830045925.4163412-3-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
In-Reply-To: <20210830045925.4163412-1-stevensd@google.com>
References: <20210830045925.4163412-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

When calling arch_sync_dma, we need to pass it the memory that's
actually being used for dma. When using swiotlb bounce buffers, this is
the bounce buffer. Move arch_sync_dma into the __iommu_dma_map_swiotlb
helper, so it can use the bounce buffer address if necessary.

Now that iommu_dma_map_sg delegates to a function which takes care of
architectural syncing in the untrusted device case, the call to
iommu_dma_sync_sg_for_device can be moved so it only occurs for trusted
devices. Doing the sync for untrusted devices before mapping never
really worked, since it needs to be able to target swiotlb buffers.

This also moves the architectural sync to before the call to
__iommu_dma_map, to guarantee that untrusted devices can't see stale
data they shouldn't see.

Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
Signed-off-by: David Stevens <stevensd@chromium.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d6ae87212768..12197fdc3b1c 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -593,6 +593,9 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
 		memset(padding_start, 0, padding_size);
 	}
 
+	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		arch_sync_dma_for_device(phys, org_size, dir);
+
 	iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
 	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(phys))
 		swiotlb_tbl_unmap_single(dev, phys, org_size, dir, attrs);
@@ -859,14 +862,9 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 {
 	phys_addr_t phys = page_to_phys(page) + offset;
 	bool coherent = dev_is_dma_coherent(dev);
-	dma_addr_t dma_handle;
 
-	dma_handle = __iommu_dma_map_swiotlb(dev, phys, size, dma_get_mask(dev),
+	return __iommu_dma_map_swiotlb(dev, phys, size, dma_get_mask(dev),
 			coherent, dir, attrs);
-	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
-	    dma_handle != DMA_MAPPING_ERROR)
-		arch_sync_dma_for_device(phys, size, dir);
-	return dma_handle;
 }
 
 static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
@@ -1009,12 +1007,12 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	    iommu_deferred_attach(dev, domain))
 		return 0;
 
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		iommu_dma_sync_sg_for_device(dev, sg, nents, dir);
-
 	if (dev_is_untrusted(dev))
 		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
 
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		iommu_dma_sync_sg_for_device(dev, sg, nents, dir);
+
 	/*
 	 * Work out how much IOVA space we need, and align the segments to
 	 * IOVA granules for the IOMMU driver to handle. With some clever
-- 
2.33.0.259.gc128427fd7-goog


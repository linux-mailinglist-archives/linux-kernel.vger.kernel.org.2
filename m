Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E00D3EE3CE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 03:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbhHQBj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 21:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236060AbhHQBjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 21:39:55 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAEDC0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 18:39:22 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso3455862pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 18:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fkx6jJVp5t9v78nFWX5+OiZGx8CBIKsaZwk7dXo56kQ=;
        b=HzqS4D8ujlROeUqPIjZSm/OMCksHtOvUVbhoYctn0J1YcrM2jem63lOBqcbrkMwen9
         XUHLLnk2NUZNYPZeVvMJ01jIp22IUMvF4Q2LyWhiHb6V/0ZK1fzuykq/bITAuWsv6n3+
         6QKu2cBiuNpWeFrT7XATkYfpHfZgsrYulf0jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fkx6jJVp5t9v78nFWX5+OiZGx8CBIKsaZwk7dXo56kQ=;
        b=oPBZTJnnyn9aeLIgy1bLFVPJhTUo5h0beO/CO2cbMI4iI3gTHnIswY9EB1x9ETDbZJ
         YkgO2xA5MtPo0HLW+FhEx8jWH8ywvzO7NaJTBCtkBpHy95MSIwnbA5jXUUeKVTYXn6uh
         TmynL5JflBKobJai9I456YpN027b68w0NjvbSPfXyt791T4COYLL7Y7awpRqihu5n69+
         fIcH62fsyB4P9LAdo5dkeQDIHr9VEfuUo6ev4hTVmqMcNKkXlvRdeF+hf90qPYmTOyMw
         KXH0ekxF3Kb0WuU0hk/vrVwPwsb+1hNXiyUHztvMYe7BEuN10Fc26tvtxg5ysM+IzX+/
         nQOg==
X-Gm-Message-State: AOAM531bzNiAXDNkHrotPTZ3iUGW0h7HCEFiAejgtN0LxEybF3U2J3+t
        PzfVivmjH1EyfJyu7TXt+JMXFqsmGcHZXg==
X-Google-Smtp-Source: ABdhPJylYm0KjTGdKnEXjB0gPkPje+w1Dc2if/KmXG6z0a+VhLeSbBpmZrkEUSDOi+zI4L6E4VB94A==
X-Received: by 2002:a17:90a:c712:: with SMTP id o18mr913856pjt.69.1629164362173;
        Mon, 16 Aug 2021 18:39:22 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:6864:767c:2ff8:749d])
        by smtp.gmail.com with UTF8SMTPSA id g20sm405212pfo.20.2021.08.16.18.39.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 18:39:21 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH v6 2/7] dma-iommu: fix arch_sync_dma for map
Date:   Tue, 17 Aug 2021 10:38:47 +0900
Message-Id: <20210817013852.3222824-3-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
In-Reply-To: <20210817013852.3222824-1-stevensd@google.com>
References: <20210817013852.3222824-1-stevensd@google.com>
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
---
 drivers/iommu/dma-iommu.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 968e0150c95e..8098ce593640 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -576,6 +576,9 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
 		memset(padding_start, 0, padding_size);
 	}
 
+	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		arch_sync_dma_for_device(phys, org_size, dir);
+
 	iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
 	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(phys))
 		swiotlb_tbl_unmap_single(dev, phys, org_size, dir, attrs);
@@ -842,14 +845,9 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
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
@@ -992,12 +990,12 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
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
2.33.0.rc1.237.g0d66db33f3-goog


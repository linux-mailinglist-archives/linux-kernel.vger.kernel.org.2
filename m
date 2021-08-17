Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91DCD3EE3D0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 03:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbhHQBkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 21:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbhHQBj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 21:39:58 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F92EC0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 18:39:26 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id m24-20020a17090a7f98b0290178b1a81700so3437430pjl.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 18:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rTpdRIu7FpzvBFJwAANhpBrL0QFcTu4ptjq1LAtftzQ=;
        b=ezZ42GIRfs9eXpeKCSPeUfZMHb1oY8KWX1Zmv/qEJMLBhMLRgHr4ZHj2Iyx5HQ3MmP
         Z3PYeWqP7NNkbRmfxJEvAHQaFiGbsIfNDRy7t/gkJPLdNtYfYZu8fZwd6DiaBo5hQSE2
         I2c4PNhFo9A9maeFjR1CnjRPPIzbjxogbUd/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rTpdRIu7FpzvBFJwAANhpBrL0QFcTu4ptjq1LAtftzQ=;
        b=X6eXF4NH3wcCy6Axxbapg+oTwdGBOsJPKRXRGPvn9mGjkssXV15mDiuleyLA95livi
         auhfmLJ+NqVpCl4edjUcnREkytbd2FLX150oSulWH6ASb6rFd3UqAvaHQbOmjwzFmyRb
         hbqd7iTT8a1znqLTzbBiHbp9C3kTP18Ypt9NI+0yir+LTtOCxhePG/zW2nFRvUcIzzLG
         CybAPMLnDlgEaxvFoKC9IAhLS+Q0xkxz3P1gLGkfibWk7BTBynrweUDAbhmqNcv3VuHf
         vU44dmunGe7NeGWA8eE6R2IZe+k6xyR60US0kv08B4OMfFjwsA9wjHT+kZ84kaEXsWlY
         qi6Q==
X-Gm-Message-State: AOAM532R3PPtX0c6zAhyHY1WClkoSDE5MjyitDlOUNvCL4MmpZCpD06J
        rssGBHaE4+UwXdnPZjjTQueNUg==
X-Google-Smtp-Source: ABdhPJzHt0Q3iODtQezPrYHRIiO+4+NDCtHq9DghJp3azP1e9Y6fx29b/XrikZInLJlJdBmZNNDH2A==
X-Received: by 2002:a17:90a:d181:: with SMTP id fu1mr838875pjb.137.1629164365817;
        Mon, 16 Aug 2021 18:39:25 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:6864:767c:2ff8:749d])
        by smtp.gmail.com with UTF8SMTPSA id n185sm409593pfn.171.2021.08.16.18.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 18:39:25 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH v6 3/7] dma-iommu: skip extra sync during unmap w/swiotlb
Date:   Tue, 17 Aug 2021 10:38:48 +0900
Message-Id: <20210817013852.3222824-4-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
In-Reply-To: <20210817013852.3222824-1-stevensd@google.com>
References: <20210817013852.3222824-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

Calling the iommu_dma_sync_*_for_cpu functions during unmap can cause
two copies out of the swiotlb buffer. Do the arch sync directly in
__iommu_dma_unmap_swiotlb instead to avoid this. This makes the call to
iommu_dma_sync_sg_for_cpu for untrusted devices in iommu_dma_unmap_sg no
longer necessary, so move that invocation later in the function.

Signed-off-by: David Stevens <stevensd@chromium.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 8098ce593640..5dd2c517dbf5 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -504,6 +504,9 @@ static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
 	if (WARN_ON(!phys))
 		return;
 
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) && !dev_is_dma_coherent(dev))
+		arch_sync_dma_for_cpu(phys, size, dir);
+
 	__iommu_dma_unmap(dev, dma_addr, size);
 
 	if (unlikely(is_swiotlb_buffer(phys)))
@@ -853,8 +856,6 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
 	__iommu_dma_unmap_swiotlb(dev, dma_handle, size, dir, attrs);
 }
 
@@ -1062,14 +1063,14 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 	struct scatterlist *tmp;
 	int i;
 
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		iommu_dma_sync_sg_for_cpu(dev, sg, nents, dir);
-
 	if (dev_is_untrusted(dev)) {
 		iommu_dma_unmap_sg_swiotlb(dev, sg, nents, dir, attrs);
 		return;
 	}
 
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		iommu_dma_sync_sg_for_cpu(dev, sg, nents, dir);
+
 	/*
 	 * The scatterlist segments are mapped into a single
 	 * contiguous IOVA allocation, so this is incredibly easy.
-- 
2.33.0.rc1.237.g0d66db33f3-goog


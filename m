Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7F83ECCDA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 04:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbhHPDAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 23:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbhHPDAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 23:00:04 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05140C061764
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 19:59:34 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j12-20020a17090aeb0c00b00179530520b3so9718917pjz.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 19:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/W+vSgwB4JE0r8Dwuz6/SM/DZ1++krnjsG0UhcUWbEs=;
        b=Jl6EC+NAyTbfNS7jUTmbm7eH62FigekPVFVSy0bGiiXXpAixnUU1bA4pHE0C3xTOzc
         v4yBas0Shz3pahQ+rIlHfTn7P0EgCM29nVtV2Fvr6hMTY0xTxv5S1sVLiXqd6qbkLvfR
         tw6VxlHIuauqbpFLysiJ0mdqNm6lchod/ibtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/W+vSgwB4JE0r8Dwuz6/SM/DZ1++krnjsG0UhcUWbEs=;
        b=CbiobJHSXIv1V1HoWrgaEuoUp0Z8g0x9D3XTmaJVQzEdO4IVIazUFS5V6arXKE33KX
         dLH/S7lVMSQbPaQIVQnSXplvbbctAiBH121qCEedTdAY6tNkq41D3z1OL9WZiEVKYu/o
         EPAPE4DJ3dHf+7kC4zyekULWJ4CNz6yYPMxChM/pb07zhgXLQaPhZNE7cWUbZwAXE899
         o5Ys9ErcA28MiNopIZe1h3X5VaoYihVY2rnkMB25VlHg5ey5kQxIJlCvbV0AwCcif+U1
         zkYda1pdQcqmU//y7z2BI1juZyxAr2Mwk+r3VHedH98apiJV2mRy8hhDTH01r26Nr3yX
         oq1Q==
X-Gm-Message-State: AOAM533bhyO6DuVl+MGbCHyScrzhTtRnaD7cTri4ycBkjdZMgyaywLFl
        KyGvo/jOas+paYm1USJfddvVKA==
X-Google-Smtp-Source: ABdhPJwl22a/1iaLG7lwTFr+2DBMmhbUqgV4wTzEOn11jhBWA9F1fFWOiixp9UyfZqS8O97dLz6MJQ==
X-Received: by 2002:a65:4203:: with SMTP id c3mr4567183pgq.309.1629082773658;
        Sun, 15 Aug 2021 19:59:33 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:17b8:f07a:2a52:317a])
        by smtp.gmail.com with UTF8SMTPSA id j128sm9534987pfd.38.2021.08.15.19.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Aug 2021 19:59:33 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH v5 3/7] dma-iommu: skip extra sync during unmap w/swiotlb
Date:   Mon, 16 Aug 2021 11:57:51 +0900
Message-Id: <20210816025755.2906695-4-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
In-Reply-To: <20210816025755.2906695-1-stevensd@google.com>
References: <20210816025755.2906695-1-stevensd@google.com>
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


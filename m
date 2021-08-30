Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8079A3FB0A7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 07:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbhH3FBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 01:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbhH3FBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 01:01:16 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACD5C061756
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 22:00:23 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id x4so12305623pgh.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 22:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p0M0LPeLb2bO15/S2RN1fSV7prFIeL6kElwekRN6sTw=;
        b=S3yczAZAkq/yaayh+fEIYgG+OGimGvZhH5pW0o5+iovC3ow6Pk74+0Zxt6ggbkLOWo
         jgqbWPwxirW+0jI7jK/G+8PoBahK0AljG8xIU1D9eBSChiDAi+8LgtjP5FTYzbLou8HO
         8eaM4Z7+N/BJtFEUFc/6fL1rKFHNVJoC+DVk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p0M0LPeLb2bO15/S2RN1fSV7prFIeL6kElwekRN6sTw=;
        b=jnEkQAAWM6eLnqboTwu4JzxPntfHvXzRPDP9EALSxHl+1blSsQRGxYRUD5RsT7LC+J
         urYzc1UIWS98v7BABMnWTo8qbmHWo8RtEco2eL1DpQD5IJsyu3MmC4KI6GV51cFjs26t
         2IBe6sq7rjV9hWMXJQsPIHAInEt0Wnuy2aFSPK1nRjPBgvKpN5mhA2QOyQpZcz9y+LvZ
         3/UMKGWAAhkNjNgG8ibLrefCk7B9MDJM+51GzCMoF/TdngEfP51BDl5Mcq4HPqfvPlEu
         Hegdpmzdg1q246K/Uk7z/jPqap5sXtjAhG5nkWRrxQmSLSY2/rtymoXNfyK3Wm1a9rY3
         Lfkg==
X-Gm-Message-State: AOAM53347V4e9CF2PNQkYeXZnbfU3+bA8urDNa3lDMwaNNWG7aTOLiUt
        //Z/rCZxg8+ZihfSk64XfsfaFA==
X-Google-Smtp-Source: ABdhPJwReaCNJJnrv/elBCRGZOUsyg/AsxzC4aoA//Ej0ZUib5Qnw5rAjliODJvign4dDnuvDxNHtg==
X-Received: by 2002:a05:6a00:228a:b0:3e1:a0b2:535b with SMTP id f10-20020a056a00228a00b003e1a0b2535bmr21407462pfe.5.1630299623159;
        Sun, 29 Aug 2021 22:00:23 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:28a5:1b9f:af1d:5542])
        by smtp.gmail.com with UTF8SMTPSA id q21sm15506738pgk.71.2021.08.29.22.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Aug 2021 22:00:22 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, Rajat Jain <rajatja@google.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH v7 3/7] dma-iommu: skip extra sync during unmap w/swiotlb
Date:   Mon, 30 Aug 2021 13:59:21 +0900
Message-Id: <20210830045925.4163412-4-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
In-Reply-To: <20210830045925.4163412-1-stevensd@google.com>
References: <20210830045925.4163412-1-stevensd@google.com>
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
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 12197fdc3b1c..abc528ed653c 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -521,6 +521,9 @@ static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
 	if (WARN_ON(!phys))
 		return;
 
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) && !dev_is_dma_coherent(dev))
+		arch_sync_dma_for_cpu(phys, size, dir);
+
 	__iommu_dma_unmap(dev, dma_addr, size);
 
 	if (unlikely(is_swiotlb_buffer(phys)))
@@ -870,8 +873,6 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
 	__iommu_dma_unmap_swiotlb(dev, dma_handle, size, dir, attrs);
 }
 
@@ -1079,14 +1080,14 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
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
2.33.0.259.gc128427fd7-goog


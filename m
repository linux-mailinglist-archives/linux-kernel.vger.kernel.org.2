Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0AEE3FB0A5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 07:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhH3FBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 01:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhH3FBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 01:01:08 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D992C06175F
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 22:00:15 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id t42so11199236pfg.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 22:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ODCLmgJroklYClFaSFOowOn0wl0I5e9vA7yPkFVbffA=;
        b=fodwtW8SR+rX87U8RheOBcjS6kk7hqtO9du4VG2u0/cFxjS1wGatTh2nTkqLAmvLId
         +ZrhsgHDU6HUPtRjE6Li6gvThSIz3wtFgk7MMMmIxl6sywg9wPC0qRBvjEZ+XFfQDtc7
         1RTJEi/JtOkFUpyov7DDvn1OPtTD3RxIRU10w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ODCLmgJroklYClFaSFOowOn0wl0I5e9vA7yPkFVbffA=;
        b=PZ2z/O0nRZRsDmx2ugI8rblzsuJCbeGOJJc1Pua8ewmBvSDpN3WlCBz9cqddjD/ZLB
         XbYN+zLhP7tLEhGLIoHp5nA3+mum6lMFWRRhlREXnY9+I6v407zaMeURQg0u4coCwXg+
         +mqMNyXUHVY2PdVp5G2OCsXOfhIO4Dr1ZmQ3Y5nfl3Gz2kH+2xI+IQej+UzSUMOueDJ1
         7nRNfa3swiBVEbj0mHnXwHp6i8fxCUzgfbh+HIJ7IQMbf5LyE8ictCWU/KxjnJ2ZxQJm
         qEvApfj9dloQs9YkFXeZreBe6bIEmOJTzKTVW1QjaG1J714eOoQvRmP8F7C22fmE/xbn
         iGRg==
X-Gm-Message-State: AOAM531r/316Rk8+udBc/OGpJ5r9tm9Tx4r3WtgQ7gyPcX+YCk4/TXJe
        LeYfdpovztNU0Mk7W0KGp88zXQ==
X-Google-Smtp-Source: ABdhPJyKRtKBYVk3GmeYi8uaGepLu5a3+Ov6qL8iD5sY0zy33v/FtHH1+zEW61CA8sFaTCeDF4yieg==
X-Received: by 2002:a62:1c4e:0:b0:3ee:7c8e:ce6 with SMTP id c75-20020a621c4e000000b003ee7c8e0ce6mr21281935pfc.60.1630299615053;
        Sun, 29 Aug 2021 22:00:15 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:28a5:1b9f:af1d:5542])
        by smtp.gmail.com with UTF8SMTPSA id c124sm13579665pfc.216.2021.08.29.22.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Aug 2021 22:00:14 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, Rajat Jain <rajatja@google.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH v7 1/7] dma-iommu: fix sync_sg with swiotlb
Date:   Mon, 30 Aug 2021 13:59:19 +0900
Message-Id: <20210830045925.4163412-2-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
In-Reply-To: <20210830045925.4163412-1-stevensd@google.com>
References: <20210830045925.4163412-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

The is_swiotlb_buffer function takes the physical address of the swiotlb
buffer, not the physical address of the original buffer. The sglist
contains the physical addresses of the original buffer, so for the
sync_sg functions to work properly when a bounce buffer might have been
used, we need to use iommu_iova_to_phys to look up the physical address.
This is what sync_single does, so call that function on each sglist
segment.

The previous code mostly worked because swiotlb does the transfer on map
and unmap. However, any callers which use DMA_ATTR_SKIP_CPU_SYNC with
sglists or which call sync_sg would not have had anything copied to the
bounce buffer.

Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
Signed-off-by: David Stevens <stevensd@chromium.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index bac7370ead3e..d6ae87212768 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -827,17 +827,13 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
-		return;
-
-	for_each_sg(sgl, sg, nelems, i) {
-		if (!dev_is_dma_coherent(dev))
+	if (dev_is_untrusted(dev))
+		for_each_sg(sgl, sg, nelems, i)
+			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
+						      sg->length, dir);
+	else if (!dev_is_dma_coherent(dev))
+		for_each_sg(sgl, sg, nelems, i)
 			arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
-
-		if (is_swiotlb_buffer(sg_phys(sg)))
-			swiotlb_sync_single_for_cpu(dev, sg_phys(sg),
-						    sg->length, dir);
-	}
 }
 
 static void iommu_dma_sync_sg_for_device(struct device *dev,
@@ -847,17 +843,14 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
-		return;
-
-	for_each_sg(sgl, sg, nelems, i) {
-		if (is_swiotlb_buffer(sg_phys(sg)))
-			swiotlb_sync_single_for_device(dev, sg_phys(sg),
-						       sg->length, dir);
-
-		if (!dev_is_dma_coherent(dev))
+	if (dev_is_untrusted(dev))
+		for_each_sg(sgl, sg, nelems, i)
+			iommu_dma_sync_single_for_device(dev,
+							 sg_dma_address(sg),
+							 sg->length, dir);
+	else if (!dev_is_dma_coherent(dev))
+		for_each_sg(sgl, sg, nelems, i)
 			arch_sync_dma_for_device(sg_phys(sg), sg->length, dir);
-	}
 }
 
 static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
-- 
2.33.0.259.gc128427fd7-goog


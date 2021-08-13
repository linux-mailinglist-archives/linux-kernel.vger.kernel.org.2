Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAD13EB1D5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 09:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239641AbhHMHo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 03:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239694AbhHMHnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:43:53 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F65BC0613A3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 00:42:38 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so19478165pjn.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 00:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VjVCAvnl6PUy5EY4yV2b37TCvoOV7plfescupRYCqI4=;
        b=lx+qGECuMb2tdJm9D4k5cNvLxbwpPISDiQgcbMhVM9Lo63AniUT6x8HxtkKUAGcCz9
         YazgX36am4EkZMecUhX06P1Z6SVKDKaeYZhCCz1PxktYeTcyvNFGeZZAVv49t9ZPcTcH
         E2lQ28NvrKiRLXqLWJ2gACn2U0MloGsATLWlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VjVCAvnl6PUy5EY4yV2b37TCvoOV7plfescupRYCqI4=;
        b=Kow4OcKA5fmjliEr3IzOwpK0iK5f3MM7JH3VgB8Tm50Y1weJ/4fSv0Pd4BXt/1mVp8
         DK/Nw3XeMB+yDH6/RqxrIOoxJ5MArGoQQ9ym5XMTQ4q4RCjKzO3P7IGVUaOncDBeXhvS
         Qk6w9n1Vq5pQlpkslW+Rbhz9CG2ifzicM/NspxruvgXrFZONCBDh5Gh34/ORDrHNjtTQ
         KSMN9CjEnUmLaWy/R96l01AYLgc/LgolYMicrND4Hv+nbmGuY1f8tkPw/SRkI56w7Xu+
         xuKp7HmP5pDG9hdwZKLUXgpek2tcDcGqHCjuQ31zcS3TYGbEPKKTpO5nCpORPrhbvFUZ
         ZG0A==
X-Gm-Message-State: AOAM53034C3cjf7ykWx4aE45qVymzuZk8nuC69L43ve/j9YDUGAAbqzT
        CHpImZj7Pze2ybF9zbSZegyy9A==
X-Google-Smtp-Source: ABdhPJzdQU4uWpopc/R6CXnmuwVAtJOqkPHcpsQCBadSYGthl9aCy1sahQINdjqtgv229ObctMjiGA==
X-Received: by 2002:aa7:93cd:0:b029:3e0:e283:9c45 with SMTP id y13-20020aa793cd0000b02903e0e2839c45mr1163463pff.53.1628840557654;
        Fri, 13 Aug 2021 00:42:37 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:cbc8:5998:527e:5f43])
        by smtp.gmail.com with UTF8SMTPSA id y8sm1158540pfe.162.2021.08.13.00.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 00:42:36 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH v4 1/6] dma-iommu: fix sync_sg with swiotlb
Date:   Fri, 13 Aug 2021 16:38:34 +0900
Message-Id: <20210813073839.1562438-2-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
In-Reply-To: <20210813073839.1562438-1-stevensd@google.com>
References: <20210813073839.1562438-1-stevensd@google.com>
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
---
 drivers/iommu/dma-iommu.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 98ba927aee1a..968e0150c95e 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -810,17 +810,13 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
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
@@ -830,17 +826,14 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
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
2.33.0.rc1.237.g0d66db33f3-goog


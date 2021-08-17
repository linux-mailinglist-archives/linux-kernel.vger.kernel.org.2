Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4237D3EE3CD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 03:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbhHQBjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 21:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbhHQBju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 21:39:50 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC0DC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 18:39:18 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso2162503pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 18:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+F9dSAyZHVmy26HMTvHdg1DO02SGISMQ5dvVqt7bETc=;
        b=MQKhWtjeZ57gnzfmUr+cF5/3VUgNEo6UeHE8d8WpjYSpkvziUks/63Ge9pH360tCd9
         ACHoA3kMfp1KGdh00SFGOMtCgipqxJi/ZvwL8y+Ny3WVhlUlu/xEPVWy8BtoLXi6TwT5
         9b/Bx6x+oYwh5ra/BTayWrf+eBcTH4XMmuOwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+F9dSAyZHVmy26HMTvHdg1DO02SGISMQ5dvVqt7bETc=;
        b=lD/DG2iyPozoHlQx/ezzAJkmoICVLG7gpy/VAWKMfeCUL9nOiBVe+5gfsJeNT+eki3
         t0nAUMNQOJE3rdyfQNM5BeH++RTwWbbfnVm+8F2hNOSWIaa5+fgEKNorquG4FKCHXA9V
         jcTPMfh3f0V2cLLGiKEAqVgKByI9ntfyqypCzk7fsLC4D+jkyO2EXymZt3ugMNpTE7/2
         3y8iEMs9Je6PGoTzMt6yEB1V5XUlQ97WY0cLNcnUNLRhmrKFr0FI71OVQcS3AGI7ezbI
         P4QVLMnktROaiw0sujrWu3eV9PPmlb+s8Za0LgQ5B2U/dgRJekmn2ibvvHntdyXgCmzk
         PJLg==
X-Gm-Message-State: AOAM532TL7fMOUUk9+2hgQe8PVKhFsJS4cc2wvsHTW97bNDpuu+tRAks
        k2rHTm/6rwn6bLBdfO/GR1Bh2w==
X-Google-Smtp-Source: ABdhPJzAuOY//4lB+1dmUENRVwCd7Zmp+MPEA8vNPjZIst3xAH5jElLNh+qgeXWysbImalHTiqhvuA==
X-Received: by 2002:aa7:900e:0:b0:3e1:3dfe:bb2b with SMTP id m14-20020aa7900e000000b003e13dfebb2bmr1014734pfo.81.1629164358012;
        Mon, 16 Aug 2021 18:39:18 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:6864:767c:2ff8:749d])
        by smtp.gmail.com with UTF8SMTPSA id t18sm396938pfg.111.2021.08.16.18.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 18:39:17 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH v6 1/7] dma-iommu: fix sync_sg with swiotlb
Date:   Tue, 17 Aug 2021 10:38:46 +0900
Message-Id: <20210817013852.3222824-2-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
In-Reply-To: <20210817013852.3222824-1-stevensd@google.com>
References: <20210817013852.3222824-1-stevensd@google.com>
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


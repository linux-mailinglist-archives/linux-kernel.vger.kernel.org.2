Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C9441BCC4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 04:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243818AbhI2CfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 22:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243819AbhI2Ce7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 22:34:59 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD172C061753
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 19:33:18 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id g184so1139553pgc.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 19:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vrY7lpb6fr2IzuXu04r9wlKCRD8tQ1O3VtXZLqEl8J0=;
        b=CE2hvSxe7UyyqQ8j3KDMtzh7/V+Dy3gHbNUEcODQ9hRI7uyAdoCJx+NRH25O/oKLxT
         wHk7MGSk2+AF3uWePiLRJlnmEXZnboMfkQO+Iin1jukpnqG2C1JbyBo8JA6F/i5m9jvs
         +PpjrxfjFNgsBM27/s7UCYHJxuUvLYilxNFmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vrY7lpb6fr2IzuXu04r9wlKCRD8tQ1O3VtXZLqEl8J0=;
        b=lSC6Lkk+SNVVlVzfY8SyCSzEouTuFTzSp7CSS9KT3h2ZfUxt1Zp9nuHpA4CxVGUGRT
         LwOzu5aLVUcE7+Ys8wRbmuu+vDwhh73n9utSXFDFonEwLPL0upCDosduV7BzohlDgZFw
         1TzE/sc8FwW8/bk0PpXXyc1PUkI09UzCv610X9EG5dVyrBHpkXKLfE+v5UkNCOJWsbhf
         G4nln3uNvwOIJphl5smXsCn7c4mbaydMj8c5hUQmDnuv2JY2zp88/w13WnogSDwFzC22
         cVNRtjT1P79rcoWPyXGCd4pPnemhh/Erg/UCt4ilUNDWx7KHZBM9KtBA4L2/Zm1WccwM
         BD/Q==
X-Gm-Message-State: AOAM532O8mh2335mblmaeG5GwOfpIsDTrXTi/DxMsaylVWbSKHoEr3y0
        8WgMNz8P11LVJjhPI6TUdVa2Uf5bN4xfcg==
X-Google-Smtp-Source: ABdhPJx4soaibGC17QBhG2efz2SYVL25tMvV2d+x2C27zGdEPiDV93CLb4Fva+pExlObuiEE7cCM3Q==
X-Received: by 2002:a63:f84f:: with SMTP id v15mr7491181pgj.204.1632882797550;
        Tue, 28 Sep 2021 19:33:17 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:f818:368:93ef:fa36])
        by smtp.gmail.com with UTF8SMTPSA id ml21sm22975pjb.55.2021.09.28.19.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 19:33:17 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, Rajat Jain <rajatja@google.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH v8 2/7] dma-iommu: fix arch_sync_dma for map
Date:   Wed, 29 Sep 2021 11:32:55 +0900
Message-Id: <20210929023300.335969-3-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210929023300.335969-1-stevensd@google.com>
References: <20210929023300.335969-1-stevensd@google.com>
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
index c4d205b63c58..19bebacbf178 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -593,6 +593,9 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
 		memset(padding_start, 0, padding_size);
 	}
 
+	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		arch_sync_dma_for_device(phys, org_size, dir);
+
 	iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
 	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(dev, phys))
 		swiotlb_tbl_unmap_single(dev, phys, org_size, dir, attrs);
@@ -860,14 +863,9 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
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
@@ -1012,12 +1010,12 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		goto out;
 	}
 
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
2.33.0.685.g46640cef36-goog


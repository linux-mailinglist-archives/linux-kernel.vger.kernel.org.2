Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DDE3E881C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 04:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhHKCoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 22:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbhHKCoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 22:44:37 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AA5C061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 19:44:14 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n12so77881plf.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 19:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=32CCkzzdwlBxBR5R3R3lQIa/BUxHULX8DF1l6bUu8Gg=;
        b=MrvkA+8UoYyZJMGfbINoSZj40Z+N4JQ9I+NievWkQ2fR4dqQzEEvM7whbnBjgjGSmv
         l0nrF9dUjZOZJuu1L8+giXIxKKnkMMqME0MQSJQCkXZaC5uCZvyEgAU+e6jaPTaIs+Jt
         nWKhDYvv2sA5nS684Pwkv8J+1ViFVgH/xaDZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=32CCkzzdwlBxBR5R3R3lQIa/BUxHULX8DF1l6bUu8Gg=;
        b=ot8rt2Bf338/kn30gR3bAcbeWywfs7zz5TZLaRqU2uaStaBLFkDddXFwOjBFUkYG+S
         Wqnf4yONprri6SAhP9kMcUuRNoglfVXkL0G7aQ454N/+bAHTN3QUZhipi4Q2ghbSC4Oo
         RtActC15spkpY6m9QvqLBTC2oxp1EqD2bHmmAIj39qEktcnfeC56xnZlNCBINS4VWRNZ
         BoDLOzHgHJd2tF3o6sc84Al37Pw/OQLYF/NeuhlOgb3UcL2ZTpJ/mI5bD8pObS+HS4Q4
         NVisTiOua44ksxP9Jpd0viPcQ1WDBxWytGg4vB4wyI9NYWXMysGteOIj0LHE9+i4EZtx
         pNqA==
X-Gm-Message-State: AOAM531KUEVL6pug99DN4x4JkufnB6EYGeU4I1dLoSc321fzFJE6JVf/
        QPzTQmPGGr9cvlikhe2anh0dbQ==
X-Google-Smtp-Source: ABdhPJy2axgHyiRzRqB0mBc5KbCk2yWjNcqP8qah7TL56kK7YEtNcGf0hUpmuLezpBSWmj7A8FmJjw==
X-Received: by 2002:a65:6099:: with SMTP id t25mr239595pgu.85.1628649854506;
        Tue, 10 Aug 2021 19:44:14 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:1e5c:70cb:3289:1b5b])
        by smtp.gmail.com with UTF8SMTPSA id 128sm890278pfe.55.2021.08.10.19.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 19:44:14 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH v3 2/5] dma-iommu: fix arch_sync_dma for map
Date:   Wed, 11 Aug 2021 11:42:44 +0900
Message-Id: <20210811024247.1144246-3-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
In-Reply-To: <20210811024247.1144246-1-stevensd@google.com>
References: <20210811024247.1144246-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

When calling arch_sync_dma, we need to pass it the memory that's
actually being used for dma. When using swiotlb bounce buffers, this is
the bounce buffer. Move arch_sync_dma into the __iommu_dma_map_swiotlb
helper, so it can use the bounce buffer address if necessary. This also
means it is no longer necessary to call iommu_dma_sync_sg_for_device in
iommu_dma_map_sg for untrusted devices.

Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/dma-iommu.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 54e103b989d9..4f0cc4a0a61f 100644
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
@@ -848,14 +851,9 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
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
@@ -998,12 +996,12 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
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
2.32.0.605.g8dce9f2422-goog


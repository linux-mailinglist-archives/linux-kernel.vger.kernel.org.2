Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9743C1DD8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 05:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbhGIDiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 23:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbhGIDiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 23:38:08 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE76AC061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 20:35:24 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id t9so8595069pgn.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 20:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1m3gpf5gt+XbBI2rSpaMHxXcliMWw53oiKsV/n19iME=;
        b=kBKJQ1hr1n760w6WcnJ/hDwupbsZEuRK3r1zxPo167KJnJofflnj/WVukOIVf3LQ8L
         RbaO80ID66caIpCVt0ggxKPQDYpFTqdlwPLC1bVkWC5rL5NAnBegYrEOZr1ZnK5KZ/br
         qEZZOGcgfT9PZaWpLCSFO2DToPkCQXX9r1uak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1m3gpf5gt+XbBI2rSpaMHxXcliMWw53oiKsV/n19iME=;
        b=CTjMJl2ot//T1QnGAndPK5lK1puXXz5O3kz3LOUwOtRNYz8YGcpFomTy6s7/0lFLgj
         GYBjnLmzAyCp7GnYPyx2AW7wUUMORbsh37GFfQGjUWYJiLIh7prrV0+XcI5c65UWzmXn
         f5AGlA8vwv26wOOKABSvnlVYlXwS0eziE29Nejg4xuvMqd2E6zoU1Dxc2f/Fi0UIKaWA
         +yO6gBuzweKIXCvIK7DSCnaas+gz512ZGiFU4Qml1SDLP28TFcO1SWEPUeOiNa5Tgsrw
         V/3P93FfsvcPemZhJUmxbeAj/yfeJW387B5sUjdBA6wBYJw9o4d5kq55c1iSc5gMG7tI
         TmrA==
X-Gm-Message-State: AOAM530YUkeLN2UDmIQoq7uterh8CcOC9M+yYnAf4dgcFKOHnqoW7vLB
        AaOcMfWNznvH/3/h+H6Zb/aVyg==
X-Google-Smtp-Source: ABdhPJw4oQK7P8xqQOMV3M6phBKmcUh5Pu80vAbVvQAtGx5ufdSDq4xIjcdC2rD5z9VmF6Vatdf0MA==
X-Received: by 2002:a62:fb13:0:b029:309:8d89:46b2 with SMTP id x19-20020a62fb130000b02903098d8946b2mr34325611pfm.67.1625801724457;
        Thu, 08 Jul 2021 20:35:24 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:d47a:af0a:d5b9:e774])
        by smtp.gmail.com with UTF8SMTPSA id u16sm5220496pgh.53.2021.07.08.20.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 20:35:24 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH v2 2/4] dma-iommu: fix arch_sync_dma for map with swiotlb
Date:   Fri,  9 Jul 2021 12:35:00 +0900
Message-Id: <20210709033502.3545820-3-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210709033502.3545820-1-stevensd@google.com>
References: <20210709033502.3545820-1-stevensd@google.com>
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
index eac65302439e..e79e274d2dc5 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -574,6 +574,9 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
 		memset(padding_start, 0, padding_size);
 	}
 
+	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		arch_sync_dma_for_device(phys, org_size, dir);
+
 	iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
 	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(phys))
 		swiotlb_tbl_unmap_single(dev, phys, org_size, dir, attrs);
@@ -847,14 +850,9 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
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
@@ -997,12 +995,12 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
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
2.32.0.93.g670b81a890-goog


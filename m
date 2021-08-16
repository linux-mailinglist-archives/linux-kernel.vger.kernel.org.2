Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14093ECCD9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 04:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhHPDAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 23:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbhHPDAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 23:00:00 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7A2C061764
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 19:59:29 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c17so13894318plz.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 19:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VZd8V2fsNe9Uh2if0wRu/3mbxWlF2E8oIxYBHNo3rTI=;
        b=Cnvv63h/l1T3nNadJ8t6i2aXhyZVCv5hq6pbq8prdVdDx0tIfOfAofaM4CMHo4agz/
         d5XfhK3MEO/5itTqtaKxTP/ay+BWePmOxm64Ucb5+HIpMrlBabfSikUZYV8qXPIvWoZT
         gXwPVj1adg1e6ltfk+FiLxev5M6na/w9EgiWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VZd8V2fsNe9Uh2if0wRu/3mbxWlF2E8oIxYBHNo3rTI=;
        b=I1iE69YZa/wAtwHS85y92o6Xgwuoc31GPVDtfGF7k9D82pUs7byLkinn9ipdnB6Vq3
         2Me0Wh1p9TrqFhr6KYRVOoPThMxVPNgkd5HJZgmHVSt9dFwQMcWRZQNjoqmluwo7vBYV
         8bQ6LLZxqrDyaLRIFeZ/itfaK01tK0gHi4mwRy8kNLcrhcyjBThV8ZNwGkYQE3HAXN/X
         lpzp6o9DUywUGH4x2Bj5U3lQh3s+GztEAu0VPIDgL05ViMzJehQJU7e7sk7oEG6LUUMd
         LmAq62KN2Dxjtt8YCrF5KEkhFrZeEjwQHJl+ejobLcwa/vWPQq1H71IfIrNrASJ5pOKi
         3WwA==
X-Gm-Message-State: AOAM532pqkVR8dqVX9MvVqRP1EEd/XfZuF670I/LgkYVsyn1djAH6gXK
        wSV/UB6BMxcyqapVX8CUdwXy+g==
X-Google-Smtp-Source: ABdhPJwHKL05j7G2W2owZOHoDj9LUQ1sYMHVsV6hGMfnojZKI/XQTvxytrpnpxHORqq5whmYA+X+5w==
X-Received: by 2002:a05:6a00:181c:b029:3c6:2258:a844 with SMTP id y28-20020a056a00181cb02903c62258a844mr14233089pfa.6.1629082769496;
        Sun, 15 Aug 2021 19:59:29 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:17b8:f07a:2a52:317a])
        by smtp.gmail.com with UTF8SMTPSA id q29sm9769349pfl.142.2021.08.15.19.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Aug 2021 19:59:29 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH v5 2/7] dma-iommu: fix arch_sync_dma for map
Date:   Mon, 16 Aug 2021 11:57:50 +0900
Message-Id: <20210816025755.2906695-3-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
In-Reply-To: <20210816025755.2906695-1-stevensd@google.com>
References: <20210816025755.2906695-1-stevensd@google.com>
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


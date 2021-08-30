Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2673FB0AA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 07:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbhH3FBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 01:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbhH3FBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 01:01:32 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171F3C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 22:00:39 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id u11-20020a17090adb4b00b00181668a56d6so9122140pjx.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 22:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/VS4mvo3sV1dyJzQfdauWA5TTO+Tom8rl19Tszwo+xo=;
        b=anQ0zN7j+GJcEuaUBLLQmwHIVBH60mpnps17q81PSlJdxmIwWgErHTJ1KHG1dkLr45
         ANsJgtQM8xdy4QcNl4vsCcEJn8xww1p2fhaIBC73GtlX5oc2QBdSaieXOGnivPh/UOHT
         fe/f77MY9HPvk1d7O3qj8aMEXLPRkNhUOzB5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/VS4mvo3sV1dyJzQfdauWA5TTO+Tom8rl19Tszwo+xo=;
        b=FMl2rUxrayLuwN8hXkjOJwq6OPB8BaupZua7l75qTThYGZ2/CDukRr74/s35zYgc6E
         i13YMi9MUej0kn4EaVr7GVW9dI+d3uSz8XPh/QqINoxzVW1fy01Gd9Y7dzvVL8s/PSo4
         aOAkccPFOLrdax5Pcob+9ik+lXZTrvW9R5qUxigNNwMb5n3k2R8Yi1Z61CT5mPfzk6on
         8+HXtybnpTlYLjgLjVFKthBZzpoctdXN+QONSHhysXVJBF7wanCleGzAJnMOMuLe934i
         7XPvy3/C2Mfpzs3iQ+7PW2wvKfYgRbEGmg2N+F5bkE4lCz+GUIYXCORogJHBvm8UZP66
         q1WA==
X-Gm-Message-State: AOAM531WH8x3guqcaYfoXBDz0f+WInuMMT0PhjdNJrfET1Ckz9DhB6Wj
        k+GxWcoECB+21kFn979dklsQ9g==
X-Google-Smtp-Source: ABdhPJyx1l/gwIFaNymoiKGDrYWkTaqOD9FXeIxsFCrlnVTtHCQHfOEblXAk0c12OY9B7qcrV8H9/Q==
X-Received: by 2002:a17:90a:6b83:: with SMTP id w3mr24253385pjj.114.1630299638643;
        Sun, 29 Aug 2021 22:00:38 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:28a5:1b9f:af1d:5542])
        by smtp.gmail.com with UTF8SMTPSA id d17sm13065128pfn.110.2021.08.29.22.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Aug 2021 22:00:38 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, Rajat Jain <rajatja@google.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH v7 7/7] dma-iommu: account for min_align_mask w/swiotlb
Date:   Mon, 30 Aug 2021 13:59:25 +0900
Message-Id: <20210830045925.4163412-8-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
In-Reply-To: <20210830045925.4163412-1-stevensd@google.com>
References: <20210830045925.4163412-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

Pass the non-aligned size to __iommu_dma_map when using swiotlb bounce
buffers in iommu_dma_map_page, to account for min_align_mask.

To deal with granule alignment, __iommu_dma_map maps iova_align(size +
iova_off) bytes starting at phys - iova_off. If iommu_dma_map_page
passes aligned size when using swiotlb, then this becomes
iova_align(iova_align(orig_size) + iova_off). Normally iova_off will be
zero when using swiotlb. However, this is not the case for devices that
set min_align_mask. When iova_off is non-zero, __iommu_dma_map ends up
mapping an extra page at the end of the buffer. Beyond just being a
security issue, the extra page is not cleaned up by __iommu_dma_unmap.
This causes problems when the IOVA is reused, due to collisions in the
iommu driver.  Just passing the original size is sufficient, since
__iommu_dma_map will take care of granule alignment.

Fixes: 1f221a0d0dbf ("swiotlb: respect min_align_mask")
Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/dma-iommu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9b8c17c3d29b..addcaa09db12 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -805,7 +805,6 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
-	size_t aligned_size = size;
 	dma_addr_t iova, dma_mask = dma_get_mask(dev);
 
 	/*
@@ -814,7 +813,7 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	 */
 	if (dev_use_swiotlb(dev) && iova_offset(iovad, phys | size)) {
 		void *padding_start;
-		size_t padding_size;
+		size_t padding_size, aligned_size;
 
 		aligned_size = iova_align(iovad, size);
 		phys = swiotlb_tbl_map_single(dev, phys, size, aligned_size,
@@ -839,7 +838,7 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		arch_sync_dma_for_device(phys, size, dir);
 
-	iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
+	iova = __iommu_dma_map(dev, phys, size, prot, dma_mask);
 	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(phys))
 		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
 	return iova;
-- 
2.33.0.259.gc128427fd7-goog


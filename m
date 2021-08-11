Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145E33E8820
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 04:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhHKCos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 22:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbhHKCoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 22:44:44 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FAFC06179B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 19:44:18 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso7337374pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 19:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FhJsQrtI0mlERMxw9DUQORRBKVECLUnsn0dwH6DWscI=;
        b=GaECZtBIkJz6AyK40abK6J/+xb1of30F2yKMSOfbnFJzZa+eIrW9GbunW+ibsd9In3
         7Kc5Pg0qEdwK3TJRv5MsTWa+CRah7ae+e1BOe+EFrRArcSSxhsolZ43znN4wQRc1PCPu
         nPEKIZszTZB/NEcILNd/AZkE7jqyO4WOqXV1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FhJsQrtI0mlERMxw9DUQORRBKVECLUnsn0dwH6DWscI=;
        b=iyzh3XOLPr9wjKzbXMWS/H5HSnqL71qwB1bkPTR+q/hYOLCMREFNWB09ODxGQOeJ9z
         Z+ZGLf+yValWD/szLS8X0Kta8MSOevtvfbmrSIpUY4gVoXxiby2/DK2VT7NZ0RP67rIo
         ihVIYHfmrILpL4IwiDvHwC/oe3wkRh5Zy70xID0CcbY5lnVyzMCs2lUofKjr6/a376L7
         YcwYxmJQG7uDmRu5jwn1oCaH9vbwwI0xw/9Ve7/TbLIU0fTbVL3/nI85sRyBvorUudWD
         TWRUuYr04ZBHeQBmR4I/zirXr6gzA/P2I2ACMotQTQI2tzs3wz5EUARCq26jM1CaoOpz
         PsWQ==
X-Gm-Message-State: AOAM530FS+CEDwrm3gSXajabckvhngQ3wRtw/yhiXjvODMeXbjrXWTYO
        ThFU7oaci5JEl7CID8NQHCdLbA==
X-Google-Smtp-Source: ABdhPJywf14WhUCr12O+J7cLL1Oy8A8X6l/SjDM/es4+ywB1SrthLhZtomuPe2Vx+un8ayRcrCU0eQ==
X-Received: by 2002:a63:5506:: with SMTP id j6mr853602pgb.19.1628649858038;
        Tue, 10 Aug 2021 19:44:18 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:1e5c:70cb:3289:1b5b])
        by smtp.gmail.com with UTF8SMTPSA id k6sm10298046pjj.52.2021.08.10.19.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 19:44:17 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH v3 3/5] dma-iommu: add SKIP_CPU_SYNC after syncing
Date:   Wed, 11 Aug 2021 11:42:45 +0900
Message-Id: <20210811024247.1144246-4-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
In-Reply-To: <20210811024247.1144246-1-stevensd@google.com>
References: <20210811024247.1144246-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

After syncing in map/unmap, add the DMA_ATTR_SKIP_CPU_SYNC flag so
anything that uses attrs later on will skip any sync work that has
already been completed. In particular, this skips copying from the
swiotlb twice during unmap.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/dma-iommu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 4f0cc4a0a61f..be0214b1455c 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -859,8 +859,11 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
 		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
+		attrs |= DMA_ATTR_SKIP_CPU_SYNC;
+	}
+
 	__iommu_dma_unmap_swiotlb(dev, dma_handle, size, dir, attrs);
 }
 
@@ -999,8 +1002,10 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	if (dev_is_untrusted(dev))
 		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
 
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
 		iommu_dma_sync_sg_for_device(dev, sg, nents, dir);
+		attrs |= DMA_ATTR_SKIP_CPU_SYNC;
+	}
 
 	/*
 	 * Work out how much IOVA space we need, and align the segments to
@@ -1068,8 +1073,10 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 	struct scatterlist *tmp;
 	int i;
 
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
 		iommu_dma_sync_sg_for_cpu(dev, sg, nents, dir);
+		attrs |= DMA_ATTR_SKIP_CPU_SYNC;
+	}
 
 	if (dev_is_untrusted(dev)) {
 		iommu_dma_unmap_sg_swiotlb(dev, sg, nents, dir, attrs);
-- 
2.32.0.605.g8dce9f2422-goog


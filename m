Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A88C41BCC6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 04:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243806AbhI2CfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 22:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243796AbhI2CfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 22:35:02 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477BBC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 19:33:22 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id x8so477720plv.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 19:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=us44EW3OvFS63mEOdctiGT2oleivZtZVOW17HZap+Vc=;
        b=Jw262KUmuhbl/sYCnakVlHBhhx9CE979chPz21hcuMsLULQLV+Hf1WZ1xTTTCjpAoO
         0jV6vHbE7b+nsKY6qr28jwM94RIwIwrA6WWgsaIK6+hHyQISVEeZyTiu+jn8Z+mdNMF7
         TJBpYVn489ZQ7C+6yH724f5nzubVLWL5wIRTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=us44EW3OvFS63mEOdctiGT2oleivZtZVOW17HZap+Vc=;
        b=NlxdGgrSJAVM6+04VgqRrl4lg+swyCh9mmNUipYNLgORkuX4Xs9u4YFUb7Asu5HBIz
         T5P7TojPLmyUF+VVGkO/sBGlo+JZwLhBERhQ3RoRZTXXN0t1RcceyzmWBsBM4093M/zg
         K+0S6h1AIebnmeDDt7A6cDAmyxPvTpH51m/GzSTsiaz++pqlxEubsv4aWE2/t7hqASMV
         rsTMzvOiDfHptMiMVIiwyFNe5ogcFemggeAw2+8xc4kWegiAfi/yd37auPNamt8sgNm/
         op1xntjd1AlmkXlHknuA6HaaaFWQlT0tNxQsEfbqSezUSARrntLA4lD62Fc7Qi0LNyyH
         2eWQ==
X-Gm-Message-State: AOAM531O/u6UfTup3TP2zF/8O8lRkameCS2mWdhR2QxNIJDDXXBp/76D
        6pbabxPkkXaxaebVfDTaE6IzWQ==
X-Google-Smtp-Source: ABdhPJxBvXPw3MZGi/8ZraF3ETd+UnNQYItojSOJCC/3H3umcbZrmUdZenXsK4ZPAtlJ7TD6nHWwjg==
X-Received: by 2002:a17:90a:578e:: with SMTP id g14mr3656852pji.184.1632882801889;
        Tue, 28 Sep 2021 19:33:21 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:f818:368:93ef:fa36])
        by smtp.gmail.com with UTF8SMTPSA id 203sm403503pfx.119.2021.09.28.19.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 19:33:21 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, Rajat Jain <rajatja@google.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH v8 3/7] dma-iommu: skip extra sync during unmap w/swiotlb
Date:   Wed, 29 Sep 2021 11:32:56 +0900
Message-Id: <20210929023300.335969-4-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210929023300.335969-1-stevensd@google.com>
References: <20210929023300.335969-1-stevensd@google.com>
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
index 19bebacbf178..027b489714b7 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -521,6 +521,9 @@ static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
 	if (WARN_ON(!phys))
 		return;
 
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) && !dev_is_dma_coherent(dev))
+		arch_sync_dma_for_cpu(phys, size, dir);
+
 	__iommu_dma_unmap(dev, dma_addr, size);
 
 	if (unlikely(is_swiotlb_buffer(dev, phys)))
@@ -871,8 +874,6 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
 	__iommu_dma_unmap_swiotlb(dev, dma_handle, size, dir, attrs);
 }
 
@@ -1088,14 +1089,14 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
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
2.33.0.685.g46640cef36-goog


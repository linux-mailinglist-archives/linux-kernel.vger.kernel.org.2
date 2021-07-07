Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2523BE406
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 09:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhGGH6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 03:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhGGH6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 03:58:09 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3347FC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 00:55:30 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id a6so598714plh.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 00:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uGEeUgmKAJ+AMwE86QaIOFXRPTohU9n1eBXMqjimMhw=;
        b=C6uhEJCNPMqgdWKMTIwMcE72fXDVHxSVB5iPOxhZ1LxLff61nIukpV1idzH1n4hbim
         Uk+6DRwVgIZTfXIMMb+IEhmyuhgU1X+kHc18IhP1IL0TdWiPa6z8dCEL5CfTK5ECjB0i
         fz1rGSHN0UPfsOGJmIIVTkLtfvL7K3NVAFgZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uGEeUgmKAJ+AMwE86QaIOFXRPTohU9n1eBXMqjimMhw=;
        b=gxLqZuYTUR/XKbGo59W0UZ/NoIu+k5vgIrbnV0A0YJI2azVFmAJpk1whuNSxw/QtFl
         Jk1NgG/aGOZokUTbzPbDu+jBEB0N47uOf+QXhu+kGxn5D4g8hN0zVSiCHa/ukOd7JLNF
         EVCE7wKybYJG+889nZUM8W+72amfLNZVt2QNeezxn2Me1TzLlU1cT5Hodw0ONWcys23h
         ybybnMJ8mvTf45RYSsXlY35QpbZbf+JIkh7LS+ul4IzV3Z5PLTWV7c0f9DwiOZeirWS7
         JXmQWF+GIpHfW+IXgnSJaa2gAO7SOh9e+DqH3Y749vVvATX39aEoDlUou3ElC5AAniN2
         r0yw==
X-Gm-Message-State: AOAM531+w+05QobvVVT5gIXdreXNYBupSSsqKbGfYcUb+j26wskxleG3
        hYSop/SV1euYabR5AbkO7Sjl0g==
X-Google-Smtp-Source: ABdhPJz8OC0dxdmIRWsGcK94nsbwAUwXodh/VqsMrx7+HVDTL6k6AHKA2UIOnTwNTGrCHmXcwXgdSw==
X-Received: by 2002:a17:90a:6942:: with SMTP id j2mr18736528pjm.9.1625644529837;
        Wed, 07 Jul 2021 00:55:29 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:355a:c470:1237:e5f4])
        by smtp.gmail.com with UTF8SMTPSA id c24sm22522018pgj.11.2021.07.07.00.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 00:55:29 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH 1/4] dma-iommu: add kalloc gfp flag to alloc helper
Date:   Wed,  7 Jul 2021 16:55:02 +0900
Message-Id: <20210707075505.2896824-2-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210707075505.2896824-1-stevensd@google.com>
References: <20210707075505.2896824-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

Add gfp flag for kalloc calls within __iommu_dma_alloc_pages, so the
function can be called from atomic contexts.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/dma-iommu.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 614f0dd86b08..00993b56c977 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -593,7 +593,8 @@ static void __iommu_dma_free_pages(struct page **pages, int count)
 }
 
 static struct page **__iommu_dma_alloc_pages(struct device *dev,
-		unsigned int count, unsigned long order_mask, gfp_t gfp)
+		unsigned int count, unsigned long order_mask,
+		gfp_t page_gfp, gfp_t kalloc_gfp)
 {
 	struct page **pages;
 	unsigned int i = 0, nid = dev_to_node(dev);
@@ -602,15 +603,15 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
 	if (!order_mask)
 		return NULL;
 
-	pages = kvzalloc(count * sizeof(*pages), GFP_KERNEL);
+	pages = kvzalloc(count * sizeof(*pages), kalloc_gfp);
 	if (!pages)
 		return NULL;
 
 	/* IOMMU can map any pages, so himem can also be used here */
-	gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
+	page_gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
 
 	/* It makes no sense to muck about with huge pages */
-	gfp &= ~__GFP_COMP;
+	page_gfp &= ~__GFP_COMP;
 
 	while (count) {
 		struct page *page = NULL;
@@ -624,7 +625,7 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
 		for (order_mask &= (2U << __fls(count)) - 1;
 		     order_mask; order_mask &= ~order_size) {
 			unsigned int order = __fls(order_mask);
-			gfp_t alloc_flags = gfp;
+			gfp_t alloc_flags = page_gfp;
 
 			order_size = 1U << order;
 			if (order_mask > order_size)
@@ -680,7 +681,7 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
 
 	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	pages = __iommu_dma_alloc_pages(dev, count, alloc_sizes >> PAGE_SHIFT,
-					gfp);
+					gfp, GFP_KERNEL);
 	if (!pages)
 		return NULL;
 
-- 
2.32.0.93.g670b81a890-goog


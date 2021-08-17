Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D9F3EE3D6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 03:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbhHQBkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 21:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236280AbhHQBkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 21:40:07 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3C7C061292
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 18:39:34 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c17so17557464plz.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 18:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bH6cLE0zMhAQVWMm2D0O+HHUiSj+wLXXMwuwnh6v2/4=;
        b=iyWks8HhsOysI2qXvnHO59zz/9NNMj+xLZHMy7ZrsqUapbiN8qrPSpd3JkR/19bH32
         LN09eA3oCQSijRywugAepz4cGiCVfsm6Lwbj2xZmy/GokTWxnA/cKD564RUppL/77U/L
         4RTw03/keaOEiWBDqE0NHHZJj/NuN3be1CnKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bH6cLE0zMhAQVWMm2D0O+HHUiSj+wLXXMwuwnh6v2/4=;
        b=ksjAh7Vn0DKo4y3AvnCtZENyYag5Phdf4INfC94EUjSSzFccEiIhwktG6LoSEhbGxF
         NsGoQBH16OJBqRZLYCEBT59AKXEUDdWeexeOf6732KE06+2qzgWdI7A9KBnkqPck0y9z
         VJwpBWAEbIj7CH5OvovEZcbssWg6dr34bl8IjHpfpPdQmvlTqqdfNh3xXH+M/1C9h96S
         TTQp7EshGV4lb58qSLcgtNfyr6iNigPRjxQNNelVXv0qvQwSFXNjVWXda68O4aTEw5Mx
         Z5M5YpPCy5vlc3zAsZHlaifflpc8ISBZLbDx6B57B7ZLk88LtZ6QVfSa3vtrSXPQzOWe
         3Gcw==
X-Gm-Message-State: AOAM533A7b3MJNrZ2n++jV/9u7CwbWMjT5D02K0Ug9VXNHKEsoOoM4Gc
        9PONT5KzIoqPNYBW7C+q+it1iA==
X-Google-Smtp-Source: ABdhPJwFZbcrs17oaSWeQKBstAhkLuam/l24hSIdIrRP4saMF6o8GfwyhkOfUUYiO8Ik9dOrnVr+Vw==
X-Received: by 2002:a05:6a00:2171:b029:3ab:eca3:af59 with SMTP id r17-20020a056a002171b02903abeca3af59mr1049865pff.46.1629164373910;
        Mon, 16 Aug 2021 18:39:33 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:6864:767c:2ff8:749d])
        by smtp.gmail.com with UTF8SMTPSA id j68sm475347pgc.44.2021.08.16.18.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 18:39:33 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH v6 5/7] dma-iommu: Check CONFIG_SWIOTLB more broadly
Date:   Tue, 17 Aug 2021 10:38:50 +0900
Message-Id: <20210817013852.3222824-6-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
In-Reply-To: <20210817013852.3222824-1-stevensd@google.com>
References: <20210817013852.3222824-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

Introduce a new dev_use_swiotlb function to guard swiotlb code, instead
of overloading dev_is_untrusted. This allows CONFIG_SWIOTLB to be
checked more broadly, so the swiotlb related code can be removed more
aggressively.

Signed-off-by: David Stevens <stevensd@chromium.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 8152efada8b2..49a0d4de5f6c 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -317,6 +317,11 @@ static bool dev_is_untrusted(struct device *dev)
 	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
 }
 
+static bool dev_use_swiotlb(struct device *dev)
+{
+	return IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev);
+}
+
 /**
  * iommu_dma_init_domain - Initialise a DMA mapping domain
  * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
@@ -713,7 +718,7 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
 {
 	phys_addr_t phys;
 
-	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
+	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
@@ -729,7 +734,7 @@ static void iommu_dma_sync_single_for_device(struct device *dev,
 {
 	phys_addr_t phys;
 
-	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
+	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
@@ -747,7 +752,7 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	if (dev_is_untrusted(dev))
+	if (dev_use_swiotlb(dev))
 		for_each_sg(sgl, sg, nelems, i)
 			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
 						      sg->length, dir);
@@ -763,7 +768,7 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	if (dev_is_untrusted(dev))
+	if (dev_use_swiotlb(dev))
 		for_each_sg(sgl, sg, nelems, i)
 			iommu_dma_sync_single_for_device(dev,
 							 sg_dma_address(sg),
@@ -790,8 +795,7 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	 * If both the physical buffer start address and size are
 	 * page aligned, we don't need to use a bounce page.
 	 */
-	if (IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev) &&
-	    iova_offset(iovad, phys | size)) {
+	if (dev_use_swiotlb(dev) && iova_offset(iovad, phys | size)) {
 		void *padding_start;
 		size_t padding_size;
 
@@ -974,7 +978,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	    iommu_deferred_attach(dev, domain))
 		return 0;
 
-	if (dev_is_untrusted(dev))
+	if (dev_use_swiotlb(dev))
 		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
 
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
@@ -1046,7 +1050,7 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 	struct scatterlist *tmp;
 	int i;
 
-	if (dev_is_untrusted(dev)) {
+	if (dev_use_swiotlb(dev)) {
 		iommu_dma_unmap_sg_swiotlb(dev, sg, nents, dir, attrs);
 		return;
 	}
-- 
2.33.0.rc1.237.g0d66db33f3-goog


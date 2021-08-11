Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844393E8822
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 04:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbhHKCou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 22:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbhHKCoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 22:44:44 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4D9C061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 19:44:21 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id lw7-20020a17090b1807b029017881cc80b7so7318647pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 19:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d9Fogz88kO7TPs++Yazrj9aWtmQXYZLLHaGCMFZnMyA=;
        b=F7yHJk7uJWMZpLGrkdE9CZ+H2ElVNhVn+FjQYDoKpnUMSXQH4nyUsEijZahFd8i7GP
         94/H0B0AezIxjJoxtLz96aBUQdvwho2A7aEM7C9aVmemUo+/LDqHJylJyS/7L3Ltvsca
         eCrP9N9P8JANTUsYqoklGqV9+pWLecFo2tZkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d9Fogz88kO7TPs++Yazrj9aWtmQXYZLLHaGCMFZnMyA=;
        b=Zpi8SrvBsKlKSQ2iazKmcnwsyKKIqUewu66ryRoqltNUExyLmYKzTl2UxPROpzz517
         /FQakAfo7BLRbpWc/ghOmRZA3qBUX3jJxidAZsD4ZyJSVpuE4AWpRR2rX+eCKh4j+D/d
         yaiSUphba/MrpLGWYj+SU8qJpBqgomVuNGLTLTd8S6PHzs22HHeUd+rkVoAW+gGzet2+
         s3gIC1UxgefzR5eYDZMxXilWuWz9jTpQ28jk/rpI9gwsWem5W6upzRYnv0eJ41PgPgqg
         wwu9PU1wIKDNut7ghxAUq/P8b975f/W13X4AGVODeidqcz1ycyEaLoGnV8DcN9HMz7I4
         OE8g==
X-Gm-Message-State: AOAM533E2N5ditiCVE0jfX6W0FbOfTOxppO6asItWrQQwb4ZUce+744H
        8Vaq+WA55VrocalbsaNBC/AOugdz7MsA+g==
X-Google-Smtp-Source: ABdhPJyiYKdqzPWVKRAOY6h8Nqupanb8EQD3yZLDgsFhAA1wurDS3DwAuYxBcsdWTesSgHjZrzERFQ==
X-Received: by 2002:a63:5815:: with SMTP id m21mr131853pgb.363.1628649861448;
        Tue, 10 Aug 2021 19:44:21 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:1e5c:70cb:3289:1b5b])
        by smtp.gmail.com with UTF8SMTPSA id g3sm24332604pfi.197.2021.08.10.19.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 19:44:21 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH v3 4/5] dma-iommu: Check CONFIG_SWIOTLB more broadly
Date:   Wed, 11 Aug 2021 11:42:46 +0900
Message-Id: <20210811024247.1144246-5-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
In-Reply-To: <20210811024247.1144246-1-stevensd@google.com>
References: <20210811024247.1144246-1-stevensd@google.com>
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
---
 drivers/iommu/dma-iommu.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index be0214b1455c..89b689bf801f 100644
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
@@ -553,8 +558,7 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
 	 * If both the physical buffer start address and size are
 	 * page aligned, we don't need to use a bounce page.
 	 */
-	if (IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev) &&
-	    iova_offset(iovad, phys | org_size)) {
+	if (dev_use_swiotlb(dev) && iova_offset(iovad, phys | org_size)) {
 		aligned_size = iova_align(iovad, org_size);
 		phys = swiotlb_tbl_map_single(dev, phys, org_size,
 					      aligned_size, dir, attrs);
@@ -779,7 +783,7 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
 {
 	phys_addr_t phys;
 
-	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
+	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
@@ -795,7 +799,7 @@ static void iommu_dma_sync_single_for_device(struct device *dev,
 {
 	phys_addr_t phys;
 
-	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
+	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
@@ -813,10 +817,10 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
+	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
 		return;
 
-	if (dev_is_untrusted(dev))
+	if (dev_use_swiotlb(dev))
 		for_each_sg(sgl, sg, nelems, i)
 			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
 						      sg->length, dir);
@@ -832,10 +836,10 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
+	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
 		return;
 
-	if (dev_is_untrusted(dev))
+	if (dev_use_swiotlb(dev))
 		for_each_sg(sgl, sg, nelems, i)
 			iommu_dma_sync_single_for_device(dev,
 							 sg_dma_address(sg),
@@ -999,7 +1003,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	    iommu_deferred_attach(dev, domain))
 		return 0;
 
-	if (dev_is_untrusted(dev))
+	if (dev_use_swiotlb(dev))
 		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
 
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
@@ -1078,7 +1082,7 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 		attrs |= DMA_ATTR_SKIP_CPU_SYNC;
 	}
 
-	if (dev_is_untrusted(dev)) {
+	if (dev_use_swiotlb(dev)) {
 		iommu_dma_unmap_sg_swiotlb(dev, sg, nents, dir, attrs);
 		return;
 	}
-- 
2.32.0.605.g8dce9f2422-goog


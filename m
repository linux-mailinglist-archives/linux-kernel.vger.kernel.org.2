Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AC33C1DDA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 05:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhGIDiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 23:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbhGIDiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 23:38:16 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226ABC061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 20:35:32 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x3so3875703pfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 20:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aPud1GyRqsHfWkLqb0FlXVgreTjJC2V6WztaIayyWSM=;
        b=Oz19EtwvXHFJ9xThJtjG3VWdFo2q8LB56VxV2Ho+NUVxgWk2St/DulPnKjFgaZaIiB
         pcj5R/byIMkf2u3WLU+JQEWFbNfaf5Cw/+k5BpV5evK5JfGnqmeBBrnTgSxbK6h/Ot3j
         SRsxRPCMMc6Wc4sdI0avoGomEXuYl9aUN1nlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aPud1GyRqsHfWkLqb0FlXVgreTjJC2V6WztaIayyWSM=;
        b=OclgDj9XtgwnQMF4weUlHd9dNGp0QN2lqvvWXKgKPbu7b63+N/wey0fzjdNdRGXmf1
         ZCnN79rzWt9Ds/TZ3imhnId0Zjxg/L6geYmfXVigl1C9d0e4mvebqXYatYWIOuXBNKLJ
         6GPCeq79mzBhjGWTt3GF1QcDwPkVL2ck5ewQVIont0hSg/QkknnEQHih34To06LqFPMV
         41qV/CZRuE3da7A9MzPT0LTwImqh4xi4oqAaPz3JQ0F60SpD5hA2rJUZOGwoEdmZjOWa
         OnVsK4KTLwRMpKJxLoyRIHdDCNjXSGXUsKJ/2zyuYEHHfChUdvl2A3kfx/eq1T4SWCT2
         ymxA==
X-Gm-Message-State: AOAM532vvwhat9Nk/cIj9Xi51cDPzbMPoJnhlSG482QcWVJCbk22+o07
        nJHnKoMwpgYFCKGd4QV2sAZMAQ==
X-Google-Smtp-Source: ABdhPJygOn61MoRfFdo0T28bisoiZKhSuqrDH85f31YMxg2ilbL/TX1nGtNYAbIP3F/aEqnvt2zNIg==
X-Received: by 2002:a63:794:: with SMTP id 142mr35500830pgh.198.1625801731764;
        Thu, 08 Jul 2021 20:35:31 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:d47a:af0a:d5b9:e774])
        by smtp.gmail.com with UTF8SMTPSA id g9sm247857pfr.133.2021.07.08.20.35.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 20:35:31 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH v2 4/4] dma-iommu: Check CONFIG_SWIOTLB more broadly
Date:   Fri,  9 Jul 2021 12:35:02 +0900
Message-Id: <20210709033502.3545820-5-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210709033502.3545820-1-stevensd@google.com>
References: <20210709033502.3545820-1-stevensd@google.com>
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
index 0a9a9a343e64..d8a0764c69aa 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -315,6 +315,11 @@ static bool dev_is_untrusted(struct device *dev)
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
@@ -552,8 +557,7 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
 	 * If both the physical buffer start address and size are
 	 * page aligned, we don't need to use a bounce page.
 	 */
-	if (IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev) &&
-	    iova_offset(iovad, phys | org_size)) {
+	if (dev_use_swiotlb(dev) && iova_offset(iovad, phys | org_size)) {
 		aligned_size = iova_align(iovad, org_size);
 		phys = swiotlb_tbl_map_single(dev, phys, org_size,
 					      aligned_size, dir, attrs);
@@ -778,7 +782,7 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
 {
 	phys_addr_t phys;
 
-	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
+	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
@@ -794,7 +798,7 @@ static void iommu_dma_sync_single_for_device(struct device *dev,
 {
 	phys_addr_t phys;
 
-	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
+	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
@@ -812,10 +816,10 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
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
@@ -996,7 +1000,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	    iommu_deferred_attach(dev, domain))
 		return 0;
 
-	if (dev_is_untrusted(dev))
+	if (dev_use_swiotlb(dev))
 		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
 
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
@@ -1071,7 +1075,7 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_sg_for_cpu(dev, sg, nents, dir);
 
-	if (dev_is_untrusted(dev)) {
+	if (dev_use_swiotlb(dev)) {
 		iommu_dma_unmap_sg_swiotlb(dev, sg, nents, dir, attrs);
 		return;
 	}
-- 
2.32.0.93.g670b81a890-goog


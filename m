Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA9B3EB1DF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 09:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239703AbhHMHqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 03:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239042AbhHMHoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:44:00 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D3CC061224
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 00:42:48 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id e19so10776935pla.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 00:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=39hkNmw6o7Z0mNIDijrFuXQ77XHiAZfo7UkU2TVoZZI=;
        b=YfA1LumMveWEilLmwpuS8MN4XSqv9UJi0P7hqJauNlaSRr4OULvU+AtHTS2Pi72Gn4
         j1cwRAofyqssx4rJ3xp/bofOFanP7pUehmxPRR/JKrs94zNmuiJhjbaRgjCDsFUPjRYb
         A+61dBnjw+5gMT1efXHKQ7V8lcMjcUjAcUJ2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=39hkNmw6o7Z0mNIDijrFuXQ77XHiAZfo7UkU2TVoZZI=;
        b=q9vklRDQte1V7oYDXwxP1gtHfLwPxn5g7UUoQsjdBLgbGdPgcbl8M/BE6ww2YyiZvY
         O6kDU309JGFXMPl8hewGyo6IVDupsi0rKtKXgVXJHGb1UkqE/trp3L+BBuB4xUISppN1
         NTPle1pPEKYtXoaL8dwNcmNmWqwuSQLHMVnKkwgEjdU31GpJrwIF+S8jwWIFfFVaYIli
         suiUuCtzRIcKhyF7y2IJvS1u/7KTQBjL6S14bI/eAml7HoMlWQUDUoDXWRCzJUXMNSOS
         NSVD0Sv/xNlrSujXV9EXwk9limMOsMUmtmsjbkFcgfUpjzUacZyOmV5ROMTVhyNEKrGd
         +Rng==
X-Gm-Message-State: AOAM530xDSUIezn6DkAYqafLFH/H92zdFr08rCOP249Ro0WcTqh30uqv
        PxlzmhkhxTo07RjdaEOLrSz0Pw==
X-Google-Smtp-Source: ABdhPJwXo68wilxYpjBxAsjuThyV6rBpf4cQgxADZETuJFhjNKeMX+0S192jGGgN92MC5k1g7FFisg==
X-Received: by 2002:a63:a511:: with SMTP id n17mr1217056pgf.156.1628840568515;
        Fri, 13 Aug 2021 00:42:48 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:cbc8:5998:527e:5f43])
        by smtp.gmail.com with UTF8SMTPSA id u190sm1173679pfb.95.2021.08.13.00.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 00:42:48 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH v4 4/6] dma-iommu: Check CONFIG_SWIOTLB more broadly
Date:   Fri, 13 Aug 2021 16:38:37 +0900
Message-Id: <20210813073839.1562438-5-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
In-Reply-To: <20210813073839.1562438-1-stevensd@google.com>
References: <20210813073839.1562438-1-stevensd@google.com>
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
---
 drivers/iommu/dma-iommu.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f7da4934f7e6..bad813d63ea6 100644
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
@@ -790,7 +795,7 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	 * If both the physical buffer start address and size are
 	 * page aligned, we don't need to use a bounce page.
 	 */
-	if (IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev) &&
+	if (IS_ENABLED(CONFIG_SWIOTLB) && dev_use_swiotlb(dev) &&
 	    iova_offset(iovad, phys | size)) {
 		void *padding_start;
 		size_t padding_size;
@@ -975,7 +980,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	    iommu_deferred_attach(dev, domain))
 		return 0;
 
-	if (dev_is_untrusted(dev))
+	if (dev_use_swiotlb(dev))
 		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
 
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
@@ -1047,7 +1052,7 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 	struct scatterlist *tmp;
 	int i;
 
-	if (dev_is_untrusted(dev)) {
+	if (dev_use_swiotlb(dev)) {
 		iommu_dma_unmap_sg_swiotlb(dev, sg, nents, dir, attrs);
 		return;
 	}
-- 
2.33.0.rc1.237.g0d66db33f3-goog


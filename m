Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFE639EBBC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 03:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhFHB51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 21:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbhFHB5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 21:57:19 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0457FC06178B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 18:55:27 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id z26so14494106pfj.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 18:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PVlNy6GFZskXwhmJM3/KpQE5O4kPgimeLb6iehn44jE=;
        b=rtJTHteosGHqvGerLxDOacK+OAEMS78keadnAtsslhFWaQd76IG1I30qATHXr3U1+O
         u3Pcn1u1ZaZRTEe+TJKtRGrJsu6jCGVCIaVNvZwLnv+haxMJUIcv4V7FcTwSWlQWKaKn
         aA0hbuDVmbkf2rTc/lUjXn3S3OncimcpFr4HfORnYrLWfc1K+Uot7v/FN8M94eahUWmD
         qmAvOgQ6/N2w8+Mx6URrug9t+oTsSGpkjqJGShkmyVJCZjEEW7vu1eHcJL8gTPC8b2Qm
         79m+BHGTzTBpdNAbBzIXch0lgWWTlWIoWCgZcFZuIkRbKHuhsEnuJfpovzQZ+NPg29Bc
         hHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PVlNy6GFZskXwhmJM3/KpQE5O4kPgimeLb6iehn44jE=;
        b=RB05NyoMHcW8bNneDtjoDn6CHUpUIZKVdvlNDNXpC8300xUqoXFPMH0eHMQagHJijl
         fvzoXY7qMRjEXY/M8BelnWdVCNw6BpnPAFiMTHuc15J7wrKO0sQCjEHg2FpBwZB7dFZ2
         7CUl4Dqr1ChZOpkgU08hbNji59SbwOiPiYba1ZYTzLzmwbZ2eOcgEUloxwmXEssbHFEi
         Lk6jchUauLURqzESan2caPhlIcMexG9BJlUBz6j+eCBe1WvEN5Gde55pJTXWr0UltzVI
         uE0e63V/zvfswNdnkqxbUEt9ltYV6Sb7VkMlplTC0fdhK4N7BEv7crHw3HvkwCTQyAzZ
         VFFQ==
X-Gm-Message-State: AOAM531HSFCL42KvSzLVq/cw5WhNqDiF8rewApiGKNL2ng4nsdnSKdZi
        gqpDC8dVCNvkAd29ovKbPzk=
X-Google-Smtp-Source: ABdhPJxVT8efeIufgkaSCDKk6eZ4gB5/q4jKeVg4vhx+g85q5sdx4JTMRcU359SIEQBq5lXjHMHE/g==
X-Received: by 2002:a05:6a00:26d8:b029:2ea:1101:8acf with SMTP id p24-20020a056a0026d8b02902ea11018acfmr19317888pfw.67.1623117324738;
        Mon, 07 Jun 2021 18:55:24 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id s24sm9284767pfh.104.2021.06.07.18.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 18:55:24 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] iommu: Improve iommu_iotlb_gather helpers
Date:   Mon,  7 Jun 2021 11:25:38 -0700
Message-Id: <20210607182541.119756-4-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607182541.119756-1-namit@vmware.com>
References: <20210607182541.119756-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

The Mediatek driver is not the only one which might want a basic
address-based gathering behaviour, so although it's arguably simple
enough to open-code, let's factor it out for the sake of cleanliness.
Let's also take this opportunity to document the intent of these
helpers for clarity.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

Changes from Robin's version:
* Added iommu_iotlb_gather_add_range() stub !CONFIG_IOMMU_API
* Use iommu_iotlb_gather_add_range() in iommu_iotlb_gather_add_page()
---
 drivers/iommu/mtk_iommu.c |  5 +----
 include/linux/iommu.h     | 43 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index e06b8a0e2b56..0af4a91ac7da 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -523,10 +523,7 @@ static size_t mtk_iommu_unmap(struct iommu_domain *domain,
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 	unsigned long end = iova + size - 1;
 
-	if (gather->start > iova)
-		gather->start = iova;
-	if (gather->end < end)
-		gather->end = end;
+	iommu_iotlb_gather_add_range(gather, iova, size);
 	return dom->iop->unmap(dom->iop, iova, size, gather);
 }
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 32d448050bf7..f254c62f3720 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -497,6 +497,38 @@ static inline void iommu_iotlb_sync(struct iommu_domain *domain,
 	iommu_iotlb_gather_init(iotlb_gather);
 }
 
+/**
+ * iommu_iotlb_gather_add_range - Gather for address-based TLB invalidation
+ * @gather: TLB gather data
+ * @iova: start of page to invalidate
+ * @size: size of page to invalidate
+ *
+ * Helper for IOMMU drivers to build arbitrarily-sized invalidation commands
+ * where only the address range matters, and simply minimising intermediate
+ * syncs is preferred.
+ */
+static inline void iommu_iotlb_gather_add_range(struct iommu_iotlb_gather *gather,
+						unsigned long iova, size_t size)
+{
+	unsigned long end = iova + size - 1;
+
+	if (gather->start > iova)
+		gather->start = iova;
+	if (gather->end < end)
+		gather->end = end;
+}
+
+/**
+ * iommu_iotlb_gather_add_page - Gather for page-based TLB invalidation
+ * @domain: IOMMU domain to be invalidated
+ * @gather: TLB gather data
+ * @iova: start of page to invalidate
+ * @size: size of page to invalidate
+ *
+ * Helper for IOMMU drivers to build invalidation commands based on individual
+ * pages, or with page size/table level hints which cannot be gathered if they
+ * differ.
+ */
 static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
 					       struct iommu_iotlb_gather *gather,
 					       unsigned long iova, size_t size)
@@ -515,11 +547,7 @@ static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
 		gather->pgsize = size;
 	}
 
-	if (gather->end < end)
-		gather->end = end;
-
-	if (gather->start > start)
-		gather->start = start;
+	iommu_iotlb_gather_add_range(gather, iova, size);
 }
 
 /* PCI device grouping function */
@@ -702,6 +730,11 @@ static inline void iommu_iotlb_sync(struct iommu_domain *domain,
 {
 }
 
+static inline void iommu_iotlb_gather_add_range(struct iommu_iotlb_gather *gather,
+						unsigned long iova, size_t size)
+{
+}
+
 static inline phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 {
 	return 0;
-- 
2.25.1


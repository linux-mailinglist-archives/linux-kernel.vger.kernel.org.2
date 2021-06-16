Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5A33AA278
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 19:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhFPRgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 13:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbhFPRge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 13:36:34 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F44BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 10:34:28 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t9so2577182pgn.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 10:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dRmBSLhAuXxBVTuhCH5oFREPk0hy4CPzH2ZUQRDqv1I=;
        b=BQujgSI/SQuHMrtiNYyK9oa6Xkfiw5O6r5xaRKxR6ggIFV/lLfFN2U4CWDUguYX9UY
         9jpQBY6lck0rgEk9mvySpQp9laDFb9yNlYdGvZOlr3F4VijrCK63JKcT+e63tY4lPKc4
         urCyYX9XgencbyvDKb5mWWeUJpbjqbPrtdAMUkXSUL7YfIQyK2n68UakUcbe1Xnl+FX5
         eCuhPaLG2UK8XLqeUEs9M1G4jHPgnO/zdSFIi5NuznYdnN5a60txyM4Xixl4Qm409Uqf
         u/OPa6yktVFgohfdFrZ9OEVNWZuURcq3GgHDqrzDDozq7G9PSbAjaQ09Al6o5eoYKQ8h
         LaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dRmBSLhAuXxBVTuhCH5oFREPk0hy4CPzH2ZUQRDqv1I=;
        b=eoYpdrsnFqSvl6dpAOawBcFQSFmtorCSqlAaA/iqbKc5Y7p8LMUGLrnnAp63WsHPgv
         e3UAjCP6JP8gm3M9rGa/+MBuQIpxXyVDau1+Y/+4rbOhdviYxQVZYG3AWzJN29ZAOuMG
         rk1tEnhb81d7QO9SNOVD60jP4L16Hci8Aidsu5OUvTa/DT+cdA3WXVMqsz8Q+NFZKiVs
         QKCKjTLqN118yjR11Dj1yeJKEFgKUasEIFuCX/7qkmWZ8W1OH9F7Us+irkxF8rpjFI4E
         ze5fC6x0sAFylNjfGxVfjyRJHCL//+f3oG01X2PVyR08ZCyOIE1bCiu+yEP2rx05WzXI
         JufA==
X-Gm-Message-State: AOAM532GdeLNwQV/cATXLbSCJXcfH4Dz8X3PEOCGB1juVnIw5+zOd1Za
        hZmP6F4ExgE6z/fkH7oxN64=
X-Google-Smtp-Source: ABdhPJwB7O62mp8ypvQ1bWIM4zK7x+69bkrCnrTVjMC2IdH7tq14Fu/IrkgxzCLmHN30YuRsXaF7OQ==
X-Received: by 2002:a05:6a00:c2:b029:2ee:9cfc:af85 with SMTP id e2-20020a056a0000c2b02902ee9cfcaf85mr983338pfj.78.1623864867588;
        Wed, 16 Jun 2021 10:34:27 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id m3sm2933901pfh.174.2021.06.16.10.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 10:34:27 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH v4 3/7] iommu: Improve iommu_iotlb_gather helpers
Date:   Wed, 16 Jun 2021 03:04:56 -0700
Message-Id: <20210616100500.174507-4-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616100500.174507-1-namit@vmware.com>
References: <20210616100500.174507-1-namit@vmware.com>
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
Signed-off-by: Nadav Amit <namit@vmware.com>

---

Changes from Robin's version:
* Added iommu_iotlb_gather_add_range() stub !CONFIG_IOMMU_API
* Use iommu_iotlb_gather_add_range() in iommu_iotlb_gather_add_page()
---
 drivers/iommu/mtk_iommu.c |  6 +-----
 include/linux/iommu.h     | 38 +++++++++++++++++++++++++++++++++-----
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index e06b8a0e2b56..cd457487ce81 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -521,12 +521,8 @@ static size_t mtk_iommu_unmap(struct iommu_domain *domain,
 			      struct iommu_iotlb_gather *gather)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
-	unsigned long end = iova + size - 1;
 
-	if (gather->start > iova)
-		gather->start = iova;
-	if (gather->end < end)
-		gather->end = end;
+	iommu_iotlb_gather_add_range(gather, iova, size);
 	return dom->iop->unmap(dom->iop, iova, size, gather);
 }
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 32d448050bf7..e554871db46f 100644
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
-- 
2.25.1


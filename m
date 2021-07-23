Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862C03D3E17
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 19:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbhGWQVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 12:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhGWQVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 12:21:30 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FE9C061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 10:02:03 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id a9so3084059pjw.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 10:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZOtpaC4Ypd4T1gRyw7mWdmcY15YhrZKpr6JIl6t/8bQ=;
        b=DC17T2un6ipQQvJOy8tv7AwJ0k2o8iKNJCWM3GlUdJyi3ViAzs8PfVaGfRPrdTGGfW
         sOz6RCYKNpWU5OtE42KYVnKqz2U/14IvIz7lumRkfDzbVy0t1foQkumNpydjv2C2xL2d
         8Ffv00Q5o+cSau/WPxWnzb18hsPH16g7tZDAU7kKdr2+lbHbZIGGM3c24p9ItsxPdkq3
         zcU8BkQ1+3yQEm6pWkHrgloHlS0XT2d6bUhumkiKhJZ9pw4P5zjJIagNc1USmAaTg5S6
         /uhFj38bQAb596dOHrqc5BzN0RU1W6stdTDxEK7wrAD1AhpJ8HAFT+Y5gubCv2c8GUjT
         U3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZOtpaC4Ypd4T1gRyw7mWdmcY15YhrZKpr6JIl6t/8bQ=;
        b=ppoopMDcm7ed5q+nmQ99TcOWafw7tNfqSPO+Ya4M9p/VUWEW5mQa0Zjj3FLbKKzGvt
         PQBN6razvtvSASKKbaCTKL0+Vg2paz+sXRGrHHNSIyPZktV8nyg7U5sfcUTrovVZUEUG
         v8qhX2XTPJKZsYN0dwHn/7L5Fvlc6+MmnDMIZb6FhQ0kPqkd7YCiCD8XINLlToBWQVTh
         JpX8MpCEPFgPYYddn6zM6op+gAv1ewUyFiLZgdcAO8LK0UdnrDTpXRvD8y/bi9B7X04/
         Hn3rKp25x2h5EqWPsyumfBEo4kgpSc2K6wJOx+Pup+RP05YEXVoTnznI88CGTVS4uUo0
         Y1yg==
X-Gm-Message-State: AOAM530VD5Yz2kOd7wFH0jbBCum+PnnRQ5x5kuRweefvGZP5vxiu4TUE
        Znfn631GxrrieNyiOndjv0E=
X-Google-Smtp-Source: ABdhPJxrlYneBL/21Vv+jWVwD9xwJ6n1OmSun1pN9q8BI/YgevVlJp7ILLU6zark7cDESnfNn2z9lQ==
X-Received: by 2002:a17:90b:4a4b:: with SMTP id lb11mr5443506pjb.99.1627059722696;
        Fri, 23 Jul 2021 10:02:02 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d15sm33479004pfl.82.2021.07.23.10.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 10:02:02 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     John Garry <john.garry@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH v6 3/7] iommu: Improve iommu_iotlb_gather helpers
Date:   Fri, 23 Jul 2021 02:32:05 -0700
Message-Id: <20210723093209.714328-4-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210723093209.714328-1-namit@vmware.com>
References: <20210723093209.714328-1-namit@vmware.com>
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
 drivers/iommu/mtk_iommu.c |  6 +-----
 include/linux/iommu.h     | 38 +++++++++++++++++++++++++++++++++-----
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 6f7c69688ce2..d9939e4af35c 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -520,12 +520,8 @@ static size_t mtk_iommu_unmap(struct iommu_domain *domain,
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


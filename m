Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D753C75B7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 19:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbhGMR1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 13:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbhGMR1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 13:27:43 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C27C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 10:24:53 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id n11so12555196pjo.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 10:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZOtpaC4Ypd4T1gRyw7mWdmcY15YhrZKpr6JIl6t/8bQ=;
        b=fp5UYghHE6KtNxD2b1E0TGw4ywdgqHo3DOU3XSqTy6BSP+SAI8jHkwFLuZ3ATi7uL7
         HjFY+YKKSKQxJnesW4N/MjEkeeaYVa2kZfvqQdMInA1LUAY8z9UzZoIZyNj0wwhanH6v
         3d+GTNcVYLKF7perJ0FNaJBkN3n1kPPP72ZTBnwddzBr6bJmzb+Ku+B7cKY3gSLLUyo5
         tSMYW9YA+TYgOZ/6cIergAnS2FhUUb1eYasucW6nue4Zriipvxl0wH6ukQ7MAfni27p4
         pxn2NKJeWfNWA8icoA7xTgm8dxFPhK+yt3T7OkHyih+olTmCWENmbEaRjt6gOQImN4qv
         QbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZOtpaC4Ypd4T1gRyw7mWdmcY15YhrZKpr6JIl6t/8bQ=;
        b=GNhp39Adjw6OsEWVspaF1cdar6WVO/blM6G0egRoCNp9Mm8QSiG6hDAyCtE2/N8S9/
         /XbIs/ryNcbhXN10SqO/hYUOy66vs2gKA/0VaqIHcNqEJC9KFbU5Z9doXEbTaWduQUcm
         cuQZAIJUqL9tjwL7BoE0k0Vw1pQHnys2hjy936gW808RjWgF0Nv38YcJMMwdObm1+zj6
         2qbkTh940eIjVbMILaBjaSxXJw24D9ABLY4lq9qijeotray3ufWksHUfjAvdQ4vRqMmN
         MFNet8+TQLVTWz5rnuYy0L8Fj77TDenspAD/mC35FKrJazxDDS+6JEsLUD1P/v/k6uCF
         WTdg==
X-Gm-Message-State: AOAM5326HbCLtp7iW6PKv72vWeXQZFm2dQfIJM9l2iVNA4HC7/3cmryh
        5dg7wIkCmJakq8Awojvo8d0=
X-Google-Smtp-Source: ABdhPJwDB3PHMILWk7WENii0WJjizUfXAPoiKBUBnI4U8E94UulJuRUPIXWr4LSf1rcBkQhpKrWnsA==
X-Received: by 2002:a17:90a:8407:: with SMTP id j7mr399030pjn.13.1626197092437;
        Tue, 13 Jul 2021 10:24:52 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id lt14sm18239032pjb.47.2021.07.13.10.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 10:24:51 -0700 (PDT)
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
Subject: [PATCH v5 3/7] iommu: Improve iommu_iotlb_gather helpers
Date:   Tue, 13 Jul 2021 02:41:47 -0700
Message-Id: <20210713094151.652597-4-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713094151.652597-1-namit@vmware.com>
References: <20210713094151.652597-1-namit@vmware.com>
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


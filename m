Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8AB39EBC0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 03:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhFHB6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 21:58:19 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:37856 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhFHB6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 21:58:18 -0400
Received: by mail-pf1-f171.google.com with SMTP id y15so14493961pfl.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 18:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a5Q03kPB9N31Dxz5JpgFwNRhEHR7Ck7FkWGxbrLez1o=;
        b=MmLsD0VYye5jr8qllapIW+sULNF1AqgI9y2nx0BegR+bTMbQ2Hfsv+TVMqg8Eqfnbl
         mfq0nXiK0HKYzuDVdn0d6/aC4iMXJF8oZ/YQhRuhW/KJS7zvmnNKKP9Z1Xpp7NsdRmBY
         lFxqMbHPN55xVsBkDq/mWF0RQxk73S43HBdlnln22aD8EJQbR0eEzqhV2atNiUNlSWMW
         H0gyaW/LvxoWJM1RK8db7LbeOpjHrQAXDbqQKdqYfX5AbNexcyKTrsupYfM9OAUtO1C9
         VzxRKtyZvoXDM/aaoHk3lbldaavnmLEQXO2Td98VDXOni+4LmNP/zZgCpTYIV7hwm/mT
         iJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a5Q03kPB9N31Dxz5JpgFwNRhEHR7Ck7FkWGxbrLez1o=;
        b=XPWUOCyumufGYbVBIQkK/aCJsIy43LEVNoYXzbTa/wonrEEUGvc7EwjMECr6p6e9kZ
         IEMW86fuooD1yHJ/EVLK62bPd1CJsBBq2uYXlli4s3qnrXFJE8UKOSMVkze26j6WINYP
         DCk98ckJwVMziwyszM+geRu1XaZdyAwKEEuYegoTqCsyEc1Xfjh8FxqvT8kQGPIIGDYS
         mg7up+9NBER+hBzSEZz7RBCVGSJ4RKUu6F6YsD+74W9A7u+3OkZUjTdctsMN+ufBmGlr
         RFX9OtPHtCQsDTRvWibdreGIKJqSfWIbbPQB4r4U+YHHdiidbcSZmkQ7+4qYFksTWloc
         twsQ==
X-Gm-Message-State: AOAM532GF+OQ7lwzslIpo1gabnSwBtfM4I099Boiqb91MA3RPmooMOhY
        9ubizjSYiDoDsOv+zOY6os4ASvDUXjPuxw==
X-Google-Smtp-Source: ABdhPJySj6bY3RLL5G2GGlLOcMIbtH6J1GqfmqQkYZySvs5JdXKnRZ6oPYN23g6N0eNUQOOcCrT6bA==
X-Received: by 2002:aa7:8114:0:b029:2e9:c437:1121 with SMTP id b20-20020aa781140000b02902e9c4371121mr19464441pfi.7.1623117326092;
        Mon, 07 Jun 2021 18:55:26 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id s24sm9284767pfh.104.2021.06.07.18.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 18:55:25 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Nadav Amit <namit@vmware.com>, Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] iommu: Factor iommu_iotlb_gather_is_disjoint() out
Date:   Mon,  7 Jun 2021 11:25:39 -0700
Message-Id: <20210607182541.119756-5-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607182541.119756-1-namit@vmware.com>
References: <20210607182541.119756-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Refactor iommu_iotlb_gather_add_page() and factor out the logic that
detects whether IOTLB gather range and a new range are disjoint. To be
used by the next patch that implements different gathering logic for
AMD.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 include/linux/iommu.h | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f254c62f3720..b5a2bfc68fb0 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -497,6 +497,28 @@ static inline void iommu_iotlb_sync(struct iommu_domain *domain,
 	iommu_iotlb_gather_init(iotlb_gather);
 }
 
+/**
+ * iommu_iotlb_gather_is_disjoint - Checks whether a new range is disjoint
+ *
+ * @gather: TLB gather data
+ * @iova: start of page to invalidate
+ * @size: size of page to invalidate
+ *
+ * Helper for IOMMU drivers to check whether a new range is and the gathered
+ * range are disjoint. For many IOMMUs, flushing the IOMMU in this case is
+ * better than merging the two, which might lead to unnecessary invalidations.
+ */
+static inline
+bool iommu_iotlb_gather_is_disjoint(struct iommu_iotlb_gather *gather,
+				    unsigned long iova, size_t size)
+{
+	unsigned long start = iova, end = start + size - 1;
+
+	return gather->end != 0 &&
+		(end + 1 < gather->start || start > gather->end + 1);
+}
+
+
 /**
  * iommu_iotlb_gather_add_range - Gather for address-based TLB invalidation
  * @gather: TLB gather data
@@ -533,20 +555,16 @@ static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
 					       struct iommu_iotlb_gather *gather,
 					       unsigned long iova, size_t size)
 {
-	unsigned long start = iova, end = start + size - 1;
-
 	/*
 	 * If the new page is disjoint from the current range or is mapped at
 	 * a different granularity, then sync the TLB so that the gather
 	 * structure can be rewritten.
 	 */
-	if (gather->pgsize != size ||
-	    end + 1 < gather->start || start > gather->end + 1) {
-		if (gather->pgsize)
-			iommu_iotlb_sync(domain, gather);
-		gather->pgsize = size;
-	}
+	if ((gather->pgsize && gather->pgsize != size) ||
+	    iommu_iotlb_gather_is_disjoint(gather, iova, size))
+		iommu_iotlb_sync(domain, gather);
 
+	gather->pgsize = size;
 	iommu_iotlb_gather_add_range(gather, iova, size);
 }
 
@@ -730,6 +748,13 @@ static inline void iommu_iotlb_sync(struct iommu_domain *domain,
 {
 }
 
+static inline
+bool iommu_iotlb_gather_is_disjoint(struct iommu_iotlb_gather *gather,
+				    unsigned long iova, size_t size)
+{
+	return false;
+}
+
 static inline void iommu_iotlb_gather_add_range(struct iommu_iotlb_gather *gather,
 						unsigned long iova, size_t size)
 {
-- 
2.25.1


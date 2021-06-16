Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5BC03AA27E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 19:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhFPRgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 13:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbhFPRgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 13:36:38 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BA6C061760
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 10:34:29 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id v7so2590463pgl.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 10:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hs2JqvHLc2VhwLkCLKEeX1pzwKqE7ns6gX3Zd+1Br1s=;
        b=AuFzhHmQOykzLH+MM2+snE+jgetovtrcAA9tToZ4Hwqpc4ggWwisMmLP8LmdDI1DZP
         M9wsgjXbeOs/7OrkHYKEI/LYtx9RaTtI6hSxFJVvoKvjlrGCCd+USinhf+sGBgqCzk/9
         l5scqtjteV8HcG2vA1J63HQUPGEYU6E02fahsVg2hAVBJwA5BtD40lQeGzaEor8q5cX9
         j2+J8F5sEaaM0/eSedOq2RCBdUUxUgkHGhxWjiUq2v5qR2leo73iWaAAMRQrAaZKEXQp
         OleZbYNR4kdcdGupYsUdUeRjxVv2R4Wxfd/aA1kE006DimXpl+tShRgh5fbZ1LXzmmqD
         7hJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hs2JqvHLc2VhwLkCLKEeX1pzwKqE7ns6gX3Zd+1Br1s=;
        b=NoaWwsxxUhWHLgiR/xY1tY6yuyprV6VSU/DXcU/1MxqsR/jaJgiGPjXP3XKm8R+yDO
         SrgXqhz8sfri4HPSdF/vn09jxo6pUaAgSa/OasjiqUBPjISVkV7C5kfZVBBfRNfm3Q+3
         TP0oeMMQRMJQkRh4Nv7L5xlgIm4uXnbd6fWq6memSDYilI9LRqlfPzo3ib9GQRQ7UaGe
         soVJ7pD6LeZyEabj3zGwUmSpKRHTCOz09BKilRS52Ge0b4ZS+UdycgTtcwM12x1hIsvI
         tfELVqv0rOBxNl9t53Fgx5qdWtHduln+bZkZbguSquPsyfm9B2RDvVy/qwTlOZT4ncvj
         Zorg==
X-Gm-Message-State: AOAM530683GNIrLQt1Y3b+B5tc0GfZGbIIimS/1aNM5J1v915qA/WL9J
        bILV+BJHpCyiD5BSTYyV6jw=
X-Google-Smtp-Source: ABdhPJwD23Vxr1ODoNWLpOERLWSC6h7gVARUONxTC477QL2wMV0+PuyKXe+dFMJRXPV5NMLcEW/e1w==
X-Received: by 2002:aa7:92c6:0:b029:2f1:3fbb:3171 with SMTP id k6-20020aa792c60000b02902f13fbb3171mr1043892pfa.0.1623864869005;
        Wed, 16 Jun 2021 10:34:29 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id m3sm2933901pfh.174.2021.06.16.10.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 10:34:28 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Nadav Amit <namit@vmware.com>, Jiajun Cao <caojiajun@vmware.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
Subject: [PATCH v4 4/7] iommu: Factor iommu_iotlb_gather_is_disjoint() out
Date:   Wed, 16 Jun 2021 03:04:57 -0700
Message-Id: <20210616100500.174507-5-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616100500.174507-1-namit@vmware.com>
References: <20210616100500.174507-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Refactor iommu_iotlb_gather_add_page() and factor out the logic that
detects whether IOTLB gather range and a new range are disjoint. To be
used by the next patch that implements different gathering logic for
AMD.

Note that updating gather->pgsize unconditionally does not affect
correctness as the function had (and has) an invariant, in which
gather->pgsize always represents the flushing granularity of its range.
Arguably, “size" should never be zero, but lets assume for the matter of
discussion that it might.

If "size" equals to "gather->pgsize", then the assignment in question
has no impact.

Otherwise, if "size" is non-zero, then iommu_iotlb_sync() would
initialize the size and range (see iommu_iotlb_gather_init()), and the
invariant is kept.

Otherwise, "size" is zero, and "gather" already holds a range, so
gather->pgsize is non-zero and (gather->pgsize && gather->pgsize !=
size) is true. Therefore, again, iommu_iotlb_sync() would be called and
initialize the size.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 include/linux/iommu.h | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e554871db46f..979a5ceeea55 100644
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
+ * Helper for IOMMU drivers to check whether a new range and the gathered range
+ * are disjoint. For many IOMMUs, flushing the IOMMU in this case is better
+ * than merging the two, which might lead to unnecessary invalidations.
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
 
-- 
2.25.1


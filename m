Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158163D3E18
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 19:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhGWQVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 12:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbhGWQVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 12:21:31 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B8AC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 10:02:04 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso9822408pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 10:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BWFBKBoQSQylTkHjpb3SiDuKKZ/wgdaS3agUZ4UYN3M=;
        b=K735bBzttTFRvVBbD71RwbA5lvWBdsSYXqH3+GAld03dGl7BsTzF1EHQGduM2yjNKG
         9MwSA7EXUTeak48klV0Bum0TFR4omD9TiZJEd8rF1Dkl4mIi0zjXt5YxgHihNZlAVKrD
         +sVavs3d+pvzDhSdcEFdsmExTDetgVrXSJHvR1KJLtoakOx5pbUoobNbDhrnxtZz8wOF
         r/xEiT6a2yn0zfcrklbiMU2DUXMFaoAc/fty82DaApULtwoZvQfygUtmgJxWhJtyjBOa
         h3C8Gx0OOcciSpjtk64aq++Isk6yRgExMMJn+4B31oUJQWR+R1iX+h3dbTgEA7RyQr+h
         VdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BWFBKBoQSQylTkHjpb3SiDuKKZ/wgdaS3agUZ4UYN3M=;
        b=ZGueXsfitLGW/nXOAzFxmG1/HfxQSw02RbSTZWURjslX+tIM17fUS/GIFMftCv/uqQ
         dOGaqxGMEjINi4EkGSc3GUKJKeXgH2faVTYg4frMpVi7kvEpsbuzH2xwkTqpLwd3jSuT
         4+ZYLPFDJ8s/11/M8Nh8i6FdDo4aDcz5Y3ujHtBm2IjIfTA/ltRNXwpkWOTEOmN192FY
         gXMWR/kJ712SYYallTR6efZyXGsHsrsKMWd5pzUUr+eteC/OzfuvYkdkeFSnd2Pj2k47
         y0KzXbBmwGVrAlxIAaEnGtOYKtGUc08TOVWU0VJig7m/NLylsLcj827E6oowKmnZ3cbd
         coUg==
X-Gm-Message-State: AOAM530MW2pwdWlguf6hnS+4iNuRql0xHQY8ELobKab+lk7ZAdEACua8
        1FZhBGp0k+H4QXVtYC2VLBw=
X-Google-Smtp-Source: ABdhPJyFYe7wB6XmVZKOiIJqtB5OibW35hOyo0W1fRRSsMwInjmBp8JR7cfPt0QeyErHlmlimA9TLA==
X-Received: by 2002:a17:903:2309:b029:12a:965b:333 with SMTP id d9-20020a1709032309b029012a965b0333mr4665525plh.31.1627059724164;
        Fri, 23 Jul 2021 10:02:04 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d15sm33479004pfl.82.2021.07.23.10.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 10:02:03 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     John Garry <john.garry@huawei.com>, Nadav Amit <namit@vmware.com>,
        Jiajun Cao <caojiajun@vmware.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v6 4/7] iommu: Factor iommu_iotlb_gather_is_disjoint() out
Date:   Fri, 23 Jul 2021 02:32:06 -0700
Message-Id: <20210723093209.714328-5-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210723093209.714328-1-namit@vmware.com>
References: <20210723093209.714328-1-namit@vmware.com>
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
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
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


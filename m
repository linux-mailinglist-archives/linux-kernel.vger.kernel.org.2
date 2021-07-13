Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737833C75B8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 19:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbhGMR1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 13:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbhGMR1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 13:27:44 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69506C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 10:24:54 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id k20so15240165pgg.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 10:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hs2JqvHLc2VhwLkCLKEeX1pzwKqE7ns6gX3Zd+1Br1s=;
        b=QAav+USR8km1W3fwSHLhKJS1on6grs3Opl96GLHDUXTzUdbAL5VYIkzoLyBrlANCbK
         h7tBqzU14vWuEXJHP7LavFv46VEE9aRy2w311L4AqiEr4ztmPKwZzTPgC/vKTwAZRGKF
         8xn5xqsdT8QRQbhwm/rAziNhlFvLZDompwboVOpGY7UaqSk5HfvGfnzzUNm8ol5Ikg4q
         In8yeOl0RGiTRrCnAM2/36GUzvCB4jpNSWwyywTmTZW1ZGpe0wUeaU6RjGWp9iTt5O4q
         XgskL3sxT23Ri8ryCneep2SfQAeYns4MP9AgQ1b7Lc++vG7g422y5i/EtHDzO3ZqDDhW
         gTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hs2JqvHLc2VhwLkCLKEeX1pzwKqE7ns6gX3Zd+1Br1s=;
        b=IbGD7pVXwmguGlX1GmOrimWxCWJ/8PtkWRJsgIwji6iGuHrnKFnNe6ZmkwwScr7wSt
         tT4UMDLJ8voPvBuxvZQCa3CTqutOi/myE0dRkIF+7P6zMcKya4TS8Z6NtghahEuaZ/zz
         9x8vuZh4+RPNE7VynAUGORI+CLI9ML5sXNm9rGuUOzGlBIan4UfRNp7CkS3W9PbYw8aP
         +A4MJpKubfUEkMbFiiN1kRRF4+bDf/wi3ZZmkV2xujWwQM8OmXFEu5e4l+kf+ELKudXP
         WvgD7d8im4JO+RZqkdL08V8dhjcN/admA2DyLFpkGnX/6qfH4kdqoOEJiXkjBW30hqJY
         j+Vg==
X-Gm-Message-State: AOAM5301tDneOEW83NjjOmGkiuvnKor/DXzInV+ZGM0/AbeLfFU0qXSh
        uOMzgOzr2yK6HjzlPW5uLSo=
X-Google-Smtp-Source: ABdhPJylQ8Ys/YO1uvPeeqE89vjPI5d2swuMnSg4o+kFUEMpky9zhlRmquI4dqRTAZYSjKKKJtMoUg==
X-Received: by 2002:a62:3045:0:b029:32b:880f:c03a with SMTP id w66-20020a6230450000b029032b880fc03amr5756377pfw.22.1626197093839;
        Tue, 13 Jul 2021 10:24:53 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id lt14sm18239032pjb.47.2021.07.13.10.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 10:24:53 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     John Garry <john.garry@huawei.com>, Nadav Amit <namit@vmware.com>,
        Jiajun Cao <caojiajun@vmware.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
Subject: [PATCH v5 4/7] iommu: Factor iommu_iotlb_gather_is_disjoint() out
Date:   Tue, 13 Jul 2021 02:41:48 -0700
Message-Id: <20210713094151.652597-5-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713094151.652597-1-namit@vmware.com>
References: <20210713094151.652597-1-namit@vmware.com>
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


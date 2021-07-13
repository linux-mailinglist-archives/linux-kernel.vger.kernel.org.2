Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3CA3C75B9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 19:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbhGMR1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 13:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbhGMR1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 13:27:46 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02A3C0613EF
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 10:24:56 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id h4so22207831pgp.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 10:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FJB56kWozbK1kjgY7PiMohuexaSvPtWxY4TTt6bF5Gg=;
        b=bluFC6GPCsU23gn4OEAWPyo+wxKcGS8PIAGe++5V9agxNB588VRJhXFXX1ctJnvg2l
         tIa8U1HO8zPpVNzbDdKilua2eu4UyQYRH6oN9kVm8VDi9SQqI7m7daU7EDTCJ3eY2UJ9
         2xmf0UbKXdRYO/wsKjxLpl5E5QQSZrM2J1+Ln7LbomE1MS7HYak0+2vxb0p2SsxzNWiL
         /ALxRd0xr3G1cSVBnFdr47QgCYVUmtpvCkw26Wtbn5IVrgcAa2Pe+91CMNCpihx/YFn0
         drtgX3TKS/61NOtkFgq6KMCXgUZisWD45vMlXif3r8GABIv2uq+EYo2+IEnOhjobtsYK
         5aRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FJB56kWozbK1kjgY7PiMohuexaSvPtWxY4TTt6bF5Gg=;
        b=W+bznUnEyNB9cLLL8zYop+RUby1as8uMxbPA+MleSkN/B+RHc3t1I6fF0RMik6uGSf
         G1mTaGLPx5KL+0vceVTyjB8lZYha7dELumcVKs3q5yFZxks09x1iZBwZe55N7BX885ry
         pLRKVAyTFveOz+I5qrdWpumDY9nrl50CvDkmOb6CMHSMnNQh9Mt9pU8tLs4mvX4+V2rW
         dPKVT4jK7pquzCeWz6l8yo+RgvG6wEw5U7HwZrOcaMRtg9l1cY9wcHoDmK2zMDbZzUhK
         R0dlr1Lml+PeZAIQf2GjCu+buBvQ9meEqXk2efUevOMLCAxBcCx4pQ2zN9Ht47ZBkmXR
         TQjQ==
X-Gm-Message-State: AOAM532anoYn4GGYVx72z1SQzwb8TgE7pQMicpiwCcAcgpE2RJs1lcQ1
        e41Rkjm4IGM5GZikD0qwqDA=
X-Google-Smtp-Source: ABdhPJzdlxgjhuXpOJ9TOTIn+TMrQ+vi8rAZXSewI9CchFgtPsQ29/q6/Sjs/tBWcHQWcnaAUEDrtA==
X-Received: by 2002:a65:6243:: with SMTP id q3mr5244655pgv.297.1626197095145;
        Tue, 13 Jul 2021 10:24:55 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id lt14sm18239032pjb.47.2021.07.13.10.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 10:24:54 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     John Garry <john.garry@huawei.com>, Nadav Amit <namit@vmware.com>,
        Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v5 5/7] iommu/amd: Tailored gather logic for AMD
Date:   Tue, 13 Jul 2021 02:41:49 -0700
Message-Id: <20210713094151.652597-6-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713094151.652597-1-namit@vmware.com>
References: <20210713094151.652597-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

AMD's IOMMU can flush efficiently (i.e., in a single flush) any range.
This is in contrast, for instnace, to Intel IOMMUs that have a limit on
the number of pages that can be flushed in a single flush.  In addition,
AMD's IOMMU do not care about the page-size, so changes of the page size
do not need to trigger a TLB flush.

So in most cases, a TLB flush due to disjoint range is not needed for
AMD. Yet, vIOMMUs require the hypervisor to synchronize the virtualized
IOMMU's PTEs with the physical ones. This process induce overheads, so
it is better not to cause unnecessary flushes, i.e., flushes of PTEs
that were not modified.

Implement and use amd_iommu_iotlb_gather_add_page() and use it instead
of the generic iommu_iotlb_gather_add_page(). Ignore disjoint regions
unless "non-present cache" feature is reported by the IOMMU
capabilities, as this is an indication we are running on a physical
IOMMU. A similar indication is used by VT-d (see "caching mode"). The
new logic retains the same flushing behavior that we had before the
introduction of page-selective IOTLB flushes for AMD.

On virtualized environments, check if the newly flushed region and the
gathered one are disjoint and flush if it is.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/iommu/amd/iommu.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index bfae3928b98f..cc55c4c6a355 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2048,6 +2048,27 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 	return ret;
 }
 
+static void amd_iommu_iotlb_gather_add_page(struct iommu_domain *domain,
+					    struct iommu_iotlb_gather *gather,
+					    unsigned long iova, size_t size)
+{
+	/*
+	 * AMD's IOMMU can flush as many pages as necessary in a single flush.
+	 * Unless we run in a virtual machine, which can be inferred according
+	 * to whether "non-present cache" is on, it is probably best to prefer
+	 * (potentially) too extensive TLB flushing (i.e., more misses) over
+	 * mutliple TLB flushes (i.e., more flushes). For virtual machines the
+	 * hypervisor needs to synchronize the host IOMMU PTEs with those of
+	 * the guest, and the trade-off is different: unnecessary TLB flushes
+	 * should be avoided.
+	 */
+	if (amd_iommu_np_cache && gather->end != 0 &&
+	    iommu_iotlb_gather_is_disjoint(gather, iova, size))
+		iommu_iotlb_sync(domain, gather);
+
+	iommu_iotlb_gather_add_range(gather, iova, size);
+}
+
 static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 			      size_t page_size,
 			      struct iommu_iotlb_gather *gather)
@@ -2062,7 +2083,7 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 
 	r = (ops->unmap) ? ops->unmap(ops, iova, page_size, gather) : 0;
 
-	iommu_iotlb_gather_add_page(dom, gather, iova, page_size);
+	amd_iommu_iotlb_gather_add_page(dom, gather, iova, page_size);
 
 	return r;
 }
-- 
2.25.1


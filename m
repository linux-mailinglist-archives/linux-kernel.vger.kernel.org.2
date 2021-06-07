Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F1539EBBB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 03:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhFHB50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 21:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbhFHB5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 21:57:21 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3BBC061795
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 18:55:28 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so13091226pjs.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 18:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uFTvQbgSS4vjW1gLIskRix1ckdU0+Wo0UqmTHN+t/Oo=;
        b=UslctD1uuZDXjRPn9kbMb1uXQWhxu5trekbHnKso09R6mgvBjFzNAQlyo8I+ahVEfZ
         0k4ZmCs3dKcKylKpbrltAlEUyjK7ei2HysqIxxpI/2EzsREF5wFfopu6ffsQgDTawv2n
         ry14xl2EScYHVs3l4Zve44TG1BgRIICqZxSU6Zos2CIINb7g0slOALyxb85gFMzZgOyg
         3Ro0mIqnPVTtTkBMGeRoAQ4cA+suYIZNYZMuci6a9ZfJ7FFAEY5d3iDH94pxccw6Z5Ko
         Y9vxmWnXMuLc6dHNtANbfJ3nYrGr6TV1O5YCy1+6xPL3WlvMU9PmpTneY/eQoKgZcSHQ
         FsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uFTvQbgSS4vjW1gLIskRix1ckdU0+Wo0UqmTHN+t/Oo=;
        b=kCxE7r5YZY6U+ZzyELRlxTAiLFMOYlsloIJ+BSZjGGgKHRLOXwfJOqH7JC8gZ1g6Kt
         e8D3iFkpr8YFMtSjqFConLOdhwSQTycL5byZAgJw1by9vqmIprKo9w/37MAOD0/9RCxI
         pHV/qvYU+7/HFtNHC2WmklV9x0XVU7KN1wmVabjOYtekT68KktAAJZ2fotHxews08y1V
         ajqm/p1/sw5ysaWuWIonUjl2pmmnFgeN5vpjktpS2QDSxMXJhuDrQHDRBinjuJvdvgnM
         Gc/jKO+CDqlCSjZtmvR7MGMraNsCIRMtWRvu6B6alqmlZHWq+EIamxAy761m6Lo+kZmL
         hT8A==
X-Gm-Message-State: AOAM532HsJye1e6p8POhlxxN2FhOwEd+7eLbufSDwLeOaS5Pswsvp6Xe
        abt2f1BK9Ny6pyQbP8tuIoU=
X-Google-Smtp-Source: ABdhPJzBYc5vEysdDZtlWaGoWcLV2RlUWUcJiiQJes3awhZZc2nidmFv9Uafm9CZ9JHLE/ThkgNIDQ==
X-Received: by 2002:a17:902:8341:b029:fa:2aef:7e3c with SMTP id z1-20020a1709028341b02900fa2aef7e3cmr20953159pln.9.1623117327417;
        Mon, 07 Jun 2021 18:55:27 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id s24sm9284767pfh.104.2021.06.07.18.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 18:55:27 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Nadav Amit <namit@vmware.com>, Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] iommu/amd: Tailored gather logic for AMD
Date:   Mon,  7 Jun 2021 11:25:40 -0700
Message-Id: <20210607182541.119756-6-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607182541.119756-1-namit@vmware.com>
References: <20210607182541.119756-1-namit@vmware.com>
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

So in most cases, a TLB flush due to disjoint range or page-size changes
are not needed for AMD. Yet, vIOMMUs require the hypervisor to
synchronize the virtualized IOMMU's PTEs with the physical ones. This
process induce overheads, so it is better not to cause unnecessary
flushes, i.e., flushes of PTEs that were not modified.

Implement and use amd_iommu_iotlb_gather_add_page() and use it instead
of the generic iommu_iotlb_gather_add_page(). Ignore page-size changes
and disjoint regions unless "non-present cache" feature is reported by
the IOMMU capabilities, as this is an indication we are running on a
physical IOMMU. A similar indication is used by VT-d (see "caching
mode"). The new logic retains the same flushing behavior that we had
before the introduction of page-selective IOTLB flushes for AMD.

On virtualized environments, check if the newly flushed region and the
gathered one are disjoint and flush if it is. Also check whether the new
region would cause IOTLB invalidation of large region that would include
unmodified PTE. The latter check is done according to the "order" of the
IOTLB flush.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/iommu/amd/iommu.c | 44 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 3e40f6610b6a..128f2e889ced 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2053,6 +2053,48 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
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
+	if (amd_iommu_np_cache && gather->end != 0) {
+		unsigned long start = iova, end = start + size - 1;
+
+		if (iommu_iotlb_gather_is_disjoint(gather, iova, size)) {
+			/*
+			 * If the new page is disjoint from the current range,
+			 * flush.
+			 */
+			iommu_iotlb_sync(domain, gather);
+		} else {
+			/*
+			 * If the order of TLB flushes increases by more than
+			 * 1, it means that we would have to flush PTEs that
+			 * were not modified. In this case, flush.
+			 */
+			unsigned long new_start = min(gather->start, start);
+			unsigned long new_end = min(gather->end, end);
+			int msb_diff = fls64(gather->end ^ gather->start);
+			int new_msb_diff = fls64(new_end ^ new_start);
+
+			if (new_msb_diff > msb_diff + 1)
+				iommu_iotlb_sync(domain, gather);
+		}
+	}
+
+	iommu_iotlb_gather_add_range(gather, iova, size);
+}
+
 static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 			      size_t page_size,
 			      struct iommu_iotlb_gather *gather)
@@ -2067,7 +2109,7 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 
 	r = (ops->unmap) ? ops->unmap(ops, iova, page_size, gather) : 0;
 
-	iommu_iotlb_gather_add_page(dom, gather, iova, page_size);
+	amd_iommu_iotlb_gather_add_page(dom, gather, iova, page_size);
 
 	return r;
 }
-- 
2.25.1


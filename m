Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2CB73AA27D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 19:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhFPRgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 13:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhFPRgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 13:36:40 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CB3C061767
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 10:34:31 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id k6so2742241pfk.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 10:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kXz09feWPyifbFoBfjgnokAvwGkjdufnieFRhQ4k4Lw=;
        b=sn+QHskEW4APRjJ/4YJ6VC71n3rWCfqKk0RxSN1LP0jolG2LkFkPUuDif/RzFpsS5F
         3pGFbfm4iNWuHxUNL8c3t4PW5r7PGnGz1vYQApJZYY3FNTjwECI8CRkREHDRGlPuh+JH
         59szRa/GdoKPoWnuNbrUNwVL9BzC0nXbLRQlvS1be1ckLsXLuqLLY5vlsA2izpl4GmHt
         TZGIsfNMZA/S3OdKUy3tEiVj1dfNydBJlMKn9UX+dARMhgez4c9RSeNdT3QKOapotae1
         hMGloj1vev9h70+CYkusbHfBJ+hyXA8KMntIDAXmcm7YmaZO0lPXwgsD27G2d+byqIle
         ASoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kXz09feWPyifbFoBfjgnokAvwGkjdufnieFRhQ4k4Lw=;
        b=jbh1PwUwzjFDwL9Kf3k57XPlfizaKn0INx0s7qNlHTFayI7og3J2A5c+wB0FBl6GR9
         ilVr6HFEQ7My2dkEObnyOQu4TUeLuQIP37kF3IBPsM47QyFcg6wEjF/Vfz84lLeowV4s
         xN37XLUV8xLSZmg8EV2D9xWj80KFIaWakVZoQn11AE51FDZvT9Ewlyl6OT/SOMxlWp09
         9UwhCBEyx8+Lp077jLsi9bB4Otp8vy34kZvCrHwFbxPRIt61H098OuUHFJWTRoznNATY
         jUrK60ARBd1WCrt8vCFasNqZ6ZTzQu13aoaCCi8EAa0SXJHZCGYHIBs875Ag94Qedzxi
         WGNQ==
X-Gm-Message-State: AOAM5310J5kOIc8UDRvmSim1Hc/DG88mT+hGfB0P5Gfzy1Ho4exM8Xn5
        PTeAXwqYss2mBGvEa/Z2vRFzfTguf1G82w==
X-Google-Smtp-Source: ABdhPJyXUc6GXMXaKYm8BTeRe+ZiQUequ43eZFEax2cadQZha4bUdFPsd2WlcP/kuUxqulwbwIWiNA==
X-Received: by 2002:a62:7711:0:b029:2f3:5a03:5a31 with SMTP id s17-20020a6277110000b02902f35a035a31mr882731pfc.81.1623864870282;
        Wed, 16 Jun 2021 10:34:30 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id m3sm2933901pfh.174.2021.06.16.10.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 10:34:29 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Nadav Amit <namit@vmware.com>, Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v4 5/7] iommu/amd: Tailored gather logic for AMD
Date:   Wed, 16 Jun 2021 03:04:58 -0700
Message-Id: <20210616100500.174507-6-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616100500.174507-1-namit@vmware.com>
References: <20210616100500.174507-1-namit@vmware.com>
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
index 3e40f6610b6a..63048aabaf5d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2053,6 +2053,27 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
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
@@ -2067,7 +2088,7 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 
 	r = (ops->unmap) ? ops->unmap(ops, iova, page_size, gather) : 0;
 
-	iommu_iotlb_gather_add_page(dom, gather, iova, page_size);
+	amd_iommu_iotlb_gather_add_page(dom, gather, iova, page_size);
 
 	return r;
 }
-- 
2.25.1


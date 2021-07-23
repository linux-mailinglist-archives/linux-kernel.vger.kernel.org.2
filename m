Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BE03D3E19
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 19:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhGWQVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 12:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbhGWQVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 12:21:34 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8CCC0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 10:02:06 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso9822549pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 10:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QRkB641yJcCb/0Kn6mAvfKfDyauYX+C6J+z3H+KwMfg=;
        b=jQfz++avmVQMEReAxFj3brhki689C89BCVDNGxMOcCfznbObjTlWUnEexzSFGaHFyh
         tSEryqbZeEQmfN+9XcezrcUZSrNWx4bnU9RhOJKliVYxaDRT4ZHFPpArW1i1/UKckYta
         cWUwulh34peaEvf+C+IbaBJaUbsLOhjJX18Oi3jBHhmbc4T5R00uvcRI+9XdGIC1hLiW
         itX7CKyNUOABg9EUpIlvBfnTcI8e8IFBEEyhUDLY3gXLhuRIylNcJhlvSi10xGWIGuX3
         TRgkqXU7NCw7+/z1Toh6n8YCbyKwq8GgJoyoKkO1otOwY134NrVlUMQpanMjDUcqfyce
         791g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QRkB641yJcCb/0Kn6mAvfKfDyauYX+C6J+z3H+KwMfg=;
        b=TUTFKmLZJxgua0gCARZ6JkBz/Alxdh0u7oNvSbCOEYq/kNAkAqoEmIyIYasstKXCon
         VjBX342jxMaPAdKs5O603tNuba5XsEdvHvobzF4MgYxujCVbF2Dlq0akoYDNsgwocc0D
         WrJI8n1l3LXlxtz4ztRft4JvEGdv+PoEtZXeCFW8FZHmPSnHwciI+F/9A7cIOjMm9PYE
         ZLHGP8qufEHVw7eBrIXPkiki8RwEat/WQPCqDDROeEhhRMupR9Sxz7UoBzX2iHAlRUnK
         J9EGYHI1icedjHYP+d9mgzCmxkqEsIj4cVxOBaR6CuL2uq19PcuyEdGSB7tpwZq9cjwZ
         LwOA==
X-Gm-Message-State: AOAM530iY0JhGrp4q2S8YFe/oGPMPu3fwSSfNgEsYbTSJHM+t3dFxwKn
        p63Q9i7BHRrO9BldkZ8JMjI=
X-Google-Smtp-Source: ABdhPJypGkANe53XromAl/C7tLdnNuJ8pJVuEb9XxPGL3iRHTCLSy65H6OkjAs5kuYYOP2b0jqsm9Q==
X-Received: by 2002:a65:6088:: with SMTP id t8mr5636818pgu.371.1627059725733;
        Fri, 23 Jul 2021 10:02:05 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d15sm33479004pfl.82.2021.07.23.10.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 10:02:05 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Joerg Roedel <joro@8bytes.org>
Cc:     John Garry <john.garry@huawei.com>, Nadav Amit <namit@vmware.com>,
        Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v6 5/7] iommu/amd: Tailored gather logic for AMD
Date:   Fri, 23 Jul 2021 02:32:07 -0700
Message-Id: <20210723093209.714328-6-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210723093209.714328-1-namit@vmware.com>
References: <20210723093209.714328-1-namit@vmware.com>
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
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 drivers/iommu/amd/iommu.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index bfae3928b98f..f5d5f2124391 100644
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
+	if (amd_iommu_np_cache &&
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CAB416FF1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 12:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245564AbhIXKIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 06:08:41 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3869 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245423AbhIXKIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 06:08:39 -0400
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HG71K6Wsbz67Zhc;
        Fri, 24 Sep 2021 18:04:37 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 24 Sep 2021 12:07:05 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 24 Sep 2021 11:07:01 +0100
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <mst@redhat.com>,
        <jasowang@redhat.com>, <robin.murphy@arm.com>
CC:     <xieyongji@bytedance.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>,
        <virtualization@lists.linux-foundation.org>, <linuxarm@huawei.com>,
        <thunder.leizhen@huawei.com>, <baolu.lu@linux.intel.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 1/5] iova: Move fast alloc size roundup into alloc_iova_fast()
Date:   Fri, 24 Sep 2021 18:01:53 +0800
Message-ID: <1632477717-5254-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
References: <1632477717-5254-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It really is a property of the IOVA rcache code that we need to alloc a
power-of-2 size, so relocate the functionality to resize into
alloc_iova_fast(), rather than the callsites.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/dma-iommu.c            | 8 --------
 drivers/iommu/iova.c                 | 9 +++++++++
 drivers/vdpa/vdpa_user/iova_domain.c | 8 --------
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 896bea04c347..a99b3445fef8 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -444,14 +444,6 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 
 	shift = iova_shift(iovad);
 	iova_len = size >> shift;
-	/*
-	 * Freeing non-power-of-two-sized allocations back into the IOVA caches
-	 * will come back to bite us badly, so we have to waste a bit of space
-	 * rounding up anything cacheable to make sure that can't happen. The
-	 * order of the unadjusted size will still match upon freeing.
-	 */
-	if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
-		iova_len = roundup_pow_of_two(iova_len);
 
 	dma_limit = min_not_zero(dma_limit, dev->bus_dma_limit);
 
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 9e8bc802ac05..ff567cbc42f7 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -497,6 +497,15 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
 	unsigned long iova_pfn;
 	struct iova *new_iova;
 
+	/*
+	 * Freeing non-power-of-two-sized allocations back into the IOVA caches
+	 * will come back to bite us badly, so we have to waste a bit of space
+	 * rounding up anything cacheable to make sure that can't happen. The
+	 * order of the unadjusted size will still match upon freeing.
+	 */
+	if (size < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
+		size = roundup_pow_of_two(size);
+
 	iova_pfn = iova_rcache_get(iovad, size, limit_pfn + 1);
 	if (iova_pfn)
 		return iova_pfn;
diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 1daae2608860..2b1143f11d8f 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -292,14 +292,6 @@ vduse_domain_alloc_iova(struct iova_domain *iovad,
 	unsigned long iova_len = iova_align(iovad, size) >> shift;
 	unsigned long iova_pfn;
 
-	/*
-	 * Freeing non-power-of-two-sized allocations back into the IOVA caches
-	 * will come back to bite us badly, so we have to waste a bit of space
-	 * rounding up anything cacheable to make sure that can't happen. The
-	 * order of the unadjusted size will still match upon freeing.
-	 */
-	if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
-		iova_len = roundup_pow_of_two(iova_len);
 	iova_pfn = alloc_iova_fast(iovad, iova_len, limit >> shift, true);
 
 	return iova_pfn << shift;
-- 
2.26.2


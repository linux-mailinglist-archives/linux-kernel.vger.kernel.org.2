Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAFF3CF1EF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 04:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237297AbhGTBcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 21:32:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:12594 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241157AbhGTB17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 21:27:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="190749824"
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="190749824"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 19:08:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="453891960"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga007.jf.intel.com with ESMTP; 19 Jul 2021 19:08:32 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     will@kernel.org, robin.murphy@arm.com,
        Georgi Djakov <quic_c_gdjako@quicinc.com>,
        chenxiang <chenxiang66@hisilicon.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/3] iommu/vt-d: Implement map/unmap_pages() iommu_ops callback
Date:   Tue, 20 Jul 2021 10:06:14 +0800
Message-Id: <20210720020615.4144323-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210720020615.4144323-1-baolu.lu@linux.intel.com>
References: <20210720020615.4144323-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the map_pages() and unmap_pages() callback for the Intel IOMMU
driver to allow calls from iommu core to map and unmap multiple pages of
the same size in one call. With map/unmap_pages() implemented, the prior
map/unmap callbacks are deprecated.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 240af636d51e..6114dac8777d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5063,6 +5063,28 @@ static int intel_iommu_map(struct iommu_domain *domain,
 				hpa >> VTD_PAGE_SHIFT, size, prot);
 }
 
+static int intel_iommu_map_pages(struct iommu_domain *domain,
+				 unsigned long iova, phys_addr_t paddr,
+				 size_t pgsize, size_t pgcount,
+				 int prot, gfp_t gfp, size_t *mapped)
+{
+	unsigned long pgshift = __ffs(pgsize);
+	size_t size = pgcount << pgshift;
+	int ret;
+
+	if (pgsize != SZ_4K && pgsize != SZ_2M && pgsize != SZ_1G)
+		return -EINVAL;
+
+	if (!IS_ALIGNED(iova | paddr, pgsize))
+		return -EINVAL;
+
+	ret = intel_iommu_map(domain, iova, paddr, size, prot, gfp);
+	if (!ret && mapped)
+		*mapped = size;
+
+	return ret;
+}
+
 static size_t intel_iommu_unmap(struct iommu_domain *domain,
 				unsigned long iova, size_t size,
 				struct iommu_iotlb_gather *gather)
@@ -5092,6 +5114,17 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 	return size;
 }
 
+static size_t intel_iommu_unmap_pages(struct iommu_domain *domain,
+				      unsigned long iova,
+				      size_t pgsize, size_t pgcount,
+				      struct iommu_iotlb_gather *gather)
+{
+	unsigned long pgshift = __ffs(pgsize);
+	size_t size = pgcount << pgshift;
+
+	return intel_iommu_unmap(domain, iova, size, gather);
+}
+
 static void intel_iommu_tlb_sync(struct iommu_domain *domain,
 				 struct iommu_iotlb_gather *gather)
 {
@@ -5589,9 +5622,9 @@ const struct iommu_ops intel_iommu_ops = {
 	.aux_attach_dev		= intel_iommu_aux_attach_device,
 	.aux_detach_dev		= intel_iommu_aux_detach_device,
 	.aux_get_pasid		= intel_iommu_aux_get_pasid,
-	.map			= intel_iommu_map,
+	.map_pages		= intel_iommu_map_pages,
+	.unmap_pages		= intel_iommu_unmap_pages,
 	.iotlb_sync_map		= intel_iommu_iotlb_sync_map,
-	.unmap			= intel_iommu_unmap,
 	.flush_iotlb_all        = intel_flush_iotlb_all,
 	.iotlb_sync		= intel_iommu_tlb_sync,
 	.iova_to_phys		= intel_iommu_iova_to_phys,
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660483CF1ED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 04:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbhGTBbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 21:31:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:12591 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240570AbhGTB17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 21:27:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="190749822"
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="190749822"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 19:08:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="453891950"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga007.jf.intel.com with ESMTP; 19 Jul 2021 19:08:29 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     will@kernel.org, robin.murphy@arm.com,
        Georgi Djakov <quic_c_gdjako@quicinc.com>,
        chenxiang <chenxiang66@hisilicon.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/3] iommu/vt-d: Report real pgsize bitmap to iommu core
Date:   Tue, 20 Jul 2021 10:06:13 +0800
Message-Id: <20210720020615.4144323-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210720020615.4144323-1-baolu.lu@linux.intel.com>
References: <20210720020615.4144323-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pgsize bitmap is used to advertise the page sizes our hardware supports
to the IOMMU core, which will then use this information to split physically
contiguous memory regions it is mapping into page sizes that we support.

Traditionally the IOMMU core just handed us the mappings directly, after
making sure the size is an order of a 4KiB page and that the mapping has
natural alignment. To retain this behavior, we currently advertise that we
support all page sizes that are an order of 4KiB.

We are about to utilize the new IOMMU map/unmap_pages APIs. We could change
this to advertise the real page sizes we support.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 38 ++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 741d25ded717..240af636d51e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -85,24 +85,6 @@
 #define LEVEL_STRIDE		(9)
 #define LEVEL_MASK		(((u64)1 << LEVEL_STRIDE) - 1)
 
-/*
- * This bitmap is used to advertise the page sizes our hardware support
- * to the IOMMU core, which will then use this information to split
- * physically contiguous memory regions it is mapping into page sizes
- * that we support.
- *
- * Traditionally the IOMMU core just handed us the mappings directly,
- * after making sure the size is an order of a 4KiB page and that the
- * mapping has natural alignment.
- *
- * To retain this behavior, we currently advertise that we support
- * all page sizes that are an order of 4KiB.
- *
- * If at some point we'd like to utilize the IOMMU core's new behavior,
- * we could change this to advertise the real page sizes we support.
- */
-#define INTEL_IOMMU_PGSIZES	(~0xFFFUL)
-
 static inline int agaw_to_level(int agaw)
 {
 	return agaw + 2;
@@ -736,6 +718,23 @@ static int domain_update_device_node(struct dmar_domain *domain)
 
 static void domain_update_iotlb(struct dmar_domain *domain);
 
+/* Return the super pagesize bitmap if supported. */
+static unsigned long domain_super_pgsize_bitmap(struct dmar_domain *domain)
+{
+	unsigned long bitmap = 0;
+
+	/*
+	 * 1-level super page supports page size of 2MiB, 2-level super page
+	 * supports page size of both 2MiB and 1GiB.
+	 */
+	if (domain->iommu_superpage == 1)
+		bitmap |= SZ_2M;
+	else if (domain->iommu_superpage == 2)
+		bitmap |= SZ_2M | SZ_1G;
+
+	return bitmap;
+}
+
 /* Some capabilities may be different across iommus */
 static void domain_update_iommu_cap(struct dmar_domain *domain)
 {
@@ -762,6 +761,7 @@ static void domain_update_iommu_cap(struct dmar_domain *domain)
 	else
 		domain->domain.geometry.aperture_end = __DOMAIN_MAX_ADDR(domain->gaw);
 
+	domain->domain.pgsize_bitmap |= domain_super_pgsize_bitmap(domain);
 	domain_update_iotlb(domain);
 }
 
@@ -5607,7 +5607,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.dev_disable_feat	= intel_iommu_dev_disable_feat,
 	.is_attach_deferred	= intel_iommu_is_attach_deferred,
 	.def_domain_type	= device_def_domain_type,
-	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
+	.pgsize_bitmap		= SZ_4K,
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	.cache_invalidate	= intel_iommu_sva_invalidate,
 	.sva_bind_gpasid	= intel_svm_bind_gpasid,
-- 
2.25.1


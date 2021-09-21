Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFCC414122
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 07:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhIVFOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 01:14:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:29325 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231901AbhIVFOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 01:14:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="203012039"
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; 
   d="scan'208";a="203012039"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 22:13:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; 
   d="scan'208";a="550107670"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Sep 2021 22:13:11 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Christoph Hellwig" <hch@infradead.org>
Cc:     "Lu Baolu" <baolu.lu@linux.intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>, mike.campin@intel.com,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Subject: [RFC 1/7] ioasid: reserve special PASID for in-kernel DMA
Date:   Tue, 21 Sep 2021 13:29:35 -0700
Message-Id: <1632256181-36071-2-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOASIDs associated with user processes are subject to resource
restrictions. However, in-kernel usages can target only one global
kernel virtual address mapping. Reserve a special IOASID for the devices
that perform DMA requests with PASID. This global PASID is excluded from
the IOASID allocator.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 2 +-
 drivers/iommu/ioasid.c                          | 2 ++
 drivers/iommu/iommu-sva-lib.c                   | 1 +
 include/linux/ioasid.h                          | 4 ++++
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index bb251cab61f3..c5fb89bd6229 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -329,7 +329,7 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 		return ERR_PTR(-ENOMEM);
 
 	/* Allocate a PASID for this mm if necessary */
-	ret = iommu_sva_alloc_pasid(mm, 1, (1U << master->ssid_bits) - 1);
+	ret = iommu_sva_alloc_pasid(mm, IOASID_ALLOC_START, (1U << master->ssid_bits) - 1);
 	if (ret)
 		goto err_free_bond;
 
diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 50ee27bbd04e..89c6132bf1ec 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -317,6 +317,8 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 	data->private = private;
 	refcount_set(&data->refs, 1);
 
+	if (min < IOASID_ALLOC_BASE)
+		min = IOASID_ALLOC_BASE;
 	/*
 	 * Custom allocator needs allocator data to perform platform specific
 	 * operations.
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index bd41405d34e9..4f56843517e5 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva-lib.c
@@ -28,6 +28,7 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 	int ret = 0;
 	ioasid_t pasid;
 
+	/* TODO: no need to check!! reserved range is checked in ioasid_alloc() */
 	if (min == INVALID_IOASID || max == INVALID_IOASID ||
 	    min == 0 || max < min)
 		return -EINVAL;
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index e9dacd4b9f6b..4d435cbd48b8 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -6,6 +6,10 @@
 #include <linux/errno.h>
 
 #define INVALID_IOASID ((ioasid_t)-1)
+#define IOASID_DMA_NO_PASID	0 /* For DMA request w/o PASID */
+#define IOASID_DMA_PASID	1 /* For in-kernel DMA w/ PASID */
+#define IOASID_ALLOC_BASE	2 /* Start of the allocation */
+
 typedef unsigned int ioasid_t;
 typedef ioasid_t (*ioasid_alloc_fn_t)(ioasid_t min, ioasid_t max, void *data);
 typedef void (*ioasid_free_fn_t)(ioasid_t ioasid, void *data);
-- 
2.25.1


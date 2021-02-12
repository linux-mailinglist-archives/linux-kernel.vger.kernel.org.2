Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B511F319CF9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 12:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhBLLBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 06:01:46 -0500
Received: from foss.arm.com ([217.140.110.172]:35094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231184AbhBLLAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 06:00:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6664612FC;
        Fri, 12 Feb 2021 02:59:20 -0800 (PST)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1D82A3F719;
        Fri, 12 Feb 2021 02:59:15 -0800 (PST)
From:   Vivek Gautam <vivek.gautam@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org
Cc:     joro@8bytes.org, will.deacon@arm.com, mst@redhat.com,
        robin.murphy@arm.com, jean-philippe@linaro.org,
        eric.auger@redhat.com, alex.williamson@redhat.com,
        kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@intel.com, Lorenzo.Pieralisi@arm.com,
        shameerali.kolothum.thodi@huawei.com
Subject: [PATCH 2/2] iommu: arm-smmu-v3: Report domain nesting info reuqired for stage1
Date:   Fri, 12 Feb 2021 16:28:59 +0530
Message-Id: <20210212105859.8445-3-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210212105859.8445-1-vivek.gautam@arm.com>
References: <20210212105859.8445-1-vivek.gautam@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update nested domain information required for stage1 page table.

Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c11dd3940583..728018921fae 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2555,6 +2555,7 @@ static int arm_smmu_domain_nesting_info(struct arm_smmu_domain *smmu_domain,
 					void *data)
 {
 	struct iommu_nesting_info *info = (struct iommu_nesting_info *)data;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	unsigned int size;
 
 	if (!info || smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
@@ -2571,9 +2572,20 @@ static int arm_smmu_domain_nesting_info(struct arm_smmu_domain *smmu_domain,
 		return 0;
 	}
 
-	/* report an empty iommu_nesting_info for now */
-	memset(info, 0x0, size);
+	/* Update the nesting info as required for stage1 page tables */
+	info->addr_width = smmu->ias;
+	info->format = IOMMU_PASID_FORMAT_ARM_SMMU_V3;
+	info->features = IOMMU_NESTING_FEAT_BIND_PGTBL |
+			 IOMMU_NESTING_FEAT_PAGE_RESP |
+			 IOMMU_NESTING_FEAT_CACHE_INVLD;
+	info->pasid_bits = smmu->ssid_bits;
+	info->vendor.smmuv3.asid_bits = smmu->asid_bits;
+	info->vendor.smmuv3.pgtbl_fmt = ARM_64_LPAE_S1;
+	memset(&info->padding, 0x0, 12);
+	memset(&info->vendor.smmuv3.padding, 0x0, 9);
+
 	info->argsz = size;
+
 	return 0;
 }
 
-- 
2.17.1


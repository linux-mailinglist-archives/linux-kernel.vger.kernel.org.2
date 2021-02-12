Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE55319CF7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 12:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhBLLAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 06:00:20 -0500
Received: from foss.arm.com ([217.140.110.172]:35070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231177AbhBLLAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 06:00:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A134511B3;
        Fri, 12 Feb 2021 02:59:15 -0800 (PST)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 614273F719;
        Fri, 12 Feb 2021 02:59:11 -0800 (PST)
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
Subject: [PATCH 1/2] iommu: Report domain nesting info for arm-smmu-v3
Date:   Fri, 12 Feb 2021 16:28:58 +0530
Message-Id: <20210212105859.8445-2-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210212105859.8445-1-vivek.gautam@arm.com>
References: <20210212105859.8445-1-vivek.gautam@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a vendor specific structure for domain nesting info for
arm smmu-v3, and necessary info fields required to populate
stage1 page tables.

Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
---
 include/uapi/linux/iommu.h | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index 4d3d988fa353..5f059bcf7720 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -323,7 +323,8 @@ struct iommu_gpasid_bind_data {
 #define IOMMU_GPASID_BIND_VERSION_1	1
 	__u32 version;
 #define IOMMU_PASID_FORMAT_INTEL_VTD	1
-#define IOMMU_PASID_FORMAT_LAST		2
+#define IOMMU_PASID_FORMAT_ARM_SMMU_V3	2
+#define IOMMU_PASID_FORMAT_LAST		3
 	__u32 format;
 	__u32 addr_width;
 #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
@@ -409,6 +410,21 @@ struct iommu_nesting_info_vtd {
 	__u64	ecap_reg;
 };
 
+/*
+ * struct iommu_nesting_info_arm_smmuv3 - Arm SMMU-v3 nesting info.
+ */
+struct iommu_nesting_info_arm_smmuv3 {
+	__u32	flags;
+	__u16	asid_bits;
+
+	/* Arm LPAE page table format as per kernel */
+#define ARM_PGTBL_32_LPAE_S1		(0x0)
+#define ARM_PGTBL_64_LPAE_S1		(0x2)
+	__u8	pgtbl_fmt;
+
+	__u8	padding[9];
+};
+
 /*
  * struct iommu_nesting_info - Information for nesting-capable IOMMU.
  *			       userspace should check it before using
@@ -445,11 +461,13 @@ struct iommu_nesting_info_vtd {
  * +---------------+------------------------------------------------------+
  *
  * data struct types defined for @format:
- * +================================+=====================================+
- * | @format                        | data struct                         |
- * +================================+=====================================+
- * | IOMMU_PASID_FORMAT_INTEL_VTD   | struct iommu_nesting_info_vtd       |
- * +--------------------------------+-------------------------------------+
+ * +================================+======================================+
+ * | @format                        | data struct                          |
+ * +================================+======================================+
+ * | IOMMU_PASID_FORMAT_INTEL_VTD   | struct iommu_nesting_info_vtd        |
+ * +---------------+-------------------------------------------------------+
+ * | IOMMU_PASID_FORMAT_ARM_SMMU_V3 | struct iommu_nesting_info_arm_smmuv3 |
+ * +--------------------------------+--------------------------------------+
  *
  */
 struct iommu_nesting_info {
@@ -466,6 +484,7 @@ struct iommu_nesting_info {
 	/* Vendor specific data */
 	union {
 		struct iommu_nesting_info_vtd vtd;
+		struct iommu_nesting_info_arm_smmuv3 smmuv3;
 	} vendor;
 };
 
-- 
2.17.1


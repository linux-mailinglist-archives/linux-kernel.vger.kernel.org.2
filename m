Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4039333845
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbhCJJHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:07:23 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13491 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbhCJJGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:06:53 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DwR3y6rjKzrTKP;
        Wed, 10 Mar 2021 17:05:02 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.184.42) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Wed, 10 Mar 2021 17:06:20 +0800
From:   Keqian Zhu <zhukeqian1@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Yi Sun <yi.y.sun@linux.intel.com>,
        Will Deacon <will@kernel.org>
CC:     Kirti Wankhede <kwankhede@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        <wanghaibin.wang@huawei.com>, <jiangkunkun@huawei.com>,
        <yuzenghui@huawei.com>, <lushenming@huawei.com>
Subject: [PATCH v2 03/11] iommu/arm-smmu-v3: Add feature detection for BBML
Date:   Wed, 10 Mar 2021 17:06:06 +0800
Message-ID: <20210310090614.26668-4-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210310090614.26668-1-zhukeqian1@huawei.com>
References: <20210310090614.26668-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jiangkunkun <jiangkunkun@huawei.com>

When altering a translation table descriptor of some specific reasons,
we require break-before-make procedure. But it might cause problems when
the TTD is alive. The I/O streams might not tolerate translation faults.

If the SMMU supports BBM level 1 or BBM level 2, we can change the block
size without using break-before-make sequence.

This adds feature detection for BBML, none functional change expected.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---

changelog:

v2:
 - Use two new quirk flags named IO_PGTABLE_QUIRK_ARM_BBML1/2 to transfer
   SMMU BBML feature to io-pgtable. (Robin)
   
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 19 +++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  6 ++++++
 include/linux/io-pgtable.h                  |  8 ++++++++
 3 files changed, 33 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 369c0ea7a104..443ac19c6da9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2030,6 +2030,11 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 	if (smmu->features & ARM_SMMU_FEAT_HD)
 		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_ARM_HD;
 
+	if (smmu->features & ARM_SMMU_FEAT_BBML1)
+		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_ARM_BBML1;
+	else if (smmu->features & ARM_SMMU_FEAT_BBML2)
+		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_ARM_BBML2;
+
 	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
 	if (!pgtbl_ops)
 		return -ENOMEM;
@@ -3373,6 +3378,20 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	/* IDR3 */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR3);
+	switch (FIELD_GET(IDR3_BBML, reg)) {
+	case IDR3_BBML0:
+		break;
+	case IDR3_BBML1:
+		smmu->features |= ARM_SMMU_FEAT_BBML1;
+		break;
+	case IDR3_BBML2:
+		smmu->features |= ARM_SMMU_FEAT_BBML2;
+		break;
+	default:
+		dev_err(smmu->dev, "unknown/unsupported BBM behavior level\n");
+		return -ENXIO;
+	}
+
 	if (FIELD_GET(IDR3_RIL, reg))
 		smmu->features |= ARM_SMMU_FEAT_RANGE_INV;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 26d6b935b383..a74125675544 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -54,6 +54,10 @@
 #define IDR1_SIDSIZE			GENMASK(5, 0)
 
 #define ARM_SMMU_IDR3			0xc
+#define IDR3_BBML			GENMASK(12, 11)
+#define IDR3_BBML0			0
+#define IDR3_BBML1			1
+#define IDR3_BBML2			2
 #define IDR3_RIL			(1 << 10)
 
 #define ARM_SMMU_IDR5			0x14
@@ -615,6 +619,8 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_E2H		(1 << 18)
 #define ARM_SMMU_FEAT_HA		(1 << 19)
 #define ARM_SMMU_FEAT_HD		(1 << 20)
+#define ARM_SMMU_FEAT_BBML1		(1 << 21)
+#define ARM_SMMU_FEAT_BBML2		(1 << 22)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 64cee6831c97..857932357f1d 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -84,6 +84,12 @@ struct io_pgtable_cfg {
 	 *	attributes set in the TCR for a non-coherent page-table walker.
 	 *
 	 * IO_PGTABLE_QUIRK_ARM_HD: Support hardware management of dirty status.
+	 *
+	 * IO_PGTABLE_QUIRK_ARM_BBML1: ARM SMMU supports BBM Level 1 behavior
+	 *	when changing block size.
+	 *
+	 * IO_PGTABLE_QUIRK_ARM_BBML2: ARM SMMU supports BBM Level 2 behavior
+	 * when changing block size.
 	 */
 	#define IO_PGTABLE_QUIRK_ARM_NS		BIT(0)
 	#define IO_PGTABLE_QUIRK_NO_PERMS	BIT(1)
@@ -92,6 +98,8 @@ struct io_pgtable_cfg {
 	#define IO_PGTABLE_QUIRK_ARM_TTBR1	BIT(5)
 	#define IO_PGTABLE_QUIRK_ARM_OUTER_WBWA	BIT(6)
 	#define IO_PGTABLE_QUIRK_ARM_HD		BIT(7)
+	#define IO_PGTABLE_QUIRK_ARM_BBML1	BIT(8)
+	#define IO_PGTABLE_QUIRK_ARM_BBML2	BIT(9)
 	unsigned long			quirks;
 	unsigned long			pgsize_bitmap;
 	unsigned int			ias;
-- 
2.19.1


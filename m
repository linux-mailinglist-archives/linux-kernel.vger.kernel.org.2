Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCE437639A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 12:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbhEGKYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 06:24:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:18350 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbhEGKYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 06:24:18 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fc5zw4crwzCr7C;
        Fri,  7 May 2021 18:20:12 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.224) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Fri, 7 May 2021 18:22:38 +0800
From:   Keqian Zhu <zhukeqian1@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Will Deacon" <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Yi Sun" <yi.y.sun@linux.intel.com>,
        Tian Kevin <kevin.tian@intel.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <wanghaibin.wang@huawei.com>, <jiangkunkun@huawei.com>,
        <yuzenghui@huawei.com>, <lushenming@huawei.com>
Subject: [RFC PATCH v4 09/13] iommu/arm-smmu-v3: Add feature detection for BBML
Date:   Fri, 7 May 2021 18:22:07 +0800
Message-ID: <20210507102211.8836-10-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210507102211.8836-1-zhukeqian1@huawei.com>
References: <20210507102211.8836-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.224]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kunkun Jiang <jiangkunkun@huawei.com>

This detects BBML feature and if SMMU supports it, transfer BBMLx
quirk to io-pgtable.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 19 +++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  6 ++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c42e59655fd0..3a2dc3177180 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2051,6 +2051,11 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
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
@@ -3419,6 +3424,20 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
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
index 3edcd31b046e..e3b6bdd292c9 100644
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
@@ -613,6 +617,8 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_E2H		(1 << 18)
 #define ARM_SMMU_FEAT_HA		(1 << 19)
 #define ARM_SMMU_FEAT_HD		(1 << 20)
+#define ARM_SMMU_FEAT_BBML1		(1 << 21)
+#define ARM_SMMU_FEAT_BBML2		(1 << 22)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
-- 
2.19.1


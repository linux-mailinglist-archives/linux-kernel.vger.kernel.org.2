Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7024B33384A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbhCJJHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:07:30 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13497 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbhCJJGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:06:55 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DwR3z3vPkzrTKS;
        Wed, 10 Mar 2021 17:05:03 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.184.42) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Wed, 10 Mar 2021 17:06:25 +0800
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
Subject: [PATCH v2 08/11] iommu/arm-smmu-v3: Add HWDBM device feature reporting
Date:   Wed, 10 Mar 2021 17:06:11 +0800
Message-ID: <20210310090614.26668-9-zhukeqian1@huawei.com>
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

We have implemented these interfaces required to support iommu
dirty log tracking. The last step is reporting this feature to
upper user, then the user can perform higher policy base on it.

This adds a new dev feature named IOMMU_DEV_FEAT_HWDBM in iommu
layer. For arm smmuv3, it is equal to ARM_SMMU_FEAT_HD and it is
enabled by default if supported. Other types of IOMMU can enable
it by default or when dev_enable_feature() is called.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---

changelog:

v2:
 - As dev_has_feature() has been removed from iommu layer, IOMMU_DEV_FEAT_HWDBM
   is designed to be used through "enable" interface.

---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++++
 include/linux/iommu.h                       | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 696df51a3282..cd1627123e80 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2722,6 +2722,8 @@ static bool arm_smmu_dev_has_feature(struct device *dev,
 	switch (feat) {
 	case IOMMU_DEV_FEAT_SVA:
 		return arm_smmu_master_sva_supported(master);
+	case IOMMU_DEV_FEAT_HWDBM:
+		return !!(master->smmu->features & ARM_SMMU_FEAT_HD);
 	default:
 		return false;
 	}
@@ -2738,6 +2740,8 @@ static bool arm_smmu_dev_feature_enabled(struct device *dev,
 	switch (feat) {
 	case IOMMU_DEV_FEAT_SVA:
 		return arm_smmu_master_sva_enabled(master);
+	case IOMMU_DEV_FEAT_HWDBM:
+		return arm_smmu_dev_has_feature(dev, feat);
 	default:
 		return false;
 	}
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 4f7db5d23b23..88584a2d027c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -160,6 +160,7 @@ struct iommu_resv_region {
 enum iommu_dev_features {
 	IOMMU_DEV_FEAT_AUX,	/* Aux-domain feature */
 	IOMMU_DEV_FEAT_SVA,	/* Shared Virtual Addresses */
+	IOMMU_DEV_FEAT_HWDBM,	/* Hardware Dirty Bit Management */
 };
 
 #define IOMMU_PASID_INVALID	(-1U)
-- 
2.19.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55CA3763A0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 12:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbhEGKZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 06:25:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:18348 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236081AbhEGKYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 06:24:17 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fc5zw3scPzCr6L;
        Fri,  7 May 2021 18:20:12 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.224) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Fri, 7 May 2021 18:22:40 +0800
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
Subject: [RFC PATCH v4 11/13] iommu/arm-smmu-v3: Realize sync_dirty_log iommu ops
Date:   Fri, 7 May 2021 18:22:09 +0800
Message-ID: <20210507102211.8836-12-zhukeqian1@huawei.com>
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

This realizes sync_dirty_log iommu ops based on sync_dirty_log
io-pgtable ops.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 30 +++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6de81d6ab652..3d3c0f8e2446 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2721,6 +2721,35 @@ static int arm_smmu_switch_dirty_log(struct iommu_domain *domain, bool enable,
 	return 0;
 }
 
+static int arm_smmu_sync_dirty_log(struct iommu_domain *domain,
+				   unsigned long iova, size_t size,
+				   unsigned long *bitmap,
+				   unsigned long base_iova,
+				   unsigned long bitmap_pgshift)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_HD))
+		return -ENODEV;
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
+		return -EINVAL;
+
+	if (!ops || !ops->sync_dirty_log) {
+		pr_err("io-pgtable don't realize sync dirty log\n");
+		return -ENODEV;
+	}
+
+	/*
+	 * Flush iotlb to ensure all inflight transactions are completed.
+	 * See doc IHI0070Da 3.13.4 "HTTU behavior summary".
+	 */
+	arm_smmu_flush_iotlb_all(domain);
+	return ops->sync_dirty_log(ops, iova, size, bitmap, base_iova,
+				   bitmap_pgshift);
+}
+
 static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 {
 	return iommu_fwspec_add_ids(dev, args->args, 1);
@@ -2820,6 +2849,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.device_group		= arm_smmu_device_group,
 	.enable_nesting		= arm_smmu_enable_nesting,
 	.switch_dirty_log	= arm_smmu_switch_dirty_log,
+	.sync_dirty_log		= arm_smmu_sync_dirty_log,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= generic_iommu_put_resv_regions,
-- 
2.19.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6A035DA83
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 10:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244750AbhDMI4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 04:56:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16546 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244156AbhDMIzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 04:55:43 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FKK9q0617zPqkh;
        Tue, 13 Apr 2021 16:52:31 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.224) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 13 Apr 2021 16:55:14 +0800
From:   Keqian Zhu <zhukeqian1@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Will Deacon" <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Yi Sun <yi.y.sun@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tian Kevin <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        <wanghaibin.wang@huawei.com>, <jiangkunkun@huawei.com>,
        <yuzenghui@huawei.com>, <lushenming@huawei.com>
Subject: [PATCH v3 09/12] iommu/arm-smmu-v3: Realize switch_dirty_log iommu ops
Date:   Tue, 13 Apr 2021 16:54:54 +0800
Message-ID: <20210413085457.25400-10-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210413085457.25400-1-zhukeqian1@huawei.com>
References: <20210413085457.25400-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.224]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kunkun Jiang <jiangkunkun@huawei.com>

This realizes switch_dirty_log by invoking iommu_split_block() and
iommu_merge_page(). HTTU HD feature is required.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 38 +++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 4d8495d88be2..52c6f3e74d6f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2590,6 +2590,43 @@ static int arm_smmu_merge_page(struct iommu_domain *domain,
 	return 0;
 }
 
+static int arm_smmu_switch_dirty_log(struct iommu_domain *domain, bool enable,
+				     unsigned long iova, size_t size, int prot)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_HD))
+		return -ENODEV;
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
+		return -EINVAL;
+
+	if (enable) {
+		/*
+		 * For SMMU, the hardware dirty management is always enabled if
+		 * hardware supports HTTU HD. The action to start dirty log is
+		 * spliting block mapping.
+		 *
+		 * We don't return error even if the split operation fail, as we
+		 * can still track dirty at block granule, which is still a much
+		 * better choice compared to full dirty policy.
+		 */
+		iommu_split_block(domain, iova, size);
+	} else {
+		/*
+		 * For SMMU, the hardware dirty management is always enabled if
+		 * hardware supports HTTU HD. The action to start dirty log is
+		 * merging page mapping.
+		 *
+		 * We don't return error even if the merge operation fail, as it
+		 * just effects performace of DMA transaction.
+		 */
+		iommu_merge_page(domain, iova, size, prot);
+	}
+
+	return 0;
+}
+
 static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 {
 	return iommu_fwspec_add_ids(dev, args->args, 1);
@@ -2691,6 +2728,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.domain_set_attr	= arm_smmu_domain_set_attr,
 	.split_block		= arm_smmu_split_block,
 	.merge_page		= arm_smmu_merge_page,
+	.switch_dirty_log	= arm_smmu_switch_dirty_log,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= generic_iommu_put_resv_regions,
-- 
2.19.1


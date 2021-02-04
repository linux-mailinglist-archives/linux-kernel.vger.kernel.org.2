Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D371930A8C1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhBANax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:30:53 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11656 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbhBAN3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:29:53 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DTpfL1P7Yz162lf;
        Mon,  1 Feb 2021 21:27:54 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.176.220) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Mon, 1 Feb 2021 21:29:02 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v5 1/1] perf/smmuv3: Don't reserve the PMCG register spaces
Date:   Mon, 1 Feb 2021 21:27:50 +0800
Message-ID: <20210201132750.1709-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210201132750.1709-1-thunder.leizhen@huawei.com>
References: <20210201132750.1709-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the SMMUv3 specification:
Each PMCG counter group is represented by one 4KB page (Page 0) with one
optional additional 4KB page (Page 1), both of which are at IMPLEMENTATION
DEFINED base addresses.

This means that the PMCG register spaces may be within the 64KB pages of
the SMMUv3 register space. When both the SMMU and PMCG drivers reserve
their own resources, a resource conflict occurs.

To avoid this conflict, don't reserve the PMCG regions.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm_smmuv3_pmu.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 74474bb322c3f26..8f0b71b5d08a815 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -793,17 +793,30 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
-	smmu_pmu->reg_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res_0);
-	if (IS_ERR(smmu_pmu->reg_base))
-		return PTR_ERR(smmu_pmu->reg_base);
+	/*
+	 * The register spaces of the PMCG may be in the register space of
+	 * other devices. For example, SMMU. Therefore, the PMCG resources are
+	 * not reserved to avoid resource conflicts with other drivers.
+	 */
+	res_0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res_0)
+		return -EINVAL;
+	smmu_pmu->reg_base = devm_ioremap(dev, res_0->start, resource_size(res_0));
+	if (!smmu_pmu->reg_base)
+		return -ENOMEM;
 
 	cfgr = readl_relaxed(smmu_pmu->reg_base + SMMU_PMCG_CFGR);
 
 	/* Determine if page 1 is present */
 	if (cfgr & SMMU_PMCG_CFGR_RELOC_CTRS) {
-		smmu_pmu->reloc_base = devm_platform_ioremap_resource(pdev, 1);
-		if (IS_ERR(smmu_pmu->reloc_base))
-			return PTR_ERR(smmu_pmu->reloc_base);
+		struct resource *res_1;
+
+		res_1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		if (!res_1)
+			return -EINVAL;
+		smmu_pmu->reloc_base = devm_ioremap(dev, res_1->start, resource_size(res_1));
+		if (!smmu_pmu->reloc_base)
+			return -ENOMEM;
 	} else {
 		smmu_pmu->reloc_base = smmu_pmu->reg_base;
 	}
-- 
2.26.0.106.g9fadedd



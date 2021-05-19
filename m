Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8C7388AF3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346163AbhESJp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:45:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4745 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345252AbhESJpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:45:46 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FlSY42yz2zpfb5;
        Wed, 19 May 2021 17:40:56 +0800 (CST)
Received: from dggema765-chm.china.huawei.com (10.1.198.207) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 17:44:17 +0800
Received: from DESKTOP-6NKE0BC.china.huawei.com (10.174.185.210) by
 dggema765-chm.china.huawei.com (10.1.198.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 19 May 2021 17:44:17 +0800
From:   Kunkun Jiang <jiangkunkun@huawei.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Eric Auger" <eric.auger@redhat.com>,
        "moderated list:ARM SMMU DRIVERS" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     <wanghaibin.wang@huawei.com>, Keqian Zhu <zhukeqian1@huawei.com>,
        "Zenghui Yu" <yuzenghui@huawei.com>,
        Kunkun Jiang <jiangkunkun@huawei.com>
Subject: [RFC PATCH v1 1/2] iommu/arm-smmu-v3: Align invalid range with leaf page size upwards when support RIL
Date:   Wed, 19 May 2021 17:43:06 +0800
Message-ID: <20210519094307.3275-2-jiangkunkun@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
In-Reply-To: <20210519094307.3275-1-jiangkunkun@huawei.com>
References: <20210519094307.3275-1-jiangkunkun@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.210]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema765-chm.china.huawei.com (10.1.198.207)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the __arm_smmu_tlb_inv_range(), the fileds of TLBI CMD is
calculated based on the invalid range and the leaf page size,
when SMMU supports RIL. It will cause some errors when the
invalid range isn't aligned with the leaf page size.

1. The num_pages will be zero, if the invalid range is less
than b. Then it will enter an endless loop in
__arm_smmu_tlb_inv_range().
2. The actual invalid range will only be part of the invalid
range. If the invalid range is not an integral multiple of
the leaf page size.

To align invalid range with leaf page size upwards will solve
the two issues.

Reported-by: Nianyao Tang <tangnianyao@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 54b2f27b81d4..8a2cacbb1ef8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1703,7 +1703,9 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 
 	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
 		/* Get the leaf page size */
+		size_t leaf_pgsize;
 		tg = __ffs(smmu_domain->domain.pgsize_bitmap);
+		leaf_pgsize = 1 << tg;
 
 		/* Convert page size of 12,14,16 (log2) to 1,2,3 */
 		cmd->tlbi.tg = (tg - 10) / 2;
@@ -1711,6 +1713,8 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 		/* Determine what level the granule is at */
 		cmd->tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
 
+		/* Align size with the leaf page size upwards */
+		size = ALIGN(size, leaf_pgsize);
 		num_pages = size >> tg;
 	}
 
-- 
2.23.0


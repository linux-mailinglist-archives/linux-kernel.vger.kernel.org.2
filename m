Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D8A388AF2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346035AbhESJpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:45:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4679 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239386AbhESJpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:45:44 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FlSYs1SQnz1BP0l;
        Wed, 19 May 2021 17:41:37 +0800 (CST)
Received: from dggema765-chm.china.huawei.com (10.1.198.207) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 17:44:23 +0800
Received: from DESKTOP-6NKE0BC.china.huawei.com (10.174.185.210) by
 dggema765-chm.china.huawei.com (10.1.198.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 19 May 2021 17:44:22 +0800
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
Subject: [RFC PATCH v1 2/2] iommu/arm-smmu-v3: Standardize granule size when support RIL
Date:   Wed, 19 May 2021 17:43:07 +0800
Message-ID: <20210519094307.3275-3-jiangkunkun@huawei.com>
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

In __arm_smmu_tlb_inv_range(), the field 'ttl' of TLB invalidation
command is caculated based on granule size when the SMMU supports
RIL. There are some scenarious we need to avoid, which are pointed
out in the SMMUv3 spec(page 143-144, Version D.a). Adding a check
to ensure that the granule size is supported by the SMMU before set
the 'ttl' value.

Reported-by: Nianyao Tang <tangnianyao@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8a2cacbb1ef8..77ff283ca329 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1711,6 +1711,11 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 		cmd->tlbi.tg = (tg - 10) / 2;
 
 		/* Determine what level the granule is at */
+		if (!(granule & smmu_domain->domain.pgsize_bitmap) ||
+		    (granule & (granule - 1))) {
+			granule = leaf_pgsize;
+			iova = ALIGN_DOWN(iova, leaf_pgsize);
+		}
 		cmd->tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
 
 		/* Align size with the leaf page size upwards */
-- 
2.23.0


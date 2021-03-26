Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D0F34A1D0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 07:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhCZG01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 02:26:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14486 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhCZGZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 02:25:44 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F6BkQ7405zyP0P;
        Fri, 26 Mar 2021 14:23:42 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.179.202) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Fri, 26 Mar 2021 14:25:33 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 7/8] iommu/arm-smmu: Fix spelling mistake "initally" -> "initially"
Date:   Fri, 26 Mar 2021 14:24:11 +0800
Message-ID: <20210326062412.1262-8-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210326062412.1262-1-thunder.leizhen@huawei.com>
References: <20210326062412.1262-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a comment, fix it.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index d8c6bfde6a61587..8e4e8fea106b612 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1358,7 +1358,7 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 		ret = arm_smmu_register_legacy_master(dev, &smmu);
 
 		/*
-		 * If dev->iommu_fwspec is initally NULL, arm_smmu_register_legacy_master()
+		 * If dev->iommu_fwspec is initially NULL, arm_smmu_register_legacy_master()
 		 * will allocate/initialise a new one. Thus we need to update fwspec for
 		 * later use.
 		 */
-- 
1.8.3



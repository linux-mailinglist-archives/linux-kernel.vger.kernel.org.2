Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61675347341
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 09:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbhCXIRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 04:17:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14573 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbhCXIQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 04:16:56 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F51Hg3l0fz19Hwg;
        Wed, 24 Mar 2021 16:14:55 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.179.202) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Wed, 24 Mar 2021 16:16:46 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>, Rui Zhu <zhurui3@huawei.com>
Subject: [PATCH 1/1] iommu/arm-smmu-v3: add bit field SFM into GERROR_ERR_MASK
Date:   Wed, 24 Mar 2021 16:16:03 +0800
Message-ID: <20210324081603.1074-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In arm_smmu_gerror_handler(), the value of the SMMU_GERROR register is
filtered by GERROR_ERR_MASK. However, the GERROR_ERR_MASK does not contain
the SFM bit. As a result, the subsequent error processing is not performed
when only the SFM error occurs.

Fixes: 48ec83bcbcf5 ("iommu/arm-smmu: Add initial driver support for ARM SMMUv3 devices")
Reported-by: Rui Zhu <zhurui3@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index f985817c967a257..230b6f6b39016cd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -115,7 +115,7 @@
 #define GERROR_PRIQ_ABT_ERR		(1 << 3)
 #define GERROR_EVTQ_ABT_ERR		(1 << 2)
 #define GERROR_CMDQ_ERR			(1 << 0)
-#define GERROR_ERR_MASK			0xfd
+#define GERROR_ERR_MASK			0x1fd
 
 #define ARM_SMMU_GERRORN		0x64
 
-- 
2.26.0.106.g9fadedd



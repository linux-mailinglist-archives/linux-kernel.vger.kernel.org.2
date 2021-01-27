Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE44C3059F4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbhA0LhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:37:11 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11613 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236977AbhA0Le3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:34:29 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DQhK71R7Tz160LH;
        Wed, 27 Jan 2021 19:32:11 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.176.220) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Wed, 27 Jan 2021 19:33:14 +0800
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
Subject: [PATCH v3 2/3] perf/smmuv3: Add a MODULE_SOFTDEP() to indicate dependency on SMMU
Date:   Wed, 27 Jan 2021 19:32:57 +0800
Message-ID: <20210127113258.1421-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210127113258.1421-1-thunder.leizhen@huawei.com>
References: <20210127113258.1421-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MODULE_SOFTDEP() gives user space a hint of the loading sequence. And
when command "modprobe arm_smmuv3_pmu" is executed, the arm_smmu_v3.ko is
automatically loaded in advance.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/perf/arm_smmuv3_pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index e5e505a0804fe53..9a305ac51208cd2 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -950,6 +950,7 @@ static void __exit arm_smmu_pmu_exit(void)
 module_exit(arm_smmu_pmu_exit);
 
 MODULE_DESCRIPTION("PMU driver for ARM SMMUv3 Performance Monitors Extension");
+MODULE_SOFTDEP("pre: arm_smmu_v3");
 MODULE_AUTHOR("Neil Leeder <nleeder@codeaurora.org>");
 MODULE_AUTHOR("Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>");
 MODULE_LICENSE("GPL v2");
-- 
1.8.3



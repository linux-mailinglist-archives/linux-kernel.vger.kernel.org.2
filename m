Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77405389EC4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 09:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhETHUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 03:20:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4764 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbhETHUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 03:20:42 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fm1H91xKvzqV4S;
        Thu, 20 May 2021 15:15:49 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 15:19:19 +0800
Received: from huawei.com (10.174.28.241) by dggpemm500004.china.huawei.com
 (7.185.36.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 20 May
 2021 15:19:19 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <cuibixuan@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 3/3] iommu/arm-smmu-v3: Prefer unsigned int to bare use of unsigned
Date:   Thu, 20 May 2021 16:42:20 +0800
Message-ID: <20210520084220.51684-4-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210520084220.51684-1-cuibixuan@huawei.com>
References: <20210520084220.51684-1-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.28.241]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warning in arm-smmu-v3.c:
Prefer 'unsigned int' to bare use of 'unsigned'

Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 51ce44fe550c..725b099d0652 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1827,7 +1827,7 @@ static bool arm_smmu_capable(enum iommu_cap cap)
 	}
 }
 
-static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
+static struct iommu_domain *arm_smmu_domain_alloc(unsigned int type)
 {
 	struct arm_smmu_domain *smmu_domain;
 
-- 
2.17.1


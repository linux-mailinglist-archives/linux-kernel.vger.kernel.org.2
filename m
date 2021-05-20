Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E16389EC2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 09:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhETHUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 03:20:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4553 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhETHUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 03:20:37 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fm1Hv5Vy3zkYFt;
        Thu, 20 May 2021 15:16:27 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 15:19:14 +0800
Received: from huawei.com (10.174.28.241) by dggpemm500004.china.huawei.com
 (7.185.36.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 20 May
 2021 15:19:13 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <cuibixuan@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 1/3] iommu/arm-smmu-v3: fix missing a blank line after declarations
Date:   Thu, 20 May 2021 16:42:18 +0800
Message-ID: <20210520084220.51684-2-cuibixuan@huawei.com>
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

Fixes checkpatch warnings in arm-smmu-v3.c:
WARNING: Missing a blank line after declarations

Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 54b2f27b81d4..4f184119c26d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -151,6 +151,7 @@ static void queue_sync_cons_out(struct arm_smmu_queue *q)
 static void queue_inc_cons(struct arm_smmu_ll_queue *q)
 {
 	u32 cons = (Q_WRP(q, q->cons) | Q_IDX(q, q->cons)) + 1;
+
 	q->cons = Q_OVF(q->cons) | Q_WRP(q, cons) | Q_IDX(q, cons);
 }
 
@@ -176,6 +177,7 @@ static int queue_sync_prod_in(struct arm_smmu_queue *q)
 static u32 queue_inc_prod_n(struct arm_smmu_ll_queue *q, int n)
 {
 	u32 prod = (Q_WRP(q, q->prod) | Q_IDX(q, q->prod)) + n;
+
 	return Q_OVF(q->prod) | Q_WRP(q, prod) | Q_IDX(q, prod);
 }
 
@@ -1895,6 +1897,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 		mutex_unlock(&arm_smmu_asid_lock);
 	} else {
 		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
+
 		if (cfg->vmid)
 			arm_smmu_bitmap_free(smmu->vmid_map, cfg->vmid);
 	}
@@ -2724,6 +2727,7 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 static void arm_smmu_cmdq_free_bitmap(void *data)
 {
 	unsigned long *bitmap = data;
+
 	bitmap_free(bitmap);
 }
 
@@ -2939,6 +2943,7 @@ static int arm_smmu_update_gbpa(struct arm_smmu_device *smmu, u32 set, u32 clr)
 static void arm_smmu_free_msis(void *data)
 {
 	struct device *dev = data;
+
 	platform_msi_domain_free_irqs(dev);
 }
 
-- 
2.17.1


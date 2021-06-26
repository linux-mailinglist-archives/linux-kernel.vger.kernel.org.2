Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767F93B4E54
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 13:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhFZLEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 07:04:38 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:12032 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhFZLEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 07:04:34 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GBrTl34jBzZh1W;
        Sat, 26 Jun 2021 18:59:07 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 19:02:10 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 19:02:10 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH RFC 4/8] iommu/arm-smmu-v3: Extract reusable function __arm_smmu_cmdq_skip_err()
Date:   Sat, 26 Jun 2021 19:01:26 +0800
Message-ID: <20210626110130.2416-5-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210626110130.2416-1-thunder.leizhen@huawei.com>
References: <20210626110130.2416-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SMMU_GERROR.CMDQP_ERR is different to SMMU_GERRORN.CMDQP_ERR, it
indicates that one or more errors have been encountered on a command queue
control page interface. We need to traverse all ECMDQs in that control
page to find all errors. For each ECMDQ error handling, it is much the
same as the CMDQ error handling. This common processing part is extracted
as a new function __arm_smmu_cmdq_skip_err().

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e4af13b1e7fc015..62b2742daab3257 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -359,7 +359,8 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
 	arm_smmu_cmdq_build_cmd(cmd, &ent);
 }
 
-static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
+static void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
+				     struct arm_smmu_queue *q)
 {
 	static const char * const cerror_str[] = {
 		[CMDQ_ERR_CERROR_NONE_IDX]	= "No error",
@@ -370,7 +371,6 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
 
 	int i;
 	u64 cmd[CMDQ_ENT_DWORDS];
-	struct arm_smmu_queue *q = &smmu->cmdq.q;
 	u32 cons = readl_relaxed(q->cons_reg);
 	u32 idx = FIELD_GET(CMDQ_CONS_ERR, cons);
 	struct arm_smmu_cmdq_ent cmd_sync = {
@@ -416,6 +416,11 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
 	queue_write(Q_ENT(q, cons), cmd, q->ent_dwords);
 }
 
+static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
+{
+	__arm_smmu_cmdq_skip_err(smmu, &smmu->cmdq.q);
+}
+
 /*
  * Command queue locking.
  * This is a form of bastardised rwlock with the following major changes:
-- 
2.26.0.106.g9fadedd



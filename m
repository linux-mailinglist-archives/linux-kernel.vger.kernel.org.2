Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390633EFEA0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 10:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239645AbhHRIGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 04:06:31 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8875 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239589AbhHRIGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 04:06:25 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GqL2d4sM0z8sZm;
        Wed, 18 Aug 2021 16:01:45 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 18 Aug 2021 16:05:48 +0800
Received: from thunder-town.china.huawei.com (10.174.178.242) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 18 Aug 2021 16:05:48 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 1/2] iommu/arm-smmu-v3: Properly handle the return value of arm_smmu_cmdq_build_cmd()
Date:   Wed, 18 Aug 2021 16:04:51 +0800
Message-ID: <20210818080452.2079-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210818080452.2079-1-thunder.leizhen@huawei.com>
References: <20210818080452.2079-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.242]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Build command CMD_SYNC cannot fail. So the return value can be ignored.
2. The arm_smmu_cmdq_build_cmd() almost never fails, the addition of
   "unlikely()" can optimize the instruction pipeline.
3. Check the return value in arm_smmu_cmdq_batch_add().

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3646bf8f021cd4c..01e95b56ffa07d1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -409,10 +409,7 @@ static void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 		dev_err(smmu->dev, "\t0x%016llx\n", (unsigned long long)cmd[i]);
 
 	/* Convert the erroneous command into a CMD_SYNC */
-	if (arm_smmu_cmdq_build_cmd(cmd, &cmd_sync)) {
-		dev_err(smmu->dev, "failed to convert to CMD_SYNC\n");
-		return;
-	}
+	arm_smmu_cmdq_build_cmd(cmd, &cmd_sync);
 
 	queue_write(Q_ENT(q, cons), cmd, q->ent_dwords);
 }
@@ -860,7 +857,7 @@ static int __arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 {
 	u64 cmd[CMDQ_ENT_DWORDS];
 
-	if (arm_smmu_cmdq_build_cmd(cmd, ent)) {
+	if (unlikely(arm_smmu_cmdq_build_cmd(cmd, ent))) {
 		dev_warn(smmu->dev, "ignoring unknown CMDQ opcode 0x%x\n",
 			 ent->opcode);
 		return -EINVAL;
@@ -885,11 +882,20 @@ static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
 				    struct arm_smmu_cmdq_batch *cmds,
 				    struct arm_smmu_cmdq_ent *cmd)
 {
+	int index;
+
 	if (cmds->num == CMDQ_BATCH_ENTRIES) {
 		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, false);
 		cmds->num = 0;
 	}
-	arm_smmu_cmdq_build_cmd(&cmds->cmds[cmds->num * CMDQ_ENT_DWORDS], cmd);
+
+	index = cmds->num * CMDQ_ENT_DWORDS;
+	if (unlikely(arm_smmu_cmdq_build_cmd(&cmds->cmds[index], cmd))) {
+		dev_warn(smmu->dev, "ignoring unknown CMDQ opcode 0x%x\n",
+			 cmd->opcode);
+		return;
+	}
+
 	cmds->num++;
 }
 
-- 
2.26.0.106.g9fadedd


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD893B4E56
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 13:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhFZLEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 07:04:42 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5768 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhFZLEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 07:04:34 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GBrRD0vwTzXlKy;
        Sat, 26 Jun 2021 18:56:56 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 19:02:10 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 19:02:09 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH RFC 3/8] iommu/arm-smmu-v3: Add and use static helper function arm_smmu_get_cmdq()
Date:   Sat, 26 Jun 2021 19:01:25 +0800
Message-ID: <20210626110130.2416-4-thunder.leizhen@huawei.com>
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

One SMMU has only one normal CMDQ. Therefore, this CMDQ is used regardless
of the core on which the command is inserted. It can be referenced
directly through "smmu->cmdq". However, one SMMU has multiple ECMDQs, and
the ECMDQ used by the core on which the command insertion is executed may
be different. So the helper function arm_smmu_get_cmdq() is added, which
returns the CMDQ/ECMDQ that the current core should use. Currently, the
code that supports ECMDQ is not added. just simply returns "&smmu->cmdq".

Many subfunctions of arm_smmu_cmdq_issue_cmdlist() use "&smmu->cmdq" or
"&smmu->cmdq.q" directly. To support ECMDQ, they need to call the newly
added function arm_smmu_get_cmdq() instead.

Note that normal CMDQ is still required until ECMDQ is available.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 22 ++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a5361153ca1d6a4..e4af13b1e7fc015 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -335,10 +335,14 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 	return 0;
 }
 
+static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
+{
+	return &smmu->cmdq;
+}
+
 static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
-					 u32 prod)
+					 struct arm_smmu_queue *q, u32 prod)
 {
-	struct arm_smmu_queue *q = &smmu->cmdq.q;
 	struct arm_smmu_cmdq_ent ent = {
 		.opcode = CMDQ_OP_CMD_SYNC,
 	};
@@ -578,7 +582,7 @@ static int arm_smmu_cmdq_poll_until_not_full(struct arm_smmu_device *smmu,
 {
 	unsigned long flags;
 	struct arm_smmu_queue_poll qp;
-	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
+	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu);
 	int ret = 0;
 
 	/*
@@ -594,7 +598,7 @@ static int arm_smmu_cmdq_poll_until_not_full(struct arm_smmu_device *smmu,
 
 	queue_poll_init(smmu, &qp);
 	do {
-		llq->val = READ_ONCE(smmu->cmdq.q.llq.val);
+		llq->val = READ_ONCE(cmdq->q.llq.val);
 		if (!queue_full(llq))
 			break;
 
@@ -613,7 +617,7 @@ static int __arm_smmu_cmdq_poll_until_msi(struct arm_smmu_device *smmu,
 {
 	int ret = 0;
 	struct arm_smmu_queue_poll qp;
-	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
+	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu);
 	u32 *cmd = (u32 *)(Q_ENT(&cmdq->q, llq->prod));
 
 	queue_poll_init(smmu, &qp);
@@ -636,12 +640,12 @@ static int __arm_smmu_cmdq_poll_until_consumed(struct arm_smmu_device *smmu,
 					       struct arm_smmu_ll_queue *llq)
 {
 	struct arm_smmu_queue_poll qp;
-	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
+	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu);
 	u32 prod = llq->prod;
 	int ret = 0;
 
 	queue_poll_init(smmu, &qp);
-	llq->val = READ_ONCE(smmu->cmdq.q.llq.val);
+	llq->val = READ_ONCE(cmdq->q.llq.val);
 	do {
 		if (queue_consumed(llq, prod))
 			break;
@@ -731,7 +735,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	u32 prod;
 	unsigned long flags;
 	bool owner;
-	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
+	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu);
 	struct arm_smmu_ll_queue llq = {
 		.max_n_shift = cmdq->q.llq.max_n_shift,
 	}, head = llq;
@@ -771,7 +775,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	arm_smmu_cmdq_write_entries(cmdq, cmds, llq.prod, n);
 	if (sync) {
 		prod = queue_inc_prod_n(&llq, n);
-		arm_smmu_cmdq_build_sync_cmd(cmd_sync, smmu, prod);
+		arm_smmu_cmdq_build_sync_cmd(cmd_sync, smmu, &cmdq->q, prod);
 		queue_write(Q_ENT(&cmdq->q, prod), cmd_sync, CMDQ_ENT_DWORDS);
 
 		/*
-- 
2.26.0.106.g9fadedd



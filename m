Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1DF3B4E5B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 13:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhFZLE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 07:04:59 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8442 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbhFZLEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 07:04:36 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GBrTm6X88zZkCw;
        Sat, 26 Jun 2021 18:59:08 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 19:02:12 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 19:02:11 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH RFC 7/8] iommu/arm-smmu-v3: Add arm_smmu_ecmdq_issue_cmdlist() for non-shared ECMDQ
Date:   Sat, 26 Jun 2021 19:01:29 +0800
Message-ID: <20210626110130.2416-8-thunder.leizhen@huawei.com>
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

When a core can exclusively own an ECMDQ, competition with other cores
does not need to be considered during command insertion. Therefore, we can
delete the part of arm_smmu_cmdq_issue_cmdlist() that deals with
multi-core contention and generate a more efficient ECMDQ-specific
function arm_smmu_ecmdq_issue_cmdlist().

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 85 +++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 2 files changed, 86 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d5205030710bd1a..a088f2479fc6223 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -769,6 +769,87 @@ static void arm_smmu_cmdq_write_entries(struct arm_smmu_cmdq *cmdq, u64 *cmds,
 	}
 }
 
+/*
+ * The function is used when the current core exclusively occupies an ECMDQ.
+ * This is a reduced version of arm_smmu_cmdq_issue_cmdlist(), which eliminates
+ * a lot of unnecessary inter-core competition considerations.
+ */
+static int arm_smmu_ecmdq_issue_cmdlist(struct arm_smmu_device *smmu,
+					struct arm_smmu_cmdq *cmdq,
+					u64 *cmds, int n, bool sync)
+{
+	u32 prod;
+	unsigned long flags;
+	struct arm_smmu_ll_queue llq = {
+		.max_n_shift = cmdq->q.llq.max_n_shift,
+	}, head;
+	int ret = 0;
+
+	/* 1. Allocate some space in the queue */
+	local_irq_save(flags);
+	llq.val = READ_ONCE(cmdq->q.llq.val);
+	do {
+		u64 old;
+
+		while (!queue_has_space(&llq, n + sync)) {
+			local_irq_restore(flags);
+			if (arm_smmu_cmdq_poll_until_not_full(smmu, &llq))
+				dev_err_ratelimited(smmu->dev, "ECMDQ timeout\n");
+			local_irq_save(flags);
+		}
+
+		head.cons = llq.cons;
+		head.prod = queue_inc_prod_n(&llq, n + sync);
+
+		old = cmpxchg_relaxed(&cmdq->q.llq.val, llq.val, head.val);
+		if (old == llq.val)
+			break;
+
+		llq.val = old;
+	} while (1);
+
+	/* 2. Write our commands into the queue */
+	arm_smmu_cmdq_write_entries(cmdq, cmds, llq.prod, n);
+	if (sync) {
+		u64 cmd_sync[CMDQ_ENT_DWORDS];
+
+		prod = queue_inc_prod_n(&llq, n);
+		arm_smmu_cmdq_build_sync_cmd(cmd_sync, smmu, &cmdq->q, prod);
+		queue_write(Q_ENT(&cmdq->q, prod), cmd_sync, CMDQ_ENT_DWORDS);
+	}
+
+	/* 3. Ensuring commands are visible first */
+	dma_wmb();
+
+	/* 4. Advance the hardware prod pointer */
+	read_lock(&cmdq->q.ecmdq_lock);
+	writel_relaxed(head.prod | cmdq->q.ecmdq_prod, cmdq->q.prod_reg);
+	read_unlock(&cmdq->q.ecmdq_lock);
+
+	/* 5. If we are inserting a CMD_SYNC, we must wait for it to complete */
+	if (sync) {
+		llq.prod = queue_inc_prod_n(&llq, n);
+		ret = arm_smmu_cmdq_poll_until_sync(smmu, &llq);
+		if (ret) {
+			dev_err_ratelimited(smmu->dev,
+					    "CMD_SYNC timeout at 0x%08x [hwprod 0x%08x, hwcons 0x%08x]\n",
+					    llq.prod,
+					    readl_relaxed(cmdq->q.prod_reg),
+					    readl_relaxed(cmdq->q.cons_reg));
+		}
+
+		/*
+		 * Update cmdq->q.llq.cons, to improve the success rate of
+		 * queue_has_space() when some new commands are inserted next
+		 * time.
+		 */
+		WRITE_ONCE(cmdq->q.llq.cons, llq.cons);
+	}
+
+	local_irq_restore(flags);
+	return ret;
+}
+
 /*
  * This is the actual insertion function, and provides the following
  * ordering guarantees to callers:
@@ -798,6 +879,9 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	}, head = llq;
 	int ret = 0;
 
+	if (!cmdq->shared)
+		return arm_smmu_ecmdq_issue_cmdlist(smmu, cmdq, cmds, n, sync);
+
 	/* 1. Allocate some space in the queue */
 	local_irq_save(flags);
 	llq.val = READ_ONCE(cmdq->q.llq.val);
@@ -3001,6 +3085,7 @@ static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
 	unsigned int nents = 1 << cmdq->q.llq.max_n_shift;
 	atomic_long_t *bitmap;
 
+	cmdq->shared = 1;
 	atomic_set(&cmdq->owner_prod, 0);
 	atomic_set(&cmdq->lock, 0);
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 3f3a867a4626fcd..c6efbea3c0a1cda 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -569,6 +569,7 @@ struct arm_smmu_cmdq {
 	atomic_long_t			*valid_map;
 	atomic_t			owner_prod;
 	atomic_t			lock;
+	int				shared;
 };
 
 struct arm_smmu_ecmdq {
-- 
2.26.0.106.g9fadedd



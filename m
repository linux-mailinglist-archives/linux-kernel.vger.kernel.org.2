Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C06D3ECF62
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbhHPHak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 03:30:40 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:13431 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbhHPHah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:30:37 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gp5Lk09kYzdbLh;
        Mon, 16 Aug 2021 15:26:22 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 15:29:51 +0800
Received: from thunder-town.china.huawei.com (10.174.178.242) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 15:29:50 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 1/4] iommu/arm-smmu-v3: Use command queue batching helpers to improve performance
Date:   Mon, 16 Aug 2021 15:29:01 +0800
Message-ID: <20210816072904.1897-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210816072904.1897-1-thunder.leizhen@huawei.com>
References: <20210816072904.1897-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.242]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The obvious key to the performance optimization of commit 587e6c10a7ce
("iommu/arm-smmu-v3: Reduce contention during command-queue insertion") is
to allow multiple cores to insert commands in parallel after a brief mutex
contention.

Obviously, inserting as many commands at a time as possible can reduce the
number of times the mutex contention participates, thereby improving the
overall performance. At least it reduces the number of calls to function
arm_smmu_cmdq_issue_cmdlist().

Therefore, use command queue batching helpers to insert multiple commands
at a time.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 235f9bdaeaf223b..5eedb46aaceece8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1747,15 +1747,17 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 {
 	int i;
 	struct arm_smmu_cmdq_ent cmd;
+	struct arm_smmu_cmdq_batch cmds;
 
 	arm_smmu_atc_inv_to_cmd(0, 0, 0, &cmd);
 
+	cmds.num = 0;
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.atc.sid = master->streams[i].id;
-		arm_smmu_cmdq_issue_cmd(master->smmu, &cmd);
+		arm_smmu_cmdq_batch_add(master->smmu, &cmds, &cmd);
 	}
 
-	return arm_smmu_cmdq_issue_sync(master->smmu);
+	return arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
 }
 
 int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
-- 
2.26.0.106.g9fadedd


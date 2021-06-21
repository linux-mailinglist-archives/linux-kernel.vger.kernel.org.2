Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029403AF05F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 18:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbhFUQse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 12:48:34 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3297 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbhFUQn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 12:43:57 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G7w5p2wfjz6L7cg;
        Tue, 22 Jun 2021 00:31:42 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 21 Jun 2021 18:41:39 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 21 Jun 2021 17:41:36 +0100
From:   John Garry <john.garry@huawei.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH] iommu/arm-smmu-v3: Remove some unneeded init in arm_smmu_cmdq_issue_cmdlist()
Date:   Tue, 22 Jun 2021 00:36:34 +0800
Message-ID: <1624293394-202509-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Members of struct "llq" will be zero-inited, apart from member max_n_shift.
But we write llq.val straight after the init, so it was pointless to zero
init those other members. As such, separately init member max_n_shift
only.

In addition, struct "head" is initialised to "llq" only so that member
max_n_shift is set. But that member is never referenced for "head", so
remove any init there.

Removing these initializations is seen as a small performance optimisation,
as this code is (very) hot path.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 54b2f27b81d4..8a8ad49bb7fd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -727,11 +727,11 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	unsigned long flags;
 	bool owner;
 	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
-	struct arm_smmu_ll_queue llq = {
-		.max_n_shift = cmdq->q.llq.max_n_shift,
-	}, head = llq;
+	struct arm_smmu_ll_queue llq, head;
 	int ret = 0;
 
+	llq.max_n_shift = cmdq->q.llq.max_n_shift;
+
 	/* 1. Allocate some space in the queue */
 	local_irq_save(flags);
 	llq.val = READ_ONCE(cmdq->q.llq.val);
-- 
2.26.2


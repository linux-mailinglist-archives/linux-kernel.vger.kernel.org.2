Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F9A3ECF5F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbhHPHaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 03:30:35 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:13430 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbhHPHa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:30:29 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gp5LT0tddzdbCh;
        Mon, 16 Aug 2021 15:26:09 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 15:29:52 +0800
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
Subject: [PATCH v2 0/4] Prepare for ECMDQ support
Date:   Mon, 16 Aug 2021 15:29:00 +0800
Message-ID: <20210816072904.1897-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
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

v1 --> v2:
1. Stop pre-zeroing batch commands. Patch 1 is modified. Other patches remain unchanged.
   Before:
   struct arm_smmu_cmdq_batch cmds = {};

   After:
   struct arm_smmu_cmdq_batch cmds;
   cmds.num = 0;

RFC --> v1
1. Resend the patches for ECMDQ preparation and remove the patches for ECMDQ implementation.
2. Patch 2 is modified. Other patches remain unchanged.
   1) Add static helper __arm_smmu_cmdq_issue_cmd(), and make arm_smmu_cmdq_issue_cmd()
      and arm_smmu_cmdq_issue_cmd_with_sync() implement based on it.
   2) Remove unused arm_smmu_cmdq_issue_sync().

RFC:
https://www.spinics.net/lists/arm-kernel/msg904879.html


Zhen Lei (4):
  iommu/arm-smmu-v3: Use command queue batching helpers to improve
    performance
  iommu/arm-smmu-v3: Add and use static helper function
    arm_smmu_cmdq_issue_cmd_with_sync()
  iommu/arm-smmu-v3: Add and use static helper function
    arm_smmu_get_cmdq()
  iommu/arm-smmu-v3: Extract reusable function
    __arm_smmu_cmdq_skip_err()

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 72 ++++++++++++---------
 1 file changed, 43 insertions(+), 29 deletions(-)

-- 
2.26.0.106.g9fadedd


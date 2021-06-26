Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF303B4E55
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 13:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhFZLEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 07:04:39 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5770 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhFZLEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 07:04:34 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GBrRC6pVGzXkWv;
        Sat, 26 Jun 2021 18:56:55 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 19:02:08 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 19:02:07 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH RFC 0/8] iommu/arm-smmu-v3: add support for ECMDQ register mode
Date:   Sat, 26 Jun 2021 19:01:22 +0800
Message-ID: <20210626110130.2416-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
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

SMMU v3.3 added a new feature, which is Enhanced Command queue interface
for reducing contention when submitting Commands to the SMMU, in this
patch set, ECMDQ is the abbreviation of Enhanced Command Queue.

When the hardware supports ECMDQ and each core can exclusively use one ECMDQ,
each core does not need to compete with other cores when using its own ECMDQ.
This means that each core can insert commands in parallel. If each ECMDQ can
execute commands in parallel, the overall performance may be better. However,
our hardware currently does not support multiple ECMDQ execute commands in
parallel.

In order to reuse existing code, I originally still call arm_smmu_cmdq_issue_cmdlist()
to insert commands. Even so, however, there was a performance improvement of nearly 12%
in strict mode.

The test environment is the EMU, which simulates the connection of the 200 Gbit/s NIC.
Number of queues:    passthrough   lazy   strict(ECMDQ)  strict(CMDQ)
      6                  188        180       162           145        --> 11.7% improvement
      8                  188        188       184           183        --> 0.55% improvement

In recent days, I implemented a new function without competition with other
cores to replace arm_smmu_cmdq_issue_cmdlist() when a core can have an ECMDQ.
I'm guessing it might get better performance results. Because the EMU is too
slow, it will take a while before the relevant data is available.


Zhen Lei (8):
  iommu/arm-smmu-v3: Use command queue batching helpers to improve
    performance
  iommu/arm-smmu-v3: Add and use static helper function
    arm_smmu_cmdq_issue_cmd_with_sync()
  iommu/arm-smmu-v3: Add and use static helper function
    arm_smmu_get_cmdq()
  iommu/arm-smmu-v3: Extract reusable function
    __arm_smmu_cmdq_skip_err()
  iommu/arm-smmu-v3: Add support for ECMDQ register mode
  iommu/arm-smmu-v3: Ensure that a set of associated commands are
    inserted in the same ECMDQ
  iommu/arm-smmu-v3: Add arm_smmu_ecmdq_issue_cmdlist() for non-shared
    ECMDQ
  iommu/arm-smmu-v3: Add support for less than one ECMDQ per core

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 483 ++++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  37 ++
 2 files changed, 489 insertions(+), 31 deletions(-)

-- 
2.26.0.106.g9fadedd



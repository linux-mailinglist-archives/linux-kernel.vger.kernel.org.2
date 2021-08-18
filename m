Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFC93EFE9E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 10:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239667AbhHRIGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 04:06:25 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8035 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239560AbhHRIGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 04:06:24 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GqL6r05krzYq2R;
        Wed, 18 Aug 2021 16:05:24 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 18 Aug 2021 16:05:48 +0800
Received: from thunder-town.china.huawei.com (10.174.178.242) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 18 Aug 2021 16:05:47 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 0/2] iommu/arm-smmu-v3: Perform some simple optimizations for arm_smmu_cmdq_build_cmd()
Date:   Wed, 18 Aug 2021 16:04:50 +0800
Message-ID: <20210818080452.2079-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
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

v1 --> v2:
1. Add patch 1, Properly handle the return value of arm_smmu_cmdq_build_cmd()
2. Remove arm_smmu_cmdq_copy_cmd(). In addition, when build command fails, out_cmd is not filled.


Zhen Lei (2):
  iommu/arm-smmu-v3: Properly handle the return value of
    arm_smmu_cmdq_build_cmd()
  iommu/arm-smmu-v3: Simplify useless instructions in
    arm_smmu_cmdq_build_cmd()

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 29 ++++++++++++++-------
 1 file changed, 20 insertions(+), 9 deletions(-)

-- 
2.26.0.106.g9fadedd


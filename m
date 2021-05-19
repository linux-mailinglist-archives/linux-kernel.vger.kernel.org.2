Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC64D388AEC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346016AbhESJpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:45:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3028 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239386AbhESJpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:45:30 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FlSXm3SfrzQpfn;
        Wed, 19 May 2021 17:40:40 +0800 (CST)
Received: from dggema765-chm.china.huawei.com (10.1.198.207) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 17:44:10 +0800
Received: from DESKTOP-6NKE0BC.china.huawei.com (10.174.185.210) by
 dggema765-chm.china.huawei.com (10.1.198.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 19 May 2021 17:44:10 +0800
From:   Kunkun Jiang <jiangkunkun@huawei.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Eric Auger" <eric.auger@redhat.com>,
        "moderated list:ARM SMMU DRIVERS" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     <wanghaibin.wang@huawei.com>, Keqian Zhu <zhukeqian1@huawei.com>,
        "Zenghui Yu" <yuzenghui@huawei.com>,
        Kunkun Jiang <jiangkunkun@huawei.com>
Subject: [RFC PATCH v1 0/2] iommu/arm-smmu-v3: Add some parameter check in __arm_smmu_tlb_inv_range()
Date:   Wed, 19 May 2021 17:43:05 +0800
Message-ID: <20210519094307.3275-1-jiangkunkun@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.210]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema765-chm.china.huawei.com (10.1.198.207)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This set of patches solves some errors when I tested the SMMU nested mode.

Test scenario description:
guest kernel: 4KB translation granule
host kernel: 16KB translation granule

errors:
1. encountered an endless loop in __arm_smmu_tlb_inv_range because
num_pages is 0
2. encountered CERROR_ILL because the fields of TLB invalidation
command are as follow: TG = 2, NUM = 0, SCALE = 0, TTL = 0. The
combination is exactly the kind of reserved combination pointed
out in the SMMUv3 spec(page 143-144, version D.a)

In my opinion, it is more appropriate to add parameter check in
__arm_smmu_tlb_inv_range(), although these problems only appeared
when I tested the SMMU nested mode. What do you think?

This series include patches as below:
Patch 1:
- align the invalid range with leaf page size upwards when smmu
supports RIL

Patch 2:
- add a check to standardize granule size when smmu supports RIL

Kunkun Jiang (2):
  iommu/arm-smmu-v3: Align invalid range with leaf page size upwards
    when support RIL
  iommu/arm-smmu-v3: Standardize granule size when support RIL

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
2.23.0


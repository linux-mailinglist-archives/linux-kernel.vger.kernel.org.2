Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41B0351DCB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbhDAScD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:32:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15463 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238728AbhDASKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:10:01 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FB11K5HVKzyNCT;
        Thu,  1 Apr 2021 19:19:49 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Thu, 1 Apr 2021 19:21:45 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <will@kernel.org>, <joro@8bytes.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH] iommu: Remove duplicate check of pasids
Date:   Thu, 1 Apr 2021 19:19:16 +0800
Message-ID: <1617275956-4467-1-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate check of pasids in amd_iommu_domain_enable_v2(), as it
has been guaranteed in amd_iommu_init_device().

Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 drivers/iommu/amd/iommu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 107316e..7ca9f2f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2310,9 +2310,6 @@ int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
 	unsigned long flags;
 	int levels, ret;
 
-	if (pasids <= 0 || pasids > (PASID_MASK + 1))
-		return -EINVAL;
-
 	/* Number of GCR3 table levels required */
 	for (levels = 0; (pasids - 1) & ~0x1ff; pasids >>= 9)
 		levels += 1;
-- 
2.8.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7913DDBE1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 17:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbhHBPHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 11:07:20 -0400
Received: from 8bytes.org ([81.169.241.247]:53302 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234687AbhHBPHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 11:07:01 -0400
Received: from cap.home.8bytes.org (p4ff2b1ea.dip0.t-ipconnect.de [79.242.177.234])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id E7D9235A;
        Mon,  2 Aug 2021 17:06:48 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>, Nadav Amit <namit@vmware.com>,
        Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH] iommu/amd: Remove stale amd_iommu_unmap_flush usage
Date:   Mon,  2 Aug 2021 17:06:43 +0200
Message-Id: <20210802150643.3634-1-joro@8bytes.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Remove the new use of the variable introduced in the AMD driver branch.
The variable was removed already in the iommu core branch, causing build
errors when the brances are merged.

Cc: Nadav Amit <namit@vmware.com>
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd/init.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 239556c1f698..bdcf167b4afe 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1850,11 +1850,9 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 		return ret;
 
 	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE)) {
-		if (!amd_iommu_unmap_flush)
-			pr_info("IOMMU batching is disabled due to virtualization\n");
-
+		pr_info("Using strict mode due to virtualization\n");
+		iommu_set_dma_strict();
 		amd_iommu_np_cache = true;
-		amd_iommu_unmap_flush = true;
 	}
 
 	init_iommu_perf_ctr(iommu);
-- 
2.31.1


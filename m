Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D890454BBC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 18:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239318AbhKQRQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 12:16:05 -0500
Received: from marcansoft.com ([212.63.210.85]:33428 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231313AbhKQRQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 12:16:04 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 586F441F12;
        Wed, 17 Nov 2021 17:13:02 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Sven Peter <sven@svenpeter.dev>, Will Deacon <will@kernel.org>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH] iommu/io-pgtable-arm: Fix table descriptor paddr formatting
Date:   Thu, 18 Nov 2021 02:12:13 +0900
Message-Id: <20211117171213.243584-1-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Table descriptors were being installed without properly formatting the
address using paddr_to_iopte, which does not match up with the
iopte_deref in __arm_lpae_map. This is incorrect for the LPAE pte
format, as it does not handle the high bits properly.

This was found on Apple T6000 DARTs, which require a new pte format
(different shift); adding support for that to
paddr_to_iopte/iopte_to_paddr caused it to break badly, as even <48-bit
addresses would end up incorrect in that case.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/iommu/io-pgtable-arm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index dd9e47189d0d..b636e2737607 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -315,12 +315,12 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 static arm_lpae_iopte arm_lpae_install_table(arm_lpae_iopte *table,
 					     arm_lpae_iopte *ptep,
 					     arm_lpae_iopte curr,
-					     struct io_pgtable_cfg *cfg)
+					     struct arm_lpae_io_pgtable *data)
 {
 	arm_lpae_iopte old, new;
 
-	new = __pa(table) | ARM_LPAE_PTE_TYPE_TABLE;
-	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS)
+	new = paddr_to_iopte(__pa(table), data) | ARM_LPAE_PTE_TYPE_TABLE;
+	if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NS)
 		new |= ARM_LPAE_PTE_NSTABLE;
 
 	/*
@@ -332,11 +332,11 @@ static arm_lpae_iopte arm_lpae_install_table(arm_lpae_iopte *table,
 
 	old = cmpxchg64_relaxed(ptep, curr, new);
 
-	if (cfg->coherent_walk || (old & ARM_LPAE_PTE_SW_SYNC))
+	if (data->iop.cfg.coherent_walk || (old & ARM_LPAE_PTE_SW_SYNC))
 		return old;
 
 	/* Even if it's not ours, there's no point waiting; just kick it */
-	__arm_lpae_sync_pte(ptep, 1, cfg);
+	__arm_lpae_sync_pte(ptep, 1, &data->iop.cfg);
 	if (old == curr)
 		WRITE_ONCE(*ptep, new | ARM_LPAE_PTE_SW_SYNC);
 
@@ -380,7 +380,7 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
 		if (!cptep)
 			return -ENOMEM;
 
-		pte = arm_lpae_install_table(cptep, ptep, 0, cfg);
+		pte = arm_lpae_install_table(cptep, ptep, 0, data);
 		if (pte)
 			__arm_lpae_free_pages(cptep, tblsz, cfg);
 	} else if (!cfg->coherent_walk && !(pte & ARM_LPAE_PTE_SW_SYNC)) {
@@ -592,7 +592,7 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
 		__arm_lpae_init_pte(data, blk_paddr, pte, lvl, 1, &tablep[i]);
 	}
 
-	pte = arm_lpae_install_table(tablep, ptep, blk_pte, cfg);
+	pte = arm_lpae_install_table(tablep, ptep, blk_pte, data);
 	if (pte != blk_pte) {
 		__arm_lpae_free_pages(tablep, tablesz, cfg);
 		/*
-- 
2.33.0


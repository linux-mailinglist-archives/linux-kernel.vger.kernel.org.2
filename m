Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1485C43ABD8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 07:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbhJZFu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 01:50:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229687AbhJZFu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 01:50:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5150860E73;
        Tue, 26 Oct 2021 05:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635227285;
        bh=XsFhsP511nj6/eHseLH0aIDFSZivx3CUuD1Py4KM2Zc=;
        h=From:To:Cc:Subject:Date:From;
        b=qqQVf5EeWuFj4wEPnHypPj15RIQ5Ysq5Tt/E0bFL7ammniejPLnz5cLFtod+wYRyi
         So9onQ62TDQUb9iGaLdkoRawZw05OPItooOEsSbrRI0F/QyrSIjxsgvQEFAm+3JHS7
         MBMfgGxo8bfYuxpPcp+MnMg9Ui08DzWPgcGT6hp+CS2+tlBICOeW1zmSHiZfhzOnCo
         BKTgAoTB7rx5A3frCcS6F9PseXY7mnRI/WAbA3/62mJ8jqXoLHBhpZKzLdML/Vku+A
         9JDpseNW6fvfxd2XETOIpRiuJjeAZyucyuSVkboDbdDVX2KfXcThHpcLVAgOyZYdOS
         wABKAA2YPuRVw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yuri Nudelman <ynudelman@habana.ai>
Subject: [PATCH] habanalabs: make last_mask an MMU property
Date:   Tue, 26 Oct 2021 08:48:00 +0300
Message-Id: <20211026054800.3033091-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuri Nudelman <ynudelman@habana.ai>

Currently LAST_MASK is a global, but really it is an MMU implementation
specific. We need this change for future ASICs.

Signed-off-by: Yuri Nudelman <ynudelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h |  2 ++
 drivers/misc/habanalabs/common/mmu/mmu_v1.c | 10 +++++-----
 drivers/misc/habanalabs/gaudi/gaudi.c       |  1 +
 drivers/misc/habanalabs/goya/goya.c         |  2 ++
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 4f3c228c9b9d..6dd7d9ee7a44 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -382,6 +382,7 @@ enum hl_device_hw_state {
  * @hop3_mask: mask to get the PTE address in hop 3.
  * @hop4_mask: mask to get the PTE address in hop 4.
  * @hop5_mask: mask to get the PTE address in hop 5.
+ * @last_mask: mask to get the bit indicating this is the last hop.
  * @page_size: default page size used to allocate memory.
  * @num_hops: The amount of hops supported by the translation table.
  * @host_resident: Should the MMU page table reside in host memory or in the
@@ -402,6 +403,7 @@ struct hl_mmu_properties {
 	u64	hop3_mask;
 	u64	hop4_mask;
 	u64	hop5_mask;
+	u64	last_mask;
 	u32	page_size;
 	u32	num_hops;
 	u8	host_resident;
diff --git a/drivers/misc/habanalabs/common/mmu/mmu_v1.c b/drivers/misc/habanalabs/common/mmu/mmu_v1.c
index 0f536f79dd9c..159da2fafd79 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu_v1.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu_v1.c
@@ -573,7 +573,7 @@ static int _hl_mmu_v1_unmap(struct hl_ctx *ctx,
 
 	curr_pte = *(u64 *) (uintptr_t) hop3_pte_addr;
 
-	is_huge = curr_pte & LAST_MASK;
+	is_huge = curr_pte & mmu_prop->last_mask;
 
 	if (is_dram_addr && !is_huge) {
 		dev_err(hdev->dev,
@@ -597,7 +597,7 @@ static int _hl_mmu_v1_unmap(struct hl_ctx *ctx,
 
 	if (hdev->dram_default_page_mapping && is_dram_addr) {
 		u64 default_pte = (prop->mmu_dram_default_page_addr &
-				HOP_PHYS_ADDR_MASK) | LAST_MASK |
+				HOP_PHYS_ADDR_MASK) | mmu_prop->last_mask |
 					PAGE_PRESENT_MASK;
 		if (curr_pte == default_pte) {
 			dev_err(hdev->dev,
@@ -729,7 +729,7 @@ static int _hl_mmu_v1_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
 
 	if (hdev->dram_default_page_mapping && is_dram_addr) {
 		u64 default_pte = (prop->mmu_dram_default_page_addr &
-					HOP_PHYS_ADDR_MASK) | LAST_MASK |
+					HOP_PHYS_ADDR_MASK) | mmu_prop->last_mask |
 						PAGE_PRESENT_MASK;
 
 		if (curr_pte != default_pte) {
@@ -769,7 +769,7 @@ static int _hl_mmu_v1_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
 		goto err;
 	}
 
-	curr_pte = (phys_addr & HOP_PHYS_ADDR_MASK) | LAST_MASK
+	curr_pte = (phys_addr & HOP_PHYS_ADDR_MASK) | mmu_prop->last_mask
 			| PAGE_PRESENT_MASK;
 
 	if (is_huge)
@@ -930,7 +930,7 @@ static int hl_mmu_v1_get_tlb_info(struct hl_ctx *ctx, u64 virt_addr,
 		if (!(hops->hop_info[i].hop_pte_val & PAGE_PRESENT_MASK))
 			return -EFAULT;
 
-		if (hops->hop_info[i].hop_pte_val & LAST_MASK)
+		if (hops->hop_info[i].hop_pte_val & mmu_prop->last_mask)
 			break;
 	}
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 92d55a0a10c1..52fffd76f5cf 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -613,6 +613,7 @@ static int gaudi_set_fixed_properties(struct hl_device *hdev)
 			(VA_HOST_SPACE_START + VA_HOST_SPACE_SIZE / 2) - 1;
 	prop->pmmu.page_size = PAGE_SIZE_4KB;
 	prop->pmmu.num_hops = MMU_ARCH_5_HOPS;
+	prop->pmmu.last_mask = LAST_MASK;
 
 	/* PMMU and HPMMU are the same except of page size */
 	memcpy(&prop->pmmu_huge, &prop->pmmu, sizeof(prop->pmmu));
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 5536e8c27bd5..59bb12fcc935 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -429,6 +429,7 @@ int goya_set_fixed_properties(struct hl_device *hdev)
 	prop->dmmu.end_addr = VA_DDR_SPACE_END;
 	prop->dmmu.page_size = PAGE_SIZE_2MB;
 	prop->dmmu.num_hops = MMU_ARCH_5_HOPS;
+	prop->dmmu.last_mask = LAST_MASK;
 
 	/* shifts and masks are the same in PMMU and DMMU */
 	memcpy(&prop->pmmu, &prop->dmmu, sizeof(prop->dmmu));
@@ -436,6 +437,7 @@ int goya_set_fixed_properties(struct hl_device *hdev)
 	prop->pmmu.end_addr = VA_HOST_SPACE_END;
 	prop->pmmu.page_size = PAGE_SIZE_4KB;
 	prop->pmmu.num_hops = MMU_ARCH_5_HOPS;
+	prop->pmmu.last_mask = LAST_MASK;
 
 	/* PMMU and HPMMU are the same except of page size */
 	memcpy(&prop->pmmu_huge, &prop->pmmu, sizeof(prop->pmmu));
-- 
2.25.1


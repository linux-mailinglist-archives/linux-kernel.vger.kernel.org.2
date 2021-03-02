Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F1C32A2C3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381741AbhCBIcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 03:32:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:49016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376856AbhCBIQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:16:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B50CD64D9E;
        Tue,  2 Mar 2021 08:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614672925;
        bh=mm6xPuCkcScAGySvxF3CYPumZ+Fx3pkjxR1bUYH0Opg=;
        h=From:To:Cc:Subject:Date:From;
        b=IkGFeHaq7FSq8nSxEXjuvzrpwmtwA9QgrJcwhqgv9eVYihcJVIiPoFaJ8FLXirnJk
         5rz+IXhoo/tVhiwa1fakSekfpfXlSG67UB3EG0YnSCSSzxgnu29N2GZCCp5GaxqGv8
         e1olWE4A6Br9bS93YIVQBdWDjpwtgc5f1oVNLqE3s6osDcmCrgaArkWZ+YaPmCtXLr
         LkF4wMiM0vU4ueI2sQzKlIYcxlzi3NQxTYORaB9GBE7YwPy36I/boH5sC+KVdU88Wo
         0dWP5HEJM35Jj+iInbUcZZJQ/YTi7RC9NXjkOz6Ozre6hOkXk6m3B8J3uVpT1HL2WS
         A26cAGD41PUnQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH] habanalabs: fix debugfs address translation
Date:   Tue,  2 Mar 2021 10:15:20 +0200
Message-Id: <20210302081520.27170-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

when user uses virtual addresses to access dram through debugfs,
driver translate this address to physical and use it
for the access through the pcie bar.
in case dram page size is different than the dmmu
page size, we need to have special treatment
for adding the page offset to the actual address, which
is to use the dram page size mask to fetch the page offset
from the virtual address, instead of the dmmu last hop shift.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/mmu/mmu.c | 38 ++++++++++++++++--------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/habanalabs/common/mmu/mmu.c b/drivers/misc/habanalabs/common/mmu/mmu.c
index 71703a32350f..5251b336215c 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu.c
@@ -499,18 +499,32 @@ static void hl_mmu_pa_page_with_offset(struct hl_ctx *ctx, u64 virt_addr,
 	else /* HL_VA_RANGE_TYPE_DRAM */
 		p = &prop->dmmu;
 
-	/*
-	 * find the correct hop shift field in hl_mmu_properties structure
-	 * in order to determine the right maks for the page offset.
-	 */
-	hop0_shift_off = offsetof(struct hl_mmu_properties, hop0_shift);
-	p = (char *)p + hop0_shift_off;
-	p = (char *)p + ((hops->used_hops - 1) * sizeof(u64));
-	hop_shift = *(u64 *)p;
-	offset_mask = (1ull << hop_shift) - 1;
-	addr_mask = ~(offset_mask);
-	*phys_addr = (tmp_phys_addr & addr_mask) |
-					(virt_addr & offset_mask);
+	if ((hops->range_type == HL_VA_RANGE_TYPE_DRAM) &&
+			!is_power_of_2(prop->dram_page_size)) {
+		u32 bit;
+		u64 page_offset_mask;
+		u64 phys_addr_mask;
+
+		bit = __ffs64((u64)prop->dram_page_size);
+		page_offset_mask = ((1 << bit) - 1);
+		phys_addr_mask = ~page_offset_mask;
+		*phys_addr = (tmp_phys_addr & phys_addr_mask) |
+				(virt_addr & page_offset_mask);
+	} else {
+		/*
+		 * find the correct hop shift field in hl_mmu_properties
+		 * structure in order to determine the right masks
+		 * for the page offset.
+		 */
+		hop0_shift_off = offsetof(struct hl_mmu_properties, hop0_shift);
+		p = (char *)p + hop0_shift_off;
+		p = (char *)p + ((hops->used_hops - 1) * sizeof(u64));
+		hop_shift = *(u64 *)p;
+		offset_mask = (1ull << hop_shift) - 1;
+		addr_mask = ~(offset_mask);
+		*phys_addr = (tmp_phys_addr & addr_mask) |
+				(virt_addr & offset_mask);
+	}
 }
 
 int hl_mmu_va_to_pa(struct hl_ctx *ctx, u64 virt_addr, u64 *phys_addr)
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136BB39CE19
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 10:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFFIZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 04:25:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230131AbhFFIZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 04:25:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C734361420;
        Sun,  6 Jun 2021 08:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622967813;
        bh=xVlR5Ainedt5nPHD6N6PyK6jCCfTVMpmXxwxX9xeeLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dRWwAu2EeD5N6ArUAa0Zg2sMosFCnvqnnfp+XpGn2fYJBFPqkHIynNpUtJ+yubDlI
         i8oYE0MOa6P5+aq7+owYjZGYKvm9FwD6bwnwXCBwmT1Pg8oXxd3aRHUdAWr4FbPuEq
         leKN0b1tvkeq/bUaYibutt/bz7yp2WtwlNcDjc/k3XOsRokFEjzC+aEXM33HTN+mnr
         vWMfCclEwy+xOiChZV1f7PbAajBPWK0E29GkekWDIbiPDex2rj6dVgs7GDkUDIxCIL
         xGJJLACi+h1IQkZdCBPEnKo6kP0+AHnyKtaELa0sBKQC27OKGSoBvf6HScepQ7R/Ae
         db0HZqzApq+kA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 6/6] habanalabs: fix mask to obtain page offset
Date:   Sun,  6 Jun 2021 11:23:20 +0300
Message-Id: <20210606082320.4319-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210606082320.4319-1-ogabbay@kernel.org>
References: <20210606082320.4319-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

When converting virtual address to physical we need to add correct
offset to the physical page.

For this we need to use mask that include ALL bits of page offset.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/mmu/mmu.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/mmu/mmu.c b/drivers/misc/habanalabs/common/mmu/mmu.c
index b37189956b14..792d25b79ea6 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu.c
@@ -501,12 +501,20 @@ static void hl_mmu_pa_page_with_offset(struct hl_ctx *ctx, u64 virt_addr,
 
 	if ((hops->range_type == HL_VA_RANGE_TYPE_DRAM) &&
 			!is_power_of_2(prop->dram_page_size)) {
-		u32 bit;
+		unsigned long dram_page_size = prop->dram_page_size;
 		u64 page_offset_mask;
 		u64 phys_addr_mask;
+		u32 bit;
 
-		bit = __ffs64((u64)prop->dram_page_size);
-		page_offset_mask = ((1ull << bit) - 1);
+		/*
+		 * find last set bit in page_size to cover all bits of page
+		 * offset. note that 1 has to be added to bit index.
+		 * note that the internal ulong variable is used to avoid
+		 * alignment issue.
+		 */
+		bit = find_last_bit(&dram_page_size,
+					sizeof(dram_page_size) * BITS_PER_BYTE) + 1;
+		page_offset_mask = (BIT_ULL(bit) - 1);
 		phys_addr_mask = ~page_offset_mask;
 		*phys_addr = (tmp_phys_addr & phys_addr_mask) |
 				(virt_addr & page_offset_mask);
-- 
2.25.1


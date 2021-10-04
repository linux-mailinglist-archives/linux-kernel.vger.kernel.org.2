Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4502E420904
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 12:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbhJDKK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 06:10:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229825AbhJDKKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 06:10:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B70461206;
        Mon,  4 Oct 2021 10:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633342117;
        bh=eLdQtmYb2ZA746S8Y2SA8a6or1YUs0gYfzgV6pQ+BLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rPM5Y/NQHKmhaANECXozF7jWxLaHRTbqT3wv4V3vi679vDwFUbCDTl1s+DoRWYkJD
         6D3iyscMLmtmsFmrZAQyRzdP4v6/DepmaLgG3uNl1PYFzVUeUZLzMou5gUBu5u93i4
         CXG/s+L1GqWTrqxpEDznOdd8HKmdzrF91PsNHrwIh2SSMN2QDlaGQiqxWnhFeTvhpk
         ntVg7/BRC9oKgkufcz4KXYCPr7xu+zSDxBLM9XbFuUPddWgZSNa/giOxBUNUTVacnb
         Y2ecgPaSo07IDMfyNzq7Mrj1NeEkpxpLelD8KqSEo506MFdTKIl0t67re2jU4IH4sj
         wWsQySq36DGFg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yuri Nudelman <ynudelman@habana.ai>
Subject: [PATCH 2/6] habanalabs: fix debugfs device memory MMU VA translation
Date:   Mon,  4 Oct 2021 13:08:26 +0300
Message-Id: <20211004100830.27573-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211004100830.27573-1-ogabbay@kernel.org>
References: <20211004100830.27573-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuri Nudelman <ynudelman@habana.ai>

The translation in debugfs of device memory MMU virtual addresses was
wrong as it did not take into consideration the fact that the page
sizes there can be not power of 2.

Signed-off-by: Yuri Nudelman <ynudelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/mmu/mmu.c | 30 +++++++++++++-----------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/habanalabs/common/mmu/mmu.c b/drivers/misc/habanalabs/common/mmu/mmu.c
index 792d25b79ea6..aa96917f62e5 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu.c
@@ -501,23 +501,25 @@ static void hl_mmu_pa_page_with_offset(struct hl_ctx *ctx, u64 virt_addr,
 
 	if ((hops->range_type == HL_VA_RANGE_TYPE_DRAM) &&
 			!is_power_of_2(prop->dram_page_size)) {
-		unsigned long dram_page_size = prop->dram_page_size;
-		u64 page_offset_mask;
-		u64 phys_addr_mask;
-		u32 bit;
+		u64 dram_page_size, dram_base, abs_phys_addr, abs_virt_addr,
+			page_id, page_start;
+		u32 page_off;
 
 		/*
-		 * find last set bit in page_size to cover all bits of page
-		 * offset. note that 1 has to be added to bit index.
-		 * note that the internal ulong variable is used to avoid
-		 * alignment issue.
+		 * Bit arithmetics cannot be used for non power of two page
+		 * sizes. In addition, since bit arithmetics is not used,
+		 * we cannot ignore dram base. All that shall be considerd.
 		 */
-		bit = find_last_bit(&dram_page_size,
-					sizeof(dram_page_size) * BITS_PER_BYTE) + 1;
-		page_offset_mask = (BIT_ULL(bit) - 1);
-		phys_addr_mask = ~page_offset_mask;
-		*phys_addr = (tmp_phys_addr & phys_addr_mask) |
-				(virt_addr & page_offset_mask);
+
+		dram_page_size = prop->dram_page_size;
+		dram_base = prop->dram_base_address;
+		abs_phys_addr = tmp_phys_addr - dram_base;
+		abs_virt_addr = virt_addr - dram_base;
+		page_id = DIV_ROUND_DOWN_ULL(abs_phys_addr, dram_page_size);
+		page_start = page_id * dram_page_size;
+		div_u64_rem(abs_virt_addr, dram_page_size, &page_off);
+
+		*phys_addr = page_start + page_off + dram_base;
 	} else {
 		/*
 		 * find the correct hop shift field in hl_mmu_properties
-- 
2.17.1


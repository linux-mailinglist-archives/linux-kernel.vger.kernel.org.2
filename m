Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D6C3C3C9E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 14:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbhGKM51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 08:57:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232813AbhGKM5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 08:57:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6724561206
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 12:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626008072;
        bh=U3zb8vTCIR6UEbLM2VlCgKyidaPiPwkwe1QWxUYdhb8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mpLhsJ3mzwd19p9bW84+t6neUZj7mLNqGwlNp7XYdX/sNtx5egTHjo5BLprznXPtN
         u7/NnfeckR8LR0URMdbvj4yBOxunKLx36hDAFRW0PJIMZ4LVa7vc/c5Hosbl7EbDQG
         rIqLd1/PPxkTo1FFmzXvtGXabnF9cXdZsph2O/+yK1MKlrApc9/YSfltn1HsueK4c0
         +VGwSIXOx4YuD1TZz7Tmh7tK1+E74Ml6vW5LTzfbLUQXAXb4/bnz5M3hmy1hlxMcpU
         J4Zdz6njjYdczkEvXqtQ+N7+muFE2eRnIaczlElZjqujWL316+11CR40/IeSkSW6WD
         1WRmoHqw1qOPA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] habanalabs: add asic property of host dma offset
Date:   Sun, 11 Jul 2021 15:54:17 +0300
Message-Id: <20210711125418.17533-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210711125418.17533-1-ogabbay@kernel.org>
References: <20210711125418.17533-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each ASIC can have a different offset to add to a host dma address,
to enable the ASIC to access that host memory.

The usage for this can be common code so add this to the asic
property structure.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h | 3 +++
 drivers/misc/habanalabs/gaudi/gaudi.c       | 1 +
 drivers/misc/habanalabs/goya/goya.c         | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 6affad6bc1b9..9782bb50931a 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -434,6 +434,8 @@ struct hl_hints_range {
  *                  the device's MMU.
  * @dram_hints_align_mask: dram va hint addresses alignment mask which is used
  *                  for hints validity check.
+ * device_dma_offset_for_host_access: the offset to add to host DMA addresses
+ *                                    to enable the device to access them.
  * @mmu_pgt_size: MMU page tables total size.
  * @mmu_pte_size: PTE size in MMU page tables.
  * @mmu_hop_table_size: MMU hop table size.
@@ -527,6 +529,7 @@ struct asic_fixed_properties {
 	u64				cb_va_start_addr;
 	u64				cb_va_end_addr;
 	u64				dram_hints_align_mask;
+	u64				device_dma_offset_for_host_access;
 	u32				mmu_pgt_size;
 	u32				mmu_pte_size;
 	u32				mmu_hop_table_size;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 14d0f6d9a383..fdbe8155ef3c 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -537,6 +537,7 @@ static int gaudi_set_fixed_properties(struct hl_device *hdev)
 						get_collective_mode(hdev, i);
 	}
 
+	prop->device_dma_offset_for_host_access = HOST_PHYS_BASE;
 	prop->completion_queues_count = NUMBER_OF_CMPLT_QUEUES;
 	prop->collective_first_sob = 0;
 	prop->collective_first_mon = 0;
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 017c913f7b5a..ae9871928369 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -389,6 +389,7 @@ int goya_set_fixed_properties(struct hl_device *hdev)
 		prop->hw_queues_props[i].cb_alloc_flags = CB_ALLOC_USER;
 	}
 
+	prop->device_dma_offset_for_host_access = HOST_PHYS_BASE;
 	prop->completion_queues_count = NUMBER_OF_CMPLT_QUEUES;
 
 	prop->dram_base_address = DRAM_PHYS_BASE;
-- 
2.25.1


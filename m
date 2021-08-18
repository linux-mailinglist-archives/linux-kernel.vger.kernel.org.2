Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A8E3F04FD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238206AbhHRNkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:40:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237243AbhHRNkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:40:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 22C79610C9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 13:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629293971;
        bh=BzuyOU0oV4ELj8IhFlHRvs/3NkAJcUlhk8EjXu6QTfI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mNacBKgF7onm/GDB11D3TKPVJfUmcsRGD5kAqy6PbzJDV/ikvkWQkaocCGplba/yn
         X2J8mQzDaOYEZjvumXdtTexrtUlnfyb3LUXYGAKoVvBbnJkusB7n7JlSQUs8clMXO2
         ZmqXnd1XvPE+0QRZBqhKn7CxzXxxjAeifrLGrjRPidr/CY/1he8wbujUSloHhjDNhK
         GjMq+EI+EvGyIgVlOmzEWK5kT/Qi/VtAykzwbZ3ywmC9Aieq2lfarr0cuDGBY1dAY2
         S9AF2I08Nn7BZNcW5O0f4E4UW+SLki4DY29v2SgNgQp52CLegJvdatl2nwDLo/n1nG
         FeoGdl39S3sVg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 05/16] habanalabs/gaudi: minimize number of register reads
Date:   Wed, 18 Aug 2021 16:39:11 +0300
Message-Id: <20210818133922.63637-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210818133922.63637-1-ogabbay@kernel.org>
References: <20210818133922.63637-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because the register reads might be trapped by the hypervisor in
certain deployments, minimize the number of reads during runtime by
moving static initializations to functions that occur during device
initialization instead of context open.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c           | 15 +++++++++++----
 drivers/misc/habanalabs/gaudi/gaudi_coresight.c |  5 -----
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index d8d296b66f9d..1b98233ffc4b 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1596,6 +1596,11 @@ static int gaudi_late_init(struct hl_device *hdev)
 		goto disable_pci_access;
 	}
 
+	/* We only support a single ASID for the user, so for the sake of optimization, just
+	 * initialize the ASID one time during device initialization with the fixed value of 1
+	 */
+	gaudi_mmu_prepare(hdev, 1);
+
 	return 0;
 
 disable_pci_access:
@@ -6793,6 +6798,9 @@ static void gaudi_mmu_prepare(struct hl_device *hdev, u32 asid)
 				asid);
 	}
 
+	gaudi_mmu_prepare_reg(hdev, mmPSOC_GLOBAL_CONF_TRACE_ARUSER, asid);
+	gaudi_mmu_prepare_reg(hdev, mmPSOC_GLOBAL_CONF_TRACE_AWUSER, asid);
+
 	hdev->asic_funcs->set_clock_gating(hdev);
 
 	mutex_unlock(&gaudi->clk_gate_mutex);
@@ -6842,7 +6850,8 @@ static int gaudi_send_job_on_qman0(struct hl_device *hdev,
 
 	dma_offset = gaudi_dma_assignment[GAUDI_PCI_DMA_1] * DMA_CORE_OFFSET;
 
-	WREG32_OR(mmDMA0_CORE_PROT + dma_offset, BIT(DMA0_CORE_PROT_VAL_SHIFT));
+	WREG32(mmDMA0_CORE_PROT + dma_offset,
+			BIT(DMA0_CORE_PROT_ERR_VAL_SHIFT) | BIT(DMA0_CORE_PROT_VAL_SHIFT));
 
 	rc = hl_hw_queue_send_cb_no_cmpl(hdev, GAUDI_QUEUE_ID_DMA_0_0,
 					job->job_cb_size, cb->bus_address);
@@ -6863,8 +6872,7 @@ static int gaudi_send_job_on_qman0(struct hl_device *hdev,
 	}
 
 free_fence_ptr:
-	WREG32_AND(mmDMA0_CORE_PROT + dma_offset,
-			~BIT(DMA0_CORE_PROT_VAL_SHIFT));
+	WREG32(mmDMA0_CORE_PROT + dma_offset, BIT(DMA0_CORE_PROT_ERR_VAL_SHIFT));
 
 	hdev->asic_funcs->asic_dma_pool_free(hdev, (void *) fence_ptr,
 					fence_dma_addr);
@@ -8653,7 +8661,6 @@ static int gaudi_ctx_init(struct hl_ctx *ctx)
 	if (ctx->asid == HL_KERNEL_ASID_ID)
 		return 0;
 
-	gaudi_mmu_prepare(ctx->hdev, ctx->asid);
 	return gaudi_internal_cb_pool_init(ctx->hdev, ctx);
 }
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudi_coresight.c b/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
index c2a27ed1c4d1..5349c1be13f9 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
@@ -622,11 +622,6 @@ static int gaudi_config_etr(struct hl_device *hdev,
 			return -EINVAL;
 		}
 
-		gaudi_mmu_prepare_reg(hdev, mmPSOC_GLOBAL_CONF_TRACE_ARUSER,
-						hdev->compute_ctx->asid);
-		gaudi_mmu_prepare_reg(hdev, mmPSOC_GLOBAL_CONF_TRACE_AWUSER,
-						hdev->compute_ctx->asid);
-
 		msb = upper_32_bits(input->buffer_address) >> 8;
 		msb &= PSOC_GLOBAL_CONF_TRACE_ADDR_MSB_MASK;
 		WREG32(mmPSOC_GLOBAL_CONF_TRACE_ADDR, msb);
-- 
2.17.1


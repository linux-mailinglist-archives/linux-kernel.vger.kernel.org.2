Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0DC374FA1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 08:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbhEFGyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 02:54:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232896AbhEFGyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 02:54:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6D1C610E6;
        Thu,  6 May 2021 06:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620284018;
        bh=st/JLHwX37KpyXNxS2OcmqedtdzB65Uf5MIl63wQJiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aCxMhcIh4mGGMV1s/91j/pKm3T8EqzCo5YXu8QKYQ43BZjQ87tuKjYq7oAN21i0kW
         6JdsHOjNNC1LSVl3lhyuyx3IfeP5V2CZGna/c9kTVyjhenOg77lVB58pDCFJqRDOIU
         7AuStGq+Iq3H2asCwjLX3ul/XEVVr43Xc4/tS3Ul420D+ta9aCzv//WmI6V/DxkTbI
         hgAWv+G4FGrIKNq4uEaOGIaCLBeOvm4oasc88M1rtTtu5B/kwNDOlhatemPFZTY5A2
         fYeWaixZCtRKS/lDwWniHv7zpPpoIJWImXle+9U/uyRj1HO+1L9Jd7IbkfApaMWANx
         lDNViaYBc+Thw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Koby Elbaz <kelbaz@habana.ai>
Subject: [PATCH 3/3] habanalabs/gaudi: use scratchpad regs instead of GIC controller
Date:   Thu,  6 May 2021 09:53:30 +0300
Message-Id: <20210506065330.9626-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210506065330.9626-1-ogabbay@kernel.org>
References: <20210506065330.9626-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Koby Elbaz <kelbaz@habana.ai>

Due to new security restrictions, GIC controller can no
longer be accessed from user/kernel.
To monitor that, a new status bit will be read from preboot
caps, indicating whether direct access to GIC is blocked.

In case it is blocked, driver will use scratchpad registers
instead of using GIC interface on two main scenarios:
The first of which LKD triggers interrupts to F/W through GIC,
and the second of when LKD configures all engines/QMANs
to write to GIC when they want to report an error.

From F/W perspective, it will poll on all SPs, and once IRQ
number is retrieved, SP register is cleared, and it will perform the
write to the GIC to trigger the IRQ handler.

Signed-off-by: Koby Elbaz <kelbaz@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c  |   7 ++
 drivers/misc/habanalabs/common/habanalabs.h   |   3 +
 drivers/misc/habanalabs/gaudi/gaudi.c         | 116 ++++++++++++------
 drivers/misc/habanalabs/goya/goya.c           |   1 +
 .../habanalabs/include/common/hl_boot_if.h    |   7 ++
 .../habanalabs/include/gaudi/gaudi_reg_map.h  |   6 +
 6 files changed, 104 insertions(+), 36 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 8fdace889b07..0e6a69fb3013 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -1074,6 +1074,7 @@ static void hl_fw_preboot_update_state(struct hl_device *hdev)
 	 * Preboot:
 	 * Check security status bit (CPU_BOOT_DEV_STS0_ENABLED), if it is set
 	 * check security enabled bit (CPU_BOOT_DEV_STS0_SECURITY_EN)
+	 * Check GIC privileged bit (CPU_BOOT_DEV_STS0_GIC_PRIVILEGED_EN)
 	 */
 	if (cpu_boot_dev_sts0 & CPU_BOOT_DEV_STS0_ENABLED) {
 		prop->fw_cpu_boot_dev_sts0_valid = 1;
@@ -1086,6 +1087,9 @@ static void hl_fw_preboot_update_state(struct hl_device *hdev)
 
 		if (cpu_boot_dev_sts0 & CPU_BOOT_DEV_STS0_FW_HARD_RST_EN)
 			prop->hard_reset_done_by_fw = true;
+
+		if (cpu_boot_dev_sts0 & CPU_BOOT_DEV_STS0_GIC_PRIVILEGED_EN)
+			prop->gic_interrupts_enable = false;
 	} else {
 		prop->fw_cpu_boot_dev_sts0_valid = 0;
 	}
@@ -1105,6 +1109,9 @@ static void hl_fw_preboot_update_state(struct hl_device *hdev)
 
 	dev_info(hdev->dev, "firmware-level security is %s\n",
 			prop->fw_security_disabled ? "disabled" : "enabled");
+
+	dev_info(hdev->dev, "GIC controller is %s\n",
+			prop->gic_interrupts_enable ? "enabled" : "disabled");
 }
 
 static int hl_fw_static_read_preboot_status(struct hl_device *hdev)
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 863f0337883f..9d01406fc32f 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -463,6 +463,8 @@ struct hl_mmu_properties {
  * @num_functional_hbms: number of functional HBMs in each DCORE.
  * @iatu_done_by_fw: true if iATU configuration is being done by FW.
  * @dynamic_fw_load: is dynamic FW load is supported.
+ * @gic_interrupts_enable: true if FW is not blocking GIC controller,
+ *                         false otherwise.
  */
 struct asic_fixed_properties {
 	struct hw_queue_properties	*hw_queues_props;
@@ -533,6 +535,7 @@ struct asic_fixed_properties {
 	u8				num_functional_hbms;
 	u8				iatu_done_by_fw;
 	u8				dynamic_fw_load;
+	u8				gic_interrupts_enable;
 };
 
 /**
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 8619a1524bed..672c0cf4563b 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -549,6 +549,7 @@ static int gaudi_get_fixed_properties(struct hl_device *hdev)
 	prop->fw_cpu_boot_dev_sts0_valid = false;
 	prop->fw_cpu_boot_dev_sts1_valid = false;
 	prop->hard_reset_done_by_fw = false;
+	prop->gic_interrupts_enable = true;
 
 	return 0;
 }
@@ -2536,7 +2537,7 @@ static void gaudi_init_pci_dma_qman(struct hl_device *hdev, int dma_id,
 	u32 mtr_base_en_lo, mtr_base_en_hi, mtr_base_ws_lo, mtr_base_ws_hi;
 	u32 so_base_en_lo, so_base_en_hi, so_base_ws_lo, so_base_ws_hi;
 	u32 q_off, dma_qm_offset;
-	u32 dma_qm_err_cfg;
+	u32 dma_qm_err_cfg, irq_handler_offset;
 
 	dma_qm_offset = dma_id * DMA_QMAN_OFFSET;
 
@@ -2585,6 +2586,10 @@ static void gaudi_init_pci_dma_qman(struct hl_device *hdev, int dma_id,
 
 	/* The following configuration is needed only once per QMAN */
 	if (qman_id == 0) {
+		irq_handler_offset = hdev->asic_prop.gic_interrupts_enable ?
+				mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
+				mmGIC_DMA_QM_IRQ_CTRL_POLL_REG;
+
 		/* Configure RAZWI IRQ */
 		dma_qm_err_cfg = PCI_DMA_QMAN_GLBL_ERR_CFG_MSG_EN_MASK;
 		if (hdev->stop_on_err) {
@@ -2593,12 +2598,12 @@ static void gaudi_init_pci_dma_qman(struct hl_device *hdev, int dma_id,
 		}
 
 		WREG32(mmDMA0_QM_GLBL_ERR_CFG + dma_qm_offset, dma_qm_err_cfg);
+
 		WREG32(mmDMA0_QM_GLBL_ERR_ADDR_LO + dma_qm_offset,
-			lower_32_bits(CFG_BASE +
-					mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR));
+			lower_32_bits(CFG_BASE + irq_handler_offset));
 		WREG32(mmDMA0_QM_GLBL_ERR_ADDR_HI + dma_qm_offset,
-			upper_32_bits(CFG_BASE +
-					mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR));
+			upper_32_bits(CFG_BASE + irq_handler_offset));
+
 		WREG32(mmDMA0_QM_GLBL_ERR_WDATA + dma_qm_offset,
 			gaudi_irq_map_table[GAUDI_EVENT_DMA0_QM].cpu_id +
 									dma_id);
@@ -2619,8 +2624,9 @@ static void gaudi_init_pci_dma_qman(struct hl_device *hdev, int dma_id,
 
 static void gaudi_init_dma_core(struct hl_device *hdev, int dma_id)
 {
-	u32 dma_offset = dma_id * DMA_CORE_OFFSET;
 	u32 dma_err_cfg = 1 << DMA0_CORE_ERR_CFG_ERR_MSG_EN_SHIFT;
+	u32 dma_offset = dma_id * DMA_CORE_OFFSET;
+	u32 irq_handler_offset;
 
 	/* Set to maximum possible according to physical size */
 	WREG32(mmDMA0_CORE_RD_MAX_OUTSTAND + dma_offset, 0);
@@ -2634,10 +2640,16 @@ static void gaudi_init_dma_core(struct hl_device *hdev, int dma_id)
 		dma_err_cfg |= 1 << DMA0_CORE_ERR_CFG_STOP_ON_ERR_SHIFT;
 
 	WREG32(mmDMA0_CORE_ERR_CFG + dma_offset, dma_err_cfg);
+
+	irq_handler_offset = hdev->asic_prop.gic_interrupts_enable ?
+			mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
+			mmGIC_DMA_CR_IRQ_CTRL_POLL_REG;
+
 	WREG32(mmDMA0_CORE_ERRMSG_ADDR_LO + dma_offset,
-		lower_32_bits(CFG_BASE + mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR));
+		lower_32_bits(CFG_BASE + irq_handler_offset));
 	WREG32(mmDMA0_CORE_ERRMSG_ADDR_HI + dma_offset,
-		upper_32_bits(CFG_BASE + mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR));
+		upper_32_bits(CFG_BASE + irq_handler_offset));
+
 	WREG32(mmDMA0_CORE_ERRMSG_WDATA + dma_offset,
 		gaudi_irq_map_table[GAUDI_EVENT_DMA0_CORE].cpu_id + dma_id);
 	WREG32(mmDMA0_CORE_PROT + dma_offset,
@@ -2702,8 +2714,8 @@ static void gaudi_init_hbm_dma_qman(struct hl_device *hdev, int dma_id,
 {
 	u32 mtr_base_en_lo, mtr_base_en_hi, mtr_base_ws_lo, mtr_base_ws_hi;
 	u32 so_base_en_lo, so_base_en_hi, so_base_ws_lo, so_base_ws_hi;
+	u32 dma_qm_err_cfg, irq_handler_offset;
 	u32 q_off, dma_qm_offset;
-	u32 dma_qm_err_cfg;
 
 	dma_qm_offset = dma_id * DMA_QMAN_OFFSET;
 
@@ -2743,6 +2755,10 @@ static void gaudi_init_hbm_dma_qman(struct hl_device *hdev, int dma_id,
 		WREG32(mmDMA0_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 + q_off,
 							QMAN_CPDMA_DST_OFFSET);
 	} else {
+		irq_handler_offset = hdev->asic_prop.gic_interrupts_enable ?
+					mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
+					mmGIC_DMA_QM_IRQ_CTRL_POLL_REG;
+
 		WREG32(mmDMA0_QM_CP_LDMA_TSIZE_OFFSET_0 + q_off,
 							QMAN_LDMA_SIZE_OFFSET);
 		WREG32(mmDMA0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 + q_off,
@@ -2759,11 +2775,10 @@ static void gaudi_init_hbm_dma_qman(struct hl_device *hdev, int dma_id,
 		WREG32(mmDMA0_QM_GLBL_ERR_CFG + dma_qm_offset, dma_qm_err_cfg);
 
 		WREG32(mmDMA0_QM_GLBL_ERR_ADDR_LO + dma_qm_offset,
-			lower_32_bits(CFG_BASE +
-					mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR));
+			lower_32_bits(CFG_BASE + irq_handler_offset));
 		WREG32(mmDMA0_QM_GLBL_ERR_ADDR_HI + dma_qm_offset,
-			upper_32_bits(CFG_BASE +
-					mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR));
+			upper_32_bits(CFG_BASE + irq_handler_offset));
+
 		WREG32(mmDMA0_QM_GLBL_ERR_WDATA + dma_qm_offset,
 			gaudi_irq_map_table[GAUDI_EVENT_DMA0_QM].cpu_id +
 									dma_id);
@@ -2840,6 +2855,7 @@ static void gaudi_init_mme_qman(struct hl_device *hdev, u32 mme_offset,
 {
 	u32 mtr_base_lo, mtr_base_hi;
 	u32 so_base_lo, so_base_hi;
+	u32 irq_handler_offset;
 	u32 q_off, mme_id;
 	u32 mme_qm_err_cfg;
 
@@ -2871,6 +2887,10 @@ static void gaudi_init_mme_qman(struct hl_device *hdev, u32 mme_offset,
 		WREG32(mmMME0_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 + q_off,
 							QMAN_CPDMA_DST_OFFSET);
 	} else {
+		irq_handler_offset = hdev->asic_prop.gic_interrupts_enable ?
+					mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
+					mmGIC_MME_QM_IRQ_CTRL_POLL_REG;
+
 		WREG32(mmMME0_QM_CP_LDMA_TSIZE_OFFSET_0 + q_off,
 							QMAN_LDMA_SIZE_OFFSET);
 		WREG32(mmMME0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 + q_off,
@@ -2888,12 +2908,12 @@ static void gaudi_init_mme_qman(struct hl_device *hdev, u32 mme_offset,
 				MME_QMAN_GLBL_ERR_CFG_STOP_ON_ERR_EN_MASK;
 		}
 		WREG32(mmMME0_QM_GLBL_ERR_CFG + mme_offset, mme_qm_err_cfg);
+
 		WREG32(mmMME0_QM_GLBL_ERR_ADDR_LO + mme_offset,
-			lower_32_bits(CFG_BASE +
-					mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR));
+			lower_32_bits(CFG_BASE + irq_handler_offset));
 		WREG32(mmMME0_QM_GLBL_ERR_ADDR_HI + mme_offset,
-			upper_32_bits(CFG_BASE +
-					mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR));
+			upper_32_bits(CFG_BASE + irq_handler_offset));
+
 		WREG32(mmMME0_QM_GLBL_ERR_WDATA + mme_offset,
 			gaudi_irq_map_table[GAUDI_EVENT_MME0_QM].cpu_id +
 									mme_id);
@@ -2960,8 +2980,8 @@ static void gaudi_init_tpc_qman(struct hl_device *hdev, u32 tpc_offset,
 {
 	u32 mtr_base_en_lo, mtr_base_en_hi, mtr_base_ws_lo, mtr_base_ws_hi;
 	u32 so_base_en_lo, so_base_en_hi, so_base_ws_lo, so_base_ws_hi;
+	u32 tpc_qm_err_cfg, irq_handler_offset;
 	u32 q_off, tpc_id;
-	u32 tpc_qm_err_cfg;
 
 	mtr_base_en_lo = lower_32_bits(CFG_BASE +
 			mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0);
@@ -3002,6 +3022,10 @@ static void gaudi_init_tpc_qman(struct hl_device *hdev, u32 tpc_offset,
 		WREG32(mmTPC0_QM_CP_LDMA_DST_BASE_LO_OFFSET_0 + q_off,
 							QMAN_CPDMA_DST_OFFSET);
 	} else {
+		irq_handler_offset = hdev->asic_prop.gic_interrupts_enable ?
+					mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
+					mmGIC_TPC_QM_IRQ_CTRL_POLL_REG;
+
 		WREG32(mmTPC0_QM_CP_LDMA_TSIZE_OFFSET_0 + q_off,
 							QMAN_LDMA_SIZE_OFFSET);
 		WREG32(mmTPC0_QM_CP_LDMA_SRC_BASE_LO_OFFSET_0 + q_off,
@@ -3017,12 +3041,12 @@ static void gaudi_init_tpc_qman(struct hl_device *hdev, u32 tpc_offset,
 		}
 
 		WREG32(mmTPC0_QM_GLBL_ERR_CFG + tpc_offset, tpc_qm_err_cfg);
+
 		WREG32(mmTPC0_QM_GLBL_ERR_ADDR_LO + tpc_offset,
-			lower_32_bits(CFG_BASE +
-				mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR));
+			lower_32_bits(CFG_BASE + irq_handler_offset));
 		WREG32(mmTPC0_QM_GLBL_ERR_ADDR_HI + tpc_offset,
-			upper_32_bits(CFG_BASE +
-				mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR));
+			upper_32_bits(CFG_BASE + irq_handler_offset));
+
 		WREG32(mmTPC0_QM_GLBL_ERR_WDATA + tpc_offset,
 			gaudi_irq_map_table[GAUDI_EVENT_TPC0_QM].cpu_id +
 									tpc_id);
@@ -3107,8 +3131,8 @@ static void gaudi_init_nic_qman(struct hl_device *hdev, u32 nic_offset,
 {
 	u32 mtr_base_en_lo, mtr_base_en_hi, mtr_base_ws_lo, mtr_base_ws_hi;
 	u32 so_base_en_lo, so_base_en_hi, so_base_ws_lo, so_base_ws_hi;
+	u32 nic_qm_err_cfg, irq_handler_offset;
 	u32 q_off;
-	u32 nic_qm_err_cfg;
 
 	mtr_base_en_lo = lower_32_bits(CFG_BASE +
 			mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0);
@@ -3155,6 +3179,10 @@ static void gaudi_init_nic_qman(struct hl_device *hdev, u32 nic_offset,
 	WREG32(mmNIC0_QM0_CP_MSG_BASE3_ADDR_HI_0 + q_off, so_base_ws_hi);
 
 	if (qman_id == 0) {
+		irq_handler_offset = hdev->asic_prop.gic_interrupts_enable ?
+					mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
+					mmGIC_NIC_QM_IRQ_CTRL_POLL_REG;
+
 		/* Configure RAZWI IRQ */
 		nic_qm_err_cfg = NIC_QMAN_GLBL_ERR_CFG_MSG_EN_MASK;
 		if (hdev->stop_on_err) {
@@ -3163,12 +3191,12 @@ static void gaudi_init_nic_qman(struct hl_device *hdev, u32 nic_offset,
 		}
 
 		WREG32(mmNIC0_QM0_GLBL_ERR_CFG + nic_offset, nic_qm_err_cfg);
+
 		WREG32(mmNIC0_QM0_GLBL_ERR_ADDR_LO + nic_offset,
-			lower_32_bits(CFG_BASE +
-				mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR));
+			lower_32_bits(CFG_BASE + irq_handler_offset));
 		WREG32(mmNIC0_QM0_GLBL_ERR_ADDR_HI + nic_offset,
-			upper_32_bits(CFG_BASE +
-				mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR));
+			upper_32_bits(CFG_BASE + irq_handler_offset));
+
 		WREG32(mmNIC0_QM0_GLBL_ERR_WDATA + nic_offset,
 			gaudi_irq_map_table[GAUDI_EVENT_NIC0_QM0].cpu_id +
 									nic_id);
@@ -3830,10 +3858,10 @@ static int gaudi_init_cpu(struct hl_device *hdev)
 
 static int gaudi_init_cpu_queues(struct hl_device *hdev, u32 cpu_timeout)
 {
-	struct gaudi_device *gaudi = hdev->asic_specific;
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct gaudi_device *gaudi = hdev->asic_specific;
+	u32 status, irq_handler_offset;
 	struct hl_eq *eq;
-	u32 status;
 	struct hl_hw_queue *cpu_pq =
 			&hdev->kernel_queues[GAUDI_QUEUE_ID_CPU_PQ];
 	int err;
@@ -3872,7 +3900,11 @@ static int gaudi_init_cpu_queues(struct hl_device *hdev, u32 cpu_timeout)
 		WREG32(mmCPU_IF_QUEUE_INIT,
 			PQ_INIT_STATUS_READY_FOR_CP_SINGLE_MSI);
 
-	WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR, GAUDI_EVENT_PI_UPDATE);
+	irq_handler_offset = prop->gic_interrupts_enable ?
+			mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
+			mmGIC_HOST_IRQ_CTRL_POLL_REG;
+
+	WREG32(irq_handler_offset, GAUDI_EVENT_PI_UPDATE);
 
 	err = hl_poll_timeout(
 		hdev,
@@ -4003,7 +4035,7 @@ static int gaudi_hw_init(struct hl_device *hdev)
 static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
-	u32 status, reset_timeout_ms, cpu_timeout_ms;
+	u32 status, reset_timeout_ms, cpu_timeout_ms, irq_handler_offset;
 
 	if (!hard_reset) {
 		dev_err(hdev->dev, "GAUDI doesn't support soft-reset\n");
@@ -4034,7 +4066,11 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 	else
 		WREG32(mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU, KMD_MSG_GOTO_WFE);
 
-	WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR, GAUDI_EVENT_HALT_MACHINE);
+	irq_handler_offset = hdev->asic_prop.gic_interrupts_enable ?
+				mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
+				mmGIC_HOST_IRQ_CTRL_POLL_REG;
+
+	WREG32(irq_handler_offset, GAUDI_EVENT_HALT_MACHINE);
 
 	if (hdev->asic_prop.fw_security_disabled &&
 				!hdev->asic_prop.hard_reset_done_by_fw) {
@@ -4146,8 +4182,8 @@ static int gaudi_cb_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
 
 static void gaudi_ring_doorbell(struct hl_device *hdev, u32 hw_queue_id, u32 pi)
 {
+	u32 db_reg_offset, db_value, dma_qm_offset, q_off, irq_handler_offset;
 	struct gaudi_device *gaudi = hdev->asic_specific;
-	u32 db_reg_offset, db_value, dma_qm_offset, q_off;
 	int dma_id;
 	bool invalid_queue = false;
 
@@ -4554,8 +4590,12 @@ static void gaudi_ring_doorbell(struct hl_device *hdev, u32 hw_queue_id, u32 pi)
 	if (hw_queue_id == GAUDI_QUEUE_ID_CPU_PQ) {
 		/* make sure device CPU will read latest data from host */
 		mb();
-		WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR,
-				GAUDI_EVENT_PI_UPDATE);
+
+		irq_handler_offset = hdev->asic_prop.gic_interrupts_enable ?
+					mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
+					mmGIC_HOST_IRQ_CTRL_POLL_REG;
+
+		WREG32(irq_handler_offset, GAUDI_EVENT_PI_UPDATE);
 	}
 }
 
@@ -8778,7 +8818,11 @@ static int gaudi_block_mmap(struct hl_device *hdev,
 
 static void gaudi_enable_events_from_fw(struct hl_device *hdev)
 {
-	WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR, GAUDI_EVENT_INTS_REGISTER);
+	u32 irq_handler_offset = hdev->asic_prop.gic_interrupts_enable ?
+			mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
+			mmGIC_HOST_IRQ_CTRL_POLL_REG;
+
+	WREG32(irq_handler_offset, GAUDI_EVENT_INTS_REGISTER);
 }
 
 static int gaudi_map_pll_idx_to_fw_idx(u32 pll_idx)
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index f1bd8e826304..3d7a760cf2ba 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -464,6 +464,7 @@ int goya_get_fixed_properties(struct hl_device *hdev)
 	prop->fw_cpu_boot_dev_sts0_valid = false;
 	prop->fw_cpu_boot_dev_sts1_valid = false;
 	prop->hard_reset_done_by_fw = false;
+	prop->gic_interrupts_enable = true;
 
 	return 0;
 }
diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index 0fd749c92fc2..9baa56acf473 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -191,6 +191,12 @@
  *					PLLs.
  *					Initialized in: linux
  *
+ * CPU_BOOT_DEV_STS0_GIC_PRIVILEGED_EN	GIC access permission only from
+ *					previleged entity. FW sets this status
+ *					bit for host. If this bit is set then
+ *					GIC can not be accessed from host.
+ *					Initialized in: preboot
+ *
  * CPU_BOOT_DEV_STS0_ENABLED		Device status register enabled.
  *					This is a main indication that the
  *					running FW populates the device status
@@ -219,6 +225,7 @@
 #define CPU_BOOT_DEV_STS0_FW_LD_COM_EN			(1 << 16)
 #define CPU_BOOT_DEV_STS0_FW_IATU_CONF_EN		(1 << 17)
 #define CPU_BOOT_DEV_STS0_DYN_PLL_EN			(1 << 19)
+#define CPU_BOOT_DEV_STS0_GIC_PRIVILEGED_EN		(1 << 20)
 #define CPU_BOOT_DEV_STS0_ENABLED			(1 << 31)
 #define CPU_BOOT_DEV_STS1_ENABLED			(1 << 31)
 
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_reg_map.h b/drivers/misc/habanalabs/include/gaudi/gaudi_reg_map.h
index 137afedf5f15..cd69d3407631 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_reg_map.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_reg_map.h
@@ -12,6 +12,12 @@
  * PSOC scratch-pad registers
  */
 #define mmHW_STATE			mmPSOC_GLOBAL_CONF_SCRATCHPAD_0
+#define mmGIC_HOST_IRQ_CTRL_POLL_REG	mmPSOC_GLOBAL_CONF_SCRATCHPAD_1
+#define mmGIC_TPC_QM_IRQ_CTRL_POLL_REG	mmPSOC_GLOBAL_CONF_SCRATCHPAD_2
+#define mmGIC_MME_QM_IRQ_CTRL_POLL_REG	mmPSOC_GLOBAL_CONF_SCRATCHPAD_3
+#define mmGIC_DMA_QM_IRQ_CTRL_POLL_REG	mmPSOC_GLOBAL_CONF_SCRATCHPAD_4
+#define mmGIC_NIC_QM_IRQ_CTRL_POLL_REG	mmPSOC_GLOBAL_CONF_SCRATCHPAD_5
+#define mmGIC_DMA_CR_IRQ_CTRL_POLL_REG	mmPSOC_GLOBAL_CONF_SCRATCHPAD_6
 #define mmCPU_BOOT_DEV_STS0		mmPSOC_GLOBAL_CONF_SCRATCHPAD_20
 #define mmCPU_BOOT_DEV_STS1		mmPSOC_GLOBAL_CONF_SCRATCHPAD_21
 #define mmFUSE_VER_OFFSET		mmPSOC_GLOBAL_CONF_SCRATCHPAD_22
-- 
2.25.1


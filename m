Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151DB3819DF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 18:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbhEOQc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 12:32:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233612AbhEOQcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 12:32:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD290613C3;
        Sat, 15 May 2021 16:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621096289;
        bh=3jVV41s7pPy3eaDfFjjnwuxeDLjS4CWVHhqthbsy/QI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ET83WkFyW22cKXnz5YDOkjwv9GxzFGgvjs+IZJC3dRdfhT7r4SVvov3bxpZw5K6ne
         kugmvUoMif6fJI/G7IcUCRiWVFQ55egdvArnxzQ/7Y/Y40ufrz805gNsuISNmD4LfR
         j3aSOFn1qiyR/yoIQmixCFSzuPwQFCe9NaaOBGyuGUNQl8Rjvc5ZJKiDpBx7/GHTF0
         enavfsdFKGr4GNHV2AFNjoiqvccxuhobaozXeohsHq4eei1ezC3rYqouGh2rBH6IfM
         I7ZqVENZN4rN2zKMp2G0vjdSyQci/BvKXyf3c+e4C+TGTncR2VyaqnkRvSzCrTCTXM
         tmFsuJOTvC9zQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Koby Elbaz <kelbaz@habana.ai>
Subject: [PATCH 4/5] habanalabs/gaudi: read GIC sts after FW is loaded
Date:   Sat, 15 May 2021 19:31:15 +0300
Message-Id: <20210515163116.14181-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210515163116.14181-1-ogabbay@kernel.org>
References: <20210515163116.14181-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Koby Elbaz <kelbaz@habana.ai>

Reading of GIC privileged status will be done after F/W is loaded,
because privileged GIC capability is only available with the correct
ARMCP version, and after it's loaded.
Such versions necessarily support COMMS, so GIC alternatives (SP regs)
will be read directly from dynamic regs.

As well, initiation of DMA QMANs will occur after F/W is loaded
since it depends on GIC configuration.

In case F/W isn't loaded there's no problem since either way
there won't be any GIC IRQ handling.

Signed-off-by: Koby Elbaz <kelbaz@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c  | 16 ++---
 drivers/misc/habanalabs/gaudi/gaudi.c         | 59 +++++++++++++------
 .../habanalabs/include/common/hl_boot_if.h    | 10 +++-
 3 files changed, 57 insertions(+), 28 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 2d5a849a377e..b00f763bcda6 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -1123,9 +1123,6 @@ static void hl_fw_preboot_update_state(struct hl_device *hdev)
 
 		if (cpu_boot_dev_sts0 & CPU_BOOT_DEV_STS0_FW_HARD_RST_EN)
 			prop->hard_reset_done_by_fw = true;
-
-		if (cpu_boot_dev_sts0 & CPU_BOOT_DEV_STS0_GIC_PRIVILEGED_EN)
-			prop->gic_interrupts_enable = false;
 	} else {
 		prop->fw_cpu_boot_dev_sts0_valid = 0;
 	}
@@ -1143,11 +1140,8 @@ static void hl_fw_preboot_update_state(struct hl_device *hdev)
 	dev_dbg(hdev->dev, "Firmware preboot hard-reset is %s\n",
 			prop->hard_reset_done_by_fw ? "enabled" : "disabled");
 
-	dev_info(hdev->dev, "firmware-level security is %s\n",
+	dev_dbg(hdev->dev, "firmware-level security is %s\n",
 			prop->fw_security_disabled ? "disabled" : "enabled");
-
-	dev_info(hdev->dev, "GIC controller is %s\n",
-			prop->gic_interrupts_enable ? "enabled" : "disabled");
 }
 
 static int hl_fw_static_read_preboot_status(struct hl_device *hdev)
@@ -1971,9 +1965,17 @@ static void hl_fw_linux_update_state(struct hl_device *hdev,
 				CPU_BOOT_DEV_STS0_FW_HARD_RST_EN)
 			prop->hard_reset_done_by_fw = true;
 
+		if (prop->fw_app_cpu_boot_dev_sts0 &
+				CPU_BOOT_DEV_STS0_GIC_PRIVILEGED_EN)
+			prop->gic_interrupts_enable = false;
+
 		dev_dbg(hdev->dev,
 			"Firmware application CPU status0 %#x\n",
 			prop->fw_app_cpu_boot_dev_sts0);
+
+		dev_dbg(hdev->dev, "GIC controller is %s\n",
+				prop->gic_interrupts_enable ?
+						"enabled" : "disabled");
 	}
 
 	if (prop->fw_cpu_boot_dev_sts1_valid) {
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index cf76edc49382..375f7893b84a 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -2534,6 +2534,8 @@ static void gaudi_init_golden_registers(struct hl_device *hdev)
 static void gaudi_init_pci_dma_qman(struct hl_device *hdev, int dma_id,
 					int qman_id, dma_addr_t qman_pq_addr)
 {
+	struct cpu_dyn_regs *dyn_regs =
+			&hdev->fw_loader.dynamic_loader.comm_desc.cpu_dyn_regs;
 	u32 mtr_base_en_lo, mtr_base_en_hi, mtr_base_ws_lo, mtr_base_ws_hi;
 	u32 so_base_en_lo, so_base_en_hi, so_base_ws_lo, so_base_ws_hi;
 	u32 q_off, dma_qm_offset;
@@ -2588,7 +2590,7 @@ static void gaudi_init_pci_dma_qman(struct hl_device *hdev, int dma_id,
 	if (qman_id == 0) {
 		irq_handler_offset = hdev->asic_prop.gic_interrupts_enable ?
 				mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
-				mmGIC_DMA_QM_IRQ_CTRL_POLL_REG;
+				le32_to_cpu(dyn_regs->gic_dma_qm_irq_ctrl);
 
 		/* Configure RAZWI IRQ */
 		dma_qm_err_cfg = PCI_DMA_QMAN_GLBL_ERR_CFG_MSG_EN_MASK;
@@ -2624,6 +2626,8 @@ static void gaudi_init_pci_dma_qman(struct hl_device *hdev, int dma_id,
 
 static void gaudi_init_dma_core(struct hl_device *hdev, int dma_id)
 {
+	struct cpu_dyn_regs *dyn_regs =
+			&hdev->fw_loader.dynamic_loader.comm_desc.cpu_dyn_regs;
 	u32 dma_err_cfg = 1 << DMA0_CORE_ERR_CFG_ERR_MSG_EN_SHIFT;
 	u32 dma_offset = dma_id * DMA_CORE_OFFSET;
 	u32 irq_handler_offset;
@@ -2643,7 +2647,7 @@ static void gaudi_init_dma_core(struct hl_device *hdev, int dma_id)
 
 	irq_handler_offset = hdev->asic_prop.gic_interrupts_enable ?
 			mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
-			mmGIC_DMA_CR_IRQ_CTRL_POLL_REG;
+			le32_to_cpu(dyn_regs->gic_dma_core_irq_ctrl);
 
 	WREG32(mmDMA0_CORE_ERRMSG_ADDR_LO + dma_offset,
 		lower_32_bits(CFG_BASE + irq_handler_offset));
@@ -2712,6 +2716,8 @@ static void gaudi_init_pci_dma_qmans(struct hl_device *hdev)
 static void gaudi_init_hbm_dma_qman(struct hl_device *hdev, int dma_id,
 					int qman_id, u64 qman_base_addr)
 {
+	struct cpu_dyn_regs *dyn_regs =
+			&hdev->fw_loader.dynamic_loader.comm_desc.cpu_dyn_regs;
 	u32 mtr_base_en_lo, mtr_base_en_hi, mtr_base_ws_lo, mtr_base_ws_hi;
 	u32 so_base_en_lo, so_base_en_hi, so_base_ws_lo, so_base_ws_hi;
 	u32 dma_qm_err_cfg, irq_handler_offset;
@@ -2756,8 +2762,8 @@ static void gaudi_init_hbm_dma_qman(struct hl_device *hdev, int dma_id,
 							QMAN_CPDMA_DST_OFFSET);
 	} else {
 		irq_handler_offset = hdev->asic_prop.gic_interrupts_enable ?
-					mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
-					mmGIC_DMA_QM_IRQ_CTRL_POLL_REG;
+				mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
+				le32_to_cpu(dyn_regs->gic_dma_qm_irq_ctrl);
 
 		WREG32(mmDMA0_QM_CP_LDMA_TSIZE_OFFSET_0 + q_off,
 							QMAN_LDMA_SIZE_OFFSET);
@@ -2853,6 +2859,8 @@ static void gaudi_init_hbm_dma_qmans(struct hl_device *hdev)
 static void gaudi_init_mme_qman(struct hl_device *hdev, u32 mme_offset,
 					int qman_id, u64 qman_base_addr)
 {
+	struct cpu_dyn_regs *dyn_regs =
+			&hdev->fw_loader.dynamic_loader.comm_desc.cpu_dyn_regs;
 	u32 mtr_base_lo, mtr_base_hi;
 	u32 so_base_lo, so_base_hi;
 	u32 irq_handler_offset;
@@ -2888,8 +2896,8 @@ static void gaudi_init_mme_qman(struct hl_device *hdev, u32 mme_offset,
 							QMAN_CPDMA_DST_OFFSET);
 	} else {
 		irq_handler_offset = hdev->asic_prop.gic_interrupts_enable ?
-					mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
-					mmGIC_MME_QM_IRQ_CTRL_POLL_REG;
+				mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
+				le32_to_cpu(dyn_regs->gic_mme_qm_irq_ctrl);
 
 		WREG32(mmMME0_QM_CP_LDMA_TSIZE_OFFSET_0 + q_off,
 							QMAN_LDMA_SIZE_OFFSET);
@@ -2978,6 +2986,8 @@ static void gaudi_init_mme_qmans(struct hl_device *hdev)
 static void gaudi_init_tpc_qman(struct hl_device *hdev, u32 tpc_offset,
 				int qman_id, u64 qman_base_addr)
 {
+	struct cpu_dyn_regs *dyn_regs =
+			&hdev->fw_loader.dynamic_loader.comm_desc.cpu_dyn_regs;
 	u32 mtr_base_en_lo, mtr_base_en_hi, mtr_base_ws_lo, mtr_base_ws_hi;
 	u32 so_base_en_lo, so_base_en_hi, so_base_ws_lo, so_base_ws_hi;
 	u32 tpc_qm_err_cfg, irq_handler_offset;
@@ -3023,8 +3033,8 @@ static void gaudi_init_tpc_qman(struct hl_device *hdev, u32 tpc_offset,
 							QMAN_CPDMA_DST_OFFSET);
 	} else {
 		irq_handler_offset = hdev->asic_prop.gic_interrupts_enable ?
-					mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
-					mmGIC_TPC_QM_IRQ_CTRL_POLL_REG;
+				mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
+				le32_to_cpu(dyn_regs->gic_tpc_qm_irq_ctrl);
 
 		WREG32(mmTPC0_QM_CP_LDMA_TSIZE_OFFSET_0 + q_off,
 							QMAN_LDMA_SIZE_OFFSET);
@@ -3129,6 +3139,8 @@ static void gaudi_init_tpc_qmans(struct hl_device *hdev)
 static void gaudi_init_nic_qman(struct hl_device *hdev, u32 nic_offset,
 				int qman_id, u64 qman_base_addr, int nic_id)
 {
+	struct cpu_dyn_regs *dyn_regs =
+			&hdev->fw_loader.dynamic_loader.comm_desc.cpu_dyn_regs;
 	u32 mtr_base_en_lo, mtr_base_en_hi, mtr_base_ws_lo, mtr_base_ws_hi;
 	u32 so_base_en_lo, so_base_en_hi, so_base_ws_lo, so_base_ws_hi;
 	u32 nic_qm_err_cfg, irq_handler_offset;
@@ -3180,8 +3192,8 @@ static void gaudi_init_nic_qman(struct hl_device *hdev, u32 nic_offset,
 
 	if (qman_id == 0) {
 		irq_handler_offset = hdev->asic_prop.gic_interrupts_enable ?
-					mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
-					mmGIC_NIC_QM_IRQ_CTRL_POLL_REG;
+				mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
+				le32_to_cpu(dyn_regs->gic_nic_qm_irq_ctrl);
 
 		/* Configure RAZWI IRQ */
 		nic_qm_err_cfg = NIC_QMAN_GLBL_ERR_CFG_MSG_EN_MASK;
@@ -3858,6 +3870,8 @@ static int gaudi_init_cpu(struct hl_device *hdev)
 
 static int gaudi_init_cpu_queues(struct hl_device *hdev, u32 cpu_timeout)
 {
+	struct cpu_dyn_regs *dyn_regs =
+			&hdev->fw_loader.dynamic_loader.comm_desc.cpu_dyn_regs;
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct gaudi_device *gaudi = hdev->asic_specific;
 	u32 status, irq_handler_offset;
@@ -3902,7 +3916,7 @@ static int gaudi_init_cpu_queues(struct hl_device *hdev, u32 cpu_timeout)
 
 	irq_handler_offset = prop->gic_interrupts_enable ?
 			mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
-			mmGIC_HOST_IRQ_CTRL_POLL_REG;
+			le32_to_cpu(dyn_regs->gic_host_irq_ctrl);
 
 	WREG32(irq_handler_offset, GAUDI_EVENT_PI_UPDATE);
 
@@ -3964,9 +3978,6 @@ static int gaudi_hw_init(struct hl_device *hdev)
 
 	gaudi_pre_hw_init(hdev);
 
-	gaudi_init_pci_dma_qmans(hdev);
-
-	gaudi_init_hbm_dma_qmans(hdev);
 
 	rc = gaudi_init_cpu(hdev);
 	if (rc) {
@@ -3995,6 +4006,10 @@ static int gaudi_hw_init(struct hl_device *hdev)
 
 	gaudi_init_security(hdev);
 
+	gaudi_init_pci_dma_qmans(hdev);
+
+	gaudi_init_hbm_dma_qmans(hdev);
+
 	gaudi_init_mme_qmans(hdev);
 
 	gaudi_init_tpc_qmans(hdev);
@@ -4034,6 +4049,8 @@ static int gaudi_hw_init(struct hl_device *hdev)
 
 static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 {
+	struct cpu_dyn_regs *dyn_regs =
+			&hdev->fw_loader.dynamic_loader.comm_desc.cpu_dyn_regs;
 	struct gaudi_device *gaudi = hdev->asic_specific;
 	u32 status, reset_timeout_ms, cpu_timeout_ms, irq_handler_offset;
 
@@ -4067,8 +4084,8 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 		WREG32(mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU, KMD_MSG_GOTO_WFE);
 
 	irq_handler_offset = hdev->asic_prop.gic_interrupts_enable ?
-				mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
-				mmGIC_HOST_IRQ_CTRL_POLL_REG;
+			mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
+			le32_to_cpu(dyn_regs->gic_host_irq_ctrl);
 
 	WREG32(irq_handler_offset, GAUDI_EVENT_HALT_MACHINE);
 
@@ -4182,6 +4199,8 @@ static int gaudi_cb_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
 
 static void gaudi_ring_doorbell(struct hl_device *hdev, u32 hw_queue_id, u32 pi)
 {
+	struct cpu_dyn_regs *dyn_regs =
+			&hdev->fw_loader.dynamic_loader.comm_desc.cpu_dyn_regs;
 	u32 db_reg_offset, db_value, dma_qm_offset, q_off, irq_handler_offset;
 	struct gaudi_device *gaudi = hdev->asic_specific;
 	int dma_id;
@@ -4592,8 +4611,8 @@ static void gaudi_ring_doorbell(struct hl_device *hdev, u32 hw_queue_id, u32 pi)
 		mb();
 
 		irq_handler_offset = hdev->asic_prop.gic_interrupts_enable ?
-					mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
-					mmGIC_HOST_IRQ_CTRL_POLL_REG;
+				mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
+				le32_to_cpu(dyn_regs->gic_host_irq_ctrl);
 
 		WREG32(irq_handler_offset, GAUDI_EVENT_PI_UPDATE);
 	}
@@ -8820,9 +8839,11 @@ static int gaudi_block_mmap(struct hl_device *hdev,
 
 static void gaudi_enable_events_from_fw(struct hl_device *hdev)
 {
+	struct cpu_dyn_regs *dyn_regs =
+			&hdev->fw_loader.dynamic_loader.comm_desc.cpu_dyn_regs;
 	u32 irq_handler_offset = hdev->asic_prop.gic_interrupts_enable ?
 			mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
-			mmGIC_HOST_IRQ_CTRL_POLL_REG;
+			le32_to_cpu(dyn_regs->gic_host_irq_ctrl);
 
 	WREG32(irq_handler_offset, GAUDI_EVENT_INTS_REGISTER);
 }
diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index e9d86673109c..9266c44d8c6c 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -195,7 +195,7 @@
  *					previleged entity. FW sets this status
  *					bit for host. If this bit is set then
  *					GIC can not be accessed from host.
- *					Initialized in: preboot
+ *					Initialized in: armcpd
  *
  * CPU_BOOT_DEV_STS0_ENABLED		Device status register enabled.
  *					This is a main indication that the
@@ -299,7 +299,13 @@ struct cpu_dyn_regs {
 	__le32 hw_state;
 	__le32 kmd_msg_to_cpu;
 	__le32 cpu_cmd_status_to_host;
-	__le32 reserved1[32];		/* reserve for future use */
+	__le32 gic_host_irq_ctrl;
+	__le32 gic_tpc_qm_irq_ctrl;
+	__le32 gic_mme_qm_irq_ctrl;
+	__le32 gic_dma_qm_irq_ctrl;
+	__le32 gic_nic_qm_irq_ctrl;
+	__le32 gic_dma_core_irq_ctrl;
+	__le32 reserved1[26];		/* reserve for future use */
 };
 
 /* TODO: remove the desc magic after the code is updated to use message */
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D382939662D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 18:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbhEaRAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:00:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233976AbhEaPPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 11:15:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DCED6124C;
        Mon, 31 May 2021 15:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622474053;
        bh=mFibgwOX03nCHZtcHAU7qUHXvDGUVSs9yP+JBzI1ZYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UC82i9VAO3Mjw346AlyXIGaDcNb2SclaoaBHL+RUCF90yuYYPzq4fkLXf09aCWeEM
         71MEy7EwGewCnSWqJa7ZSX55ARbHBRFSUkoLn5p425x2Xoxu2Cue64jv/r+Tp+imht
         dO0qWTUgKJxt61eMHPxVHWWAdOz80WVUF4IoaURr9CmTiUVy+pCoLrUe4pOhsaBoKM
         AYFcIU3ST0BizPErMj8xB21NEzJBn3Vr1UA4JSnHo/aoVBu4l49i7w5z5uZfNM8PHJ
         o01HGc96xyQDpULCwTpUXOYmyFehFEmmYSdCkYeMaSrkHFE8+/5R8eCKLhxcVVumCs
         z7VHNA7z4dKhA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 5/6] habanalabs/gaudi: split host irq interfaces towards FW
Date:   Mon, 31 May 2021 18:14:02 +0300
Message-Id: <20210531151403.12494-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210531151403.12494-1-ogabbay@kernel.org>
References: <20210531151403.12494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Current implementation uses a single interrupt interface towards
FW, this interface is causing races between interrupt types.
We split this interface to interface per interrupt type.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c  | 26 +++++++++++++++++--
 drivers/misc/habanalabs/gaudi/gaudi.c         |  8 +++---
 .../habanalabs/include/common/hl_boot_if.h    | 14 ++++++++--
 .../habanalabs/include/gaudi/gaudi_reg_map.h  |  4 +++
 4 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 4cc6690a3e26..40e91985cb48 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -1782,7 +1782,8 @@ static void hl_fw_boot_fit_update_state(struct hl_device *hdev,
 
 	/* Read boot_cpu status bits */
 	if (prop->fw_cpu_boot_dev_sts0_valid) {
-		prop->fw_bootfit_cpu_boot_dev_sts0 = RREG32(cpu_boot_dev_sts0_reg);
+		prop->fw_bootfit_cpu_boot_dev_sts0 =
+				RREG32(cpu_boot_dev_sts0_reg);
 
 		if (prop->fw_bootfit_cpu_boot_dev_sts0 &
 				CPU_BOOT_DEV_STS0_FW_HARD_RST_EN)
@@ -1793,7 +1794,8 @@ static void hl_fw_boot_fit_update_state(struct hl_device *hdev,
 	}
 
 	if (prop->fw_cpu_boot_dev_sts1_valid) {
-		prop->fw_bootfit_cpu_boot_dev_sts1 = RREG32(cpu_boot_dev_sts1_reg);
+		prop->fw_bootfit_cpu_boot_dev_sts1 =
+				RREG32(cpu_boot_dev_sts1_reg);
 
 		dev_dbg(hdev->dev, "Firmware boot CPU status1 %#x\n",
 					prop->fw_bootfit_cpu_boot_dev_sts1);
@@ -1803,6 +1805,24 @@ static void hl_fw_boot_fit_update_state(struct hl_device *hdev,
 			prop->hard_reset_done_by_fw ? "enabled" : "disabled");
 }
 
+static void hl_fw_dynamic_update_linux_interrupt_if(struct hl_device *hdev)
+{
+	struct cpu_dyn_regs *dyn_regs =
+			&hdev->fw_loader.dynamic_loader.comm_desc.cpu_dyn_regs;
+
+	/* Check whether all 3 interrupt interfaces are set, if not use a
+	 * single interface
+	 */
+	if (!hdev->asic_prop.gic_interrupts_enable &&
+			!(hdev->asic_prop.fw_app_cpu_boot_dev_sts0 &
+				CPU_BOOT_DEV_STS0_MULTI_IRQ_POLL_EN)) {
+		dyn_regs->gic_host_halt_irq = dyn_regs->gic_host_irq_ctrl;
+		dyn_regs->gic_host_ints_irq = dyn_regs->gic_host_irq_ctrl;
+
+		dev_warn(hdev->dev,
+			"Using a single interrupt interface towards cpucp");
+	}
+}
 /**
  * hl_fw_dynamic_load_image - load FW image using dynamic protocol
  *
@@ -2150,6 +2170,8 @@ static int hl_fw_dynamic_init_cpu(struct hl_device *hdev,
 	hl_fw_linux_update_state(hdev, le32_to_cpu(dyn_regs->cpu_boot_dev_sts0),
 				le32_to_cpu(dyn_regs->cpu_boot_dev_sts1));
 
+	hl_fw_dynamic_update_linux_interrupt_if(hdev);
+
 	return 0;
 
 protocol_err:
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 3f760b932eee..007248946b63 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -3962,7 +3962,7 @@ static int gaudi_init_cpu_queues(struct hl_device *hdev, u32 cpu_timeout)
 
 	irq_handler_offset = prop->gic_interrupts_enable ?
 			mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
-			le32_to_cpu(dyn_regs->gic_host_irq_ctrl);
+			le32_to_cpu(dyn_regs->gic_host_pi_upd_irq);
 
 	WREG32(irq_handler_offset, GAUDI_EVENT_PI_UPDATE);
 
@@ -4148,7 +4148,7 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 	if (hdev->fw_loader.linux_loaded) {
 		irq_handler_offset = hdev->asic_prop.gic_interrupts_enable ?
 				mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
-				le32_to_cpu(dyn_regs->gic_host_irq_ctrl);
+				le32_to_cpu(dyn_regs->gic_host_halt_irq);
 
 		WREG32(irq_handler_offset, GAUDI_EVENT_HALT_MACHINE);
 	} else {
@@ -4681,7 +4681,7 @@ static void gaudi_ring_doorbell(struct hl_device *hdev, u32 hw_queue_id, u32 pi)
 
 		irq_handler_offset = hdev->asic_prop.gic_interrupts_enable ?
 				mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
-				le32_to_cpu(dyn_regs->gic_host_irq_ctrl);
+				le32_to_cpu(dyn_regs->gic_host_pi_upd_irq);
 
 		WREG32(irq_handler_offset, GAUDI_EVENT_PI_UPDATE);
 	}
@@ -8912,7 +8912,7 @@ static void gaudi_enable_events_from_fw(struct hl_device *hdev)
 			&hdev->fw_loader.dynamic_loader.comm_desc.cpu_dyn_regs;
 	u32 irq_handler_offset = hdev->asic_prop.gic_interrupts_enable ?
 			mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
-			le32_to_cpu(dyn_regs->gic_host_irq_ctrl);
+			le32_to_cpu(dyn_regs->gic_host_ints_irq);
 
 	WREG32(irq_handler_offset, GAUDI_EVENT_INTS_REGISTER);
 }
diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index 6d0c1ddb4304..89ac8020f821 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -205,6 +205,10 @@
  *					was not served before.
  *					Initialized in: linux
  *
+ * CPU_BOOT_DEV_STS0_MULTI_IRQ_POLL_EN  Use multiple scratchpad interfaces to
+ *					prevent IRQs overriding each other.
+ *					Initialized in: linux
+ *
  * CPU_BOOT_DEV_STS0_ENABLED		Device status register enabled.
  *					This is a main indication that the
  *					running FW populates the device status
@@ -235,6 +239,7 @@
 #define CPU_BOOT_DEV_STS0_DYN_PLL_EN			(1 << 19)
 #define CPU_BOOT_DEV_STS0_GIC_PRIVILEGED_EN		(1 << 20)
 #define CPU_BOOT_DEV_STS0_EQ_INDEX_EN			(1 << 21)
+#define CPU_BOOT_DEV_STS0_MULTI_IRQ_POLL_EN		(1 << 22)
 #define CPU_BOOT_DEV_STS0_ENABLED			(1 << 31)
 #define CPU_BOOT_DEV_STS1_ENABLED			(1 << 31)
 
@@ -308,13 +313,18 @@ struct cpu_dyn_regs {
 	__le32 hw_state;
 	__le32 kmd_msg_to_cpu;
 	__le32 cpu_cmd_status_to_host;
-	__le32 gic_host_irq_ctrl;
+	union {
+		__le32 gic_host_irq_ctrl;
+		__le32 gic_host_pi_upd_irq;
+	};
 	__le32 gic_tpc_qm_irq_ctrl;
 	__le32 gic_mme_qm_irq_ctrl;
 	__le32 gic_dma_qm_irq_ctrl;
 	__le32 gic_nic_qm_irq_ctrl;
 	__le32 gic_dma_core_irq_ctrl;
-	__le32 reserved1[26];		/* reserve for future use */
+	__le32 gic_host_halt_irq;
+	__le32 gic_host_ints_irq;
+	__le32 reserved1[24];		/* reserve for future use */
 };
 
 /* TODO: remove the desc magic after the code is updated to use message */
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_reg_map.h b/drivers/misc/habanalabs/include/gaudi/gaudi_reg_map.h
index cd69d3407631..d95d4162ae2c 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_reg_map.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_reg_map.h
@@ -12,12 +12,16 @@
  * PSOC scratch-pad registers
  */
 #define mmHW_STATE			mmPSOC_GLOBAL_CONF_SCRATCHPAD_0
+/* TODO: remove mmGIC_HOST_IRQ_CTRL_POLL_REG */
 #define mmGIC_HOST_IRQ_CTRL_POLL_REG	mmPSOC_GLOBAL_CONF_SCRATCHPAD_1
+#define mmGIC_HOST_PI_UPD_IRQ_POLL_REG	mmPSOC_GLOBAL_CONF_SCRATCHPAD_1
 #define mmGIC_TPC_QM_IRQ_CTRL_POLL_REG	mmPSOC_GLOBAL_CONF_SCRATCHPAD_2
 #define mmGIC_MME_QM_IRQ_CTRL_POLL_REG	mmPSOC_GLOBAL_CONF_SCRATCHPAD_3
 #define mmGIC_DMA_QM_IRQ_CTRL_POLL_REG	mmPSOC_GLOBAL_CONF_SCRATCHPAD_4
 #define mmGIC_NIC_QM_IRQ_CTRL_POLL_REG	mmPSOC_GLOBAL_CONF_SCRATCHPAD_5
 #define mmGIC_DMA_CR_IRQ_CTRL_POLL_REG	mmPSOC_GLOBAL_CONF_SCRATCHPAD_6
+#define mmGIC_HOST_HALT_IRQ_POLL_REG	mmPSOC_GLOBAL_CONF_SCRATCHPAD_7
+#define mmGIC_HOST_INTS_IRQ_POLL_REG	mmPSOC_GLOBAL_CONF_SCRATCHPAD_8
 #define mmCPU_BOOT_DEV_STS0		mmPSOC_GLOBAL_CONF_SCRATCHPAD_20
 #define mmCPU_BOOT_DEV_STS1		mmPSOC_GLOBAL_CONF_SCRATCHPAD_21
 #define mmFUSE_VER_OFFSET		mmPSOC_GLOBAL_CONF_SCRATCHPAD_22
-- 
2.25.1


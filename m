Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7951A3B911F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 13:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbhGAL3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 07:29:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236040AbhGAL3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 07:29:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88E6061467;
        Thu,  1 Jul 2021 11:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625138842;
        bh=RHfnJsZYmn8GcXBoG6Strh/zr6TOla1okodIj0xrWjM=;
        h=From:To:Cc:Subject:Date:From;
        b=aqS+DowpCR9bP/y8Te/NKqYPf0Zb92TtEmQzyZHOB5Bn56sdqYHWkkTcBZTkv6Med
         j+Yyguv0dA2fjMLzbgVDKQt26oHi1OLAj0RrDbf/sNHVbsuUrTCHFEfQA3ptWrW66R
         VQVxILyzmKpnfPbgkTB4LLxFoxb8TlJ3xkih/WPHgbjmOg1/islFsSibH6wlCfxIxV
         J19ne4NSMltzbmne8On/HZIGIhfQPyaQ+4myzwDxMcIyzd/4R3Bob6aQGuknzHvHQy
         W27D6FT3PUD++q3vnVlad/F+yDJ+aYOCGJ2q7VoKqIx8xMfQX/X/LtapOjyq3R7OZA
         e7YOHj24LLN7Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/7] habanalabs: update firmware header files
Date:   Thu,  1 Jul 2021 14:27:11 +0300
Message-Id: <20210701112717.9540-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Update recent changes made in firmware header files, which contain
a minor COMMS protocol change and new error status definitions.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c  |  4 +--
 .../habanalabs/include/common/hl_boot_if.h    | 35 ++++++++++++++++---
 .../habanalabs/include/gaudi/gaudi_reg_map.h  |  2 --
 3 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 2e4d04ec6b53..bac25a60650f 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -1953,8 +1953,8 @@ static void hl_fw_dynamic_update_linux_interrupt_if(struct hl_device *hdev)
 	if (!hdev->asic_prop.gic_interrupts_enable &&
 			!(hdev->asic_prop.fw_app_cpu_boot_dev_sts0 &
 				CPU_BOOT_DEV_STS0_MULTI_IRQ_POLL_EN)) {
-		dyn_regs->gic_host_halt_irq = dyn_regs->gic_host_irq_ctrl;
-		dyn_regs->gic_host_ints_irq = dyn_regs->gic_host_irq_ctrl;
+		dyn_regs->gic_host_halt_irq = dyn_regs->gic_host_pi_upd_irq;
+		dyn_regs->gic_host_ints_irq = dyn_regs->gic_host_pi_upd_irq;
 
 		dev_warn(hdev->dev,
 			"Using a single interrupt interface towards cpucp");
diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index fa8a5ad2d438..d762bb2f1204 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -78,6 +78,26 @@
  * CPU_BOOT_ERR0_DEVICE_UNUSABLE_FAIL	Device is unusable and customer support
  *					should be contacted.
  *
+ * CPU_BOOT_ERR0_ARC0_HALT_ACK_NOT_RCVD	HALT ACK from ARC0 is not received
+ *					within specified retries after issuing
+ *					HALT request. ARC0 appears to be in bad
+ *					reset.
+ *
+ * CPU_BOOT_ERR0_ARC1_HALT_ACK_NOT_RCVD	HALT ACK from ARC1 is not received
+ *					within specified retries after issuing
+ *					HALT request. ARC1 appears to be in bad
+ *					reset.
+ *
+ * CPU_BOOT_ERR0_ARC0_RUN_ACK_NOT_RCVD	RUN ACK from ARC0 is not received
+ *					within specified timeout after issuing
+ *					RUN request. ARC0 appears to be in bad
+ *					reset.
+ *
+ * CPU_BOOT_ERR0_ARC1_RUN_ACK_NOT_RCVD	RUN ACK from ARC1 is not received
+ *					within specified timeout after issuing
+ *					RUN request. ARC1 appears to be in bad
+ *					reset.
+ *
  * CPU_BOOT_ERR0_ENABLED		Error registers enabled.
  *					This is a main indication that the
  *					running FW populates the error
@@ -98,6 +118,10 @@
 #define CPU_BOOT_ERR0_SEC_IMG_VER_FAIL		(1 << 11)
 #define CPU_BOOT_ERR0_PLL_FAIL			(1 << 12)
 #define CPU_BOOT_ERR0_DEVICE_UNUSABLE_FAIL	(1 << 13)
+#define CPU_BOOT_ERR0_ARC0_HALT_ACK_NOT_RCVD	(1 << 14)
+#define CPU_BOOT_ERR0_ARC1_HALT_ACK_NOT_RCVD	(1 << 15)
+#define CPU_BOOT_ERR0_ARC0_RUN_ACK_NOT_RCVD	(1 << 16)
+#define CPU_BOOT_ERR0_ARC1_RUN_ACK_NOT_RCVD	(1 << 17)
 #define CPU_BOOT_ERR0_ENABLED			(1 << 31)
 #define CPU_BOOT_ERR1_ENABLED			(1 << 31)
 
@@ -313,10 +337,7 @@ struct cpu_dyn_regs {
 	__le32 hw_state;
 	__le32 kmd_msg_to_cpu;
 	__le32 cpu_cmd_status_to_host;
-	union {
-		__le32 gic_host_irq_ctrl;
-		__le32 gic_host_pi_upd_irq;
-	};
+	__le32 gic_host_pi_upd_irq;
 	__le32 gic_tpc_qm_irq_ctrl;
 	__le32 gic_mme_qm_irq_ctrl;
 	__le32 gic_dma_qm_irq_ctrl;
@@ -462,6 +483,11 @@ struct lkd_fw_comms_msg {
  *				Do not wait for BMC response.
  *
  * COMMS_LOW_PLL_OPP		Initialize PLLs for low OPP.
+ *
+ * COMMS_PREP_DESC_ELBI		Same as COMMS_PREP_DESC only that the memory
+ *				space is allocated in a ELBI access only
+ *				address range.
+ *
  */
 enum comms_cmd {
 	COMMS_NOOP = 0,
@@ -474,6 +500,7 @@ enum comms_cmd {
 	COMMS_GOTO_WFE = 7,
 	COMMS_SKIP_BMC = 8,
 	COMMS_LOW_PLL_OPP = 9,
+	COMMS_PREP_DESC_ELBI = 10,
 	COMMS_INVLD_LAST
 };
 
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_reg_map.h b/drivers/misc/habanalabs/include/gaudi/gaudi_reg_map.h
index d95d4162ae2c..b9bd5a7f71eb 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_reg_map.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_reg_map.h
@@ -12,8 +12,6 @@
  * PSOC scratch-pad registers
  */
 #define mmHW_STATE			mmPSOC_GLOBAL_CONF_SCRATCHPAD_0
-/* TODO: remove mmGIC_HOST_IRQ_CTRL_POLL_REG */
-#define mmGIC_HOST_IRQ_CTRL_POLL_REG	mmPSOC_GLOBAL_CONF_SCRATCHPAD_1
 #define mmGIC_HOST_PI_UPD_IRQ_POLL_REG	mmPSOC_GLOBAL_CONF_SCRATCHPAD_1
 #define mmGIC_TPC_QM_IRQ_CTRL_POLL_REG	mmPSOC_GLOBAL_CONF_SCRATCHPAD_2
 #define mmGIC_MME_QM_IRQ_CTRL_POLL_REG	mmPSOC_GLOBAL_CONF_SCRATCHPAD_3
-- 
2.25.1


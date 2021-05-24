Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E38C38E28A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 10:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhEXIr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 04:47:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232487AbhEXIrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 04:47:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D421B611AC
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 08:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621845987;
        bh=cvD0dZPvuBZ5Lca6Ao+tHozvUGoIwvjRQXJJEGBZAVQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=c/fwmPHKtnImL1Fzu0pQCEDMZfQd8GEqjV57p7bjsVCaKBclWTYq1glebO9s8LyNn
         7oBug6SgpWDqiwaAMif132pkGky2+44J67wKnAxHMIuIsx0O9da0OVFOKjd2dQlXUw
         40EZKUOg/wBznHj0/qXIRRkfNJ0kwAZ7Z8MuZ79AsZUZ7lTsUJQeOwGc6D2T8tkPdm
         raawkAKBOluwKTz3iBWsM8bgp/K7i0dfuTcbpRPtM7w/be1h2hBxESLZcWQBlHWGy6
         aBFTYqklAqoZucc3pHzyX+rKW61LcyKwgFB26KS7L7bscXpnOeS6o6Ppw//aD3P/lX
         tYVZL+oO+6k4g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] habanalabs/gaudi: refactor reset code
Date:   Mon, 24 May 2021 11:46:19 +0300
Message-Id: <20210524084619.4680-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210524084619.4680-1-ogabbay@kernel.org>
References: <20210524084619.4680-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After all the latest changes to the reset code, there were some
redundancy and errors in the flows.

If the Linux FIT is loaded to the ASIC CPU, we need to communicate
with it only via GIC. If it is not loaded, we need to either use
COMMS protocol (for newer f/w) or MSG_TO_CPU register (for older f/w).

In addition, if we halted the device CPU then we need to mark that
the driver will do the reset, regardless of the capabilities.

Also, to prevent false errors, we need to keep track whether the
device CPU was already halted. If so, we shouldn't try to halt it
again.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c  | 47 ++++++++++++++++----------
 drivers/misc/habanalabs/gaudi/gaudiP.h |  5 +++
 2 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 836465dccc61..5ca4c8f86801 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1931,11 +1931,11 @@ static void gaudi_disable_msi(struct hl_device *hdev)
 	gaudi->hw_cap_initialized &= ~HW_CAP_MSI;
 }
 
-static void gaudi_fw_hard_reset(struct hl_device *hdev)
+static void gaudi_ask_hard_reset_without_linux(struct hl_device *hdev)
 {
 	int rc;
 
-	if (hdev->asic_prop.dynamic_fw_load && !hdev->fw_loader.linux_loaded) {
+	if (hdev->asic_prop.dynamic_fw_load) {
 		rc = hl_fw_dynamic_send_protocol_cmd(hdev, &hdev->fw_loader,
 				COMMS_RST_DEV, 0, false,
 				hdev->fw_loader.cpu_timeout);
@@ -1946,12 +1946,16 @@ static void gaudi_fw_hard_reset(struct hl_device *hdev)
 	}
 }
 
-static void gaudi_fw_halt_cpu(struct hl_device *hdev)
+static void gaudi_ask_halt_machine_without_linux(struct hl_device *hdev)
 {
+	struct gaudi_device *gaudi = hdev->asic_specific;
 	int rc;
 
+	if (gaudi && gaudi->device_cpu_is_halted)
+		return;
+
 	/* Stop device CPU to make sure nothing bad happens */
-	if (hdev->asic_prop.dynamic_fw_load && !hdev->fw_loader.linux_loaded) {
+	if (hdev->asic_prop.dynamic_fw_load) {
 		rc = hl_fw_dynamic_send_protocol_cmd(hdev, &hdev->fw_loader,
 				COMMS_GOTO_WFE, 0, true,
 				hdev->fw_loader.cpu_timeout);
@@ -1961,6 +1965,9 @@ static void gaudi_fw_halt_cpu(struct hl_device *hdev)
 		WREG32(mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU, KMD_MSG_GOTO_WFE);
 		msleep(GAUDI_CPU_RESET_WAIT_MSEC);
 	}
+
+	if (gaudi)
+		gaudi->device_cpu_is_halted = true;
 }
 
 static void gaudi_init_scrambler_sram(struct hl_device *hdev)
@@ -4110,8 +4117,9 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 {
 	struct cpu_dyn_regs *dyn_regs =
 			&hdev->fw_loader.dynamic_loader.comm_desc.cpu_dyn_regs;
-	struct gaudi_device *gaudi = hdev->asic_specific;
 	u32 status, reset_timeout_ms, cpu_timeout_ms, irq_handler_offset;
+	struct gaudi_device *gaudi = hdev->asic_specific;
+	bool driver_performs_reset;
 
 	if (!hard_reset) {
 		dev_err(hdev->dev, "GAUDI doesn't support soft-reset\n");
@@ -4126,32 +4134,34 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 		cpu_timeout_ms = GAUDI_CPU_RESET_WAIT_MSEC;
 	}
 
+	driver_performs_reset = !!(!hdev->asic_prop.fw_security_enabled &&
+					!hdev->asic_prop.hard_reset_done_by_fw);
+
 	/* Set device to handle FLR by H/W as we will put the device CPU to
 	 * halt mode
 	 */
-	if (!hdev->asic_prop.fw_security_enabled &&
-				!hdev->asic_prop.hard_reset_done_by_fw)
+	if (driver_performs_reset)
 		WREG32(mmPCIE_AUX_FLR_CTRL, (PCIE_AUX_FLR_CTRL_HW_CTRL_MASK |
 					PCIE_AUX_FLR_CTRL_INT_MASK_MASK));
 
-	/* I don't know what is the state of the CPU so make sure it is
-	 * stopped in any means necessary
+	/* If linux is loaded in the device CPU we need to communicate with it
+	 * via the GIC. Otherwise, we need to use COMMS or the MSG_TO_CPU
+	 * registers in case of old F/Ws
 	 */
-	if (hdev->asic_prop.hard_reset_done_by_fw)
-		gaudi_fw_hard_reset(hdev);
-	else
-		gaudi_fw_halt_cpu(hdev);
-
 	if (hdev->fw_loader.linux_loaded) {
 		irq_handler_offset = hdev->asic_prop.gic_interrupts_enable ?
 				mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
 				le32_to_cpu(dyn_regs->gic_host_irq_ctrl);
 
 		WREG32(irq_handler_offset, GAUDI_EVENT_HALT_MACHINE);
+	} else {
+		if (hdev->asic_prop.hard_reset_done_by_fw)
+			gaudi_ask_hard_reset_without_linux(hdev);
+		else
+			gaudi_ask_halt_machine_without_linux(hdev);
 	}
 
-	if (!hdev->asic_prop.fw_security_enabled &&
-				!hdev->asic_prop.hard_reset_done_by_fw) {
+	if (driver_performs_reset) {
 
 		/* Configure the reset registers. Must be done as early as
 		 * possible in case we fail during H/W initialization
@@ -4185,8 +4195,7 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 		WREG32(mmPREBOOT_PCIE_EN, LKD_HARD_RESET_MAGIC);
 
 		/* Restart BTL/BLR upon hard-reset */
-		if (!hdev->asic_prop.fw_security_enabled)
-			WREG32(mmPSOC_GLOBAL_CONF_BOOT_SEQ_RE_START, 1);
+		WREG32(mmPSOC_GLOBAL_CONF_BOOT_SEQ_RE_START, 1);
 
 		WREG32(mmPSOC_GLOBAL_CONF_SW_ALL_RST,
 			1 << PSOC_GLOBAL_CONF_SW_ALL_RST_IND_SHIFT);
@@ -4223,6 +4232,8 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 				HW_CAP_CLK_GATE);
 
 		memset(gaudi->events_stat, 0, sizeof(gaudi->events_stat));
+
+		gaudi->device_cpu_is_halted = false;
 	}
 }
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index 5929be81ec23..48637a6343bb 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -314,6 +314,10 @@ struct gaudi_internal_qman_info {
  *                  Multi MSI is possible only with IOMMU enabled.
  * @mmu_cache_inv_pi: PI for MMU cache invalidation flow. The H/W expects an
  *                    8-bit value so use u8.
+ * @device_cpu_is_halted: Flag to indicate whether the device CPU was already
+ *                        halted. We can't halt it again because the COMMS
+ *                        protocol will throw an error. Relevant only for
+ *                        cases where Linux was not loaded to device CPU
  */
 struct gaudi_device {
 	int (*cpucp_info_get)(struct hl_device *hdev);
@@ -335,6 +339,7 @@ struct gaudi_device {
 	u32				hw_cap_initialized;
 	u8				multi_msi_mode;
 	u8				mmu_cache_inv_pi;
+	u8				device_cpu_is_halted;
 };
 
 void gaudi_init_security(struct hl_device *hdev);
-- 
2.25.1


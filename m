Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3483AE40B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 09:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhFUH0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 03:26:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230215AbhFUH0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 03:26:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F73B61026;
        Mon, 21 Jun 2021 07:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624260258;
        bh=oH9pOtQndgOlQi+kOSy0dhSqijTkGboOKdHfahILkyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X+ScQCz5LRHnHKtvYxuqh9bf9ExE7Q7nHJRFgoBJGh/VMgRuCFsOiY7T7v2WKYT7U
         fmnPJ2htdf1zmzUrmywXTwD723mNJgywRFKU0Cn/ViBCztQjRNITvbdFss61ZJwnkl
         KDiYKOm42JKnqw7EN2WUDiljV9UXSoSpwFTBDz0lXWni1wTY2oIlHD04/yvswp4V/a
         9OZNPkPnGNMjlzHsVA8ccDWaJF4d7OcI+41o1qzYeEZfWVzkU36W6wHNcx9r5LKa0c
         oMTqJLfJJGPhQ4rUp02hmwGYtUvppPxnZRVR4WTzgoWVFC+BUXkN25YNqk54n5ae/Z
         OEUHebC3q8s+g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Koby Elbaz <kelbaz@habana.ai>
Subject: [PATCH 5/5] habanalabs/gaudi: refactor hard-reset related code
Date:   Mon, 21 Jun 2021 10:24:06 +0300
Message-Id: <20210621072406.5421-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210621072406.5421-1-ogabbay@kernel.org>
References: <20210621072406.5421-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Koby Elbaz <kelbaz@habana.ai>

There is code related to hard-reset, which is done in gaudi specific
code. However, this code can be used by future ASICs and therefore it
is better to move it to the common code section.

Signed-off-by: Koby Elbaz <kelbaz@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 41 +++++++++++++++++
 drivers/misc/habanalabs/common/habanalabs.h  |  9 ++++
 drivers/misc/habanalabs/gaudi/gaudi.c        | 48 +++-----------------
 drivers/misc/habanalabs/gaudi/gaudiP.h       |  5 --
 4 files changed, 56 insertions(+), 47 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index ce87053d4fde..2e4d04ec6b53 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -972,6 +972,47 @@ int hl_fw_cpucp_power_get(struct hl_device *hdev, u64 *power)
 	return rc;
 }
 
+void hl_fw_ask_hard_reset_without_linux(struct hl_device *hdev)
+{
+	struct static_fw_load_mgr *static_loader =
+			&hdev->fw_loader.static_loader;
+	int rc;
+
+	if (hdev->asic_prop.dynamic_fw_load) {
+		rc = hl_fw_dynamic_send_protocol_cmd(hdev, &hdev->fw_loader,
+				COMMS_RST_DEV, 0, false,
+				hdev->fw_loader.cpu_timeout);
+		if (rc)
+			dev_warn(hdev->dev, "Failed sending COMMS_RST_DEV\n");
+	} else {
+		WREG32(static_loader->kmd_msg_to_cpu_reg, KMD_MSG_RST_DEV);
+	}
+}
+
+void hl_fw_ask_halt_machine_without_linux(struct hl_device *hdev)
+{
+	struct static_fw_load_mgr *static_loader =
+			&hdev->fw_loader.static_loader;
+	int rc;
+
+	if (hdev->device_cpu_is_halted)
+		return;
+
+	/* Stop device CPU to make sure nothing bad happens */
+	if (hdev->asic_prop.dynamic_fw_load) {
+		rc = hl_fw_dynamic_send_protocol_cmd(hdev, &hdev->fw_loader,
+				COMMS_GOTO_WFE, 0, true,
+				hdev->fw_loader.cpu_timeout);
+		if (rc)
+			dev_warn(hdev->dev, "Failed sending COMMS_GOTO_WFE\n");
+	} else {
+		WREG32(static_loader->kmd_msg_to_cpu_reg, KMD_MSG_GOTO_WFE);
+		msleep(static_loader->cpu_reset_wait_msec);
+	}
+
+	hdev->device_cpu_is_halted = true;
+}
+
 static void detect_cpu_boot_status(struct hl_device *hdev, u32 status)
 {
 	/* Some of the status codes below are deprecated in newer f/w
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 98aa8524a6a6..6b3cdd7e068a 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -894,6 +894,7 @@ struct pci_mem_region {
  * @preboot_version_offset_reg: SRAM offset to preboot version register
  * @boot_fit_version_offset_reg: SRAM offset to boot fit version register
  * @sram_offset_mask: mask for getting offset into the SRAM
+ * @cpu_reset_wait_msec: used when setting WFE via kmd_msg_to_cpu_reg
  */
 struct static_fw_load_mgr {
 	u64 preboot_version_max_off;
@@ -908,6 +909,7 @@ struct static_fw_load_mgr {
 	u32 preboot_version_offset_reg;
 	u32 boot_fit_version_offset_reg;
 	u32 sram_offset_mask;
+	u32 cpu_reset_wait_msec;
 };
 
 /**
@@ -2199,6 +2201,10 @@ struct hl_mmu_funcs {
  *                    triggered, and cleared after it is shared with preboot.
  * @skip_reset_on_timeout: Skip device reset if CS has timed out, wait for it to
  *                         complete instead.
+ * @device_cpu_is_halted: Flag to indicate whether the device CPU was already
+ *                        halted. We can't halt it again because the COMMS
+ *                        protocol will throw an error. Relevant only for
+ *                        cases where Linux was not loaded to device CPU
  */
 struct hl_device {
 	struct pci_dev			*pdev;
@@ -2315,6 +2321,7 @@ struct hl_device {
 	u8				supports_staged_submission;
 	u8				curr_reset_cause;
 	u8				skip_reset_on_timeout;
+	u8				device_cpu_is_halted;
 
 	/* Parameters for bring-up */
 	u64				nic_ports_mask;
@@ -2596,6 +2603,8 @@ int get_used_pll_index(struct hl_device *hdev, u32 input_pll_index,
 int hl_fw_cpucp_pll_info_get(struct hl_device *hdev, u32 pll_index,
 		u16 *pll_freq_arr);
 int hl_fw_cpucp_power_get(struct hl_device *hdev, u64 *power);
+void hl_fw_ask_hard_reset_without_linux(struct hl_device *hdev);
+void hl_fw_ask_halt_machine_without_linux(struct hl_device *hdev);
 int hl_fw_init_cpu(struct hl_device *hdev);
 int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
 				u32 sts_boot_dev_sts0_reg,
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 82d5613f291b..aa8a0ca5aca2 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1934,45 +1934,6 @@ static void gaudi_disable_msi(struct hl_device *hdev)
 	gaudi->hw_cap_initialized &= ~HW_CAP_MSI;
 }
 
-static void gaudi_ask_hard_reset_without_linux(struct hl_device *hdev)
-{
-	int rc;
-
-	if (hdev->asic_prop.dynamic_fw_load) {
-		rc = hl_fw_dynamic_send_protocol_cmd(hdev, &hdev->fw_loader,
-				COMMS_RST_DEV, 0, false,
-				hdev->fw_loader.cpu_timeout);
-		if (rc)
-			dev_warn(hdev->dev, "Failed sending COMMS_RST_DEV\n");
-	} else {
-		WREG32(mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU, KMD_MSG_RST_DEV);
-	}
-}
-
-static void gaudi_ask_halt_machine_without_linux(struct hl_device *hdev)
-{
-	struct gaudi_device *gaudi = hdev->asic_specific;
-	int rc;
-
-	if (gaudi && gaudi->device_cpu_is_halted)
-		return;
-
-	/* Stop device CPU to make sure nothing bad happens */
-	if (hdev->asic_prop.dynamic_fw_load) {
-		rc = hl_fw_dynamic_send_protocol_cmd(hdev, &hdev->fw_loader,
-				COMMS_GOTO_WFE, 0, true,
-				hdev->fw_loader.cpu_timeout);
-		if (rc)
-			dev_warn(hdev->dev, "Failed sending COMMS_GOTO_WFE\n");
-	} else {
-		WREG32(mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU, KMD_MSG_GOTO_WFE);
-		msleep(GAUDI_CPU_RESET_WAIT_MSEC);
-	}
-
-	if (gaudi)
-		gaudi->device_cpu_is_halted = true;
-}
-
 static void gaudi_init_scrambler_sram(struct hl_device *hdev)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
@@ -3859,6 +3820,9 @@ static void gaudi_init_static_firmware_loader(struct hl_device *hdev)
 	static_loader->preboot_version_offset_reg = mmPREBOOT_VER_OFFSET;
 	static_loader->boot_fit_version_offset_reg = mmUBOOT_VER_OFFSET;
 	static_loader->sram_offset_mask = ~(lower_32_bits(SRAM_BASE_ADDR));
+	static_loader->cpu_reset_wait_msec = hdev->pldm ?
+			GAUDI_PLDM_RESET_WAIT_MSEC :
+			GAUDI_CPU_RESET_WAIT_MSEC;
 }
 
 static void gaudi_init_firmware_loader(struct hl_device *hdev)
@@ -4151,9 +4115,9 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 			gaudi_irq_map_table[GAUDI_EVENT_HALT_MACHINE].cpu_id);
 	} else {
 		if (hdev->asic_prop.hard_reset_done_by_fw)
-			gaudi_ask_hard_reset_without_linux(hdev);
+			hl_fw_ask_hard_reset_without_linux(hdev);
 		else
-			gaudi_ask_halt_machine_without_linux(hdev);
+			hl_fw_ask_halt_machine_without_linux(hdev);
 	}
 
 	if (driver_performs_reset) {
@@ -4228,7 +4192,7 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 
 		memset(gaudi->events_stat, 0, sizeof(gaudi->events_stat));
 
-		gaudi->device_cpu_is_halted = false;
+		hdev->device_cpu_is_halted = false;
 	}
 }
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index b23336af191e..957bf3720f70 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -315,10 +315,6 @@ struct gaudi_internal_qman_info {
  *                  Multi MSI is possible only with IOMMU enabled.
  * @mmu_cache_inv_pi: PI for MMU cache invalidation flow. The H/W expects an
  *                    8-bit value so use u8.
- * @device_cpu_is_halted: Flag to indicate whether the device CPU was already
- *                        halted. We can't halt it again because the COMMS
- *                        protocol will throw an error. Relevant only for
- *                        cases where Linux was not loaded to device CPU
  */
 struct gaudi_device {
 	int (*cpucp_info_get)(struct hl_device *hdev);
@@ -340,7 +336,6 @@ struct gaudi_device {
 	u32				hw_cap_initialized;
 	u8				multi_msi_mode;
 	u8				mmu_cache_inv_pi;
-	u8				device_cpu_is_halted;
 };
 
 void gaudi_init_security(struct hl_device *hdev);
-- 
2.25.1


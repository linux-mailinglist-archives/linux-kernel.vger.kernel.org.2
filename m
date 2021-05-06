Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BEE374FA0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 08:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbhEFGyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 02:54:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232869AbhEFGyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 02:54:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F42116112D;
        Thu,  6 May 2021 06:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620284017;
        bh=RmcFRot4eGZ2uxhKd4mU9mQ8nlMCJ815wm7ofyLZ+6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h7bPa1bPhUqohYBMiie3cZ7DDbBlD2lprG9RLY0HimkwBxvwbyfwdjsN8HT2/OJAX
         NNepIE16ECqDsGuGYUiWGX89rxcW+pKV06IIL9gVq8mVkCdgMfLUg65MIX0QP9Z1yS
         ZfcbpF+bjEumY+IEf7wGKvrvJnIsKuy+poy4NxtU8dixif0y3mxaZ9PS28Nbln9bzu
         zIhYipGpEIE+rSCSbMXk9+9gg/BUVEwDDe/EPCtQkEr0nyELLM83H+EMzaRX2E8dHL
         ySzwVDyn7Isbm0zbYklfe7F+OdNat+nL3/NrhY9xfA2rPSUlydeJ59H0TTm6oS33ke
         mSv8GFswEBNlg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 2/3] habanalabs: read f/w's 2-nd sts and err registers
Date:   Thu,  6 May 2021 09:53:29 +0300
Message-Id: <20210506065330.9626-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210506065330.9626-1-ogabbay@kernel.org>
References: <20210506065330.9626-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

Maintain both STS1 and ERR1 registers used for status communication
with F/W.
Those are not maintained as we currently have less than 31
statuses/error defined and so LKD did not refer to those register.
The reason to read them now is to try to support future f/w versions
with current driver.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 287 +++++++++++++------
 drivers/misc/habanalabs/common/habanalabs.h  |  70 +++--
 drivers/misc/habanalabs/gaudi/gaudi.c        |  43 +--
 drivers/misc/habanalabs/goya/goya.c          |  24 +-
 4 files changed, 291 insertions(+), 133 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index ad9bfa096bf9..8fdace889b07 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -146,6 +146,7 @@ int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 				u16 len, u32 timeout, u64 *result)
 {
 	struct hl_hw_queue *queue = &hdev->kernel_queues[hw_queue_id];
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct cpucp_packet *pkt;
 	dma_addr_t pkt_dma_addr;
 	u32 tmp, expected_ack_val;
@@ -180,8 +181,9 @@ int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 		goto out;
 	}
 
-	if (hdev->asic_prop.fw_app_security_map &
-			CPU_BOOT_DEV_STS0_PKT_PI_ACK_EN)
+	if (prop->fw_cpu_boot_dev_sts0_valid &&
+				(prop->fw_app_cpu_boot_dev_sts0 &
+					CPU_BOOT_DEV_STS0_PKT_PI_ACK_EN))
 		expected_ack_val = queue->pi;
 	else
 		expected_ack_val = CPUCP_PACKET_FENCE_VAL;
@@ -344,24 +346,13 @@ int hl_fw_send_heartbeat(struct hl_device *hdev)
 	return rc;
 }
 
-static int fw_read_errors(struct hl_device *hdev, u32 boot_err0_reg,
-		u32 cpu_security_boot_status_reg)
+static bool fw_report_boot_dev0(struct hl_device *hdev, u32 err_val,
+								u32 sts_val)
 {
-	u32 err_val, security_val;
 	bool err_exists = false;
 
-	/* Some of the firmware status codes are deprecated in newer f/w
-	 * versions. In those versions, the errors are reported
-	 * in different registers. Therefore, we need to check those
-	 * registers and print the exact errors. Moreover, there
-	 * may be multiple errors, so we need to report on each error
-	 * separately. Some of the error codes might indicate a state
-	 * that is not an error per-se, but it is an error in production
-	 * environment
-	 */
-	err_val = RREG32(boot_err0_reg);
 	if (!(err_val & CPU_BOOT_ERR0_ENABLED))
-		return 0;
+		return false;
 
 	if (err_val & CPU_BOOT_ERR0_DRAM_INIT_FAIL) {
 		dev_err(hdev->dev,
@@ -432,6 +423,20 @@ static int fw_read_errors(struct hl_device *hdev, u32 boot_err0_reg,
 		err_exists = true;
 	}
 
+	if (err_val & CPU_BOOT_ERR0_PRI_IMG_VER_FAIL) {
+		dev_warn(hdev->dev,
+			"Device boot warning - Failed to load preboot primary image\n");
+		/* This is a warning so we don't want it to disable the
+		 * device as we have a secondary preboot image
+		 */
+		err_val &= ~CPU_BOOT_ERR0_PRI_IMG_VER_FAIL;
+	}
+
+	if (err_val & CPU_BOOT_ERR0_SEC_IMG_VER_FAIL) {
+		dev_err(hdev->dev, "Device boot error - Failed to load preboot secondary image\n");
+		err_exists = true;
+	}
+
 	if (err_val & CPU_BOOT_ERR0_PLL_FAIL) {
 		dev_err(hdev->dev, "Device boot error - PLL failure\n");
 		err_exists = true;
@@ -443,28 +448,89 @@ static int fw_read_errors(struct hl_device *hdev, u32 boot_err0_reg,
 		err_val &= ~CPU_BOOT_ERR0_DEVICE_UNUSABLE_FAIL;
 	}
 
-	security_val = RREG32(cpu_security_boot_status_reg);
-	if (security_val & CPU_BOOT_DEV_STS0_ENABLED)
-		dev_dbg(hdev->dev, "Device security status %#x\n",
-				security_val);
+	if (sts_val & CPU_BOOT_DEV_STS0_ENABLED)
+		dev_dbg(hdev->dev, "Device status0 %#x\n", sts_val);
 
 	if (!err_exists && (err_val & ~CPU_BOOT_ERR0_ENABLED)) {
 		dev_err(hdev->dev,
-			"Device boot error - unknown error 0x%08x\n",
-			err_val);
+			"Device boot error - unknown ERR0 error 0x%08x\n", err_val);
 		err_exists = true;
 	}
 
+	/* return error only if it's in the predefined mask */
 	if (err_exists && ((err_val & ~CPU_BOOT_ERR0_ENABLED) &
 				lower_32_bits(hdev->boot_error_status_mask)))
+		return true;
+
+	return false;
+}
+
+/* placeholder for ERR1 as no errors defined there yet */
+static bool fw_report_boot_dev1(struct hl_device *hdev, u32 err_val,
+								u32 sts_val)
+{
+	/*
+	 * keep this variable to preserve the logic of the function.
+	 * this way it would require less modifications when error will be
+	 * added to DEV_ERR1
+	 */
+	bool err_exists = false;
+
+	if (!(err_val & CPU_BOOT_ERR1_ENABLED))
+		return false;
+
+	if (sts_val & CPU_BOOT_DEV_STS1_ENABLED)
+		dev_dbg(hdev->dev, "Device status1 %#x\n", sts_val);
+
+	if (!err_exists && (err_val & ~CPU_BOOT_ERR1_ENABLED)) {
+		dev_err(hdev->dev,
+			"Device boot error - unknown ERR1 error 0x%08x\n",
+								err_val);
+		err_exists = true;
+	}
+
+	/* return error only if it's in the predefined mask */
+	if (err_exists && ((err_val & ~CPU_BOOT_ERR1_ENABLED) &
+				upper_32_bits(hdev->boot_error_status_mask)))
+		return true;
+
+	return false;
+}
+
+static int fw_read_errors(struct hl_device *hdev, u32 boot_err0_reg,
+				u32 boot_err1_reg, u32 cpu_boot_dev_status0_reg,
+				u32 cpu_boot_dev_status1_reg)
+{
+	u32 err_val, status_val;
+	bool err_exists = false;
+
+	/* Some of the firmware status codes are deprecated in newer f/w
+	 * versions. In those versions, the errors are reported
+	 * in different registers. Therefore, we need to check those
+	 * registers and print the exact errors. Moreover, there
+	 * may be multiple errors, so we need to report on each error
+	 * separately. Some of the error codes might indicate a state
+	 * that is not an error per-se, but it is an error in production
+	 * environment
+	 */
+	err_val = RREG32(boot_err0_reg);
+	status_val = RREG32(cpu_boot_dev_status0_reg);
+	err_exists = fw_report_boot_dev0(hdev, err_val, status_val);
+
+	err_val = RREG32(boot_err1_reg);
+	status_val = RREG32(cpu_boot_dev_status1_reg);
+	err_exists |= fw_report_boot_dev1(hdev, err_val, status_val);
+
+	if (err_exists)
 		return -EIO;
 
 	return 0;
 }
 
 int hl_fw_cpucp_info_get(struct hl_device *hdev,
-			u32 cpu_security_boot_status_reg,
-			u32 boot_err0_reg)
+				u32 sts_boot_dev_sts0_reg,
+				u32 sts_boot_dev_sts1_reg, u32 boot_err0_reg,
+				u32 boot_err1_reg)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct cpucp_packet pkt = {};
@@ -498,7 +564,8 @@ int hl_fw_cpucp_info_get(struct hl_device *hdev,
 		goto out;
 	}
 
-	rc = fw_read_errors(hdev, boot_err0_reg, cpu_security_boot_status_reg);
+	rc = fw_read_errors(hdev, boot_err0_reg, boot_err1_reg,
+				sts_boot_dev_sts0_reg, sts_boot_dev_sts1_reg);
 	if (rc) {
 		dev_err(hdev->dev, "Errors in device boot\n");
 		goto out;
@@ -516,9 +583,13 @@ int hl_fw_cpucp_info_get(struct hl_device *hdev,
 	}
 
 	/* Read FW application security bits again */
-	if (hdev->asic_prop.fw_security_status_valid)
-		hdev->asic_prop.fw_app_security_map =
-				RREG32(cpu_security_boot_status_reg);
+	if (hdev->asic_prop.fw_cpu_boot_dev_sts0_valid)
+		hdev->asic_prop.fw_app_cpu_boot_dev_sts0 =
+						RREG32(sts_boot_dev_sts0_reg);
+
+	if (hdev->asic_prop.fw_cpu_boot_dev_sts1_valid)
+		hdev->asic_prop.fw_app_cpu_boot_dev_sts1 =
+						RREG32(sts_boot_dev_sts1_reg);
 
 out:
 	hdev->asic_funcs->cpu_accessible_dma_pool_free(hdev,
@@ -581,13 +652,15 @@ static int hl_fw_send_msi_info_msg(struct hl_device *hdev)
 }
 
 int hl_fw_cpucp_handshake(struct hl_device *hdev,
-			u32 cpu_security_boot_status_reg,
-			u32 boot_err0_reg)
+				u32 sts_boot_dev_sts0_reg,
+				u32 sts_boot_dev_sts1_reg, u32 boot_err0_reg,
+				u32 boot_err1_reg)
 {
 	int rc;
 
-	rc = hl_fw_cpucp_info_get(hdev, cpu_security_boot_status_reg,
-					boot_err0_reg);
+	rc = hl_fw_cpucp_info_get(hdev, sts_boot_dev_sts0_reg,
+					sts_boot_dev_sts1_reg, boot_err0_reg,
+					boot_err1_reg);
 	if (rc)
 		return rc;
 
@@ -722,8 +795,8 @@ int get_used_pll_index(struct hl_device *hdev, u32 input_pll_index,
 	bool dynamic_pll;
 	int fw_pll_idx;
 
-	dynamic_pll = prop->fw_security_status_valid &&
-		(prop->fw_app_security_map & CPU_BOOT_DEV_STS0_DYN_PLL_EN);
+	dynamic_pll = prop->fw_cpu_boot_dev_sts0_valid &&
+		(prop->fw_app_cpu_boot_dev_sts0 & CPU_BOOT_DEV_STS0_DYN_PLL_EN);
 
 	if (!dynamic_pll) {
 		/*
@@ -866,8 +939,10 @@ static void detect_cpu_boot_status(struct hl_device *hdev, u32 status)
 
 static int hl_fw_read_preboot_caps(struct hl_device *hdev,
 					u32 cpu_boot_status_reg,
-					u32 cpu_boot_caps_reg,
-					u32 boot_err0_reg, u32 timeout)
+					u32 sts_boot_dev_sts0_reg,
+					u32 sts_boot_dev_sts1_reg,
+					u32 boot_err0_reg, u32 boot_err1_reg,
+					u32 timeout)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	u32 status;
@@ -902,15 +977,20 @@ static int hl_fw_read_preboot_caps(struct hl_device *hdev,
 		 * of reading specific errors
 		 */
 		if (status != -1)
-			fw_read_errors(hdev, boot_err0_reg,
-					cpu_boot_status_reg);
+			fw_read_errors(hdev, boot_err0_reg, boot_err1_reg,
+							sts_boot_dev_sts0_reg,
+							sts_boot_dev_sts1_reg);
 		return -EIO;
 	}
 
-	prop->fw_preboot_caps_map = RREG32(cpu_boot_caps_reg);
+	prop->fw_preboot_cpu_boot_dev_sts0 = RREG32(sts_boot_dev_sts0_reg);
+	prop->fw_preboot_cpu_boot_dev_sts1 = RREG32(sts_boot_dev_sts1_reg);
 
-	prop->dynamic_fw_load = !!(prop->fw_preboot_caps_map &
+	if (prop->fw_preboot_cpu_boot_dev_sts0 & CPU_BOOT_DEV_STS0_ENABLED)
+		prop->dynamic_fw_load = !!(prop->fw_preboot_cpu_boot_dev_sts0 &
 						CPU_BOOT_DEV_STS0_FW_LD_COM_EN);
+	else
+		prop->dynamic_fw_load = 0;
 
 	/* initialize FW loader once we know what load protocol is used */
 	hdev->asic_funcs->init_firmware_loader(hdev);
@@ -977,9 +1057,10 @@ static int hl_fw_static_read_device_fw_version(struct hl_device *hdev,
 static void hl_fw_preboot_update_state(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u32 preboot_caps;
+	u32 cpu_boot_dev_sts0, cpu_boot_dev_sts1;
 
-	preboot_caps = prop->fw_preboot_caps_map;
+	cpu_boot_dev_sts0 = prop->fw_preboot_cpu_boot_dev_sts0;
+	cpu_boot_dev_sts1 = prop->fw_preboot_cpu_boot_dev_sts1;
 
 	/* We read security status multiple times during boot:
 	 * 1. preboot - a. Check whether the security status bits are valid
@@ -994,23 +1075,30 @@ static void hl_fw_preboot_update_state(struct hl_device *hdev)
 	 * Check security status bit (CPU_BOOT_DEV_STS0_ENABLED), if it is set
 	 * check security enabled bit (CPU_BOOT_DEV_STS0_SECURITY_EN)
 	 */
-	if (preboot_caps & CPU_BOOT_DEV_STS0_ENABLED) {
-		prop->fw_security_status_valid = 1;
+	if (cpu_boot_dev_sts0 & CPU_BOOT_DEV_STS0_ENABLED) {
+		prop->fw_cpu_boot_dev_sts0_valid = 1;
 
 		/* FW security should be derived from PCI ID, we keep this
 		 * check for backward compatibility
 		 */
-		if (preboot_caps & CPU_BOOT_DEV_STS0_SECURITY_EN)
+		if (cpu_boot_dev_sts0 & CPU_BOOT_DEV_STS0_SECURITY_EN)
 			prop->fw_security_disabled = false;
 
-		if (preboot_caps & CPU_BOOT_DEV_STS0_FW_HARD_RST_EN)
+		if (cpu_boot_dev_sts0 & CPU_BOOT_DEV_STS0_FW_HARD_RST_EN)
 			prop->hard_reset_done_by_fw = true;
 	} else {
-		prop->fw_security_status_valid = 0;
+		prop->fw_cpu_boot_dev_sts0_valid = 0;
 	}
 
-	dev_dbg(hdev->dev, "Firmware preboot security status %#x\n",
-			preboot_caps);
+	/* place holder for STS1 as no statuses are defined yet */
+	prop->fw_cpu_boot_dev_sts1_valid =
+			!!(cpu_boot_dev_sts1 & CPU_BOOT_DEV_STS1_ENABLED);
+
+	dev_dbg(hdev->dev, "Firmware preboot boot device status0 %#x\n",
+							cpu_boot_dev_sts0);
+
+	dev_dbg(hdev->dev, "Firmware preboot boot device status1 %#x\n",
+							cpu_boot_dev_sts1);
 
 	dev_dbg(hdev->dev, "Firmware preboot hard-reset is %s\n",
 			prop->hard_reset_done_by_fw ? "enabled" : "disabled");
@@ -1019,9 +1107,7 @@ static void hl_fw_preboot_update_state(struct hl_device *hdev)
 			prop->fw_security_disabled ? "disabled" : "enabled");
 }
 
-static int hl_fw_static_read_preboot_status(struct hl_device *hdev,
-		u32 cpu_boot_status_reg, u32 cpu_security_boot_status_reg,
-		u32 boot_err0_reg, u32 timeout)
+static int hl_fw_static_read_preboot_status(struct hl_device *hdev)
 {
 	int rc;
 
@@ -1035,8 +1121,9 @@ static int hl_fw_static_read_preboot_status(struct hl_device *hdev,
 }
 
 int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
-		u32 cpu_boot_caps_reg, u32 boot_err0_reg,
-		u32 timeout)
+				u32 sts_boot_dev_sts0_reg,
+				u32 sts_boot_dev_sts1_reg, u32 boot_err0_reg,
+				u32 boot_err1_reg, u32 timeout)
 {
 	int rc;
 
@@ -1052,8 +1139,9 @@ int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
 	 * read the boot caps register
 	 */
 	rc = hl_fw_read_preboot_caps(hdev, cpu_boot_status_reg,
-				cpu_boot_caps_reg, boot_err0_reg,
-				timeout);
+					sts_boot_dev_sts0_reg,
+					sts_boot_dev_sts1_reg, boot_err0_reg,
+					boot_err1_reg, timeout);
 	if (rc)
 		return rc;
 
@@ -1061,9 +1149,7 @@ int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
 	if (hdev->asic_prop.dynamic_fw_load)
 		return 0;
 
-	return hl_fw_static_read_preboot_status(hdev, cpu_boot_status_reg,
-				cpu_boot_caps_reg, boot_err0_reg,
-				timeout);
+	return hl_fw_static_read_preboot_status(hdev);
 }
 
 /* associate string with COMM status */
@@ -1609,30 +1695,37 @@ static int hl_fw_dynamic_copy_image(struct hl_device *hdev,
  *                               is loaded
  *
  * @hdev: pointer to the habanalabs device structure
- * @cpu_security_boot_status_reg: register holding security status props
+ * @cpu_boot_dev_sts0_reg: register holding CPU boot dev status 0
+ * @cpu_boot_dev_sts1_reg: register holding CPU boot dev status 1
  *
  * @return 0 on success, otherwise non-zero error code
  */
 static void hl_fw_boot_fit_update_state(struct hl_device *hdev,
-					u32 cpu_security_boot_status_reg)
+						u32 cpu_boot_dev_sts0_reg,
+						u32 cpu_boot_dev_sts1_reg)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 
 	/* Clear reset status since we need to read it again from boot CPU */
 	prop->hard_reset_done_by_fw = false;
 
-	/* Read boot_cpu security bits */
-	if (prop->fw_security_status_valid) {
-		prop->fw_boot_cpu_security_map =
-				RREG32(cpu_security_boot_status_reg);
+	/* Read boot_cpu status bits */
+	if (prop->fw_cpu_boot_dev_sts0_valid) {
+		prop->fw_bootfit_cpu_boot_dev_sts0 = RREG32(cpu_boot_dev_sts0_reg);
 
-		if (prop->fw_boot_cpu_security_map &
+		if (prop->fw_bootfit_cpu_boot_dev_sts0 &
 				CPU_BOOT_DEV_STS0_FW_HARD_RST_EN)
 			prop->hard_reset_done_by_fw = true;
 
-		dev_dbg(hdev->dev,
-			"Firmware boot CPU security status %#x\n",
-			prop->fw_boot_cpu_security_map);
+		dev_dbg(hdev->dev, "Firmware boot CPU status0 %#x\n",
+					prop->fw_bootfit_cpu_boot_dev_sts0);
+	}
+
+	if (prop->fw_cpu_boot_dev_sts1_valid) {
+		prop->fw_bootfit_cpu_boot_dev_sts1 = RREG32(cpu_boot_dev_sts1_reg);
+
+		dev_dbg(hdev->dev, "Firmware boot CPU status1 %#x\n",
+					prop->fw_bootfit_cpu_boot_dev_sts1);
 	}
 
 	dev_dbg(hdev->dev, "Firmware boot CPU hard-reset is %s\n",
@@ -1696,7 +1789,8 @@ static int hl_fw_dynamic_load_image(struct hl_device *hdev,
 
 		dyn_regs = &fw_loader->dynamic_loader.comm_desc.cpu_dyn_regs;
 		hl_fw_boot_fit_update_state(hdev,
-					le32_to_cpu(dyn_regs->cpu_boot_status));
+				le32_to_cpu(dyn_regs->cpu_boot_dev_sts0),
+				le32_to_cpu(dyn_regs->cpu_boot_dev_sts1));
 	} else {
 		/* update state during preboot handshake */
 		hl_fw_preboot_update_state(hdev);
@@ -1782,11 +1876,14 @@ static int hl_fw_dynamic_wait_for_linux_active(struct hl_device *hdev,
  *
  *
  * @hdev: pointer to the habanalabs device structure
+ * @cpu_boot_dev_sts0_reg: register holding CPU boot dev status 0
+ * @cpu_boot_dev_sts1_reg: register holding CPU boot dev status 1
  *
  * @return 0 on success, otherwise non-zero error code
  */
 static void hl_fw_linux_update_state(struct hl_device *hdev,
-						u32 cpu_boot_status_reg)
+						u32 cpu_boot_dev_sts0_reg,
+						u32 cpu_boot_dev_sts1_reg)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 
@@ -1794,17 +1891,26 @@ static void hl_fw_linux_update_state(struct hl_device *hdev,
 	prop->hard_reset_done_by_fw = false;
 
 	/* Read FW application security bits */
-	if (prop->fw_security_status_valid) {
-		prop->fw_app_security_map =
-				RREG32(cpu_boot_status_reg);
+	if (prop->fw_cpu_boot_dev_sts0_valid) {
+		prop->fw_app_cpu_boot_dev_sts0 =
+				RREG32(cpu_boot_dev_sts0_reg);
 
-		if (prop->fw_app_security_map &
+		if (prop->fw_app_cpu_boot_dev_sts0 &
 				CPU_BOOT_DEV_STS0_FW_HARD_RST_EN)
 			prop->hard_reset_done_by_fw = true;
 
 		dev_dbg(hdev->dev,
-			"Firmware application CPU security status %#x\n",
-			prop->fw_app_security_map);
+			"Firmware application CPU status0 %#x\n",
+			prop->fw_app_cpu_boot_dev_sts0);
+	}
+
+	if (prop->fw_cpu_boot_dev_sts1_valid) {
+		prop->fw_app_cpu_boot_dev_sts1 =
+				RREG32(cpu_boot_dev_sts1_reg);
+
+		dev_dbg(hdev->dev,
+			"Firmware application CPU status1 %#x\n",
+			prop->fw_app_cpu_boot_dev_sts1);
 	}
 
 	dev_dbg(hdev->dev, "Firmware application CPU hard-reset is %s\n",
@@ -1899,13 +2005,16 @@ static int hl_fw_dynamic_init_cpu(struct hl_device *hdev,
 	if (rc)
 		goto protocol_err;
 
-	hl_fw_linux_update_state(hdev, le32_to_cpu(dyn_regs->cpu_boot_status));
+	hl_fw_linux_update_state(hdev, le32_to_cpu(dyn_regs->cpu_boot_dev_sts0),
+				le32_to_cpu(dyn_regs->cpu_boot_dev_sts1));
 
 	return 0;
 
 protocol_err:
 	fw_read_errors(hdev, le32_to_cpu(dyn_regs->cpu_boot_err0),
-					le32_to_cpu(dyn_regs->cpu_boot_status));
+				le32_to_cpu(dyn_regs->cpu_boot_err1),
+				le32_to_cpu(dyn_regs->cpu_boot_dev_sts0),
+				le32_to_cpu(dyn_regs->cpu_boot_dev_sts1));
 	return rc;
 }
 
@@ -1921,8 +2030,9 @@ static int hl_fw_static_init_cpu(struct hl_device *hdev,
 					struct fw_load_mgr *fw_loader)
 {
 	u32 cpu_msg_status_reg, cpu_timeout, msg_to_cpu_reg, status;
-	u32 cpu_boot_status_reg, cpu_security_boot_status_reg;
+	u32 cpu_boot_dev_status0_reg, cpu_boot_dev_status1_reg;
 	struct static_fw_load_mgr *static_loader;
+	u32 cpu_boot_status_reg;
 	int rc;
 
 	if (!(hdev->fw_components & FW_TYPE_BOOT_CPU))
@@ -1935,7 +2045,8 @@ static int hl_fw_static_init_cpu(struct hl_device *hdev,
 	static_loader = &fw_loader->static_loader;
 	cpu_msg_status_reg = static_loader->cpu_cmd_status_to_host_reg;
 	msg_to_cpu_reg = static_loader->kmd_msg_to_cpu_reg;
-	cpu_security_boot_status_reg = static_loader->cpu_boot_dev_status_reg;
+	cpu_boot_dev_status0_reg = static_loader->cpu_boot_dev_status0_reg;
+	cpu_boot_dev_status1_reg = static_loader->cpu_boot_dev_status1_reg;
 	cpu_boot_status_reg = static_loader->cpu_boot_status_reg;
 
 	dev_info(hdev->dev, "Going to wait for device boot (up to %lds)\n",
@@ -2001,7 +2112,8 @@ static int hl_fw_static_init_cpu(struct hl_device *hdev,
 	hl_fw_static_read_device_fw_version(hdev, FW_COMP_BOOT_FIT);
 
 	/* update state according to boot stage */
-	hl_fw_boot_fit_update_state(hdev, cpu_security_boot_status_reg);
+	hl_fw_boot_fit_update_state(hdev, cpu_boot_dev_status0_reg,
+						cpu_boot_dev_status1_reg);
 
 	if (rc) {
 		detect_cpu_boot_status(hdev, status);
@@ -2072,17 +2184,22 @@ static int hl_fw_static_init_cpu(struct hl_device *hdev,
 	}
 
 	rc = fw_read_errors(hdev, fw_loader->static_loader.boot_err0_reg,
-					cpu_security_boot_status_reg);
+					fw_loader->static_loader.boot_err1_reg,
+					cpu_boot_dev_status0_reg,
+					cpu_boot_dev_status1_reg);
 	if (rc)
 		return rc;
 
-	hl_fw_linux_update_state(hdev, cpu_security_boot_status_reg);
+	hl_fw_linux_update_state(hdev, cpu_boot_dev_status0_reg,
+						cpu_boot_dev_status1_reg);
 
 	return 0;
 
 out:
 	fw_read_errors(hdev, fw_loader->static_loader.boot_err0_reg,
-					cpu_security_boot_status_reg);
+					fw_loader->static_loader.boot_err1_reg,
+					cpu_boot_dev_status0_reg,
+					cpu_boot_dev_status1_reg);
 
 	return rc;
 }
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index a864fd7f4da7..863f0337883f 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -422,15 +422,24 @@ struct hl_mmu_properties {
  * @cb_pool_cb_size: size of each CB in the CB pool.
  * @max_pending_cs: maximum of concurrent pending command submissions
  * @max_queues: maximum amount of queues in the system
- * @fw_preboot_caps_map: bitmap representation of preboot cpu capabilities
- *                              reported by FW, bit description can be found in
- *                              CPU_BOOT_DEV_STS*
- * @fw_boot_cpu_security_map: bitmap representation of boot cpu security status
- *                            reported by FW, bit description can be found in
- *                            CPU_BOOT_DEV_STS*
- * @fw_app_security_map: bitmap representation of application security status
- *                       reported by FW, bit description can be found in
- *                       CPU_BOOT_DEV_STS*
+ * @fw_preboot_cpu_boot_dev_sts0: bitmap representation of preboot cpu
+ *                                capabilities reported by FW, bit description
+ *                                can be found in CPU_BOOT_DEV_STS0
+ * @fw_preboot_cpu_boot_dev_sts1: bitmap representation of preboot cpu
+ *                                capabilities reported by FW, bit description
+ *                                can be found in CPU_BOOT_DEV_STS1
+ * @fw_bootfit_cpu_boot_dev_sts0: bitmap representation of boot cpu security
+ *                                status reported by FW, bit description can be
+ *                                found in CPU_BOOT_DEV_STS0
+ * @fw_bootfit_cpu_boot_dev_sts1: bitmap representation of boot cpu security
+ *                                status reported by FW, bit description can be
+ *                                found in CPU_BOOT_DEV_STS1
+ * @fw_app_cpu_boot_dev_sts0: bitmap representation of application security
+ *                            status reported by FW, bit description can be
+ *                            found in CPU_BOOT_DEV_STS0
+ * @fw_app_cpu_boot_dev_sts1: bitmap representation of application security
+ *                            status reported by FW, bit description can be
+ *                            found in CPU_BOOT_DEV_STS1
  * @collective_first_sob: first sync object available for collective use
  * @collective_first_mon: first monitor available for collective use
  * @sync_stream_first_sob: first sync object available for sync stream use
@@ -445,8 +454,10 @@ struct hl_mmu_properties {
  * @completion_queues_count: number of completion queues.
  * @fw_security_disabled: true if security measures are disabled in firmware,
  *                        false otherwise
- * @fw_security_status_valid: security status bits are valid and can be fetched
- *                            from BOOT_DEV_STS0
+ * @fw_cpu_boot_dev_sts0_valid: status bits are valid and can be fetched from
+ *                              BOOT_DEV_STS0
+ * @fw_cpu_boot_dev_sts1_valid: status bits are valid and can be fetched from
+ *                              BOOT_DEV_STS1
  * @dram_supports_virtual_memory: is there an MMU towards the DRAM
  * @hard_reset_done_by_fw: true if firmware is handling hard reset flow
  * @num_functional_hbms: number of functional HBMs in each DCORE.
@@ -497,9 +508,12 @@ struct asic_fixed_properties {
 	u32				cb_pool_cb_size;
 	u32				max_pending_cs;
 	u32				max_queues;
-	u32				fw_preboot_caps_map;
-	u32				fw_boot_cpu_security_map;
-	u32				fw_app_security_map;
+	u32				fw_preboot_cpu_boot_dev_sts0;
+	u32				fw_preboot_cpu_boot_dev_sts1;
+	u32				fw_bootfit_cpu_boot_dev_sts0;
+	u32				fw_bootfit_cpu_boot_dev_sts1;
+	u32				fw_app_cpu_boot_dev_sts0;
+	u32				fw_app_cpu_boot_dev_sts1;
 	u16				collective_first_sob;
 	u16				collective_first_mon;
 	u16				sync_stream_first_sob;
@@ -512,7 +526,8 @@ struct asic_fixed_properties {
 	u8				tpc_enabled_mask;
 	u8				completion_queues_count;
 	u8				fw_security_disabled;
-	u8				fw_security_status_valid;
+	u8				fw_cpu_boot_dev_sts0_valid;
+	u8				fw_cpu_boot_dev_sts1_valid;
 	u8				dram_supports_virtual_memory;
 	u8				hard_reset_done_by_fw;
 	u8				num_functional_hbms;
@@ -853,8 +868,10 @@ struct pci_mem_region {
  * @kmd_msg_to_cpu_reg: register address for KDM->CPU messages
  * @cpu_cmd_status_to_host_reg: register address for CPU command status response
  * @cpu_boot_status_reg: boot status register
- * @cpu_boot_dev_status_reg: boot device status register
- * @boot_err0_reg: boot error register
+ * @cpu_boot_dev_status0_reg: boot device status register 0
+ * @cpu_boot_dev_status1_reg: boot device status register 1
+ * @boot_err0_reg: boot error register 0
+ * @boot_err1_reg: boot error register 1
  * @preboot_version_offset_reg: SRAM offset to preboot version register
  * @boot_fit_version_offset_reg: SRAM offset to boot fit version register
  * @sram_offset_mask: mask for getting offset into the SRAM
@@ -865,8 +882,10 @@ struct static_fw_load_mgr {
 	u32 kmd_msg_to_cpu_reg;
 	u32 cpu_cmd_status_to_host_reg;
 	u32 cpu_boot_status_reg;
-	u32 cpu_boot_dev_status_reg;
+	u32 cpu_boot_dev_status0_reg;
+	u32 cpu_boot_dev_status1_reg;
 	u32 boot_err0_reg;
+	u32 boot_err1_reg;
 	u32 preboot_version_offset_reg;
 	u32 boot_fit_version_offset_reg;
 	u32 sram_offset_mask;
@@ -2514,11 +2533,13 @@ void hl_fw_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size,
 					void *vaddr);
 int hl_fw_send_heartbeat(struct hl_device *hdev);
 int hl_fw_cpucp_info_get(struct hl_device *hdev,
-			u32 cpu_security_boot_status_reg,
-			u32 boot_err0_reg);
+				u32 sts_boot_dev_sts0_reg,
+				u32 sts_boot_dev_sts1_reg, u32 boot_err0_reg,
+				u32 boot_err1_reg);
 int hl_fw_cpucp_handshake(struct hl_device *hdev,
-			u32 cpu_security_boot_status_reg,
-			u32 boot_err0_reg);
+				u32 sts_boot_dev_sts0_reg,
+				u32 sts_boot_dev_sts1_reg, u32 boot_err0_reg,
+				u32 boot_err1_reg);
 int hl_fw_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size);
 int hl_fw_cpucp_pci_counters_get(struct hl_device *hdev,
 		struct hl_info_pci_counters *counters);
@@ -2531,8 +2552,9 @@ int hl_fw_cpucp_pll_info_get(struct hl_device *hdev, u32 pll_index,
 int hl_fw_cpucp_power_get(struct hl_device *hdev, u64 *power);
 int hl_fw_init_cpu(struct hl_device *hdev);
 int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
-		u32 cpu_boot_caps_reg, u32 boot_err0_reg,
-		u32 timeout);
+				u32 sts_boot_dev_sts0_reg,
+				u32 sts_boot_dev_sts1_reg, u32 boot_err0_reg,
+				u32 boot_err1_reg, u32 timeout);
 
 int hl_pci_bars_map(struct hl_device *hdev, const char * const name[3],
 			bool is_wc[3]);
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 6c38009d6db7..8619a1524bed 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -546,7 +546,8 @@ static int gaudi_get_fixed_properties(struct hl_device *hdev)
 	for (i = 0 ; i < HL_MAX_DCORES ; i++)
 		prop->first_available_cq[i] = USHRT_MAX;
 
-	prop->fw_security_status_valid = false;
+	prop->fw_cpu_boot_dev_sts0_valid = false;
+	prop->fw_cpu_boot_dev_sts1_valid = false;
 	prop->hard_reset_done_by_fw = false;
 
 	return 0;
@@ -706,8 +707,10 @@ static int gaudi_early_init(struct hl_device *hdev)
 	 * version to determine whether we run with a security-enabled firmware
 	 */
 	rc = hl_fw_read_preboot_status(hdev, mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS,
-			mmCPU_BOOT_DEV_STS0, mmCPU_BOOT_ERR0,
-			GAUDI_BOOT_FIT_REQ_TIMEOUT_USEC);
+					mmCPU_BOOT_DEV_STS0,
+					mmCPU_BOOT_DEV_STS1, mmCPU_BOOT_ERR0,
+					mmCPU_BOOT_ERR1,
+					GAUDI_BOOT_FIT_REQ_TIMEOUT_USEC);
 	if (rc) {
 		if (hdev->reset_on_preboot_fail)
 			hdev->asic_funcs->hw_fini(hdev, true);
@@ -1925,8 +1928,8 @@ static void gaudi_init_scrambler_sram(struct hl_device *hdev)
 	if (!hdev->asic_prop.fw_security_disabled)
 		return;
 
-	if (hdev->asic_prop.fw_security_status_valid &&
-			(hdev->asic_prop.fw_app_security_map &
+	if (hdev->asic_prop.fw_cpu_boot_dev_sts0_valid &&
+			(hdev->asic_prop.fw_app_cpu_boot_dev_sts0 &
 					CPU_BOOT_DEV_STS0_SRAM_SCR_EN))
 		return;
 
@@ -1997,8 +2000,8 @@ static void gaudi_init_scrambler_hbm(struct hl_device *hdev)
 	if (!hdev->asic_prop.fw_security_disabled)
 		return;
 
-	if (hdev->asic_prop.fw_security_status_valid &&
-			(hdev->asic_prop.fw_boot_cpu_security_map &
+	if (hdev->asic_prop.fw_cpu_boot_dev_sts0_valid &&
+			(hdev->asic_prop.fw_bootfit_cpu_boot_dev_sts0 &
 					CPU_BOOT_DEV_STS0_DRAM_SCR_EN))
 		return;
 
@@ -2067,8 +2070,8 @@ static void gaudi_init_e2e(struct hl_device *hdev)
 	if (!hdev->asic_prop.fw_security_disabled)
 		return;
 
-	if (hdev->asic_prop.fw_security_status_valid &&
-			(hdev->asic_prop.fw_boot_cpu_security_map &
+	if (hdev->asic_prop.fw_cpu_boot_dev_sts0_valid &&
+			(hdev->asic_prop.fw_bootfit_cpu_boot_dev_sts0 &
 					CPU_BOOT_DEV_STS0_E2E_CRED_EN))
 		return;
 
@@ -2442,8 +2445,8 @@ static void gaudi_init_hbm_cred(struct hl_device *hdev)
 	if (!hdev->asic_prop.fw_security_disabled)
 		return;
 
-	if (hdev->asic_prop.fw_security_status_valid &&
-			(hdev->asic_prop.fw_boot_cpu_security_map &
+	if (hdev->asic_prop.fw_cpu_boot_dev_sts0_valid &&
+			(hdev->asic_prop.fw_bootfit_cpu_boot_dev_sts0 &
 					CPU_BOOT_DEV_STS0_HBM_CRED_EN))
 		return;
 
@@ -3768,8 +3771,10 @@ static void gaudi_init_static_firmware_loader(struct hl_device *hdev)
 	static_loader->kmd_msg_to_cpu_reg = mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU;
 	static_loader->cpu_cmd_status_to_host_reg = mmCPU_CMD_STATUS_TO_HOST;
 	static_loader->cpu_boot_status_reg = mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS;
-	static_loader->cpu_boot_dev_status_reg = mmCPU_BOOT_DEV_STS0;
+	static_loader->cpu_boot_dev_status0_reg = mmCPU_BOOT_DEV_STS0;
+	static_loader->cpu_boot_dev_status1_reg = mmCPU_BOOT_DEV_STS1;
 	static_loader->boot_err0_reg = mmCPU_BOOT_ERR0;
+	static_loader->boot_err1_reg = mmCPU_BOOT_ERR1;
 	static_loader->preboot_version_offset_reg = mmPREBOOT_VER_OFFSET;
 	static_loader->boot_fit_version_offset_reg = mmUBOOT_VER_OFFSET;
 	static_loader->sram_offset_mask = ~((u32)SRAM_BASE_ADDR);
@@ -3884,8 +3889,10 @@ static int gaudi_init_cpu_queues(struct hl_device *hdev, u32 cpu_timeout)
 	}
 
 	/* update FW application security bits */
-	if (prop->fw_security_status_valid)
-		prop->fw_app_security_map = RREG32(mmCPU_BOOT_DEV_STS0);
+	if (prop->fw_cpu_boot_dev_sts0_valid)
+		prop->fw_app_cpu_boot_dev_sts0 = RREG32(mmCPU_BOOT_DEV_STS0);
+	if (prop->fw_cpu_boot_dev_sts1_valid)
+		prop->fw_app_cpu_boot_dev_sts1 = RREG32(mmCPU_BOOT_DEV_STS1);
 
 	gaudi->hw_cap_initialized |= HW_CAP_CPU_Q;
 	return 0;
@@ -7407,8 +7414,8 @@ static int gaudi_hbm_read_interrupts(struct hl_device *hdev, int device,
 	u32 base, val, val2, wr_par, rd_par, ca_par, derr, serr, type, ch;
 	int err = 0;
 
-	if (hdev->asic_prop.fw_security_status_valid &&
-			(hdev->asic_prop.fw_app_security_map &
+	if (hdev->asic_prop.fw_cpu_boot_dev_sts0_valid &&
+			(hdev->asic_prop.fw_app_cpu_boot_dev_sts0 &
 				CPU_BOOT_DEV_STS0_HBM_ECC_EN)) {
 		if (!hbm_ecc_data) {
 			dev_err(hdev->dev, "No FW ECC data");
@@ -7976,7 +7983,9 @@ static int gaudi_cpucp_info_get(struct hl_device *hdev)
 	if (!(gaudi->hw_cap_initialized & HW_CAP_CPU_Q))
 		return 0;
 
-	rc = hl_fw_cpucp_handshake(hdev, mmCPU_BOOT_DEV_STS0, mmCPU_BOOT_ERR0);
+	rc = hl_fw_cpucp_handshake(hdev, mmCPU_BOOT_DEV_STS0,
+					mmCPU_BOOT_DEV_STS1, mmCPU_BOOT_ERR0,
+					mmCPU_BOOT_ERR1);
 	if (rc)
 		return rc;
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 3b995e354c50..f1bd8e826304 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -461,7 +461,8 @@ int goya_get_fixed_properties(struct hl_device *hdev)
 	for (i = 0 ; i < HL_MAX_DCORES ; i++)
 		prop->first_available_cq[i] = USHRT_MAX;
 
-	prop->fw_security_status_valid = false;
+	prop->fw_cpu_boot_dev_sts0_valid = false;
+	prop->fw_cpu_boot_dev_sts1_valid = false;
 	prop->hard_reset_done_by_fw = false;
 
 	return 0;
@@ -641,8 +642,10 @@ static int goya_early_init(struct hl_device *hdev)
 	 * version to determine whether we run with a security-enabled firmware
 	 */
 	rc = hl_fw_read_preboot_status(hdev, mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS,
-			mmCPU_BOOT_DEV_STS0, mmCPU_BOOT_ERR0,
-			GOYA_BOOT_FIT_REQ_TIMEOUT_USEC);
+					mmCPU_BOOT_DEV_STS0,
+					mmCPU_BOOT_DEV_STS1, mmCPU_BOOT_ERR0,
+					mmCPU_BOOT_ERR1,
+					GOYA_BOOT_FIT_REQ_TIMEOUT_USEC);
 	if (rc) {
 		if (hdev->reset_on_preboot_fail)
 			hdev->asic_funcs->hw_fini(hdev, true);
@@ -1297,8 +1300,11 @@ int goya_init_cpu_queues(struct hl_device *hdev)
 	}
 
 	/* update FW application security bits */
-	if (prop->fw_security_status_valid)
-		prop->fw_app_security_map = RREG32(mmCPU_BOOT_DEV_STS0);
+	if (prop->fw_cpu_boot_dev_sts0_valid)
+		prop->fw_app_cpu_boot_dev_sts0 = RREG32(mmCPU_BOOT_DEV_STS0);
+
+	if (prop->fw_cpu_boot_dev_sts1_valid)
+		prop->fw_app_cpu_boot_dev_sts1 = RREG32(mmCPU_BOOT_DEV_STS1);
 
 	goya->hw_cap_initialized |= HW_CAP_CPU_Q;
 	return 0;
@@ -2470,8 +2476,10 @@ static void goya_init_static_firmware_loader(struct hl_device *hdev)
 	static_loader->kmd_msg_to_cpu_reg = mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU;
 	static_loader->cpu_cmd_status_to_host_reg = mmCPU_CMD_STATUS_TO_HOST;
 	static_loader->cpu_boot_status_reg = mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS;
-	static_loader->cpu_boot_dev_status_reg = mmCPU_BOOT_DEV_STS0;
+	static_loader->cpu_boot_dev_status0_reg = mmCPU_BOOT_DEV_STS0;
+	static_loader->cpu_boot_dev_status1_reg = mmCPU_BOOT_DEV_STS1;
 	static_loader->boot_err0_reg = mmCPU_BOOT_ERR0;
+	static_loader->boot_err1_reg = mmCPU_BOOT_ERR1;
 	static_loader->preboot_version_offset_reg = mmPREBOOT_VER_OFFSET;
 	static_loader->boot_fit_version_offset_reg = mmUBOOT_VER_OFFSET;
 	static_loader->sram_offset_mask = ~((u32)SRAM_BASE_ADDR);
@@ -5245,7 +5253,9 @@ int goya_cpucp_info_get(struct hl_device *hdev)
 	if (!(goya->hw_cap_initialized & HW_CAP_CPU_Q))
 		return 0;
 
-	rc = hl_fw_cpucp_handshake(hdev, mmCPU_BOOT_DEV_STS0, mmCPU_BOOT_ERR0);
+	rc = hl_fw_cpucp_handshake(hdev, mmCPU_BOOT_DEV_STS0,
+					mmCPU_BOOT_DEV_STS1, mmCPU_BOOT_ERR0,
+					mmCPU_BOOT_ERR1);
 	if (rc)
 		return rc;
 
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6685836D689
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 13:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239185AbhD1LeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 07:34:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234158AbhD1LeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 07:34:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 785FA61429;
        Wed, 28 Apr 2021 11:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619609608;
        bh=TFfSlQDDZ+RP58SFmU2JC6PusHFD6gIHtQ2Yh6d6Fr8=;
        h=From:To:Cc:Subject:Date:From;
        b=qPI5RU+MgYhGkE/3rxppPLx6osWz0O3a5hm5PS4nsUwfpw1XTJehB5jAHY3z7hVC/
         Ciot2CdArOtWWOjXP7BHzSn0mk73cr+r4JrBqQmxDAHdEqdH4/iAdQ+BJQ/C7Io7V0
         U0wMpHKutlVGYNYVg95d074gDIXxCbDy5/f+2NrFuCfEGZn0ry5pfQTcwHBFQsABe/
         Aopr/gWSqKZtv5QtEg7hV/OxCr854S4lhVM0QKE4MLVYjXulCoO88T+I2PWH01b1Ee
         dz3wHgSUhAdfzy91Kpe373lO39q5bpaSVXXrahntrph2tnnQHnsZcPO0EiUFMO+TXe
         JtXt08JSRkhdg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 1/5] habanalabs: use common fw_version read
Date:   Wed, 28 Apr 2021 14:33:19 +0300
Message-Id: <20210428113323.17222-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

Instead of using multiple ASIC specific copies of functions to read the
FW version use single common one that gets ASIC specific arguments.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 50 ++++++++++++++++++--
 drivers/misc/habanalabs/common/habanalabs.h  | 22 ++++++---
 drivers/misc/habanalabs/gaudi/gaudi.c        | 45 +++---------------
 drivers/misc/habanalabs/goya/goya.c          | 50 +++-----------------
 4 files changed, 74 insertions(+), 93 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index a97d9c264adc..29d15a051ab9 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -887,6 +887,49 @@ static int hl_fw_read_preboot_caps(struct hl_device *hdev,
 	return 0;
 }
 
+static int hl_read_device_fw_version(struct hl_device *hdev,
+					enum hl_fw_component fwc)
+{
+	struct fw_load_mgr *fw_loader = &hdev->fw_loader;
+	const char *name;
+	u32 ver_off, limit;
+	char *dest;
+
+	switch (fwc) {
+	case FW_COMP_BOOT_FIT:
+		ver_off = RREG32(fw_loader->boot_fit_version_offset_reg);
+		dest = hdev->asic_prop.uboot_ver;
+		name = "Boot-fit";
+		limit = fw_loader->boot_fit_version_max_off;
+		break;
+	case FW_COMP_PREBOOT:
+		ver_off = RREG32(
+			fw_loader->preboot_version_offset_reg);
+		dest = hdev->asic_prop.preboot_ver;
+		name = "Preboot";
+		limit = fw_loader->preboot_version_max_off;
+		break;
+	default:
+		dev_warn(hdev->dev, "Undefined FW component: %d\n", fwc);
+		return -EIO;
+	}
+
+	ver_off &= fw_loader->sram_offset_mask;
+
+	if (ver_off < limit) {
+		memcpy_fromio(dest,
+			hdev->pcie_bar[fw_loader->sram_bar_id] + ver_off,
+			VERSION_MAX_LEN);
+	} else {
+		dev_err(hdev->dev, "%s version offset (0x%x) is above SRAM\n",
+								name, ver_off);
+		strscpy(dest, "unavailable", VERSION_MAX_LEN);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static int hl_fw_read_preboot_status_legacy(struct hl_device *hdev,
 		u32 cpu_boot_status_reg, u32 cpu_security_boot_status_reg,
 		u32 boot_err0_reg, u32 timeout)
@@ -895,7 +938,7 @@ static int hl_fw_read_preboot_status_legacy(struct hl_device *hdev,
 	u32 security_status;
 	int rc;
 
-	rc = hdev->asic_funcs->read_device_fw_version(hdev, FW_COMP_PREBOOT);
+	rc = hl_read_device_fw_version(hdev, FW_COMP_PREBOOT);
 	if (rc)
 		return rc;
 
@@ -947,6 +990,8 @@ int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
 {
 	int rc;
 
+	hdev->asic_funcs->init_firmware_loader(hdev);
+
 	/* pldm was added for cases in which we use preboot on pldm and want
 	 * to load boot fit, but we can't wait for preboot because it runs
 	 * very slowly
@@ -985,7 +1030,6 @@ int hl_fw_init_cpu(struct hl_device *hdev)
 		return 0;
 
 	/* init loader parameters */
-	hdev->asic_funcs->init_firmware_loader(hdev);
 	fw_loader = &hdev->fw_loader;
 	cpu_security_boot_status_reg = fw_loader->cpu_boot_status_reg;
 	cpu_msg_status_reg = fw_loader->cpu_cmd_status_to_host_reg;
@@ -1053,7 +1097,7 @@ int hl_fw_init_cpu(struct hl_device *hdev)
 	dev_dbg(hdev->dev, "uboot status = %d\n", status);
 
 	/* Read U-Boot version now in case we will later fail */
-	hdev->asic_funcs->read_device_fw_version(hdev, FW_COMP_UBOOT);
+	hl_read_device_fw_version(hdev, FW_COMP_BOOT_FIT);
 
 	/* Clear reset status since we need to read it again from boot CPU */
 	prop->hard_reset_done_by_fw = false;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 07c2713ba372..1a822fd741d1 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -178,11 +178,11 @@ enum hl_pci_match_mode {
 
 /**
  * enum hl_fw_component - F/W components to read version through registers.
- * @FW_COMP_UBOOT: u-boot.
+ * @FW_COMP_BOOT_FIT: boot fit.
  * @FW_COMP_PREBOOT: preboot.
  */
 enum hl_fw_component {
-	FW_COMP_UBOOT,
+	FW_COMP_BOOT_FIT,
 	FW_COMP_PREBOOT
 };
 
@@ -820,24 +820,36 @@ enum div_select_defs {
 
 /**
  * struct fw_load_mgr - manager FW loading process
- * @kmd_msg_to_cpu_reg: register address for KMD->CPU messages
+ * @preboot_version_max_off: max offset to preboot version
+ * @boot_fit_version_max_off: max offset to boot fit version
+ * @kmd_msg_to_cpu_reg: register address for KDM->CPU messages
  * @cpu_cmd_status_to_host_reg: register address for CPU command status response
  * @cpu_boot_status_reg: boot status register
  * @cpu_boot_dev_status_reg: boot device status register
  * @boot_err0_reg: boot error register
+ * @preboot_version_offset_reg: SRAM offset to preboot version register
+ * @boot_fit_version_offset_reg: SRAM offset to boot fit version register
+ * @sram_offset_mask: mask for getting offset into the SRAM
  * @cpu_timeout: CPU response timeout in usec
  * @boot_fit_timeout: Boot fit load timeout in usec
  * @skip_bmc: should BMC be skipped
+ * @sram_bar_id: SRAM bar ID
  */
 struct fw_load_mgr {
+	u64 preboot_version_max_off;
+	u64 boot_fit_version_max_off;
 	u32 kmd_msg_to_cpu_reg;
 	u32 cpu_cmd_status_to_host_reg;
 	u32 cpu_boot_status_reg;
 	u32 cpu_boot_dev_status_reg;
 	u32 boot_err0_reg;
+	u32 preboot_version_offset_reg;
+	u32 boot_fit_version_offset_reg;
+	u32 sram_offset_mask;
 	u32 cpu_timeout;
 	u32 boot_fit_timeout;
 	u8 skip_bmc;
+	u8 sram_bar_id;
 };
 
 /**
@@ -929,8 +941,6 @@ struct fw_load_mgr {
  * @ctx_fini: context dependent cleanup.
  * @get_clk_rate: Retrieve the ASIC current and maximum clock rate in MHz
  * @get_queue_id_for_cq: Get the H/W queue id related to the given CQ index.
- * @read_device_fw_version: read the device's firmware versions that are
- *                          contained in registers
  * @load_firmware_to_device: load the firmware to the device's memory
  * @load_boot_fit_to_device: load boot fit to device's memory
  * @get_signal_cb_size: Get signal CB size.
@@ -1059,8 +1069,6 @@ struct hl_asic_funcs {
 	void (*ctx_fini)(struct hl_ctx *ctx);
 	int (*get_clk_rate)(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk);
 	u32 (*get_queue_id_for_cq)(struct hl_device *hdev, u32 cq_idx);
-	int (*read_device_fw_version)(struct hl_device *hdev,
-					enum hl_fw_component fwc);
 	int (*load_firmware_to_device)(struct hl_device *hdev);
 	int (*load_boot_fit_to_device)(struct hl_device *hdev);
 	u32 (*get_signal_cb_size)(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 1d5930578e07..9e625ca94908 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -3691,56 +3691,24 @@ static int gaudi_load_boot_fit_to_device(struct hl_device *hdev)
 	return hl_fw_load_fw_to_device(hdev, GAUDI_BOOT_FIT_FILE, dst, 0, 0);
 }
 
-static int gaudi_read_device_fw_version(struct hl_device *hdev,
-					enum hl_fw_component fwc)
-{
-	const char *name;
-	u32 ver_off;
-	char *dest;
-
-	switch (fwc) {
-	case FW_COMP_UBOOT:
-		ver_off = RREG32(mmUBOOT_VER_OFFSET);
-		dest = hdev->asic_prop.uboot_ver;
-		name = "U-Boot";
-		break;
-	case FW_COMP_PREBOOT:
-		ver_off = RREG32(mmPREBOOT_VER_OFFSET);
-		dest = hdev->asic_prop.preboot_ver;
-		name = "Preboot";
-		break;
-	default:
-		dev_warn(hdev->dev, "Undefined FW component: %d\n", fwc);
-		return -EIO;
-	}
-
-	ver_off &= ~((u32)SRAM_BASE_ADDR);
-
-	if (ver_off < SRAM_SIZE - VERSION_MAX_LEN) {
-		memcpy_fromio(dest, hdev->pcie_bar[SRAM_BAR_ID] + ver_off,
-							VERSION_MAX_LEN);
-	} else {
-		dev_err(hdev->dev, "%s version offset (0x%x) is above SRAM\n",
-								name, ver_off);
-		strcpy(dest, "unavailable");
-		return -EIO;
-	}
-
-	return 0;
-}
-
 static void gaudi_init_firmware_loader(struct hl_device *hdev)
 {
 	struct fw_load_mgr *fw_loader = &hdev->fw_loader;
 
+	fw_loader->preboot_version_max_off = SRAM_SIZE - VERSION_MAX_LEN;
+	fw_loader->boot_fit_version_max_off = SRAM_SIZE - VERSION_MAX_LEN;
 	fw_loader->kmd_msg_to_cpu_reg = mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU;
 	fw_loader->cpu_cmd_status_to_host_reg = mmCPU_CMD_STATUS_TO_HOST;
+	fw_loader->preboot_version_offset_reg = mmPREBOOT_VER_OFFSET;
+	fw_loader->boot_fit_version_offset_reg = mmUBOOT_VER_OFFSET;
+	fw_loader->sram_offset_mask = ~((u32)SRAM_BASE_ADDR);
 	fw_loader->cpu_timeout = GAUDI_CPU_TIMEOUT_USEC;
 	fw_loader->boot_fit_timeout = GAUDI_BOOT_FIT_REQ_TIMEOUT_USEC;
 	fw_loader->skip_bmc = !hdev->bmc_enable;
 	fw_loader->cpu_boot_status_reg = mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS;
 	fw_loader->cpu_boot_dev_status_reg = mmCPU_BOOT_DEV_STS0;
 	fw_loader->boot_err0_reg = mmCPU_BOOT_ERR0;
+	fw_loader->sram_bar_id = SRAM_BAR_ID;
 }
 
 static int gaudi_init_cpu(struct hl_device *hdev)
@@ -8802,7 +8770,6 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.ctx_fini = gaudi_ctx_fini,
 	.get_clk_rate = gaudi_get_clk_rate,
 	.get_queue_id_for_cq = gaudi_get_queue_id_for_cq,
-	.read_device_fw_version = gaudi_read_device_fw_version,
 	.load_firmware_to_device = gaudi_load_firmware_to_device,
 	.load_boot_fit_to_device = gaudi_load_boot_fit_to_device,
 	.get_signal_cb_size = gaudi_get_signal_cb_size,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 678fbbc6521b..dd55fec19e8d 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2402,61 +2402,24 @@ static int goya_load_boot_fit_to_device(struct hl_device *hdev)
 	return hl_fw_load_fw_to_device(hdev, GOYA_BOOT_FIT_FILE, dst, 0, 0);
 }
 
-/*
- * FW component passes an offset from SRAM_BASE_ADDR in SCRATCHPAD_xx.
- * The version string should be located by that offset.
- */
-static int goya_read_device_fw_version(struct hl_device *hdev,
-					enum hl_fw_component fwc)
-{
-	const char *name;
-	u32 ver_off;
-	char *dest;
-
-	switch (fwc) {
-	case FW_COMP_UBOOT:
-		ver_off = RREG32(mmUBOOT_VER_OFFSET);
-		dest = hdev->asic_prop.uboot_ver;
-		name = "U-Boot";
-		break;
-	case FW_COMP_PREBOOT:
-		ver_off = RREG32(mmPREBOOT_VER_OFFSET);
-		dest = hdev->asic_prop.preboot_ver;
-		name = "Preboot";
-		break;
-	default:
-		dev_warn(hdev->dev, "Undefined FW component: %d\n", fwc);
-		return -EIO;
-	}
-
-	ver_off &= ~((u32)SRAM_BASE_ADDR);
-
-	if (ver_off < SRAM_SIZE - VERSION_MAX_LEN) {
-		memcpy_fromio(dest, hdev->pcie_bar[SRAM_CFG_BAR_ID] + ver_off,
-							VERSION_MAX_LEN);
-	} else {
-		dev_err(hdev->dev, "%s version offset (0x%x) is above SRAM\n",
-								name, ver_off);
-		strcpy(dest, "unavailable");
-
-		return -EIO;
-	}
-
-	return 0;
-}
-
 static void goya_init_firmware_loader(struct hl_device *hdev)
 {
 	struct fw_load_mgr *fw_loader = &hdev->fw_loader;
 
+	fw_loader->preboot_version_max_off = SRAM_SIZE - VERSION_MAX_LEN;
+	fw_loader->boot_fit_version_max_off = SRAM_SIZE - VERSION_MAX_LEN;
 	fw_loader->kmd_msg_to_cpu_reg = mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU;
 	fw_loader->cpu_cmd_status_to_host_reg = mmCPU_CMD_STATUS_TO_HOST;
+	fw_loader->preboot_version_offset_reg = mmPREBOOT_VER_OFFSET;
+	fw_loader->boot_fit_version_offset_reg = mmUBOOT_VER_OFFSET;
+	fw_loader->sram_offset_mask = ~((u32)SRAM_BASE_ADDR);
 	fw_loader->cpu_timeout = GOYA_CPU_TIMEOUT_USEC;
 	fw_loader->boot_fit_timeout = GOYA_BOOT_FIT_REQ_TIMEOUT_USEC;
 	fw_loader->skip_bmc = false;
 	fw_loader->cpu_boot_status_reg = mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS;
 	fw_loader->cpu_boot_dev_status_reg = mmCPU_BOOT_DEV_STS0;
 	fw_loader->boot_err0_reg = mmCPU_BOOT_ERR0;
+	fw_loader->sram_bar_id = SRAM_CFG_BAR_ID;
 }
 
 static int goya_init_cpu(struct hl_device *hdev)
@@ -5533,7 +5496,6 @@ static const struct hl_asic_funcs goya_funcs = {
 	.ctx_fini = goya_ctx_fini,
 	.get_clk_rate = goya_get_clk_rate,
 	.get_queue_id_for_cq = goya_get_queue_id_for_cq,
-	.read_device_fw_version = goya_read_device_fw_version,
 	.load_firmware_to_device = goya_load_firmware_to_device,
 	.load_boot_fit_to_device = goya_load_boot_fit_to_device,
 	.get_signal_cb_size = goya_get_signal_cb_size,
-- 
2.25.1


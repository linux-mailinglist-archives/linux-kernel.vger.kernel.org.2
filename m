Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4186F370A8D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 08:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhEBGju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 02:39:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230322AbhEBGjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 02:39:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DAC16161C;
        Sun,  2 May 2021 06:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619937534;
        bh=y3QAk2pLi0fincgJwFQOEa2mPpk8xNUuBWvV9sgNsGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UZpsKJWo0Zocs20ZtCXQGpgKcFUsQk7fzz9xx7qy8etqwjkd2roz1zSU4acpdd51s
         GN6XYKl4H4p3wpvJWON08BC1eHS8YF218V+WCHOVIoulU1tfck0esSMJo1e4j8WxXd
         JPXKnCcv6H3shoGKS6XvA6wiHHbagEtfUy7EPN+0ca7h71ImU4l4LSVbh60agdvUb8
         B+pTuEkl0X9Rt+DBnraF2gRKHALW5VUVfU4acdY+P0lZ7Fzb/Y25y2eCW51qpnbBFH
         +a2TAwvw4eETu6A+Ck91pyzMdJr/YUoFJNI5jc//6vVbPrHsPNO70hJqwe+KIMObYW
         c81L4EQtd6kRA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 4/4] habanalabs: load linux image to device
Date:   Sun,  2 May 2021 09:38:45 +0300
Message-Id: <20210502063845.4615-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210502063845.4615-1-ogabbay@kernel.org>
References: <20210502063845.4615-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

Implementing dynamic linux image load to the device.
This patch also implements the FW communication steps during the
boot-fit.
This patch also enables the dynamic protocol based on the compatibility
flag.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 305 ++++++++++++++-----
 drivers/misc/habanalabs/common/habanalabs.h  |  10 +-
 drivers/misc/habanalabs/gaudi/gaudi.c        |   8 +
 drivers/misc/habanalabs/goya/goya.c          |   7 +
 4 files changed, 249 insertions(+), 81 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index e85747d8392a..fc10cc06f401 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -14,13 +14,7 @@
 
 #define FW_FILE_MAX_SIZE		0x1400000 /* maximum size of 20MB */
 
-/*
- * when copying image to FW we assume that PCI bar should not be re-set
- * (refers mainly to DRAM in which we do such it to access arbitrary region's
- * memory address) and we limit the BAR offset to 1G which should be more than
- * reasonable for image copy purposes.
- */
-#define FW_IMAGE_MAX_BAR_OFFSET		(1024 * 1024 * 1024)
+#define FW_CPU_STATUS_POLL_INTERVAL_USEC	10000
 
 static int hl_request_fw(struct hl_device *hdev,
 				const struct firmware **firmware_p,
@@ -899,7 +893,7 @@ static int hl_fw_read_preboot_caps(struct hl_device *hdev,
 		(status == CPU_BOOT_STATUS_READY_TO_BOOT) ||
 		(status == CPU_BOOT_STATUS_SRAM_AVAIL) ||
 		(status == CPU_BOOT_STATUS_WAITING_FOR_BOOT_FIT),
-		10000,
+		FW_CPU_STATUS_POLL_INTERVAL_USEC,
 		timeout);
 
 	if (rc) {
@@ -911,14 +905,8 @@ static int hl_fw_read_preboot_caps(struct hl_device *hdev,
 
 	prop->fw_preboot_caps_map = RREG32(cpu_boot_caps_reg);
 
-	/*
-	 * For now- force dynamic_fw_load to false as LKD does not yet
-	 * implements all necessary parts of it.
-	 * TODO: once dynamic load is ready set to:
-	 * prop->dynamic_fw_load = !!(prop->fw_preboot_caps_map &
-	 *                                CPU_BOOT_DEV_STS0_FW_LD_COM_EN)
-	 */
-	prop->dynamic_fw_load = 0;
+	prop->dynamic_fw_load = !!(prop->fw_preboot_caps_map &
+						CPU_BOOT_DEV_STS0_FW_LD_COM_EN);
 
 	/* initialize FW loader once we know what load protocol is used */
 	hdev->asic_funcs->init_firmware_loader(hdev);
@@ -1065,13 +1053,13 @@ int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
 	if (rc)
 		return rc;
 
-	if (!hdev->asic_prop.dynamic_fw_load)
-		return hl_fw_static_read_preboot_status(hdev, cpu_boot_status_reg,
+	/* no need to read preboot status in dynamic load */
+	if (hdev->asic_prop.dynamic_fw_load)
+		return 0;
+
+	return hl_fw_static_read_preboot_status(hdev, cpu_boot_status_reg,
 				cpu_boot_caps_reg, boot_err0_reg,
 				timeout);
-
-	dev_err(hdev->dev, "Dynamic FW load is not supported\n");
-	return -EINVAL;
 }
 
 /* associate string with COMM status */
@@ -1197,7 +1185,7 @@ static int hl_fw_dynamic_wait_for_status(struct hl_device *hdev,
 		dyn_regs->cpu_cmd_status_to_host,
 		status,
 		FIELD_GET(COMMS_STATUS_STATUS_MASK, status) == expected_status,
-		10000,
+		FW_CPU_STATUS_POLL_INTERVAL_USEC,
 		timeout);
 
 	if (rc) {
@@ -1368,7 +1356,7 @@ static int hl_fw_dynamic_validate_memory_bound(struct hl_device *hdev,
 	 * memory transfers)
 	 */
 	if (end_addr >= region->region_base - region->offset_in_bar +
-						FW_IMAGE_MAX_BAR_OFFSET) {
+							region->bar_size) {
 		dev_err(hdev->dev,
 			"FW image beyond PCI BAR bounds\n");
 		return -EIO;
@@ -1612,21 +1600,76 @@ static int hl_fw_dynamic_copy_image(struct hl_device *hdev,
 }
 
 /**
- * hl_fw_dynamic_load_boot_fit - load boot fit using dynamic protocol
+ * hl_fw_boot_fit_update_state - update internal data structures after boot-fit
+ *                               is loaded
+ *
+ * @hdev: pointer to the habanalabs device structure
+ * @cpu_security_boot_status_reg: register holding security status props
+ *
+ * @return 0 on success, otherwise non-zero error code
+ */
+static void hl_fw_boot_fit_update_state(struct hl_device *hdev,
+					u32 cpu_security_boot_status_reg)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+
+	/* Clear reset status since we need to read it again from boot CPU */
+	prop->hard_reset_done_by_fw = false;
+
+	/* Read boot_cpu security bits */
+	if (prop->fw_security_status_valid) {
+		prop->fw_boot_cpu_security_map =
+				RREG32(cpu_security_boot_status_reg);
+
+		if (prop->fw_boot_cpu_security_map &
+				CPU_BOOT_DEV_STS0_FW_HARD_RST_EN)
+			prop->hard_reset_done_by_fw = true;
+
+		dev_dbg(hdev->dev,
+			"Firmware boot CPU security status %#x\n",
+			prop->fw_boot_cpu_security_map);
+	}
+
+	dev_dbg(hdev->dev, "Firmware boot CPU hard-reset is %s\n",
+			prop->hard_reset_done_by_fw ? "enabled" : "disabled");
+}
+
+/**
+ * hl_fw_dynamic_load_image - load FW image using dynamic protocol
  *
  * @hdev: pointer to the habanalabs device structure
  * @fw_loader: managing structure for loading device's FW
+ * @load_fwc: the FW component to be loaded
+ * @img_ld_timeout: image load timeout
  *
  * @return 0 on success, otherwise non-zero error code
  */
-static int hl_fw_dynamic_load_boot_fit(struct hl_device *hdev,
-						struct fw_load_mgr *fw_loader)
+static int hl_fw_dynamic_load_image(struct hl_device *hdev,
+						struct fw_load_mgr *fw_loader,
+						enum hl_fw_component load_fwc,
+						u32 img_ld_timeout)
 {
+	enum hl_fw_component cur_fwc;
 	const struct firmware *fw;
+	char *fw_name;
 	int rc = 0;
 
+	/*
+	 * when loading image we have one of 2 scenarios:
+	 * 1. current FW component is preboot and we want to load boot-fit
+	 * 2. current FW component is boot-fit and we want to load linux
+	 */
+	if (load_fwc == FW_COMP_BOOT_FIT) {
+		cur_fwc = FW_COMP_PREBOOT;
+		fw_name = fw_loader->boot_fit_img.image_name;
+	} else {
+		cur_fwc = FW_COMP_BOOT_FIT;
+		fw_name = fw_loader->linux_img.image_name;
+
+	}
+
 	/* request FW in order to communicate to FW the size to be allocated */
-	rc = hl_request_fw(hdev, &fw, fw_loader->boot_fit_img.image_name);
+	rc = hl_request_fw(hdev, &fw, fw_name);
 	if (rc)
 		return rc;
 
@@ -1638,11 +1681,21 @@ static int hl_fw_dynamic_load_boot_fit(struct hl_device *hdev,
 		goto release_fw;
 
 	/* read preboot version */
-	hl_fw_dynamic_read_device_fw_version(hdev, FW_COMP_PREBOOT,
+	hl_fw_dynamic_read_device_fw_version(hdev, cur_fwc,
 				fw_loader->dynamic_loader.comm_desc.cur_fw_ver);
 
-	/* update state during preboot handshake */
-	hl_fw_preboot_update_state(hdev);
+
+	/* update state according to boot stage */
+	if (cur_fwc == FW_COMP_BOOT_FIT) {
+		struct cpu_dyn_regs *dyn_regs;
+
+		dyn_regs = &fw_loader->dynamic_loader.comm_desc.cpu_dyn_regs;
+		hl_fw_boot_fit_update_state(hdev,
+					le32_to_cpu(dyn_regs->cpu_boot_status));
+	} else {
+		/* update state during preboot handshake */
+		hl_fw_preboot_update_state(hdev);
+	}
 
 	/* copy boot fit to space allocated by FW */
 	rc = hl_fw_dynamic_copy_image(hdev, fw, fw_loader);
@@ -1657,13 +1710,104 @@ static int hl_fw_dynamic_load_boot_fit(struct hl_device *hdev,
 
 	rc = hl_fw_dynamic_send_protocol_cmd(hdev, fw_loader, COMMS_EXEC,
 						0, false,
-						fw_loader->boot_fit_timeout);
+						img_ld_timeout);
 
 release_fw:
 	hl_release_firmware(fw);
 	return rc;
 }
 
+static int hl_fw_dynamic_wait_for_boot_fit_active(struct hl_device *hdev,
+					struct fw_load_mgr *fw_loader)
+{
+	struct dynamic_fw_load_mgr *dyn_loader;
+	u32 status;
+	int rc;
+
+	dyn_loader = &fw_loader->dynamic_loader;
+
+	/* Make sure CPU boot-loader is running */
+	rc = hl_poll_timeout(
+		hdev,
+		le32_to_cpu(dyn_loader->comm_desc.cpu_dyn_regs.cpu_boot_status),
+		status,
+		(status == CPU_BOOT_STATUS_NIC_FW_RDY) ||
+		(status == CPU_BOOT_STATUS_READY_TO_BOOT),
+		FW_CPU_STATUS_POLL_INTERVAL_USEC,
+		dyn_loader->wait_for_bl_timeout);
+	if (rc) {
+		dev_err(hdev->dev, "failed to wait for boot\n");
+		return rc;
+	}
+
+	dev_dbg(hdev->dev, "uboot status = %d\n", status);
+	return 0;
+}
+
+static int hl_fw_dynamic_wait_for_linux_active(struct hl_device *hdev,
+						struct fw_load_mgr *fw_loader)
+{
+	struct dynamic_fw_load_mgr *dyn_loader;
+	u32 status;
+	int rc;
+
+	dyn_loader = &fw_loader->dynamic_loader;
+
+	/* Make sure CPU boot-loader is running */
+
+	rc = hl_poll_timeout(
+		hdev,
+		le32_to_cpu(dyn_loader->comm_desc.cpu_dyn_regs.cpu_boot_status),
+		status,
+		(status == CPU_BOOT_STATUS_SRAM_AVAIL),
+		FW_CPU_STATUS_POLL_INTERVAL_USEC,
+		fw_loader->cpu_timeout);
+	if (rc) {
+		dev_err(hdev->dev, "failed to wait for Linux\n");
+		return rc;
+	}
+
+	dev_dbg(hdev->dev, "Boot status = %d\n", status);
+	return 0;
+}
+
+/**
+ * hl_fw_linux_update_state - update internal data structures after loading
+ *                            Linux
+ *
+ *
+ * @hdev: pointer to the habanalabs device structure
+ *
+ * @return 0 on success, otherwise non-zero error code
+ */
+static void hl_fw_linux_update_state(struct hl_device *hdev,
+						u32 cpu_boot_status_reg)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+
+	/* Clear reset status since we need to read again from app */
+	prop->hard_reset_done_by_fw = false;
+
+	/* Read FW application security bits */
+	if (prop->fw_security_status_valid) {
+		prop->fw_app_security_map =
+				RREG32(cpu_boot_status_reg);
+
+		if (prop->fw_app_security_map &
+				CPU_BOOT_DEV_STS0_FW_HARD_RST_EN)
+			prop->hard_reset_done_by_fw = true;
+
+		dev_dbg(hdev->dev,
+			"Firmware application CPU security status %#x\n",
+			prop->fw_app_security_map);
+	}
+
+	dev_dbg(hdev->dev, "Firmware application CPU hard-reset is %s\n",
+			prop->hard_reset_done_by_fw ? "enabled" : "disabled");
+
+	dev_info(hdev->dev, "Successfully loaded firmware to device\n");
+}
+
 /**
  * hl_fw_dynamic_init_cpu - initialize the device CPU using dynamic protocol
  *
@@ -1688,6 +1832,8 @@ static int hl_fw_dynamic_init_cpu(struct hl_device *hdev,
 	struct cpu_dyn_regs *dyn_regs;
 	int rc;
 
+	dyn_regs = &fw_loader->dynamic_loader.comm_desc.cpu_dyn_regs;
+
 	rc = hl_fw_dynamic_send_protocol_cmd(hdev, fw_loader, COMMS_RST_STATE,
 						0, true,
 						fw_loader->cpu_timeout);
@@ -1695,6 +1841,9 @@ static int hl_fw_dynamic_init_cpu(struct hl_device *hdev,
 		goto protocol_err;
 
 	if (!(hdev->fw_components & FW_TYPE_BOOT_CPU)) {
+		/* update the preboot state */
+		hl_fw_preboot_update_state(hdev);
+
 		rc = hl_fw_dynamic_request_descriptor(hdev, fw_loader, 0);
 		if (rc)
 			goto protocol_err;
@@ -1706,14 +1855,50 @@ static int hl_fw_dynamic_init_cpu(struct hl_device *hdev,
 	}
 
 	/* load boot fit to FW */
-	rc = hl_fw_dynamic_load_boot_fit(hdev, fw_loader);
+	rc = hl_fw_dynamic_load_image(hdev, fw_loader, FW_COMP_BOOT_FIT,
+						fw_loader->boot_fit_timeout);
+	if (rc) {
+		dev_err(hdev->dev, "failed to load boot fit\n");
+		goto protocol_err;
+	}
+
+	rc = hl_fw_dynamic_wait_for_boot_fit_active(hdev, fw_loader);
 	if (rc)
 		goto protocol_err;
 
+	if (!(hdev->fw_components & FW_TYPE_LINUX)) {
+		dev_info(hdev->dev, "Skip loading Linux F/W\n");
+		return 0;
+	}
+
+	if (fw_loader->skip_bmc) {
+		rc = hl_fw_dynamic_send_protocol_cmd(hdev, fw_loader,
+							COMMS_SKIP_BMC, 0,
+							true,
+							fw_loader->cpu_timeout);
+		if (rc) {
+			dev_err(hdev->dev, "failed to load boot fit\n");
+			goto protocol_err;
+		}
+	}
+
+	/* load Linux image to FW */
+	rc = hl_fw_dynamic_load_image(hdev, fw_loader, FW_COMP_LINUX,
+							fw_loader->cpu_timeout);
+	if (rc) {
+		dev_err(hdev->dev, "failed to load Linux\n");
+		goto protocol_err;
+	}
+
+	rc = hl_fw_dynamic_wait_for_linux_active(hdev, fw_loader);
+	if (rc)
+		goto protocol_err;
+
+	hl_fw_linux_update_state(hdev, le32_to_cpu(dyn_regs->cpu_boot_status));
+
 	return 0;
 
 protocol_err:
-	dyn_regs = &fw_loader->dynamic_loader.comm_desc.cpu_dyn_regs;
 	fw_read_errors(hdev, le32_to_cpu(dyn_regs->cpu_boot_err0),
 					le32_to_cpu(dyn_regs->cpu_boot_status));
 	return rc;
@@ -1732,7 +1917,6 @@ static int hl_fw_static_init_cpu(struct hl_device *hdev,
 {
 	u32 cpu_msg_status_reg, cpu_timeout, msg_to_cpu_reg, status;
 	u32 cpu_boot_status_reg, cpu_security_boot_status_reg;
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct static_fw_load_mgr *static_loader;
 	int rc;
 
@@ -1758,7 +1942,7 @@ static int hl_fw_static_init_cpu(struct hl_device *hdev,
 		cpu_boot_status_reg,
 		status,
 		status == CPU_BOOT_STATUS_WAITING_FOR_BOOT_FIT,
-		10000,
+		FW_CPU_STATUS_POLL_INTERVAL_USEC,
 		fw_loader->boot_fit_timeout);
 
 	if (rc) {
@@ -1781,7 +1965,7 @@ static int hl_fw_static_init_cpu(struct hl_device *hdev,
 			cpu_msg_status_reg,
 			status,
 			status == CPU_MSG_OK,
-			10000,
+			FW_CPU_STATUS_POLL_INTERVAL_USEC,
 			fw_loader->boot_fit_timeout);
 
 		if (rc) {
@@ -1803,7 +1987,7 @@ static int hl_fw_static_init_cpu(struct hl_device *hdev,
 		(status == CPU_BOOT_STATUS_NIC_FW_RDY) ||
 		(status == CPU_BOOT_STATUS_READY_TO_BOOT) ||
 		(status == CPU_BOOT_STATUS_SRAM_AVAIL),
-		10000,
+		FW_CPU_STATUS_POLL_INTERVAL_USEC,
 		cpu_timeout);
 
 	dev_dbg(hdev->dev, "uboot status = %d\n", status);
@@ -1811,25 +1995,8 @@ static int hl_fw_static_init_cpu(struct hl_device *hdev,
 	/* Read U-Boot version now in case we will later fail */
 	hl_fw_static_read_device_fw_version(hdev, FW_COMP_BOOT_FIT);
 
-	/* Clear reset status since we need to read it again from boot CPU */
-	prop->hard_reset_done_by_fw = false;
-
-	/* Read boot_cpu security bits */
-	if (prop->fw_security_status_valid) {
-		prop->fw_boot_cpu_security_map =
-				RREG32(cpu_security_boot_status_reg);
-
-		if (prop->fw_boot_cpu_security_map &
-				CPU_BOOT_DEV_STS0_FW_HARD_RST_EN)
-			prop->hard_reset_done_by_fw = true;
-
-		dev_dbg(hdev->dev,
-			"Firmware boot CPU security status %#x\n",
-			prop->fw_boot_cpu_security_map);
-	}
-
-	dev_dbg(hdev->dev, "Firmware boot CPU hard-reset is %s\n",
-			prop->hard_reset_done_by_fw ? "enabled" : "disabled");
+	/* update state according to boot stage */
+	hl_fw_boot_fit_update_state(hdev, cpu_security_boot_status_reg);
 
 	if (rc) {
 		detect_cpu_boot_status(hdev, status);
@@ -1860,7 +2027,7 @@ static int hl_fw_static_init_cpu(struct hl_device *hdev,
 			cpu_boot_status_reg,
 			status,
 			(status == CPU_BOOT_STATUS_BMC_WAITING_SKIPPED),
-			10000,
+			FW_CPU_STATUS_POLL_INTERVAL_USEC,
 			cpu_timeout);
 
 		if (rc) {
@@ -1880,7 +2047,7 @@ static int hl_fw_static_init_cpu(struct hl_device *hdev,
 		cpu_boot_status_reg,
 		status,
 		(status == CPU_BOOT_STATUS_SRAM_AVAIL),
-		10000,
+		FW_CPU_STATUS_POLL_INTERVAL_USEC,
 		cpu_timeout);
 
 	/* Clear message */
@@ -1904,27 +2071,7 @@ static int hl_fw_static_init_cpu(struct hl_device *hdev,
 	if (rc)
 		return rc;
 
-	/* Clear reset status since we need to read again from app */
-	prop->hard_reset_done_by_fw = false;
-
-	/* Read FW application security bits */
-	if (prop->fw_security_status_valid) {
-		prop->fw_app_security_map =
-				RREG32(cpu_security_boot_status_reg);
-
-		if (prop->fw_app_security_map &
-				CPU_BOOT_DEV_STS0_FW_HARD_RST_EN)
-			prop->hard_reset_done_by_fw = true;
-
-		dev_dbg(hdev->dev,
-			"Firmware application CPU security status %#x\n",
-			prop->fw_app_security_map);
-	}
-
-	dev_dbg(hdev->dev, "Firmware application CPU hard-reset is %s\n",
-			prop->hard_reset_done_by_fw ? "enabled" : "disabled");
-
-	dev_info(hdev->dev, "Successfully loaded firmware to device\n");
+	hl_fw_linux_update_state(hdev, cpu_security_boot_status_reg);
 
 	return 0;
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 161d33bcc79a..936780247ba4 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -180,10 +180,12 @@ enum hl_pci_match_mode {
  * enum hl_fw_component - F/W components to read version through registers.
  * @FW_COMP_BOOT_FIT: boot fit.
  * @FW_COMP_PREBOOT: preboot.
+ * @FW_COMP_LINUX: linux.
  */
 enum hl_fw_component {
 	FW_COMP_BOOT_FIT,
-	FW_COMP_PREBOOT
+	FW_COMP_PREBOOT,
+	FW_COMP_LINUX,
 };
 
 /**
@@ -830,6 +832,7 @@ enum pci_region {
  * struct pci_mem_region - describe memory region in a PCI bar
  * @region_base: region base address
  * @region_size: region size
+ * @bar_size: size of the BAR
  * @offset_in_bar: region offset into the bar
  * @bar_id: bar ID of the region
  * @used: if used 1, otherwise 0
@@ -837,6 +840,7 @@ enum pci_region {
 struct pci_mem_region {
 	u64 region_base;
 	u64 region_size;
+	u64 bar_size;
 	u32 offset_in_bar;
 	u8 bar_id;
 	u8 used;
@@ -885,13 +889,15 @@ struct fw_response {
  * @response: FW to LKD response
  * @comm_desc: the communication descriptor with FW
  * @image_region: region to copy the FW image to
- * @fw_image_size: FW image size
+ * @fw_image_size: size of FW image to load
+ * @wait_for_bl_timeout: timeout for waiting for boot loader to respond
  */
 struct dynamic_fw_load_mgr {
 	struct fw_response response;
 	struct lkd_fw_comms_desc comm_desc;
 	struct pci_mem_region *image_region;
 	size_t fw_image_size;
+	u32 wait_for_bl_timeout;
 };
 
 /**
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index e3a64600dc3b..683793c68e83 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -78,6 +78,7 @@
 #define GAUDI_PLDM_TPC_KERNEL_WAIT_USEC	(HL_DEVICE_TIMEOUT_USEC * 30)
 #define GAUDI_BOOT_FIT_REQ_TIMEOUT_USEC	1000000		/* 1s */
 #define GAUDI_MSG_TO_CPU_TIMEOUT_USEC	4000000		/* 4s */
+#define GAUDI_WAIT_FOR_BL_TIMEOUT_USEC	15000000	/* 15s */
 
 #define GAUDI_QMAN0_FENCE_VAL		0x72E91AB9
 
@@ -1592,6 +1593,7 @@ static int gaudi_alloc_internal_qmans_pq_mem(struct hl_device *hdev)
 
 static void gaudi_set_pci_memory_regions(struct hl_device *hdev)
 {
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct pci_mem_region *region;
 
 	/* CFG */
@@ -1599,6 +1601,7 @@ static void gaudi_set_pci_memory_regions(struct hl_device *hdev)
 	region->region_base = CFG_BASE;
 	region->region_size = CFG_SIZE;
 	region->offset_in_bar = CFG_BASE - SPI_FLASH_BASE_ADDR;
+	region->bar_size = CFG_BAR_SIZE;
 	region->bar_id = CFG_BAR_ID;
 	region->used = 1;
 
@@ -1607,6 +1610,7 @@ static void gaudi_set_pci_memory_regions(struct hl_device *hdev)
 	region->region_base = SRAM_BASE_ADDR;
 	region->region_size = SRAM_SIZE;
 	region->offset_in_bar = 0;
+	region->bar_size = SRAM_BAR_SIZE;
 	region->bar_id = SRAM_BAR_ID;
 	region->used = 1;
 
@@ -1615,6 +1619,7 @@ static void gaudi_set_pci_memory_regions(struct hl_device *hdev)
 	region->region_base = DRAM_PHYS_BASE;
 	region->region_size = hdev->asic_prop.dram_size;
 	region->offset_in_bar = 0;
+	region->bar_size = prop->dram_pci_bar_size;
 	region->bar_id = HBM_BAR_ID;
 	region->used = 1;
 
@@ -1623,6 +1628,7 @@ static void gaudi_set_pci_memory_regions(struct hl_device *hdev)
 	region->region_base = PSOC_SCRATCHPAD_ADDR;
 	region->region_size = PSOC_SCRATCHPAD_SIZE;
 	region->offset_in_bar = PSOC_SCRATCHPAD_ADDR - SPI_FLASH_BASE_ADDR;
+	region->bar_size = CFG_BAR_SIZE;
 	region->bar_id = CFG_BAR_ID;
 	region->used = 1;
 }
@@ -3749,6 +3755,8 @@ static void gaudi_init_dynamic_firmware_loader(struct hl_device *hdev)
 				cpu_to_le32(mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU);
 	dyn_regs->cpu_cmd_status_to_host =
 				cpu_to_le32(mmCPU_CMD_STATUS_TO_HOST);
+
+	dynamic_loader->wait_for_bl_timeout = GAUDI_WAIT_FOR_BL_TIMEOUT_USEC;
 }
 
 static void gaudi_init_static_firmware_loader(struct hl_device *hdev)
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 469587a63804..ef0e3f7965cd 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -87,6 +87,7 @@
 #define GOYA_PLDM_QMAN0_TIMEOUT_USEC	(HL_DEVICE_TIMEOUT_USEC * 30)
 #define GOYA_BOOT_FIT_REQ_TIMEOUT_USEC	1000000		/* 1s */
 #define GOYA_MSG_TO_CPU_TIMEOUT_USEC	4000000		/* 4s */
+#define GOYA_WAIT_FOR_BL_TIMEOUT_USEC	15000000	/* 15s */
 
 #define GOYA_QMAN0_FENCE_VAL		0xD169B243
 
@@ -851,6 +852,7 @@ void goya_late_fini(struct hl_device *hdev)
 
 static void goya_set_pci_memory_regions(struct hl_device *hdev)
 {
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct pci_mem_region *region;
 
 	/* CFG */
@@ -858,6 +860,7 @@ static void goya_set_pci_memory_regions(struct hl_device *hdev)
 	region->region_base = CFG_BASE;
 	region->region_size = CFG_SIZE;
 	region->offset_in_bar = CFG_BASE - SRAM_BASE_ADDR;
+	region->bar_size = CFG_BAR_SIZE;
 	region->bar_id = SRAM_CFG_BAR_ID;
 	region->used = 1;
 
@@ -866,6 +869,7 @@ static void goya_set_pci_memory_regions(struct hl_device *hdev)
 	region->region_base = SRAM_BASE_ADDR;
 	region->region_size = SRAM_SIZE;
 	region->offset_in_bar = 0;
+	region->bar_size = CFG_BAR_SIZE;
 	region->bar_id = SRAM_CFG_BAR_ID;
 	region->used = 1;
 
@@ -874,6 +878,7 @@ static void goya_set_pci_memory_regions(struct hl_device *hdev)
 	region->region_base = DRAM_PHYS_BASE;
 	region->region_size = hdev->asic_prop.dram_size;
 	region->offset_in_bar = 0;
+	region->bar_size = prop->dram_pci_bar_size;
 	region->bar_id = DDR_BAR_ID;
 	region->used = 1;
 }
@@ -2452,6 +2457,8 @@ static void goya_init_dynamic_firmware_loader(struct hl_device *hdev)
 				cpu_to_le32(mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU);
 	dyn_regs->cpu_cmd_status_to_host =
 				cpu_to_le32(mmCPU_CMD_STATUS_TO_HOST);
+
+	dynamic_loader->wait_for_bl_timeout = GOYA_WAIT_FOR_BL_TIMEOUT_USEC;
 }
 
 static void goya_init_static_firmware_loader(struct hl_device *hdev)
-- 
2.25.1


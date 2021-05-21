Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DCD38CB89
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237966AbhEURI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:08:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237942AbhEURIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:08:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B0BF613FE;
        Fri, 21 May 2021 17:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621616822;
        bh=l+Y+PX3qGh8EFlJtNXzLv5AQhs34TPs5IEsNyPUvML4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DCasIcoF5XTYqC7DYzlvUPvAKv62yH+znR5mrpHGvvgtq/3KMEbTs9cELXJm8y+pm
         +AfxTTVG6WKJNUlAHmAf0hajMT0pPtvit4Uuc3ZXa1qKaY9bKwLReRHjfKW+sjXLj6
         RLSYxjdAKcMwXvekG/EW+yBg0L+dPaE6laiJbc5/iAgOdNEiE4brL6nVHKelCm7t5i
         YTXx52b0QFmE2DCWSTkKVTSySE3FJ83+Upb99hyBUpfNHG9h1BYq/rv+qrUaS/QPVo
         uKHcnlQWQb536+09sOjKQxfaDFTtDA5rwMzc/JUM29SP0pD48q0WRk+C0eCz6JZL+S
         E27El0Z6kwGkA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Koby Elbaz <kelbaz@habana.ai>
Subject: [PATCH 4/4] habanalabs/gaudi: disable GIC usage if security is enabled
Date:   Fri, 21 May 2021 20:06:53 +0300
Message-Id: <20210521170653.4700-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210521170653.4700-1-ogabbay@kernel.org>
References: <20210521170653.4700-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Koby Elbaz <kelbaz@habana.ai>

Security is set based on PCI ID, and after reading preboot status bits.
GIC usage is set in both scenarios since GIC can't be used when security
is enabled.
Moreover, writing to GIC/SP is enabled only after Linux is fully loaded.

Signed-off-by: Koby Elbaz <kelbaz@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 25 +++++++++++---------
 drivers/misc/habanalabs/common/habanalabs.h  |  2 ++
 drivers/misc/habanalabs/gaudi/gaudi.c        | 17 +++++++++----
 3 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index cdec7212f377..399d64e4f4c2 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -1115,19 +1115,13 @@ static void hl_fw_preboot_update_state(struct hl_device *hdev)
 	 *                     b. Check whether hard reset is done by fw app
 	 *
 	 * Preboot:
-	 * Check security status bit (CPU_BOOT_DEV_STS0_ENABLED), if it is set
+	 * Check security status bit (CPU_BOOT_DEV_STS0_ENABLED). If set, then-
 	 * check security enabled bit (CPU_BOOT_DEV_STS0_SECURITY_EN)
-	 * Check GIC privileged bit (CPU_BOOT_DEV_STS0_GIC_PRIVILEGED_EN)
+	 * If set, then mark GIC controller to be disabled.
 	 */
 	if (cpu_boot_dev_sts0 & CPU_BOOT_DEV_STS0_ENABLED) {
 		prop->fw_cpu_boot_dev_sts0_valid = 1;
 
-		/* FW security should be derived from PCI ID, we keep this
-		 * check for backward compatibility
-		 */
-		if (cpu_boot_dev_sts0 & CPU_BOOT_DEV_STS0_SECURITY_EN)
-			prop->fw_security_disabled = false;
-
 		if (cpu_boot_dev_sts0 & CPU_BOOT_DEV_STS0_FW_HARD_RST_EN)
 			prop->hard_reset_done_by_fw = true;
 	} else {
@@ -1149,6 +1143,9 @@ static void hl_fw_preboot_update_state(struct hl_device *hdev)
 
 	dev_dbg(hdev->dev, "firmware-level security is %s\n",
 			prop->fw_security_disabled ? "disabled" : "enabled");
+
+	dev_dbg(hdev->dev, "GIC controller is %s\n",
+			prop->gic_interrupts_enable ? "enabled" : "disabled");
 }
 
 static int hl_fw_static_read_preboot_status(struct hl_device *hdev)
@@ -1941,9 +1938,13 @@ static int hl_fw_dynamic_wait_for_linux_active(struct hl_device *hdev,
 }
 
 /**
- * hl_fw_linux_update_state - update internal data structures after loading
- *                            Linux
- *
+ * hl_fw_linux_update_state -	update internal data structures after Linux
+ *				is loaded.
+ *				Note: Linux initialization is comprised mainly
+ *				of two stages - loading kernel (SRAM_AVAIL)
+ *				& loading ARMCP.
+ *				Therefore reading boot device status in any of
+ *				these stages might result in different values.
  *
  * @hdev: pointer to the habanalabs device structure
  * @cpu_boot_dev_sts0_reg: register holding CPU boot dev status 0
@@ -1957,6 +1958,8 @@ static void hl_fw_linux_update_state(struct hl_device *hdev,
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 
+	hdev->fw_loader.linux_loaded = true;
+
 	/* Clear reset status since we need to read again from app */
 	prop->hard_reset_done_by_fw = false;
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index c3f41f0b609f..433262bfb7e6 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -956,6 +956,7 @@ struct fw_image_props {
  * @skip_bmc: should BMC be skipped
  * @sram_bar_id: SRAM bar ID
  * @dram_bar_id: DRAM bar ID
+ * @linux_loaded: true if linux was loaded so far
  */
 struct fw_load_mgr {
 	union {
@@ -969,6 +970,7 @@ struct fw_load_mgr {
 	u8 skip_bmc;
 	u8 sram_bar_id;
 	u8 dram_bar_id;
+	u8 linux_loaded;
 };
 
 /**
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 6654f95caecd..9be3809d4d0d 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -689,6 +689,12 @@ static int gaudi_early_init(struct hl_device *hdev)
 	/* If FW security is enabled at this point it means no access to ELBI */
 	if (!hdev->asic_prop.fw_security_disabled) {
 		hdev->asic_prop.iatu_done_by_fw = true;
+
+		/*
+		 * GIC-security-bit can ONLY be set by CPUCP, so in this stage
+		 * decision can only be taken based on PCI ID security.
+		 */
+		hdev->asic_prop.gic_interrupts_enable = false;
 		goto pci_init;
 	}
 
@@ -3829,6 +3835,7 @@ static void gaudi_init_firmware_loader(struct hl_device *hdev)
 	struct fw_load_mgr *fw_loader = &hdev->fw_loader;
 
 	/* fill common fields */
+	fw_loader->linux_loaded = false;
 	fw_loader->boot_fit_img.image_name = GAUDI_BOOT_FIT_FILE;
 	fw_loader->linux_img.image_name = GAUDI_LINUX_FW_FILE;
 	fw_loader->cpu_timeout = GAUDI_CPU_TIMEOUT_USEC;
@@ -4103,11 +4110,13 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 	else
 		WREG32(mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU, KMD_MSG_GOTO_WFE);
 
-	irq_handler_offset = hdev->asic_prop.gic_interrupts_enable ?
-			mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
-			le32_to_cpu(dyn_regs->gic_host_irq_ctrl);
+	if (hdev->fw_loader.linux_loaded) {
+		irq_handler_offset = hdev->asic_prop.gic_interrupts_enable ?
+				mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
+				le32_to_cpu(dyn_regs->gic_host_irq_ctrl);
 
-	WREG32(irq_handler_offset, GAUDI_EVENT_HALT_MACHINE);
+		WREG32(irq_handler_offset, GAUDI_EVENT_HALT_MACHINE);
+	}
 
 	if (hdev->asic_prop.fw_security_disabled &&
 				!hdev->asic_prop.hard_reset_done_by_fw) {
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9813A362EC3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 11:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbhDQJHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 05:07:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235983AbhDQJHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 05:07:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CC0261208;
        Sat, 17 Apr 2021 09:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618650411;
        bh=arV05lC5l9/+XkQ3LKYcKwnry3J/bi318hn54ESmCD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IxZBPSQNU/GocZhY84he9R5bDDGgK3M8G0VocRnZU8Gs2z1yT1r8GNPc7SGG/AZv+
         60hodPBuOCYd9KtVFf0QfSX0qsN6tMbkcV/VyhmwCPb07q5zLH7VMHzC9Ej86tAYd9
         FNBcrmkc7cW/y1pWh3k3Hb/0fHcWjufcDc5/qCF1MMmc7WxeoBipvXfaJ2SLs601fJ
         p7eCsdzZ/O06g/bEQDM4B8O+VeKV1n4YEOBjb7KRbTmGHUB1ZlVAhx2A7TBwpUHGnL
         dc3cmuUWhPQxl6C1ezyxIIpIGCPWuQ+zZOexE/p0jWVRdQpLGr2MtDVf7OEZn/u0Mr
         gucgKt8FY8sGw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 6/7] habanalabs: refactor init device cpu code
Date:   Sat, 17 Apr 2021 12:06:37 +0300
Message-Id: <20210417090638.9802-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210417090638.9802-1-ogabbay@kernel.org>
References: <20210417090638.9802-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

Replace multiple arguments to init device CPU function by passing
firmware loader managing structure that is initialized per ASIC with
the loader parameters.

In addition, the FW loader management structure is now part of the
habanalabs device, this way the loader parameters will be able to be
communicated across various boot stages.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 30 ++++++++++++------
 drivers/misc/habanalabs/common/habanalabs.h  | 32 +++++++++++++++++---
 drivers/misc/habanalabs/gaudi/gaudi.c        | 24 ++++++++++-----
 drivers/misc/habanalabs/goya/goya.c          | 24 ++++++++++-----
 4 files changed, 82 insertions(+), 28 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 0a9e3cb86552..a97d9c264adc 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -973,18 +973,26 @@ int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
 	return -EINVAL;
 }
 
-int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
-			u32 msg_to_cpu_reg, u32 cpu_msg_status_reg,
-			u32 cpu_security_boot_status_reg, u32 boot_err0_reg,
-			bool skip_bmc, u32 cpu_timeout, u32 boot_fit_timeout)
+int hl_fw_init_cpu(struct hl_device *hdev)
 {
+	u32 cpu_msg_status_reg, cpu_timeout, msg_to_cpu_reg, status;
+	u32 cpu_boot_status_reg, cpu_security_boot_status_reg;
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u32 status;
+	struct fw_load_mgr *fw_loader;
 	int rc;
 
 	if (!(hdev->fw_components & FW_TYPE_BOOT_CPU))
 		return 0;
 
+	/* init loader parameters */
+	hdev->asic_funcs->init_firmware_loader(hdev);
+	fw_loader = &hdev->fw_loader;
+	cpu_security_boot_status_reg = fw_loader->cpu_boot_status_reg;
+	cpu_msg_status_reg = fw_loader->cpu_cmd_status_to_host_reg;
+	cpu_boot_status_reg = fw_loader->cpu_boot_status_reg;
+	msg_to_cpu_reg = fw_loader->kmd_msg_to_cpu_reg;
+	cpu_timeout = fw_loader->cpu_timeout;
+
 	dev_info(hdev->dev, "Going to wait for device boot (up to %lds)\n",
 		cpu_timeout / USEC_PER_SEC);
 
@@ -995,7 +1003,7 @@ int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 		status,
 		status == CPU_BOOT_STATUS_WAITING_FOR_BOOT_FIT,
 		10000,
-		boot_fit_timeout);
+		fw_loader->boot_fit_timeout);
 
 	if (rc) {
 		dev_dbg(hdev->dev,
@@ -1018,7 +1026,7 @@ int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 			status,
 			status == CPU_MSG_OK,
 			10000,
-			boot_fit_timeout);
+			fw_loader->boot_fit_timeout);
 
 		if (rc) {
 			dev_err(hdev->dev,
@@ -1088,7 +1096,7 @@ int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 	if (rc)
 		goto out;
 
-	if (skip_bmc) {
+	if (fw_loader->skip_bmc) {
 		WREG32(msg_to_cpu_reg, KMD_MSG_SKIP_BMC);
 
 		rc = hl_poll_timeout(
@@ -1135,7 +1143,8 @@ int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 		goto out;
 	}
 
-	rc = fw_read_errors(hdev, boot_err0_reg, cpu_security_boot_status_reg);
+	rc = fw_read_errors(hdev, fw_loader->boot_err0_reg,
+					cpu_security_boot_status_reg);
 	if (rc)
 		return rc;
 
@@ -1164,7 +1173,8 @@ int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 	return 0;
 
 out:
-	fw_read_errors(hdev, boot_err0_reg, cpu_security_boot_status_reg);
+	fw_read_errors(hdev, fw_loader->boot_err0_reg,
+					cpu_security_boot_status_reg);
 
 	return rc;
 }
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 6441a270e10a..9ee7a583b614 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -818,6 +818,28 @@ enum div_select_defs {
 	DIV_SEL_DIVIDED_PLL = 3,
 };
 
+/**
+ * struct fw_load_mgr - manager FW loading process
+ * @kmd_msg_to_cpu_reg: register address for KMD->CPU messages
+ * @cpu_cmd_status_to_host_reg: register address for CPU command status response
+ * @cpu_boot_status_reg: boot status register
+ * @cpu_boot_dev_status_reg: boot device status register
+ * @boot_err0_reg: boot error register
+ * @cpu_timeout: CPU response timeout in usec
+ * @boot_fit_timeout: Boot fit load timeout in usec
+ * @skip_bmc: should BMC be skipped
+ */
+struct fw_load_mgr {
+	u32 kmd_msg_to_cpu_reg;
+	u32 cpu_cmd_status_to_host_reg;
+	u32 cpu_boot_status_reg;
+	u32 cpu_boot_dev_status_reg;
+	u32 boot_err0_reg;
+	u32 cpu_timeout;
+	u32 boot_fit_timeout;
+	u8 skip_bmc;
+};
+
 /**
  * struct hl_asic_funcs - ASIC specific functions that are can be called from
  *                        common code.
@@ -939,6 +961,7 @@ enum div_select_defs {
  * @get_msi_info: Retrieve asic-specific MSI ID of the f/w async event
  * @map_pll_idx_to_fw_idx: convert driver specific per asic PLL index to
  *                         generic f/w compatible PLL Indexes
+ *@init_firmware_loader: initialize data for FW loader.
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
@@ -1064,6 +1087,7 @@ struct hl_asic_funcs {
 	void (*enable_events_from_fw)(struct hl_device *hdev);
 	void (*get_msi_info)(u32 *table);
 	int (*map_pll_idx_to_fw_idx)(u32 pll_idx);
+	void (*init_firmware_loader)(struct hl_device *hdev);
 };
 
 
@@ -1960,6 +1984,7 @@ struct hl_mmu_funcs {
  * @aggregated_cs_counters: aggregated cs counters among all contexts
  * @mmu_priv: device-specific MMU data.
  * @mmu_func: device-related MMU functions.
+ * @fw_loader: FW loader manager.
  * @dram_used_mem: current DRAM memory consumption.
  * @timeout_jiffies: device CS timeout value.
  * @max_power: the max power of the device, as configured by the sysadmin. This
@@ -2079,6 +2104,8 @@ struct hl_device {
 	struct hl_mmu_priv		mmu_priv;
 	struct hl_mmu_funcs		mmu_func[MMU_NUM_PGT_LOCATIONS];
 
+	struct fw_load_mgr		fw_loader;
+
 	atomic64_t			dram_used_mem;
 	u64				timeout_jiffies;
 	u64				max_power;
@@ -2398,10 +2425,7 @@ int get_used_pll_index(struct hl_device *hdev, u32 input_pll_index,
 int hl_fw_cpucp_pll_info_get(struct hl_device *hdev, u32 pll_index,
 		u16 *pll_freq_arr);
 int hl_fw_cpucp_power_get(struct hl_device *hdev, u64 *power);
-int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
-			u32 msg_to_cpu_reg, u32 cpu_msg_status_reg,
-			u32 cpu_security_boot_status_reg, u32 boot_err0_reg,
-			bool skip_bmc, u32 cpu_timeout, u32 boot_fit_timeout);
+int hl_fw_init_cpu(struct hl_device *hdev);
 int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
 		u32 cpu_boot_caps_reg, u32 boot_err0_reg,
 		u32 timeout);
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 81155f06c126..45c40549ded4 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -3729,6 +3729,20 @@ static int gaudi_read_device_fw_version(struct hl_device *hdev,
 	return 0;
 }
 
+static void gaudi_init_firmware_loader(struct hl_device *hdev)
+{
+	struct fw_load_mgr *fw_loader = &hdev->fw_loader;
+
+	fw_loader->kmd_msg_to_cpu_reg = mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU;
+	fw_loader->cpu_cmd_status_to_host_reg = mmCPU_CMD_STATUS_TO_HOST;
+	fw_loader->cpu_timeout = GAUDI_CPU_TIMEOUT_USEC;
+	fw_loader->boot_fit_timeout = GAUDI_BOOT_FIT_REQ_TIMEOUT_USEC;
+	fw_loader->skip_bmc = !hdev->bmc_enable;
+	fw_loader->cpu_boot_status_reg = mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS;
+	fw_loader->cpu_boot_dev_status_reg = mmCPU_BOOT_DEV_STS0;
+	fw_loader->boot_err0_reg = mmCPU_BOOT_ERR0;
+}
+
 static int gaudi_init_cpu(struct hl_device *hdev)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
@@ -3747,12 +3761,7 @@ static int gaudi_init_cpu(struct hl_device *hdev)
 	if (hdev->asic_prop.fw_security_disabled)
 		WREG32(mmCPU_IF_CPU_MSB_ADDR, hdev->cpu_pci_msb_addr);
 
-	rc = hl_fw_init_cpu(hdev, mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS,
-			mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU,
-			mmCPU_CMD_STATUS_TO_HOST,
-			mmCPU_BOOT_DEV_STS0, mmCPU_BOOT_ERR0,
-			!hdev->bmc_enable, GAUDI_CPU_TIMEOUT_USEC,
-			GAUDI_BOOT_FIT_REQ_TIMEOUT_USEC);
+	rc = hl_fw_init_cpu(hdev);
 
 	if (rc)
 		return rc;
@@ -8851,7 +8860,8 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.get_hw_block_id = gaudi_get_hw_block_id,
 	.hw_block_mmap = gaudi_block_mmap,
 	.enable_events_from_fw = gaudi_enable_events_from_fw,
-	.map_pll_idx_to_fw_idx = gaudi_map_pll_idx_to_fw_idx
+	.map_pll_idx_to_fw_idx = gaudi_map_pll_idx_to_fw_idx,
+	.init_firmware_loader = gaudi_init_firmware_loader,
 };
 
 /**
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index e0ad2a269779..d554304b6868 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2445,6 +2445,20 @@ static int goya_read_device_fw_version(struct hl_device *hdev,
 	return 0;
 }
 
+static void goya_init_firmware_loader(struct hl_device *hdev)
+{
+	struct fw_load_mgr *fw_loader = &hdev->fw_loader;
+
+	fw_loader->kmd_msg_to_cpu_reg = mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU;
+	fw_loader->cpu_cmd_status_to_host_reg = mmCPU_CMD_STATUS_TO_HOST;
+	fw_loader->cpu_timeout = GOYA_CPU_TIMEOUT_USEC;
+	fw_loader->boot_fit_timeout = GOYA_BOOT_FIT_REQ_TIMEOUT_USEC;
+	fw_loader->skip_bmc = false;
+	fw_loader->cpu_boot_status_reg = mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS;
+	fw_loader->cpu_boot_dev_status_reg = mmCPU_BOOT_DEV_STS0;
+	fw_loader->boot_err0_reg = mmCPU_BOOT_ERR0;
+}
+
 static int goya_init_cpu(struct hl_device *hdev)
 {
 	struct goya_device *goya = hdev->asic_specific;
@@ -2466,12 +2480,7 @@ static int goya_init_cpu(struct hl_device *hdev)
 		return -EIO;
 	}
 
-	rc = hl_fw_init_cpu(hdev, mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS,
-			mmPSOC_GLOBAL_CONF_UBOOT_MAGIC,
-			mmCPU_CMD_STATUS_TO_HOST,
-			mmCPU_BOOT_DEV_STS0, mmCPU_BOOT_ERR0,
-			false, GOYA_CPU_TIMEOUT_USEC,
-			GOYA_BOOT_FIT_REQ_TIMEOUT_USEC);
+	rc = hl_fw_init_cpu(hdev);
 
 	if (rc)
 		return rc;
@@ -5584,7 +5593,8 @@ static const struct hl_asic_funcs goya_funcs = {
 	.get_hw_block_id = goya_get_hw_block_id,
 	.hw_block_mmap = goya_block_mmap,
 	.enable_events_from_fw = goya_enable_events_from_fw,
-	.map_pll_idx_to_fw_idx = goya_map_pll_idx_to_fw_idx
+	.map_pll_idx_to_fw_idx = goya_map_pll_idx_to_fw_idx,
+	.init_firmware_loader = goya_init_firmware_loader
 };
 
 /*
-- 
2.25.1


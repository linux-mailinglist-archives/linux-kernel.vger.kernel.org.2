Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B45F440FBA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 18:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhJaRVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 13:21:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230209AbhJaRVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 13:21:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69BE960F58;
        Sun, 31 Oct 2021 17:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635700750;
        bh=xA77m81fyMxh3zwph1KZekEvERMWOszJWOKbRAfOKGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lmBa6HPIkoCV0EfcgSGl/HMmyZehS1U4j0u/9Zg23eOCKfpprI09gxORYPy2smRag
         QRrmB2t/FJHAeGt4PpkxLofsochb2K4nHesvxLguLbEHPyA/rhwjqcUfcqoygi+J5Y
         NuRNUNSdgg6Rt0ffxF9ExIGlrWm6PZ6Zj37rpRVdgW3JyclVE+1W4hMhu9VchnZM70
         MkYsbXH56GWeOHS+D+nhSEvJhRlKlgn0anNmOcYonkRUzPYb8uWYX6c4KiR5q6VqsE
         VN2Viia1RTRnTJdjWrAT7K0Xkk5aNSv02ohx3sVyG5uSLREw3K5+2V3rMygahrWjDk
         CI15zcfqiTvSg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 3/4] habanalabs: adding indication of boot fit loaded
Date:   Sun, 31 Oct 2021 19:19:01 +0200
Message-Id: <20211031171902.220708-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211031171902.220708-1-ogabbay@kernel.org>
References: <20211031171902.220708-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

Up until now the driver stored indication if Linux was loaded on the
device CPU. This was needed in order to coordinate some tasks that are
performed by the Linux.

In future ASICs, many of those tasks will be performed by the boot
fit, so now we need the same indication of boot fit load status.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c      | 4 ++--
 drivers/misc/habanalabs/common/firmware_if.c | 4 +++-
 drivers/misc/habanalabs/common/habanalabs.h  | 7 +++++--
 drivers/misc/habanalabs/gaudi/gaudi.c        | 4 ++--
 drivers/misc/habanalabs/goya/goya.c          | 2 +-
 5 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 2022e5d7b3ad..9674e2520532 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1138,7 +1138,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	hdev->asic_funcs->hw_fini(hdev, hard_reset, fw_reset);
 
 	if (hard_reset) {
-		hdev->fw_loader.linux_loaded = false;
+		hdev->fw_loader.fw_comp_loaded = FW_TYPE_NONE;
 
 		/* Release kernel context */
 		if (hdev->kernel_ctx && hl_ctx_put(hdev->kernel_ctx) == 1)
@@ -1692,7 +1692,7 @@ void hl_device_fini(struct hl_device *hdev)
 	/* Reset the H/W. It will be in idle state after this returns */
 	hdev->asic_funcs->hw_fini(hdev, true, false);
 
-	hdev->fw_loader.linux_loaded = false;
+	hdev->fw_loader.fw_comp_loaded = FW_TYPE_NONE;
 
 	/* Release kernel context */
 	if ((hdev->kernel_ctx) && (hl_ctx_put(hdev->kernel_ctx) != 1))
diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 482bed152c39..8cbec10cddb1 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -1919,6 +1919,8 @@ static void hl_fw_boot_fit_update_state(struct hl_device *hdev,
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 
+	hdev->fw_loader.fw_comp_loaded |= FW_TYPE_BOOT_CPU;
+
 	/* Clear reset status since we need to read it again from boot CPU */
 	prop->hard_reset_done_by_fw = false;
 
@@ -2127,7 +2129,7 @@ static void hl_fw_linux_update_state(struct hl_device *hdev,
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 
-	hdev->fw_loader.linux_loaded = true;
+	hdev->fw_loader.fw_comp_loaded |= FW_TYPE_LINUX;
 
 	/* Clear reset status since we need to read again from app */
 	prop->hard_reset_done_by_fw = false;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index aac73c8d2e1d..b3c6b660c7aa 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -219,6 +219,7 @@ enum hl_fw_component {
 
 /**
  * enum hl_fw_types - F/W types present in the system
+ * @FW_TYPE_NONE: no FW component indication
  * @FW_TYPE_LINUX: Linux image for device CPU
  * @FW_TYPE_BOOT_CPU: Boot image for device CPU
  * @FW_TYPE_PREBOOT_CPU: Indicates pre-loaded CPUs are present in the system
@@ -226,6 +227,7 @@ enum hl_fw_component {
  * @FW_TYPE_ALL_TYPES: Mask for all types
  */
 enum hl_fw_types {
+	FW_TYPE_NONE = 0x0,
 	FW_TYPE_LINUX = 0x1,
 	FW_TYPE_BOOT_CPU = 0x2,
 	FW_TYPE_PREBOOT_CPU = 0x4,
@@ -1059,7 +1061,8 @@ struct fw_image_props {
  * @skip_bmc: should BMC be skipped
  * @sram_bar_id: SRAM bar ID
  * @dram_bar_id: DRAM bar ID
- * @linux_loaded: true if linux was loaded so far
+ * @fw_comp_loaded: bitmask of loaded FW components. set bit meaning loaded
+ *                  component. values are set according to enum hl_fw_types.
  */
 struct fw_load_mgr {
 	union {
@@ -1073,7 +1076,7 @@ struct fw_load_mgr {
 	u8 skip_bmc;
 	u8 sram_bar_id;
 	u8 dram_bar_id;
-	u8 linux_loaded;
+	u8 fw_comp_loaded;
 };
 
 /**
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 2e39514ee102..1dcce1bc976f 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -4007,7 +4007,7 @@ static void gaudi_init_firmware_loader(struct hl_device *hdev)
 	struct fw_load_mgr *fw_loader = &hdev->fw_loader;
 
 	/* fill common fields */
-	fw_loader->linux_loaded = false;
+	fw_loader->fw_comp_loaded = FW_TYPE_NONE;
 	fw_loader->boot_fit_img.image_name = GAUDI_BOOT_FIT_FILE;
 	fw_loader->linux_img.image_name = GAUDI_LINUX_FW_FILE;
 	fw_loader->cpu_timeout = GAUDI_CPU_TIMEOUT_USEC;
@@ -4290,7 +4290,7 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset, bool fw_reset
 	 * via the GIC. Otherwise, we need to use COMMS or the MSG_TO_CPU
 	 * registers in case of old F/Ws
 	 */
-	if (hdev->fw_loader.linux_loaded) {
+	if (hdev->fw_loader.fw_comp_loaded & FW_TYPE_LINUX) {
 		irq_handler_offset = hdev->asic_prop.gic_interrupts_enable ?
 				mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
 				le32_to_cpu(dyn_regs->gic_host_halt_irq);
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 6ee6d5b915a1..ce06103292a0 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2504,7 +2504,7 @@ static void goya_init_firmware_loader(struct hl_device *hdev)
 	struct fw_load_mgr *fw_loader = &hdev->fw_loader;
 
 	/* fill common fields */
-	fw_loader->linux_loaded = false;
+	fw_loader->fw_comp_loaded = FW_TYPE_NONE;
 	fw_loader->boot_fit_img.image_name = GOYA_BOOT_FIT_FILE;
 	fw_loader->linux_img.image_name = GOYA_LINUX_FW_FILE;
 	fw_loader->cpu_timeout = GOYA_CPU_TIMEOUT_USEC;
-- 
2.25.1


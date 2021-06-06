Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431D339CE18
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 10:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhFFIZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 04:25:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230215AbhFFIZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 04:25:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A5FD61422;
        Sun,  6 Jun 2021 08:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622967812;
        bh=o64deMTovHBQZMwHKIpDGDoazcvIwNE+XFVoRq/PIDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nV4z/t+ilK05w0EQqGUwwi5MpUIE+nr3A+QJUnOftsuHAszF3ZjCOPDNAJssq1wJ5
         WS9zSZQgVr4i/nkvS5tXCW/nh14D081oII75J7QGXJ0mffhLukWHcBQkWOBc0RwMql
         0XzHuvabSEKhEvYJVX/raffKH8HFbusfkrwYVVA3Ijk9rJS+P0pFTk61CvXH8xfHh5
         39zQWDTQoftzTeK3ifusrq9VwD3IIykQuySqtXEboossTs0UTjBNeb8mdtfHBR8Yib
         3nEcpm/7GSTxrsrJH/q9dACbCceWH7eUJY6mrfsDMFfWU9Uj3xmImIC1+QXk89yG+X
         3juONZ1K1tUKg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 5/6] habanalabs: skip valid test for boot_dev_sts regs
Date:   Sun,  6 Jun 2021 11:23:19 +0300
Message-Id: <20210606082320.4319-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210606082320.4319-1-ogabbay@kernel.org>
References: <20210606082320.4319-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

Get rid of the need to check if boot_dev_sts is valid on every access
to value read from these registers.

This is done by storing the register value in hdev props ONLY if
register is enabled.

This way if register is NOT enabled all capability bits will not be set.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 56 +++++++++++---------
 drivers/misc/habanalabs/gaudi/gaudi.c        | 25 ++++-----
 2 files changed, 40 insertions(+), 41 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 40e91985cb48..9412e6707906 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -216,9 +216,7 @@ int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 		goto out;
 	}
 
-	if (prop->fw_cpu_boot_dev_sts0_valid &&
-				(prop->fw_app_cpu_boot_dev_sts0 &
-					CPU_BOOT_DEV_STS0_PKT_PI_ACK_EN))
+	if (prop->fw_app_cpu_boot_dev_sts0 & CPU_BOOT_DEV_STS0_PKT_PI_ACK_EN)
 		expected_ack_val = queue->pi;
 	else
 		expected_ack_val = CPUCP_PACKET_FENCE_VAL;
@@ -838,8 +836,8 @@ int get_used_pll_index(struct hl_device *hdev, u32 input_pll_index,
 	bool dynamic_pll;
 	int fw_pll_idx;
 
-	dynamic_pll = prop->fw_cpu_boot_dev_sts0_valid &&
-		(prop->fw_app_cpu_boot_dev_sts0 & CPU_BOOT_DEV_STS0_DYN_PLL_EN);
+	dynamic_pll = !!(prop->fw_app_cpu_boot_dev_sts0 &
+						CPU_BOOT_DEV_STS0_DYN_PLL_EN);
 
 	if (!dynamic_pll) {
 		/*
@@ -988,7 +986,7 @@ static int hl_fw_read_preboot_caps(struct hl_device *hdev,
 					u32 timeout)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u32 status;
+	u32 status, reg_val;
 	int rc;
 
 	/* Need to check two possible scenarios:
@@ -1026,14 +1024,30 @@ static int hl_fw_read_preboot_caps(struct hl_device *hdev,
 		return -EIO;
 	}
 
-	prop->fw_preboot_cpu_boot_dev_sts0 = RREG32(sts_boot_dev_sts0_reg);
-	prop->fw_preboot_cpu_boot_dev_sts1 = RREG32(sts_boot_dev_sts1_reg);
+	/*
+	 * the registers DEV_STS* contain FW capabilities/features.
+	 * We can rely on this registers only if bit CPU_BOOT_DEV_STS*_ENABLED
+	 * is set.
+	 * In the first read of this register we store the value of this
+	 * register ONLY if the register is enabled (which will be propagated
+	 * to next stages) and also mark the register as valid.
+	 * In case it is not enabled the stored value will be left 0- all
+	 * caps/features are off
+	 */
+	reg_val = RREG32(sts_boot_dev_sts0_reg);
+	if (reg_val & CPU_BOOT_DEV_STS0_ENABLED) {
+		prop->fw_cpu_boot_dev_sts0_valid = true;
+		prop->fw_preboot_cpu_boot_dev_sts0 = reg_val;
+	}
 
-	if (prop->fw_preboot_cpu_boot_dev_sts0 & CPU_BOOT_DEV_STS0_ENABLED)
-		prop->dynamic_fw_load = !!(prop->fw_preboot_cpu_boot_dev_sts0 &
+	reg_val = RREG32(sts_boot_dev_sts1_reg);
+	if (reg_val & CPU_BOOT_DEV_STS1_ENABLED) {
+		prop->fw_cpu_boot_dev_sts1_valid = true;
+		prop->fw_preboot_cpu_boot_dev_sts1 = reg_val;
+	}
+
+	prop->dynamic_fw_load = !!(prop->fw_preboot_cpu_boot_dev_sts0 &
 						CPU_BOOT_DEV_STS0_FW_LD_COM_EN);
-	else
-		prop->dynamic_fw_load = 0;
 
 	/* initialize FW loader once we know what load protocol is used */
 	hdev->asic_funcs->init_firmware_loader(hdev);
@@ -1105,7 +1119,7 @@ static void hl_fw_preboot_update_state(struct hl_device *hdev)
 	cpu_boot_dev_sts0 = prop->fw_preboot_cpu_boot_dev_sts0;
 	cpu_boot_dev_sts1 = prop->fw_preboot_cpu_boot_dev_sts1;
 
-	/* We read security status multiple times during boot:
+	/* We read boot_dev_sts registers multiple times during boot:
 	 * 1. preboot - a. Check whether the security status bits are valid
 	 *              b. Check whether fw security is enabled
 	 *              c. Check whether hard reset is done by preboot
@@ -1119,18 +1133,8 @@ static void hl_fw_preboot_update_state(struct hl_device *hdev)
 	 * check security enabled bit (CPU_BOOT_DEV_STS0_SECURITY_EN)
 	 * If set, then mark GIC controller to be disabled.
 	 */
-	if (cpu_boot_dev_sts0 & CPU_BOOT_DEV_STS0_ENABLED) {
-		prop->fw_cpu_boot_dev_sts0_valid = 1;
-
-		if (cpu_boot_dev_sts0 & CPU_BOOT_DEV_STS0_FW_HARD_RST_EN)
-			prop->hard_reset_done_by_fw = true;
-	} else {
-		prop->fw_cpu_boot_dev_sts0_valid = 0;
-	}
-
-	/* place holder for STS1 as no statuses are defined yet */
-	prop->fw_cpu_boot_dev_sts1_valid =
-			!!(cpu_boot_dev_sts1 & CPU_BOOT_DEV_STS1_ENABLED);
+	prop->hard_reset_done_by_fw =
+		!!(cpu_boot_dev_sts0 & CPU_BOOT_DEV_STS0_FW_HARD_RST_EN);
 
 	dev_dbg(hdev->dev, "Firmware preboot boot device status0 %#x\n",
 							cpu_boot_dev_sts0);
@@ -1781,7 +1785,7 @@ static void hl_fw_boot_fit_update_state(struct hl_device *hdev,
 	prop->hard_reset_done_by_fw = false;
 
 	/* Read boot_cpu status bits */
-	if (prop->fw_cpu_boot_dev_sts0_valid) {
+	if (prop->fw_preboot_cpu_boot_dev_sts0 & CPU_BOOT_DEV_STS0_ENABLED) {
 		prop->fw_bootfit_cpu_boot_dev_sts0 =
 				RREG32(cpu_boot_dev_sts0_reg);
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 9a4b0b495a29..792d8a382c10 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1980,9 +1980,8 @@ static void gaudi_init_scrambler_sram(struct hl_device *hdev)
 	if (hdev->asic_prop.fw_security_enabled)
 		return;
 
-	if (hdev->asic_prop.fw_cpu_boot_dev_sts0_valid &&
-			(hdev->asic_prop.fw_app_cpu_boot_dev_sts0 &
-					CPU_BOOT_DEV_STS0_SRAM_SCR_EN))
+	if (hdev->asic_prop.fw_app_cpu_boot_dev_sts0 &
+						CPU_BOOT_DEV_STS0_SRAM_SCR_EN)
 		return;
 
 	if (gaudi->hw_cap_initialized & HW_CAP_SRAM_SCRAMBLER)
@@ -2052,9 +2051,8 @@ static void gaudi_init_scrambler_hbm(struct hl_device *hdev)
 	if (hdev->asic_prop.fw_security_enabled)
 		return;
 
-	if (hdev->asic_prop.fw_cpu_boot_dev_sts0_valid &&
-			(hdev->asic_prop.fw_bootfit_cpu_boot_dev_sts0 &
-					CPU_BOOT_DEV_STS0_DRAM_SCR_EN))
+	if (hdev->asic_prop.fw_bootfit_cpu_boot_dev_sts0 &
+					CPU_BOOT_DEV_STS0_DRAM_SCR_EN)
 		return;
 
 	if (gaudi->hw_cap_initialized & HW_CAP_HBM_SCRAMBLER)
@@ -2122,9 +2120,8 @@ static void gaudi_init_e2e(struct hl_device *hdev)
 	if (hdev->asic_prop.fw_security_enabled)
 		return;
 
-	if (hdev->asic_prop.fw_cpu_boot_dev_sts0_valid &&
-			(hdev->asic_prop.fw_bootfit_cpu_boot_dev_sts0 &
-					CPU_BOOT_DEV_STS0_E2E_CRED_EN))
+	if (hdev->asic_prop.fw_bootfit_cpu_boot_dev_sts0 &
+					CPU_BOOT_DEV_STS0_E2E_CRED_EN)
 		return;
 
 	WREG32(mmSIF_RTR_CTRL_0_E2E_HBM_WR_SIZE, 247 >> 3);
@@ -2497,9 +2494,8 @@ static void gaudi_init_hbm_cred(struct hl_device *hdev)
 	if (hdev->asic_prop.fw_security_enabled)
 		return;
 
-	if (hdev->asic_prop.fw_cpu_boot_dev_sts0_valid &&
-			(hdev->asic_prop.fw_bootfit_cpu_boot_dev_sts0 &
-					CPU_BOOT_DEV_STS0_HBM_CRED_EN))
+	if (hdev->asic_prop.fw_bootfit_cpu_boot_dev_sts0 &
+						CPU_BOOT_DEV_STS0_HBM_CRED_EN)
 		return;
 
 	hbm0_wr = 0x33333333;
@@ -7477,9 +7473,8 @@ static int gaudi_hbm_read_interrupts(struct hl_device *hdev, int device,
 	u32 base, val, val2, wr_par, rd_par, ca_par, derr, serr, type, ch;
 	int err = 0;
 
-	if (hdev->asic_prop.fw_cpu_boot_dev_sts0_valid &&
-			(hdev->asic_prop.fw_app_cpu_boot_dev_sts0 &
-				CPU_BOOT_DEV_STS0_HBM_ECC_EN)) {
+	if (hdev->asic_prop.fw_app_cpu_boot_dev_sts0 &
+					CPU_BOOT_DEV_STS0_HBM_ECC_EN) {
 		if (!hbm_ecc_data) {
 			dev_err(hdev->dev, "No FW ECC data");
 			return 0;
-- 
2.25.1


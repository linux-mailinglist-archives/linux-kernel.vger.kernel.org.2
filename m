Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C5B3D2297
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 13:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhGVKgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 06:36:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231634AbhGVKgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 06:36:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E21DF61279;
        Thu, 22 Jul 2021 11:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626952609;
        bh=xb2Y8osVz6uiWpAfpMK9T2/tt6vKtBdsfoj6bSK6jYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I38zILjdUr6cb76tC6GSXBDTAJjEDoAU4BymKIO99zHzh979yczdmACz/zPSlYZz4
         eilS2mcXkFZ1gUxplR0YlEGK3Q1+dzq1r4bSpn+RRQ6gL0Bs/Ddvw4Al7d1esWfTyd
         qG/P48/dBShacmxVHPDweZpK2TjgSkyuMfaPCkUpppyPHJdFXMyX/p2q8raAd+GMb+
         fiBQpKEGAWiy5N6QMb9y+fGXiU72e6fP4oHNVs8sO/rcIsCeCynzVSObl8m3VD0ANh
         YwFltwwVEmZXjuHXjRFMO2yVRtye1UmIJK346TwYKPDmH27rheLreZeyHlO6yJ7ryw
         iP1k35IK2oFiQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Koby Elbaz <kelbaz@habana.ai>
Subject: [PATCH 2/3] habanalabs: clear msg_to_cpu_reg to avoid misread after reset
Date:   Thu, 22 Jul 2021 14:16:42 +0300
Message-Id: <20210722111643.17568-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210722111643.17568-1-ogabbay@kernel.org>
References: <20210722111643.17568-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Koby Elbaz <kelbaz@habana.ai>

For some ASICs, the f/w reads the msg_to_cpu_reg value after
reset, and for some it doesn't.
Therefore, to be sure f/w doesn't read a wrong value after reset, we
need to clear this register before the reset occurs.

Signed-off-by: Koby Elbaz <kelbaz@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 28 +++++++++-----------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 0be3f5414f0b..c232d197b57a 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -667,17 +667,15 @@ int hl_fw_cpucp_info_get(struct hl_device *hdev,
 	hdev->event_queue.check_eqe_index = false;
 
 	/* Read FW application security bits again */
-	if (hdev->asic_prop.fw_cpu_boot_dev_sts0_valid) {
-		hdev->asic_prop.fw_app_cpu_boot_dev_sts0 =
-						RREG32(sts_boot_dev_sts0_reg);
-		if (hdev->asic_prop.fw_app_cpu_boot_dev_sts0 &
+	if (prop->fw_cpu_boot_dev_sts0_valid) {
+		prop->fw_app_cpu_boot_dev_sts0 = RREG32(sts_boot_dev_sts0_reg);
+		if (prop->fw_app_cpu_boot_dev_sts0 &
 				CPU_BOOT_DEV_STS0_EQ_INDEX_EN)
 			hdev->event_queue.check_eqe_index = true;
 	}
 
-	if (hdev->asic_prop.fw_cpu_boot_dev_sts1_valid)
-		hdev->asic_prop.fw_app_cpu_boot_dev_sts1 =
-						RREG32(sts_boot_dev_sts1_reg);
+	if (prop->fw_cpu_boot_dev_sts1_valid)
+		prop->fw_app_cpu_boot_dev_sts1 = RREG32(sts_boot_dev_sts1_reg);
 
 out:
 	hdev->asic_funcs->cpu_accessible_dma_pool_free(hdev,
@@ -1012,6 +1010,11 @@ void hl_fw_ask_halt_machine_without_linux(struct hl_device *hdev)
 	} else {
 		WREG32(static_loader->kmd_msg_to_cpu_reg, KMD_MSG_GOTO_WFE);
 		msleep(static_loader->cpu_reset_wait_msec);
+
+		/* Must clear this register in order to prevent preboot
+		 * from reading WFE after reboot
+		 */
+		WREG32(static_loader->kmd_msg_to_cpu_reg, KMD_MSG_NA);
 	}
 
 	hdev->device_cpu_is_halted = true;
@@ -1242,11 +1245,6 @@ static void hl_fw_preboot_update_state(struct hl_device *hdev)
 	 *               b. Check whether hard reset is done by boot cpu
 	 * 3. FW application - a. Fetch fw application security status
 	 *                     b. Check whether hard reset is done by fw app
-	 *
-	 * Preboot:
-	 * Check security status bit (CPU_BOOT_DEV_STS0_ENABLED). If set, then-
-	 * check security enabled bit (CPU_BOOT_DEV_STS0_SECURITY_EN)
-	 * If set, then mark GIC controller to be disabled.
 	 */
 	prop->hard_reset_done_by_fw =
 		!!(cpu_boot_dev_sts0 & CPU_BOOT_DEV_STS0_FW_HARD_RST_EN);
@@ -2126,8 +2124,7 @@ static void hl_fw_linux_update_state(struct hl_device *hdev,
 
 	/* Read FW application security bits */
 	if (prop->fw_cpu_boot_dev_sts0_valid) {
-		prop->fw_app_cpu_boot_dev_sts0 =
-				RREG32(cpu_boot_dev_sts0_reg);
+		prop->fw_app_cpu_boot_dev_sts0 = RREG32(cpu_boot_dev_sts0_reg);
 
 		if (prop->fw_app_cpu_boot_dev_sts0 &
 				CPU_BOOT_DEV_STS0_FW_HARD_RST_EN)
@@ -2147,8 +2144,7 @@ static void hl_fw_linux_update_state(struct hl_device *hdev,
 	}
 
 	if (prop->fw_cpu_boot_dev_sts1_valid) {
-		prop->fw_app_cpu_boot_dev_sts1 =
-				RREG32(cpu_boot_dev_sts1_reg);
+		prop->fw_app_cpu_boot_dev_sts1 = RREG32(cpu_boot_dev_sts1_reg);
 
 		dev_dbg(hdev->dev,
 			"Firmware application CPU status1 %#x\n",
-- 
2.25.1


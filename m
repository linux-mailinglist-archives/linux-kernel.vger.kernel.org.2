Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672874475EC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 21:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbhKGUy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 15:54:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:56260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235254AbhKGUyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 15:54:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EABD060E94;
        Sun,  7 Nov 2021 20:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636318302;
        bh=Gz+8GwcaMdsEmrxoXy3SRin2rwKrtOAwJOeJyAIOKT8=;
        h=From:To:Cc:Subject:Date:From;
        b=qnVFY+L+r8rzxkrr/4+ISdxr+Fd0tht0sdr9kTA2d6R2Qs68DAC+MGaLbl1OFwoiX
         eGMJRsDLtsbAdpFdJMzpEntKbsvVbg1609rzBw+hA1l3U08Oy3ep2da5uBTa68+Pga
         fsOK7OpBzN7p01CpJWQ8i/0DXzkTdRpuCTqO6CXnKl583vBVIYtBAqY9b2P+6rT9Wp
         NQDAxI7DTkQ8ziaJklNBoCzCFqANqynJROPI0zLykCPYOfduMkwxcKytGz6GZCFzBz
         Vijyppw92v9e9ME49Y8Vxb3yxBBD0iaWXm93D+F+vypbWKtZKgswE/5ds47kfHqtyi
         z2UItFSnVhBbg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 01/10] habanalabs: don't clear previous f/w indications
Date:   Sun,  7 Nov 2021 22:51:27 +0200
Message-Id: <20211107205136.2329007-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

Once we read indication of whether f/w is doing the reset, we don't
want to clear it, until the next time we read this indication.

Otherwise, we might be in a state of wrong indication.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index c68ad4d7b1bb..9addcfba6a8b 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -1247,8 +1247,7 @@ static void hl_fw_preboot_update_state(struct hl_device *hdev)
 	 * 3. FW application - a. Fetch fw application security status
 	 *                     b. Check whether hard reset is done by fw app
 	 */
-	prop->hard_reset_done_by_fw =
-		!!(cpu_boot_dev_sts0 & CPU_BOOT_DEV_STS0_FW_HARD_RST_EN);
+	prop->hard_reset_done_by_fw = !!(cpu_boot_dev_sts0 & CPU_BOOT_DEV_STS0_FW_HARD_RST_EN);
 
 	dev_dbg(hdev->dev, "Firmware preboot boot device status0 %#x\n",
 							cpu_boot_dev_sts0);
@@ -1915,17 +1914,13 @@ static void hl_fw_boot_fit_update_state(struct hl_device *hdev,
 
 	hdev->fw_loader.fw_comp_loaded |= FW_TYPE_BOOT_CPU;
 
-	/* Clear reset status since we need to read it again from boot CPU */
-	prop->hard_reset_done_by_fw = false;
-
 	/* Read boot_cpu status bits */
 	if (prop->fw_preboot_cpu_boot_dev_sts0 & CPU_BOOT_DEV_STS0_ENABLED) {
 		prop->fw_bootfit_cpu_boot_dev_sts0 =
 				RREG32(cpu_boot_dev_sts0_reg);
 
-		if (prop->fw_bootfit_cpu_boot_dev_sts0 &
-				CPU_BOOT_DEV_STS0_FW_HARD_RST_EN)
-			prop->hard_reset_done_by_fw = true;
+		prop->hard_reset_done_by_fw = !!(prop->fw_bootfit_cpu_boot_dev_sts0 &
+							CPU_BOOT_DEV_STS0_FW_HARD_RST_EN);
 
 		dev_dbg(hdev->dev, "Firmware boot CPU status0 %#x\n",
 					prop->fw_bootfit_cpu_boot_dev_sts0);
@@ -2125,16 +2120,12 @@ static void hl_fw_linux_update_state(struct hl_device *hdev,
 
 	hdev->fw_loader.fw_comp_loaded |= FW_TYPE_LINUX;
 
-	/* Clear reset status since we need to read again from app */
-	prop->hard_reset_done_by_fw = false;
-
 	/* Read FW application security bits */
 	if (prop->fw_cpu_boot_dev_sts0_valid) {
 		prop->fw_app_cpu_boot_dev_sts0 = RREG32(cpu_boot_dev_sts0_reg);
 
-		if (prop->fw_app_cpu_boot_dev_sts0 &
-				CPU_BOOT_DEV_STS0_FW_HARD_RST_EN)
-			prop->hard_reset_done_by_fw = true;
+		prop->hard_reset_done_by_fw = !!(prop->fw_app_cpu_boot_dev_sts0 &
+							CPU_BOOT_DEV_STS0_FW_HARD_RST_EN);
 
 		if (prop->fw_app_cpu_boot_dev_sts0 &
 				CPU_BOOT_DEV_STS0_GIC_PRIVILEGED_EN)
-- 
2.25.1


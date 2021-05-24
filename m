Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C24438E288
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 10:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbhEXIr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 04:47:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232471AbhEXIrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 04:47:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26F806113B;
        Mon, 24 May 2021 08:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621845985;
        bh=yERjAWZasI70550xDq/cBJlx0jmw3br4ac4vm2Inq2k=;
        h=From:To:Cc:Subject:Date:From;
        b=nNPw5La71aVDbkTpbb8so0a7YqvarBO1gz66Ct4HK1aTJQUR+NeSfLnvbkjxq4DB0
         LbfswUAhIGMFPtt/DTMu+9nMd3zDr8MChI68cReZakAh59vjcC6DyK+cNso9Wapam1
         5eonxei39rKhINOoE5HdcjXzGDTL+kIYjJn6NDFtG7wBLvF1h8Eqe7yWvHDOeQFxv0
         HCyIJk3Uqn18UXMVB2Abc81Yv+oOgd+jxKzStQzPF2lkOmUPQoyTFBwTIaNPO6MP11
         WZZfF9SBcPe2/leqkQPO/jaOO8wwi4A6W1aa5qLIFjBOLfyyzWOvaxUruCKfxIVA/s
         uGQDliuZd0S+A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Koby Elbaz <kelbaz@habana.ai>
Subject: [PATCH 1/3] habanalabs/gaudi: use COMMS to reset device / halt CPU
Date:   Mon, 24 May 2021 11:46:17 +0300
Message-Id: <20210524084619.4680-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Koby Elbaz <kelbaz@habana.ai>

This is needed because legacy FW 'communication' protocol will soon
become obsolete.
Because COMMS is a boot protocol, communicating through it is supported
only until Linux is loaded to the device CPU, where in that case we
will fallback to the former implementation.

Signed-off-by: Koby Elbaz <kelbaz@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c |  2 +-
 drivers/misc/habanalabs/common/habanalabs.h  |  5 ++-
 drivers/misc/habanalabs/gaudi/gaudi.c        | 36 ++++++++++++++++++--
 3 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 399d64e4f4c2..c19acefdb7e4 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -1390,7 +1390,7 @@ static int hl_fw_dynamic_send_clear_cmd(struct hl_device *hdev,
  *             leftovers between command
  * NOOP command: necessary to avoid loop on the clear command by the FW
  */
-static int hl_fw_dynamic_send_protocol_cmd(struct hl_device *hdev,
+int hl_fw_dynamic_send_protocol_cmd(struct hl_device *hdev,
 				struct fw_load_mgr *fw_loader,
 				enum comms_cmd cmd, unsigned int size,
 				bool wait_ok, u32 timeout)
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 433262bfb7e6..f1ff4d503cf2 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2574,7 +2574,10 @@ int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
 				u32 sts_boot_dev_sts0_reg,
 				u32 sts_boot_dev_sts1_reg, u32 boot_err0_reg,
 				u32 boot_err1_reg, u32 timeout);
-
+int hl_fw_dynamic_send_protocol_cmd(struct hl_device *hdev,
+				struct fw_load_mgr *fw_loader,
+				enum comms_cmd cmd, unsigned int size,
+				bool wait_ok, u32 timeout);
 int hl_pci_bars_map(struct hl_device *hdev, const char * const name[3],
 			bool is_wc[3]);
 int hl_pci_elbi_read(struct hl_device *hdev, u64 addr, u32 *data);
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 9be3809d4d0d..e155fae5edcb 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1931,6 +1931,38 @@ static void gaudi_disable_msi(struct hl_device *hdev)
 	gaudi->hw_cap_initialized &= ~HW_CAP_MSI;
 }
 
+static void gaudi_fw_hard_reset(struct hl_device *hdev)
+{
+	int rc;
+
+	if (hdev->asic_prop.dynamic_fw_load && !hdev->fw_loader.linux_loaded) {
+		rc = hl_fw_dynamic_send_protocol_cmd(hdev, &hdev->fw_loader,
+				COMMS_RST_DEV, 0, false,
+				hdev->fw_loader.cpu_timeout);
+		if (rc)
+			dev_warn(hdev->dev, "Failed sending COMMS_RST_DEV\n");
+	} else {
+		WREG32(mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU, KMD_MSG_RST_DEV);
+	}
+}
+
+static void gaudi_fw_halt_cpu(struct hl_device *hdev)
+{
+	int rc;
+
+	/* Stop device CPU to make sure nothing bad happens */
+	if (hdev->asic_prop.dynamic_fw_load && !hdev->fw_loader.linux_loaded) {
+		rc = hl_fw_dynamic_send_protocol_cmd(hdev, &hdev->fw_loader,
+				COMMS_GOTO_WFE, 0, true,
+				hdev->fw_loader.cpu_timeout);
+		if (rc)
+			dev_warn(hdev->dev, "Failed sending COMMS_GOTO_WFE\n");
+	} else {
+		WREG32(mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU, KMD_MSG_GOTO_WFE);
+		msleep(GAUDI_CPU_RESET_WAIT_MSEC);
+	}
+}
+
 static void gaudi_init_scrambler_sram(struct hl_device *hdev)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
@@ -4106,9 +4138,9 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 	 * stopped in any means necessary
 	 */
 	if (hdev->asic_prop.hard_reset_done_by_fw)
-		WREG32(mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU, KMD_MSG_RST_DEV);
+		gaudi_fw_hard_reset(hdev);
 	else
-		WREG32(mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU, KMD_MSG_GOTO_WFE);
+		gaudi_fw_halt_cpu(hdev);
 
 	if (hdev->fw_loader.linux_loaded) {
 		irq_handler_offset = hdev->asic_prop.gic_interrupts_enable ?
-- 
2.25.1


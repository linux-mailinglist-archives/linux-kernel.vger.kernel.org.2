Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CED440FBB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 18:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhJaRVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 13:21:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230225AbhJaRVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 13:21:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4A0A60C40;
        Sun, 31 Oct 2021 17:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635700751;
        bh=1MFB14TFqZlfxW4c7UjP0wZAxPEsYjGn62jzDwHFrpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gc3r6HULptVYnI9YBbwAio7Hs+FSNG5l3sW+YXrVUMcit3GYMuQRJlgkKM/7LSeRG
         Wn9m4nr0JyEdijFofj51UYn2sRTVJ3kJJyjGLJ34lGcZkE94vhtLOrVWAEPVAN7Mqy
         9Wfvevs5VCLly0umUUfTSQrb0jndsrMQQ96CrwJcJWZHnSyvIYamqi8IuFtVJ29Bx8
         jRaq62+l9bKV7V5FsfgpeauI3bBlY5r9imXrmAfTDFnuMXK6OjVqzfNq62xOUvMbaS
         zTN21HAmHvYRq40wlrleIHXYLn4fuEe0M3GLMlqwleDhhg5FRsTqTquC26OengWBX7
         BuLDXLags8c9A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 4/4] habanalabs: use variable poll interval for fw loading
Date:   Sun, 31 Oct 2021 19:19:02 +0200
Message-Id: <20211031171902.220708-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211031171902.220708-1-ogabbay@kernel.org>
References: <20211031171902.220708-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

Using a variable poll interval for fw loading allows us to support
much slower environments (emulation) while changing only a single
line in the code, instead of choosing a different interval in each
function that polls.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c  | 35 ++++++++++---------
 drivers/misc/habanalabs/common/habanalabs.h   |  5 +++
 .../misc/habanalabs/common/habanalabs_drv.c   |  3 ++
 3 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 8cbec10cddb1..c68ad4d7b1bb 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -15,8 +15,6 @@
 
 #define FW_FILE_MAX_SIZE		0x1400000 /* maximum size of 20MB */
 
-#define FW_CPU_STATUS_POLL_INTERVAL_USEC	10000
-
 static char *extract_fw_ver_from_str(const char *fw_str)
 {
 	char *str, *fw_ver, *whitespace;
@@ -1102,7 +1100,7 @@ static int hl_fw_read_preboot_caps(struct hl_device *hdev,
 		(status == CPU_BOOT_STATUS_NIC_FW_RDY) ||
 		(status == CPU_BOOT_STATUS_READY_TO_BOOT) ||
 		(status == CPU_BOOT_STATUS_WAITING_FOR_BOOT_FIT),
-		FW_CPU_STATUS_POLL_INTERVAL_USEC,
+		hdev->fw_poll_interval_usec,
 		timeout);
 
 	if (rc) {
@@ -1286,11 +1284,7 @@ int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
 {
 	int rc;
 
-	/* pldm was added for cases in which we use preboot on pldm and want
-	 * to load boot fit, but we can't wait for preboot because it runs
-	 * very slowly
-	 */
-	if (!(hdev->fw_components & FW_TYPE_PREBOOT_CPU) || hdev->pldm)
+	if (!(hdev->fw_components & FW_TYPE_PREBOOT_CPU))
 		return 0;
 
 	/*
@@ -1436,7 +1430,7 @@ static int hl_fw_dynamic_wait_for_status(struct hl_device *hdev,
 		le32_to_cpu(dyn_regs->cpu_cmd_status_to_host),
 		status,
 		FIELD_GET(COMMS_STATUS_STATUS_MASK, status) == expected_status,
-		FW_CPU_STATUS_POLL_INTERVAL_USEC,
+		hdev->fw_poll_interval_usec,
 		timeout);
 
 	if (rc) {
@@ -2070,7 +2064,7 @@ static int hl_fw_dynamic_wait_for_boot_fit_active(struct hl_device *hdev,
 		status,
 		(status == CPU_BOOT_STATUS_READY_TO_BOOT) ||
 		(status == CPU_BOOT_STATUS_SRAM_AVAIL),
-		FW_CPU_STATUS_POLL_INTERVAL_USEC,
+		hdev->fw_poll_interval_usec,
 		dyn_loader->wait_for_bl_timeout);
 	if (rc) {
 		dev_err(hdev->dev, "failed to wait for boot\n");
@@ -2097,7 +2091,7 @@ static int hl_fw_dynamic_wait_for_linux_active(struct hl_device *hdev,
 		le32_to_cpu(dyn_loader->comm_desc.cpu_dyn_regs.cpu_boot_status),
 		status,
 		(status == CPU_BOOT_STATUS_SRAM_AVAIL),
-		FW_CPU_STATUS_POLL_INTERVAL_USEC,
+		hdev->fw_poll_interval_usec,
 		fw_loader->cpu_timeout);
 	if (rc) {
 		dev_err(hdev->dev, "failed to wait for Linux\n");
@@ -2296,6 +2290,15 @@ static int hl_fw_dynamic_init_cpu(struct hl_device *hdev,
 		goto protocol_err;
 	}
 
+	/*
+	 * when testing FW load (without Linux) on PLDM we don't want to
+	 * wait until boot fit is active as it may take several hours.
+	 * instead, we load the bootfit and let it do all initializations in
+	 * the background.
+	 */
+	if (hdev->pldm && !(hdev->fw_components & FW_TYPE_LINUX))
+		return 0;
+
 	rc = hl_fw_dynamic_wait_for_boot_fit_active(hdev, fw_loader);
 	if (rc)
 		goto protocol_err;
@@ -2388,7 +2391,7 @@ static int hl_fw_static_init_cpu(struct hl_device *hdev,
 		cpu_boot_status_reg,
 		status,
 		status == CPU_BOOT_STATUS_WAITING_FOR_BOOT_FIT,
-		FW_CPU_STATUS_POLL_INTERVAL_USEC,
+		hdev->fw_poll_interval_usec,
 		fw_loader->boot_fit_timeout);
 
 	if (rc) {
@@ -2411,7 +2414,7 @@ static int hl_fw_static_init_cpu(struct hl_device *hdev,
 			cpu_msg_status_reg,
 			status,
 			status == CPU_MSG_OK,
-			FW_CPU_STATUS_POLL_INTERVAL_USEC,
+			hdev->fw_poll_interval_usec,
 			fw_loader->boot_fit_timeout);
 
 		if (rc) {
@@ -2440,7 +2443,7 @@ static int hl_fw_static_init_cpu(struct hl_device *hdev,
 		(status == CPU_BOOT_STATUS_NIC_FW_RDY) ||
 		(status == CPU_BOOT_STATUS_READY_TO_BOOT) ||
 		(status == CPU_BOOT_STATUS_SRAM_AVAIL),
-		FW_CPU_STATUS_POLL_INTERVAL_USEC,
+		hdev->fw_poll_interval_usec,
 		cpu_timeout);
 
 	dev_dbg(hdev->dev, "uboot status = %d\n", status);
@@ -2489,7 +2492,7 @@ static int hl_fw_static_init_cpu(struct hl_device *hdev,
 			cpu_boot_status_reg,
 			status,
 			(status == CPU_BOOT_STATUS_BMC_WAITING_SKIPPED),
-			FW_CPU_STATUS_POLL_INTERVAL_USEC,
+			hdev->fw_poll_interval_usec,
 			cpu_timeout);
 
 		if (rc) {
@@ -2509,7 +2512,7 @@ static int hl_fw_static_init_cpu(struct hl_device *hdev,
 		cpu_boot_status_reg,
 		status,
 		(status == CPU_BOOT_STATUS_SRAM_AVAIL),
-		FW_CPU_STATUS_POLL_INTERVAL_USEC,
+		hdev->fw_poll_interval_usec,
 		cpu_timeout);
 
 	/* Clear message */
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index b3c6b660c7aa..5fc9cfd892e8 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -61,6 +61,9 @@
 #define HL_CPUCP_INFO_TIMEOUT_USEC	10000000 /* 10s */
 #define HL_CPUCP_EEPROM_TIMEOUT_USEC	10000000 /* 10s */
 
+#define HL_FW_STATUS_POLL_INTERVAL_USEC		10000 /* 10ms */
+#define HL_FW_STATUS_PLDM_POLL_INTERVAL_USEC	300000000 /* 300s */
+
 #define HL_PCI_ELBI_TIMEOUT_MSEC	10 /* 10ms */
 
 #define HL_SIM_MAX_TIMEOUT_US		10000000 /* 10s */
@@ -2459,6 +2462,7 @@ struct multi_cs_data {
  * @last_open_session_duration_jif: duration (jiffies) of the last device open
  *                                  session.
  * @open_counter: number of successful device open operations.
+ * @fw_poll_interval_usec: FW status poll interval in usec.
  * @in_reset: is device in reset flow.
  * @curr_pll_profile: current PLL profile.
  * @card_type: Various ASICs have several card types. This indicates the card
@@ -2607,6 +2611,7 @@ struct hl_device {
 	u64				last_successful_open_jif;
 	u64				last_open_session_duration_jif;
 	u64				open_counter;
+	u64				fw_poll_interval_usec;
 	atomic_t			in_reset;
 	enum hl_pll_frequency		curr_pll_profile;
 	enum cpucp_card_types		card_type;
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 949d1b5c5c41..5989826701bc 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -345,6 +345,9 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 
 	set_driver_behavior_per_device(hdev);
 
+	hdev->fw_poll_interval_usec = hdev->pldm ? HL_FW_STATUS_PLDM_POLL_INTERVAL_USEC :
+							HL_FW_STATUS_POLL_INTERVAL_USEC;
+
 	hdev->curr_reset_cause = HL_RESET_CAUSE_UNKNOWN;
 	hdev->prev_reset_trigger = HL_RESET_TRIGGER_DEFAULT;
 
-- 
2.25.1


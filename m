Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E9E36D68A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 13:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239240AbhD1LeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 07:34:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234158AbhD1LeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 07:34:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D81B56142E;
        Wed, 28 Apr 2021 11:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619609609;
        bh=Z8Fy1a9VFFHtLa2L0wfvkvjqv2c5+H70EeJqIZuruv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pW0tYWNCxoVxQIkWdNpTCRm06hS3ZyFr7GaJaYcwQb+a8zeEKX50OXdzIybz5M/bo
         TTbgTMI4YhZ7rUaLTj3nR5dblBaW8owz5X+VBbrQkp90J5yO3WXU6+xhYK5Hk8xNKn
         kLQSzBcRQfcWukeg2ebpSoykQLKkQ+OOeXsdTf4FPcEhAho8wM3Vnst+jn80NGa77L
         Aq1l8rbDV+C5o565rsiZQVuFm7K+Z/y9zKR+Wl6Jang/QhyVA4yQgNlZXJPWldqHWg
         K+Dffzesd9SEgD7F+LgWe/tO88g2A2qec0+3AYoSQEzLGEbAHTTn6HqLSE/Hf5y4ee
         2qfvPH0fksPJQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 2/5] habanalabs: dynamic fw load reset protocol
Date:   Wed, 28 Apr 2021 14:33:20 +0300
Message-Id: <20210428113323.17222-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210428113323.17222-1-ogabbay@kernel.org>
References: <20210428113323.17222-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

First stage of the dynamic FW load protocol is to reset the protocol to
avoid residues from former load cycles.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 287 ++++++++++++++++++-
 drivers/misc/habanalabs/common/habanalabs.h  |  41 ++-
 drivers/misc/habanalabs/gaudi/gaudi.c        |  36 ++-
 drivers/misc/habanalabs/goya/goya.c          |  36 ++-
 4 files changed, 360 insertions(+), 40 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 29d15a051ab9..2a22ff9d4425 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -891,30 +891,32 @@ static int hl_read_device_fw_version(struct hl_device *hdev,
 					enum hl_fw_component fwc)
 {
 	struct fw_load_mgr *fw_loader = &hdev->fw_loader;
+	struct static_fw_load_mgr *static_loader;
 	const char *name;
 	u32 ver_off, limit;
 	char *dest;
 
+	static_loader = &hdev->fw_loader.static_loader;
+
 	switch (fwc) {
 	case FW_COMP_BOOT_FIT:
-		ver_off = RREG32(fw_loader->boot_fit_version_offset_reg);
+		ver_off = RREG32(static_loader->boot_fit_version_offset_reg);
 		dest = hdev->asic_prop.uboot_ver;
 		name = "Boot-fit";
-		limit = fw_loader->boot_fit_version_max_off;
+		limit = static_loader->boot_fit_version_max_off;
 		break;
 	case FW_COMP_PREBOOT:
-		ver_off = RREG32(
-			fw_loader->preboot_version_offset_reg);
+		ver_off = RREG32(static_loader->preboot_version_offset_reg);
 		dest = hdev->asic_prop.preboot_ver;
 		name = "Preboot";
-		limit = fw_loader->preboot_version_max_off;
+		limit = static_loader->preboot_version_max_off;
 		break;
 	default:
 		dev_warn(hdev->dev, "Undefined FW component: %d\n", fwc);
 		return -EIO;
 	}
 
-	ver_off &= fw_loader->sram_offset_mask;
+	ver_off &= static_loader->sram_offset_mask;
 
 	if (ver_off < limit) {
 		memcpy_fromio(dest,
@@ -1018,25 +1020,262 @@ int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
 	return -EINVAL;
 }
 
-int hl_fw_init_cpu(struct hl_device *hdev)
+/* associate string with COMM status */
+static char *hl_dynamic_fw_status_str[COMMS_STS_INVLD_LAST] = {
+	[COMMS_STS_NOOP] = "NOOP",
+	[COMMS_STS_ACK] = "ACK",
+	[COMMS_STS_OK] = "OK",
+	[COMMS_STS_ERR] = "ERR",
+	[COMMS_STS_VALID_ERR] = "VALID_ERR",
+	[COMMS_STS_TIMEOUT_ERR] = "TIMEOUT_ERR",
+};
+
+/**
+ * hl_fw_dynamic_report_error_status - report error status
+ *
+ * @hdev: pointer to the habanalabs device structure
+ * @status: value of FW status register
+ * @expected_status: the expected status
+ */
+static void hl_fw_dynamic_report_error_status(struct hl_device *hdev,
+						u32 status,
+						enum comms_sts expected_status)
+{
+	enum comms_sts comm_status =
+				FIELD_GET(COMMS_STATUS_STATUS_MASK, status);
+
+	if (comm_status < COMMS_STS_INVLD_LAST)
+		dev_err(hdev->dev, "Device status %s, expected status: %s\n",
+				hl_dynamic_fw_status_str[comm_status],
+				hl_dynamic_fw_status_str[expected_status]);
+	else
+		dev_err(hdev->dev, "Device status unknown %d, expected status: %s\n",
+				comm_status,
+				hl_dynamic_fw_status_str[expected_status]);
+}
+
+/**
+ * hl_fw_dynamic_send_cmd - send LKD to FW cmd
+ *
+ * @hdev: pointer to the habanalabs device structure
+ * @fw_loader: managing structure for loading device's FW
+ * @lkd_cmd: LKD to FW cmd code
+ * @size: size of next FW component to be loaded (0 if not necessary)
+ *
+ * LDK to FW exact command layout is defined at struct comms_command.
+ * note: the size argument is used only when the next FW component should be
+ *       loaded, otherwise it shall be 0. the size is used by the FW in later
+ *       protocol stages and when sending only indicating the amount of memory
+ *       to be allocated by the FW to receive the next boot component.
+ */
+static void hl_fw_dynamic_send_cmd(struct hl_device *hdev,
+				struct fw_load_mgr *fw_loader,
+				enum comms_cmd cmd, unsigned int size)
+{
+	struct comms_command lkd_cmd;
+
+	lkd_cmd.val = FIELD_PREP(COMMS_COMMAND_CMD_MASK, cmd);
+	lkd_cmd.val |= FIELD_PREP(COMMS_COMMAND_SIZE_MASK, size);
+
+	WREG32(fw_loader->kmd_msg_to_cpu_reg, lkd_cmd.val);
+}
+
+/**
+ * hl_fw_dynamic_wait_for_status - wait for status in dynamic FW load
+ *
+ * @hdev: pointer to the habanalabs device structure
+ * @fw_loader: managing structure for loading device's FW
+ * @expected_status: expected status to wait for
+ * @timeout: timeout for status wait
+ *
+ * @return 0 on success, otherwise non-zero error code
+ *
+ * waiting for status from FW include polling the FW status register until
+ * expected status is received or timeout occurs (whatever occurs first).
+ */
+static int hl_fw_dynamic_wait_for_status(struct hl_device *hdev,
+						struct fw_load_mgr *fw_loader,
+						enum comms_sts expected_status,
+						u32 timeout)
+{
+	u32 status;
+	int rc;
+
+	/* Wait for expected status */
+	rc = hl_poll_timeout(
+		hdev,
+		fw_loader->cpu_cmd_status_to_host_reg,
+		status,
+		FIELD_GET(COMMS_STATUS_STATUS_MASK, status) == expected_status,
+		10000,
+		timeout);
+
+	if (rc) {
+		hl_fw_dynamic_report_error_status(hdev, status,
+							expected_status);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/**
+ * hl_fw_dynamic_send_clear_cmd - send clear command to FW
+ *
+ * @hdev: pointer to the habanalabs device structure
+ * @fw_loader: managing structure for loading device's FW
+ *
+ * @return 0 on success, otherwise non-zero error code
+ *
+ * after command cycle between LKD to FW CPU (i.e. LKD got an expected status
+ * from FW) we need to clear the CPU status register in order to avoid garbage
+ * between command cycles.
+ * This is done by sending clear command and polling the CPU to LKD status
+ * register to hold the status NOOP
+ */
+static int hl_fw_dynamic_send_clear_cmd(struct hl_device *hdev,
+						struct fw_load_mgr *fw_loader)
+{
+	hl_fw_dynamic_send_cmd(hdev, fw_loader, COMMS_CLR_STS, 0);
+
+	return hl_fw_dynamic_wait_for_status(hdev, fw_loader, COMMS_STS_NOOP,
+							fw_loader->cpu_timeout);
+}
+
+/**
+ * hl_fw_dynamic_send_protocol_cmd - send LKD to FW cmd and wait for ACK
+ *
+ * @hdev: pointer to the habanalabs device structure
+ * @fw_loader: managing structure for loading device's FW
+ * @lkd_cmd: LKD to FW cmd code
+ * @size: size of next FW component to be loaded (0 if not necessary)
+ * @wait_ok: if true also wait for OK response from FW
+ * @timeout: timeout for status wait
+ *
+ * @return 0 on success, otherwise non-zero error code
+ *
+ * brief:
+ * when sending protocol command we have the following steps:
+ * - send clear (clear command and verify clear status register)
+ * - send the actual protocol command
+ * - wait for ACK on the protocol command
+ * - send clear
+ * - send NOOP
+ * if, in addition, the specific protocol command should wait for OK then:
+ * - wait for OK
+ * - send clear
+ * - send NOOP
+ *
+ * NOTES:
+ * send clear: this is necessary in order to clear the status register to avoid
+ *             leftovers between command
+ * NOOP command: necessary to avoid loop on the clear command by the FW
+ */
+static int hl_fw_dynamic_send_protocol_cmd(struct hl_device *hdev,
+				struct fw_load_mgr *fw_loader,
+				enum comms_cmd cmd, unsigned int size,
+				bool wait_ok, u32 timeout)
+{
+	int rc;
+
+	/* first send clear command to clean former commands */
+	rc = hl_fw_dynamic_send_clear_cmd(hdev, fw_loader);
+
+	/* send the actual command */
+	hl_fw_dynamic_send_cmd(hdev, fw_loader, cmd, size);
+
+	/* wait for ACK for the command */
+	rc = hl_fw_dynamic_wait_for_status(hdev, fw_loader, COMMS_STS_ACK,
+								timeout);
+	if (rc)
+		return rc;
+
+	/* clear command to prepare for NOOP command */
+	rc = hl_fw_dynamic_send_clear_cmd(hdev, fw_loader);
+	if (rc)
+		return rc;
+
+	/* send the actual NOOP command */
+	hl_fw_dynamic_send_cmd(hdev, fw_loader, COMMS_NOOP, 0);
+
+	if (!wait_ok)
+		return 0;
+
+	rc = hl_fw_dynamic_wait_for_status(hdev, fw_loader, COMMS_STS_OK,
+								timeout);
+	if (rc)
+		return rc;
+
+	/* clear command to prepare for NOOP command */
+	rc = hl_fw_dynamic_send_clear_cmd(hdev, fw_loader);
+	if (rc)
+		return rc;
+
+	/* send the actual NOOP command */
+	hl_fw_dynamic_send_cmd(hdev, fw_loader, COMMS_NOOP, 0);
+
+	return 0;
+}
+
+/**
+ * hl_fw_dynamic_init_cpu - initialize the device CPU using dynamic protocol
+ *
+ * @hdev: pointer to the habanalabs device structure
+ * @fw_loader: managing structure for loading device's FW
+ *
+ * @return 0 on success, otherwise non-zero error code
+ *
+ * brief: the dynamic protocol is master (LKD) slave (FW CPU) protocol.
+ * the communication is done using registers:
+ * - LKD command register
+ * - FW status register
+ * the protocol is race free. this goal is achieved by splitting the requests
+ * and response to known synchronization points between the LKD and the FW.
+ * each response to LKD request is known and bound to a predefined timeout.
+ * in case of timeout expiration without the desired status from FW- the
+ * protocol (and hence the boot) will fail.
+ */
+static int hl_fw_dynamic_init_cpu(struct hl_device *hdev,
+					struct fw_load_mgr *fw_loader)
+{
+	int rc;
+
+	rc = hl_fw_dynamic_send_protocol_cmd(hdev, fw_loader, COMMS_RST_STATE,
+						0, true,
+						fw_loader->cpu_timeout);
+	return rc;
+}
+
+/**
+ * hl_fw_static_init_cpu - initialize the device CPU using static protocol
+ *
+ * @hdev: pointer to the habanalabs device structure
+ * @fw_loader: managing structure for loading device's FW
+ *
+ * @return 0 on success, otherwise non-zero error code
+ */
+static int hl_fw_static_init_cpu(struct hl_device *hdev,
+					struct fw_load_mgr *fw_loader)
 {
 	u32 cpu_msg_status_reg, cpu_timeout, msg_to_cpu_reg, status;
 	u32 cpu_boot_status_reg, cpu_security_boot_status_reg;
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	struct fw_load_mgr *fw_loader;
+	struct static_fw_load_mgr *static_loader;
 	int rc;
 
 	if (!(hdev->fw_components & FW_TYPE_BOOT_CPU))
 		return 0;
 
-	/* init loader parameters */
-	fw_loader = &hdev->fw_loader;
-	cpu_security_boot_status_reg = fw_loader->cpu_boot_status_reg;
+	/* init common loader parameters */
+	static_loader = &fw_loader->static_loader;
 	cpu_msg_status_reg = fw_loader->cpu_cmd_status_to_host_reg;
-	cpu_boot_status_reg = fw_loader->cpu_boot_status_reg;
 	msg_to_cpu_reg = fw_loader->kmd_msg_to_cpu_reg;
 	cpu_timeout = fw_loader->cpu_timeout;
 
+	/* init static loader parameters */
+	cpu_security_boot_status_reg = static_loader->cpu_boot_status_reg;
+	cpu_boot_status_reg = static_loader->cpu_boot_status_reg;
+
 	dev_info(hdev->dev, "Going to wait for device boot (up to %lds)\n",
 		cpu_timeout / USEC_PER_SEC);
 
@@ -1187,7 +1426,7 @@ int hl_fw_init_cpu(struct hl_device *hdev)
 		goto out;
 	}
 
-	rc = fw_read_errors(hdev, fw_loader->boot_err0_reg,
+	rc = fw_read_errors(hdev, fw_loader->static_loader.boot_err0_reg,
 					cpu_security_boot_status_reg);
 	if (rc)
 		return rc;
@@ -1217,8 +1456,28 @@ int hl_fw_init_cpu(struct hl_device *hdev)
 	return 0;
 
 out:
-	fw_read_errors(hdev, fw_loader->boot_err0_reg,
+	fw_read_errors(hdev, fw_loader->static_loader.boot_err0_reg,
 					cpu_security_boot_status_reg);
 
 	return rc;
 }
+
+/**
+ * hl_fw_init_cpu - initialize the device CPU
+ *
+ * @hdev: pointer to the habanalabs device structure
+ *
+ * @return 0 on success, otherwise non-zero error code
+ *
+ * perform necessary initializations for device's CPU. takes into account if
+ * init protocol is static or dynamic.
+ */
+int hl_fw_init_cpu(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct fw_load_mgr *fw_loader = &hdev->fw_loader;
+
+	return  prop->dynamic_fw_load ?
+			hl_fw_dynamic_init_cpu(hdev, fw_loader) :
+			hl_fw_static_init_cpu(hdev, fw_loader);
+}
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 1a822fd741d1..5df971e5c108 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -819,37 +819,58 @@ enum div_select_defs {
 };
 
 /**
- * struct fw_load_mgr - manager FW loading process
+ * struct static_fw_load_mgr - static FW load manager
  * @preboot_version_max_off: max offset to preboot version
  * @boot_fit_version_max_off: max offset to boot fit version
- * @kmd_msg_to_cpu_reg: register address for KDM->CPU messages
- * @cpu_cmd_status_to_host_reg: register address for CPU command status response
  * @cpu_boot_status_reg: boot status register
  * @cpu_boot_dev_status_reg: boot device status register
  * @boot_err0_reg: boot error register
  * @preboot_version_offset_reg: SRAM offset to preboot version register
  * @boot_fit_version_offset_reg: SRAM offset to boot fit version register
  * @sram_offset_mask: mask for getting offset into the SRAM
- * @cpu_timeout: CPU response timeout in usec
- * @boot_fit_timeout: Boot fit load timeout in usec
- * @skip_bmc: should BMC be skipped
- * @sram_bar_id: SRAM bar ID
  */
-struct fw_load_mgr {
+struct static_fw_load_mgr {
 	u64 preboot_version_max_off;
 	u64 boot_fit_version_max_off;
-	u32 kmd_msg_to_cpu_reg;
-	u32 cpu_cmd_status_to_host_reg;
 	u32 cpu_boot_status_reg;
 	u32 cpu_boot_dev_status_reg;
 	u32 boot_err0_reg;
 	u32 preboot_version_offset_reg;
 	u32 boot_fit_version_offset_reg;
 	u32 sram_offset_mask;
+};
+
+/**
+ * struct dynamic_fw_load_mgr - dynamic FW load manager
+ * TODO: currently empty, will be filled once boot stages implementation will
+ *       progress.
+ */
+struct dynamic_fw_load_mgr {
+};
+
+/**
+ * struct fw_load_mgr - manager FW loading process
+ * @kmd_msg_to_cpu_reg: register address for KDM->CPU messages
+ * @cpu_cmd_status_to_host_reg: register address for CPU command status response
+ * @cpu_timeout: CPU response timeout in usec
+ * @boot_fit_timeout: Boot fit load timeout in usec
+ * @skip_bmc: should BMC be skipped
+ * @sram_bar_id: SRAM bar ID
+ * @static_loader: specific structure for static load
+ * @dynamic_loader: specific structure for dynamic load
+ */
+struct fw_load_mgr {
+	u32 kmd_msg_to_cpu_reg;
+	u32 cpu_cmd_status_to_host_reg;
 	u32 cpu_timeout;
 	u32 boot_fit_timeout;
 	u8 skip_bmc;
 	u8 sram_bar_id;
+
+	union {
+		struct static_fw_load_mgr static_loader;
+		struct dynamic_fw_load_mgr dynamic_loader;
+	};
 };
 
 /**
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 9e625ca94908..84c42868e7fd 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -3691,24 +3691,44 @@ static int gaudi_load_boot_fit_to_device(struct hl_device *hdev)
 	return hl_fw_load_fw_to_device(hdev, GAUDI_BOOT_FIT_FILE, dst, 0, 0);
 }
 
+static void gaudi_init_dynamic_firmware_loader(struct hl_device *hdev)
+{
+
+}
+
+static void gaudi_init_static_firmware_loader(struct hl_device *hdev)
+{
+	struct static_fw_load_mgr *static_loader;
+
+	static_loader = &hdev->fw_loader.static_loader;
+
+	static_loader->preboot_version_max_off = SRAM_SIZE - VERSION_MAX_LEN;
+	static_loader->boot_fit_version_max_off = SRAM_SIZE - VERSION_MAX_LEN;
+	static_loader->cpu_boot_status_reg = mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS;
+	static_loader->cpu_boot_dev_status_reg = mmCPU_BOOT_DEV_STS0;
+	static_loader->boot_err0_reg = mmCPU_BOOT_ERR0;
+	static_loader->preboot_version_offset_reg = mmPREBOOT_VER_OFFSET;
+	static_loader->boot_fit_version_offset_reg = mmUBOOT_VER_OFFSET;
+	static_loader->sram_offset_mask = ~((u32)SRAM_BASE_ADDR);
+}
+
 static void gaudi_init_firmware_loader(struct hl_device *hdev)
 {
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct fw_load_mgr *fw_loader = &hdev->fw_loader;
 
-	fw_loader->preboot_version_max_off = SRAM_SIZE - VERSION_MAX_LEN;
-	fw_loader->boot_fit_version_max_off = SRAM_SIZE - VERSION_MAX_LEN;
+	/* fill common fields */
 	fw_loader->kmd_msg_to_cpu_reg = mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU;
 	fw_loader->cpu_cmd_status_to_host_reg = mmCPU_CMD_STATUS_TO_HOST;
-	fw_loader->preboot_version_offset_reg = mmPREBOOT_VER_OFFSET;
-	fw_loader->boot_fit_version_offset_reg = mmUBOOT_VER_OFFSET;
-	fw_loader->sram_offset_mask = ~((u32)SRAM_BASE_ADDR);
 	fw_loader->cpu_timeout = GAUDI_CPU_TIMEOUT_USEC;
 	fw_loader->boot_fit_timeout = GAUDI_BOOT_FIT_REQ_TIMEOUT_USEC;
 	fw_loader->skip_bmc = !hdev->bmc_enable;
-	fw_loader->cpu_boot_status_reg = mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS;
-	fw_loader->cpu_boot_dev_status_reg = mmCPU_BOOT_DEV_STS0;
-	fw_loader->boot_err0_reg = mmCPU_BOOT_ERR0;
 	fw_loader->sram_bar_id = SRAM_BAR_ID;
+
+	if (prop->dynamic_fw_load)
+		gaudi_init_dynamic_firmware_loader(hdev);
+	else
+		gaudi_init_static_firmware_loader(hdev);
 }
 
 static int gaudi_init_cpu(struct hl_device *hdev)
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index dd55fec19e8d..dc5659340220 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2402,24 +2402,44 @@ static int goya_load_boot_fit_to_device(struct hl_device *hdev)
 	return hl_fw_load_fw_to_device(hdev, GOYA_BOOT_FIT_FILE, dst, 0, 0);
 }
 
+static void goya_init_dynamic_firmware_loader(struct hl_device *hdev)
+{
+
+}
+
+static void goya_init_static_firmware_loader(struct hl_device *hdev)
+{
+	struct static_fw_load_mgr *static_loader;
+
+	static_loader = &hdev->fw_loader.static_loader;
+
+	static_loader->preboot_version_max_off = SRAM_SIZE - VERSION_MAX_LEN;
+	static_loader->boot_fit_version_max_off = SRAM_SIZE - VERSION_MAX_LEN;
+	static_loader->cpu_boot_status_reg = mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS;
+	static_loader->cpu_boot_dev_status_reg = mmCPU_BOOT_DEV_STS0;
+	static_loader->boot_err0_reg = mmCPU_BOOT_ERR0;
+	static_loader->preboot_version_offset_reg = mmPREBOOT_VER_OFFSET;
+	static_loader->boot_fit_version_offset_reg = mmUBOOT_VER_OFFSET;
+	static_loader->sram_offset_mask = ~((u32)SRAM_BASE_ADDR);
+}
+
 static void goya_init_firmware_loader(struct hl_device *hdev)
 {
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct fw_load_mgr *fw_loader = &hdev->fw_loader;
 
-	fw_loader->preboot_version_max_off = SRAM_SIZE - VERSION_MAX_LEN;
-	fw_loader->boot_fit_version_max_off = SRAM_SIZE - VERSION_MAX_LEN;
+	/* fill common fields */
 	fw_loader->kmd_msg_to_cpu_reg = mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU;
 	fw_loader->cpu_cmd_status_to_host_reg = mmCPU_CMD_STATUS_TO_HOST;
-	fw_loader->preboot_version_offset_reg = mmPREBOOT_VER_OFFSET;
-	fw_loader->boot_fit_version_offset_reg = mmUBOOT_VER_OFFSET;
-	fw_loader->sram_offset_mask = ~((u32)SRAM_BASE_ADDR);
 	fw_loader->cpu_timeout = GOYA_CPU_TIMEOUT_USEC;
 	fw_loader->boot_fit_timeout = GOYA_BOOT_FIT_REQ_TIMEOUT_USEC;
 	fw_loader->skip_bmc = false;
-	fw_loader->cpu_boot_status_reg = mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS;
-	fw_loader->cpu_boot_dev_status_reg = mmCPU_BOOT_DEV_STS0;
-	fw_loader->boot_err0_reg = mmCPU_BOOT_ERR0;
 	fw_loader->sram_bar_id = SRAM_CFG_BAR_ID;
+
+	if (prop->dynamic_fw_load)
+		goya_init_dynamic_firmware_loader(hdev);
+	else
+		goya_init_static_firmware_loader(hdev);
 }
 
 static int goya_init_cpu(struct hl_device *hdev)
-- 
2.25.1


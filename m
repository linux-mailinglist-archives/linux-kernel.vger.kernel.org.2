Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8D83F4DEA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhHWP77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 11:59:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231967AbhHWP76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 11:59:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6592613CD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 15:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629734355;
        bh=oU6kWTPKPNFxIxdo/L/9eIBbtssoFf4uHFJJbSMlZHQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HDVlW1oiaVjd3rBMBymrXUGeEdOq6UZPg5rX3xZFOTi2vUwBH5tjOtCBHkf0dODx/
         R6zLWkyno+Hzt/olacgQaS06aaBE4VmzQpImd2EnMNhjHT93UCCeoMAjyvGW0Ti+Qa
         xiw0qQKz73yPwMjUeP+Xg81Zic8ChclHQiPPiIehK9ii13eZSrNMEmSi80nbHobFmh
         ASV1PKY5PdYbpd0nw7HiR1zQG6a/Npg3bb/4zcvp2W8Bq16q3uo4Aq7hm33rt3FK2e
         jUs0n5VZZeqWKaigbanmDmzVyupM7ixbjZsXo1ikzcnu8iVUwRimBRM3Zmp0MQ95Cp
         jyoYFsm8ERf6Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] habanalabs: add support for f/w reset
Date:   Mon, 23 Aug 2021 18:59:10 +0300
Message-Id: <20210823155910.100371-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210823155910.100371-1-ogabbay@kernel.org>
References: <20210823155910.100371-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the f/w runs in secured mode, it can reset the ASIC when certain
events occur. In unsecured mode, the driver asks the f/w to reset the
ASIC for those events.

We need to perform the entire reset procedure but without accessing the
ASIC. i.e. without halting the engines and without sending messages
to the f/w.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c       | 35 ++++++++++++-------
 drivers/misc/habanalabs/common/habanalabs.h   | 11 ++++--
 .../misc/habanalabs/common/habanalabs_drv.c   |  2 +-
 drivers/misc/habanalabs/gaudi/gaudi.c         | 33 ++++++++++++-----
 drivers/misc/habanalabs/goya/goya.c           | 15 +++-----
 5 files changed, 61 insertions(+), 35 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index c2641030d9ff..97c7c86580e6 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -311,9 +311,15 @@ static void device_hard_reset_pending(struct work_struct *work)
 		container_of(work, struct hl_device_reset_work,
 				reset_work.work);
 	struct hl_device *hdev = device_reset_work->hdev;
+	u32 flags;
 	int rc;
 
-	rc = hl_device_reset(hdev, HL_RESET_HARD | HL_RESET_FROM_RESET_THREAD);
+	flags = HL_RESET_HARD | HL_RESET_FROM_RESET_THREAD;
+
+	if (device_reset_work->fw_reset)
+		flags |= HL_RESET_FW;
+
+	rc = hl_device_reset(hdev, flags);
 	if ((rc == -EBUSY) && !hdev->device_fini_pending) {
 		dev_info(hdev->dev,
 			"Could not reset device. will try again in %u seconds",
@@ -702,7 +708,7 @@ static void take_release_locks(struct hl_device *hdev)
 	mutex_unlock(&hdev->fpriv_list_lock);
 }
 
-static void cleanup_resources(struct hl_device *hdev, bool hard_reset)
+static void cleanup_resources(struct hl_device *hdev, bool hard_reset, bool fw_reset)
 {
 	if (hard_reset)
 		device_late_fini(hdev);
@@ -712,7 +718,7 @@ static void cleanup_resources(struct hl_device *hdev, bool hard_reset)
 	 * completions from H/W and we won't have any accesses from the
 	 * H/W to the host machine
 	 */
-	hdev->asic_funcs->halt_engines(hdev, hard_reset);
+	hdev->asic_funcs->halt_engines(hdev, hard_reset, fw_reset);
 
 	/* Go over all the queues, release all CS and their jobs */
 	hl_cs_rollback_all(hdev);
@@ -922,7 +928,7 @@ static void device_disable_open_processes(struct hl_device *hdev)
 int hl_device_reset(struct hl_device *hdev, u32 flags)
 {
 	u64 idle_mask[HL_BUSY_ENGINES_MASK_EXT_SIZE] = {0};
-	bool hard_reset, from_hard_reset_thread, hard_instead_soft = false;
+	bool hard_reset, from_hard_reset_thread, fw_reset, hard_instead_soft = false;
 	int i, rc;
 
 	if (!hdev->init_done) {
@@ -933,6 +939,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 
 	hard_reset = !!(flags & HL_RESET_HARD);
 	from_hard_reset_thread = !!(flags & HL_RESET_FROM_RESET_THREAD);
+	fw_reset = !!(flags & HL_RESET_FW);
 
 	if (!hard_reset && !hdev->supports_soft_reset) {
 		hard_instead_soft = true;
@@ -984,11 +991,13 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		else
 			hdev->curr_reset_cause = HL_RESET_CAUSE_UNKNOWN;
 
-		/*
-		 * if reset is due to heartbeat, device CPU is no responsive in
-		 * which case no point sending PCI disable message to it
+		/* If reset is due to heartbeat, device CPU is no responsive in
+		 * which case no point sending PCI disable message to it.
+		 *
+		 * If F/W is performing the reset, no need to send it a message to disable
+		 * PCI access
 		 */
-		if (hard_reset && !(flags & HL_RESET_HEARTBEAT)) {
+		if (hard_reset && !(flags & (HL_RESET_HEARTBEAT | HL_RESET_FW))) {
 			/* Disable PCI access from device F/W so he won't send
 			 * us additional interrupts. We disable MSI/MSI-X at
 			 * the halt_engines function and we can't have the F/W
@@ -1018,6 +1027,8 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 
 		hdev->process_kill_trial_cnt = 0;
 
+		hdev->device_reset_work.fw_reset = fw_reset;
+
 		/*
 		 * Because the reset function can't run from heartbeat work,
 		 * we need to call the reset function from a dedicated work.
@@ -1028,7 +1039,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		return 0;
 	}
 
-	cleanup_resources(hdev, hard_reset);
+	cleanup_resources(hdev, hard_reset, fw_reset);
 
 kill_processes:
 	if (hard_reset) {
@@ -1062,7 +1073,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	}
 
 	/* Reset the H/W. It will be in idle state after this returns */
-	hdev->asic_funcs->hw_fini(hdev, hard_reset);
+	hdev->asic_funcs->hw_fini(hdev, hard_reset, fw_reset);
 
 	if (hard_reset) {
 		hdev->fw_loader.linux_loaded = false;
@@ -1587,7 +1598,7 @@ void hl_device_fini(struct hl_device *hdev)
 
 	hl_hwmon_fini(hdev);
 
-	cleanup_resources(hdev, true);
+	cleanup_resources(hdev, true, false);
 
 	/* Kill processes here after CS rollback. This is because the process
 	 * can't really exit until all its CSs are done, which is what we
@@ -1606,7 +1617,7 @@ void hl_device_fini(struct hl_device *hdev)
 	hl_cb_pool_fini(hdev);
 
 	/* Reset the H/W. It will be in idle state after this returns */
-	hdev->asic_funcs->hw_fini(hdev, true);
+	hdev->asic_funcs->hw_fini(hdev, true, false);
 
 	hdev->fw_loader.linux_loaded = false;
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index d22ad9e4d5e8..df49376a0880 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -129,12 +129,17 @@ enum hl_mmu_page_table_location {
  *
  * - HL_RESET_DEVICE_RELEASE
  *       Set if reset is due to device release
+ *
+ * - HL_RESET_FW
+ *       F/W will perform the reset. No need to ask it to reset the device. This is relevant
+ *       only when running with secured f/w
  */
 #define HL_RESET_HARD			(1 << 0)
 #define HL_RESET_FROM_RESET_THREAD	(1 << 1)
 #define HL_RESET_HEARTBEAT		(1 << 2)
 #define HL_RESET_TDR			(1 << 3)
 #define HL_RESET_DEVICE_RELEASE		(1 << 4)
+#define HL_RESET_FW			(1 << 5)
 
 #define HL_MAX_SOBS_PER_MONITOR	8
 
@@ -1171,8 +1176,8 @@ struct hl_asic_funcs {
 	int (*sw_init)(struct hl_device *hdev);
 	int (*sw_fini)(struct hl_device *hdev);
 	int (*hw_init)(struct hl_device *hdev);
-	void (*hw_fini)(struct hl_device *hdev, bool hard_reset);
-	void (*halt_engines)(struct hl_device *hdev, bool hard_reset);
+	void (*hw_fini)(struct hl_device *hdev, bool hard_reset, bool fw_reset);
+	void (*halt_engines)(struct hl_device *hdev, bool hard_reset, bool fw_reset);
 	int (*suspend)(struct hl_device *hdev);
 	int (*resume)(struct hl_device *hdev);
 	int (*mmap)(struct hl_device *hdev, struct vm_area_struct *vma,
@@ -2158,11 +2163,13 @@ struct hwmon_chip_info;
  * @wq: work queue for device reset procedure.
  * @reset_work: reset work to be done.
  * @hdev: habanalabs device structure.
+ * @fw_reset: whether f/w will do the reset without us sending them a message to do it.
  */
 struct hl_device_reset_work {
 	struct workqueue_struct		*wq;
 	struct delayed_work		reset_work;
 	struct hl_device		*hdev;
+	bool				fw_reset;
 };
 
 /**
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 2ef59fd465ba..a75e4fceb9d8 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -535,7 +535,7 @@ hl_pci_err_detected(struct pci_dev *pdev, pci_channel_state_t state)
 		result = PCI_ERS_RESULT_NONE;
 	}
 
-	hdev->asic_funcs->halt_engines(hdev, true);
+	hdev->asic_funcs->halt_engines(hdev, true, false);
 
 	return result;
 }
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index ca9c3b9f08a1..48cea845624e 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -834,14 +834,14 @@ static int gaudi_early_init(struct hl_device *hdev)
 					GAUDI_BOOT_FIT_REQ_TIMEOUT_USEC);
 	if (rc) {
 		if (hdev->reset_on_preboot_fail)
-			hdev->asic_funcs->hw_fini(hdev, true);
+			hdev->asic_funcs->hw_fini(hdev, true, false);
 		goto pci_fini;
 	}
 
 	if (gaudi_get_hw_state(hdev) == HL_DEVICE_HW_STATE_DIRTY) {
 		dev_info(hdev->dev,
 			"H/W state is dirty, must reset before initializing\n");
-		hdev->asic_funcs->hw_fini(hdev, true);
+		hdev->asic_funcs->hw_fini(hdev, true, false);
 	}
 
 	return 0;
@@ -3837,7 +3837,7 @@ static void gaudi_disable_timestamp(struct hl_device *hdev)
 	WREG32(mmPSOC_TIMESTAMP_BASE - CFG_BASE, 0);
 }
 
-static void gaudi_halt_engines(struct hl_device *hdev, bool hard_reset)
+static void gaudi_halt_engines(struct hl_device *hdev, bool hard_reset, bool fw_reset)
 {
 	u32 wait_timeout_ms;
 
@@ -3849,6 +3849,9 @@ static void gaudi_halt_engines(struct hl_device *hdev, bool hard_reset)
 	else
 		wait_timeout_ms = GAUDI_RESET_WAIT_MSEC;
 
+	if (fw_reset)
+		goto skip_engines;
+
 	gaudi_stop_nic_qmans(hdev);
 	gaudi_stop_mme_qmans(hdev);
 	gaudi_stop_tpc_qmans(hdev);
@@ -3874,6 +3877,7 @@ static void gaudi_halt_engines(struct hl_device *hdev, bool hard_reset)
 
 	gaudi_disable_timestamp(hdev);
 
+skip_engines:
 	gaudi_disable_msi(hdev);
 }
 
@@ -4241,7 +4245,7 @@ static int gaudi_hw_init(struct hl_device *hdev)
 	return rc;
 }
 
-static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
+static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset, bool fw_reset)
 {
 	struct cpu_dyn_regs *dyn_regs =
 			&hdev->fw_loader.dynamic_loader.comm_desc.cpu_dyn_regs;
@@ -4262,6 +4266,14 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 		cpu_timeout_ms = GAUDI_CPU_RESET_WAIT_MSEC;
 	}
 
+	if (fw_reset) {
+		dev_info(hdev->dev,
+			"Firmware performs HARD reset, going to wait %dms\n",
+			reset_timeout_ms);
+
+		goto skip_reset;
+	}
+
 	driver_performs_reset = !!(!hdev->asic_prop.fw_security_enabled &&
 					!hdev->asic_prop.hard_reset_done_by_fw);
 
@@ -4338,6 +4350,7 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 			reset_timeout_ms);
 	}
 
+skip_reset:
 	/*
 	 * After hard reset, we can't poll the BTM_FSM register because the PSOC
 	 * itself is in reset. Need to wait until the reset is deasserted
@@ -8000,10 +8013,10 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 					tpc_dec_event_to_tpc_id(event_type),
 					"AXI_SLV_DEC_Error");
 		if (reset_required) {
-			dev_err(hdev->dev, "hard reset required due to %s\n",
+			dev_err(hdev->dev, "reset required due to %s\n",
 				gaudi_irq_map_table[event_type].name);
 
-			goto reset_device;
+			hl_device_reset(hdev, 0);
 		} else {
 			hl_fw_unmask_irq(hdev, event_type);
 		}
@@ -8022,10 +8035,10 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 					tpc_krn_event_to_tpc_id(event_type),
 					"KRN_ERR");
 		if (reset_required) {
-			dev_err(hdev->dev, "hard reset required due to %s\n",
+			dev_err(hdev->dev, "reset required due to %s\n",
 				gaudi_irq_map_table[event_type].name);
 
-			goto reset_device;
+			hl_device_reset(hdev, 0);
 		} else {
 			hl_fw_unmask_irq(hdev, event_type);
 		}
@@ -8155,7 +8168,9 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 	return;
 
 reset_device:
-	if (hdev->hard_reset_on_fw_events)
+	if (hdev->asic_prop.fw_security_enabled)
+		hl_device_reset(hdev, HL_RESET_HARD | HL_RESET_FW);
+	else if (hdev->hard_reset_on_fw_events)
 		hl_device_reset(hdev, HL_RESET_HARD);
 	else
 		hl_fw_unmask_irq(hdev, event_type);
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index af3f84d8f710..65e4a4bb9323 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -655,14 +655,14 @@ static int goya_early_init(struct hl_device *hdev)
 					GOYA_BOOT_FIT_REQ_TIMEOUT_USEC);
 	if (rc) {
 		if (hdev->reset_on_preboot_fail)
-			hdev->asic_funcs->hw_fini(hdev, true);
+			hdev->asic_funcs->hw_fini(hdev, true, false);
 		goto pci_fini;
 	}
 
 	if (goya_get_hw_state(hdev) == HL_DEVICE_HW_STATE_DIRTY) {
 		dev_info(hdev->dev,
 			"H/W state is dirty, must reset before initializing\n");
-		hdev->asic_funcs->hw_fini(hdev, true);
+		hdev->asic_funcs->hw_fini(hdev, true, false);
 	}
 
 	if (!hdev->pldm) {
@@ -2381,7 +2381,7 @@ static void goya_disable_timestamp(struct hl_device *hdev)
 	WREG32(mmPSOC_TIMESTAMP_BASE - CFG_BASE, 0);
 }
 
-static void goya_halt_engines(struct hl_device *hdev, bool hard_reset)
+static void goya_halt_engines(struct hl_device *hdev, bool hard_reset, bool fw_reset)
 {
 	u32 wait_timeout_ms;
 
@@ -2704,14 +2704,7 @@ static int goya_hw_init(struct hl_device *hdev)
 	return rc;
 }
 
-/*
- * goya_hw_fini - Goya hardware tear-down code
- *
- * @hdev: pointer to hl_device structure
- * @hard_reset: should we do hard reset to all engines or just reset the
- *              compute/dma engines
- */
-static void goya_hw_fini(struct hl_device *hdev, bool hard_reset)
+static void goya_hw_fini(struct hl_device *hdev, bool hard_reset, bool fw_reset)
 {
 	struct goya_device *goya = hdev->asic_specific;
 	u32 reset_timeout_ms, cpu_timeout_ms, status;
-- 
2.17.1


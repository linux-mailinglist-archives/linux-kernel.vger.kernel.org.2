Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754EE4475EF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 21:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbhKGUyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 15:54:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:56332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235740AbhKGUya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 15:54:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C9D6614C8;
        Sun,  7 Nov 2021 20:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636318307;
        bh=RWJMcTWSieqdTFyJKOxwvLpTd38s0moLfgmh5dKllOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VS6Tj0gE6/S2dB6FDc54M6/lcdx1wJPycfhMpqPa5LnOoUfin2tJYN62sqcNvi6Ho
         7DPsWKMhImZZokP9wN0aI2A9+MjQ2+UuOMMbLDssXt0oSFNwAe83wMI073OW30X1a4
         nU4t73lnF+W1Q3enritV9efj4E6orkk7oMZ6mRmtxlx/bd+t+rQG+rTPYSBu4gckq+
         HGdlUOstI5mEqZmzsmhQfoNPkStXpJnUnkfmaDgH5a68300ADmVgYCZ1b7pOnvy3ej
         KqD+1/MGxjoZVYVu3a7IsYocQOn28PmsqBWUagqHXT2BG9Pfcjsggt/bGOVg6ADQOH
         Vcy84DSe5Bb4Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Bharat Jauhari <bjauhari@habana.ai>
Subject: [PATCH 04/10] habanalabs: rename reset flags
Date:   Sun,  7 Nov 2021 22:51:30 +0200
Message-Id: <20211107205136.2329007-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211107205136.2329007-1-ogabbay@kernel.org>
References: <20211107205136.2329007-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bharat Jauhari <bjauhari@habana.ai>

Rename reset flags for better readability as compared to
HL_RESET_CAUSE* enum shared with the f/w.

Signed-off-by: Bharat Jauhari <bjauhari@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    |  2 +-
 drivers/misc/habanalabs/common/device.c       | 40 +++++++++----------
 drivers/misc/habanalabs/common/habanalabs.h   | 28 ++++++-------
 drivers/misc/habanalabs/common/memory.c       |  2 +-
 drivers/misc/habanalabs/common/sysfs.c        |  2 +-
 drivers/misc/habanalabs/gaudi/gaudi.c         | 14 ++++---
 drivers/misc/habanalabs/goya/goya.c           | 10 ++---
 7 files changed, 50 insertions(+), 48 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 41b48929cd59..9ebcd9894d83 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -767,7 +767,7 @@ static void cs_timedout(struct work_struct *work)
 
 	if (likely(!skip_reset_on_timeout)) {
 		if (hdev->reset_on_lockup)
-			hl_device_reset(hdev, HL_RESET_TDR);
+			hl_device_reset(hdev, HL_DRV_RESET_TDR);
 		else
 			hdev->needs_reset = true;
 	}
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 9674e2520532..eb5800b403b6 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -95,7 +95,7 @@ static void hpriv_release(struct kref *ref)
 
 	if ((hdev->reset_if_device_not_idle && !device_is_idle)
 			|| hdev->reset_upon_device_release)
-		hl_device_reset(hdev, HL_RESET_DEVICE_RELEASE);
+		hl_device_reset(hdev, HL_DRV_RESET_DEV_RELEASE);
 
 	/* Now we can mark the compute_ctx as empty. Even if a reset is running in a different
 	 * thread, we don't care because the in_reset is marked so if a user will try to open
@@ -330,10 +330,10 @@ static void device_hard_reset_pending(struct work_struct *work)
 	u32 flags;
 	int rc;
 
-	flags = HL_RESET_HARD | HL_RESET_FROM_RESET_THREAD;
+	flags = HL_DRV_RESET_HARD | HL_DRV_RESET_FROM_RESET_THR;
 
 	if (device_reset_work->fw_reset)
-		flags |= HL_RESET_FW;
+		flags |= HL_DRV_RESET_BYPASS_REQ_TO_FW;
 
 	rc = hl_device_reset(hdev, flags);
 	if ((rc == -EBUSY) && !hdev->device_fini_pending) {
@@ -541,7 +541,7 @@ static void hl_device_heartbeat(struct work_struct *work)
 		goto reschedule;
 
 	dev_err(hdev->dev, "Device heartbeat failed!\n");
-	hl_device_reset(hdev, HL_RESET_HARD | HL_RESET_HEARTBEAT);
+	hl_device_reset(hdev, HL_DRV_RESET_HARD | HL_DRV_RESET_HEARTBEAT);
 
 	return;
 
@@ -552,7 +552,7 @@ static void hl_device_heartbeat(struct work_struct *work)
 	 * If control reached here, then at least one heartbeat work has been
 	 * scheduled since last reset/init cycle.
 	 * So if the device is not already in reset cycle, reset the flag
-	 * prev_reset_trigger as no reset occurred with HL_RESET_FW_FATAL_ERR
+	 * prev_reset_trigger as no reset occurred with HL_DRV_RESET_FW_FATAL_ERR
 	 * status for at least one heartbeat. From this point driver restarts
 	 * tracking future consecutive fatal errors.
 	 */
@@ -831,7 +831,7 @@ int hl_device_resume(struct hl_device *hdev)
 	hdev->disabled = false;
 	atomic_set(&hdev->in_reset, 0);
 
-	rc = hl_device_reset(hdev, HL_RESET_HARD);
+	rc = hl_device_reset(hdev, HL_DRV_RESET_HARD);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to reset device during resume\n");
 		goto disable_device;
@@ -948,15 +948,15 @@ static void handle_reset_trigger(struct hl_device *hdev, u32 flags)
 	 * ('in_reset' makes sure of it). This makes sure that
 	 * 'reset_cause' will continue holding its 1st recorded reason!
 	 */
-	if (flags & HL_RESET_HEARTBEAT) {
+	if (flags & HL_DRV_RESET_HEARTBEAT) {
 		hdev->curr_reset_cause = HL_RESET_CAUSE_HEARTBEAT;
-		cur_reset_trigger = HL_RESET_HEARTBEAT;
-	} else if (flags & HL_RESET_TDR) {
+		cur_reset_trigger = HL_DRV_RESET_HEARTBEAT;
+	} else if (flags & HL_DRV_RESET_TDR) {
 		hdev->curr_reset_cause = HL_RESET_CAUSE_TDR;
-		cur_reset_trigger = HL_RESET_TDR;
-	} else if (flags & HL_RESET_FW_FATAL_ERR) {
+		cur_reset_trigger = HL_DRV_RESET_TDR;
+	} else if (flags & HL_DRV_RESET_FW_FATAL_ERR) {
 		hdev->curr_reset_cause = HL_RESET_CAUSE_UNKNOWN;
-		cur_reset_trigger = HL_RESET_FW_FATAL_ERR;
+		cur_reset_trigger = HL_DRV_RESET_FW_FATAL_ERR;
 	} else {
 		hdev->curr_reset_cause = HL_RESET_CAUSE_UNKNOWN;
 	}
@@ -979,8 +979,8 @@ static void handle_reset_trigger(struct hl_device *hdev, u32 flags)
 	 * If F/W is performing the reset, no need to send it a message to disable
 	 * PCI access
 	 */
-	if ((flags & HL_RESET_HARD) &&
-			!(flags & (HL_RESET_HEARTBEAT | HL_RESET_FW))) {
+	if ((flags & HL_DRV_RESET_HARD) &&
+			!(flags & (HL_DRV_RESET_HEARTBEAT | HL_DRV_RESET_BYPASS_REQ_TO_FW))) {
 		/* Disable PCI access from device F/W so he won't send
 		 * us additional interrupts. We disable MSI/MSI-X at
 		 * the halt_engines function and we can't have the F/W
@@ -1025,9 +1025,9 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		return 0;
 	}
 
-	hard_reset = !!(flags & HL_RESET_HARD);
-	from_hard_reset_thread = !!(flags & HL_RESET_FROM_RESET_THREAD);
-	fw_reset = !!(flags & HL_RESET_FW);
+	hard_reset = !!(flags & HL_DRV_RESET_HARD);
+	from_hard_reset_thread = !!(flags & HL_DRV_RESET_FROM_RESET_THR);
+	fw_reset = !!(flags & HL_DRV_RESET_BYPASS_REQ_TO_FW);
 
 	if (!hard_reset && !hdev->supports_soft_reset) {
 		hard_instead_soft = true;
@@ -1035,7 +1035,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	}
 
 	if (hdev->reset_upon_device_release &&
-			(flags & HL_RESET_DEVICE_RELEASE)) {
+			(flags & HL_DRV_RESET_DEV_RELEASE)) {
 		dev_dbg(hdev->dev,
 			"Perform %s-reset upon device release\n",
 			hard_reset ? "hard" : "soft");
@@ -1075,7 +1075,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 
 		if (hard_reset)
 			dev_info(hdev->dev, "Going to reset device\n");
-		else if (flags & HL_RESET_DEVICE_RELEASE)
+		else if (flags & HL_DRV_RESET_DEV_RELEASE)
 			dev_info(hdev->dev,
 				"Going to reset device after it was released by user\n");
 		else
@@ -1171,7 +1171,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		hdev->hard_reset_pending = false;
 
 		if (hdev->reset_trigger_repeated &&
-				(hdev->prev_reset_trigger == HL_RESET_FW_FATAL_ERR)) {
+				(hdev->prev_reset_trigger == HL_DRV_RESET_FW_FATAL_ERR)) {
 			/* if there 2 back to back resets from FW,
 			 * ensure driver puts the driver in a unusable state
 			 */
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index dc61f7031c38..92d12c8ba569 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -120,37 +120,37 @@ enum hl_mmu_page_table_location {
 /*
  * Reset Flags
  *
- * - HL_RESET_HARD
+ * - HL_DRV_RESET_HARD
  *       If set do hard reset to all engines. If not set reset just
  *       compute/DMA engines.
  *
- * - HL_RESET_FROM_RESET_THREAD
+ * - HL_DRV_RESET_FROM_RESET_THR
  *       Set if the caller is the hard-reset thread
  *
- * - HL_RESET_HEARTBEAT
+ * - HL_DRV_RESET_HEARTBEAT
  *       Set if reset is due to heartbeat
  *
- * - HL_RESET_TDR
+ * - HL_DRV_RESET_TDR
  *       Set if reset is due to TDR
  *
- * - HL_RESET_DEVICE_RELEASE
+ * - HL_DRV_RESET_DEV_RELEASE
  *       Set if reset is due to device release
  *
- * - HL_RESET_FW
+ * - HL_DRV_RESET_BYPASS_REQ_TO_FW
  *       F/W will perform the reset. No need to ask it to reset the device. This is relevant
  *       only when running with secured f/w
  *
- * - HL_RESET_FW_FATAL_ERR
+ * - HL_DRV_RESET_FW_FATAL_ERR
  *       Set if reset is due to a fatal error from FW
  */
 
-#define HL_RESET_HARD			(1 << 0)
-#define HL_RESET_FROM_RESET_THREAD	(1 << 1)
-#define HL_RESET_HEARTBEAT		(1 << 2)
-#define HL_RESET_TDR			(1 << 3)
-#define HL_RESET_DEVICE_RELEASE		(1 << 4)
-#define HL_RESET_FW			(1 << 5)
-#define HL_RESET_FW_FATAL_ERR		(1 << 6)
+#define HL_DRV_RESET_HARD		(1 << 0)
+#define HL_DRV_RESET_FROM_RESET_THR	(1 << 1)
+#define HL_DRV_RESET_HEARTBEAT		(1 << 2)
+#define HL_DRV_RESET_TDR		(1 << 3)
+#define HL_DRV_RESET_DEV_RELEASE	(1 << 4)
+#define HL_DRV_RESET_BYPASS_REQ_TO_FW	(1 << 5)
+#define HL_DRV_RESET_FW_FATAL_ERR	(1 << 6)
 
 #define HL_MAX_SOBS_PER_MONITOR	8
 
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index cd3640617d02..530f8b4fadd2 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -316,7 +316,7 @@ static int free_phys_pg_pack(struct hl_device *hdev,
 	}
 
 	if (rc && !hdev->disabled)
-		hl_device_reset(hdev, HL_RESET_HARD);
+		hl_device_reset(hdev, HL_DRV_RESET_HARD);
 
 end:
 	kvfree(phys_pg_pack->pages);
diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
index 42c1769ad25d..aee0cc4d6155 100644
--- a/drivers/misc/habanalabs/common/sysfs.c
+++ b/drivers/misc/habanalabs/common/sysfs.c
@@ -236,7 +236,7 @@ static ssize_t hard_reset_store(struct device *dev,
 
 	dev_warn(hdev->dev, "Hard-Reset requested through sysfs\n");
 
-	hl_device_reset(hdev, HL_RESET_HARD);
+	hl_device_reset(hdev, HL_DRV_RESET_HARD);
 
 out:
 	return count;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 738ad2498439..2724ab3747f2 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -8003,7 +8003,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 	case GAUDI_EVENT_NIC0_CS_DBG_DERR ... GAUDI_EVENT_NIC4_CS_DBG_DERR:
 		gaudi_print_irq_info(hdev, event_type, true);
 		gaudi_handle_ecc_event(hdev, event_type, &eq_entry->ecc_data);
-		fw_fatal_err_flag = HL_RESET_FW_FATAL_ERR;
+		fw_fatal_err_flag = HL_DRV_RESET_FW_FATAL_ERR;
 		goto reset_device;
 
 	case GAUDI_EVENT_GIC500:
@@ -8011,7 +8011,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 	case GAUDI_EVENT_L2_RAM_ECC:
 	case GAUDI_EVENT_PLL0 ... GAUDI_EVENT_PLL17:
 		gaudi_print_irq_info(hdev, event_type, false);
-		fw_fatal_err_flag = HL_RESET_FW_FATAL_ERR;
+		fw_fatal_err_flag = HL_DRV_RESET_FW_FATAL_ERR;
 		goto reset_device;
 
 	case GAUDI_EVENT_HBM0_SPI_0:
@@ -8022,7 +8022,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 		gaudi_hbm_read_interrupts(hdev,
 				gaudi_hbm_event_to_dev(event_type),
 				&eq_entry->hbm_ecc_data);
-		fw_fatal_err_flag = HL_RESET_FW_FATAL_ERR;
+		fw_fatal_err_flag = HL_DRV_RESET_FW_FATAL_ERR;
 		goto reset_device;
 
 	case GAUDI_EVENT_HBM0_SPI_1:
@@ -8205,9 +8205,11 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 
 reset_device:
 	if (hdev->asic_prop.fw_security_enabled)
-		hl_device_reset(hdev, HL_RESET_HARD | HL_RESET_FW | fw_fatal_err_flag);
+		hl_device_reset(hdev, HL_DRV_RESET_HARD
+					| HL_DRV_RESET_BYPASS_REQ_TO_FW
+					| fw_fatal_err_flag);
 	else if (hdev->hard_reset_on_fw_events)
-		hl_device_reset(hdev, HL_RESET_HARD | fw_fatal_err_flag);
+		hl_device_reset(hdev, HL_DRV_RESET_HARD | fw_fatal_err_flag);
 	else
 		hl_fw_unmask_irq(hdev, event_type);
 }
@@ -8260,7 +8262,7 @@ static int gaudi_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
 	if (rc) {
 		dev_err_ratelimited(hdev->dev,
 					"MMU cache invalidation timeout\n");
-		hl_device_reset(hdev, HL_RESET_HARD);
+		hl_device_reset(hdev, HL_DRV_RESET_HARD);
 	}
 
 	return rc;
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 959eb21dcc69..3bbcab7da25e 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4838,14 +4838,14 @@ void goya_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry)
 	case GOYA_ASYNC_EVENT_ID_L2_RAM_ECC:
 		goya_print_irq_info(hdev, event_type, false);
 		if (hdev->hard_reset_on_fw_events)
-			hl_device_reset(hdev, (HL_RESET_HARD |
-						HL_RESET_FW_FATAL_ERR));
+			hl_device_reset(hdev, (HL_DRV_RESET_HARD |
+						HL_DRV_RESET_FW_FATAL_ERR));
 		break;
 
 	case GOYA_ASYNC_EVENT_ID_PSOC_GPIO_05_SW_RESET:
 		goya_print_irq_info(hdev, event_type, false);
 		if (hdev->hard_reset_on_fw_events)
-			hl_device_reset(hdev, HL_RESET_HARD);
+			hl_device_reset(hdev, HL_DRV_RESET_HARD);
 		break;
 
 	case GOYA_ASYNC_EVENT_ID_PCIE_DEC:
@@ -4905,7 +4905,7 @@ void goya_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry)
 		goya_print_irq_info(hdev, event_type, false);
 		goya_print_out_of_sync_info(hdev, &eq_entry->pkt_sync_err);
 		if (hdev->hard_reset_on_fw_events)
-			hl_device_reset(hdev, HL_RESET_HARD);
+			hl_device_reset(hdev, HL_DRV_RESET_HARD);
 		else
 			hl_fw_unmask_irq(hdev, event_type);
 		break;
@@ -5239,7 +5239,7 @@ static int goya_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
 	if (rc) {
 		dev_err_ratelimited(hdev->dev,
 					"MMU cache invalidation timeout\n");
-		hl_device_reset(hdev, HL_RESET_HARD);
+		hl_device_reset(hdev, HL_DRV_RESET_HARD);
 	}
 
 	return rc;
-- 
2.25.1


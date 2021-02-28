Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6746327419
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 20:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhB1T2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 14:28:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:46048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231185AbhB1T2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 14:28:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CEC964E01;
        Sun, 28 Feb 2021 19:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614540457;
        bh=0S0+k5X4Jon6qwtoaaeWjB0mFRlApqjoUF/MhsXOQKE=;
        h=From:To:Cc:Subject:Date:From;
        b=c6M7Tu9OnToyqOum7aBAZCCFv/u1G6rPrf3YN/MQsvdhA5LoAa7j7yDk7O61gqkpI
         4zfsCTLukue51WZqXuYmokrgns9cO8ybn/nOOSkDwOMVDo4/kGj/KYZxgJFasptPRe
         UgdVX0CA2xlrm8TbIrLmtr5qceaslMAA98+OBlofkSFMoCJqam2qGnYb6y9rFb1Uc+
         JLzYQFCGuI+llQbUPklp3M1vo7j9EH/jUXEIHxZhSHp3rOD4AicmM8BxkyqF2/fTqH
         Fxr61mVaJRborauXaEYYU1AlPoaTQRlB46xp4TuecY4MNEJ0oq2JxzoYsKKIfTUHYM
         BctCCZXaQBRlg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 1/2] habanalabs: skip DISABLE PCI packet to FW on heartbeat
Date:   Sun, 28 Feb 2021 21:27:32 +0200
Message-Id: <20210228192733.12076-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

if reset is due to heartbeat, device CPU is no responsive in which
case no point sending PCI disable message to it.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    |  4 +-
 drivers/misc/habanalabs/common/debugfs.c      |  2 +-
 drivers/misc/habanalabs/common/device.c       | 25 +++++++-----
 drivers/misc/habanalabs/common/habanalabs.h   | 20 +++++++++-
 drivers/misc/habanalabs/common/sysfs.c        |  4 +-
 drivers/misc/habanalabs/gaudi/gaudi.c         | 40 ++++++++-----------
 drivers/misc/habanalabs/goya/goya.c           |  8 ++--
 7 files changed, 59 insertions(+), 44 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 7d0d3e61a6e7..34a98e3c3bf8 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -620,7 +620,7 @@ static void cs_timedout(struct work_struct *work)
 	cs_put(cs);
 
 	if (hdev->reset_on_lockup)
-		hl_device_reset(hdev, false, false);
+		hl_device_reset(hdev, 0);
 	else
 		hdev->needs_reset = true;
 }
@@ -1473,7 +1473,7 @@ static int hl_cs_ctx_switch(struct hl_fpriv *hpriv, union hl_cs_args *args,
 
 out:
 	if ((rc == -ETIMEDOUT || rc == -EBUSY) && (need_soft_reset))
-		hl_device_reset(hdev, false, false);
+		hl_device_reset(hdev, 0);
 
 	return rc;
 }
diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index d4a49d6d1753..94d574953dd0 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -887,7 +887,7 @@ static ssize_t hl_stop_on_err_write(struct file *f, const char __user *buf,
 
 	hdev->stop_on_err = value ? 1 : 0;
 
-	hl_device_reset(hdev, false, false);
+	hl_device_reset(hdev, 0);
 
 	return count;
 }
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 2cbe9d04c229..756d7f2a7a2d 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -72,7 +72,7 @@ static void hpriv_release(struct kref *ref)
 	kfree(hpriv);
 
 	if (hdev->reset_upon_device_release)
-		hl_device_reset(hdev, false, false);
+		hl_device_reset(hdev, 0);
 }
 
 void hl_hpriv_get(struct hl_fpriv *hpriv)
@@ -276,7 +276,7 @@ static void device_hard_reset_pending(struct work_struct *work)
 	struct hl_device *hdev = device_reset_work->hdev;
 	int rc;
 
-	rc = hl_device_reset(hdev, true, true);
+	rc = hl_device_reset(hdev, HL_RESET_HARD | HL_RESET_FROM_RESET_THREAD);
 	if ((rc == -EBUSY) && !hdev->device_fini_pending) {
 		dev_info(hdev->dev,
 			"Could not reset device. will try again in %u seconds",
@@ -478,7 +478,7 @@ static void hl_device_heartbeat(struct work_struct *work)
 		goto reschedule;
 
 	dev_err(hdev->dev, "Device heartbeat failed!\n");
-	hl_device_reset(hdev, true, false);
+	hl_device_reset(hdev, HL_RESET_HARD | HL_RESET_HEARTBEAT);
 
 	return;
 
@@ -802,7 +802,7 @@ int hl_device_resume(struct hl_device *hdev)
 	hdev->disabled = false;
 	atomic_set(&hdev->in_reset, 0);
 
-	rc = hl_device_reset(hdev, true, false);
+	rc = hl_device_reset(hdev, HL_RESET_HARD);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to reset device during resume\n");
 		goto disable_device;
@@ -898,9 +898,7 @@ static int device_kill_open_processes(struct hl_device *hdev, u32 timeout)
  * hl_device_reset - reset the device
  *
  * @hdev: pointer to habanalabs device structure
- * @hard_reset: should we do hard reset to all engines or just reset the
- *              compute/dma engines
- * @from_hard_reset_thread: is the caller the hard-reset thread
+ * @flags: reset flags.
  *
  * Block future CS and wait for pending CS to be enqueued
  * Call ASIC H/W fini
@@ -912,10 +910,10 @@ static int device_kill_open_processes(struct hl_device *hdev, u32 timeout)
  *
  * Returns 0 for success or an error on failure.
  */
-int hl_device_reset(struct hl_device *hdev, bool hard_reset,
-			bool from_hard_reset_thread)
+int hl_device_reset(struct hl_device *hdev, u32 flags)
 {
 	u64 idle_mask[HL_BUSY_ENGINES_MASK_EXT_SIZE] = {0};
+	bool hard_reset, from_hard_reset_thread;
 	int i, rc;
 
 	if (!hdev->init_done) {
@@ -924,6 +922,9 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 		return 0;
 	}
 
+	hard_reset = (flags & HL_RESET_HARD) != 0;
+	from_hard_reset_thread = (flags & HL_RESET_FROM_RESET_THREAD) != 0;
+
 	if ((!hard_reset) && (!hdev->supports_soft_reset)) {
 		dev_dbg(hdev->dev, "Doing hard-reset instead of soft-reset\n");
 		hard_reset = true;
@@ -944,7 +945,11 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 		if (rc)
 			return 0;
 
-		if (hard_reset) {
+		/*
+		 * if reset is due to heartbeat, device CPU is no responsive in
+		 * which case no point sending PCI disable message to it
+		 */
+		if (hard_reset && !(flags & HL_RESET_HEARTBEAT)) {
 			/* Disable PCI access from device F/W so he won't send
 			 * us additional interrupts. We disable MSI/MSI-X at
 			 * the halt_engines function and we can't have the F/W
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 33ada9425a62..ba7b63374c06 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -104,6 +104,23 @@ enum hl_mmu_page_table_location {
 
 #define HL_MAX_DCORES			4
 
+/*
+ * Reset Flags
+ *
+ * - HL_RESET_HARD
+ *       If set do hard reset to all engines. If not set reset just
+ *       compute/DMA engines.
+ *
+ * - HL_RESET_FROM_RESET_THREAD
+ *       Set if the caller is the hard-reset thread
+ *
+ * - HL_RESET_HEARTBEAT
+ *       Set if reset is due to heartbeat
+ */
+#define HL_RESET_HARD			(1 << 0)
+#define HL_RESET_FROM_RESET_THREAD	(1 << 1)
+#define HL_RESET_HEARTBEAT		(1 << 2)
+
 #define HL_MAX_SOBS_PER_MONITOR	8
 
 /**
@@ -2244,8 +2261,7 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass);
 void hl_device_fini(struct hl_device *hdev);
 int hl_device_suspend(struct hl_device *hdev);
 int hl_device_resume(struct hl_device *hdev);
-int hl_device_reset(struct hl_device *hdev, bool hard_reset,
-			bool from_hard_reset_thread);
+int hl_device_reset(struct hl_device *hdev, u32 flags);
 void hl_hpriv_get(struct hl_fpriv *hpriv);
 int hl_hpriv_put(struct hl_fpriv *hpriv);
 int hl_device_set_frequency(struct hl_device *hdev, enum hl_pll_frequency freq);
diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
index 4366d8f93842..9bd13bdc1ba9 100644
--- a/drivers/misc/habanalabs/common/sysfs.c
+++ b/drivers/misc/habanalabs/common/sysfs.c
@@ -203,7 +203,7 @@ static ssize_t soft_reset_store(struct device *dev,
 
 	dev_warn(hdev->dev, "Soft-Reset requested through sysfs\n");
 
-	hl_device_reset(hdev, false, false);
+	hl_device_reset(hdev, 0);
 
 out:
 	return count;
@@ -226,7 +226,7 @@ static ssize_t hard_reset_store(struct device *dev,
 
 	dev_warn(hdev->dev, "Hard-Reset requested through sysfs\n");
 
-	hl_device_reset(hdev, true, false);
+	hl_device_reset(hdev, HL_RESET_HARD);
 
 out:
 	return count;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index eee9387c8a26..37e3f4cd05c0 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7380,18 +7380,14 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 	case GAUDI_EVENT_MMU_DERR:
 		gaudi_print_irq_info(hdev, event_type, true);
 		gaudi_handle_ecc_event(hdev, event_type, &eq_entry->ecc_data);
-		if (hdev->hard_reset_on_fw_events)
-			hl_device_reset(hdev, true, false);
-		break;
+		goto reset_device;
 
 	case GAUDI_EVENT_GIC500:
 	case GAUDI_EVENT_AXI_ECC:
 	case GAUDI_EVENT_L2_RAM_ECC:
 	case GAUDI_EVENT_PLL0 ... GAUDI_EVENT_PLL17:
 		gaudi_print_irq_info(hdev, event_type, false);
-		if (hdev->hard_reset_on_fw_events)
-			hl_device_reset(hdev, true, false);
-		break;
+		goto reset_device;
 
 	case GAUDI_EVENT_HBM0_SPI_0:
 	case GAUDI_EVENT_HBM1_SPI_0:
@@ -7401,9 +7397,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 		gaudi_hbm_read_interrupts(hdev,
 				gaudi_hbm_event_to_dev(event_type),
 				&eq_entry->hbm_ecc_data);
-		if (hdev->hard_reset_on_fw_events)
-			hl_device_reset(hdev, true, false);
-		break;
+		goto reset_device;
 
 	case GAUDI_EVENT_HBM0_SPI_1:
 	case GAUDI_EVENT_HBM1_SPI_1:
@@ -7432,8 +7426,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 			dev_err(hdev->dev, "hard reset required due to %s\n",
 				gaudi_irq_map_table[event_type].name);
 
-			if (hdev->hard_reset_on_fw_events)
-				hl_device_reset(hdev, true, false);
+			goto reset_device;
 		} else {
 			hl_fw_unmask_irq(hdev, event_type);
 		}
@@ -7455,8 +7448,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 			dev_err(hdev->dev, "hard reset required due to %s\n",
 				gaudi_irq_map_table[event_type].name);
 
-			if (hdev->hard_reset_on_fw_events)
-				hl_device_reset(hdev, true, false);
+			goto reset_device;
 		} else {
 			hl_fw_unmask_irq(hdev, event_type);
 		}
@@ -7525,9 +7517,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 
 	case GAUDI_EVENT_RAZWI_OR_ADC_SW:
 		gaudi_print_irq_info(hdev, event_type, true);
-		if (hdev->hard_reset_on_fw_events)
-			hl_device_reset(hdev, true, false);
-		break;
+		goto reset_device;
 
 	case GAUDI_EVENT_TPC0_BMON_SPMU:
 	case GAUDI_EVENT_TPC1_BMON_SPMU:
@@ -7564,17 +7554,21 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 	case GAUDI_EVENT_PKT_QUEUE_OUT_SYNC:
 		gaudi_print_irq_info(hdev, event_type, false);
 		gaudi_print_out_of_sync_info(hdev, &eq_entry->pkt_sync_err);
-		if (hdev->hard_reset_on_fw_events)
-			hl_device_reset(hdev, true, false);
-		else
-			hl_fw_unmask_irq(hdev, event_type);
-		break;
+		goto reset_device;
 
 	default:
 		dev_err(hdev->dev, "Received invalid H/W interrupt %d\n",
 				event_type);
 		break;
 	}
+
+	return;
+
+reset_device:
+	if (hdev->hard_reset_on_fw_events)
+		hl_device_reset(hdev, HL_RESET_HARD);
+	else
+		hl_fw_unmask_irq(hdev, event_type);
 }
 
 static void *gaudi_get_events_stat(struct hl_device *hdev, bool aggregate,
@@ -7625,7 +7619,7 @@ static int gaudi_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
 	if (rc) {
 		dev_err_ratelimited(hdev->dev,
 					"MMU cache invalidation timeout\n");
-		hl_device_reset(hdev, true, false);
+		hl_device_reset(hdev, HL_RESET_HARD);
 	}
 
 	return rc;
@@ -7674,7 +7668,7 @@ static int gaudi_mmu_invalidate_cache_range(struct hl_device *hdev,
 	if (rc) {
 		dev_err_ratelimited(hdev->dev,
 					"MMU cache invalidation timeout\n");
-		hl_device_reset(hdev, true, false);
+		hl_device_reset(hdev, HL_RESET_HARD);
 	}
 
 	return rc;
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 1eaf9c06227c..452bef461fe4 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4712,7 +4712,7 @@ void goya_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry)
 	case GOYA_ASYNC_EVENT_ID_PSOC_GPIO_05_SW_RESET:
 		goya_print_irq_info(hdev, event_type, false);
 		if (hdev->hard_reset_on_fw_events)
-			hl_device_reset(hdev, true, false);
+			hl_device_reset(hdev, HL_RESET_HARD);
 		break;
 
 	case GOYA_ASYNC_EVENT_ID_PCIE_DEC:
@@ -4772,7 +4772,7 @@ void goya_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry)
 		goya_print_irq_info(hdev, event_type, false);
 		goya_print_out_of_sync_info(hdev, &eq_entry->pkt_sync_err);
 		if (hdev->hard_reset_on_fw_events)
-			hl_device_reset(hdev, true, false);
+			hl_device_reset(hdev, HL_RESET_HARD);
 		else
 			hl_fw_unmask_irq(hdev, event_type);
 		break;
@@ -5106,7 +5106,7 @@ static int goya_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
 	if (rc) {
 		dev_err_ratelimited(hdev->dev,
 					"MMU cache invalidation timeout\n");
-		hl_device_reset(hdev, true, false);
+		hl_device_reset(hdev, HL_RESET_HARD);
 	}
 
 	return rc;
@@ -5157,7 +5157,7 @@ static int goya_mmu_invalidate_cache_range(struct hl_device *hdev,
 	if (rc) {
 		dev_err_ratelimited(hdev->dev,
 					"MMU cache invalidation timeout\n");
-		hl_device_reset(hdev, true, false);
+		hl_device_reset(hdev, HL_RESET_HARD);
 	}
 
 	return rc;
-- 
2.25.1


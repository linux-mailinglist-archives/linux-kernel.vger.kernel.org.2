Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B66B427FF9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 10:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhJJIFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 04:05:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229697AbhJJIFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 04:05:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70CA2608FB;
        Sun, 10 Oct 2021 08:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633852993;
        bh=JkIHKUW1U3BBPxq7L/VVw9kZ9KW6EhJnitWzErW2JZ8=;
        h=From:To:Cc:Subject:Date:From;
        b=iezQuC5NLvOQndENM5xRdw/4nkqCt/E+k7g6Nx/6gh3KoTe6M/60Hgh82SqeyUMVB
         zftHl1P2b1v+z5VYQclLT+kYkRf0RNXVvz/GAkukHA9Cf8r6rDGmBC9zXI15lYWDCQ
         r/1uvZgDhQjtFX933HXSBTGgFaFQBVEx/BeRlS7+mSa+nSUb/x0AYmwIxr7K7AmyB9
         ftL+kDB+9+Gwuww55kgkO7QVq9RyW6yDRJBkwquaFlT4450Vgq7NHhdrltzUaXi6jq
         ihB6MXK9c+sznL3ASM4v6KD07IY1HHSfA48JOhk20hQpUq5+EI2HvJZlaAQQ6MUxVw
         tgztSOqRtlqiA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Bharat Jauhari <bjauhari@habana.ai>
Subject: [PATCH 1/5] habanalabs: bypass reset for continuous h/w error event
Date:   Sun, 10 Oct 2021 11:03:03 +0300
Message-Id: <20211010080307.153420-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bharat Jauhari <bjauhari@habana.ai>

There may be a situation where drivers receives continuous fatal H/W
error events from FW immediately post reset cycle.
This may be due to some fault on the silicon itself.
In such case its better to bypass reset cycle so we won't be stuck in
endless loop of resets.

This commit bypasses reset request in case driver received two back to
back FW fatal error before first occurrence of heartbeat event.

Signed-off-by: Bharat Jauhari <bjauhari@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c       | 118 +++++++++++++-----
 drivers/misc/habanalabs/common/habanalabs.h   |  14 +++
 .../misc/habanalabs/common/habanalabs_drv.c   |   1 +
 drivers/misc/habanalabs/gaudi/gaudi.c         |   8 +-
 drivers/misc/habanalabs/goya/goya.c           |   6 +
 5 files changed, 111 insertions(+), 36 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index e1949b087ae3..2022e5d7b3ad 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -546,6 +546,19 @@ static void hl_device_heartbeat(struct work_struct *work)
 	return;
 
 reschedule:
+	/*
+	 * prev_reset_trigger tracks consecutive fatal h/w errors until first
+	 * heartbeat immediately post reset.
+	 * If control reached here, then at least one heartbeat work has been
+	 * scheduled since last reset/init cycle.
+	 * So if the device is not already in reset cycle, reset the flag
+	 * prev_reset_trigger as no reset occurred with HL_RESET_FW_FATAL_ERR
+	 * status for at least one heartbeat. From this point driver restarts
+	 * tracking future consecutive fatal errors.
+	 */
+	if (!(atomic_read(&hdev->in_reset)))
+		hdev->prev_reset_trigger = HL_RESET_TRIGGER_DEFAULT;
+
 	schedule_delayed_work(&hdev->work_heartbeat,
 			usecs_to_jiffies(HL_HEARTBEAT_PER_USEC));
 }
@@ -925,6 +938,65 @@ static void device_disable_open_processes(struct hl_device *hdev)
 	mutex_unlock(&hdev->fpriv_list_lock);
 }
 
+static void handle_reset_trigger(struct hl_device *hdev, u32 flags)
+{
+	u32 cur_reset_trigger = HL_RESET_TRIGGER_DEFAULT;
+
+	/*
+	 * 'reset cause' is being updated here, because getting here
+	 * means that it's the 1st time and the last time we're here
+	 * ('in_reset' makes sure of it). This makes sure that
+	 * 'reset_cause' will continue holding its 1st recorded reason!
+	 */
+	if (flags & HL_RESET_HEARTBEAT) {
+		hdev->curr_reset_cause = HL_RESET_CAUSE_HEARTBEAT;
+		cur_reset_trigger = HL_RESET_HEARTBEAT;
+	} else if (flags & HL_RESET_TDR) {
+		hdev->curr_reset_cause = HL_RESET_CAUSE_TDR;
+		cur_reset_trigger = HL_RESET_TDR;
+	} else if (flags & HL_RESET_FW_FATAL_ERR) {
+		hdev->curr_reset_cause = HL_RESET_CAUSE_UNKNOWN;
+		cur_reset_trigger = HL_RESET_FW_FATAL_ERR;
+	} else {
+		hdev->curr_reset_cause = HL_RESET_CAUSE_UNKNOWN;
+	}
+
+	/*
+	 * If reset cause is same twice, then reset_trigger_repeated
+	 * is set and if this reset is due to a fatal FW error
+	 * device is set to an unstable state.
+	 */
+	if (hdev->prev_reset_trigger != cur_reset_trigger) {
+		hdev->prev_reset_trigger = cur_reset_trigger;
+		hdev->reset_trigger_repeated = 0;
+	} else {
+		hdev->reset_trigger_repeated = 1;
+	}
+
+	/* If reset is due to heartbeat, device CPU is no responsive in
+	 * which case no point sending PCI disable message to it.
+	 *
+	 * If F/W is performing the reset, no need to send it a message to disable
+	 * PCI access
+	 */
+	if ((flags & HL_RESET_HARD) &&
+			!(flags & (HL_RESET_HEARTBEAT | HL_RESET_FW))) {
+		/* Disable PCI access from device F/W so he won't send
+		 * us additional interrupts. We disable MSI/MSI-X at
+		 * the halt_engines function and we can't have the F/W
+		 * sending us interrupts after that. We need to disable
+		 * the access here because if the device is marked
+		 * disable, the message won't be send. Also, in case
+		 * of heartbeat, the device CPU is marked as disable
+		 * so this message won't be sent
+		 */
+		if (hl_fw_send_pci_access_msg(hdev,
+				CPUCP_PACKET_DISABLE_PCI_ACCESS))
+			dev_warn(hdev->dev,
+				"Failed to disable PCI access by F/W\n");
+	}
+}
+
 /*
  * hl_device_reset - reset the device
  *
@@ -994,40 +1066,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		if (rc)
 			return 0;
 
-		/*
-		 * 'reset cause' is being updated here, because getting here
-		 * means that it's the 1st time and the last time we're here
-		 * ('in_reset' makes sure of it). This makes sure that
-		 * 'reset_cause' will continue holding its 1st recorded reason!
-		 */
-		if (flags & HL_RESET_HEARTBEAT)
-			hdev->curr_reset_cause = HL_RESET_CAUSE_HEARTBEAT;
-		else if (flags & HL_RESET_TDR)
-			hdev->curr_reset_cause = HL_RESET_CAUSE_TDR;
-		else
-			hdev->curr_reset_cause = HL_RESET_CAUSE_UNKNOWN;
-
-		/* If reset is due to heartbeat, device CPU is no responsive in
-		 * which case no point sending PCI disable message to it.
-		 *
-		 * If F/W is performing the reset, no need to send it a message to disable
-		 * PCI access
-		 */
-		if (hard_reset && !(flags & (HL_RESET_HEARTBEAT | HL_RESET_FW))) {
-			/* Disable PCI access from device F/W so he won't send
-			 * us additional interrupts. We disable MSI/MSI-X at
-			 * the halt_engines function and we can't have the F/W
-			 * sending us interrupts after that. We need to disable
-			 * the access here because if the device is marked
-			 * disable, the message won't be send. Also, in case
-			 * of heartbeat, the device CPU is marked as disable
-			 * so this message won't be sent
-			 */
-			if (hl_fw_send_pci_access_msg(hdev,
-					CPUCP_PACKET_DISABLE_PCI_ACCESS))
-				dev_warn(hdev->dev,
-					"Failed to disable PCI access by F/W\n");
-		}
+		handle_reset_trigger(hdev, flags);
 
 		/* This also blocks future CS/VM/JOB completion operations */
 		hdev->disabled = true;
@@ -1131,6 +1170,17 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		hdev->device_cpu_disabled = false;
 		hdev->hard_reset_pending = false;
 
+		if (hdev->reset_trigger_repeated &&
+				(hdev->prev_reset_trigger == HL_RESET_FW_FATAL_ERR)) {
+			/* if there 2 back to back resets from FW,
+			 * ensure driver puts the driver in a unusable state
+			 */
+			dev_crit(hdev->dev,
+				"Consecutive FW fatal errors received, stopping hard reset\n");
+			rc = -EIO;
+			goto out_err;
+		}
+
 		if (hdev->kernel_ctx) {
 			dev_crit(hdev->dev,
 				"kernel ctx was alive during hard reset, something is terribly wrong\n");
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 2d9edd734d1c..a06135155b57 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -68,6 +68,9 @@
 
 #define HL_STATE_DUMP_HIST_LEN		5
 
+/* Default value for device reset trigger , an invalid value */
+#define HL_RESET_TRIGGER_DEFAULT	0xFF
+
 #define OBJ_NAMES_HASH_TABLE_BITS	7 /* 1 << 7 buckets */
 #define SYNC_TO_ENGINE_HASH_TABLE_BITS	7 /* 1 << 7 buckets */
 
@@ -132,13 +135,18 @@ enum hl_mmu_page_table_location {
  * - HL_RESET_FW
  *       F/W will perform the reset. No need to ask it to reset the device. This is relevant
  *       only when running with secured f/w
+ *
+ * - HL_RESET_FW_FATAL_ERR
+ *       Set if reset is due to a fatal error from FW
  */
+
 #define HL_RESET_HARD			(1 << 0)
 #define HL_RESET_FROM_RESET_THREAD	(1 << 1)
 #define HL_RESET_HEARTBEAT		(1 << 2)
 #define HL_RESET_TDR			(1 << 3)
 #define HL_RESET_DEVICE_RELEASE		(1 << 4)
 #define HL_RESET_FW			(1 << 5)
+#define HL_RESET_FW_FATAL_ERR		(1 << 6)
 
 #define HL_MAX_SOBS_PER_MONITOR	8
 
@@ -2458,6 +2466,10 @@ struct multi_cs_data {
  * @supports_staged_submission: true if staged submissions are supported
  * @curr_reset_cause: saves an enumerated reset cause when a hard reset is
  *                    triggered, and cleared after it is shared with preboot.
+ * @prev_reset_trigger: saves the previous trigger which caused a reset, overidden
+ *                      with a new value on next reset
+ * @reset_trigger_repeated: set if device reset is triggered more than once with
+ *                          same cause.
  * @skip_reset_on_timeout: Skip device reset if CS has timed out, wait for it to
  *                         complete instead.
  * @device_cpu_is_halted: Flag to indicate whether the device CPU was already
@@ -2585,6 +2597,8 @@ struct hl_device {
 	u8				device_fini_pending;
 	u8				supports_staged_submission;
 	u8				curr_reset_cause;
+	u8				prev_reset_trigger;
+	u8				reset_trigger_repeated;
 	u8				skip_reset_on_timeout;
 	u8				device_cpu_is_halted;
 	u8				supports_wait_for_multi_cs;
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index a75e4fceb9d8..1da56069750a 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -339,6 +339,7 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 	set_driver_behavior_per_device(hdev);
 
 	hdev->curr_reset_cause = HL_RESET_CAUSE_UNKNOWN;
+	hdev->prev_reset_trigger = HL_RESET_TRIGGER_DEFAULT;
 
 	if (timeout_locked)
 		hdev->timeout_jiffies = msecs_to_jiffies(timeout_locked * 1000);
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 14da87b38e83..70a668951ec4 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7932,6 +7932,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
 	u32 ctl = le32_to_cpu(eq_entry->hdr.ctl);
+	u32 fw_fatal_err_flag = 0;
 	u16 event_type = ((ctl & EQ_CTL_EVENT_TYPE_MASK)
 			>> EQ_CTL_EVENT_TYPE_SHIFT);
 	bool reset_required;
@@ -7972,6 +7973,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 	case GAUDI_EVENT_NIC0_CS_DBG_DERR ... GAUDI_EVENT_NIC4_CS_DBG_DERR:
 		gaudi_print_irq_info(hdev, event_type, true);
 		gaudi_handle_ecc_event(hdev, event_type, &eq_entry->ecc_data);
+		fw_fatal_err_flag = HL_RESET_FW_FATAL_ERR;
 		goto reset_device;
 
 	case GAUDI_EVENT_GIC500:
@@ -7979,6 +7981,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 	case GAUDI_EVENT_L2_RAM_ECC:
 	case GAUDI_EVENT_PLL0 ... GAUDI_EVENT_PLL17:
 		gaudi_print_irq_info(hdev, event_type, false);
+		fw_fatal_err_flag = HL_RESET_FW_FATAL_ERR;
 		goto reset_device;
 
 	case GAUDI_EVENT_HBM0_SPI_0:
@@ -7989,6 +7992,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 		gaudi_hbm_read_interrupts(hdev,
 				gaudi_hbm_event_to_dev(event_type),
 				&eq_entry->hbm_ecc_data);
+		fw_fatal_err_flag = HL_RESET_FW_FATAL_ERR;
 		goto reset_device;
 
 	case GAUDI_EVENT_HBM0_SPI_1:
@@ -8171,9 +8175,9 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 
 reset_device:
 	if (hdev->asic_prop.fw_security_enabled)
-		hl_device_reset(hdev, HL_RESET_HARD | HL_RESET_FW);
+		hl_device_reset(hdev, HL_RESET_HARD | HL_RESET_FW | fw_fatal_err_flag);
 	else if (hdev->hard_reset_on_fw_events)
-		hl_device_reset(hdev, HL_RESET_HARD);
+		hl_device_reset(hdev, HL_RESET_HARD | fw_fatal_err_flag);
 	else
 		hl_fw_unmask_irq(hdev, event_type);
 }
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index ef67e2586ede..78cf35879680 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4829,6 +4829,12 @@ void goya_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry)
 	case GOYA_ASYNC_EVENT_ID_PLL0 ... GOYA_ASYNC_EVENT_ID_PLL6:
 	case GOYA_ASYNC_EVENT_ID_AXI_ECC:
 	case GOYA_ASYNC_EVENT_ID_L2_RAM_ECC:
+		goya_print_irq_info(hdev, event_type, false);
+		if (hdev->hard_reset_on_fw_events)
+			hl_device_reset(hdev, (HL_RESET_HARD |
+						HL_RESET_FW_FATAL_ERR));
+		break;
+
 	case GOYA_ASYNC_EVENT_ID_PSOC_GPIO_05_SW_RESET:
 		goya_print_irq_info(hdev, event_type, false);
 		if (hdev->hard_reset_on_fw_events)
-- 
2.25.1


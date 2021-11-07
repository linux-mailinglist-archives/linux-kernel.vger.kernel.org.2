Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B444475F5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 21:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236473AbhKGUyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 15:54:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:56522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235804AbhKGUyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 15:54:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C9E5614C8
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 20:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636318317;
        bh=WWgE9PznJp6xEfuH9C5KqrhABXsmVhSdO0lmp2He8ys=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FKKbnthqaiiZM/9/5JyOe4KsPFQSf9LNucw1QWeYXPp5BRmG+p0lJKIPX0OFdQcHJ
         6xd1DUVv/vdFRNfImBZWTKizO4nen9ML4GUgCCDo5fV8rI8HIcRwfUqLGCWU4msnu8
         1sghAxCYFkrU8TfzBnSG/4Xj5VNZW8fPwjWUSlStk9/1VVqpXsjrCanLE+hhTka8B+
         qTxh6khsfN2n8cK7J3R9t2dmNauDO/OWWDBKvSNq236DZSOCiooOG90SRv45MAMQaH
         hf4st5ZEc/rmA4jFecZNQGJ4gDlSe3bQwT4xAATCkHwSFIYtIWg3ut+/vLgZTWILOb
         HzyDk5u/TUlMA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] habanalabs: make hdev creation code more readable
Date:   Sun,  7 Nov 2021 22:51:36 +0200
Message-Id: <20211107205136.2329007-10-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211107205136.2329007-1-ogabbay@kernel.org>
References: <20211107205136.2329007-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Divide the code into 3 different parts:
- Copy kernel parameters
- Setting device behaivor per asic
- Fixup of various device parameters according to the device behaivor.

In addition, remove non-relevant code for upstream (simulator support).

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h   |   6 +-
 .../misc/habanalabs/common/habanalabs_drv.c   | 123 +++++++++---------
 2 files changed, 61 insertions(+), 68 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index a19563c416ac..6b33fbd72fd8 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0
  *
- * Copyright 2016-2019 HabanaLabs, Ltd.
+ * Copyright 2016-2021 HabanaLabs, Ltd.
  * All Rights Reserved.
  *
  */
@@ -62,7 +62,6 @@
 #define HL_CPUCP_EEPROM_TIMEOUT_USEC	10000000 /* 10s */
 
 #define HL_FW_STATUS_POLL_INTERVAL_USEC		10000 /* 10ms */
-#define HL_FW_STATUS_PLDM_POLL_INTERVAL_USEC	300000000 /* 300s */
 
 #define HL_PCI_ELBI_TIMEOUT_MSEC	10 /* 10ms */
 
@@ -2823,9 +2822,6 @@ bool hl_device_operational(struct hl_device *hdev,
 		enum hl_device_status *status);
 enum hl_device_status hl_device_status(struct hl_device *hdev);
 int hl_device_set_debug_mode(struct hl_device *hdev, bool enable);
-int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
-		enum hl_asic_type asic_type, int minor);
-void destroy_hdev(struct hl_device *hdev);
 int hl_hw_queues_create(struct hl_device *hdev);
 void hl_hw_queues_destroy(struct hl_device *hdev);
 int hl_hw_queue_send_cb_no_cmpl(struct hl_device *hdev, u32 hw_queue_id,
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 5989826701bc..85034f2f2e89 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /*
- * Copyright 2016-2019 HabanaLabs, Ltd.
+ * Copyright 2016-2021 HabanaLabs, Ltd.
  * All Rights Reserved.
  *
  */
@@ -263,6 +263,7 @@ int hl_device_open_ctrl(struct inode *inode, struct file *filp)
 
 static void set_driver_behavior_per_device(struct hl_device *hdev)
 {
+	hdev->pldm = 0;
 	hdev->fw_components = FW_TYPE_ALL_TYPES;
 	hdev->cpu_queues_enable = 1;
 	hdev->heartbeat = 1;
@@ -279,23 +280,53 @@ static void set_driver_behavior_per_device(struct hl_device *hdev)
 	hdev->axi_drain = 0;
 }
 
-/*
+static void copy_kernel_module_params_to_device(struct hl_device *hdev)
+{
+	hdev->major = hl_major;
+	hdev->memory_scrub = memory_scrub;
+	hdev->reset_on_lockup = reset_on_lockup;
+	hdev->boot_error_status_mask = boot_error_status_mask;
+
+	if (timeout_locked)
+		hdev->timeout_jiffies = msecs_to_jiffies(timeout_locked * 1000);
+	else
+		hdev->timeout_jiffies = MAX_SCHEDULE_TIMEOUT;
+
+}
+
+static int fixup_device_params(struct hl_device *hdev)
+{
+	hdev->asic_prop.fw_security_enabled = is_asic_secured(hdev->asic_type);
+
+	hdev->fw_poll_interval_usec = HL_FW_STATUS_POLL_INTERVAL_USEC;
+
+	hdev->stop_on_err = true;
+	hdev->curr_reset_cause = HL_RESET_CAUSE_UNKNOWN;
+	hdev->prev_reset_trigger = HL_RESET_TRIGGER_DEFAULT;
+
+	/* Enable only after the initialization of the device */
+	hdev->disabled = true;
+
+	/* Set default DMA mask to 32 bits */
+	hdev->dma_mask = 32;
+
+	return 0;
+}
+
+/**
  * create_hdev - create habanalabs device instance
  *
  * @dev: will hold the pointer to the new habanalabs device structure
  * @pdev: pointer to the pci device
- * @asic_type: in case of simulator device, which device is it
- * @minor: in case of simulator device, the minor of the device
  *
  * Allocate memory for habanalabs device and initialize basic fields
  * Identify the ASIC type
  * Allocate ID (minor) for the device (only for real devices)
  */
-int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
-		enum hl_asic_type asic_type, int minor)
+static int create_hdev(struct hl_device **dev, struct pci_dev *pdev)
 {
+	int main_id, ctrl_id = 0, rc = 0;
 	struct hl_device *hdev;
-	int rc, main_id, ctrl_id = 0;
 
 	*dev = NULL;
 
@@ -303,72 +334,39 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 	if (!hdev)
 		return -ENOMEM;
 
-	/* First, we must find out which ASIC are we handling. This is needed
-	 * to configure the behavior of the driver (kernel parameters)
-	 */
-	if (pdev) {
-		hdev->asic_type = get_asic_type(pdev->device);
-		if (hdev->asic_type == ASIC_INVALID) {
-			dev_err(&pdev->dev, "Unsupported ASIC\n");
-			rc = -ENODEV;
-			goto free_hdev;
-		}
-	} else {
-		hdev->asic_type = asic_type;
-	}
-
-	if (pdev)
-		hdev->asic_prop.fw_security_enabled =
-					is_asic_secured(hdev->asic_type);
-	else
-		hdev->asic_prop.fw_security_enabled = false;
+	/* can be NULL in case of simulator device */
+	hdev->pdev = pdev;
 
 	/* Assign status description string */
-	strncpy(hdev->status[HL_DEVICE_STATUS_OPERATIONAL],
-					"operational", HL_STR_MAX);
-	strncpy(hdev->status[HL_DEVICE_STATUS_IN_RESET],
-					"in reset", HL_STR_MAX);
-	strncpy(hdev->status[HL_DEVICE_STATUS_MALFUNCTION],
-					"disabled", HL_STR_MAX);
-	strncpy(hdev->status[HL_DEVICE_STATUS_NEEDS_RESET],
-					"needs reset", HL_STR_MAX);
+	strncpy(hdev->status[HL_DEVICE_STATUS_OPERATIONAL], "operational", HL_STR_MAX);
+	strncpy(hdev->status[HL_DEVICE_STATUS_IN_RESET], "in reset", HL_STR_MAX);
+	strncpy(hdev->status[HL_DEVICE_STATUS_MALFUNCTION], "disabled", HL_STR_MAX);
+	strncpy(hdev->status[HL_DEVICE_STATUS_NEEDS_RESET], "needs reset", HL_STR_MAX);
 	strncpy(hdev->status[HL_DEVICE_STATUS_IN_DEVICE_CREATION],
 					"in device creation", HL_STR_MAX);
 
-	hdev->major = hl_major;
-	hdev->reset_on_lockup = reset_on_lockup;
-	hdev->memory_scrub = memory_scrub;
-	hdev->boot_error_status_mask = boot_error_status_mask;
-	hdev->stop_on_err = true;
+	/* First, we must find out which ASIC are we handling. This is needed
+	 * to configure the behavior of the driver (kernel parameters)
+	 */
+	hdev->asic_type = get_asic_type(pdev->device);
+	if (hdev->asic_type == ASIC_INVALID) {
+		dev_err(&pdev->dev, "Unsupported ASIC\n");
+		rc = -ENODEV;
+		goto free_hdev;
+	}
 
-	hdev->pldm = 0;
+	copy_kernel_module_params_to_device(hdev);
 
 	set_driver_behavior_per_device(hdev);
 
-	hdev->fw_poll_interval_usec = hdev->pldm ? HL_FW_STATUS_PLDM_POLL_INTERVAL_USEC :
-							HL_FW_STATUS_POLL_INTERVAL_USEC;
-
-	hdev->curr_reset_cause = HL_RESET_CAUSE_UNKNOWN;
-	hdev->prev_reset_trigger = HL_RESET_TRIGGER_DEFAULT;
-
-	if (timeout_locked)
-		hdev->timeout_jiffies = msecs_to_jiffies(timeout_locked * 1000);
-	else
-		hdev->timeout_jiffies = MAX_SCHEDULE_TIMEOUT;
-
-	hdev->disabled = true;
-	hdev->pdev = pdev; /* can be NULL in case of simulator device */
-
-	/* Set default DMA mask to 32 bits */
-	hdev->dma_mask = 32;
+	fixup_device_params(hdev);
 
 	mutex_lock(&hl_devs_idr_lock);
 
 	/* Always save 2 numbers, 1 for main device and 1 for control.
 	 * They must be consecutive
 	 */
-	main_id = idr_alloc(&hl_devs_idr, hdev, 0, HL_MAX_MINORS,
-				GFP_KERNEL);
+	main_id = idr_alloc(&hl_devs_idr, hdev, 0, HL_MAX_MINORS, GFP_KERNEL);
 
 	if (main_id >= 0)
 		ctrl_id = idr_alloc(&hl_devs_idr, hdev, main_id + 1,
@@ -408,7 +406,7 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
  * @dev: pointer to the habanalabs device structure
  *
  */
-void destroy_hdev(struct hl_device *hdev)
+static void destroy_hdev(struct hl_device *hdev)
 {
 	/* Remove device from the device list */
 	mutex_lock(&hl_devs_idr_lock);
@@ -447,7 +445,7 @@ static int hl_pmops_resume(struct device *dev)
 	return hl_device_resume(hdev);
 }
 
-/*
+/**
  * hl_pci_probe - probe PCI habanalabs devices
  *
  * @pdev: pointer to pci device
@@ -457,8 +455,7 @@ static int hl_pmops_resume(struct device *dev)
  * Create a new habanalabs device and initialize it according to the
  * device's type
  */
-static int hl_pci_probe(struct pci_dev *pdev,
-				const struct pci_device_id *id)
+static int hl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct hl_device *hdev;
 	int rc;
@@ -467,7 +464,7 @@ static int hl_pci_probe(struct pci_dev *pdev,
 		 " device found [%04x:%04x] (rev %x)\n",
 		 (int)pdev->vendor, (int)pdev->device, (int)pdev->revision);
 
-	rc = create_hdev(&hdev, pdev, ASIC_INVALID, -1);
+	rc = create_hdev(&hdev, pdev);
 	if (rc)
 		return rc;
 
-- 
2.25.1


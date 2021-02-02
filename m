Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1157630C718
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237185AbhBBRKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:10:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:37042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236985AbhBBQ4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:56:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42B2C64F87
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 16:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612284969;
        bh=6TGUCJUMZhRtmM1UYvc81rMpTe+uEskUyGr0VlcYLNU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kNbzWiaImTY90Z6QtP3pQb54YNWnQL9EPFqHMAjSrQSYsU34kCMyxmyd7SNZKnlOq
         JcyDSnIsP9RaAUV7ShTKrBNayMefhlKGBWpgniLSVGVUElYrTrIybA4yV9Bj0fsDMf
         +PPo7IYBkRI2Jh2nHIzG9CGBAjZuo1S2jslC9wdJhp+/4e9i7FaLh6adwGFZSB4Qma
         g5yWATSAhd9AOh/uN1DfAfRV/LnRnyDxZtKOM1DnfxXjcZJl8EVoMWNA+nLPrcAi8L
         nI935/iJa3JOyJ6mCI39VwObz8WBf4FhbgCQHhPqEGjvH7NMZx6pTGKEPb+5Bfnp5C
         Nph+IpSUi5xHg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] habanalabs: enable F/W events after init done
Date:   Tue,  2 Feb 2021 18:56:00 +0200
Message-Id: <20210202165600.4620-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210202165600.4620-1-ogabbay@kernel.org>
References: <20210202165600.4620-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only after the initialization of the device is done, the driver is
ready to receive events from the F/W. The driver can't handle events
before that because of races so it will ignore events. In case of
a fatal event, the driver won't know about it and the device will be
operational although it shouldn't be.

Same logic should be applied after hard-reset.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c     | 23 +++++++++++++++++----
 drivers/misc/habanalabs/common/habanalabs.h |  9 ++++++--
 drivers/misc/habanalabs/gaudi/gaudi.c       | 10 ++++++---
 drivers/misc/habanalabs/goya/goya.c         | 12 +++++++----
 4 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 59219c862ca0..15fcb5c31c4b 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1159,12 +1159,20 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 	atomic_set(&hdev->in_reset, 0);
 	hdev->needs_reset = false;
 
-	if (hard_reset)
+	dev_notice(hdev->dev, "Successfully finished resetting the device\n");
+
+	if (hard_reset) {
 		hdev->hard_reset_cnt++;
-	else
-		hdev->soft_reset_cnt++;
 
-	dev_warn(hdev->dev, "Successfully finished resetting the device\n");
+		/* After reset is done, we are ready to receive events from
+		 * the F/W. We can't do it before because we will ignore events
+		 * and if those events are fatal, we won't know about it and
+		 * the device will be operational although it shouldn't be
+		 */
+		hdev->asic_funcs->enable_events_from_fw(hdev);
+	} else {
+		hdev->soft_reset_cnt++;
+	}
 
 	return 0;
 
@@ -1415,6 +1423,13 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 
 	hdev->init_done = true;
 
+	/* After initialization is done, we are ready to receive events from
+	 * the F/W. We can't do it before because we will ignore events and if
+	 * those events are fatal, we won't know about it and the device will
+	 * be operational although it shouldn't be
+	 */
+	hdev->asic_funcs->enable_events_from_fw(hdev);
+
 	return 0;
 
 release_ctx:
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 98163317ec43..18ed3a6000b0 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -860,12 +860,16 @@ enum div_select_defs {
  *                           and place them in the relevant cs jobs
  * @collective_wait_create_jobs: allocate collective wait cs jobs
  * @scramble_addr: Routine to scramble the address prior of mapping it
- *                  in the MMU.
+ *                 in the MMU.
  * @descramble_addr: Routine to de-scramble the address prior of
- *                  showing it to users.
+ *                   showing it to users.
  * @ack_protection_bits_errors: ack and dump all security violations
  * @get_hw_block_id: retrieve a HW block id to be used by the user to mmap it.
  * @hw_block_mmap: mmap a HW block with a given id.
+ * @enable_events_from_fw: send interrupt to firmware to notify them the
+ *                         driver is ready to receive asynchronous events. This
+ *                         function should be called during the first init and
+ *                         after every hard-reset of the device
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
@@ -982,6 +986,7 @@ struct hl_asic_funcs {
 			u32 *block_id);
 	int (*hw_block_mmap)(struct hl_device *hdev, struct vm_area_struct *vma,
 			u32 block_id, u32 block_size);
+	void (*enable_events_from_fw)(struct hl_device *hdev);
 };
 
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index b929e602fa3d..6905857b363b 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1383,8 +1383,6 @@ static int gaudi_late_init(struct hl_device *hdev)
 		return rc;
 	}
 
-	WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR, GAUDI_EVENT_INTS_REGISTER);
-
 	rc = gaudi_fetch_psoc_frequency(hdev);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to fetch psoc frequency\n");
@@ -8500,6 +8498,11 @@ static int gaudi_block_mmap(struct hl_device *hdev,
 	return -EPERM;
 }
 
+static void gaudi_enable_events_from_fw(struct hl_device *hdev)
+{
+	WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR, GAUDI_EVENT_INTS_REGISTER);
+}
+
 static const struct hl_asic_funcs gaudi_funcs = {
 	.early_init = gaudi_early_init,
 	.early_fini = gaudi_early_fini,
@@ -8581,7 +8584,8 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.descramble_addr = hl_mmu_descramble_addr,
 	.ack_protection_bits_errors = gaudi_ack_protection_bits_errors,
 	.get_hw_block_id = gaudi_get_hw_block_id,
-	.hw_block_mmap = gaudi_block_mmap
+	.hw_block_mmap = gaudi_block_mmap,
+	.enable_events_from_fw = gaudi_enable_events_from_fw
 };
 
 /**
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index d26b405f0c17..af6a5760924c 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -798,9 +798,6 @@ int goya_late_init(struct hl_device *hdev)
 		return rc;
 	}
 
-	WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR,
-			GOYA_ASYNC_EVENT_ID_INTS_REGISTER);
-
 	return 0;
 }
 
@@ -5400,6 +5397,12 @@ static int goya_block_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
 	return -EPERM;
 }
 
+static void goya_enable_events_from_fw(struct hl_device *hdev)
+{
+	WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR,
+			GOYA_ASYNC_EVENT_ID_INTS_REGISTER);
+}
+
 static const struct hl_asic_funcs goya_funcs = {
 	.early_init = goya_early_init,
 	.early_fini = goya_early_fini,
@@ -5481,7 +5484,8 @@ static const struct hl_asic_funcs goya_funcs = {
 	.descramble_addr = hl_mmu_descramble_addr,
 	.ack_protection_bits_errors = goya_ack_protection_bits_errors,
 	.get_hw_block_id = goya_get_hw_block_id,
-	.hw_block_mmap = goya_block_mmap
+	.hw_block_mmap = goya_block_mmap,
+	.enable_events_from_fw = goya_enable_events_from_fw
 };
 
 /*
-- 
2.25.1


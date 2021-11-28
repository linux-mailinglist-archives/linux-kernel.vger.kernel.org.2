Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE50F460970
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 20:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357089AbhK1TkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 14:40:02 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35482 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbhK1Th7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 14:37:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74BB9B80D5C
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 19:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF4CC53FC1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 19:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638128080;
        bh=d5s80WfL+nbkCT9cmV9g4ZOIVUdSgPpO1gIz/kMCinY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dN9zEOKO+DPNUZ7/pz9WM/BKlaWsT8e6BARNiG8DCsKkarg8l9w8SJVL9xpMatwGb
         OuXFwgWuue+U9fdPOvpfwU5Hoe9guMaR9kuNAADHueDYhWZCH2t+EFo+pamiBCBPey
         n7c928/T0Y2XqXmGF0i7IQorASRF+mYJw0LzGfijrI3Wpg2rsouqz3bA9cIQaoUlY5
         9jupNWjuqA7PAjo43xVfIeQqdohlNj5C3FNUPWrXg1wL+yOYsD9i2MMrbne/u/KwDk
         haJzvQCDI32eHcZd2JZcEFgsJUsrgZyfHP8EXDE1oRNZWY4OsFxsaG17XaPV3gWNOq
         qM6fcZTdgbDPQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] habanalabs: rename late init after reset function
Date:   Sun, 28 Nov 2021 21:34:25 +0200
Message-Id: <20211128193435.266534-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211128193435.266534-1-ogabbay@kernel.org>
References: <20211128193435.266534-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASIC-specific soft_reset_late_init() is now called after either
soft-reset or reset-upon-device-release. Therefore, it needs a more
appropriate name.

No need to split it to two functions, as an ASIC either supports
soft-reset or reset-upon-device-release.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c     | 2 +-
 drivers/misc/habanalabs/common/habanalabs.h | 4 ++--
 drivers/misc/habanalabs/gaudi/gaudi.c       | 4 ++--
 drivers/misc/habanalabs/goya/goya.c         | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 2b208007c26f..822d9cec5aaf 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1209,7 +1209,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 
 		hl_set_max_power(hdev);
 	} else {
-		rc = hdev->asic_funcs->soft_reset_late_init(hdev);
+		rc = hdev->asic_funcs->non_hard_reset_late_init(hdev);
 		if (rc) {
 			if (reset_upon_device_release)
 				dev_err(hdev->dev,
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 1a7f8d37f684..a465b4a5f31d 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1153,7 +1153,7 @@ struct fw_load_mgr {
  * @disable_clock_gating: disable clock gating completely
  * @debug_coresight: perform certain actions on Coresight for debugging.
  * @is_device_idle: return true if device is idle, false otherwise.
- * @soft_reset_late_init: perform certain actions needed after soft reset.
+ * @non_hard_reset_late_init: perform certain actions needed after a reset which is not hard-reset
  * @hw_queues_lock: acquire H/W queues lock.
  * @hw_queues_unlock: release H/W queues lock.
  * @get_pci_id: retrieve PCI ID.
@@ -1289,7 +1289,7 @@ struct hl_asic_funcs {
 	int (*debug_coresight)(struct hl_device *hdev, void *data);
 	bool (*is_device_idle)(struct hl_device *hdev, u64 *mask_arr,
 					u8 mask_len, struct seq_file *s);
-	int (*soft_reset_late_init)(struct hl_device *hdev);
+	int (*non_hard_reset_late_init)(struct hl_device *hdev);
 	void (*hw_queues_lock)(struct hl_device *hdev);
 	void (*hw_queues_unlock)(struct hl_device *hdev);
 	u32 (*get_pci_id)(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index f29afcca74fc..464d205a26ed 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7819,7 +7819,7 @@ static void gaudi_print_fw_alive_info(struct hl_device *hdev,
 		fw_alive->thread_id, fw_alive->uptime_seconds);
 }
 
-static int gaudi_soft_reset_late_init(struct hl_device *hdev)
+static int gaudi_non_hard_reset_late_init(struct hl_device *hdev)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
 
@@ -9591,7 +9591,7 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.disable_clock_gating = gaudi_disable_clock_gating,
 	.debug_coresight = gaudi_debug_coresight,
 	.is_device_idle = gaudi_is_device_idle,
-	.soft_reset_late_init = gaudi_soft_reset_late_init,
+	.non_hard_reset_late_init = gaudi_non_hard_reset_late_init,
 	.hw_queues_lock = gaudi_hw_queues_lock,
 	.hw_queues_unlock = gaudi_hw_queues_unlock,
 	.get_pci_id = gaudi_get_pci_id,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index bbee6739ce87..e54d60e75854 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4813,7 +4813,7 @@ static int goya_unmask_irq_arr(struct hl_device *hdev, u32 *irq_arr,
 	return rc;
 }
 
-static int goya_soft_reset_late_init(struct hl_device *hdev)
+static int goya_non_hard_reset_late_init(struct hl_device *hdev)
 {
 	/*
 	 * Unmask all IRQs since some could have been received
@@ -5738,7 +5738,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.disable_clock_gating = goya_disable_clock_gating,
 	.debug_coresight = goya_debug_coresight,
 	.is_device_idle = goya_is_device_idle,
-	.soft_reset_late_init = goya_soft_reset_late_init,
+	.non_hard_reset_late_init = goya_non_hard_reset_late_init,
 	.hw_queues_lock = goya_hw_queues_lock,
 	.hw_queues_unlock = goya_hw_queues_unlock,
 	.get_pci_id = goya_get_pci_id,
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB473AE406
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 09:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhFUH00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 03:26:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhFUH0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 03:26:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50207610CA;
        Mon, 21 Jun 2021 07:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624260252;
        bh=a5uUhUqryf91Iv34iUG1N5+TaItKkckQgSC/wyODgeY=;
        h=From:To:Cc:Subject:Date:From;
        b=fXG/sr2YN37VsBGCmMFqdWBWPGWdWH7DJ1PKMvnsQqPZl2XWgbuNQWgmpPrtRVhck
         /0We9hFVcSOfbZzaJP1/3cf/mUgfegPH+blDaP635+jqb5qTup9LGqZot2csqiOth+
         8mw0k8uxzMQqVsXEBnPDk7YCkZ6ss4sy99ng3QF6AsRSHEVOJdunikbDRqjPoeWJfB
         CljNrJQXGD9/gLMmBFhEbB8qqEVI427ANiYDEqIlxmGr2SpAGBuLZbMgkfhXOtNsfe
         xGmK+I6Vm8qmI7y5IUN6yvl6eAjSkFLH28fVIsnNLJ3obwK8pp0GbGOxlkFYcBlzXQ
         XAUmxy+SnF8nQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/5] habanalabs: allow reset upon device release
Date:   Mon, 21 Jun 2021 10:24:02 +0300
Message-Id: <20210621072406.5421-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

We introduce a new type of reset which is reset upon device release.
This reset is very similar to soft reset except the fact it is
performed only upon device release and not upon user sysfs request
nor TDR.

The purpose of this reset is to make sure the device is returned to
IDLE state after the current user has finished working with the device.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c     | 25 +++++++++++++++++----
 drivers/misc/habanalabs/common/habanalabs.h |  7 ++++++
 drivers/misc/habanalabs/common/sysfs.c      |  2 +-
 drivers/misc/habanalabs/goya/goya.c         |  1 +
 4 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 37ce38d9a1a7..ff4cbde289c0 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -86,7 +86,7 @@ static void hpriv_release(struct kref *ref)
 
 	if ((hdev->reset_if_device_not_idle && !device_is_idle)
 			|| hdev->reset_upon_device_release)
-		hl_device_reset(hdev, 0);
+		hl_device_reset(hdev, HL_RESET_DEVICE_RELEASE);
 }
 
 void hl_hpriv_get(struct hl_fpriv *hpriv)
@@ -885,7 +885,7 @@ static void device_disable_open_processes(struct hl_device *hdev)
 int hl_device_reset(struct hl_device *hdev, u32 flags)
 {
 	u64 idle_mask[HL_BUSY_ENGINES_MASK_EXT_SIZE] = {0};
-	bool hard_reset, from_hard_reset_thread;
+	bool hard_reset, from_hard_reset_thread, hard_instead_soft = false;
 	int i, rc;
 
 	if (!hdev->init_done) {
@@ -897,11 +897,28 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	hard_reset = (flags & HL_RESET_HARD) != 0;
 	from_hard_reset_thread = (flags & HL_RESET_FROM_RESET_THREAD) != 0;
 
-	if ((!hard_reset) && (!hdev->supports_soft_reset)) {
-		dev_dbg(hdev->dev, "Doing hard-reset instead of soft-reset\n");
+	if (!hard_reset && !hdev->supports_soft_reset) {
+		hard_instead_soft = true;
 		hard_reset = true;
 	}
 
+	if (hdev->reset_upon_device_release &&
+			(flags & HL_RESET_DEVICE_RELEASE)) {
+		dev_dbg(hdev->dev,
+			"Perform %s-reset upon device release\n",
+			hard_reset ? "hard" : "soft");
+		goto do_reset;
+	}
+
+	if (!hard_reset && !hdev->allow_external_soft_reset) {
+		hard_instead_soft = true;
+		hard_reset = true;
+	}
+
+	if (hard_instead_soft)
+		dev_dbg(hdev->dev, "Doing hard-reset instead of soft-reset\n");
+
+do_reset:
 	/* Re-entry of reset thread */
 	if (from_hard_reset_thread && hdev->process_kill_trial_cnt)
 		goto kill_processes;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 09b89fdeba0b..fad112a01009 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -119,11 +119,15 @@ enum hl_mmu_page_table_location {
  *
  * - HL_RESET_TDR
  *       Set if reset is due to TDR
+ *
+ * - HL_RESET_DEVICE_RELEASE
+ *       Set if reset is due to device release
  */
 #define HL_RESET_HARD			(1 << 0)
 #define HL_RESET_FROM_RESET_THREAD	(1 << 1)
 #define HL_RESET_HEARTBEAT		(1 << 2)
 #define HL_RESET_TDR			(1 << 3)
+#define HL_RESET_DEVICE_RELEASE		(1 << 4)
 
 #define HL_MAX_SOBS_PER_MONITOR	8
 
@@ -2181,6 +2185,8 @@ struct hl_mmu_funcs {
  * @collective_mon_idx: helper index for collective initialization
  * @supports_coresight: is CoreSight supported.
  * @supports_soft_reset: is soft reset supported.
+ * @allow_external_soft_reset: true if soft reset initiated by user or TDR is
+ *                             allowed.
  * @supports_cb_mapping: is mapping a CB to the device's MMU supported.
  * @needs_reset: true if reset_on_lockup is false and device should be reset
  *               due to lockup.
@@ -2301,6 +2307,7 @@ struct hl_device {
 	u8				collective_mon_idx;
 	u8				supports_coresight;
 	u8				supports_soft_reset;
+	u8				allow_external_soft_reset;
 	u8				supports_cb_mapping;
 	u8				needs_reset;
 	u8				process_kill_trial_cnt;
diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
index c9f649b31e3a..db72df282ef8 100644
--- a/drivers/misc/habanalabs/common/sysfs.c
+++ b/drivers/misc/habanalabs/common/sysfs.c
@@ -208,7 +208,7 @@ static ssize_t soft_reset_store(struct device *dev,
 		goto out;
 	}
 
-	if (!hdev->supports_soft_reset) {
+	if (!hdev->allow_external_soft_reset) {
 		dev_err(hdev->dev, "Device does not support soft-reset\n");
 		goto out;
 	}
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 5a837c0b4d76..06f5f1439e69 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -954,6 +954,7 @@ static int goya_sw_init(struct hl_device *hdev)
 	spin_lock_init(&goya->hw_queues_lock);
 	hdev->supports_coresight = true;
 	hdev->supports_soft_reset = true;
+	hdev->allow_external_soft_reset = true;
 
 	goya_set_pci_memory_regions(hdev);
 
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141DE420905
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 12:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhJDKKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 06:10:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231663AbhJDKK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 06:10:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 780996124F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 10:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633342118;
        bh=52tX7kuJdSFoBD6Eckyy8GS1qM4yP+okttTgAnjXO4Q=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=EcS8lLACY/PKP/q3j14nIABy0rDt8YIAaAcaqVDPO1Ky26tAPyUaWRoN5iJmdq0PQ
         aVyIDprUlFbZBuNYhj0CUklHcy2p3nLik+liowajNA19I0gnI35Q83Cv9EzCB5GXSb
         maKSV4j1/Xj6KcstQCTLLFRU46nbon3+Sb3YQKsjil+bL9AUgQyb/K/LfxZ7Q0uGY8
         C9KgyE7EVcBX0pHUMinPTGnzsDUyTPGDrzNFABzU3/xJ7D/1YlCBOjTijq904p2FHe
         rhawi9R5M1JCfLf5+O6zuRzgPWoT/DXzobyfrwCx+o23WOmQMpNDuuDpwj1LLgv7pu
         x/PcbUKwW0Lww==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] habanalabs: define soft-reset as inference op
Date:   Mon,  4 Oct 2021 13:08:27 +0300
Message-Id: <20211004100830.27573-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211004100830.27573-1-ogabbay@kernel.org>
References: <20211004100830.27573-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Soft-reset is the procedure where we reset only the compute/DMA engines
of the device, without requiring the current user-space process to
release the device.

This type of reset can happen if TDR event occurred (a workload got
stuck) or by a root request through sysfs.

This is only relevant for inference ASICs, as there is no real-world
use-case to do that in training, because training runs on multiple
devices.

In addition, we also do (in certain ASICs) a reset upon device release.
That reset uses the same code as the soft-reset.

Therefore, to better differentiate between the two resets, it is better
to rename the soft-reset support as "inference soft-reset", to make
the code more self-explanatory.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c     |  2 +-
 drivers/misc/habanalabs/common/habanalabs.h | 10 +++++++---
 drivers/misc/habanalabs/common/sysfs.c      |  6 +++---
 drivers/misc/habanalabs/goya/goya.c         |  2 +-
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 97c7c86580e6..8f96f2bb14ec 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -954,7 +954,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		goto do_reset;
 	}
 
-	if (!hard_reset && !hdev->allow_external_soft_reset) {
+	if (!hard_reset && !hdev->allow_inference_soft_reset) {
 		hard_instead_soft = true;
 		hard_reset = true;
 	}
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index f8e23ca18a57..99de80915eed 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2440,8 +2440,12 @@ struct multi_cs_data {
  * @collective_mon_idx: helper index for collective initialization
  * @supports_coresight: is CoreSight supported.
  * @supports_soft_reset: is soft reset supported.
- * @allow_external_soft_reset: true if soft reset initiated by user or TDR is
- *                             allowed.
+ * @allow_inference_soft_reset: true if the ASIC supports soft reset that is
+ *                              initiated by user or TDR. This is only true
+ *                              in inference ASICs, as there is no real-world
+ *                              use-case of doing soft-reset in training (due
+ *                              to the fact that training runs on multiple
+ *                              devices)
  * @supports_cb_mapping: is mapping a CB to the device's MMU supported.
  * @needs_reset: true if reset_on_lockup is false and device should be reset
  *               due to lockup.
@@ -2572,7 +2576,7 @@ struct hl_device {
 	u8				collective_mon_idx;
 	u8				supports_coresight;
 	u8				supports_soft_reset;
-	u8				allow_external_soft_reset;
+	u8				allow_inference_soft_reset;
 	u8				supports_cb_mapping;
 	u8				needs_reset;
 	u8				process_kill_trial_cnt;
diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
index 34f9f2779962..42c1769ad25d 100644
--- a/drivers/misc/habanalabs/common/sysfs.c
+++ b/drivers/misc/habanalabs/common/sysfs.c
@@ -206,12 +206,12 @@ static ssize_t soft_reset_store(struct device *dev,
 		goto out;
 	}
 
-	if (!hdev->allow_external_soft_reset) {
-		dev_err(hdev->dev, "Device does not support soft-reset\n");
+	if (!hdev->allow_inference_soft_reset) {
+		dev_err(hdev->dev, "Device does not support inference soft-reset\n");
 		goto out;
 	}
 
-	dev_warn(hdev->dev, "Soft-Reset requested through sysfs\n");
+	dev_warn(hdev->dev, "Inference Soft-Reset requested through sysfs\n");
 
 	hl_device_reset(hdev, 0);
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 031c1849da14..ef67e2586ede 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -959,7 +959,7 @@ static int goya_sw_init(struct hl_device *hdev)
 	spin_lock_init(&goya->hw_queues_lock);
 	hdev->supports_coresight = true;
 	hdev->supports_soft_reset = true;
-	hdev->allow_external_soft_reset = true;
+	hdev->allow_inference_soft_reset = true;
 	hdev->supports_wait_for_multi_cs = false;
 
 	hdev->asic_funcs->set_pci_memory_regions(hdev);
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F278546096F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 20:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbhK1Tj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 14:39:59 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35474 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbhK1Th6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 14:37:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C429B80D5A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 19:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073C9C004E1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 19:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638128079;
        bh=t/3nq4TUAll4/PqECbyo9k2MU3hWRo0zL+q+jTfTB4Y=;
        h=From:To:Subject:Date:From;
        b=JNqSO4lXMs6IaFLaV/DMDTvbVLdfItjqfGFi+Y81EzFkPJvj0FZltHQbTziYY9YTt
         SEYpBsPhjBWfM5mtsBa+G2A83jMsa5/5rVs/Pg+AlVwQ20L+N2Ipk6Y2bOk1w+aXMB
         0DXcjBXCPEhk0m0efPtmXYmLwfvtissj+q4A+SuBoePJd75uzfC9mhDcxcz874Jz9/
         dtX995N6fugak2BmSuX73I07H80ZNEbvVtqKEY84lPXTfMmSBiTmyAWAteTUyOLoTq
         lUrQ4gFG1Bt+Nm4LqTiicQoLDIaHvbv5ABNmOvvBQGZ4y1xTvz0r/N6Fo58H+GX+IS
         j2l9TS6GDtjTQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] habanalabs: fix soft reset accounting
Date:   Sun, 28 Nov 2021 21:34:24 +0200
Message-Id: <20211128193435.266534-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reset upon device release is not a soft-reset from user/system point
of view. As such, we shouldn't count that reset in the statistics we
gather and expose to the monitoring applications.

We also shouldn't print soft-reset when doing the reset upon device
release.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 50 ++++++++++++-------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 484e0446381e..2b208007c26f 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -962,13 +962,13 @@ static void handle_reset_trigger(struct hl_device *hdev, u32 flags)
  */
 int hl_device_reset(struct hl_device *hdev, u32 flags)
 {
-	bool hard_reset, from_hard_reset_thread, fw_reset, hard_instead_soft = false;
+	bool hard_reset, from_hard_reset_thread, fw_reset, hard_instead_soft = false,
+								reset_upon_device_release = false;
 	u64 idle_mask[HL_BUSY_ENGINES_MASK_EXT_SIZE] = {0};
 	int i, rc;
 
 	if (!hdev->init_done) {
-		dev_err(hdev->dev,
-			"Can't reset before initialization is done\n");
+		dev_err(hdev->dev, "Can't reset before initialization is done\n");
 		return 0;
 	}
 
@@ -988,6 +988,8 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 			return -EINVAL;
 		}
 
+		reset_upon_device_release = true;
+
 		goto do_reset;
 	}
 
@@ -1024,12 +1026,10 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 
 		if (hard_reset)
 			dev_info(hdev->dev, "Going to reset device\n");
-		else if (flags & HL_DRV_RESET_DEV_RELEASE)
-			dev_info(hdev->dev,
-				"Going to reset device after it was released by user\n");
+		else if (reset_upon_device_release)
+			dev_info(hdev->dev, "Going to reset device after release by user\n");
 		else
-			dev_info(hdev->dev,
-				"Going to reset compute engines of inference device\n");
+			dev_info(hdev->dev, "Going to reset engines of inference device\n");
 	}
 
 again:
@@ -1174,16 +1174,14 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 
 	rc = hdev->asic_funcs->hw_init(hdev);
 	if (rc) {
-		dev_err(hdev->dev,
-			"failed to initialize the H/W after reset\n");
+		dev_err(hdev->dev, "failed to initialize the H/W after reset\n");
 		goto out_err;
 	}
 
 	/* If device is not idle fail the reset process */
 	if (!hdev->asic_funcs->is_device_idle(hdev, idle_mask,
 			HL_BUSY_ENGINES_MASK_EXT_SIZE, NULL)) {
-		dev_err(hdev->dev,
-			"device is not idle (mask 0x%llx_%llx) after reset\n",
+		dev_err(hdev->dev, "device is not idle (mask 0x%llx_%llx) after reset\n",
 			idle_mask[1], idle_mask[0]);
 		rc = -EIO;
 		goto out_err;
@@ -1192,23 +1190,20 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	/* Check that the communication with the device is working */
 	rc = hdev->asic_funcs->test_queues(hdev);
 	if (rc) {
-		dev_err(hdev->dev,
-			"Failed to detect if device is alive after reset\n");
+		dev_err(hdev->dev, "Failed to detect if device is alive after reset\n");
 		goto out_err;
 	}
 
 	if (hard_reset) {
 		rc = device_late_init(hdev);
 		if (rc) {
-			dev_err(hdev->dev,
-				"Failed late init after hard reset\n");
+			dev_err(hdev->dev, "Failed late init after hard reset\n");
 			goto out_err;
 		}
 
 		rc = hl_vm_init(hdev);
 		if (rc) {
-			dev_err(hdev->dev,
-				"Failed to init memory module after hard reset\n");
+			dev_err(hdev->dev, "Failed to init memory module after hard reset\n");
 			goto out_err;
 		}
 
@@ -1216,8 +1211,11 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	} else {
 		rc = hdev->asic_funcs->soft_reset_late_init(hdev);
 		if (rc) {
-			dev_err(hdev->dev,
-				"Failed late init after soft reset\n");
+			if (reset_upon_device_release)
+				dev_err(hdev->dev,
+					"Failed late init in reset after device release\n");
+			else
+				dev_err(hdev->dev, "Failed late init after soft reset\n");
 			goto out_err;
 		}
 	}
@@ -1236,7 +1234,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		 * the device will be operational although it shouldn't be
 		 */
 		hdev->asic_funcs->enable_events_from_fw(hdev);
-	} else {
+	} else if (!reset_upon_device_release) {
 		hdev->soft_reset_cnt++;
 	}
 
@@ -1246,12 +1244,14 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	hdev->disabled = true;
 
 	if (hard_reset) {
-		dev_err(hdev->dev,
-			"Failed to reset! Device is NOT usable\n");
+		dev_err(hdev->dev, "Failed to reset! Device is NOT usable\n");
 		hdev->hard_reset_cnt++;
+	} else if (reset_upon_device_release) {
+		dev_err(hdev->dev, "Failed to reset device after user release\n");
+		hard_reset = true;
+		goto again;
 	} else {
-		dev_err(hdev->dev,
-			"Failed to do soft-reset, trying hard reset\n");
+		dev_err(hdev->dev, "Failed to do soft-reset\n");
 		hdev->soft_reset_cnt++;
 		hard_reset = true;
 		goto again;
-- 
2.25.1


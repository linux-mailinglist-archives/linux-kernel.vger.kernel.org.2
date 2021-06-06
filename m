Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9101939CE17
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 10:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhFFIZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 04:25:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230192AbhFFIZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 04:25:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CA7D61426;
        Sun,  6 Jun 2021 08:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622967810;
        bh=gwTb6UFeQkViQES/pfPDchg41zL/fWr6/vm3ieXGo+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JpEmgvWL1raSS1KdFm1pq/K6XhHSXJZg5SC98bt3rEfhCrY89h7LL/Wh+gLVc1lon
         geUipCCY5/STWLI069VhQsNonIqJweV9XS16XBefUnTVCq3sTESewjHKdk58C3vxec
         Ul1jI6naJ1g3manP5fd21A9zUCvu9dkeJcXnpb97F/PxUIyn3YZGKgMq/xJ8Txm18e
         PYr/9ph50kxSL2WLAOwOv2QuXmR2FROtRRGK/nZmo54seQJbb2HqvWDZ5n6utj0Crd
         zJnLdMYfTCqun/RydYQsHIqfA7ie/5lTpjycoSNXrmTZr7AJVagMcZpSySeWhz43H/
         WQwnyFHLyVoVA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 4/6] habanalabs: reset device upon FD close if not idle
Date:   Sun,  6 Jun 2021 11:23:18 +0300
Message-Id: <20210606082320.4319-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210606082320.4319-1-ogabbay@kernel.org>
References: <20210606082320.4319-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

If device is not idle after user closes the FD we must reset device
as next user that will try to open FD will encounter a non-functional
device.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/context.c      |  9 ---------
 drivers/misc/habanalabs/common/device.c       | 20 ++++++++++++++++---
 drivers/misc/habanalabs/common/habanalabs.h   |  1 +
 .../misc/habanalabs/common/habanalabs_drv.c   |  1 +
 4 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index 62d705889ca8..19b6b045219e 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -12,7 +12,6 @@
 static void hl_ctx_fini(struct hl_ctx *ctx)
 {
 	struct hl_device *hdev = ctx->hdev;
-	u64 idle_mask[HL_BUSY_ENGINES_MASK_EXT_SIZE] = {0};
 	int i;
 
 	/* Release all allocated pending cb's, those cb's were never
@@ -57,14 +56,6 @@ static void hl_ctx_fini(struct hl_ctx *ctx)
 
 		/* Scrub both SRAM and DRAM */
 		hdev->asic_funcs->scrub_device_mem(hdev, 0, 0);
-
-		if ((!hdev->pldm) && (hdev->pdev) &&
-				(!hdev->asic_funcs->is_device_idle(hdev,
-					idle_mask,
-					HL_BUSY_ENGINES_MASK_EXT_SIZE, NULL)))
-			dev_notice(hdev->dev,
-					"device not idle after user context is closed (0x%llx, 0x%llx)\n",
-						idle_mask[0], idle_mask[1]);
 	} else {
 		dev_dbg(hdev->dev, "closing kernel context\n");
 		hdev->asic_funcs->ctx_fini(ctx);
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index bc58a91bf50a..0056282cec94 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -51,6 +51,8 @@ bool hl_device_operational(struct hl_device *hdev,
 
 static void hpriv_release(struct kref *ref)
 {
+	u64 idle_mask[HL_BUSY_ENGINES_MASK_EXT_SIZE] = {0};
+	bool device_is_idle = true;
 	struct hl_fpriv *hpriv;
 	struct hl_device *hdev;
 
@@ -71,7 +73,19 @@ static void hpriv_release(struct kref *ref)
 
 	kfree(hpriv);
 
-	if (hdev->reset_upon_device_release)
+	if ((!hdev->pldm) && (hdev->pdev) &&
+			(!hdev->asic_funcs->is_device_idle(hdev,
+				idle_mask,
+				HL_BUSY_ENGINES_MASK_EXT_SIZE, NULL))) {
+		dev_err(hdev->dev,
+			"device not idle after user context is closed (0x%llx_%llx)\n",
+			idle_mask[1], idle_mask[0]);
+
+		device_is_idle = false;
+	}
+
+	if ((hdev->reset_if_device_not_idle && !device_is_idle)
+			|| hdev->reset_upon_device_release)
 		hl_device_reset(hdev, 0);
 }
 
@@ -1108,8 +1122,8 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	if (!hdev->asic_funcs->is_device_idle(hdev, idle_mask,
 			HL_BUSY_ENGINES_MASK_EXT_SIZE, NULL)) {
 		dev_err(hdev->dev,
-			"device is not idle (mask %#llx %#llx) after reset\n",
-			idle_mask[0], idle_mask[1]);
+			"device is not idle (mask 0x%llx_%llx) after reset\n",
+			idle_mask[1], idle_mask[0]);
 		rc = -EIO;
 		goto out_err;
 	}
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 56d2f41f8893..bcb5bfdd7f20 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2311,6 +2311,7 @@ struct hl_device {
 	u8				rl_enable;
 	u8				reset_on_preboot_fail;
 	u8				reset_upon_device_release;
+	u8				reset_if_device_not_idle;
 };
 
 
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 137e7dc63d3b..b55dd1c55166 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -264,6 +264,7 @@ static void set_driver_behavior_per_device(struct hl_device *hdev)
 	hdev->bmc_enable = 1;
 	hdev->hard_reset_on_fw_events = 1;
 	hdev->reset_on_preboot_fail = 1;
+	hdev->reset_if_device_not_idle = 1;
 
 	hdev->reset_pcilink = 0;
 	hdev->axi_drain = 0;
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373E43221F2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 23:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhBVWJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 17:09:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:42800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231241AbhBVWIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 17:08:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DA2E64E2E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 22:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614031693;
        bh=DnvoDpDJyevVJq+kXXwzsSWWg03bcy6H1Qbiii+KNSk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZvZFxq7Hjphs9vMEv+If4p5Sx+6VOkiwi5TXdi0sB+mUHCwJ6tQvC7m9pNsHk9jKf
         HELNESopGBZiZJ2nIoI/5BVKbsC84toHsKEPK+MIfbT/VsQHj4GJ7rXxFlck6fRyF+
         R3QWUkYmE21oRPwifltk+eyALsy5ksg8zQyepIcD+pnTIRvtmb/NM5Wd4wfyad59f6
         hTqk3QgxbGRJbRBNw0UfiYvwBSqmdBYhaGiOSoJwSp+kkO4ErdbIY5DlGQ70yhXnc4
         PSvxq3qwUkxLoN+72nR7mEdEAxMObydQ/cCKn28teto7egT4Fi+XMijfO5ZgaMnYdJ
         3BD7Hu0xJUOUQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] habanalabs: fail reset if device is not idle
Date:   Tue, 23 Feb 2021 00:08:04 +0200
Message-Id: <20210222220806.9311-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210222220806.9311-1-ogabbay@kernel.org>
References: <20210222220806.9311-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After any reset (soft or hard) the device (the engines/QMANs) should
be idle. If they are not idle, fail the reset. If it is soft-reset,
the driver will try to do hard-reset automatically. If it is hard-reset,
the driver will make the device non-operational.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 8cc3264ae378..48d301a03d62 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -71,21 +71,8 @@ static void hpriv_release(struct kref *ref)
 
 	kfree(hpriv);
 
-	if (hdev->reset_upon_device_release) {
-		u64 idle_mask[HL_BUSY_ENGINES_MASK_EXT_SIZE] = {0};
-
-		/* We try soft reset first */
+	if (hdev->reset_upon_device_release)
 		hl_device_reset(hdev, false, false);
-
-		/* If device is not idle perform hard reset */
-		if (!hdev->asic_funcs->is_device_idle(hdev, idle_mask,
-				HL_BUSY_ENGINES_MASK_EXT_SIZE, NULL)) {
-			dev_info(hdev->dev,
-				"device is not idle (mask %#llx %#llx) after soft reset, performing hard reset",
-				idle_mask[0], idle_mask[1]);
-			hl_device_reset(hdev, true, false);
-		}
-	}
 }
 
 void hl_hpriv_get(struct hl_fpriv *hpriv)
@@ -921,6 +908,7 @@ static int device_kill_open_processes(struct hl_device *hdev, u32 timeout)
 int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 			bool from_hard_reset_thread)
 {
+	u64 idle_mask[HL_BUSY_ENGINES_MASK_EXT_SIZE] = {0};
 	int i, rc;
 
 	if (!hdev->init_done) {
@@ -1140,6 +1128,15 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 		goto out_err;
 	}
 
+	/* If device is not idle fail the reset process */
+	if (!hdev->asic_funcs->is_device_idle(hdev, idle_mask,
+			HL_BUSY_ENGINES_MASK_EXT_SIZE, NULL)) {
+		dev_err(hdev->dev,
+			"device is not idle (mask %#llx %#llx) after reset\n",
+			idle_mask[0], idle_mask[1]);
+		goto out_err;
+	}
+
 	/* Check that the communication with the device is working */
 	rc = hdev->asic_funcs->test_queues(hdev);
 	if (rc) {
-- 
2.25.1


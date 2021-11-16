Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C838F453419
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 15:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237399AbhKPO1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 09:27:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:41204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237412AbhKPO1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 09:27:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2716161502
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 14:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637072679;
        bh=biTocHL1hGp24ay2csZW1S7RPhxxw+8vfjvhmfQo7OE=;
        h=From:To:Subject:Date:From;
        b=OLfNsqEvJfbZCv2wUP7YTo7Zqxjpyinu+NagAIfN6RvdoPRcjvKtf51sFPdXzvBjP
         mnS7L/N0k4+Ru8N6N20xj7n5QKC1CeCvBcdTCiWtcpx9e5OxZHqI+ZEJ9Ld5oLZZqt
         ms1H8bI2VMyf1xxfnJqJgjea0Lq0Rv7u1EAU5N2QyUiRodG3qfGHNxIXzVJKVHs07t
         r2BA5vsp3e5+bXcffKWDOwsACLeqp6NK0f4HUukzmlizhzkGM232tRMqvpGrn581dH
         3e0mDKu7LEKUWTRkBE5U/HKRzGI5tN9+76p0EUohdI1zj4s97vp3j437/Ma3lWrMcd
         ZryY24R1S5+dQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] habanalabs: abort reset on invalid request
Date:   Tue, 16 Nov 2021 16:24:35 +0200
Message-Id: <20211116142436.1153282-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hard-reset is mutually exclusive with reset-on-device-release.
Therefore, if such a request arrives to the reset function, abort
the reset and return an error to the callee.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index ca74d7815a67..a3d5617da64c 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /*
- * Copyright 2016-2019 HabanaLabs, Ltd.
+ * Copyright 2016-2021 HabanaLabs, Ltd.
  * All Rights Reserved.
  */
 
@@ -1020,8 +1020,8 @@ static void handle_reset_trigger(struct hl_device *hdev, u32 flags)
  */
 int hl_device_reset(struct hl_device *hdev, u32 flags)
 {
-	u64 idle_mask[HL_BUSY_ENGINES_MASK_EXT_SIZE] = {0};
 	bool hard_reset, from_hard_reset_thread, fw_reset, hard_instead_soft = false;
+	u64 idle_mask[HL_BUSY_ENGINES_MASK_EXT_SIZE] = {0};
 	int i, rc;
 
 	if (!hdev->init_done) {
@@ -1039,11 +1039,13 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		hard_reset = true;
 	}
 
-	if (hdev->reset_upon_device_release &&
-			(flags & HL_DRV_RESET_DEV_RELEASE)) {
-		dev_dbg(hdev->dev,
-			"Perform %s-reset upon device release\n",
-			hard_reset ? "hard" : "soft");
+	if (hdev->reset_upon_device_release && (flags & HL_DRV_RESET_DEV_RELEASE)) {
+		if (hard_reset) {
+			dev_crit(hdev->dev,
+				"Aborting reset because hard-reset is mutually exclusive with reset-on-device-release\n");
+			return -EINVAL;
+		}
+
 		goto do_reset;
 	}
 
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECDE43829C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 11:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhJWJXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 05:23:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230104AbhJWJXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 05:23:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F29861057
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 09:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634980847;
        bh=yryamFAhOLhTgMnpeOkGelN+xyO4TP3QX47fzaFStV0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JCIaYk9Crgde/lo8ffh+LipkSZ6zJr/74PGJabL8yee9LQlEWrMS/FbzIfDkUY4Ge
         IjAYxLcjSYR+QhRNZEr6cR1kuy65zECXpfBHVEqrig6yALqZXodhRch0TY2deaH2ng
         av5PZeqUSp5xjvmokhBxQGQik7ue9WASulYzpv48ZCqDrCGQurMRGmxIz5vtUhN4Ts
         0eIlFG4k8HsKKZnxhvO5Yn23/NHb0MrF8e8XNqA62aNlJYdt+xm143fy2d4kEIVxpd
         G5BHB38qP5F0mVoowSG8smVBTlPr3CtG7wHvj36cLxS5bQtLT1AZ8VTlmEdAW5oeL8
         yj6+zs8bbWWsQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] habanalabs/gaudi: recover from CPU WD event
Date:   Sat, 23 Oct 2021 12:20:41 +0300
Message-Id: <20211023092041.2364497-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211023092041.2364497-1-ogabbay@kernel.org>
References: <20211023092041.2364497-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are rare cases where the device CPU's watchdog has expired and as
a result, the watchdog reset has happened and the CPU will now move to
running its preboot f/w.

When that happens, the driver will only know that a heartbeat failure
occurred. As a result, the driver will send a message to the CPU's main
f/w asking it to reset the device, but because the CPU is now running
preboot, it won't respond and the re-initialization process will later
fail when trying to load the f/w.

The solution is to send the request to the preboot as well, only if the
reset was caused because of HB failure.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 825737dfe381..d2b7ecb45497 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /*
- * Copyright 2016-2020 HabanaLabs, Ltd.
+ * Copyright 2016-2021 HabanaLabs, Ltd.
  * All Rights Reserved.
  */
 
@@ -4296,6 +4296,24 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset, bool fw_reset
 
 		WREG32(irq_handler_offset,
 			gaudi_irq_map_table[GAUDI_EVENT_HALT_MACHINE].cpu_id);
+
+		/* This is a hail-mary attempt to revive the card in the small chance that the
+		 * f/w has experienced a watchdog event, which caused it to return back to preboot.
+		 * In that case, triggering reset through GIC won't help. We need to trigger the
+		 * reset as if Linux wasn't loaded.
+		 *
+		 * We do it only if the reset cause was HB, because that would be the indication
+		 * of such an event.
+		 *
+		 * In case watchdog hasn't expired but we still got HB, then this won't do any
+		 * damage.
+		 */
+		if (hdev->curr_reset_cause == HL_RESET_CAUSE_HEARTBEAT) {
+			if (hdev->asic_prop.hard_reset_done_by_fw)
+				hl_fw_ask_hard_reset_without_linux(hdev);
+			else
+				hl_fw_ask_halt_machine_without_linux(hdev);
+		}
 	} else {
 		if (hdev->asic_prop.hard_reset_done_by_fw)
 			hl_fw_ask_hard_reset_without_linux(hdev);
-- 
2.25.1


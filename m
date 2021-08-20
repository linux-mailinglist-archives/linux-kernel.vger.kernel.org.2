Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD63A3F2E91
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 17:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240992AbhHTPIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 11:08:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240956AbhHTPIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 11:08:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D18D60FDA
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 15:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629472048;
        bh=tWufcxFkKtxB7AT4OiAkVQ5Q/bP625jdgo4IPuIhtJA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OBjnP7LuhmV64IZcPMGG04g7VUPDl1VbuV7uz+aedQv3j8x7qIXPSOtRxAz1i1Zd5
         0lCWMozyWnIF2/FoygycH6z0gZ0GmMFpnfCOGPIanJoYARu6OVsUtA/QSY1TvH05PB
         GgTvNFLz45n6cCWHwyd62F9MGjIjVt+iZw1AojZx/OAxdu6VpRNCO08WevD3tvIfBM
         hUWFiXRLzu+KfctrktC2coKh00652kvPqRHsgBe7qSeNTLv5fD6nhRXKQ+a2PjZKOO
         h4l8xDh0NktYy1DXwNAyfyJq9QP6CWWvZzAVPP5c3kqp7xws0HlBZP+GONRexX9ZiX
         X7sFalt4+ZN5A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] habanalabs: disable IRQ in user interrupts spinlock
Date:   Fri, 20 Aug 2021 18:07:17 +0300
Message-Id: <20210820150719.67934-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820150719.67934-1-ogabbay@kernel.org>
References: <20210820150719.67934-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because this spinlock is taken in an interrupt handler, we must use
the spin_lock_irqsave/irqrestore version to disable the interrupts
on the local CPU. Otherwise, we can have a potential deadlock (if
the interrupt handler is scheduled to run on the same cpu that the
code who took the lock was running on).

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 3a67265312ee..8a2f75de6df8 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -923,13 +923,14 @@ static void
 wake_pending_user_interrupt_threads(struct hl_user_interrupt *interrupt)
 {
 	struct hl_user_pending_interrupt *pend;
+	unsigned long flags;
 
-	spin_lock(&interrupt->wait_list_lock);
+	spin_lock_irqsave(&interrupt->wait_list_lock, flags);
 	list_for_each_entry(pend, &interrupt->wait_list_head, wait_list_node) {
 		pend->fence.error = -EIO;
 		complete_all(&pend->fence.completion);
 	}
-	spin_unlock(&interrupt->wait_list_lock);
+	spin_unlock_irqrestore(&interrupt->wait_list_lock, flags);
 }
 
 void hl_release_pending_user_interrupts(struct hl_device *hdev)
@@ -2714,9 +2715,9 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 {
 	struct hl_user_pending_interrupt *pend;
 	struct hl_user_interrupt *interrupt;
-	unsigned long timeout;
-	long completion_rc;
+	unsigned long timeout, flags;
 	u32 completion_value;
+	long completion_rc;
 	int rc = 0;
 
 	if (timeout_us == U32_MAX)
@@ -2739,7 +2740,7 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 	else
 		interrupt = &hdev->user_interrupt[interrupt_offset];
 
-	spin_lock(&interrupt->wait_list_lock);
+	spin_lock_irqsave(&interrupt->wait_list_lock, flags);
 	if (!hl_device_operational(hdev, NULL)) {
 		rc = -EPERM;
 		goto unlock_and_free_fence;
@@ -2765,7 +2766,7 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 	 * handler to monitor
 	 */
 	list_add_tail(&pend->wait_list_node, &interrupt->wait_list_head);
-	spin_unlock(&interrupt->wait_list_lock);
+	spin_unlock_irqrestore(&interrupt->wait_list_lock, flags);
 
 wait_again:
 	/* Wait for interrupt handler to signal completion */
@@ -2777,12 +2778,12 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 	 * If comparison fails, keep waiting until timeout expires
 	 */
 	if (completion_rc > 0) {
-		spin_lock(&interrupt->wait_list_lock);
+		spin_lock_irqsave(&interrupt->wait_list_lock, flags);
 
 		if (copy_from_user(&completion_value,
 				u64_to_user_ptr(user_address), 4)) {
 
-			spin_unlock(&interrupt->wait_list_lock);
+			spin_unlock_irqrestore(&interrupt->wait_list_lock, flags);
 
 			dev_err(hdev->dev,
 				"Failed to copy completion value from user\n");
@@ -2792,13 +2793,13 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 		}
 
 		if (completion_value >= target_value) {
-			spin_unlock(&interrupt->wait_list_lock);
+			spin_unlock_irqrestore(&interrupt->wait_list_lock, flags);
 			*status = CS_WAIT_STATUS_COMPLETED;
 		} else {
 			reinit_completion(&pend->fence.completion);
 			timeout = completion_rc;
 
-			spin_unlock(&interrupt->wait_list_lock);
+			spin_unlock_irqrestore(&interrupt->wait_list_lock, flags);
 			goto wait_again;
 		}
 	} else if (completion_rc == -ERESTARTSYS) {
@@ -2812,11 +2813,11 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 	}
 
 remove_pending_user_interrupt:
-	spin_lock(&interrupt->wait_list_lock);
+	spin_lock_irqsave(&interrupt->wait_list_lock, flags);
 	list_del(&pend->wait_list_node);
 
 unlock_and_free_fence:
-	spin_unlock(&interrupt->wait_list_lock);
+	spin_unlock_irqrestore(&interrupt->wait_list_lock, flags);
 	kfree(pend);
 	hl_ctx_put(ctx);
 
-- 
2.17.1


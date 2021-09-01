Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646283FE003
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 18:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbhIAQgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 12:36:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245484AbhIAQeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 12:34:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1683661058;
        Wed,  1 Sep 2021 16:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630513993;
        bh=s2TucavZsd7zUPmOZwYMPKcyDfCf62bBfnuuMIJxfl4=;
        h=From:To:Cc:Subject:Date:From;
        b=LM6CZABzFl2LauwI67IXNiOC/pAh4lg3Y8W+lj9VBwMEpEKGvm7hhlz504bCsMhMz
         9y85JFx04V6FwQLgOclNxr0Hy3OTyq842bi1PGNJlvWIDAeOs28Fa7x6SNVcMBt9wg
         b1fsI+hCHhiwrtjcCdgfYpYSkOaEhvwAVIS+zydEtvhehpTNLfF3THpsRfngGq2kwT
         XIrq41mjyrNa7V9FEjFWbrxp2kMMfGUU40WPDMBIUnSuXa0gD+q1RkEt5u1YJz6OjF
         NEvUj6gQZ6mJGKTAOzM55SKoRmm5l9mC5yuabX0dS4fqIyJVccxqCyxxW8fn9yFG03
         ngcAZ983zc5lA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/2] habanalabs: fix potential race in interrupt wait ioctl
Date:   Wed,  1 Sep 2021 19:33:08 +0300
Message-Id: <20210901163309.112126-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

We have a potential race where a user interrupt can be received
in between user thread value comparison and before request was
added to wait list. This means that if no consecutive interrupt
will be received, user thread will timeout and fail.

The solution is to add the request to wait list before we
perform the comparison.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 35 +++++++++++--------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 7b0516cf808b..9a8b9191c28c 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2740,10 +2740,20 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 	else
 		interrupt = &hdev->user_interrupt[interrupt_offset];
 
+	/* Add pending user interrupt to relevant list for the interrupt
+	 * handler to monitor
+	 */
+	spin_lock_irqsave(&interrupt->wait_list_lock, flags);
+	list_add_tail(&pend->wait_list_node, &interrupt->wait_list_head);
+	spin_unlock_irqrestore(&interrupt->wait_list_lock, flags);
+
+	/* We check for completion value as interrupt could have been received
+	 * before we added the node to the wait list
+	 */
 	if (copy_from_user(&completion_value, u64_to_user_ptr(user_address), 4)) {
 		dev_err(hdev->dev, "Failed to copy completion value from user\n");
 		rc = -EFAULT;
-		goto free_fence;
+		goto remove_pending_user_interrupt;
 	}
 
 	if (completion_value >= target_value)
@@ -2752,14 +2762,7 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 		*status = CS_WAIT_STATUS_BUSY;
 
 	if (!timeout_us || (*status == CS_WAIT_STATUS_COMPLETED))
-		goto free_fence;
-
-	/* Add pending user interrupt to relevant list for the interrupt
-	 * handler to monitor
-	 */
-	spin_lock_irqsave(&interrupt->wait_list_lock, flags);
-	list_add_tail(&pend->wait_list_node, &interrupt->wait_list_head);
-	spin_unlock_irqrestore(&interrupt->wait_list_lock, flags);
+		goto remove_pending_user_interrupt;
 
 wait_again:
 	/* Wait for interrupt handler to signal completion */
@@ -2770,6 +2773,15 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 	 * If comparison fails, keep waiting until timeout expires
 	 */
 	if (completion_rc > 0) {
+		spin_lock_irqsave(&interrupt->wait_list_lock, flags);
+		/* reinit_completion must be called before we check for user
+		 * completion value, otherwise, if interrupt is received after
+		 * the comparison and before the next wait_for_completion,
+		 * we will reach timeout and fail
+		 */
+		reinit_completion(&pend->fence.completion);
+		spin_unlock_irqrestore(&interrupt->wait_list_lock, flags);
+
 		if (copy_from_user(&completion_value, u64_to_user_ptr(user_address), 4)) {
 			dev_err(hdev->dev, "Failed to copy completion value from user\n");
 			rc = -EFAULT;
@@ -2780,11 +2792,7 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 		if (completion_value >= target_value) {
 			*status = CS_WAIT_STATUS_COMPLETED;
 		} else {
-			spin_lock_irqsave(&interrupt->wait_list_lock, flags);
-			reinit_completion(&pend->fence.completion);
 			timeout = completion_rc;
-
-			spin_unlock_irqrestore(&interrupt->wait_list_lock, flags);
 			goto wait_again;
 		}
 	} else if (completion_rc == -ERESTARTSYS) {
@@ -2802,7 +2810,6 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 	list_del(&pend->wait_list_node);
 	spin_unlock_irqrestore(&interrupt->wait_list_lock, flags);
 
-free_fence:
 	kfree(pend);
 	hl_ctx_put(ctx);
 
-- 
2.17.1


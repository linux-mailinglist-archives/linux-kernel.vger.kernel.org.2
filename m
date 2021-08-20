Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F88B3F2E93
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 17:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241052AbhHTPIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 11:08:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240983AbhHTPIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 11:08:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A45696112E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 15:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629472051;
        bh=l2ha2dS8HOsBrlpFhVouhA4Nk6F7rSUhkz8tBpRTRuI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=V4ZPayfaIWGGbVAFzuzvIsfpyqVZmALyo8o7616X1YTFgkYK4K+h7dsrATR+JQVf5
         rJIjF66yJXF8ZGoeivvTzWYh4zermhcDAofk+ICM+2rsxnSogPbXaj5iYiS5knphr1
         xmFv1WsO9NZPeZzkPw62eWPWJesMaWVqcUCOmxHqcxrMtDJ5lj5k/BBV+JbRmBqDoB
         JlYKCngl4FFcJ62HOsmmoQwO0HJSb+P3Ep6vHqtvwHyiYr4P/5pArM3/5hjmAMZiVu
         FkN32eOcNzcEdyIhqyXnGio/0UQyLemIs3n+QezIh+VdifoKV6itjsqbA1reZ5MkBW
         SNc6jkAkzxrfw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] habanalabs: never copy_from_user inside spinlock
Date:   Fri, 20 Aug 2021 18:07:19 +0300
Message-Id: <20210820150719.67934-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820150719.67934-1-ogabbay@kernel.org>
References: <20210820150719.67934-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

copy_from_user might sleep so we can never call it when we have
a spinlock.

Moreover, it is not necessary in waiting for user interrupt, because
if multiple threads will call this function on the same interrupt,
each one will have it's own fence object inside the driver. The
user address might be the same, but it doesn't really matter to us,
as we only read from it.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 35 +++++++------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index a97bb27ebb90..7b0516cf808b 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2740,14 +2740,10 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 	else
 		interrupt = &hdev->user_interrupt[interrupt_offset];
 
-	spin_lock_irqsave(&interrupt->wait_list_lock, flags);
-
-	if (copy_from_user(&completion_value, u64_to_user_ptr(user_address),
-									4)) {
-		dev_err(hdev->dev,
-			"Failed to copy completion value from user\n");
+	if (copy_from_user(&completion_value, u64_to_user_ptr(user_address), 4)) {
+		dev_err(hdev->dev, "Failed to copy completion value from user\n");
 		rc = -EFAULT;
-		goto unlock_and_free_fence;
+		goto free_fence;
 	}
 
 	if (completion_value >= target_value)
@@ -2756,42 +2752,35 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 		*status = CS_WAIT_STATUS_BUSY;
 
 	if (!timeout_us || (*status == CS_WAIT_STATUS_COMPLETED))
-		goto unlock_and_free_fence;
+		goto free_fence;
 
 	/* Add pending user interrupt to relevant list for the interrupt
 	 * handler to monitor
 	 */
+	spin_lock_irqsave(&interrupt->wait_list_lock, flags);
 	list_add_tail(&pend->wait_list_node, &interrupt->wait_list_head);
 	spin_unlock_irqrestore(&interrupt->wait_list_lock, flags);
 
 wait_again:
 	/* Wait for interrupt handler to signal completion */
-	completion_rc =
-		wait_for_completion_interruptible_timeout(
-				&pend->fence.completion, timeout);
+	completion_rc = wait_for_completion_interruptible_timeout(&pend->fence.completion,
+										timeout);
 
 	/* If timeout did not expire we need to perform the comparison.
 	 * If comparison fails, keep waiting until timeout expires
 	 */
 	if (completion_rc > 0) {
-		spin_lock_irqsave(&interrupt->wait_list_lock, flags);
-
-		if (copy_from_user(&completion_value,
-				u64_to_user_ptr(user_address), 4)) {
-
-			spin_unlock_irqrestore(&interrupt->wait_list_lock, flags);
-
-			dev_err(hdev->dev,
-				"Failed to copy completion value from user\n");
+		if (copy_from_user(&completion_value, u64_to_user_ptr(user_address), 4)) {
+			dev_err(hdev->dev, "Failed to copy completion value from user\n");
 			rc = -EFAULT;
 
 			goto remove_pending_user_interrupt;
 		}
 
 		if (completion_value >= target_value) {
-			spin_unlock_irqrestore(&interrupt->wait_list_lock, flags);
 			*status = CS_WAIT_STATUS_COMPLETED;
 		} else {
+			spin_lock_irqsave(&interrupt->wait_list_lock, flags);
 			reinit_completion(&pend->fence.completion);
 			timeout = completion_rc;
 
@@ -2811,9 +2800,9 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 remove_pending_user_interrupt:
 	spin_lock_irqsave(&interrupt->wait_list_lock, flags);
 	list_del(&pend->wait_list_node);
-
-unlock_and_free_fence:
 	spin_unlock_irqrestore(&interrupt->wait_list_lock, flags);
+
+free_fence:
 	kfree(pend);
 	hl_ctx_put(ctx);
 
-- 
2.17.1


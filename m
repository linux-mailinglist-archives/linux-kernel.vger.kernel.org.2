Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2699E3B9121
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 13:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbhGAL35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 07:29:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236040AbhGAL3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 07:29:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7C0E6147D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 11:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625138844;
        bh=nNrQC63NikNLqxeTkcD3rb0pXT0h3yZDJ7f9B32wyaA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FdouCNKNkXLulhZV/JE/913vwKniHRytPpc4O/Gp6QLWNu2mLUbj1RIMj2RSxGRbU
         fyufEBF4Rh8dn/FDVTynkVfV5Xet4sM72sjgP5Y4isd7BKQ37v+WmLk+imOnc/grmG
         bMBdsi0XhcmC04Bi/+0sZqK91CRPnLI/7rn5QNzz4mBHHI7bZt7L+zUKL67W4nJ5z2
         oQeVN00XLRjxhUh/lsttxCk3Y1hLKF1bjjLdv5/svCw3FWKH2PzyTKq06pXDYRldpW
         doJubwXCJeHsdR79U7Lew32Xs1S8jfGrcJWs/OTnZMvUaV+eLb+RT5AkcXYwsRw2xH
         QtKt90P/zAntg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] habanalabs: re-init completion object upon retry
Date:   Thu,  1 Jul 2021 14:27:13 +0300
Message-Id: <20210701112717.9540-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210701112717.9540-1-ogabbay@kernel.org>
References: <20210701112717.9540-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case user interrupt arrived but the completion value is less than
the target value, we want to retry the wait.

However, before the retry we must reinitialize the completion object,
under spin-lock, so the wait function won't exit immediately because
the completion object is already completed (from the previous
interrupt).

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 80c60fb41bbc..12f20446e99a 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2046,7 +2046,8 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 		goto unlock_and_free_fence;
 	}
 
-	if (copy_from_user(&completion_value, u64_to_user_ptr(user_address), 4)) {
+	if (copy_from_user(&completion_value, u64_to_user_ptr(user_address),
+									4)) {
 		dev_err(hdev->dev,
 			"Failed to copy completion value from user\n");
 		rc = -EFAULT;
@@ -2077,18 +2078,28 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 	 * If comparison fails, keep waiting until timeout expires
 	 */
 	if (completion_rc > 0) {
+		spin_lock(&interrupt->wait_list_lock);
+
 		if (copy_from_user(&completion_value,
 				u64_to_user_ptr(user_address), 4)) {
+
+			spin_unlock(&interrupt->wait_list_lock);
+
 			dev_err(hdev->dev,
 				"Failed to copy completion value from user\n");
 			rc = -EFAULT;
+
 			goto remove_pending_user_interrupt;
 		}
 
 		if (completion_value >= target_value) {
+			spin_unlock(&interrupt->wait_list_lock);
 			*status = CS_WAIT_STATUS_COMPLETED;
 		} else {
+			reinit_completion(&pend->fence.completion);
 			timeout = completion_rc;
+
+			spin_unlock(&interrupt->wait_list_lock);
 			goto wait_again;
 		}
 	} else {
-- 
2.25.1


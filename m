Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B5C3F2E92
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 17:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241030AbhHTPIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 11:08:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240968AbhHTPII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 11:08:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78A3060FDA
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 15:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629472050;
        bh=3/L8H2QBs6PnSlI28I97iO39q8f+miKaNwO+fzjrnSs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VWM323HRjeduxjlFYIj1d45h50AbtRBng4M+LQ9DSxhpTlIfw5FirnwFaG28C9mYi
         5TYKTuCT8DOgNmm4GPtZd1XLAzEm+oS6QkgGoP1IbHtiq4FRe0BtJdinMiux46rSoN
         TU7bHCR7hCYpxz82p1Jvhq8Z4gUEUDER25BqG15Kaaxr8C0NicYsLA5H9bFV75DwJT
         pINJ2umYOc0jQhpMdFC1Zm/jM7qibIW+vr8vLVGupDJ1YvHsxCMKX4zTVWVIwSy0Al
         o+XhNyGjd8KijWDwri+8oOg40bj+i2LQLEzU42ZN1/NJLGKQA4ocecKPZ/59U5O/aI
         jmk3G2B4/uacw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] habanalabs: remove unnecessary device status check
Date:   Fri, 20 Aug 2021 18:07:18 +0300
Message-Id: <20210820150719.67934-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210820150719.67934-1-ogabbay@kernel.org>
References: <20210820150719.67934-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking if the device is operational when entering the function to
wait for user interrupt is not something that is useful or necessary.

It is not done in any other wait_for_cs ioctl path.

If the device becomes non-operational during the wait, the reset
function will make sure the process wait is interrupted.

Instead, move the check to the beginning of hl_wait_ioctl(). It will
block any attempt to wait on CS or user interrupt once the device
is already marked as non-operational.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 8a2f75de6df8..a97bb27ebb90 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2741,10 +2741,6 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 		interrupt = &hdev->user_interrupt[interrupt_offset];
 
 	spin_lock_irqsave(&interrupt->wait_list_lock, flags);
-	if (!hl_device_operational(hdev, NULL)) {
-		rc = -EPERM;
-		goto unlock_and_free_fence;
-	}
 
 	if (copy_from_user(&completion_value, u64_to_user_ptr(user_address),
 									4)) {
@@ -2891,6 +2887,12 @@ int hl_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 	u32 flags = args->in.flags;
 	int rc;
 
+	/* If the device is not operational, no point in waiting for any command submission or
+	 * user interrupt
+	 */
+	if (!hl_device_operational(hpriv->hdev, NULL))
+		return -EPERM;
+
 	if (flags & HL_WAIT_CS_FLAGS_INTERRUPT)
 		rc = hl_interrupt_wait_ioctl(hpriv, data);
 	else if (flags & HL_WAIT_CS_FLAGS_MULTI_CS)
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981D542E3E1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 23:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbhJNV7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 17:59:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229829AbhJNV7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 17:59:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE86E6108E;
        Thu, 14 Oct 2021 21:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634248638;
        bh=ZI0iCYs3qrRnNNXjtxaoxU0Yank7YLMxvVLB18/FXgs=;
        h=From:To:Cc:Subject:Date:From;
        b=X67dWTvzRThDcnjF+zIrfzM7Hs3C05/TUR/b9txQF6LQliBCun1mjS/aCTjjhwFR5
         MuL1nNsdhNbM+ckVUwk6adiokWp06kVhoVn8KDAoWryQl8FGUjVNabJO/Q8jRVHEJD
         ffMvzE3KEWlBeA+8NwKt8y6TzYbrfFCvwSfPQqDKuNCliWThXNveMfL8kT9OYHc3wr
         p+WsjuG9rw73hFyDT8Z2b7zD/Nos0TOSdd526o2kQfWx0kbO8F/GC+luSJFXFCBWDM
         4+QCHJjtt94NoGonEFpw0ChIUwrGiGNfjkg0it488medfjYV6Zw6QsUr0E3cU34owh
         7Gn67OqqNEXlQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] staging: wlan-ng: Avoid bitwise vs logical OR warning in hfa384x_usb_throttlefn()
Date:   Thu, 14 Oct 2021 14:57:03 -0700
Message-Id: <20211014215703.3705371-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.1.637.gf443b226ca
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new warning in clang points out a place in this file where a bitwise
OR is being used with boolean expressions:

In file included from drivers/staging/wlan-ng/prism2usb.c:2:
drivers/staging/wlan-ng/hfa384x_usb.c:3787:7: warning: use of bitwise '|' with boolean operands [-Wbitwise-instead-of-logical]
            ((test_and_clear_bit(THROTTLE_RX, &hw->usb_flags) &&
            ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/staging/wlan-ng/hfa384x_usb.c:3787:7: note: cast one or both operands to int to silence this warning
1 warning generated.

The comment explains that short circuiting here is undesirable, as the
calls to test_and_{clear,set}_bit() need to happen for both sides of the
expression.

Clang's suggestion would work to silence the warning but the readability
of the expression would suffer even more. To clean up the warning and
make the block more readable, use a variable for each side of the
bitwise expression.

Link: https://github.com/ClangBuiltLinux/linux/issues/1478
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/staging/wlan-ng/hfa384x_usb.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/wlan-ng/hfa384x_usb.c b/drivers/staging/wlan-ng/hfa384x_usb.c
index 59aa84d1837d..938e11a1a0b6 100644
--- a/drivers/staging/wlan-ng/hfa384x_usb.c
+++ b/drivers/staging/wlan-ng/hfa384x_usb.c
@@ -3778,18 +3778,18 @@ static void hfa384x_usb_throttlefn(struct timer_list *t)
 
 	spin_lock_irqsave(&hw->ctlxq.lock, flags);
 
-	/*
-	 * We need to check BOTH the RX and the TX throttle controls,
-	 * so we use the bitwise OR instead of the logical OR.
-	 */
 	pr_debug("flags=0x%lx\n", hw->usb_flags);
-	if (!hw->wlandev->hwremoved &&
-	    ((test_and_clear_bit(THROTTLE_RX, &hw->usb_flags) &&
-	      !test_and_set_bit(WORK_RX_RESUME, &hw->usb_flags)) |
-	     (test_and_clear_bit(THROTTLE_TX, &hw->usb_flags) &&
-	      !test_and_set_bit(WORK_TX_RESUME, &hw->usb_flags))
-	    )) {
-		schedule_work(&hw->usb_work);
+	if (!hw->wlandev->hwremoved) {
+		bool rx_throttle = test_and_clear_bit(THROTTLE_RX, &hw->usb_flags) &&
+				   !test_and_set_bit(WORK_RX_RESUME, &hw->usb_flags);
+		bool tx_throttle = test_and_clear_bit(THROTTLE_TX, &hw->usb_flags) &&
+				   !test_and_set_bit(WORK_TX_RESUME, &hw->usb_flags);
+		/*
+		 * We need to check BOTH the RX and the TX throttle controls,
+		 * so we use the bitwise OR instead of the logical OR.
+		 */
+		if (rx_throttle | tx_throttle)
+			schedule_work(&hw->usb_work);
 	}
 
 	spin_unlock_irqrestore(&hw->ctlxq.lock, flags);

base-commit: 6ac113f741a7674e4268eea3eb13972732d83571
-- 
2.33.1.637.gf443b226ca


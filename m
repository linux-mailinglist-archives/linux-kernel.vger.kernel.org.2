Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B0936EB25
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 15:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbhD2NJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 09:09:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238456AbhD2NJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 09:09:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B73A61057;
        Thu, 29 Apr 2021 13:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619701706;
        bh=vQaYKW+5nQgdI7Y2naghwyxtzkgbBNkMPs+FtpwjlaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T7HL1uZG+VieWMUO3PIAiWmxjrEpjoduDtqDExdoNG4P6FvXTCwkDE1fk7hJ9lkNv
         gHU0m+m5bQmhYhUki+uekkCOjQ6YPW8V/Uq6Y6dFUdbyXFH9fHHi71QCwLeGBwdKH9
         By8rGt1gIgBOQKcblqJkDDrygLYY0CvAYwVBzGPE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 3/7] Revert "orinoco: avoid assertion in case of NULL pointer"
Date:   Thu, 29 Apr 2021 15:08:07 +0200
Message-Id: <20210429130811.3353369-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210429130811.3353369-1-gregkh@linuxfoundation.org>
References: <20210429130811.3353369-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit c705f9fc6a1736dcf6ec01f8206707c108dca824.

Commits from @umn.edu addresses have been found to be submitted in "bad
faith" to try to test the kernel community's ability to review "known
malicious" changes.  The result of these submissions can be found in a
paper submitted to the 42nd IEEE Symposium on Security and Privacy
entitled, "Open Source Insecurity: Stealthily Introducing
Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
of Minnesota) and Kangjie Lu (University of Minnesota) but later
withdrawn.

Because of this, all submissions from this group must be reverted from
the kernel tree and will need to be re-reviewed again to determine if
they actually are a valid fix.  Until that work is complete, remove this
change to ensure that no problems are being introduced into the
codebase.

Cc: Aditya Pakki <pakki001@umn.edu>
Cc: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intersil/orinoco/orinoco_usb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intersil/orinoco/orinoco_usb.c b/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
index dd31929261ab..60e626eb913d 100644
--- a/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
+++ b/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
@@ -1392,8 +1392,7 @@ static int ezusb_init(struct hermes *hw)
 	struct ezusb_priv *upriv = hw->priv;
 	int retval;
 
-	if (!upriv)
-		return -EINVAL;
+	BUG_ON(!upriv);
 
 	upriv->reply_count = 0;
 	/* Write the MAGIC number on the simulated registers to keep
-- 
2.31.1


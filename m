Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D945366C7C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241894AbhDUNS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:18:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239792AbhDUNJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:09:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 074B761476;
        Wed, 21 Apr 2021 13:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010487;
        bh=XeXUQhnBtVX/+NBADaBX5aGK6jRrb4fNppiFs2jMYVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qWqGFZSDqFnmdB2UcJEg5XJZZFk/rMAJXj631qy9/Dv51eoBwz+h5KyZJPTWBaTwm
         I3JfOJ5qphq3ScvxWur31Flz/3qXq1z15PX2AhCvf5wYpZJk+xr7sziUrLLsYyVfUM
         j4FXti9LyzPDRIbmz0RM6HPddStY58MSnB6xPGMA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>, Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 155/190] Revert "brcmfmac: add a check for the status of usb_register"
Date:   Wed, 21 Apr 2021 15:00:30 +0200
Message-Id: <20210421130105.1226686-156-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 42daad3343be4a4e1ee03e30a5f5cc731dadfef5.

Commits from @umn.edu addresses have been found to be submitted in "bad
faith" to try to test the kernel community's ability to review "known
malicious" changes.  The result of these submissions can be found in a
paper published at the 42nd IEEE Symposium on Security and Privacy
entitled, "Open Source Insecurity: Stealthily Introducing
Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
of Minnesota) and Kangjie Lu (University of Minnesota).

Because of this, all submissions from this group must be reverted from
the kernel tree and will need to be re-reviewed again to determine if
they actually are a valid fix.  Until that work is complete, remove this
change to ensure that no problems are being introduced into the
codebase.

Cc: Kangjie Lu <kjlu@umn.edu>
Cc: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index 586f4dfc638b..d2a803fc8ac6 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -1586,10 +1586,6 @@ void brcmf_usb_exit(void)
 
 void brcmf_usb_register(void)
 {
-	int ret;
-
 	brcmf_dbg(USB, "Enter\n");
-	ret = usb_register(&brcmf_usbdrvr);
-	if (ret)
-		brcmf_err("usb_register failed %d\n", ret);
+	usb_register(&brcmf_usbdrvr);
 }
-- 
2.31.1


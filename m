Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA14E366BC5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241027AbhDUNGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:06:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234340AbhDUNFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:05:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F06F86144C;
        Wed, 21 Apr 2021 13:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010283;
        bh=Djgxgz4Yq5aee3tYO2USWvW75GrNTN0DXteofV7ehlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PYL/IvRL6FDVNX/snG1keQqDtl62hSZ16hcc4Wagp4Mry2UpdpqyJixIoQpHXSZK3
         4m/HN6qa85Oxt4RjVwdMvbwsdk5sloEsjrX+Kg6izXGmYN+OqVocLCljrAI44hqTjT
         p8tpPsJy/4bOX+zZqPLzQVEIazOM+9MQDony2lnk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wenwen Wang <wang6495@umn.edu>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 080/190] Revert "ALSA: usx2y: fix a double free bug"
Date:   Wed, 21 Apr 2021 14:59:15 +0200
Message-Id: <20210421130105.1226686-81-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit cbb88db76a1536e02e93e5bd37ebbfbb6c4043a9.

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

Cc: Wenwen Wang <wang6495@umn.edu>
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/usx2y/usbusx2y.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index 3cd28d24f0a7..bb188245b0e2 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -279,8 +279,10 @@ int usX2Y_In04_init(struct usX2Ydev *usX2Y)
 	if (! (usX2Y->In04urb = usb_alloc_urb(0, GFP_KERNEL)))
 		return -ENOMEM;
 
-	if (! (usX2Y->In04Buf = kmalloc(21, GFP_KERNEL)))
+	if (! (usX2Y->In04Buf = kmalloc(21, GFP_KERNEL))) {
+		usb_free_urb(usX2Y->In04urb);
 		return -ENOMEM;
+	}
 	 
 	init_waitqueue_head(&usX2Y->In04WaitQueue);
 	usb_fill_int_urb(usX2Y->In04urb, usX2Y->dev, usb_rcvintpipe(usX2Y->dev, 0x4),
-- 
2.31.1


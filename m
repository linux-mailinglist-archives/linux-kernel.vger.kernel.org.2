Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF08366C19
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242480AbhDUNKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:10:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241035AbhDUNHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:07:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0378B6146D;
        Wed, 21 Apr 2021 13:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010421;
        bh=CEumbI762zughXLmNxPnsuID3yI1J/TDIozx/JWmOYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gBHs96z6d5b80E5USDEXH7piaxNXQROasyPbeqBEoMliCbvpzUNuQxkLMpNkaPHGS
         lDTXNfbeOEvvRbQ93p17rYGhNDZY7hVLT9OLwMgalaM2J33IjkNe7fYO4EPn7Ngn2e
         h9+M0PBluB9qf8vLVYfqlxxTklqmeIc63G5TQPIs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 130/190] Revert "ALSA: usx2y: Fix potential NULL pointer dereference"
Date:   Wed, 21 Apr 2021 15:00:05 +0200
Message-Id: <20210421130105.1226686-131-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit a2c6433ee5a35a8de6d563f6512a26f87835ea0f.

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

Cc: Aditya Pakki <pakki001@umn.edu>
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/usx2y/usb_stream.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/usb/usx2y/usb_stream.c b/sound/usb/usx2y/usb_stream.c
index 091c071b270a..6bba17bf689a 100644
--- a/sound/usb/usx2y/usb_stream.c
+++ b/sound/usb/usx2y/usb_stream.c
@@ -91,12 +91,7 @@ static int init_urbs(struct usb_stream_kernel *sk, unsigned use_packsize,
 
 	for (u = 0; u < USB_STREAM_NURBS; ++u) {
 		sk->inurb[u] = usb_alloc_urb(sk->n_o_ps, GFP_KERNEL);
-		if (!sk->inurb[u])
-			return -ENOMEM;
-
 		sk->outurb[u] = usb_alloc_urb(sk->n_o_ps, GFP_KERNEL);
-		if (!sk->outurb[u])
-			return -ENOMEM;
 	}
 
 	if (init_pipe_urbs(sk, use_packsize, sk->inurb, indata, dev, in_pipe) ||
-- 
2.31.1


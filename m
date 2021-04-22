Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D82336805C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbhDVM1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:27:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:46752 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236008AbhDVM1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:27:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619094420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RECEfsZBNRjYNvlSSaCaXHoBXSmE5X3WtOQeZ0cdsQk=;
        b=JCJpJNqgbl436K8JGv5cMckSpbcM2e7aw1prytkAxI81R1PpNJRbDJQwVcvVrexN6TJ3Uu
        VQOsBqdrCmhULF9i5Aoi1gEsDefDb56uRLG4EdlsIyyV2btyHgrjijnX/7+ekCk65Ovt2Y
        0zhuqYJoMiv0rdbGPHG+OdQazkiuDzk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 50D60AF1E;
        Thu, 22 Apr 2021 12:27:00 +0000 (UTC)
Message-ID: <94aa3e7fcbb225da66961a21c940406ada2bbd0b.camel@suse.com>
Subject: Re: [syzbot] memory leak in usb_set_configuration (2)
From:   Oliver Neukum <oneukum@suse.com>
To:     syzbot <syzbot+d1e69c888f0d3866ead4@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mathias.nyman@linux.intel.com, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Date:   Thu, 22 Apr 2021 14:26:42 +0200
In-Reply-To: <0000000000001ad5d605c07cfd2e@google.com>
References: <0000000000001ad5d605c07cfd2e@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 21.04.2021, 08:12 -0700 schrieb syzbot:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    9cdbf646 Merge tag 'io_uring-5.12-2021-04-16' of git://git..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=136ce5a6d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fd35e661e44323ea
> dashboard link: https://syzkaller.appspot.com/bug?extid=d1e69c888f0d3866ead4
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ecba29d00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143cf955d00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d1e69c888f0d3866ead4@syzkaller.appspotmail.com

#syz test: https://github.com/google/kasan.git 9cdbf646

From 1704504f905fe8e3eb83d63cbbbe9af60f002585 Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oneukum@suse.com>
Date: Thu, 22 Apr 2021 14:14:21 +0200
Subject: [PATCH] cpia2: unregister device on probe error

The v4l2 device must be unregistered in case probe() fails,
lest we get a leak.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/media/usb/cpia2/cpia2_usb.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/media/usb/cpia2/cpia2_usb.c b/drivers/media/usb/cpia2/cpia2_usb.c
index 3ab80a7b4498..db3b5d6d2d9a 100644
--- a/drivers/media/usb/cpia2/cpia2_usb.c
+++ b/drivers/media/usb/cpia2/cpia2_usb.c
@@ -844,15 +844,13 @@ static int cpia2_usb_probe(struct usb_interface *intf,
 	ret = set_alternate(cam, USBIF_CMDONLY);
 	if (ret < 0) {
 		ERR("%s: usb_set_interface error (ret = %d)\n", __func__, ret);
-		kfree(cam);
-		return ret;
+		goto error;
 	}
 
 
 	if((ret = cpia2_init_camera(cam)) < 0) {
 		ERR("%s: failed to initialize cpia2 camera (ret = %d)\n", __func__, ret);
-		kfree(cam);
-		return ret;
+		goto error;
 	}
 	LOG("  CPiA Version: %d.%02d (%d.%d)\n",
 	       cam->params.version.firmware_revision_hi,
@@ -872,11 +870,14 @@ static int cpia2_usb_probe(struct usb_interface *intf,
 	ret = cpia2_register_camera(cam);
 	if (ret < 0) {
 		ERR("%s: Failed to register cpia2 camera (ret = %d)\n", __func__, ret);
-		kfree(cam);
-		return ret;
+		goto error;
 	}
 
 	return 0;
+error:
+	v4l2_device_unregister(&cam->v4l2_dev);
+	kfree(cam);
+	return ret;
 }
 
 /******************************************************************************
-- 
2.26.2




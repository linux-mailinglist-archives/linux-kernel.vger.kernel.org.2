Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766C73C34E9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 16:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhGJOwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 10:52:51 -0400
Received: from netrider.rowland.org ([192.131.102.5]:44745 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229805AbhGJOwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 10:52:49 -0400
Received: (qmail 272166 invoked by uid 1000); 10 Jul 2021 10:50:03 -0400
Date:   Sat, 10 Jul 2021 10:50:03 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+72af3105289dcb4c055b@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mathias.nyman@linux.intel.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in do_proc_control/usb_submit_urb
Message-ID: <20210710145003.GA271154@rowland.harvard.edu>
References: <0000000000005d93c405c6c2f20d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000005d93c405c6c2f20d@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2021 at 04:11:15AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ee268dee Add linux-next specific files for 20210707
> git tree:       linux-next

Is this an old version of syzbot?  I thought it had been fixed up to 
give a real URL (one that "#syz test:" would accept) for the git 
tree and a 12-digit SHA-1 abbreviation for the HEAD commit.

> console output: https://syzkaller.appspot.com/x/log.txt?x=1067ddb4300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=59e1e3bbc3afca75
> dashboard link: https://syzkaller.appspot.com/bug?extid=72af3105289dcb4c055b
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116443fc300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=102541c4300000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+72af3105289dcb4c055b@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> usb usb2: BOGUS control dir, pipe 80000180 doesn't match bRequestType 80
> WARNING: CPU: 0 PID: 8442 at drivers/usb/core/urb.c:410 usb_submit_urb+0x149d/0x18a0 drivers/usb/core/urb.c:410
> Modules linked in:
> CPU: 1 PID: 8442 Comm: syz-executor261 Tainted: G        W         5.13.0-next-20210707-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:usb_submit_urb+0x149d/0x18a0 drivers/usb/core/urb.c:410
> Code: 7c 24 40 e8 45 1e 20 fc 48 8b 7c 24 40 e8 6b 40 0c ff 45 89 e8 44 89 f1 4c 89 e2 48 89 c6 48 c7 c7 a0 99 27 8a e8 5a a4 91 03 <0f> 0b e9 a5 ee ff ff e8 17 1e 20 fc 0f b6 1d 21 86 02 08 31 ff 41
> RSP: 0018:ffffc90002f5f9a8 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: ffff888146fee058 RCX: 0000000000000000
> RDX: ffff88801891b900 RSI: ffffffff815d7735 RDI: fffff520005ebf27
> RBP: ffff88801f4523e8 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffffff815d156e R11: 0000000000000000 R12: ffff88801c6aa8c0
> R13: 0000000000000080 R14: 0000000080000180 R15: ffff8880205f3a00
> FS:  0000000000977300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fdf91ee0000 CR3: 0000000016427000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  usb_start_wait_urb+0x101/0x4c0 drivers/usb/core/message.c:58
>  usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
>  usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
>  do_proc_control+0x6c4/0x920 drivers/usb/core/devio.c:1141
>  proc_control drivers/usb/core/devio.c:1191 [inline]
>  usbdev_do_ioctl drivers/usb/core/devio.c:2540 [inline]
>  usbdev_ioctl+0x10e2/0x36c0 drivers/usb/core/devio.c:2713

Apparently I forgot to fix the usbfs pathways.

Alan Stern

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git ee268dee

Index: usb-devel/drivers/usb/core/devio.c
===================================================================
--- usb-devel.orig/drivers/usb/core/devio.c
+++ usb-devel/drivers/usb/core/devio.c
@@ -1133,7 +1133,7 @@ static int do_proc_control(struct usb_de
 		"wIndex=%04x wLength=%04x\n",
 		ctrl->bRequestType, ctrl->bRequest, ctrl->wValue,
 		ctrl->wIndex, ctrl->wLength);
-	if (ctrl->bRequestType & 0x80) {
+	if ((ctrl->bRequestType & USB_DIR_IN) && ctrl->wLength) {
 		pipe = usb_rcvctrlpipe(dev, 0);
 		snoop_urb(dev, NULL, pipe, ctrl->wLength, tmo, SUBMIT, NULL, 0);
 
@@ -1157,6 +1157,7 @@ static int do_proc_control(struct usb_de
 				goto done;
 			}
 		}
+		ctrl->bRequestType &= ~USB_DIR_IN;
 		pipe = usb_sndctrlpipe(dev, 0);
 		snoop_urb(dev, NULL, pipe, ctrl->wLength, tmo, SUBMIT,
 			tbuf, ctrl->wLength);
@@ -1579,6 +1580,13 @@ static int proc_do_submiturb(struct usb_
 				      le16_to_cpu(dr->wIndex));
 		if (ret)
 			goto error;
+		snoop(&ps->dev->dev, "control urb: bRequestType=%02x "
+			"bRequest=%02x wValue=%04x "
+			"wIndex=%04x wLength=%04x\n",
+			dr->bRequestType, dr->bRequest,
+			__le16_to_cpu(dr->wValue),
+			__le16_to_cpu(dr->wIndex),
+			__le16_to_cpu(dr->wLength));
 		uurb->buffer_length = le16_to_cpu(dr->wLength);
 		uurb->buffer += 8;
 		if ((dr->bRequestType & USB_DIR_IN) && uurb->buffer_length) {
@@ -1587,16 +1595,10 @@ static int proc_do_submiturb(struct usb_
 		} else {
 			is_in = false;
 			uurb->endpoint &= ~USB_DIR_IN;
+			dr->bRequestType &= ~USB_DIR_IN;
 		}
 		if (is_in)
 			allow_short = true;
-		snoop(&ps->dev->dev, "control urb: bRequestType=%02x "
-			"bRequest=%02x wValue=%04x "
-			"wIndex=%04x wLength=%04x\n",
-			dr->bRequestType, dr->bRequest,
-			__le16_to_cpu(dr->wValue),
-			__le16_to_cpu(dr->wIndex),
-			__le16_to_cpu(dr->wLength));
 		u = sizeof(struct usb_ctrlrequest);
 		break;
 

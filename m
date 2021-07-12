Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFC43C5DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 16:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbhGLOC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 10:02:56 -0400
Received: from netrider.rowland.org ([192.131.102.5]:43603 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231721AbhGLOCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 10:02:53 -0400
Received: (qmail 317233 invoked by uid 1000); 12 Jul 2021 10:00:04 -0400
Date:   Mon, 12 Jul 2021 10:00:04 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+72af3105289dcb4c055b@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mathias.nyman@linux.intel.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in do_proc_control/usb_submit_urb
Message-ID: <20210712140004.GA316776@rowland.harvard.edu>
References: <20210711155345.GB293743@rowland.harvard.edu>
 <00000000000068b24405c6db3249@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000068b24405c6db3249@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2021 at 09:07:09AM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> WARNING in do_proc_control/usb_submit_urb
> 
> ------------[ cut here ]------------
> usb usb2: BOGUS control dir, pipe 80000180 doesn't match bRequestType 80
> WARNING: CPU: 0 PID: 10164 at drivers/usb/core/urb.c:410 usb_submit_urb+0x149d/0x18a0 drivers/usb/core/urb.c:410
> Modules linked in:
> CPU: 1 PID: 10164 Comm: syz-executor.2 Tainted: G        W         5.13.0-next-20210707-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:usb_submit_urb+0x149d/0x18a0 drivers/usb/core/urb.c:410
> Code: 7c 24 40 e8 45 1e 20 fc 48 8b 7c 24 40 e8 6b 40 0c ff 45 89 e8 44 89 f1 4c 89 e2 48 89 c6 48 c7 c7 a0 99 27 8a e8 5a a4 91 03 <0f> 0b e9 a5 ee ff ff e8 17 1e 20 fc 0f b6 1d 21 86 02 08 31 ff 41
> RSP: 0018:ffffc9000a33f9a8 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: ffff8881468f1058 RCX: 0000000000000000
> RDX: ffff88802a830000 RSI: ffffffff815d7735 RDI: fffff52001467f27
> RBP: ffff888142fe0578 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffffff815d156e R11: 0000000000000000 R12: ffff888146811500
> R13: 0000000000000080 R14: 0000000080000180 R15: ffff8880135f2700
> FS:  00007f1b9bc83700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffcfa7f3720 CR3: 000000003de67000 CR4: 00000000001506e0
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

I don't get this.  It shouldn't be possible.  The fact that the 
direction bit is set in both bRequestType and pipe means that the URB 
was submitted as a control-IN but had length 0.  But the patch addresses 
exactly that case:

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
 
and causes the kernel to handle it as a control-OUT instead.

Johan, any ideas?

Alan Stern


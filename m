Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5ADE3C5F41
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 17:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbhGLPc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 11:32:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229987AbhGLPc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 11:32:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D997760E08;
        Mon, 12 Jul 2021 15:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626103779;
        bh=yhz9CUpwyJleUtb3S7n67XZS0ryrpqybNAxPTMxmyO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q7UC50se7bINSukV5ZcCfu67MX0Pzc1r5Uw1iaCJ7xGrTK0ufuDVEj516jEYEXo0e
         1quzgk+H0yMVqSt1hC4ZMiH7lTIcMipZ1UVWv2VYLG0jmcE7b7s/Tg8mtR5fSUs9ON
         CP3p9MSkfkZXA6hy6G4TiOf84+bCbAigJ9pJcw6C8RZNQ6r5HADkxP+JTaUM/Vb4q3
         COILjySTMVox+5ZFc4yMrNiy04Q/AbVKUxo9/EXGS9e0SY8hDcVHK/7vW6a/nYQOH/
         gYWYMOa1uguPqHTMcpZgGAoVgOuvoi0EdiX1wk3KHijV50RB6vCxlfx4G4MdSR9bE1
         4/L/KS1KCOvKg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1m2xs0-0007QP-KB; Mon, 12 Jul 2021 17:29:21 +0200
Date:   Mon, 12 Jul 2021 17:29:20 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+72af3105289dcb4c055b@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mathias.nyman@linux.intel.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in do_proc_control/usb_submit_urb
Message-ID: <YOxf0OvoGOvWf14m@hovoldconsulting.com>
References: <20210711155345.GB293743@rowland.harvard.edu>
 <00000000000068b24405c6db3249@google.com>
 <20210712140004.GA316776@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712140004.GA316776@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 10:00:04AM -0400, Alan Stern wrote:
> On Sun, Jul 11, 2021 at 09:07:09AM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > WARNING in do_proc_control/usb_submit_urb
> > 
> > ------------[ cut here ]------------
> > usb usb2: BOGUS control dir, pipe 80000180 doesn't match bRequestType 80
> > WARNING: CPU: 0 PID: 10164 at drivers/usb/core/urb.c:410 usb_submit_urb+0x149d/0x18a0 drivers/usb/core/urb.c:410
> > Modules linked in:
> > CPU: 1 PID: 10164 Comm: syz-executor.2 Tainted: G        W         5.13.0-next-20210707-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > RIP: 0010:usb_submit_urb+0x149d/0x18a0 drivers/usb/core/urb.c:410
> > Code: 7c 24 40 e8 45 1e 20 fc 48 8b 7c 24 40 e8 6b 40 0c ff 45 89 e8 44 89 f1 4c 89 e2 48 89 c6 48 c7 c7 a0 99 27 8a e8 5a a4 91 03 <0f> 0b e9 a5 ee ff ff e8 17 1e 20 fc 0f b6 1d 21 86 02 08 31 ff 41
> > RSP: 0018:ffffc9000a33f9a8 EFLAGS: 00010286
> > RAX: 0000000000000000 RBX: ffff8881468f1058 RCX: 0000000000000000
> > RDX: ffff88802a830000 RSI: ffffffff815d7735 RDI: fffff52001467f27
> > RBP: ffff888142fe0578 R08: 0000000000000000 R09: 0000000000000000
> > R10: ffffffff815d156e R11: 0000000000000000 R12: ffff888146811500
> > R13: 0000000000000080 R14: 0000000080000180 R15: ffff8880135f2700
> > FS:  00007f1b9bc83700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007ffcfa7f3720 CR3: 000000003de67000 CR4: 00000000001506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  usb_start_wait_urb+0x101/0x4c0 drivers/usb/core/message.c:58
> >  usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
> >  usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
> >  do_proc_control+0x6c4/0x920 drivers/usb/core/devio.c:1141
> >  proc_control drivers/usb/core/devio.c:1191 [inline]
> >  usbdev_do_ioctl drivers/usb/core/devio.c:2540 [inline]
> >  usbdev_ioctl+0x10e2/0x36c0 drivers/usb/core/devio.c:2713
> 
> I don't get this.  It shouldn't be possible.  The fact that the 
> direction bit is set in both bRequestType and pipe means that the URB 
> was submitted as a control-IN but had length 0.  But the patch addresses 
> exactly that case:
> 
> --- usb-devel.orig/drivers/usb/core/devio.c
> +++ usb-devel/drivers/usb/core/devio.c
> @@ -1133,7 +1133,7 @@ static int do_proc_control(struct usb_de
>  		"wIndex=%04x wLength=%04x\n",
>  		ctrl->bRequestType, ctrl->bRequest, ctrl->wValue,
>  		ctrl->wIndex, ctrl->wLength);
> -	if (ctrl->bRequestType & 0x80) {
> +	if ((ctrl->bRequestType & USB_DIR_IN) && ctrl->wLength) {
>  		pipe = usb_rcvctrlpipe(dev, 0);
>  		snoop_urb(dev, NULL, pipe, ctrl->wLength, tmo, SUBMIT, NULL, 0);
>  
> and causes the kernel to handle it as a control-OUT instead.
> 
> Johan, any ideas?

Did syzbot actually test the patch? I can't see how the direction bit of
the pipe argument can be set with the above applied either.

Johan

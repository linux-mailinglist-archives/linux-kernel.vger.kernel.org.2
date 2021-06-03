Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F3939979B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 03:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhFCBpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 21:45:40 -0400
Received: from netrider.rowland.org ([192.131.102.5]:40103 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229626AbhFCBpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 21:45:39 -0400
Received: (qmail 1626258 invoked by uid 1000); 2 Jun 2021 21:43:54 -0400
Date:   Wed, 2 Jun 2021 21:43:54 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+7dbcd9ff34dc4ed45240@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mathias.nyman@linux.intel.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in usb_new_device/usb_submit_urb
Message-ID: <20210603014354.GA1626048@rowland.harvard.edu>
References: <00000000000075c23d05c3d0d730@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000075c23d05c3d0d730@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 04:30:18PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7652dd2c USB: core: Check buffer length matches wLength fo..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=1712b99dd00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1206ee92dd3d988d
> dashboard link: https://syzkaller.appspot.com/bug?extid=7dbcd9ff34dc4ed45240
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b82e13d00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ac418dd00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7dbcd9ff34dc4ed45240@syzkaller.appspotmail.com
> 
> usb 1-1: config 0 interface 186 altsetting 4 has a duplicate endpoint with address 0x8, skipping
> usb 1-1: config 0 interface 166 has no altsetting 0
> usb 1-1: config 0 interface 186 has no altsetting 0
> ------------[ cut here ]------------
> usb 1-1: BOGUS control dir, pipe 80000280 doesn't match bRequestType 80
> WARNING: CPU: 1 PID: 2632 at drivers/usb/core/urb.c:410 usb_submit_urb+0x149d/0x18a0 drivers/usb/core/urb.c:410
> Modules linked in:
> CPU: 1 PID: 2632 Comm: kworker/1:2 Not tainted 5.13.0-rc2-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: usb_hub_wq hub_event
> RIP: 0010:usb_submit_urb+0x149d/0x18a0 drivers/usb/core/urb.c:410
> Code: 7c 24 40 e8 c5 1f b3 fd 48 8b 7c 24 40 e8 6b a6 1b ff 45 89 e8 44 89 f1 4c 89 e2 48 89 c6 48 c7 c7 80 0a 63 86 e8 15 ec fb 01 <0f> 0b e9 a5 ee ff ff e8 97 1f b3 fd 0f b6 1d db a7 34 05 31 ff 41
> RSP: 0018:ffffc90000207680 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: ffff8881182df058 RCX: 0000000000000000
> RDX: ffff888114871b40 RSI: ffffffff812a6033 RDI: fffff52000040ec2
> RBP: ffff88810cfffc80 R08: 0000000000000001 R09: 0000000000000000
> R10: ffffffff814b998b R11: 0000000000000000 R12: ffff88810cfff6b8
> R13: 0000000000000080 R14: 0000000080000280 R15: ffff88810e736f00
> FS:  0000000000000000(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f13a00114f0 CR3: 0000000108807000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  usb_start_wait_urb+0x101/0x4c0 drivers/usb/core/message.c:58
>  usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
>  usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
>  usb_get_string+0xa6/0x190 drivers/usb/core/message.c:837
>  usb_string_sub+0x35e/0x3d0 drivers/usb/core/message.c:883
>  usb_get_langid drivers/usb/core/message.c:913 [inline]
>  usb_string+0x1cc/0x540 drivers/usb/core/message.c:977
>  usb_cache_string+0x82/0x120 drivers/usb/core/message.c:1023
>  usb_enumerate_device drivers/usb/core/hub.c:2399 [inline]
>  usb_new_device+0x15b/0x7d0 drivers/usb/core/hub.c:2527
>  hub_port_connect drivers/usb/core/hub.c:5298 [inline]
>  hub_port_connect_change drivers/usb/core/hub.c:5438 [inline]
>  port_event drivers/usb/core/hub.c:5584 [inline]
>  hub_event+0x2357/0x4330 drivers/usb/core/hub.c:5666
>  process_one_work+0x98d/0x1580 kernel/workqueue.c:2275
>  worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
>  kthread+0x38c/0x460 kernel/kthread.c:313
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git 7652dd2c

Index: usb-devel/drivers/usb/core/message.c
===================================================================
--- usb-devel.orig/drivers/usb/core/message.c
+++ usb-devel/drivers/usb/core/message.c
@@ -832,6 +832,8 @@ static int usb_get_string(struct usb_dev
 	int i;
 	int result;
 
+	if (size <= 0)		/* No point in asking for no data */
+		return -EINVAL;
 	for (i = 0; i < 3; ++i) {
 		/* retry on length 0 or stall; some devices are flakey */
 		result = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F1C38E333
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 11:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbhEXJXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 05:23:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232313AbhEXJXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 05:23:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 424A76105A;
        Mon, 24 May 2021 09:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621848114;
        bh=WawpMoh5FiYrAkFdIPHHadctgGZLaNZxmVr/DgReqZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kGBL+/ZsqIHnfDFT+8i0qu4ID4C9dMc9WNHkwas5ox5JXb0x/dHTA+aIlTn6hMi9b
         Pt4Mcmz4RBHRpjQIyNkp9OUXwg0g5wTo3z0hOJcJjx/K2k4YeR3/G8bgBG96+ZHoAd
         j4mZMbuo3S0655vY2iGrA0lxAAh5yB2pw1U3+iEDVQ2fjAxBdwxcSgN9aY8T7qJAuZ
         3UoRho+DK9UrATKulwXNWkWVAgUcKppZWLJLddWBbMWwv+TrXaOjAt81Q/I/KFSr+Y
         Dx0++apqtVw2NlPHJZ9v9R+KvHYLIHukYL3Yp2zfK2Kae5gNJT9A89QDmW4k/aA7rm
         YCoZksA2eW1Gw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ll6mW-0001Az-1X; Mon, 24 May 2021 11:21:52 +0200
Date:   Mon, 24 May 2021 11:21:52 +0200
From:   Johan Hovold <johan@kernel.org>
To:     syzbot <syzbot+5d0b6bcdaaa6d1cb6ef3@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mathias.nyman@linux.intel.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in e2i_init/usb_submit_urb
Message-ID: <YKtwMB0bXhayVwt4@hovoldconsulting.com>
References: <000000000000f61b1905c30fd185@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f61b1905c30fd185@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 02:13:18AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    5cc59c41 USB: core: WARN if pipe direction != setup packet..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=17a30553d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1206ee92dd3d988d
> dashboard link: https://syzkaller.appspot.com/bug?extid=5d0b6bcdaaa6d1cb6ef3
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5d0b6bcdaaa6d1cb6ef3@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> usb 6-1: BOGUS control dir, pipe 80001d80 doesn't match bRequestType 2
> WARNING: CPU: 0 PID: 7 at drivers/usb/core/urb.c:410 usb_submit_urb+0x14aa/0x1830 drivers/usb/core/urb.c:410
> Modules linked in:
> CPU: 0 PID: 7 Comm: kworker/0:1 Not tainted 5.13.0-rc2-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: usb_hub_wq hub_event
> RIP: 0010:usb_submit_urb+0x14aa/0x1830 drivers/usb/core/urb.c:410
> Code: 84 4c 01 00 00 e8 a6 14 b3 fd 4c 89 f7 e8 4e a7 1b ff 45 89 e8 44 89 e1 48 89 ea 48 89 c6 48 c7 c7 c0 09 63 86 e8 18 f1 fb 01 <0f> 0b 49 8d 4f 5c 48 b8 00 00 00 00 00 fc ff df 48 89 ca 48 89 4c
> RSP: 0018:ffffc9000007eee0 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: ffff88811f21b058 RCX: 0000000000000000
> RDX: 0000000000040000 RSI: ffffffff812a6013 RDI: fffff5200000fdce
> RBP: ffff888100bf5e60 R08: 0000000000000001 R09: 0000000000000000
> R10: ffffffff814b996b R11: 0000000000000000 R12: 0000000080001d80
> R13: 0000000000000002 R14: ffff88811f21b0a8 R15: ffff88813b0c7800
> FS:  0000000000000000(0000) GS:ffff8881f6800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000014a53ad CR3: 0000000007825000 CR4: 00000000001506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  usb_start_wait_urb+0x101/0x4c0 drivers/usb/core/message.c:58
>  usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
>  usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
>  e2i_init+0xb3/0x150 drivers/input/touchscreen/usbtouchscreen.c:254
>  usbtouch_probe+0xfc9/0x1c40 drivers/input/touchscreen/usbtouchscreen.c:1771

Had already found but not yet posted the fix for this one too:

	https://lore.kernel.org/r/20210524092048.4443-1-johan@kernel.org

Johan

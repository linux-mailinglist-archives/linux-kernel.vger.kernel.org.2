Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5581138E324
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 11:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbhEXJUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 05:20:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232313AbhEXJUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 05:20:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35D4E60FE7;
        Mon, 24 May 2021 09:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621847920;
        bh=QZZuYuabuZoguMnXlE2ZIV5i/TTO4S7OstS7Ab/34r8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fOuoVaiFhdHm0tq88Jfv4P3/qcT3/fRY9FrNvZDM+TklKGZAhIFa1aOCWPBvlQAv5
         vX1k88IAU+p1vxD88TAOey9zYMPXD9qyaWHiFJ5YZheKSGVTdqQGbobrkldpBg9Htx
         6LNfotsQTAxkTtNT7jf592LWmDOpisM6O9xqjyLeHTkkm0Jk1xbwLEzFAzfJttnH7b
         hgszqczCgjfrGS7nRnhyBIX/3LRy2tievA1+tVtw/xWjkVt0zkBnU4QrLOJkRGIL/S
         OKAnstXrLSVLyXimY0B2tLVpDt4s820emUh+wxZuS/gt9+BjtVFiV6WIvkCMCXoI/F
         I3FlPh55dlATQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ll6jN-00018O-Rb; Mon, 24 May 2021 11:18:37 +0200
Date:   Mon, 24 May 2021 11:18:37 +0200
From:   Johan Hovold <johan@kernel.org>
To:     syzbot <syzbot+19acce48d8344df49b3a@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mathias.nyman@linux.intel.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in qt2_attach/usb_submit_urb
Message-ID: <YKtvbeGYrceXVFAT@hovoldconsulting.com>
References: <000000000000d449f105c30fce00@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d449f105c30fce00@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 02:12:25AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    5cc59c41 USB: core: WARN if pipe direction != setup packet..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=12dabf53d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1206ee92dd3d988d
> dashboard link: https://syzkaller.appspot.com/bug?extid=19acce48d8344df49b3a
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1198ed07d00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1772f1ddd00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+19acce48d8344df49b3a@syzkaller.appspotmail.com
> 
> usb 1-1: string descriptor 0 read error: -22
> usb 1-1: New USB device found, idVendor=061d, idProduct=c170, bcdDevice=11.41
> usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> quatech2 1-1:31.224: Quatech 2nd gen USB to Serial Driver converter detected
> ------------[ cut here ]------------
> usb 1-1: BOGUS control dir, pipe 80000280 doesn't match bRequestType 40
> WARNING: CPU: 1 PID: 2635 at drivers/usb/core/urb.c:410 usb_submit_urb+0x14aa/0x1830 drivers/usb/core/urb.c:410
> Modules linked in:
> CPU: 1 PID: 2635 Comm: kworker/1:2 Not tainted 5.13.0-rc2-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: usb_hub_wq hub_event
> RIP: 0010:usb_submit_urb+0x14aa/0x1830 drivers/usb/core/urb.c:410
> Code: 84 4c 01 00 00 e8 a6 14 b3 fd 4c 89 f7 e8 4e a7 1b ff 45 89 e8 44 89 e1 48 89 ea 48 89 c6 48 c7 c7 c0 09 63 86 e8 18 f1 fb 01 <0f> 0b 49 8d 4f 5c 48 b8 00 00 00 00 00 fc ff df 48 89 ca 48 89 4c
> RSP: 0018:ffffc900001b6e08 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: ffff888116d8c058 RCX: 0000000000000000
> RDX: ffff888114e61b40 RSI: ffffffff812a6013 RDI: fffff52000036db3
> RBP: ffff888109d7e690 R08: 0000000000000001 R09: 0000000000000000
> R10: ffffffff814b996b R11: 0000000000000000 R12: 0000000080000280
> R13: 0000000000000040 R14: ffff888116d8c0a8 R15: ffff8881097ac900
> FS:  0000000000000000(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055777d5bd160 CR3: 00000001045ec000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  usb_start_wait_urb+0x101/0x4c0 drivers/usb/core/message.c:58
>  usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
>  usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
>  qt2_attach+0x82/0x550 drivers/usb/serial/quatech2.c:642

I had already found this one but not yet posted the v2. Should be fixed
here:

	https://lore.kernel.org/r/20210524091705.4282-1-johan@kernel.org

Johan

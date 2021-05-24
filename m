Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5228338E51A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 13:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbhEXLMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 07:12:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232516AbhEXLMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 07:12:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67DF761002;
        Mon, 24 May 2021 11:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621854647;
        bh=+wNAuKcSZLpxSyWjfXeBPy2IpVL5TAujEjVRvy0XGIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qCPLN9TQLAcKa2RtQjuQbDznaZNWyoDDRCDPNYgk9bn9SC6moBtbTrcimwh8mhQ0l
         vPjla1QbFV4hXlwv6T05EIxyoLEGTODVpwRO62rgq0PkdbHVTqM8/N9rsflB5ducfG
         v7HgxcCFS8ku2ODYFS7gYz4CPSG3tzQZP6pe2AfObd7/AFzEV/MOhiojtFU5K1wOmK
         /aJnD2rBDoOkUyKBZKXQX+V5Y7s00hDxrLfWtBu3KenpgqfdyXZwxL+vYJNKi6z14e
         R85aNdxcjxQp2H/M73GRIHYsvJKgMkG0mGuCJ/CNSjKR2YIYXaLw1R4GFT7ZrHChVN
         TplsQiZXW5TQg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ll8Tt-0006Qc-EH; Mon, 24 May 2021 13:10:45 +0200
Date:   Mon, 24 May 2021 13:10:45 +0200
From:   Johan Hovold <johan@kernel.org>
To:     syzbot <syzbot+faf11bbadc5a372564da@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mathias.nyman@linux.intel.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in rtl28xxu_ctrl_msg/usb_submit_urb
Message-ID: <YKuJtRBtSpAmcX49@hovoldconsulting.com>
References: <000000000000f96caf05c30fd10f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f96caf05c30fd10f@google.com>
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
> console output: https://syzkaller.appspot.com/x/log.txt?x=12a839d1d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1206ee92dd3d988d
> dashboard link: https://syzkaller.appspot.com/bug?extid=faf11bbadc5a372564da
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+faf11bbadc5a372564da@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> usb 1-1: BOGUS control dir, pipe 80004380 doesn't match bRequestType c0
> WARNING: CPU: 1 PID: 17 at drivers/usb/core/urb.c:410 usb_submit_urb+0x14aa/0x1830 drivers/usb/core/urb.c:410
> Modules linked in:
> CPU: 1 PID: 17 Comm: kworker/1:0 Not tainted 5.13.0-rc2-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: usb_hub_wq hub_event
> RIP: 0010:usb_submit_urb+0x14aa/0x1830 drivers/usb/core/urb.c:410
> Code: 84 4c 01 00 00 e8 a6 14 b3 fd 4c 89 f7 e8 4e a7 1b ff 45 89 e8 44 89 e1 48 89 ea 48 89 c6 48 c7 c7 c0 09 63 86 e8 18 f1 fb 01 <0f> 0b 49 8d 4f 5c 48 b8 00 00 00 00 00 fc ff df 48 89 ca 48 89 4c
> RSP: 0018:ffffc9000012ed50 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: ffff8881130d8058 RCX: 0000000000000000
> RDX: 0000000000040000 RSI: ffffffff812a6013 RDI: fffff52000025d9c
> RBP: ffff8881039b28c0 R08: 0000000000000001 R09: 0000000000000000
> R10: ffffffff814b996b R11: 0000000000000000 R12: 0000000080004380
> R13: 00000000000000c0 R14: ffff8881130d80a8 R15: ffff88813d761500
> FS:  0000000000000000(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000002f52b38 CR3: 000000013d74a000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  usb_start_wait_urb+0x101/0x4c0 drivers/usb/core/message.c:58
>  usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
>  usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
>  rtl28xxu_ctrl_msg+0x4b7/0x700 drivers/media/usb/dvb-usb-v2/rtl28xxu.c:43
>  rtl28xxu_identify_state+0xb6/0x320 drivers/media/usb/dvb-usb-v2/rtl28xxu.c:624
>  dvb_usbv2_probe+0x55b/0x7d0 drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:947

Should be fixed by

	https://lore.kernel.org/r/20210524110920.24599-4-johan@kernel.org

Johan

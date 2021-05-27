Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091CB39298F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 10:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbhE0IaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 04:30:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235207AbhE0I36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 04:29:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1C68611CD;
        Thu, 27 May 2021 08:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622104105;
        bh=Ta3ax0ef8yphtHWSJYKBLN4MXmtoXrolhD9l4/owgG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n8nwp8zqH9ebhXGKhK39yNWAY0SrrWLYisoeUBBSDjVwSzi7yBfjXyqg4cdtxvTT2
         n80L/Pd0alpBT0MRGNjEDdOSVZn85PjqEnq12CVyxlxqXUJdYcbrQCCdNEc8SiSMHp
         ZvHiOy+A1kZgJ7CiXfuiBN34D4P9JCgZtqLffLKK/gGFLW9cmP0e5Lj+T/VXsNkuwD
         zoP6NlEjmz0uFDmyIGK+7zuFiB7TGbbVc1TXL0N+2x0HpNTH09iwcxqj0k1KoaZkBt
         L2jf+o81AKrsaKNF8s6EmoQuiuWod86sbwx7MvlASYjukRWOZaode3ogXdvX59JnFi
         7wD9i0DRPbqNQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lmBNP-0000GU-2w; Thu, 27 May 2021 10:28:23 +0200
Date:   Thu, 27 May 2021 10:28:23 +0200
From:   Johan Hovold <johan@kernel.org>
To:     syzbot <syzbot+b0b89cff78d7b7bd0278@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mathias.nyman@linux.intel.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in dtv5100_probe/usb_submit_urb
Message-ID: <YK9YJ0TPTn7tf31l@hovoldconsulting.com>
References: <0000000000008845ab05c34019a7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000008845ab05c34019a7@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 11:49:17AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    5cc59c41 USB: core: WARN if pipe direction != setup packet..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=16742b9bd00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1206ee92dd3d988d
> dashboard link: https://syzkaller.appspot.com/bug?extid=b0b89cff78d7b7bd0278
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11911887d00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16afabd7d00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b0b89cff78d7b7bd0278@syzkaller.appspotmail.com
> 
> usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> usb 1-1: Product: syz
> usb 1-1: Manufacturer: syz
> usb 1-1: SerialNumber: syz
> usb 1-1: config 0 descriptor??
> ------------[ cut here ]------------
> usb 1-1: BOGUS control dir, pipe 80000280 doesn't match bRequestType 40
> WARNING: CPU: 0 PID: 7 at drivers/usb/core/urb.c:410 usb_submit_urb+0x14aa/0x1830 drivers/usb/core/urb.c:410
> Modules linked in:
> CPU: 0 PID: 7 Comm: kworker/0:1 Not tainted 5.13.0-rc2-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: usb_hub_wq hub_event
> RIP: 0010:usb_submit_urb+0x14aa/0x1830 drivers/usb/core/urb.c:410
> Code: 84 4c 01 00 00 e8 a6 14 b3 fd 4c 89 f7 e8 4e a7 1b ff 45 89 e8 44 89 e1 48 89 ea 48 89 c6 48 c7 c7 c0 09 63 86 e8 18 f1 fb 01 <0f> 0b 49 8d 4f 5c 48 b8 00 00 00 00 00 fc ff df 48 89 ca 48 89 4c
> RSP: 0018:ffffc9000007ef48 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: ffff888118a67058 RCX: 0000000000000000
> RDX: ffff888100283680 RSI: ffffffff812a6013 RDI: fffff5200000fddb
> RBP: ffff88810f661118 R08: 0000000000000001 R09: 0000000000000000
> R10: ffffffff814b996b R11: 0000000000000000 R12: 0000000080000280
> R13: 0000000000000040 R14: ffff888118a670a8 R15: ffff888108f99d00
> FS:  0000000000000000(0000) GS:ffff8881f6800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f1967249008 CR3: 00000001104a3000 CR4: 00000000001506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  usb_start_wait_urb+0x101/0x4c0 drivers/usb/core/message.c:58
>  usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
>  usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
>  dtv5100_probe+0x184/0x2b0 drivers/media/usb/dvb-usb/dtv5100.c:144

Should be fixed by

	https://lore.kernel.org/r/20210521132839.17163-2-johan@kernel.org

Johan

#syz fix: media: dtv5100: fix control-request directions

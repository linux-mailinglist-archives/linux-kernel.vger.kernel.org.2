Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F691371EE8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 19:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbhECRyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 13:54:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231285AbhECRyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 13:54:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED87D61244;
        Mon,  3 May 2021 17:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1620064432;
        bh=WCD9ljWpCaCSXxxPCipeE4bfikSypFP5Od1Bb5asHxI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g2qRS7MLAyut5TZCDPt37qijlo6ZlbyOwIhHCOiybXOl0bAA1m+HS1P38m3YYMIjM
         LsFAVWyKgusOI06RiFekT1G4siui/+IMdO4McwXnGrWUAIuhJof5iJrEmjM/5JtbsM
         yEm/4rpdATKzIDrAHzIBpQ+g2E3lf4r0EJzFzav8=
Date:   Mon, 3 May 2021 10:53:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+882a85c0c8ec4a3e2281@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: Re: [syzbot] WARNING in do_proc_bulk
Message-Id: <20210503105351.0966275d0d9e001ed794de2c@linux-foundation.org>
In-Reply-To: <00000000000000186405c16a6156@google.com>
References: <000000000000b47bc805c15e4b11@google.com>
        <00000000000000186405c16a6156@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cc usb peeps)

On Mon, 03 May 2021 03:25:21 -0700 syzbot <syzbot+882a85c0c8ec4a3e2281@syzkaller.appspotmail.com> wrote:

> syzbot has found a reproducer for the following issue on:

Thanks.

> HEAD commit:    d2b6f8a1 Merge tag 'xfs-5.13-merge-3' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1746d3e1d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=65c207250bba4efe
> dashboard link: https://syzkaller.appspot.com/bug?extid=882a85c0c8ec4a3e2281
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107f7893d00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ae7ca5d00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+882a85c0c8ec4a3e2281@syzkaller.appspotmail.com
> 
> usb usb9: usbfs: process 8586 (syz-executor862) did not claim interface 0 before use
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 8586 at mm/page_alloc.c:4985 __alloc_pages_nodemask+0x5fd/0x730 mm/page_alloc.c:5020
> Modules linked in:
> CPU: 0 PID: 8586 Comm: syz-executor862 Not tainted 5.12.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:__alloc_pages_nodemask+0x5fd/0x730 mm/page_alloc.c:4985
> Code: 00 00 0c 00 0f 85 a7 00 00 00 8b 3c 24 4c 89 f2 44 89 e6 c6 44 24 70 00 48 89 6c 24 58 e8 9b d7 ff ff 49 89 c5 e9 e5 fc ff ff <0f> 0b e9 b0 fd ff ff 89 74 24 14 4c 89 4c 24 08 4c 89 74 24 18 e8
> RSP: 0018:ffffc90001f57a30 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 1ffff920003eaf4a RCX: 0000000000000000
> RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000040cc0
> RBP: 0000000000040cc0 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffffff81b51b41 R11: 0000000000000000 R12: 000000000000000b
> R13: 000000000000000b R14: 0000000000000000 R15: 0000000000554e47
> FS:  0000000002293300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fd2526f7008 CR3: 000000001d80b000 CR4: 00000000001506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  alloc_pages_current+0x18c/0x2a0 mm/mempolicy.c:2277
>  alloc_pages include/linux/gfp.h:561 [inline]
>  kmalloc_order+0x34/0xf0 mm/slab_common.c:906
>  kmalloc_order_trace+0x14/0x130 mm/slab_common.c:922
>  kmalloc include/linux/slab.h:561 [inline]
>  do_proc_bulk+0x2d4/0x750 drivers/usb/core/devio.c:1221
>  proc_bulk drivers/usb/core/devio.c:1268 [inline]
>  usbdev_do_ioctl drivers/usb/core/devio.c:2542 [inline]
>  usbdev_ioctl+0x586/0x36c0 drivers/usb/core/devio.c:2708
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:1069 [inline]
>  __se_sys_ioctl fs/ioctl.c:1055 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:1055
>  do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
>  entry_SYSCALL_64_after_hwframe+0x44/0xae

do_proc_bulk() is asking kmalloc for more than MAX_ORDER bytes, in

	tbuf = kmalloc(len1, GFP_KERNEL);


> RIP: 0033:0x4450c9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00000000005cfd98 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004450c9
> RDX: 0000000020000240 RSI: 00000000c0185502 RDI: 0000000000000004
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000005 R11: 0000000000000246 R12: 00000000005cfdcc
> R13: 00000000005cfe00 R14: 00000000005cfde0 R15: 0000000000000005

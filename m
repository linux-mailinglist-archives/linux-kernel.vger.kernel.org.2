Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7873713AF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 12:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbhECKeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 06:34:24 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:49705 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbhECKeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 06:34:23 -0400
Received: by mail-il1-f197.google.com with SMTP id a6-20020a056e021206b02901a532cdf439so2771744ilq.16
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 03:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=SttgBc2FxKngWImPEhO0cBWiApFwkiW/HmblDMr1uYc=;
        b=lZnoppnpgOWAnjJtDpzgkafVKLGf7wXggOH2w9S59trStP68M2f4WtNmqy82Ju6E+g
         V3RNK0JiyglgfYAr5vKG8jyOprKfMZjl33SePQVv/ZxjW1ieshDxMlfNJuCGAFG4bXm0
         tqVU3xS/a2wQm6Rb+7Jc8ylJ+mUCn/h6EOwdTW+Qs4Cy33lCWdd8WLHW2BtbD1TVh9eu
         OFJOwFnYMW0hDZzLNeCjs2szRIu6LaBxEKazRhcbo2Mkp9/IxImGAOtc6RazjQdyICdZ
         kN1VH3JpIOpTbnP9zse4iosb5BpNCL2prBDmmTOeuoTwYA9hc9EhYxCOP5apObsu0YPo
         paUg==
X-Gm-Message-State: AOAM533dPBdsY+5DUCZeaxrfLKIbTFlShI4q/NwkQVFkj/0xf8BIqrk5
        gV/RFBgmCoj+s+pyAbz4OAGx/wH/sNOTxiCBYMrcDup/524t
X-Google-Smtp-Source: ABdhPJwFqecEhAhWGznZwDwQmNnjee1mj42lvh43tr7mER7HXjEhh8pMEMXM9nucMASKRbUBaJM5v2B6QSt+d3EhIA4+ujqMjDkm
MIME-Version: 1.0
X-Received: by 2002:a92:de4c:: with SMTP id e12mr10382711ilr.178.1620037521641;
 Mon, 03 May 2021 03:25:21 -0700 (PDT)
Date:   Mon, 03 May 2021 03:25:21 -0700
In-Reply-To: <000000000000b47bc805c15e4b11@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000000186405c16a6156@google.com>
Subject: Re: [syzbot] WARNING in do_proc_bulk
From:   syzbot <syzbot+882a85c0c8ec4a3e2281@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    d2b6f8a1 Merge tag 'xfs-5.13-merge-3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1746d3e1d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=65c207250bba4efe
dashboard link: https://syzkaller.appspot.com/bug?extid=882a85c0c8ec4a3e2281
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107f7893d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ae7ca5d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+882a85c0c8ec4a3e2281@syzkaller.appspotmail.com

usb usb9: usbfs: process 8586 (syz-executor862) did not claim interface 0 before use
------------[ cut here ]------------
WARNING: CPU: 1 PID: 8586 at mm/page_alloc.c:4985 __alloc_pages_nodemask+0x5fd/0x730 mm/page_alloc.c:5020
Modules linked in:
CPU: 0 PID: 8586 Comm: syz-executor862 Not tainted 5.12.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__alloc_pages_nodemask+0x5fd/0x730 mm/page_alloc.c:4985
Code: 00 00 0c 00 0f 85 a7 00 00 00 8b 3c 24 4c 89 f2 44 89 e6 c6 44 24 70 00 48 89 6c 24 58 e8 9b d7 ff ff 49 89 c5 e9 e5 fc ff ff <0f> 0b e9 b0 fd ff ff 89 74 24 14 4c 89 4c 24 08 4c 89 74 24 18 e8
RSP: 0018:ffffc90001f57a30 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 1ffff920003eaf4a RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000040cc0
RBP: 0000000000040cc0 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff81b51b41 R11: 0000000000000000 R12: 000000000000000b
R13: 000000000000000b R14: 0000000000000000 R15: 0000000000554e47
FS:  0000000002293300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd2526f7008 CR3: 000000001d80b000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 alloc_pages_current+0x18c/0x2a0 mm/mempolicy.c:2277
 alloc_pages include/linux/gfp.h:561 [inline]
 kmalloc_order+0x34/0xf0 mm/slab_common.c:906
 kmalloc_order_trace+0x14/0x130 mm/slab_common.c:922
 kmalloc include/linux/slab.h:561 [inline]
 do_proc_bulk+0x2d4/0x750 drivers/usb/core/devio.c:1221
 proc_bulk drivers/usb/core/devio.c:1268 [inline]
 usbdev_do_ioctl drivers/usb/core/devio.c:2542 [inline]
 usbdev_ioctl+0x586/0x36c0 drivers/usb/core/devio.c:2708
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl fs/ioctl.c:1055 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:1055
 do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4450c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00000000005cfd98 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004450c9
RDX: 0000000020000240 RSI: 00000000c0185502 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000005 R11: 0000000000000246 R12: 00000000005cfdcc
R13: 00000000005cfe00 R14: 00000000005cfde0 R15: 0000000000000005


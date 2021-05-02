Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4515E370EF1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 22:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhEBUBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 16:01:19 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:39502 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbhEBUBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 16:01:17 -0400
Received: by mail-il1-f197.google.com with SMTP id v3-20020a056e0213c3b029016165a33c15so3182400ilj.6
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 13:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=7b1TAlO++AXTyymlo2OEVatIMKIwy8cF1aqpiGjAWlg=;
        b=CX9EF7t/02eDER7OZFV+6ebV7heyHSYb57pB3YuFYrA2b8WXCv9Lsf+xhKc1Od4FDi
         tLyYJXpzaJKkTUGbMF9D+ERxZD2d++bjJGT/gUe9Tnn8WSLI1PQgMa7A1Ucce7Uq2or5
         nb42fqeiiO62+K0URG34BVbVTdcJzZY1wnoKindCH2RoddlckYhCDASJGT8zL9v1NNVM
         gC5QSiuTfIgAx3zE+TjwFkrXTRFTzhoJ2CCDVNiFCzOtQCrAo7U8fiPw+1u6yjxK1YJS
         5ZeDH1+5KgTc32hjEpN1HS65ayVmcpIXJ/S66PZA5QIA4E6QF+PW4ltGK9tEvD+5dBn0
         Rl1Q==
X-Gm-Message-State: AOAM533YXV141c1UHUjvtgjvrjgTTrzg6W/IQ8AEnSJCRS+wbAXIrRvX
        9RzJPrzmeP4QaG0Fk0CjVgiAWs1cbCUlRBaEKr16AFSTqP4h
X-Google-Smtp-Source: ABdhPJxYMVCeaEuiMrunEx5DRURs2RLBd8r0YknSCqSwNE43Kms/cWjUqFZkRbwl/6mqgDpm15T1S10QE3JLIu/U/e4RGShk+UVk
MIME-Version: 1.0
X-Received: by 2002:a02:294e:: with SMTP id p75mr15159845jap.34.1619985624757;
 Sun, 02 May 2021 13:00:24 -0700 (PDT)
Date:   Sun, 02 May 2021 13:00:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b47bc805c15e4b11@google.com>
Subject: [syzbot] WARNING in do_proc_bulk
From:   syzbot <syzbot+882a85c0c8ec4a3e2281@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    acd3d285 Merge tag 'fixes-v5.13' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=123dd1e1d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7aff3234c75583fe
dashboard link: https://syzkaller.appspot.com/bug?extid=882a85c0c8ec4a3e2281

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+882a85c0c8ec4a3e2281@syzkaller.appspotmail.com

usb usb9: usbfs: process 9672 (syz-executor.4) did not claim interface 0 before use
------------[ cut here ]------------
WARNING: CPU: 0 PID: 9672 at mm/page_alloc.c:4985 __alloc_pages_nodemask+0x5fd/0x730 mm/page_alloc.c:5020
Modules linked in:
CPU: 0 PID: 9672 Comm: syz-executor.4 Not tainted 5.12.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__alloc_pages_nodemask+0x5fd/0x730 mm/page_alloc.c:4985
Code: 00 00 0c 00 0f 85 a7 00 00 00 8b 3c 24 4c 89 f2 44 89 e6 c6 44 24 70 00 48 89 6c 24 58 e8 9b d7 ff ff 49 89 c5 e9 e5 fc ff ff <0f> 0b e9 b0 fd ff ff 89 74 24 14 4c 89 4c 24 08 4c 89 74 24 18 e8
RSP: 0018:ffffc90007cdfa30 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 1ffff92000f9bf4a RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000040cc0
RBP: 0000000000040cc0 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff81b490c1 R11: 0000000000000000 R12: 000000000000000b
R13: 000000000000000b R14: 0000000000000000 R15: 0000000000554e47
FS:  00007fbaa62ba700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020005400 CR3: 00000000768f1000 CR4: 00000000001526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 alloc_pages_current+0x18c/0x2a0 mm/mempolicy.c:2277
 alloc_pages include/linux/gfp.h:561 [inline]
 kmalloc_order+0x34/0xf0 mm/slab_common.c:902
 kmalloc_order_trace+0x14/0x130 mm/slab_common.c:918
 kmalloc include/linux/slab.h:559 [inline]
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
RIP: 0033:0x4665f9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbaa62ba188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000056bf60 RCX: 00000000004665f9
RDX: 0000000020000240 RSI: 00000000c0185502 RDI: 0000000000000003
RBP: 00000000004bfce1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf60
R13: 0000000000a9fb1f R14: 00007fbaa62ba300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

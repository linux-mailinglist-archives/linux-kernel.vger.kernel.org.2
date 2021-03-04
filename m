Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03CBB32DB0A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 21:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238740AbhCDUR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 15:17:26 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:42979 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238428AbhCDUQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 15:16:54 -0500
Received: by mail-io1-f71.google.com with SMTP id q5so22835487iot.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 12:16:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=fpowfZgk8QgxLBNd0XywftjI4GcMpTYddLWckNN9y/U=;
        b=VfyQ8A1986TKg4K3ltzuDYeJDnqZhgzoTNlb0c66lScooA1uRhUmrVy7nH2ArwXWK9
         qO0Lpsq9jgbKydE9OLmPKd7l48LsHvdKrf5d5Z0xKLQCt9Y4n/KtRxoybKsO125gwRd9
         QUSl4g9aUdANSW3E6tULiUK2zkmgNr14c16w24WlvIZv+ThilsMErVms1u5udaN5IqxQ
         0RQOrK9pAp5X7V4wEYLZn3Y713fJacokK23N2AqAEK220R0QwUNH44fg47aDB04ByW5p
         50cwoatPB2Wr+zObHgGGoay+rohEu76R0GErvReOcJtAkdra2Rb0mGhieTYw3ku+xZ+p
         pT7Q==
X-Gm-Message-State: AOAM530L0gppfIh6eTjnO+q7+L1/FsylWf+YvGQ+f/+vStpQB5PuZnxd
        u/lmS0d6P8NjUVYpTc7Lv0EN84o/mlXjInuko7jv0s36dsIm
X-Google-Smtp-Source: ABdhPJx+9h4FUOG54SXJim3dO54ry8cierVwGu+fmo3ZQPmhTpMXdaWJxAH1h2Dp3d1IIOmyCRFZ/qdjXXWTbXaDntdV0PbZM3vG
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d85:: with SMTP id h5mr5662490ila.246.1614888973969;
 Thu, 04 Mar 2021 12:16:13 -0800 (PST)
Date:   Thu, 04 Mar 2021 12:16:13 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a52f4505bcbba35f@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in hide_cursor
From:   syzbot <syzbot+e28df1dcd2038f11d0f1@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5695e516 Merge tag 'io_uring-worker.v3-2021-02-25' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10bc7b96d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e33ab2de74f48295
dashboard link: https://syzkaller.appspot.com/bug?extid=e28df1dcd2038f11d0f1
compiler:       Debian clang version 11.0.1-2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145911b0d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16123ff2d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e28df1dcd2038f11d0f1@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 12e8c067 P4D 12e8c067 PUD 242de067 PMD 0 
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8335 Comm: syz-executor258 Not tainted 5.11.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffffc9000dcf7aa8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffffff8a151c78 RCX: 0000000000000007
RDX: 0000000000000002 RSI: ffff888143df0000 RDI: ffff888010879000
RBP: dffffc0000000000 R08: 0000000000000000 R09: ffffffff84048b55
R10: 0000000000000002 R11: ffff88801b115340 R12: dffffc0000000000
R13: 1ffff1100210f27c R14: ffff8880108793e0 R15: ffff888010879000
FS:  0000000000e5a300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000011d74000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 hide_cursor+0x7e/0x310 drivers/tty/vt/vt.c:907
 redraw_screen+0x190/0x11a0 drivers/tty/vt/vt.c:1012
 vc_do_resize+0x1178/0x1780 drivers/tty/vt/vt.c:1325
 fbcon_set_disp+0x9f2/0xf90 drivers/video/fbdev/core/fbcon.c:1402
 con2fb_init_display drivers/video/fbdev/core/fbcon.c:808 [inline]
 set_con2fb_map+0x7f6/0xe90 drivers/video/fbdev/core/fbcon.c:879
 fbcon_set_con2fb_map_ioctl+0x19e/0x280 drivers/video/fbdev/core/fbcon.c:3010
 do_fb_ioctl+0x307/0x6e0 drivers/video/fbdev/core/fbmem.c:1156
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x43eed9
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd3f7a18c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000400488 RCX: 000000000043eed9
RDX: 0000000020000040 RSI: 0000000000004610 RDI: 0000000000000004
RBP: 0000000000402ec0 R08: 0000000000400488 R09: 0000000000400488
R10: 0000000000400488 R11: 0000000000000246 R12: 0000000000402f50
R13: 0000000000000000 R14: 00000000004ac018 R15: 0000000000400488
Modules linked in:
CR2: 0000000000000000
---[ end trace 867c96c33860cda9 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffffc9000dcf7aa8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffffff8a151c78 RCX: 0000000000000007
RDX: 0000000000000002 RSI: ffff888143df0000 RDI: ffff888010879000
RBP: dffffc0000000000 R08: 0000000000000000 R09: ffffffff84048b55
R10: 0000000000000002 R11: ffff88801b115340 R12: dffffc0000000000
R13: 1ffff1100210f27c R14: ffff8880108793e0 R15: ffff888010879000
FS:  0000000000e5a300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000011d74000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

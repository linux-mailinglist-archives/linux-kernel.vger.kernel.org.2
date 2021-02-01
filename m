Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54AE30A409
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 10:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbhBAJHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 04:07:17 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:34444 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbhBAJGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 04:06:54 -0500
Received: by mail-il1-f200.google.com with SMTP id c16so13087231ile.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 01:06:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mbfU0loJSrsGm4ob8JlYJmfpgYS4yHJcq/AGDfiyY6g=;
        b=OghCDFvh1/pHk5mhMoCRYyws/GAL0mpkhM1CqSg+xLGYjgWZkH73KzALlfQQp0HELl
         F/cKYmZuT79AXBNA2d7vDkxX6Qn0g2ayYmj0BVt5+rHKeN+cHlxlQGStxUnvw7dGSr+r
         PPBxiTLdj49RSR/NdPOgnMiPV3tCaALOF8vK5zsCHb0kzAuUgYCrElV5dtUYB86pwQM6
         DbSqZgUyStz69KEyLcG6ZQHL/Hp8GHNEjOcm8dkzrsJqzNPYazrBo9+rJr0y1kZlZ92F
         aIfAjyHe6R+IQA6b7+jiNvICVV5Dfh0SUvoC4NQySz1bstopT+KlkzXxnWJei/68dY79
         3SKA==
X-Gm-Message-State: AOAM532NGAFaji3j75Jo7817melA3mqJfSDiNxaGtUIm6Hcw/cGlcgdf
        yc1g0o5w8KGQKnyhQnQB8oDPM1NmSLONM7gnY58luHDus3oY
X-Google-Smtp-Source: ABdhPJyZ9vfniUDe8bHzVizHJCik6zSNQLvIKY6KhJaOyfD3DwJ2PxLvJor/uw8vv88zUHcZUdggt+togxCASb4Bk3rCWYCEVKGz
MIME-Version: 1.0
X-Received: by 2002:a92:a010:: with SMTP id e16mr12074820ili.62.1612170373006;
 Mon, 01 Feb 2021 01:06:13 -0800 (PST)
Date:   Mon, 01 Feb 2021 01:06:12 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006689ee05ba42aa3d@google.com>
Subject: WARNING: suspicious RCU usage in kernfs_iop_permission
From:   syzbot <syzbot+0e507d08417ca2d565bf@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, mszeredi@redhat.com,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6642d600 Merge tag '5.11-rc5-smb3' of git://git.samba.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=171405bf500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9408d1770a50819c
dashboard link: https://syzkaller.appspot.com/bug?extid=0e507d08417ca2d565bf
compiler:       clang version 11.0.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b8a330d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f3628cd00000

The issue was bisected to:

commit 89bdfaf93d9157499c3a0d61f489df66f2dead7f
Author: Miklos Szeredi <mszeredi@redhat.com>
Date:   Mon Dec 14 14:26:14 2020 +0000

    ovl: make ioctl() safe

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11b85fb4d00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13b85fb4d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=15b85fb4d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0e507d08417ca2d565bf@syzkaller.appspotmail.com
Fixes: 89bdfaf93d91 ("ovl: make ioctl() safe")

=============================
WARNING: suspicious RCU usage
5.11.0-rc5-syzkaller #0 Not tainted
-----------------------------
kernel/sched/core.c:7932 Illegal context switch in RCU-sched read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 0
no locks held by systemd/1.

stack backtrace:
CPU: 0 PID: 1 Comm: systemd Not tainted 5.11.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x137/0x1be lib/dump_stack.c:120
 ___might_sleep+0xb4/0x530 kernel/sched/core.c:7932
 __mutex_lock_common+0x4e/0x2f00 kernel/locking/mutex.c:935
 __mutex_lock kernel/locking/mutex.c:1103 [inline]
 mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1118
 kernfs_iop_permission+0x66/0x2f0 fs/kernfs/inode.c:284
 do_inode_permission fs/namei.c:398 [inline]
 inode_permission+0x234/0x4a0 fs/namei.c:463
 may_lookup fs/namei.c:1575 [inline]
 link_path_walk+0x226/0xc10 fs/namei.c:2128
 path_openat+0x1f5/0x37a0 fs/namei.c:3367
 do_filp_open+0x191/0x3a0 fs/namei.c:3398
 do_sys_openat2+0xba/0x380 fs/open.c:1172
 do_sys_open fs/open.c:1188 [inline]
 __do_sys_open fs/open.c:1196 [inline]
 __se_sys_open fs/open.c:1192 [inline]
 __x64_sys_open+0x1af/0x1e0 fs/open.c:1192
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fdaf5f1370d
Code: 30 2c 00 00 75 10 b8 02 00 00 00 0f 05 48 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 fe 9d 01 00 48 89 04 24 b8 02 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 47 9e 01 00 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffedccb56f0 EFLAGS: 00000293 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 000055b998e80590 RCX: 00007fdaf5f1370d
RDX: 00000000000001b6 RSI: 0000000000080000 RDI: 00007ffedccb57d0
RBP: 0000000000000008 R08: 0000000000000008 R09: 0000000000000001
R10: 0000000000080000 R11: 0000000000000293 R12: 00007fdaf764d7b4
R13: 0000000000000001 R14: 000055b998d5ad60 R15: 00007ffedccb57d0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

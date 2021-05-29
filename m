Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D856394AC6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 08:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhE2Gez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 02:34:55 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:47747 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhE2Gev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 02:34:51 -0400
Received: by mail-il1-f197.google.com with SMTP id c2-20020a92d3c20000b02901d9fda18626so489259ilh.14
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 23:33:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=WVZJnUAlwP86+Nc2TtM74BnEHSWsh0nAvTld31Kj4iY=;
        b=lAizSCmpn+V5JpYJT6GRmo9bG4Qkq3kUuRg3AE6B7u9RvUNYbpCsMo2gfdr1dYsnw2
         V9ERmsYf75UUpTBvK12CgYgzlXq/mVb0pdECNuUefTgd1yR8BK8PLx7sY8eD4XJRo5uc
         sAPHPbCWz3WmYG31OLSHimBw/2+4EoYctHEFjmH1ZiKI2lEU6TysGtLakIzi9tUO/kNm
         5Vq7LoxOmN30eH7yq+rOclZwQN884aXAChKFBjtAnSMDuFm9uQrRRaUI68p5TpLEUShr
         8zp3Emwe4sUTppz6GHOWf9791UuB6SStSwbVVz6bcjANvC5RIhybqBmSSLiqoUmdhK/t
         jbuA==
X-Gm-Message-State: AOAM531jDDpz6Q9zzeeDrbAJQj+F/eZNzMzc8eyQVzRs76rEuYNoTFma
        xZuJh2B/6qpgFPRZXnO7CDKG2n0GMZ29co1OHyBeqIS+Vbz/
X-Google-Smtp-Source: ABdhPJw++tRyQiRWMdyRmN9o4KBOqsTN6FIaKBk1ra3mhsuocGLdBPThKTuJzUNtPyXwqwW4EGJx3vsq/wWzW5K9kHvA/7Jxm233
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1650:: with SMTP id a16mr11802842jat.23.1622269995698;
 Fri, 28 May 2021 23:33:15 -0700 (PDT)
Date:   Fri, 28 May 2021 23:33:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d2cdff05c3722a6c@google.com>
Subject: [syzbot] memory leak in io_submit_sqes (3)
From:   syzbot <syzbot+189b24ff132397acb8fd@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    97e5bf60 Merge branch 'for-5.13-fixes' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a782d3d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8c23f7848d1c696
dashboard link: https://syzkaller.appspot.com/bug?extid=189b24ff132397acb8fd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122ff517d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12cf7cb7d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+189b24ff132397acb8fd@syzkaller.appspotmail.com

executing program
BUG: memory leak
unreferenced object 0xffff888117747500 (size 232):
  comm "syz-executor793", pid 8437, jiffies 4294941760 (age 14.380s)
  hex dump (first 32 bytes):
    00 a2 11 02 81 88 ff ff 18 4e 6f 16 81 88 ff ff  .........No.....
    38 20 00 40 00 00 00 00 00 00 00 00 00 00 00 00  8 .@............
  backtrace:
    [<ffffffff81613299>] io_alloc_req fs/io_uring.c:1707 [inline]
    [<ffffffff81613299>] io_submit_sqes+0x6c9/0x23b0 fs/io_uring.c:6721
    [<ffffffff81615798>] __do_sys_io_uring_enter+0x818/0xf50 fs/io_uring.c:9319
    [<ffffffff8435309a>] do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
    [<ffffffff84400068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff888117747400 (size 232):
  comm "syz-executor793", pid 8437, jiffies 4294941760 (age 14.380s)
  hex dump (first 32 bytes):
    00 a2 11 02 81 88 ff ff 18 4e 6f 16 81 88 ff ff  .........No.....
    38 20 00 40 00 00 00 00 00 00 00 00 00 00 00 00  8 .@............
  backtrace:
    [<ffffffff81613299>] io_alloc_req fs/io_uring.c:1707 [inline]
    [<ffffffff81613299>] io_submit_sqes+0x6c9/0x23b0 fs/io_uring.c:6721
    [<ffffffff81615798>] __do_sys_io_uring_enter+0x818/0xf50 fs/io_uring.c:9319
    [<ffffffff8435309a>] do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
    [<ffffffff84400068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff888117747300 (size 232):
  comm "syz-executor793", pid 8437, jiffies 4294941760 (age 14.380s)
  hex dump (first 32 bytes):
    00 a2 11 02 81 88 ff ff 18 4e 6f 16 81 88 ff ff  .........No.....
    38 20 00 40 00 00 00 00 00 00 00 00 00 00 00 00  8 .@............
  backtrace:
    [<ffffffff81613299>] io_alloc_req fs/io_uring.c:1707 [inline]
    [<ffffffff81613299>] io_submit_sqes+0x6c9/0x23b0 fs/io_uring.c:6721
    [<ffffffff81615798>] __do_sys_io_uring_enter+0x818/0xf50 fs/io_uring.c:9319
    [<ffffffff8435309a>] do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
    [<ffffffff84400068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff888117747200 (size 232):
  comm "syz-executor793", pid 8437, jiffies 4294941760 (age 14.380s)
  hex dump (first 32 bytes):
    00 a2 11 02 81 88 ff ff 18 4e 6f 16 81 88 ff ff  .........No.....
    38 20 00 40 00 00 00 00 00 00 00 00 00 00 00 00  8 .@............
  backtrace:
    [<ffffffff81613299>] io_alloc_req fs/io_uring.c:1707 [inline]
    [<ffffffff81613299>] io_submit_sqes+0x6c9/0x23b0 fs/io_uring.c:6721
    [<ffffffff81615798>] __do_sys_io_uring_enter+0x818/0xf50 fs/io_uring.c:9319
    [<ffffffff8435309a>] do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
    [<ffffffff84400068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff888117747100 (size 232):
  comm "syz-executor793", pid 8437, jiffies 4294941760 (age 14.380s)
  hex dump (first 32 bytes):
    00 a2 11 02 81 88 ff ff 18 4e 6f 16 81 88 ff ff  .........No.....
    38 20 00 40 00 00 00 00 00 00 00 00 00 00 00 00  8 .@............
  backtrace:
    [<ffffffff81613299>] io_alloc_req fs/io_uring.c:1707 [inline]
    [<ffffffff81613299>] io_submit_sqes+0x6c9/0x23b0 fs/io_uring.c:6721
    [<ffffffff81615798>] __do_sys_io_uring_enter+0x818/0xf50 fs/io_uring.c:9319
    [<ffffffff8435309a>] do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
    [<ffffffff84400068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88811774acc0 (size 64):
  comm "syz-executor793", pid 8437, jiffies 4294941760 (age 14.380s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 4e 6f 16 81 88 ff ff  .........No.....
    38 20 00 40 00 00 00 00 00 00 00 00 00 00 00 00  8 .@............
  backtrace:
    [<ffffffff81607a9a>] kmalloc include/linux/slab.h:556 [inline]
    [<ffffffff81607a9a>] __io_queue_proc+0x10a/0x1b0 fs/io_uring.c:5027
    [<ffffffff824b8aa6>] poll_wait include/linux/poll.h:51 [inline]
    [<ffffffff824b8aa6>] n_tty_poll+0x76/0x3a0 drivers/tty/n_tty.c:2429
    [<ffffffff824b3319>] tty_poll+0x89/0xc0 drivers/tty/tty_io.c:2231
    [<ffffffff81600e79>] vfs_poll include/linux/poll.h:90 [inline]
    [<ffffffff81600e79>] __io_arm_poll_handler+0xb9/0x2b0 fs/io_uring.c:5118
    [<ffffffff81607137>] io_poll_add.constprop.0+0x47/0x180 fs/io_uring.c:5402
    [<ffffffff8160f6cf>] io_issue_sqe+0x19f/0x2880 fs/io_uring.c:6126
    [<ffffffff81611e4a>] __io_queue_sqe+0x9a/0x620 fs/io_uring.c:6414
    [<ffffffff81612a65>] io_queue_sqe+0x275/0x3e0 fs/io_uring.c:6463
    [<ffffffff81614bf8>] io_submit_sqe fs/io_uring.c:6626 [inline]
    [<ffffffff81614bf8>] io_submit_sqes+0x2028/0x23b0 fs/io_uring.c:6734
    [<ffffffff81615798>] __do_sys_io_uring_enter+0x818/0xf50 fs/io_uring.c:9319
    [<ffffffff8435309a>] do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
    [<ffffffff84400068>] entry_SYSCALL_64_after_hwframe+0x44/0xae



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9504533A923
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 01:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhCOAsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 20:48:23 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:39480 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhCOAsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 20:48:14 -0400
Received: by mail-io1-f69.google.com with SMTP id x6so20198560ioj.6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 17:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bqD7iz7X6hCcon73jEKrOWYI28xdRzhr2xr68GyzGlE=;
        b=dLm3X9J1cKjlN/1B0WlCFGRVAiLeTI9bEc236kSu6GKCbZ8paf/YFncq7Dcq7gNV/A
         KiUHB976sFwquV5A+C/RCXzEOokxGB3nbeopStTKMohSniG2zZNyodQtZ0U2CDAwVX+Q
         ez7sU/4xRYZ908wMMV4kPU3kSHgcZmebhj5VgICpKxI4hOcC5PuAT/17QEnaBgUIyTtg
         qw6gywEeWC2sBqFQNfUMeencMtqtGsn1REpWbV9Yp64S7pzV5pjkp2IuPpahJgryEnNq
         wrzUB2f/BgEMrSUkM+Q6T0qqEPt3U6OT/0hLu3vzeaWEBXneQTWBkNopjR3T+XkK0t71
         xmFQ==
X-Gm-Message-State: AOAM531gPrpLyJ0iXRQFEYq5crycnoohwqg27kX7ExB1hMCoGgl4Aow5
        ExPfX3JSDWLs6dI41siha79VlkvvBQjhV/rTuVcoE2VIH6qK
X-Google-Smtp-Source: ABdhPJyRKvFhMvgn/Oh+Qxwj1riE4hS0s5J/mpBEpQTSmF2PBtyqqrBfdnc7WAhIhRjMacBCGSlAOaFQ/b+MvWqtC70lEvaU9HL2
MIME-Version: 1.0
X-Received: by 2002:a92:ddd0:: with SMTP id d16mr10094931ilr.52.1615769293523;
 Sun, 14 Mar 2021 17:48:13 -0700 (PDT)
Date:   Sun, 14 Mar 2021 17:48:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7910505bd889abc@google.com>
Subject: [syzbot] memory leak in copy_process (2)
From:   syzbot <syzbot+44908bb56d2bfe56b28e@syzkaller.appspotmail.com>
To:     christian@brauner.io, ebiederm@xmission.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org, oleg@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    88fe4924 Merge tag 'char-misc-5.12-rc3' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10252462d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=815a716b5d0a8bdf
dashboard link: https://syzkaller.appspot.com/bug?extid=44908bb56d2bfe56b28e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14180dc6d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167cf68ad00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+44908bb56d2bfe56b28e@syzkaller.appspotmail.com

Warning: Permanently added '10.128.0.41' (ECDSA) to the list of known hosts.
executing program
executing program
BUG: memory leak
unreferenced object 0xffff888101b41d00 (size 120):
  comm "kworker/u4:0", pid 8, jiffies 4294944270 (age 12.780s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8125dc56>] alloc_pid+0x66/0x560 kernel/pid.c:180
    [<ffffffff81226405>] copy_process+0x1465/0x25e0 kernel/fork.c:2115
    [<ffffffff81227943>] kernel_clone+0xf3/0x670 kernel/fork.c:2493
    [<ffffffff812281a1>] kernel_thread+0x61/0x80 kernel/fork.c:2545
    [<ffffffff81253464>] call_usermodehelper_exec_work kernel/umh.c:172 [inline]
    [<ffffffff81253464>] call_usermodehelper_exec_work+0xc4/0x120 kernel/umh.c:158
    [<ffffffff812591c9>] process_one_work+0x2c9/0x600 kernel/workqueue.c:2275
    [<ffffffff81259ab9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2421
    [<ffffffff812611c8>] kthread+0x178/0x1b0 kernel/kthread.c:292
    [<ffffffff8100227f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

BUG: memory leak
unreferenced object 0xffff888110ef5c00 (size 232):
  comm "kworker/u4:0", pid 8414, jiffies 4294944270 (age 12.780s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    e0 b7 04 01 81 88 ff ff c0 56 ba 0f 81 88 ff ff  .........V......
  backtrace:
    [<ffffffff8154a0cf>] kmem_cache_zalloc include/linux/slab.h:674 [inline]
    [<ffffffff8154a0cf>] __alloc_file+0x1f/0xf0 fs/file_table.c:101
    [<ffffffff8154a809>] alloc_empty_file+0x69/0x120 fs/file_table.c:150
    [<ffffffff8154a8f3>] alloc_file+0x33/0x1b0 fs/file_table.c:192
    [<ffffffff8154ab22>] alloc_file_pseudo+0xb2/0x140 fs/file_table.c:232
    [<ffffffff81559218>] create_pipe_files+0x138/0x2e0 fs/pipe.c:911
    [<ffffffff8126c793>] umd_setup+0x33/0x220 kernel/usermode_driver.c:104
    [<ffffffff81253574>] call_usermodehelper_exec_async+0xb4/0x1b0 kernel/umh.c:101
    [<ffffffff8100227f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

BUG: memory leak
unreferenced object 0xffff888110cafc90 (size 24):
  comm "kworker/u4:0", pid 8414, jiffies 4294944270 (age 12.780s)
  hex dump (first 24 bytes):
    00 00 00 00 00 00 00 00 b0 0e 94 00 81 88 ff ff  ................
    00 00 00 00 00 00 00 00                          ........
  backtrace:
    [<ffffffff820e15ca>] kmem_cache_zalloc include/linux/slab.h:674 [inline]
    [<ffffffff820e15ca>] lsm_file_alloc security/security.c:569 [inline]
    [<ffffffff820e15ca>] security_file_alloc+0x2a/0xb0 security/security.c:1470
    [<ffffffff8154a10d>] __alloc_file+0x5d/0xf0 fs/file_table.c:106
    [<ffffffff8154a809>] alloc_empty_file+0x69/0x120 fs/file_table.c:150
    [<ffffffff8154a8f3>] alloc_file+0x33/0x1b0 fs/file_table.c:192
    [<ffffffff8154ab22>] alloc_file_pseudo+0xb2/0x140 fs/file_table.c:232
    [<ffffffff81559218>] create_pipe_files+0x138/0x2e0 fs/pipe.c:911
    [<ffffffff8126c793>] umd_setup+0x33/0x220 kernel/usermode_driver.c:104
    [<ffffffff81253574>] call_usermodehelper_exec_async+0xb4/0x1b0 kernel/umh.c:101
    [<ffffffff8100227f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

BUG: memory leak
unreferenced object 0xffff888110ef5e00 (size 232):
  comm "kworker/u4:0", pid 8414, jiffies 4294944270 (age 12.780s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    e0 b7 04 01 81 88 ff ff 00 59 ba 0f 81 88 ff ff  .........Y......
  backtrace:
    [<ffffffff8154a0cf>] kmem_cache_zalloc include/linux/slab.h:674 [inline]
    [<ffffffff8154a0cf>] __alloc_file+0x1f/0xf0 fs/file_table.c:101
    [<ffffffff8154a809>] alloc_empty_file+0x69/0x120 fs/file_table.c:150
    [<ffffffff8154a8f3>] alloc_file+0x33/0x1b0 fs/file_table.c:192
    [<ffffffff8154ac22>] alloc_file_clone+0x22/0x70 fs/file_table.c:244
    [<ffffffff81559262>] create_pipe_files+0x182/0x2e0 fs/pipe.c:922
    [<ffffffff8126c80d>] umd_setup+0xad/0x220 kernel/usermode_driver.c:115
    [<ffffffff81253574>] call_usermodehelper_exec_async+0xb4/0x1b0 kernel/umh.c:101
    [<ffffffff8100227f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

BUG: memory leak
unreferenced object 0xffff888110cafc18 (size 24):
  comm "kworker/u4:0", pid 8414, jiffies 4294944270 (age 12.780s)
  hex dump (first 24 bytes):
    00 00 00 00 00 00 00 00 b0 0e 94 00 81 88 ff ff  ................
    00 00 00 00 00 00 00 00                          ........
  backtrace:
    [<ffffffff820e15ca>] kmem_cache_zalloc include/linux/slab.h:674 [inline]
    [<ffffffff820e15ca>] lsm_file_alloc security/security.c:569 [inline]
    [<ffffffff820e15ca>] security_file_alloc+0x2a/0xb0 security/security.c:1470
    [<ffffffff8154a10d>] __alloc_file+0x5d/0xf0 fs/file_table.c:106
    [<ffffffff8154a809>] alloc_empty_file+0x69/0x120 fs/file_table.c:150
    [<ffffffff8154a8f3>] alloc_file+0x33/0x1b0 fs/file_table.c:192
    [<ffffffff8154ac22>] alloc_file_clone+0x22/0x70 fs/file_table.c:244
    [<ffffffff81559262>] create_pipe_files+0x182/0x2e0 fs/pipe.c:922
    [<ffffffff8126c80d>] umd_setup+0xad/0x220 kernel/usermode_driver.c:115
    [<ffffffff81253574>] call_usermodehelper_exec_async+0xb4/0x1b0 kernel/umh.c:101
    [<ffffffff8100227f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6B73EA609
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 15:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237755AbhHLNxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 09:53:46 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:42861 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbhHLNxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 09:53:43 -0400
Received: by mail-io1-f70.google.com with SMTP id y10-20020a5e870a0000b029058d2e067004so3477304ioj.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 06:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=NHD5PuVjimqiuByepyLI1iYdpcKAnKHFp093aOhp+fc=;
        b=Bj2naWXyiciF1+8G8qFm2+WV2Zcn8C3MnIVivByG3+ulbXMTGQZFrQ2vFSCPYpwydj
         vWQWQP68/mmOXtkJsy/KF1PaGEQu0C+zQme7VTDPZvQEIpEaAhi1aKX3LhAHxwO8wK5b
         0xPlWsGvGVgVJl+vtA5VYGOStuOp951SKO0YScVtGuIAkzTTTMPqsUUInOifWaSfLq9f
         G4Ficy+dqH/ZkprB2dreyVeGiYQcosrWghrRdQLQa8Z29k93Agpzj+tpeQA51A8duHWi
         a4jrKM9aT6Wnn1sv69ShngWeVZJnNTD8/dBDvhrgP9SvszTUHbAmnUY5dhh0hvYe689p
         ljaA==
X-Gm-Message-State: AOAM532U5nKB0TglS2RoupcsxIunbHy/JX3PSyZ37bykxqz8hT5EhbIG
        U2qb284btA0C9QUPTzoVrModa8NbQQxoYcUShZpA7lSGVwen
X-Google-Smtp-Source: ABdhPJx36dk15xIOglreLdknX9VSaCmfKbYSSAGlkETSNaqlt6hbhu0XHLE6tPr9u8iJoyh07RIkiewJJhf0cipeaxwFsdXKdXVV
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3048:: with SMTP id u8mr3849512jak.91.1628776398374;
 Thu, 12 Aug 2021 06:53:18 -0700 (PDT)
Date:   Thu, 12 Aug 2021 06:53:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a4cc9405c95d0e1c@google.com>
Subject: [syzbot] possible deadlock in fuse_reverse_inval_entry
From:   syzbot <syzbot+9f747458f5990eaa8d43@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    85a90500f9a1 Merge tag 'io_uring-5.14-2021-08-07' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10bc00c2300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=343fd21f6f4da2d6
dashboard link: https://syzkaller.appspot.com/bug?extid=9f747458f5990eaa8d43
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1427c9aa300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1540a2f6300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9f747458f5990eaa8d43@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
5.14.0-rc4-syzkaller #0 Not tainted
--------------------------------------------
syz-executor799/8433 is trying to acquire lock:
ffff888039930ed0 (&type->i_mutex_dir_key#7){++++}-{3:3}, at: inode_lock include/linux/fs.h:774 [inline]
ffff888039930ed0 (&type->i_mutex_dir_key#7){++++}-{3:3}, at: fuse_reverse_inval_entry+0x1f5/0x530 fs/fuse/dir.c:1093

but task is already holding lock:
ffff888039930150 (&type->i_mutex_dir_key#7){++++}-{3:3}, at: inode_lock include/linux/fs.h:774 [inline]
ffff888039930150 (&type->i_mutex_dir_key#7){++++}-{3:3}, at: fuse_reverse_inval_entry+0x4c/0x530 fs/fuse/dir.c:1074

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&type->i_mutex_dir_key#7);
  lock(&type->i_mutex_dir_key#7);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz-executor799/8433:
 #0: ffff888022b6bb38 (&fc->killsb){.+.+}-{3:3}, at: fuse_notify_delete fs/fuse/dev.c:1540 [inline]
 #0: ffff888022b6bb38 (&fc->killsb){.+.+}-{3:3}, at: fuse_notify fs/fuse/dev.c:1790 [inline]
 #0: ffff888022b6bb38 (&fc->killsb){.+.+}-{3:3}, at: fuse_dev_do_write+0x285f/0x2bd0 fs/fuse/dev.c:1865
 #1: ffff888039930150 (&type->i_mutex_dir_key#7){++++}-{3:3}, at: inode_lock include/linux/fs.h:774 [inline]
 #1: ffff888039930150 (&type->i_mutex_dir_key#7){++++}-{3:3}, at: fuse_reverse_inval_entry+0x4c/0x530 fs/fuse/dir.c:1074

stack backtrace:
CPU: 1 PID: 8433 Comm: syz-executor799 Not tainted 5.14.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 print_deadlock_bug kernel/locking/lockdep.c:2944 [inline]
 check_deadlock kernel/locking/lockdep.c:2987 [inline]
 validate_chain kernel/locking/lockdep.c:3776 [inline]
 __lock_acquire.cold+0x149/0x3ab kernel/locking/lockdep.c:5015
 lock_acquire kernel/locking/lockdep.c:5625 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
 down_write+0x92/0x150 kernel/locking/rwsem.c:1406
 inode_lock include/linux/fs.h:774 [inline]
 fuse_reverse_inval_entry+0x1f5/0x530 fs/fuse/dir.c:1093
 fuse_notify_delete fs/fuse/dev.c:1541 [inline]
 fuse_notify fs/fuse/dev.c:1790 [inline]
 fuse_dev_do_write+0x287f/0x2bd0 fs/fuse/dev.c:1865
 fuse_dev_write+0x144/0x1d0 fs/fuse/dev.c:1949
 call_write_iter include/linux/fs.h:2114 [inline]
 new_sync_write+0x426/0x650 fs/read_write.c:518
 vfs_write+0x75a/0xa40 fs/read_write.c:605
 ksys_write+0x12d/0x250 fs/read_write.c:658
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4455e9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f64ac9752f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004ce4e0 RCX: 00000000004455e9
RDX: 000000000000002e RSI: 00000000200000c0 RDI: 0000000000000003


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

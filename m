Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEEE739C65F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 08:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhFEGtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 02:49:08 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:33418 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFEGtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 02:49:07 -0400
Received: by mail-il1-f197.google.com with SMTP id q14-20020a056e02096eb02901dd056f8a57so7971006ilt.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 23:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JB/vgNfE/WtWH+eBO+cUF9v+44C0CMHsPaeBa5I7ao4=;
        b=I4sBensT/ktF69+5Es2ftW/j2xtc2Sl+9+Jv4OEEfYYrub7yNSH0GgZS/Ws2hK5sy9
         q4hj15ymxix1FByJBDIzdNRyXEofgZRORk/VSi5iTKwAQ/PZMPzx50ATa4r9hRKI1lXE
         5SNwU8hWRck8RgbXDdFs/Wq0wEI3snjViu+By3HborbAkpAdD5NHcQrWnf6K5ilNCZ5y
         Rg+uTBzus7/6/7INjPcezwoUBGPnWenv0Uc3ojizaeHSdrokpJ/yxTjeR3fbGCsU9f5o
         Fsu0RvQQdvdtKJ3vPgbBl4Vi8kq4azUgjbUyRSCDP0Ef3gxnFR45gnJLhNScESbTfNsm
         sa/A==
X-Gm-Message-State: AOAM5334R/UtxgqYEWvRAyMxwqVEq7fqVZtTDNAvvlpxRzeMsJInSvEn
        1p+uBn7G99b2q+WulkGP3Rkw7FADc9tmcBdDJF2G6XpbW6mu
X-Google-Smtp-Source: ABdhPJyj3YcYyC30p2inKsobld5WOyodFQsrO2dAL6F3yCwXDujRfJWHq8GYsyTkPNJww6iTNMsVkkQplM/QfGHfszIeEsh17KgJ
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2acc:: with SMTP id m12mr6798397iov.58.1622875640012;
 Fri, 04 Jun 2021 23:47:20 -0700 (PDT)
Date:   Fri, 04 Jun 2021 23:47:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000009a40d05c3ff2ebc@google.com>
Subject: [syzbot] WARNING: suspicious RCU usage in __ext4_mark_inode_dirty
From:   syzbot <syzbot+290af4ba353cd50ec3d3@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        sh_def@163.com, syzkaller-bugs@googlegroups.com, vbabka@suse.cz,
        walken@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f88cd3fb Merge tag 'vfio-v5.13-rc5' of git://github.com/aw..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1187ac33d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a9e9956ca52a5f6
dashboard link: https://syzkaller.appspot.com/bug?extid=290af4ba353cd50ec3d3

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+290af4ba353cd50ec3d3@syzkaller.appspotmail.com

Process accounting resumed
Process accounting resumed
=============================
WARNING: suspicious RCU usage
5.13.0-rc4-syzkaller #0 Not tainted
-----------------------------
kernel/sched/core.c:8304 Illegal context switch in RCU-bh read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 0
3 locks held by syz-executor.1/20572:
 #0: 
ffff88801dae7500 (&acct->lock#2){+.+.}-{3:3}, at: acct_get kernel/acct.c:161 [inline]
ffff88801dae7500 (&acct->lock#2){+.+.}-{3:3}, at: slow_acct_process kernel/acct.c:576 [inline]
ffff88801dae7500 (&acct->lock#2){+.+.}-{3:3}, at: acct_process+0x213/0x4f0 kernel/acct.c:602
 #1: ffff8880290ca460 (sb_writers#5){.+.+}-{0:0}, at: slow_acct_process kernel/acct.c:578 [inline]
 #1: ffff8880290ca460 (sb_writers#5){.+.+}-{0:0}, at: acct_process+0x3b7/0x4f0 kernel/acct.c:602
 #2: ffff8880752da270 (&sb->s_type->i_mutex_key#10){++++}-{3:3}, at: inode_lock include/linux/fs.h:774 [inline]
 #2: ffff8880752da270 (&sb->s_type->i_mutex_key#10){++++}-{3:3}, at: ext4_buffered_write_iter+0xb6/0x4d0 fs/ext4/file.c:263

stack backtrace:
CPU: 1 PID: 20572 Comm: syz-executor.1 Not tainted 5.13.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 ___might_sleep+0x229/0x2c0 kernel/sched/core.c:8304
 __ext4_mark_inode_dirty+0xea/0x8d0 fs/ext4/inode.c:5908
 ext4_dirty_inode+0xd4/0x110 fs/ext4/inode.c:5947
 __mark_inode_dirty+0x6e3/0x10f0 fs/fs-writeback.c:2274
 mark_inode_dirty include/linux/fs.h:2404 [inline]
 generic_write_end+0x316/0x4f0 fs/buffer.c:2223
 ext4_da_write_end+0x20f/0xb50 fs/ext4/inode.c:3110
 generic_perform_write+0x2c0/0x4f0 mm/filemap.c:3671
 ext4_buffered_write_iter+0x244/0x4d0 fs/ext4/file.c:269
 ext4_file_write_iter+0x423/0x14e0 fs/ext4/file.c:680
 __kernel_write+0x58d/0xa90 fs/read_write.c:550
 do_acct_process+0xd0a/0x1420 kernel/acct.c:519
 slow_acct_process kernel/acct.c:578 [inline]
 acct_process+0x3b7/0x4f0 kernel/acct.c:602
 do_exit+0x1979/0x2a60 kernel/exit.c:816
 do_group_exit+0x125/0x310 kernel/exit.c:923
 get_signal+0x47f/0x2150 kernel/signal.c:2835
 arch_do_signal_or_restart+0x2a8/0x1eb0 arch/x86/kernel/signal.c:789
 handle_signal_work kernel/entry/common.c:147 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x171/0x280 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:301
 do_syscall_64+0x47/0xb0 arch/x86/entry/common.c:57
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665d9
Code: Unable to access opcode bytes at RIP 0x4665af.
RSP: 002b:00007effc6b68218 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 000000000056c040 RCX: 00000000004665d9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000000056c040
RBP: 000000000056c038 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056c044
R13: 00007fff3643907f R14: 00007effc6b68300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4398D44F8E7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 16:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbhKNQBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 11:01:30 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:37598 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhKNQBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 11:01:24 -0500
Received: by mail-io1-f71.google.com with SMTP id w8-20020a0566022c0800b005dc06acea8dso9676897iov.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 07:58:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=SbWVnq+nDvSmXuudTBjUq/oCHiJqjz9hQVixkgRbnxQ=;
        b=U0MxenwYFb7Lug8FIKz9CUGN+mERToDKjdM7Y5WfrFX8qRFa5BpUdDtsRYU4FGv/oN
         HlVhuDeWeYHI6rQoCOm1r9h7RCO2A81cZVy1Lv3V1omLnHtPS8R8Tvf91+f40qo6W2sz
         N1PfDHwygyesw6/s+f9s5AvNBSkK7IeZz+mrsQw0mC0vaRaGM39MkgULqm/uwGVH5C97
         +7TZwSmdHzO6ub4O9N6H5PuvO2f4OESqandGomOLepWgnaBhmKEF9+cRp97kNPrFy5Dk
         NLxurIDTDee/pFWHwRJkIiD9yo1X34lPOH5tO+XDSyrsUGq5Djwwiki0Eo35i8ljwDC5
         JcXw==
X-Gm-Message-State: AOAM530FN/eHrhkcIGhOlJHk7aqTj8W6RU83ICIx9PC/+hRxpz4LfABf
        pHPj/7QuMpg+b+N003r2Q5XIwGuKMsUeSPTCfwU89+1uXtVq
X-Google-Smtp-Source: ABdhPJxvPwO1HHNr/AXIppzJ5JfMMiQyDq67g0m3DGxzFB3Kbko9+vhUXqQaa6Njv3BCMCMJm8gJr8pWI3b5zZ5kMsZ2nSxh/WrB
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1134:: with SMTP id f20mr23936092jar.6.1636905510478;
 Sun, 14 Nov 2021 07:58:30 -0800 (PST)
Date:   Sun, 14 Nov 2021 07:58:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007ba8cd05d0c1c3b0@google.com>
Subject: [syzbot] possible deadlock in console_lock_spinning_enable (2)
From:   syzbot <syzbot+3cc1054e15babd5f4cd2@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    debe436e77c7 Merge tag 'ext4_for_linus' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=162b3b8ab00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2897a869f0607967
dashboard link: https://syzkaller.appspot.com/bug?extid=3cc1054e15babd5f4cd2
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3cc1054e15babd5f4cd2@syzkaller.appspotmail.com

FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
======================================================
WARNING: possible circular locking dependency detected
5.15.0-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.5/6725 is trying to acquire lock:
ffffffff8cb12260 (console_owner){-.-.}-{0:0}, at: console_lock_spinning_enable+0x2d/0x60 kernel/printk/printk.c:1778

but task is already holding lock:
ffff8880893d4958 (&port->lock){-.-.}-{2:2}, at: pty_write+0xc5/0x170 drivers/tty/pty.c:120

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&port->lock){-.-.}-{2:2}:
       lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd1/0x120 kernel/locking/spinlock.c:162
       tty_port_tty_get+0x21/0xe0 drivers/tty/tty_port.c:289
       tty_port_default_wakeup+0x11/0x40 drivers/tty/tty_port.c:48
       serial8250_tx_chars+0x68e/0x8a0 drivers/tty/serial/8250/8250_port.c:1845
       serial8250_handle_irq+0x2fd/0x3e0 drivers/tty/serial/8250/8250_port.c:1932
       serial8250_default_handle_irq+0xaf/0x190 drivers/tty/serial/8250/8250_port.c:1949
       serial8250_interrupt+0xa3/0x1e0 drivers/tty/serial/8250/8250_core.c:126
       __handle_irq_event_percpu+0x20d/0x730 kernel/irq/handle.c:158
       handle_irq_event_percpu kernel/irq/handle.c:198 [inline]
       handle_irq_event+0x10a/0x300 kernel/irq/handle.c:215
       handle_edge_irq+0x245/0xbe0 kernel/irq/chip.c:822
       generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
       handle_irq arch/x86/kernel/irq.c:231 [inline]
       __common_interrupt+0xce/0x1e0 arch/x86/kernel/irq.c:250
       common_interrupt+0x9f/0xc0 arch/x86/kernel/irq.c:240
       asm_common_interrupt+0x1e/0x40
       __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
       _raw_spin_unlock_irqrestore+0xd4/0x130 kernel/locking/spinlock.c:194
       spin_unlock_irqrestore include/linux/spinlock.h:404 [inline]
       uart_write+0x6ad/0x920 drivers/tty/serial/serial_core.c:598
       do_output_char+0x638/0x940 drivers/tty/n_tty.c:444
       process_output drivers/tty/n_tty.c:511 [inline]
       n_tty_write+0xe95/0x1320 drivers/tty/n_tty.c:2300
       do_tty_write drivers/tty/tty_io.c:1038 [inline]
       file_tty_write+0x5c5/0x9a0 drivers/tty/tty_io.c:1110
       do_iter_readv_writev+0x54f/0x740
       do_iter_write+0x21e/0x7b0 fs/read_write.c:851
       vfs_writev fs/read_write.c:924 [inline]
       do_writev+0x279/0x470 fs/read_write.c:967
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #1 (&port_lock_key){-.-.}-{2:2}:
       lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd1/0x120 kernel/locking/spinlock.c:162
       serial8250_console_write+0x19c/0xf30 drivers/tty/serial/8250/8250_port.c:3358
       console_unlock+0xb00/0xe90 kernel/printk/printk.c:2711
       vprintk_emit+0xba/0x140 kernel/printk/printk.c:2245
       _printk+0xcf/0x118 kernel/printk/printk.c:2266
       register_console+0x6bd/0x9a0 kernel/printk/printk.c:3051
       univ8250_console_init+0x41/0x43 drivers/tty/serial/8250/8250_core.c:680
       console_init+0x52/0x97 kernel/printk/printk.c:3151
       start_kernel+0x32d/0x56e init/main.c:1064
       secondary_startup_64_no_verify+0xb1/0xbb

-> #0 (console_owner){-.-.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3063 [inline]
       check_prevs_add kernel/locking/lockdep.c:3186 [inline]
       validate_chain+0x1dfb/0x8240 kernel/locking/lockdep.c:3801
       __lock_acquire+0x1382/0x2b00 kernel/locking/lockdep.c:5027
       lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
       console_lock_spinning_enable+0x52/0x60 kernel/printk/printk.c:1781
       console_unlock+0x834/0xe90 kernel/printk/printk.c:2708
       vprintk_emit+0xba/0x140 kernel/printk/printk.c:2245
       _printk+0xcf/0x118 kernel/printk/printk.c:2266
       fail_dump lib/fault-inject.c:45 [inline]
       should_fail+0x366/0x4b0 lib/fault-inject.c:146
       should_failslab+0x5/0x20 mm/slab_common.c:1320
       slab_pre_alloc_hook mm/slab.h:494 [inline]
       slab_alloc_node mm/slub.c:3148 [inline]
       slab_alloc mm/slub.c:3242 [inline]
       __kmalloc+0x94/0x380 mm/slub.c:4419
       kmalloc include/linux/slab.h:595 [inline]
       tty_buffer_alloc drivers/tty/tty_buffer.c:177 [inline]
       __tty_buffer_request_room+0x1f0/0x540 drivers/tty/tty_buffer.c:275
       tty_insert_flip_string_fixed_flag+0x92/0x2c0 drivers/tty/tty_buffer.c:321
       tty_insert_flip_string include/linux/tty_flip.h:42 [inline]
       pty_write+0xe9/0x170 drivers/tty/pty.c:122
       tty_put_char+0x115/0x180 drivers/tty/tty_io.c:3174
       do_output_char+0x583/0x940 drivers/tty/n_tty.c:485
       __process_echoes+0x2a3/0x930 drivers/tty/n_tty.c:736
       flush_echoes drivers/tty/n_tty.c:826 [inline]
       __receive_buf drivers/tty/n_tty.c:1579 [inline]
       n_tty_receive_buf_common+0x7c2d/0x81d0 drivers/tty/n_tty.c:1674
       tiocsti drivers/tty/tty_io.c:2310 [inline]
       tty_ioctl+0xe30/0x17d0 drivers/tty/tty_io.c:2719
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:874 [inline]
       __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:860
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

Chain exists of:
  console_owner --> &port_lock_key --> &port->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&port->lock);
                               lock(&port_lock_key);
                               lock(&port->lock);
  lock(console_owner);

 *** DEADLOCK ***

6 locks held by syz-executor.5/6725:
 #0: ffff888084da5098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:252
 #1: ffff8880893d60b8 (&port->buf.lock/1){+.+.}-{3:3}, at: tiocsti drivers/tty/tty_io.c:2308 [inline]
 #1: ffff8880893d60b8 (&port->buf.lock/1){+.+.}-{3:3}, at: tty_ioctl+0xdba/0x17d0 drivers/tty/tty_io.c:2719
 #2: ffff888084da52e8 (&o_tty->termios_rwsem/1){++++}-{3:3}, at: n_tty_receive_buf_common+0x8e/0x81d0 drivers/tty/n_tty.c:1637
 #3: ffffc90017a63378 (&ldata->output_lock){+.+.}-{3:3}, at: flush_echoes drivers/tty/n_tty.c:824 [inline]
 #3: ffffc90017a63378 (&ldata->output_lock){+.+.}-{3:3}, at: __receive_buf drivers/tty/n_tty.c:1579 [inline]
 #3: ffffc90017a63378 (&ldata->output_lock){+.+.}-{3:3}, at: n_tty_receive_buf_common+0x7be1/0x81d0 drivers/tty/n_tty.c:1674
 #4: ffff8880893d4958 (&port->lock){-.-.}-{2:2}, at: pty_write+0xc5/0x170 drivers/tty/pty.c:120
 #5: ffffffff8c9f9f00 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0xa1/0x140 kernel/printk/printk.c:2244

stack backtrace:
CPU: 0 PID: 6725 Comm: syz-executor.5 Not tainted 5.15.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1dc/0x2d8 lib/dump_stack.c:106
 check_noncircular+0x2f9/0x3b0 kernel/locking/lockdep.c:2143
 check_prev_add kernel/locking/lockdep.c:3063 [inline]
 check_prevs_add kernel/locking/lockdep.c:3186 [inline]
 validate_chain+0x1dfb/0x8240 kernel/locking/lockdep.c:3801
 __lock_acquire+0x1382/0x2b00 kernel/locking/lockdep.c:5027
 lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
 console_lock_spinning_enable+0x52/0x60 kernel/printk/printk.c:1781
 console_unlock+0x834/0xe90 kernel/printk/printk.c:2708
 vprintk_emit+0xba/0x140 kernel/printk/printk.c:2245
 _printk+0xcf/0x118 kernel/printk/printk.c:2266
 fail_dump lib/fault-inject.c:45 [inline]
 should_fail+0x366/0x4b0 lib/fault-inject.c:146
 should_failslab+0x5/0x20 mm/slab_common.c:1320
 slab_pre_alloc_hook mm/slab.h:494 [inline]
 slab_alloc_node mm/slub.c:3148 [inline]
 slab_alloc mm/slub.c:3242 [inline]
 __kmalloc+0x94/0x380 mm/slub.c:4419
 kmalloc include/linux/slab.h:595 [inline]
 tty_buffer_alloc drivers/tty/tty_buffer.c:177 [inline]
 __tty_buffer_request_room+0x1f0/0x540 drivers/tty/tty_buffer.c:275
 tty_insert_flip_string_fixed_flag+0x92/0x2c0 drivers/tty/tty_buffer.c:321
 tty_insert_flip_string include/linux/tty_flip.h:42 [inline]
 pty_write+0xe9/0x170 drivers/tty/pty.c:122
 tty_put_char+0x115/0x180 drivers/tty/tty_io.c:3174
 do_output_char+0x583/0x940 drivers/tty/n_tty.c:485
 __process_echoes+0x2a3/0x930 drivers/tty/n_tty.c:736
 flush_echoes drivers/tty/n_tty.c:826 [inline]
 __receive_buf drivers/tty/n_tty.c:1579 [inline]
 n_tty_receive_buf_common+0x7c2d/0x81d0 drivers/tty/n_tty.c:1674
 tiocsti drivers/tty/tty_io.c:2310 [inline]
 tty_ioctl+0xe30/0x17d0 drivers/tty/tty_io.c:2719
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fa76cdb3ae9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa76a2e7188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fa76cec70e0 RCX: 00007fa76cdb3ae9
RDX: 0000000020000100 RSI: 0000000000005412 RDI: 0000000000000004
RBP: 00007fa76a2e71d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff471d4ccf R14: 00007fa76a2e7300 R15: 0000000000022000
 </TASK>
CPU: 0 PID: 6725 Comm: syz-executor.5 Not tainted 5.15.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1dc/0x2d8 lib/dump_stack.c:106
 fail_dump lib/fault-inject.c:52 [inline]
 should_fail+0x384/0x4b0 lib/fault-inject.c:146
 should_failslab+0x5/0x20 mm/slab_common.c:1320
 slab_pre_alloc_hook mm/slab.h:494 [inline]
 slab_alloc_node mm/slub.c:3148 [inline]
 slab_alloc mm/slub.c:3242 [inline]
 __kmalloc+0x94/0x380 mm/slub.c:4419
 kmalloc include/linux/slab.h:595 [inline]
 tty_buffer_alloc drivers/tty/tty_buffer.c:177 [inline]
 __tty_buffer_request_room+0x1f0/0x540 drivers/tty/tty_buffer.c:275
 tty_insert_flip_string_fixed_flag+0x92/0x2c0 drivers/tty/tty_buffer.c:321
 tty_insert_flip_string include/linux/tty_flip.h:42 [inline]
 pty_write+0xe9/0x170 drivers/tty/pty.c:122
 tty_put_char+0x115/0x180 drivers/tty/tty_io.c:3174
 do_output_char+0x583/0x940 drivers/tty/n_tty.c:485
 __process_echoes+0x2a3/0x930 drivers/tty/n_tty.c:736
 flush_echoes drivers/tty/n_tty.c:826 [inline]
 __receive_buf drivers/tty/n_tty.c:1579 [inline]
 n_tty_receive_buf_common+0x7c2d/0x81d0 drivers/tty/n_tty.c:1674
 tiocsti drivers/tty/tty_io.c:2310 [inline]
 tty_ioctl+0xe30/0x17d0 drivers/tty/tty_io.c:2719
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fa76cdb3ae9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa76a2e7188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fa76cec70e0 RCX: 00007fa76cdb3ae9
RDX: 0000000020000100 RSI: 0000000000005412 RDI: 0000000000000004
RBP: 00007fa76a2e71d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff471d4ccf R14: 00007fa76a2e7300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

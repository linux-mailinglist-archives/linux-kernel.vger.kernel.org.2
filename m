Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFA844F755
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 10:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhKNJUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 04:20:16 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:45871 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhKNJUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 04:20:15 -0500
Received: by mail-io1-f72.google.com with SMTP id ay10-20020a5d9d8a000000b005e238eaeaa9so9376329iob.12
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 01:17:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=WL5EIhpEFV6ghcJRw9mDEGsDCPMVntVxDJXiStMGamk=;
        b=itW5qG+tslnBrduc//Dd73l9vERMAhpXwhXdlACFZQtJvUKui3wDsZEHIhi4nMXmX7
         TlMmrrlLjJs7at4ZU1uNv0ic0CraDw3a1o2Bbtim6+lpaTHSkcvxxxcu4g5SeKaZYEPZ
         wTZgcu0ip3uKIvL6qRtdi9A7B4EdByPblzfFLbeJs4C/k46cVUp3MOm+deg2zIAxSwI9
         jNAvJoXnuE+P9TrYMdK/CULygDumE9asWDrZbM4lZAgAwJ+64TepPaYN80TMYK4WVBse
         SorAAzb4iUNL0pG2+K6Nv6zfsUFSYzSBoxlaAJQqaglzp/fFZpWXStuJ4Ku1ef0dJdu8
         LX4Q==
X-Gm-Message-State: AOAM531fQGiiNlY7tT2QeKPfpV35lbsgO3Oii/22t0CL+Hk5xzR5A5Pl
        lLVb6swaJMckAfUcuoFbQYlyHyIt+wwZTEqKyNWKKEnmy73i
X-Google-Smtp-Source: ABdhPJzy4fjZy455KAe95a+NoOv1zi/jjInL29wNQfBQxPgpRhVoAqqNCwRj+Oari2CGABDqwamQSR0ou5CV711gQYf7MQDH4P1U
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2cd4:: with SMTP id j20mr7307338iow.106.1636881441403;
 Sun, 14 Nov 2021 01:17:21 -0800 (PST)
Date:   Sun, 14 Nov 2021 01:17:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dab76c05d0bc284c@google.com>
Subject: [syzbot] possible deadlock in console_unlock (2)
From:   syzbot <syzbot+0b7c8bfd17c00d016fb4@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f2e19fd15bd7 Add linux-next specific files for 20211112
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=116e8501b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba9c83199208e103
dashboard link: https://syzkaller.appspot.com/bug?extid=0b7c8bfd17c00d016fb4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f041f1b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1585cd76b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0b7c8bfd17c00d016fb4@syzkaller.appspotmail.com

FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 1
======================================================
WARNING: possible circular locking dependency detected
5.15.0-next-20211112-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor376/6515 is trying to acquire lock:
ffffffff8ba92c80 (console_owner){....}-{0:0}, at: console_unlock+0x303/0xb70 kernel/printk/printk.c:2710

but task is already holding lock:
ffff888078adf158 (&port->lock){-.-.}-{2:2}, at: pty_write+0xea/0x1e0 drivers/tty/pty.c:120

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&port->lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
       tty_port_tty_get+0x1f/0x100 drivers/tty/tty_port.c:289
       tty_port_default_wakeup+0x11/0x40 drivers/tty/tty_port.c:48
       serial8250_tx_chars+0x4f3/0xad0 drivers/tty/serial/8250/8250_port.c:1845
       serial8250_handle_irq.part.0+0x328/0x3d0 drivers/tty/serial/8250/8250_port.c:1932
       serial8250_handle_irq drivers/tty/serial/8250/8250_port.c:1905 [inline]
       serial8250_default_handle_irq+0xb2/0x220 drivers/tty/serial/8250/8250_port.c:1949
       serial8250_interrupt+0xfd/0x200 drivers/tty/serial/8250/8250_core.c:126
       __handle_irq_event_percpu+0x303/0x8f0 kernel/irq/handle.c:158
       handle_irq_event_percpu kernel/irq/handle.c:198 [inline]
       handle_irq_event+0x102/0x280 kernel/irq/handle.c:215
       handle_edge_irq+0x25f/0xd00 kernel/irq/chip.c:822
       generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
       handle_irq arch/x86/kernel/irq.c:231 [inline]
       __common_interrupt+0x9d/0x210 arch/x86/kernel/irq.c:250
       common_interrupt+0xa4/0xc0 arch/x86/kernel/irq.c:240
       asm_common_interrupt+0x1e/0x40 arch/x86/include/asm/idtentry.h:629
       native_safe_halt arch/x86/include/asm/irqflags.h:51 [inline]
       arch_safe_halt arch/x86/include/asm/irqflags.h:89 [inline]
       acpi_safe_halt drivers/acpi/processor_idle.c:109 [inline]
       acpi_idle_do_entry+0x1c6/0x250 drivers/acpi/processor_idle.c:553
       acpi_idle_enter+0x361/0x500 drivers/acpi/processor_idle.c:688
       cpuidle_enter_state+0x1b1/0xc80 drivers/cpuidle/cpuidle.c:237
       cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:351
       call_cpuidle kernel/sched/idle.c:158 [inline]
       cpuidle_idle_call kernel/sched/idle.c:239 [inline]
       do_idle+0x3e8/0x590 kernel/sched/idle.c:306
       cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:403
       start_kernel+0x47a/0x49b init/main.c:1141
       secondary_startup_64_no_verify+0xb0/0xbb

-> #1 (&port_lock_key){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
       serial8250_console_write+0x91a/0xb70 drivers/tty/serial/8250/8250_port.c:3358
       call_console_drivers kernel/printk/printk.c:1932 [inline]
       console_unlock+0x7a9/0xb70 kernel/printk/printk.c:2714
       vprintk_emit+0x198/0x4f0 kernel/printk/printk.c:2248
       vprintk+0x80/0x90 kernel/printk/printk_safe.c:50
       _printk+0xba/0xed kernel/printk/printk.c:2269
       register_console kernel/printk/printk.c:3054 [inline]
       register_console+0x55f/0x780 kernel/printk/printk.c:2934
       univ8250_console_init+0x3a/0x46 drivers/tty/serial/8250/8250_core.c:680
       console_init+0x3c1/0x58d kernel/printk/printk.c:3154
       start_kernel+0x30b/0x49b init/main.c:1070
       secondary_startup_64_no_verify+0xb0/0xbb

-> #0 (console_owner){....}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3063 [inline]
       check_prevs_add kernel/locking/lockdep.c:3186 [inline]
       validate_chain kernel/locking/lockdep.c:3801 [inline]
       __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5027
       lock_acquire kernel/locking/lockdep.c:5637 [inline]
       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
       console_lock_spinning_enable kernel/printk/printk.c:1784 [inline]
       console_unlock+0x356/0xb70 kernel/printk/printk.c:2711
       vprintk_emit+0x198/0x4f0 kernel/printk/printk.c:2248
       vprintk+0x80/0x90 kernel/printk/printk_safe.c:50
       _printk+0xba/0xed kernel/printk/printk.c:2269
       fail_dump lib/fault-inject.c:45 [inline]
       should_fail+0x472/0x5a0 lib/fault-inject.c:146
       should_failslab+0x5/0x10 mm/slab_common.c:1320
       slab_pre_alloc_hook mm/slab.h:494 [inline]
       slab_alloc_node mm/slub.c:3148 [inline]
       slab_alloc mm/slub.c:3242 [inline]
       __kmalloc+0x72/0x340 mm/slub.c:4419
       kmalloc include/linux/slab.h:595 [inline]
       tty_buffer_alloc+0x23f/0x2a0 drivers/tty/tty_buffer.c:177
       __tty_buffer_request_room+0x156/0x2a0 drivers/tty/tty_buffer.c:275
       tty_insert_flip_string_fixed_flag+0x93/0x250 drivers/tty/tty_buffer.c:321
       tty_insert_flip_string include/linux/tty_flip.h:42 [inline]
       pty_write+0x11c/0x1e0 drivers/tty/pty.c:122
       n_tty_write+0xa7a/0xfd0 drivers/tty/n_tty.c:2311
       do_tty_write drivers/tty/tty_io.c:1038 [inline]
       file_tty_write.constprop.0+0x526/0x910 drivers/tty/tty_io.c:1110
       call_write_iter include/linux/fs.h:2162 [inline]
       new_sync_write+0x429/0x660 fs/read_write.c:503
       vfs_write+0x7cd/0xae0 fs/read_write.c:590
       ksys_write+0x12d/0x250 fs/read_write.c:643
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
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

6 locks held by syz-executor376/6515:
 #0: ffff88807e57e098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff88807e57e130 (&tty->atomic_write_lock){+.+.}-{3:3}, at: tty_write_lock drivers/tty/tty_io.c:961 [inline]
 #1: ffff88807e57e130 (&tty->atomic_write_lock){+.+.}-{3:3}, at: do_tty_write drivers/tty/tty_io.c:984 [inline]
 #1: ffff88807e57e130 (&tty->atomic_write_lock){+.+.}-{3:3}, at: file_tty_write.constprop.0+0x29f/0x910 drivers/tty/tty_io.c:1110
 #2: ffff88807e57e2e8 (&tty->termios_rwsem){++++}-{3:3}, at: n_tty_write+0x1bf/0xfd0 drivers/tty/n_tty.c:2271
 #3: ffffc90001a78378 (&ldata->output_lock){+.+.}-{3:3}, at: n_tty_write+0xa47/0xfd0 drivers/tty/n_tty.c:2310
 #4: ffff888078adf158 (&port->lock){-.-.}-{2:2}, at: pty_write+0xea/0x1e0 drivers/tty/pty.c:120
 #5: ffffffff8bb730c0 (console_lock){+.+.}-{0:0}, at: vprintk+0x80/0x90 kernel/printk/printk_safe.c:50

stack backtrace:
CPU: 1 PID: 6515 Comm: syz-executor376 Not tainted 5.15.0-next-20211112-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2143
 check_prev_add kernel/locking/lockdep.c:3063 [inline]
 check_prevs_add kernel/locking/lockdep.c:3186 [inline]
 validate_chain kernel/locking/lockdep.c:3801 [inline]
 __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5027
 lock_acquire kernel/locking/lockdep.c:5637 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
 console_lock_spinning_enable kernel/printk/printk.c:1784 [inline]
 console_unlock+0x356/0xb70 kernel/printk/printk.c:2711
 vprintk_emit+0x198/0x4f0 kernel/printk/printk.c:2248
 vprintk+0x80/0x90 kernel/printk/printk_safe.c:50
 _printk+0xba/0xed kernel/printk/printk.c:2269
 fail_dump lib/fault-inject.c:45 [inline]
 should_fail+0x472/0x5a0 lib/fault-inject.c:146
 should_failslab+0x5/0x10 mm/slab_common.c:1320
 slab_pre_alloc_hook mm/slab.h:494 [inline]
 slab_alloc_node mm/slub.c:3148 [inline]
 slab_alloc mm/slub.c:3242 [inline]
 __kmalloc+0x72/0x340 mm/slub.c:4419
 kmalloc include/linux/slab.h:595 [inline]
 tty_buffer_alloc+0x23f/0x2a0 drivers/tty/tty_buffer.c:177
 __tty_buffer_request_room+0x156/0x2a0 drivers/tty/tty_buffer.c:275
 tty_insert_flip_string_fixed_flag+0x93/0x250 drivers/tty/tty_buffer.c:321
 tty_insert_flip_string include/linux/tty_flip.h:42 [inline]
 pty_write+0x11c/0x1e0 drivers/tty/pty.c:122
 n_tty_write+0xa7a/0xfd0 drivers/tty/n_tty.c:2311
 do_tty_write drivers/tty/tty_io.c:1038 [inline]
 file_tty_write.constprop.0+0x526/0x910 drivers/tty/tty_io.c:1110
 call_write_iter include/linux/fs.h:2162 [inline]
 new_sync_write+0x429/0x660 fs/read_write.c:503
 vfs_write+0x7cd/0xae0 fs/read_write.c:590
 ksys_write+0x12d/0x250 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f41ad8ca679
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffed0e96e38 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f41ad8ca679
RDX: 000000000000ff2e RSI: 0000000020000180 RDI: 0000000000000003
RBP: 00007ffed0e96e40 R08: 0000000000000001 R09: 00007f41ad880033
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
CPU: 1 PID: 6515 Comm: syz-executor376 Not tainted 5.15.0-next-20211112-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 fail_dump lib/fault-inject.c:52 [inline]
 should_fail.cold+0x5/0xa lib/fault-inject.c:146
 should_failslab+0x5/0x10 mm/slab_common.c:1320
 slab_pre_alloc_hook mm/slab.h:494 [inline]
 slab_alloc_node mm/slub.c:3148 [inline]
 slab_alloc mm/slub.c:3242 [inline]
 __kmalloc+0x72/0x340 mm/slub.c:4419
 kmalloc include/linux/slab.h:595 [inline]
 tty_buffer_alloc+0x23f/0x2a0 drivers/tty/tty_buffer.c:177
 __tty_buffer_request_room+0x156/0x2a0 drivers/tty/tty_buffer.c:275
 tty_insert_flip_string_fixed_flag+0x93/0x250 drivers/tty/tty_buffer.c:321
 tty_insert_flip_string include/linux/tty_flip.h:42 [inline]
 pty_write+0x11c/0x1e0 drivers/tty/pty.c:122
 n_tty_write+0xa7a/0xfd0 drivers/tty/n_tty.c:2311
 do_tty_write drivers/tty/tty_io.c:1038 [inline]
 file_tty_write.constprop.0+0x526/0x910 drivers/tty/tty_io.c:1110
 call_write_iter include/linux/fs.h:2162 [inline]
 new_sync_write+0x429/0x660 fs/read_write.c:503
 vfs_write+0x7cd/0xae0 fs/read_write.c:590
 ksys_write+0x12d/0x250 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f41ad8ca679
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffed0e96e38 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f41ad8ca679
RDX: 000000000000ff2e RSI: 0000000020000180 RDI: 0000000000000003
RBP: 00007ffed0e96e40 R08: 0000000000000001 R09: 00007f41ad880033
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

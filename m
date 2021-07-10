Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0001A3C3703
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 00:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhGJWPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 18:15:05 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:40485 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhGJWPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 18:15:04 -0400
Received: by mail-io1-f70.google.com with SMTP id l15-20020a5e820f0000b02904bd1794d00eso9018535iom.7
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 15:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3QXNL+D6XbPTQrGHBqEe6kefPssk/lteAEUhSQF2D0o=;
        b=g4JLIKiKncVpdjnbQONvAKE/4TJDNC5V4AAg/oVHRL/9zk/VdKA4BksbAIiaS0rvcV
         Ahk9J49dBbFge8mvIwYoNSKxpcy2BvO9cpygJaXMVMihXJRN8sHlAImZFE6xIh+QS2Sz
         tknSdO0OKtoFZ0kgSKPQr+sReJsvZQObBoOEuTHLf2UX5CVM2llMfd4b1e4HQPWf9VBe
         UF18E6yf8xswSVpx/gNXlzZrHv10wQEaKrFtte9QpWlQu9Dqf1gEKb2oHwnnfRNC3ddh
         J8+MyC3gqT3HJxLwIrvSW+aO8bgGhTaIlXBh3rDKH25YrdotvbNAs1V3iqFkdtxTknYB
         DG5w==
X-Gm-Message-State: AOAM533N4cdK1umZMUFKklrmXovXOhlqAcOW9hyFuVdZ1AEM1x/dqKOw
        Ys68aIrRx9vA4nu3d/wgad2x1vXHfw3WeJo+13GuG6kWOGOI
X-Google-Smtp-Source: ABdhPJw0DtMJP+6mdAERffNYCGNoe/V60x/ROhvRR8UPKTwYe9DAMfSynY49ndxTvJspDU6SAGQF4+8atnOeuGlayLejdYb+JLHY
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:dd2:: with SMTP id l18mr30784225ilj.34.1625955137869;
 Sat, 10 Jul 2021 15:12:17 -0700 (PDT)
Date:   Sat, 10 Jul 2021 15:12:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069f57705c6cc2e81@google.com>
Subject: [syzbot] BUG: sleeping function called from invalid context in __munlock_pagevec
From:   syzbot <syzbot+cf9c548279bff83b0c97@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ee268dee Add linux-next specific files for 20210707
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13ed30d2300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59e1e3bbc3afca75
dashboard link: https://syzkaller.appspot.com/bug?extid=cf9c548279bff83b0c97
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a25ee4300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f81928300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cf9c548279bff83b0c97@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at include/linux/pagemap.h:674
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 8467, name: syz-executor631
1 lock held by syz-executor631/8467:
 #0: ffff8880343e0978 (ptlock_ptr(page)#2){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:359 [inline]
 #0: ffff8880343e0978 (ptlock_ptr(page)#2){+.+.}-{2:2}, at: map_pte mm/page_vma_mapped.c:52 [inline]
 #0: ffff8880343e0978 (ptlock_ptr(page)#2){+.+.}-{2:2}, at: page_vma_mapped_walk+0xd87/0x24f0 mm/page_vma_mapped.c:261
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 PID: 8467 Comm: syz-executor631 Not tainted 5.13.0-next-20210707-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 ___might_sleep.cold+0x1f1/0x237 kernel/sched/core.c:9171
 lock_page include/linux/pagemap.h:674 [inline]
 __munlock_pagevec+0xa22/0x2340 mm/mlock.c:314
 munlock_vma_pages_range+0x9d7/0xf00 mm/mlock.c:475
 munlock_vma_pages_all mm/internal.h:354 [inline]
 unlock_range mm/mmap.c:2811 [inline]
 exit_mmap+0x47a/0x620 mm/mmap.c:3188
 __mmput+0x122/0x470 kernel/fork.c:1152
 mmput+0x58/0x60 kernel/fork.c:1173
 exit_mm kernel/exit.c:501 [inline]
 do_exit+0xae2/0x2a60 kernel/exit.c:812
 do_group_exit+0x125/0x310 kernel/exit.c:922
 __do_sys_exit_group kernel/exit.c:933 [inline]
 __se_sys_exit_group kernel/exit.c:931 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:931
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x43e969
Code: Unable to access opcode bytes at RIP 0x43e93f.
RSP: 002b:00007ffce2d3a7a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00000000004b02f0 RCX: 000000000043e969
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004b02f0
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001

=============================
[ BUG: Invalid wait context ]
5.13.0-next-20210707-syzkaller #0 Tainted: G        W        
-----------------------------
syz-executor631/8467 is trying to lock:
ffff888035ea6000 (&mapping->i_mmap_rwsem){++++}-{3:3}, at: i_mmap_lock_read include/linux/fs.h:514 [inline]
ffff888035ea6000 (&mapping->i_mmap_rwsem){++++}-{3:3}, at: rmap_walk_file+0x52f/0x710 mm/rmap.c:2337
other info that might help us debug this:
context-{4:4}
1 lock held by syz-executor631/8467:
 #0: ffff8880343e0978 (ptlock_ptr(page)#2){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:359 [inline]
 #0: ffff8880343e0978 (ptlock_ptr(page)#2){+.+.}-{2:2}, at: map_pte mm/page_vma_mapped.c:52 [inline]
 #0: ffff8880343e0978 (ptlock_ptr(page)#2){+.+.}-{2:2}, at: page_vma_mapped_walk+0xd87/0x24f0 mm/page_vma_mapped.c:261
stack backtrace:
CPU: 0 PID: 8467 Comm: syz-executor631 Tainted: G        W         5.13.0-next-20210707-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4666 [inline]
 check_wait_context kernel/locking/lockdep.c:4727 [inline]
 __lock_acquire.cold+0x213/0x3ab kernel/locking/lockdep.c:4965
 lock_acquire kernel/locking/lockdep.c:5625 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
 down_read+0x9a/0x440 kernel/locking/rwsem.c:1353
 i_mmap_lock_read include/linux/fs.h:514 [inline]
 rmap_walk_file+0x52f/0x710 mm/rmap.c:2337
 rmap_walk+0x10d/0x190 mm/rmap.c:2366
 page_mlock+0x448/0x650 mm/rmap.c:2029
 __munlock_isolated_page+0x88/0x410 mm/mlock.c:122
 __munlock_pagevec+0xd7f/0x2340 mm/mlock.c:322
 munlock_vma_pages_range+0x9d7/0xf00 mm/mlock.c:475
 munlock_vma_pages_all mm/internal.h:354 [inline]
 unlock_range mm/mmap.c:2811 [inline]
 exit_mmap+0x47a/0x620 mm/mmap.c:3188
 __mmput+0x122/0x470 kernel/fork.c:1152
 mmput+0x58/0x60 kernel/fork.c:1173
 exit_mm kernel/exit.c:501 [inline]
 do_exit+0xae2/0x2a60 kernel/exit.c:812
 do_group_exit+0x125/0x310 kernel/exit.c:922
 __do_sys_exit_group kernel/exit.c:933 [inline]
 __se_sys_exit_group kernel/exit.c:931 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:931
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x43e969
Code: Unable to access opcode bytes at RIP 0x43e93f.
RSP: 002b:00007ffce2d3a7a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00000000004b02f0 RCX: 000000000043e969
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004b02f0
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

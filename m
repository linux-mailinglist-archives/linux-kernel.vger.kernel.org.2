Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C57C419E98
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 20:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbhI0Sv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 14:51:59 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:46599 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbhI0Sv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 14:51:57 -0400
Received: by mail-io1-f70.google.com with SMTP id b13-20020a05660214cd00b005d6279b61fdso22592017iow.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=l7rqchQ61TBhA/++fM9zkm7ce+MF19ar4j52EbQSFGE=;
        b=4W35I8aD90CQD5GsGfBQSqZTnI5sVcy+CZtWe/G0+pIaB6TiCU4r+AI4WnP21AGNBY
         U+QhRQFDVzOaDolrvNxYLRKYwHn9/eI4AOChgV6KP+ROqPQjh4HAuvgsFxBf9sPnTAQ1
         DjFN1R2Wgj/DfCfd/ylsOn+dFm+fUsUQmD3Yp9BUN+gRwz8eQG1uH20n2LibqZPy6FGP
         o682BUWU4UE9ii7KY0OVYZB/r/tNudkySLzSFMvHskixq/f8++J7eq4OjFLxmTSteuPS
         IPVCfsnbtYxb06A0s3C4xKD49qbL2mkSEPINwQmtpFO0IPglYxwU1sa0m0A+i6SLanzk
         RmtQ==
X-Gm-Message-State: AOAM530GDI+6wFohxlTTD/Dd4xBY992L8zBxztwM/L9yXTreavKdzH1p
        zVWJtaRIec8EH6oYxiKckaY/3/Lu5UpFUJ16iw1nNkX8TAPZ
X-Google-Smtp-Source: ABdhPJzKpzylPUFYoaDrrYKpsjzFuWVe+Lw3nvdvkv7tg1VYg8AzpO6LIxzGKtOw+oQCUHN9FEye+rVVpRx7qZzkKgN6IL2f2EBj
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4a3:: with SMTP id e3mr1143183ils.229.1632768619368;
 Mon, 27 Sep 2021 11:50:19 -0700 (PDT)
Date:   Mon, 27 Sep 2021 11:50:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008ed76c05ccfe91ee@google.com>
Subject: [syzbot] INFO: rcu detected stall in sys_mount (6)
From:   syzbot <syzbot+ee7d095f44a683a195f8@syzkaller.appspotmail.com>
To:     fweisbec@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5a5d008887b4 Add linux-next specific files for 20210924
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1187dccb300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae26deb010ccc26f
dashboard link: https://syzkaller.appspot.com/bug?extid=ee7d095f44a683a195f8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172aaf6f300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12667317300000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10149213300000
console output: https://syzkaller.appspot.com/x/log.txt?x=14149213300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ee7d095f44a683a195f8@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	0-....: (10500 ticks this GP) idle=2bb/1/0x4000000000000000 softirq=9116/9116 fqs=5250 
	(t=10502 jiffies g=12025 q=441)
NMI backtrace for cpu 0
CPU: 0 PID: 6525 Comm: syz-executor604 Not tainted 5.15.0-rc2-next-20210924-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1ae/0x220 lib/nmi_backtrace.c:62
 trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
 rcu_dump_cpu_stacks+0x25e/0x3f0 kernel/rcu/tree_stall.h:343
 print_cpu_stall kernel/rcu/tree_stall.h:627 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:711 [inline]
 rcu_pending kernel/rcu/tree.c:3878 [inline]
 rcu_sched_clock_irq.cold+0x9d/0x746 kernel/rcu/tree.c:2597
 update_process_times+0x16d/0x200 kernel/time/timer.c:1785
 tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:226
 tick_sched_timer+0x1b0/0x2d0 kernel/time/tick-sched.c:1428
 __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
 __hrtimer_run_queues+0x1c0/0xe50 kernel/time/hrtimer.c:1749
 hrtimer_interrupt+0x31c/0x790 kernel/time/hrtimer.c:1811
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x530 arch/x86/kernel/apic/apic.c:1103
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:__sanitizer_cov_trace_pc+0x37/0x60 kernel/kcov.c:197
Code: 81 e1 00 01 00 00 65 48 8b 14 25 40 70 02 00 a9 00 01 ff 00 74 0e 85 c9 74 35 8b 82 ac 15 00 00 85 c0 74 2b 8b 82 88 15 00 00 <83> f8 02 75 20 48 8b 8a 90 15 00 00 8b 92 8c 15 00 00 48 8b 01 48
RSP: 0018:ffffc9000110f9a0 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff888079718000 RSI: ffffffff828c91c6 RDI: 0000000000000003
RBP: ffffc90002081000 R08: 0000000000000000 R09: 0000000000000068
R10: ffffffff828c8e16 R11: 000000000000003f R12: ffff88806c93e600
R13: ffff888013f8b000 R14: dffffc0000000000 R15: ffff88806c93e650
 ntfs_lookup_inode_by_name+0x1d26/0x34b0 fs/ntfs/dir.c:379
 check_windows_hibernation_status+0xd9/0x740 fs/ntfs/super.c:1274
 load_system_files fs/ntfs/super.c:1989 [inline]
 ntfs_fill_super+0x62f4/0x84e0 fs/ntfs/super.c:2893
 mount_bdev+0x34d/0x410 fs/super.c:1368
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1498
 do_new_mount fs/namespace.c:2988 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3318
 do_mount fs/namespace.c:3331 [inline]
 __do_sys_mount fs/namespace.c:3539 [inline]
 __se_sys_mount fs/namespace.c:3516 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3516
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f967e8db4fa
Code: 48 c7 c2 c0 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 a8 00 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd213ac388 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd213ac3e0 RCX: 00007f967e8db4fa
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffd213ac3a0
RBP: 00007ffd213ac3a0 R08: 00007ffd213ac3e0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000020001c28
R13: 0000000000000003 R14: 0000000000000004 R15: 0000000000000117
 </TASK>
----------------
Code disassembly (best guess):
   0:	81 e1 00 01 00 00    	and    $0x100,%ecx
   6:	65 48 8b 14 25 40 70 	mov    %gs:0x27040,%rdx
   d:	02 00
   f:	a9 00 01 ff 00       	test   $0xff0100,%eax
  14:	74 0e                	je     0x24
  16:	85 c9                	test   %ecx,%ecx
  18:	74 35                	je     0x4f
  1a:	8b 82 ac 15 00 00    	mov    0x15ac(%rdx),%eax
  20:	85 c0                	test   %eax,%eax
  22:	74 2b                	je     0x4f
  24:	8b 82 88 15 00 00    	mov    0x1588(%rdx),%eax
* 2a:	83 f8 02             	cmp    $0x2,%eax <-- trapping instruction
  2d:	75 20                	jne    0x4f
  2f:	48 8b 8a 90 15 00 00 	mov    0x1590(%rdx),%rcx
  36:	8b 92 8c 15 00 00    	mov    0x158c(%rdx),%edx
  3c:	48 8b 01             	mov    (%rcx),%rax
  3f:	48                   	rex.W


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

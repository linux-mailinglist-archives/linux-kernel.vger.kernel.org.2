Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795113EC34C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 16:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238600AbhHNO1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 10:27:48 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:39522 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbhHNO1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 10:27:43 -0400
Received: by mail-il1-f198.google.com with SMTP id i4-20020a056e0212c4b029022291c9f509so6849829ilm.6
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 07:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=CoOp6XK/alayd/uCXGJgcJu3j2utGypWBGbbqN8xiek=;
        b=SNu+lDpkoK3Whf3G046KEgQugCVI3kwns4/E6fXr4jJvq+S1X/7cXeXveL4P/reJ/V
         uEKxafm/Wb7ClItRyb4NIP1Tkfa8uMbxOiYjuxU1TkYnCQBMuGyNICjI68QDDxcT1+QQ
         KDlTrI6oSJo2qLbAryZ69ivpk+7CMQfsjICVhDKKOA9oA+or4FBfSWLGVUQhJKWlOSM8
         EQ8Vis0KrCVgY0dQs/qAY80A927d/2m3hu3XIbdDU12v0kM3Svws1ca8Unrpsh+vu63C
         FUqMSPUBTdTwlB6+DNcK/WOxqXv6eRaQH1BtpzXvRtKEgvq3jPKkGu3iMHd/nd8JcOLO
         scOA==
X-Gm-Message-State: AOAM533+Tyg/gc9p9Kk9lvULge8XMcFs38K7XR5Je0pkAFLYiMAdL7qb
        uB/G5hTujlh2m+gjwCJzVD6RkiBoUezQPDkycT70KMlEx/Pc
X-Google-Smtp-Source: ABdhPJwareTMMqhQylhLWit1TIzuGV0G13xcI4DxTWKMTghob/HKhrTBVZ4pIB2yZGdYR7PjcAqmNXWGNLq6QZMq5yB2QepeNvpJ
MIME-Version: 1.0
X-Received: by 2002:a92:cf4a:: with SMTP id c10mr5513577ilr.269.1628951235079;
 Sat, 14 Aug 2021 07:27:15 -0700 (PDT)
Date:   Sat, 14 Aug 2021 07:27:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b931f005c985c34f@google.com>
Subject: [syzbot] INFO: task hung in sys_acct
From:   syzbot <syzbot+2a9f6d6707c6afef5056@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, sh_def@163.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9a73fa375d58 Merge branch 'for-5.14-fixes' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1551216e300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3a20bae04b96ccd
dashboard link: https://syzkaller.appspot.com/bug?extid=2a9f6d6707c6afef5056
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e0d7be300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14325779300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2a9f6d6707c6afef5056@syzkaller.appspotmail.com

INFO: task syz-executor050:8462 blocked for more than 143 seconds.
      Not tainted 5.14.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor050 state:D stack:29784 pid: 8462 ppid:     1 flags:0x00000000
Call Trace:
 context_switch kernel/sched/core.c:4681 [inline]
 __schedule+0x93a/0x26f0 kernel/sched/core.c:5938
 schedule+0xd3/0x270 kernel/sched/core.c:6017
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6076
 __mutex_lock_common kernel/locking/mutex.c:1036 [inline]
 __mutex_lock+0x7b6/0x10a0 kernel/locking/mutex.c:1104
 __do_sys_acct kernel/acct.c:285 [inline]
 __se_sys_acct kernel/acct.c:273 [inline]
 __x64_sys_acct+0xa3/0x1f0 kernel/acct.c:273
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x445779
RSP: 002b:00007f219fbcd308 EFLAGS: 00000246 ORIG_RAX: 00000000000000a3
RAX: ffffffffffffffda RBX: 00000000004ca408 RCX: 0000000000445779
RDX: 0000000000445779 RSI: 0000000000000000 RDI: 00000000200001c0
RBP: 00000000004ca400 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004ca40c
R13: 000000000049a074 R14: 0030656c69662f2e R15: 0000000000022000
INFO: task syz-executor050:8465 blocked for more than 143 seconds.
      Not tainted 5.14.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor050 state:D stack:29784 pid: 8465 ppid:     1 flags:0x00000000
Call Trace:
 context_switch kernel/sched/core.c:4681 [inline]
 __schedule+0x93a/0x26f0 kernel/sched/core.c:5938
 schedule+0xd3/0x270 kernel/sched/core.c:6017
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6076
 __mutex_lock_common kernel/locking/mutex.c:1036 [inline]
 __mutex_lock+0x7b6/0x10a0 kernel/locking/mutex.c:1104
 __do_sys_acct kernel/acct.c:285 [inline]
 __se_sys_acct kernel/acct.c:273 [inline]
 __x64_sys_acct+0xa3/0x1f0 kernel/acct.c:273
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x445779
RSP: 002b:00007f219fbcd308 EFLAGS: 00000246 ORIG_RAX: 00000000000000a3
RAX: ffffffffffffffda RBX: 00000000004ca408 RCX: 0000000000445779
RDX: 0000000000445779 RSI: 0000000000000000 RDI: 00000000200001c0
RBP: 00000000004ca400 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004ca40c
R13: 000000000049a074 R14: 0030656c69662f2e R15: 0000000000022000
INFO: task syz-executor050:8468 blocked for more than 143 seconds.
      Not tainted 5.14.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor050 state:D stack:29904 pid: 8468 ppid:     1 flags:0x00000000
Call Trace:
 context_switch kernel/sched/core.c:4681 [inline]
 __schedule+0x93a/0x26f0 kernel/sched/core.c:5938
 schedule+0xd3/0x270 kernel/sched/core.c:6017
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6076
 __mutex_lock_common kernel/locking/mutex.c:1036 [inline]
 __mutex_lock+0x7b6/0x10a0 kernel/locking/mutex.c:1104
 __do_sys_acct kernel/acct.c:285 [inline]
 __se_sys_acct kernel/acct.c:273 [inline]
 __x64_sys_acct+0xa3/0x1f0 kernel/acct.c:273
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x445779
RSP: 002b:00007f219fbcd308 EFLAGS: 00000246 ORIG_RAX: 00000000000000a3
RAX: ffffffffffffffda RBX: 00000000004ca408 RCX: 0000000000445779
RDX: 0000000000445779 RSI: 00000000000f4240 RDI: 00000000200001c0
RBP: 00000000004ca400 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004ca40c
R13: 000000000049a074 R14: 0030656c69662f2e R15: 0000000000022000
INFO: task syz-executor050:8470 blocked for more than 143 seconds.
      Not tainted 5.14.0-rc5-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor050 state:D stack:28280 pid: 8470 ppid:  8441 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4681 [inline]
 __schedule+0x93a/0x26f0 kernel/sched/core.c:5938
 schedule+0xd3/0x270 kernel/sched/core.c:6017
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6076
 __mutex_lock_common kernel/locking/mutex.c:1036 [inline]
 __mutex_lock+0x7b6/0x10a0 kernel/locking/mutex.c:1104
 __do_sys_acct kernel/acct.c:285 [inline]
 __se_sys_acct kernel/acct.c:273 [inline]
 __x64_sys_acct+0xa3/0x1f0 kernel/acct.c:273
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x445779
RSP: 002b:00007f219fbcd308 EFLAGS: 00000246 ORIG_RAX: 00000000000000a3
RAX: ffffffffffffffda RBX: 00000000004ca408 RCX: 0000000000445779
RDX: 0000000000445779 RSI: 0000000000000000 RDI: 00000000200001c0
RBP: 00000000004ca400 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004ca40c
R13: 000000000049a074 R14: 0030656c69662f2e R15: 0000000000022000

Showing all locks held in the system:
1 lock held by khungtaskd/1646:
 #0: ffffffff8b97c1c0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6446
1 lock held by in:imklog/8353:
 #0: ffff888018f6e0f0 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:974
1 lock held by syz-executor050/8459:
 #0: ffffffff8b9b4088 (acct_on_mutex){+.+.}-{3:3}, at: __do_sys_acct kernel/acct.c:285 [inline]
 #0: ffffffff8b9b4088 (acct_on_mutex){+.+.}-{3:3}, at: __se_sys_acct kernel/acct.c:273 [inline]
 #0: ffffffff8b9b4088 (acct_on_mutex){+.+.}-{3:3}, at: __x64_sys_acct+0xa3/0x1f0 kernel/acct.c:273
1 lock held by syz-executor050/8462:
 #0: ffffffff8b9b4088 (acct_on_mutex){+.+.}-{3:3}, at: __do_sys_acct kernel/acct.c:285 [inline]
 #0: ffffffff8b9b4088 (acct_on_mutex){+.+.}-{3:3}, at: __se_sys_acct kernel/acct.c:273 [inline]
 #0: ffffffff8b9b4088 (acct_on_mutex){+.+.}-{3:3}, at: __x64_sys_acct+0xa3/0x1f0 kernel/acct.c:273
1 lock held by syz-executor050/8465:
 #0: ffffffff8b9b4088 (acct_on_mutex){+.+.}-{3:3}, at: __do_sys_acct kernel/acct.c:285 [inline]
 #0: ffffffff8b9b4088 (acct_on_mutex){+.+.}-{3:3}, at: __se_sys_acct kernel/acct.c:273 [inline]
 #0: ffffffff8b9b4088 (acct_on_mutex){+.+.}-{3:3}, at: __x64_sys_acct+0xa3/0x1f0 kernel/acct.c:273
1 lock held by syz-executor050/8468:
 #0: ffffffff8b9b4088 (acct_on_mutex){+.+.}-{3:3}, at: __do_sys_acct kernel/acct.c:285 [inline]
 #0: ffffffff8b9b4088 (acct_on_mutex){+.+.}-{3:3}, at: __se_sys_acct kernel/acct.c:273 [inline]
 #0: ffffffff8b9b4088 (acct_on_mutex){+.+.}-{3:3}, at: __x64_sys_acct+0xa3/0x1f0 kernel/acct.c:273
1 lock held by syz-executor050/8470:
 #0: ffffffff8b9b4088 (acct_on_mutex){+.+.}-{3:3}, at: __do_sys_acct kernel/acct.c:285 [inline]
 #0: ffffffff8b9b4088 (acct_on_mutex){+.+.}-{3:3}, at: __se_sys_acct kernel/acct.c:273 [inline]
 #0: ffffffff8b9b4088 (acct_on_mutex){+.+.}-{3:3}, at: __x64_sys_acct+0xa3/0x1f0 kernel/acct.c:273

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1646 Comm: khungtaskd Not tainted 5.14.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0xd0a/0xfc0 kernel/hung_task.c:295
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 1 skipped: idling at acpi_safe_halt drivers/acpi/processor_idle.c:109 [inline]
NMI backtrace for cpu 1 skipped: idling at acpi_idle_do_entry+0x1c6/0x250 drivers/acpi/processor_idle.c:553


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

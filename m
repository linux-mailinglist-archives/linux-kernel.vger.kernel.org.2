Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBBD445709
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 17:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhKDQVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 12:21:02 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:52118 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhKDQVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 12:21:00 -0400
Received: by mail-io1-f71.google.com with SMTP id d19-20020a0566022d5300b005e178955ce3so4219683iow.18
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 09:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=TtLw6aWpwMPjFNQmIv9jnm6imzErm1KzhAzZaitDCeE=;
        b=Xk35PLMNQbKyKsdsQpsjMmg3FcFIJGB4pO0ARINWV2U8/2dWj/ZQVnBiwlYpLvgwbQ
         D3EQ5yq0bQqLAiB3gc+gvH43KT6bq8WUdasUJR8vwLWJnH82qkhLXejh/61CzEfZL34N
         shpzmnle8p94QLBTuVq+HfVK7yVUzr9fUQy4NH2pS6kaaJJwcsn14O0ZJoStZsL5KZQd
         7L9m+5uL+m+4a2MfXRCo47Ss9DGm08kqH/XI4sgXWdxSZefEUmumg1ID9PQxk3hf2Yr0
         n64nN6zBkEk+a6cSJsaJ68/4NLhB8S+qVz0hsItHnTmligWuDzf1k4p9nPIN00vgFsNW
         siHg==
X-Gm-Message-State: AOAM531vBrprvgxFcS/ocqG1OiQhlXxWE4ffVt2FkLDShrEBVp3ippqz
        u1q60HY12om+WXaynNpN94ob/dKTR+oeitxU8A0W4IYP8qbS
X-Google-Smtp-Source: ABdhPJxsCiCH/Uy1peRPdU83CArF/wCtlwK6Q6jH1tN8Tr7B4ut/KqEJlZYFSYdbr+6cB78Y5vUaIOx3JbJ5zZHKDGfvIbVNmVtr
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1544:: with SMTP id j4mr12244259ilu.205.1636042701775;
 Thu, 04 Nov 2021 09:18:21 -0700 (PDT)
Date:   Thu, 04 Nov 2021 09:18:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000013aebd05cff8e064@google.com>
Subject: [syzbot] possible deadlock in ktime_get_coarse_ts64
From:   syzbot <syzbot+43fd005b5a1b4d10781e@syzkaller.appspotmail.com>
To:     john.stultz@linaro.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    dcd68326d29b Merge tag 'devicetree-for-5.16' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a3576ab00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a89cd86e20989871
dashboard link: https://syzkaller.appspot.com/bug?extid=43fd005b5a1b4d10781e
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+43fd005b5a1b4d10781e@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.15.0-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.4/14877 is trying to acquire lock:
ffffffff8cb30008 (tk_core.seq.seqcount){----}-{0:0}, at: ktime_get_coarse_ts64+0x25/0x110 kernel/time/timekeeping.c:2255

but task is already holding lock:
ffffffff90dbf200 (&obj_hash[i].lock){-.-.}-{2:2}, at: debug_object_deactivate+0x61/0x400 lib/debugobjects.c:735

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&obj_hash[i].lock){-.-.}-{2:2}:
       lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5625
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd1/0x120 kernel/locking/spinlock.c:162
       __debug_object_init+0xd9/0x1860 lib/debugobjects.c:569
       debug_hrtimer_init kernel/time/hrtimer.c:414 [inline]
       debug_init kernel/time/hrtimer.c:468 [inline]
       hrtimer_init+0x20/0x40 kernel/time/hrtimer.c:1592
       ntp_init_cmos_sync kernel/time/ntp.c:676 [inline]
       ntp_init+0xa1/0xad kernel/time/ntp.c:1095
       timekeeping_init+0x512/0x6bf kernel/time/timekeeping.c:1639
       start_kernel+0x267/0x56e init/main.c:1030
       secondary_startup_64_no_verify+0xb1/0xbb

-> #0 (tk_core.seq.seqcount){----}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3051 [inline]
       check_prevs_add kernel/locking/lockdep.c:3174 [inline]
       validate_chain+0x1dfb/0x8240 kernel/locking/lockdep.c:3789
       __lock_acquire+0x1382/0x2b00 kernel/locking/lockdep.c:5015
       lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5625
       seqcount_lockdep_reader_access+0xfe/0x230 include/linux/seqlock.h:103
       ktime_get_coarse_ts64+0x25/0x110 kernel/time/timekeeping.c:2255
       ktime_get_coarse include/linux/timekeeping.h:120 [inline]
       ktime_get_coarse_ns include/linux/timekeeping.h:126 [inline]
       ____bpf_ktime_get_coarse_ns kernel/bpf/helpers.c:173 [inline]
       bpf_ktime_get_coarse_ns+0x7e/0x130 kernel/bpf/helpers.c:171
       bpf_prog_a99735ebafdda2f1+0x10/0xb50
       bpf_dispatcher_nop_func include/linux/bpf.h:721 [inline]
       __bpf_prog_run include/linux/filter.h:626 [inline]
       bpf_prog_run include/linux/filter.h:633 [inline]
       BPF_PROG_RUN_ARRAY include/linux/bpf.h:1294 [inline]
       trace_call_bpf+0x2cf/0x5d0 kernel/trace/bpf_trace.c:127
       perf_trace_run_bpf_submit+0x7b/0x1d0 kernel/events/core.c:9708
       perf_trace_lock+0x37c/0x440 include/trace/events/lock.h:39
       trace_lock_release+0x128/0x150 include/trace/events/lock.h:58
       lock_release+0x82/0x810 kernel/locking/lockdep.c:5636
       __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:149 [inline]
       _raw_spin_unlock_irqrestore+0x75/0x130 kernel/locking/spinlock.c:194
       debug_hrtimer_deactivate kernel/time/hrtimer.c:425 [inline]
       debug_deactivate kernel/time/hrtimer.c:481 [inline]
       __run_hrtimer kernel/time/hrtimer.c:1653 [inline]
       __hrtimer_run_queues+0x2f9/0xa60 kernel/time/hrtimer.c:1749
       hrtimer_interrupt+0x3b3/0x1040 kernel/time/hrtimer.c:1811
       local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline]
       __sysvec_apic_timer_interrupt+0xf9/0x270 arch/x86/kernel/apic/apic.c:1103
       sysvec_apic_timer_interrupt+0x8c/0xb0 arch/x86/kernel/apic/apic.c:1097
       asm_sysvec_apic_timer_interrupt+0x12/0x20
       __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
       _raw_spin_unlock_irqrestore+0xd4/0x130 kernel/locking/spinlock.c:194
       try_to_wake_up+0x702/0xd20 kernel/sched/core.c:4118
       wake_up_process kernel/sched/core.c:4200 [inline]
       wake_up_q+0x9a/0xf0 kernel/sched/core.c:953
       futex_wake+0x50f/0x5b0 kernel/futex/waitwake.c:184
       do_futex+0x367/0x560 kernel/futex/syscalls.c:127
       __do_sys_futex kernel/futex/syscalls.c:199 [inline]
       __se_sys_futex+0x401/0x4b0 kernel/futex/syscalls.c:180
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&obj_hash[i].lock);
                               lock(tk_core.seq.seqcount);
                               lock(&obj_hash[i].lock);
  lock(tk_core.seq.seqcount);

 *** DEADLOCK ***

3 locks held by syz-executor.4/14877:
 #0: ffff8880b9b2a258 (hrtimer_bases.lock){-.-.}-{2:2}, at: hrtimer_interrupt+0x107/0x1040 kernel/time/hrtimer.c:1792
 #1: ffffffff90dbf200 (&obj_hash[i].lock){-.-.}-{2:2}, at: debug_object_deactivate+0x61/0x400 lib/debugobjects.c:735
 #2: ffffffff8cb1d840 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x5/0x30 include/linux/rcupdate.h:267

stack backtrace:
CPU: 1 PID: 14877 Comm: syz-executor.4 Not tainted 5.15.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1dc/0x2d8 lib/dump_stack.c:106
 check_noncircular+0x2f9/0x3b0 kernel/locking/lockdep.c:2131
 check_prev_add kernel/locking/lockdep.c:3051 [inline]
 check_prevs_add kernel/locking/lockdep.c:3174 [inline]
 validate_chain+0x1dfb/0x8240 kernel/locking/lockdep.c:3789
 __lock_acquire+0x1382/0x2b00 kernel/locking/lockdep.c:5015
 lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5625
 seqcount_lockdep_reader_access+0xfe/0x230 include/linux/seqlock.h:103
 ktime_get_coarse_ts64+0x25/0x110 kernel/time/timekeeping.c:2255
 ktime_get_coarse include/linux/timekeeping.h:120 [inline]
 ktime_get_coarse_ns include/linux/timekeeping.h:126 [inline]
 ____bpf_ktime_get_coarse_ns kernel/bpf/helpers.c:173 [inline]
 bpf_ktime_get_coarse_ns+0x7e/0x130 kernel/bpf/helpers.c:171
 bpf_prog_a99735ebafdda2f1+0x10/0xb50
 bpf_dispatcher_nop_func include/linux/bpf.h:721 [inline]
 __bpf_prog_run include/linux/filter.h:626 [inline]
 bpf_prog_run include/linux/filter.h:633 [inline]
 BPF_PROG_RUN_ARRAY include/linux/bpf.h:1294 [inline]
 trace_call_bpf+0x2cf/0x5d0 kernel/trace/bpf_trace.c:127
 perf_trace_run_bpf_submit+0x7b/0x1d0 kernel/events/core.c:9708
 perf_trace_lock+0x37c/0x440 include/trace/events/lock.h:39
 trace_lock_release+0x128/0x150 include/trace/events/lock.h:58
 lock_release+0x82/0x810 kernel/locking/lockdep.c:5636
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:149 [inline]
 _raw_spin_unlock_irqrestore+0x75/0x130 kernel/locking/spinlock.c:194
 debug_hrtimer_deactivate kernel/time/hrtimer.c:425 [inline]
 debug_deactivate kernel/time/hrtimer.c:481 [inline]
 __run_hrtimer kernel/time/hrtimer.c:1653 [inline]
 __hrtimer_run_queues+0x2f9/0xa60 kernel/time/hrtimer.c:1749
 hrtimer_interrupt+0x3b3/0x1040 kernel/time/hrtimer.c:1811
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline]
 __sysvec_apic_timer_interrupt+0xf9/0x270 arch/x86/kernel/apic/apic.c:1103
 sysvec_apic_timer_interrupt+0x8c/0xb0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xd4/0x130 kernel/locking/spinlock.c:194
Code: 9c 8f 44 24 20 42 80 3c 23 00 74 08 4c 89 f7 e8 62 0e ce f7 f6 44 24 21 02 75 4e 41 f7 c7 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> 67 26 58 f7 65 8b 05 68 aa 00 76 85 c0 74 3f 48 c7 04 24 0e 36
RSP: 0018:ffffc90002ebfa40 EFLAGS: 00000206
RAX: 263c6496d1cb4000 RBX: 1ffff920005d7f4c RCX: ffffffff90b84903
RDX: dffffc0000000000 RSI: 0000000000000002 RDI: 0000000000000001
RBP: ffffc90002ebfad0 R08: ffffffff818add10 R09: ffffed100f346c11
R10: ffffed100f346c11 R11: 0000000000000000 R12: dffffc0000000000
R13: 1ffff920005d7f48 R14: ffffc90002ebfa60 R15: 0000000000000246
 try_to_wake_up+0x702/0xd20 kernel/sched/core.c:4118
 wake_up_process kernel/sched/core.c:4200 [inline]
 wake_up_q+0x9a/0xf0 kernel/sched/core.c:953
 futex_wake+0x50f/0x5b0 kernel/futex/waitwake.c:184
 do_futex+0x367/0x560 kernel/futex/syscalls.c:127
 __do_sys_futex kernel/futex/syscalls.c:199 [inline]
 __se_sys_futex+0x401/0x4b0 kernel/futex/syscalls.c:180
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f9864665ae9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9861bdb218 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00007f9864778f68 RCX: 00007f9864665ae9
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007f9864778f6c
RBP: 00007f9864778f60 R08: 000000000000000e R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f9864778f6c
R13: 00007fffa08fe9df R14: 00007f9861bdb300 R15: 0000000000022000
 </TASK>
----------------
Code disassembly (best guess):
   0:	9c                   	pushfq
   1:	8f 44 24 20          	popq   0x20(%rsp)
   5:	42 80 3c 23 00       	cmpb   $0x0,(%rbx,%r12,1)
   a:	74 08                	je     0x14
   c:	4c 89 f7             	mov    %r14,%rdi
   f:	e8 62 0e ce f7       	callq  0xf7ce0e76
  14:	f6 44 24 21 02       	testb  $0x2,0x21(%rsp)
  19:	75 4e                	jne    0x69
  1b:	41 f7 c7 00 02 00 00 	test   $0x200,%r15d
  22:	74 01                	je     0x25
  24:	fb                   	sti
  25:	bf 01 00 00 00       	mov    $0x1,%edi
* 2a:	e8 67 26 58 f7       	callq  0xf7582696 <-- trapping instruction
  2f:	65 8b 05 68 aa 00 76 	mov    %gs:0x7600aa68(%rip),%eax        # 0x7600aa9e
  36:	85 c0                	test   %eax,%eax
  38:	74 3f                	je     0x79
  3a:	48                   	rex.W
  3b:	c7                   	.byte 0xc7
  3c:	04 24                	add    $0x24,%al
  3e:	0e                   	(bad)
  3f:	36                   	ss


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

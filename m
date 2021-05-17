Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F76382990
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbhEQKNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:13:44 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:48810 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhEQKNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:13:42 -0400
Received: by mail-il1-f200.google.com with SMTP id h4-20020a926c040000b0290192f4fa4c3bso5893136ilc.15
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 03:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=oALpm/cLFYAAjto4LlLeYC6dXbaWQKI/A/4g5+LlXzs=;
        b=Nr9JyvqK7RO5aBQWKMNeY5ysWjjzTIM9B6ngPviAEsElEJzbRDTpBcCfyuMm6b3tWU
         a1Z8PSMQd5gNjr7wA+tYFZC4V+JQEptgnR3Rs6hLi5ymc3MiWBKeRbDQoseDrJjQw/7/
         HCM/KMfQhKbrmRP3X5oumR7etcKih0IUEyGlpH3OUy0hUot9BhS4bdBA8b5wjfwFVNs/
         1WuUdXgpfpMUpZNR2sjG+scVJEfOfKfNH5pJcR7qwsc9ObzVjeqF1IizOEGfsQo8pGWB
         16Ld6l6Kd7bIWldEgYVj44tQNbmt/Wo+zV75INgB+WqlhWP9SEmkxhupJdc8d8tQGTOl
         EYGg==
X-Gm-Message-State: AOAM533DvXCLJUC1pU+NTXTfJgGG2lF+Bv3HdBGLJDUERiJeWouuluKN
        fXe4rVsWv4YMJ8+S/1DYha7akMWB0lsvF9vVqiPgtj23quE4
X-Google-Smtp-Source: ABdhPJwXbtaOg3Lat7TRQJ3yDyNJl8iiDZ1TO/5wkhkmDjstbK6o2fVm9b6GKRE9Fyjs8xLdAdQnoOb1V8I59cxATf4pBV0Y0UB4
MIME-Version: 1.0
X-Received: by 2002:a02:3406:: with SMTP id x6mr54775748jae.137.1621246345937;
 Mon, 17 May 2021 03:12:25 -0700 (PDT)
Date:   Mon, 17 May 2021 03:12:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b0af105c283d4d8@google.com>
Subject: [syzbot] INFO: rcu detected stall in sys_open (3)
From:   syzbot <syzbot+722e26bca192a00fe8ee@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e99d8a84 Add linux-next specific files for 20210409
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1777a745d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7cd69574979bfeb7
dashboard link: https://syzkaller.appspot.com/bug?extid=722e26bca192a00fe8ee
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179ad736d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15984e9ad00000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=110bad36d00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=130bad36d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=150bad36d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+722e26bca192a00fe8ee@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	0-...!: (1 GPs behind) idle=826/1/0x4000000000000000 softirq=9816/9822 fqs=0 
	(t=10500 jiffies g=10153 q=86)
rcu: rcu_preempt kthread starved for 10500 jiffies! g10153 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:29008 pid:   14 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:4329 [inline]
 __schedule+0x917/0x2170 kernel/sched/core.c:5079
 schedule+0xcf/0x270 kernel/sched/core.c:5158
 schedule_timeout+0x14a/0x250 kernel/time/timer.c:1878
 rcu_gp_fqs_loop kernel/rcu/tree.c:1983 [inline]
 rcu_gp_kthread+0xd33/0x2300 kernel/rcu/tree.c:2156
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 8440 Comm: syz-executor021 Not tainted 5.12.0-rc6-next-20210409-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__raw_callee_save___pv_queued_spin_unlock+0xc/0x12
Code: 56 57 41 50 41 51 41 52 41 53 e8 af 15 00 00 41 5b 41 5a 41 59 41 58 5f 5e 5a 59 c3 66 90 52 b8 01 00 00 00 31 d2 f0 0f b0 17 <3c> 01 75 02 5a c3 56 0f b6 f0 e8 c5 ff ff ff 5e 5a c3 66 90 48 b8
RSP: 0018:ffffc90000dc0de8 EFLAGS: 00000046
RAX: 0000000000000001 RBX: 0000000000000046 RCX: ffffffff815a4640
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff8880b9d26380
RBP: ffff8880b9d26380 R08: 0000000000000000 R09: ffff8880b9d26383
R10: ffffed10173a4c70 R11: 0000000000000000 R12: ffff8880b9d26388
R13: ffff8880b9d26390 R14: ffff8880b9d26380 R15: ffffffff819153e0
FS:  000000000093c3c0(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc81d37000 CR3: 0000000014041000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 pv_queued_spin_unlock arch/x86/include/asm/paravirt.h:590 [inline]
 queued_spin_unlock arch/x86/include/asm/qspinlock.h:56 [inline]
 do_raw_spin_unlock+0x171/0x230 kernel/locking/spinlock_debug.c:139
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:159 [inline]
 _raw_spin_unlock_irqrestore+0x1e/0x70 kernel/locking/spinlock.c:191
 __run_hrtimer kernel/time/hrtimer.c:1533 [inline]
 __hrtimer_run_queues+0x51a/0xe50 kernel/time/hrtimer.c:1601
 hrtimer_interrupt+0x330/0xa00 kernel/time/hrtimer.c:1663
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1089 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x540 arch/x86/kernel/apic/apic.c:1106
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1100
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:632
RIP: 0010:check_kcov_mode+0x7/0x40 kernel/kcov.c:163
Code: fe ff ff 48 89 df e8 58 d3 44 00 e9 a1 fe ff ff 48 8b 3c 24 e8 4a d3 44 00 e9 18 fe ff ff cc cc cc cc cc 65 8b 05 c9 c7 8d 7e <89> c2 81 e2 00 01 00 00 a9 00 01 ff 00 74 10 31 c0 85 d2 74 15 8b
RSP: 0018:ffffc9000167ea08 EFLAGS: 00000246
RAX: 0000000080000000 RBX: 0000000000000001 RCX: ffff88802149d580
RDX: fffff94000212ef9 RSI: ffff88802149d580 RDI: 0000000000000003
RBP: ffffea00010977c0 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff81d3faaa R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: fffff94000212ef8 R15: 0000000000000000
 write_comp_data kernel/kcov.c:218 [inline]
 __sanitizer_cov_trace_const_cmp1+0x22/0x80 kernel/kcov.c:270
 compound_nr include/linux/mm.h:981 [inline]
 zero_user_segments+0x37a/0x4c0 include/linux/highmem.h:231
 zero_user include/linux/highmem.h:245 [inline]
 block_read_full_page+0x96f/0xe40 fs/buffer.c:2351
 read_pages+0x5c5/0x8d0 mm/readahead.c:145
 page_cache_ra_unbounded+0x5fe/0x920 mm/readahead.c:238
 do_page_cache_ra mm/readahead.c:267 [inline]
 ondemand_readahead+0x61e/0x11a0 mm/readahead.c:550
 page_cache_async_ra mm/readahead.c:607 [inline]
 page_cache_async_ra+0x2e1/0x3f0 mm/readahead.c:582
 page_cache_async_readahead include/linux/pagemap.h:901 [inline]
 filemap_readahead mm/filemap.c:2434 [inline]
 filemap_get_pages+0x60a/0x1920 mm/filemap.c:2475
 filemap_read+0x2ca/0xe40 mm/filemap.c:2542
 generic_file_read_iter+0x397/0x4f0 mm/filemap.c:2693
 __kernel_read+0x58d/0xa90 fs/read_write.c:454
 integrity_kernel_read+0x7b/0xb0 security/integrity/iint.c:199
 ima_calc_file_hash_tfm+0x2aa/0x3b0 security/integrity/ima/ima_crypto.c:484
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:515 [inline]
 ima_calc_file_hash+0x19d/0x4b0 security/integrity/ima/ima_crypto.c:572
 ima_collect_measurement+0x4ca/0x570 security/integrity/ima/ima_api.c:252
 process_measurement+0xd1c/0x17e0 security/integrity/ima/ima_main.c:330
 ima_file_check+0xb1/0x100 security/integrity/ima/ima_main.c:499
 do_open fs/namei.c:3363 [inline]
 path_openat+0x15b0/0x27d0 fs/namei.c:3494
 do_filp_open+0x190/0x3d0 fs/namei.c:3521
 do_sys_openat2+0x16d/0x420 fs/open.c:1187
 do_sys_open fs/open.c:1203 [inline]
 __do_sys_open fs/open.c:1211 [inline]
 __se_sys_open fs/open.c:1207 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1207
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x445d39
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c4 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc81d36578 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007ffc81d365b0 RCX: 0000000000445d39
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000200000c0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000f4240
R13: 0000000000000000 R14: 00007ffc81d3659c R15: 00007ffc81d365a0
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.861 msecs
NMI backtrace for cpu 0
CPU: 0 PID: 8434 Comm: syz-executor021 Not tainted 5.12.0-rc6-next-20210409-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
 rcu_dump_cpu_stacks+0x25e/0x3f0 kernel/rcu/tree_stall.h:341
 print_cpu_stall kernel/rcu/tree_stall.h:624 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:699 [inline]
 rcu_pending kernel/rcu/tree.c:3889 [inline]
 rcu_sched_clock_irq.cold+0x3f1/0x74b kernel/rcu/tree.c:2628
 update_process_times+0x16d/0x200 kernel/time/timer.c:1782
 tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:226
 tick_sched_timer+0x1b0/0x2d0 kernel/time/tick-sched.c:1373
 __run_hrtimer kernel/time/hrtimer.c:1537 [inline]
 __hrtimer_run_queues+0x1c0/0xe50 kernel/time/hrtimer.c:1601
 hrtimer_interrupt+0x330/0xa00 kernel/time/hrtimer.c:1663
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1089 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x540 arch/x86/kernel/apic/apic.c:1106
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1100
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:632
RIP: 0010:preempt_count_add+0x26/0x140 kernel/sched/core.c:4729
Code: 0f 1f 40 00 48 c7 c0 20 97 e8 8f 55 48 ba 00 00 00 00 00 fc ff df 48 89 c1 53 83 e0 07 89 fb 48 c1 e9 03 83 c0 03 0f b6 14 11 <38> d0 7c 08 84 d2 0f 85 e1 00 00 00 8b 15 88 36 9a 0e 65 01 1d 21
RSP: 0018:ffffc900017464e0 EFLAGS: 00000206
RAX: 0000000000000003 RBX: 0000000000000001 RCX: 1ffffffff1fd12e4
RDX: 0000000000000004 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffff8e4bf296 R09: 0000000000000001
R10: fffff520002e8cc5 R11: 0000000000084087 R12: ffffc90001746618
R13: 0000000000000000 R14: ffffc900017465d0 R15: 0000000000408d40
 unwind_next_frame+0x120/0x1ce0 arch/x86/kernel/unwind_orc.c:428
 arch_stack_walk+0x7d/0xe0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:121
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:428 [inline]
 __kasan_slab_alloc+0x84/0xa0 mm/kasan/common.c:461
 kasan_slab_alloc include/linux/kasan.h:236 [inline]
 slab_post_alloc_hook mm/slab.h:527 [inline]
 slab_alloc_node mm/slub.c:2924 [inline]
 slab_alloc mm/slub.c:2932 [inline]
 kmem_cache_alloc+0x153/0x390 mm/slub.c:2937
 kmem_cache_zalloc include/linux/slab.h:678 [inline]
 alloc_buffer_head+0x20/0x140 fs/buffer.c:3409
 alloc_page_buffers+0x280/0x750 fs/buffer.c:857
 create_empty_buffers+0x2c/0x820 fs/buffer.c:1618
 create_page_buffers+0x2ac/0x3c0 fs/buffer.c:1735
 block_read_full_page+0xc9/0xe40 fs/buffer.c:2326
 read_pages+0x5c5/0x8d0 mm/readahead.c:145
 page_cache_ra_unbounded+0x5fe/0x920 mm/readahead.c:238
 do_page_cache_ra mm/readahead.c:267 [inline]
 ondemand_readahead+0x61e/0x11a0 mm/readahead.c:550
 page_cache_async_ra mm/readahead.c:607 [inline]
 page_cache_async_ra+0x2e1/0x3f0 mm/readahead.c:582
 page_cache_async_readahead include/linux/pagemap.h:901 [inline]
 filemap_readahead mm/filemap.c:2434 [inline]
 filemap_get_pages+0x60a/0x1920 mm/filemap.c:2475
 filemap_read+0x2ca/0xe40 mm/filemap.c:2542
 generic_file_read_iter+0x397/0x4f0 mm/filemap.c:2693
 __kernel_read+0x58d/0xa90 fs/read_write.c:454
 integrity_kernel_read+0x7b/0xb0 security/integrity/iint.c:199
 ima_calc_file_hash_tfm+0x2aa/0x3b0 security/integrity/ima/ima_crypto.c:484
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:515 [inline]
 ima_calc_file_hash+0x19d/0x4b0 security/integrity/ima/ima_crypto.c:572
 ima_collect_measurement+0x4ca/0x570 security/integrity/ima/ima_api.c:252
 process_measurement+0xd1c/0x17e0 security/integrity/ima/ima_main.c:330
 ima_file_check+0xb1/0x100 security/integrity/ima/ima_main.c:499
 do_open fs/namei.c:3363 [inline]
 path_openat+0x15b0/0x27d0 fs/namei.c:3494
 do_filp_open+0x190/0x3d0 fs/namei.c:3521
 do_sys_openat2+0x16d/0x420 fs/open.c:1187
 do_sys_open fs/open.c:1203 [inline]
 __do_sys_open fs/open.c:1211 [inline]
 __se_sys_open fs/open.c:1207 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1207
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x445d39
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c4 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc81d36578 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007ffc81d365b0 RCX: 0000000000445d39
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000200000c0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000f4240
R13: 0000000000000000 R14: 00007ffc81d3659c R15: 00007ffc81d365a0
sched: RT throttling activated


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

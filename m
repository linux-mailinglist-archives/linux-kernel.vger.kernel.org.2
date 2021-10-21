Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDD9436B57
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 21:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhJUTbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 15:31:44 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:45890 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJUTbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 15:31:42 -0400
Received: by mail-io1-f69.google.com with SMTP id k9-20020a5d91c9000000b005dc4a740599so1163701ior.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 12:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=u3TMmRqhW6XSi4YAf4Pjl85XzF3f4dzaHbLnccm+TPc=;
        b=TeJMl8vO5vB7hvVDlzhw90SWacrTPOzTOHKSl14h6j7IrcadSgvh1+d2UXvNOOIYLV
         NN00MkTKuS5PKeHTcN1GlTKtwmM9AytNY4+4U1ZAOR7HkqRFpBeYZL2t7BxU0qIafZ/W
         s1YbABjo5TSbja/29aoOSGNHVHX2T7gkn28F22qvXTBFo5um/XNtgjLmBiA+9lg+kYEh
         NNWaJv0cOqYMSn7+o8n2zKd/v+ET7vabhcRuNiOVwaorMfqgHHL5L87kexjpTpJhN0qi
         fI3o/zXX5uMWaIfxgWPmYM9Nrlx3o3RWR1YHa16eHULRwSGB0QkPezJ5N5ec7ZeNrni/
         OKCA==
X-Gm-Message-State: AOAM5302P5asUGon470D9jXLTHxJ8hyo5hWFVZk/buiwGnjckcwBJGUB
        Hq4y/nXddZ+8gAKA+sKskakY7K1mwGY6f3pdq+ePlRA+8Etp
X-Google-Smtp-Source: ABdhPJyzf97Ea9oP4v8f8m/0tBn0ou4UBQxjRYO2KJnODz4YmZAHHfZaakQMF9LOrBlUYeqNN25Q1iPu87Aw2McGadRxe15u4z4g
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13d3:: with SMTP id o19mr5213955iov.18.1634844566498;
 Thu, 21 Oct 2021 12:29:26 -0700 (PDT)
Date:   Thu, 21 Oct 2021 12:29:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a636fc05cee1e95b@google.com>
Subject: [syzbot] INFO: rcu detected stall in sys_bpf (5)
From:   syzbot <syzbot+7caa651776c38f7fed6c@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d5ad8ec3cfb5 Merge tag 'media/v5.14-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c8f156300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=343fd21f6f4da2d6
dashboard link: https://syzkaller.appspot.com/bug?extid=7caa651776c38f7fed6c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7caa651776c38f7fed6c@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	0-...!: (10499 ticks this GP) idle=6fe/1/0x4000000000000000 softirq=11506/11506 fqs=0 
	(t=10500 jiffies g=12629 q=419)
rcu: rcu_preempt kthread starved for 10500 jiffies! g12629 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:28864 pid:   14 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0x93a/0x26f0 kernel/sched/core.c:5940
 schedule+0xd3/0x270 kernel/sched/core.c:6019
 schedule_timeout+0x14a/0x2a0 kernel/time/timer.c:1879
 rcu_gp_fqs_loop kernel/rcu/tree.c:1996 [inline]
 rcu_gp_kthread+0xd34/0x1980 kernel/rcu/tree.c:2169
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 10160 Comm: syz-executor.0 Not tainted 5.14.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:check_preemption_disabled+0x3e/0x140 lib/smp_processor_id.c:56
Code: 44 8b 25 6d 5c d7 76 65 8b 1d be b6 d7 76 81 e3 ff ff ff 7f 31 ff 89 de 0f 1f 44 00 00 85 db 74 11 0f 1f 44 00 00 44 89 e0 5b <5d> 41 5c 41 5d 41 5e c3 0f 1f 44 00 00 9c 5b 81 e3 00 02 00 00 31
RSP: 0018:ffffc90000dc0a48 EFLAGS: 00000002
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000104 RDI: 0000000000000000
RBP: ffffffff89e3b620 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff817bc0b5 R11: 0000000000000000 R12: 0000000000000001
R13: ffffffff898bdc20 R14: 00000000ffffffff R15: 0000000000000000
FS:  00007fd1f2445700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000542978 CR3: 00000000333a4000 CR4: 0000000000350ee0
Call Trace:
 <IRQ>
 lockdep_recursion_inc kernel/locking/lockdep.c:433 [inline]
 lock_is_held_type+0x63/0x140 kernel/locking/lockdep.c:5667
 lock_is_held include/linux/lockdep.h:283 [inline]
 rcu_read_lock_sched_held+0x3a/0x70 kernel/rcu/update.c:125
 trace_irq_disable include/trace/events/preemptirq.h:36 [inline]
 trace_hardirqs_off_finish kernel/trace/trace_preemptirq.c:67 [inline]
 trace_hardirqs_off_finish+0xd1/0x270 kernel/trace/trace_preemptirq.c:61
 irqentry_enter+0x28/0x50 kernel/entry/common.c:379
 sysvec_irq_work+0xb/0xc0 arch/x86/kernel/irq_work.c:17
 asm_sysvec_irq_work+0x12/0x20 arch/x86/include/asm/idtentry.h:664
RIP: 0010:mac80211_hwsim_tx_frame_no_nl.isra.0+0xbcc/0x1330 drivers/net/wireless/mac80211_hwsim.c:1580
Code: e8 89 7d 89 fc 48 8d bb 20 3e 00 00 4c 8b 54 24 08 48 89 f8 48 c1 e8 03 80 3c 28 00 0f 85 55 07 00 00 48 83 83 20 3e 00 00 01 <48> 8d bb 30 3e 00 00 48 89 f8 48 c1 e8 03 80 3c 28 00 0f 85 e7 06
RSP: 0018:ffffc90000dc0ba0 EFLAGS: 00000202
RAX: 1ffff11003f5ee10 RBX: ffff88801faf3260 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffc90000dc0c80 RDI: ffff88801faf7080
RBP: dffffc0000000000 R08: 0000000000000001 R09: ffff88806dcf1197
R10: ffff88806dcf1140 R11: 0000000000000000 R12: ffff88806dcf1000
R13: ffff8880801bb490 R14: ffff8880801bb260 R15: 0000000000000000
 mac80211_hwsim_tx_frame+0x1ee/0x2a0 drivers/net/wireless/mac80211_hwsim.c:1784
 mac80211_hwsim_beacon_tx+0x49b/0x930 drivers/net/wireless/mac80211_hwsim.c:1838
 __iterate_interfaces+0x1e5/0x520 net/mac80211/util.c:793
 ieee80211_iterate_active_interfaces_atomic+0x70/0x180 net/mac80211/util.c:829
 mac80211_hwsim_beacon+0xd5/0x1a0 drivers/net/wireless/mac80211_hwsim.c:1861
 __run_hrtimer kernel/time/hrtimer.c:1537 [inline]
 __hrtimer_run_queues+0x609/0xe50 kernel/time/hrtimer.c:1601
 hrtimer_run_softirq+0x17b/0x360 kernel/time/hrtimer.c:1618
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 invoke_softirq kernel/softirq.c:432 [inline]
 __irq_exit_rcu+0x16e/0x1c0 kernel/softirq.c:636
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:648
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1100
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:161 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x38/0x70 kernel/locking/spinlock.c:191
Code: 74 24 10 e8 9a 3b 2e f8 48 89 ef e8 42 b1 2e f8 81 e3 00 02 00 00 75 25 9c 58 f6 c4 02 75 2d 48 85 db 74 01 fb bf 01 00 00 00 <e8> 23 8b 22 f8 65 8b 05 3c 16 d5 76 85 c0 74 0a 5b 5d c3 e8 b0 e4
RSP: 0018:ffffc900022bf4e8 EFLAGS: 00000206
RAX: 0000000000000006 RBX: 0000000000000200 RCX: 1ffffffff1f9af2a
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000001
RBP: ffffffff903d0690 R08: 0000000000000001 R09: ffffffff8fcd48a7
R10: 0000000000000001 R11: 000000000000003f R12: 1ffffffff207a0d1
R13: 0000000000000000 R14: dead000000000100 R15: dffffc0000000000
 __debug_check_no_obj_freed lib/debugobjects.c:997 [inline]
 debug_check_no_obj_freed+0x20c/0x420 lib/debugobjects.c:1018
 slab_free_hook mm/slub.c:1600 [inline]
 slab_free_freelist_hook+0x171/0x240 mm/slub.c:1650
 slab_free mm/slub.c:3210 [inline]
 kmem_cache_free+0x8a/0x5b0 mm/slub.c:3226
 merge_or_add_vmap_area mm/vmalloc.c:1077 [inline]
 merge_or_add_vmap_area_augment mm/vmalloc.c:1127 [inline]
 __purge_vmap_area_lazy+0xaa7/0x1c50 mm/vmalloc.c:1663
 _vm_unmap_aliases.part.0+0x3f0/0x500 mm/vmalloc.c:2073
 _vm_unmap_aliases mm/vmalloc.c:2047 [inline]
 vm_unmap_aliases+0x47/0x50 mm/vmalloc.c:2096
 change_page_attr_set_clr+0x241/0x500 arch/x86/mm/pat/set_memory.c:1740
 change_page_attr_clear arch/x86/mm/pat/set_memory.c:1797 [inline]
 set_memory_ro+0x78/0xa0 arch/x86/mm/pat/set_memory.c:1943
 bpf_jit_binary_lock_ro include/linux/filter.h:866 [inline]
 bpf_int_jit_compile+0xe36/0x11e0 arch/x86/net/bpf_jit_comp.c:2319
 bpf_prog_select_runtime+0x464/0x6a0 kernel/bpf/core.c:1909
 bpf_prog_load+0xe8b/0x21f0 kernel/bpf/syscall.c:2278
 __sys_bpf+0x65a/0x53b0 kernel/bpf/syscall.c:4469
 __do_sys_bpf kernel/bpf/syscall.c:4573 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:4571 [inline]
 __x64_sys_bpf+0x75/0xb0 kernel/bpf/syscall.c:4571
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665e9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd1f2445188 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665e9
RDX: 0000000000000048 RSI: 00000000200054c0 RDI: 0000000000000005
RBP: 00000000004bfcc4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
R13: 00007ffc3864649f R14: 00007fd1f2445300 R15: 0000000000022000
NMI backtrace for cpu 0
CPU: 0 PID: 6191 Comm: kworker/u4:7 Not tainted 5.14.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound call_usermodehelper_exec_work
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
 rcu_dump_cpu_stacks+0x25e/0x3f0 kernel/rcu/tree_stall.h:342
 print_cpu_stall kernel/rcu/tree_stall.h:625 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:700 [inline]
 rcu_pending kernel/rcu/tree.c:3922 [inline]
 rcu_sched_clock_irq.cold+0x9f/0x747 kernel/rcu/tree.c:2641
 update_process_times+0x16d/0x200 kernel/time/timer.c:1783
 tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:226
 tick_sched_timer+0x1b0/0x2d0 kernel/time/tick-sched.c:1421
 __run_hrtimer kernel/time/hrtimer.c:1537 [inline]
 __hrtimer_run_queues+0x1c0/0xe50 kernel/time/hrtimer.c:1601
 hrtimer_interrupt+0x330/0xa00 kernel/time/hrtimer.c:1663
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1089 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x530 arch/x86/kernel/apic/apic.c:1106
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1100
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:arch_safe_halt arch/x86/include/asm/irqflags.h:90 [inline]
RIP: 0010:kvm_wait arch/x86/kernel/kvm.c:888 [inline]
RIP: 0010:kvm_wait+0xaf/0xf0 arch/x86/kernel/kvm.c:871
Code: 10 c3 c3 89 74 24 0c 48 89 3c 24 e8 4b a3 48 00 8b 74 24 0c 48 8b 3c 24 eb 82 e8 5c a8 48 00 eb 07 0f 00 2d d3 d3 55 08 fb f4 <eb> 9b eb 07 0f 00 2d c6 d3 55 08 f4 eb c5 89 74 24 0c 48 89 3c 24
RSP: 0018:ffffc9000966f530 EFLAGS: 00000202
RAX: 000000000009b52f RBX: 0000000000000000 RCX: 1ffffffff1f9af2a
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffffff8ba97c60 R08: 0000000000000001 R09: ffffffff8fcd48a7
R10: 0000000000000001 R11: 0000000000086088 R12: 0000000000000000
R13: fffffbfff1752f8c R14: 0000000000000001 R15: ffff8880b9c52880
 pv_wait arch/x86/include/asm/paravirt.h:597 [inline]
 pv_wait_head_or_lock kernel/locking/qspinlock_paravirt.h:470 [inline]
 __pv_queued_spin_lock_slowpath+0x8b8/0xb40 kernel/locking/qspinlock.c:508
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:585 [inline]
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:85 [inline]
 do_raw_spin_lock+0x200/0x2b0 kernel/locking/spinlock_debug.c:113
 spin_lock include/linux/spinlock.h:354 [inline]
 preload_this_cpu_lock mm/vmalloc.c:1466 [inline]
 alloc_vmap_area+0x1dd/0x1e30 mm/vmalloc.c:1507
 __get_vm_area_node.constprop.0+0x128/0x380 mm/vmalloc.c:2389
 __vmalloc_node_range+0x12e/0x960 mm/vmalloc.c:2956
 alloc_thread_stack_node kernel/fork.c:245 [inline]
 dup_task_struct kernel/fork.c:875 [inline]
 copy_process+0x8db/0x74d0 kernel/fork.c:1952
 kernel_clone+0xe7/0xac0 kernel/fork.c:2509
 kernel_thread+0xb5/0xf0 kernel/fork.c:2561
 call_usermodehelper_exec_work kernel/umh.c:174 [inline]
 call_usermodehelper_exec_work+0xcc/0x180 kernel/umh.c:160
 process_one_work+0x98d/0x1630 kernel/workqueue.c:2276
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

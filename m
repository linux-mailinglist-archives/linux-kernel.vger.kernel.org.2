Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C05944CE93
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 02:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhKKBKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 20:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbhKKBKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 20:10:12 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CD6C061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 17:07:24 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so3345484pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 17:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=pP5dUx5pGPNOtP2rZLfogvDDuT7gFNuhNcI+z6cRDtE=;
        b=FMow5vE2s8EJ/v1zJNkD5kwYmaQxxHgj3OW8/r/J7VYkuBI+iWP+Wkhir5SX43+B0C
         fRRJbUA9EKo6/aERhRHokBpQYX13r7nxIo3ngHJ9LpRw0f65J93Yw4EWXfOfbh5lmQjE
         t2DzjkjXe+et4OG8g5IN/UmbBUzEg7LoXOP1t6imgXVkgTicnEDqek2Bzib6GMq6whjE
         QFk3DplZMTdydsOJSzt+JfTpaHk7kbGeyZjFtFqs1X0TvLxfxemXimmKKa3myf7aTOhe
         7SWREBqCE/A5WPb4Aika/6NEj4BTxF8eaRF5Qrr9VFcYNdGRDA7GXLY6ri8y2cNt45h7
         rOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pP5dUx5pGPNOtP2rZLfogvDDuT7gFNuhNcI+z6cRDtE=;
        b=4RoKgk6Wrng249yep/6fJglTDNVCluZD817G2htXwifSMErkmmFbmNAVO8rNBs/fBx
         xHxhUe7CPHMa/yE8Cq9nann/c1gPrxSmtpkWTNXytLrSoq4BZN9AtcwrGbv+CYUJ91YH
         Uefoj+s8oaRgp0HnD7xzSHxWB6XA4hofBg7n2vbJ+2EVOJdXVK6OBeBjN04/3ej5G7va
         uRwf3ZmMQiCmGR0wsIEeIlfZBV8RrL/1iaHdcivl+ZUEi3+DzCVioIJifRG1q2d+95DD
         +iXkMo2d7ELDngtHkBeW6hWOxDO6FuC52ykFFWPf+eeiBevDWHCydndvXN4Fx6SgegDQ
         GTTQ==
X-Gm-Message-State: AOAM530wC+CIiPpK+HXvcs6dwmMrtiLq+6a2U5NmOdlFKGvWJErYJpM2
        AxwUKh2/phy5QlkVQrpDc20KPKY5038NYdHEBQ==
X-Google-Smtp-Source: ABdhPJwZS/0NBk8yT8Xe+Gblcv6nLstooit4R8TB3vNQHHCeVxwi2Q4WU0322sT6mO1IYd6Gwxw+uN4ShtmLQ4L/rrs=
X-Received: by 2002:a17:903:2348:b0:141:d60b:ee90 with SMTP id
 c8-20020a170903234800b00141d60bee90mr3362026plh.15.1636592844030; Wed, 10 Nov
 2021 17:07:24 -0800 (PST)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Thu, 11 Nov 2021 09:07:13 +0800
Message-ID: <CACkBjsY0YC0e0zp3c7qesoKeB6_8VLm-3oM9ip3uH_kREwvXDA@mail.gmail.com>
Subject: INFO: rcu detected stall in sys_mount
To:     fweisbec@gmail.com, mingo@kernel.org, tglx@linutronix.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 6b75d88fa81b Merge branch 'i2c/for-current'
git tree: upstream
console output: https://paste.ubuntu.com/p/WRYYcxk98X/plain/
kernel config: https://paste.ubuntu.com/p/b62Hp7BfJn/plain/

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 1-....: (10494 ticks this GP) idle=953/1/0x4000000000000000
softirq=37318/37318 fqs=5160
(t=10500 jiffies g=85513 q=25640)
NMI backtrace for cpu 1
CPU: 1 PID: 16508 Comm: syz-executor Not tainted 5.15.0+ #6
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1e1/0x220 lib/nmi_backtrace.c:62
 trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
 rcu_dump_cpu_stacks+0x25e/0x3f0 kernel/rcu/tree_stall.h:343
 print_cpu_stall kernel/rcu/tree_stall.h:627 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:711 [inline]
 rcu_pending kernel/rcu/tree.c:3878 [inline]
 rcu_sched_clock_irq.cold+0xe1/0x7db kernel/rcu/tree.c:2597
 update_process_times+0x16d/0x200 kernel/time/timer.c:1785
 tick_sched_handle.isra.0+0x91/0x180 kernel/time/tick-sched.c:226
 tick_sched_timer+0xee/0x120 kernel/time/tick-sched.c:1421
 __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
 __hrtimer_run_queues+0x5f0/0xdf0 kernel/time/hrtimer.c:1749
 hrtimer_interrupt+0x31c/0x790 kernel/time/hrtimer.c:1811
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x540 arch/x86/kernel/apic/apic.c:1103
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:__sanitizer_cov_trace_pc+0x25/0x40 kernel/kcov.c:203
Code: 00 00 0f 1f 00 65 48 8b 0c 25 40 70 02 00 bf 02 00 00 00 48 89
ce 4c 8b 04 24 e8 76 ff ff ff 84 c0 74 20 48 8b 91 48 15 00 00 <8b> 89
44 15 00 00 48 8b 02 48 83 c0 01 48 39 c1 76 07 4c 89 04 c2
RSP: 0018:ffffc9000771f560 EFLAGS: 00000202
RAX: 0000000000000001 RBX: fffffffffffffe00 RCX: ffff8880244c8000
RDX: ffffc90002721000 RSI: ffff8880244c8000 RDI: 0000000000000002
RBP: ffffc9000771f728 R08: ffffffff88b8e608 R09: 0000000000000002
R10: 0000000000000005 R11: ffffed1020ad7222 R12: ffff8881056b9100
R13: ffffc9000771f620 R14: ffff8881056b9110 R15: 0000000000000002
 p9_client_rpc+0x3e8/0x11c0 net/9p/client.c:761
 p9_client_flush+0xe9/0x1e0 net/9p/client.c:669
 p9_client_rpc+0x107c/0x11c0 net/9p/client.c:786
 p9_client_version net/9p/client.c:957 [inline]
 p9_client_create+0xbe0/0x13f0 net/9p/client.c:1057
 v9fs_session_init+0x1e4/0x1900 fs/9p/v9fs.c:407
 v9fs_mount+0x73/0x9d0 fs/9p/vfs_super.c:126
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1500
 do_new_mount fs/namespace.c:2988 [inline]
 path_mount+0x1228/0x1cb0 fs/namespace.c:3318
 do_mount+0xf3/0x110 fs/namespace.c:3331
 __do_sys_mount fs/namespace.c:3539 [inline]
 __se_sys_mount fs/namespace.c:3516 [inline]
 __x64_sys_mount+0x18f/0x230 fs/namespace.c:3516
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f6bb1de2c4d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6baf34ac58 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f6bb1f090a0 RCX: 00007f6bb1de2c4d
RDX: 0000000020000180 RSI: 0000000020000140 RDI: 0000000000000000
RBP: 00007f6bb1e5bd80 R08: 00000000200001c0 R09: 0000000000000000
R10: 0000000000018c19 R11: 0000000000000246 R12: 00007f6bb1f090a0
R13: 00007ffe6ce92aef R14: 00007ffe6ce92c90 R15: 00007f6baf34adc0
 </TASK>
watchdog: BUG: soft lockup - CPU#1 stuck for 268s! [syz-executor:16508]
Modules linked in:
irq event stamp: 0
hardirqs last  enabled at (0): [<0000000000000000>] 0x0
hardirqs last disabled at (0): [<ffffffff814496f9>]
copy_process+0x1dd9/0x73e0 kernel/fork.c:2132
softirqs last  enabled at (0): [<ffffffff8144973a>]
copy_process+0x1e1a/0x73e0 kernel/fork.c:2136
softirqs last disabled at (0): [<0000000000000000>] 0x0
CPU: 1 PID: 16508 Comm: syz-executor Not tainted 5.15.0+ #6
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:_raw_spin_lock_irqsave+0x0/0x50 kernel/locking/spinlock.c:161
Code: 8d 7d 18 31 d2 31 f6 e8 fe 18 24 f8 48 89 ef 58 5d e9 c4 9d 24
f8 e8 8f 10 45 f8 eb c9 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 <41> 54
55 48 89 fd 9c 41 5c fa 41 f7 c4 00 02 00 00 75 36 bf 01 00
RSP: 0018:ffffc9000771f510 EFLAGS: 00000296
RAX: 0000000000040000 RBX: 0000000000000102 RCX: 0000000000040000
RDX: 0000000000000102 RSI: ffffc9000771f620 RDI: ffff8881056b9110
RBP: ffffc9000771f620 R08: ffffffff88b8e62a R09: 0000000000000002
R10: 0000000000000005 R11: ffffed1004899000 R12: ffff8881056b9110
R13: ffffc9000771f620 R14: ffff8881056b9110 R15: 0000000000000002
FS:  00007f6baf34b700(0000) GS:ffff888135c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6bb1e4b7f8 CR3: 00000000158c9000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 prepare_to_wait_event+0x1b/0x680 kernel/sched/wait.c:300
 p9_client_rpc+0x41a/0x11c0 net/9p/client.c:761
 p9_client_flush+0xe9/0x1e0 net/9p/client.c:669
 p9_client_rpc+0x107c/0x11c0 net/9p/client.c:786
 p9_client_version net/9p/client.c:957 [inline]
 p9_client_create+0xbe0/0x13f0 net/9p/client.c:1057
 v9fs_session_init+0x1e4/0x1900 fs/9p/v9fs.c:407
 v9fs_mount+0x73/0x9d0 fs/9p/vfs_super.c:126
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1500
 do_new_mount fs/namespace.c:2988 [inline]
 path_mount+0x1228/0x1cb0 fs/namespace.c:3318
 do_mount+0xf3/0x110 fs/namespace.c:3331
 __do_sys_mount fs/namespace.c:3539 [inline]
 __se_sys_mount fs/namespace.c:3516 [inline]
 __x64_sys_mount+0x18f/0x230 fs/namespace.c:3516
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f6bb1de2c4d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6baf34ac58 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f6bb1f090a0 RCX: 00007f6bb1de2c4d
RDX: 0000000020000180 RSI: 0000000020000140 RDI: 0000000000000000
RBP: 00007f6bb1e5bd80 R08: 00000000200001c0 R09: 0000000000000000
R10: 0000000000018c19 R11: 0000000000000246 R12: 00007f6bb1f090a0
R13: 00007ffe6ce92aef R14: 00007ffe6ce92c90 R15: 00007f6baf34adc0
 </TASK>
Sending NMI from CPU 1 to CPUs 0,2-3:
NMI backtrace for cpu 0
CPU: 0 PID: 9 Comm: kworker/u9:0 Not tainted 5.15.0+ #6
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:csd_lock_wait kernel/smp.c:440 [inline]
RIP: 0010:smp_call_function_many_cond+0x3db/0xc20 kernel/smp.c:969
Code: 0b 00 85 ed 74 4d 48 b8 00 00 00 00 00 fc ff df 4d 89 f4 4c 89
f5 49 c1 ec 03 83 e5 07 49 01 c4 83 c5 03 e8 e7 6e 0b 00 f3 90 <41> 0f
b6 04 24 40 38 c5 7c 08 84 c0 0f 85 a2 06 00 00 8b 43 08 31
RSP: 0018:ffffc900006c7a10 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff888135c3fca0 RCX: ffff888011610000
RDX: 0000000000000000 RSI: ffff888011610000 RDI: 0000000000000002
RBP: 0000000000000003 R08: ffffffff816be2b9 R09: 0000000000000000
R10: 0000000000000005 R11: fffff520000d8f2a R12: ffffed1026b87f95
R13: 0000000000000001 R14: ffff888135c3fca8 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff888063e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3159ef5ab4 CR3: 000000000b68e000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 on_each_cpu_cond_mask+0x56/0xa0 kernel/smp.c:1135
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:1112 [inline]
 text_poke_bp_batch+0x1b3/0x560 arch/x86/kernel/alternative.c:1297
 text_poke_flush arch/x86/kernel/alternative.c:1451 [inline]
 text_poke_finish+0x16/0x30 arch/x86/kernel/alternative.c:1458
 arch_jump_label_transform_apply+0x13/0x20 arch/x86/kernel/jump_label.c:146
 jump_label_update+0x32d/0x440 kernel/jump_label.c:830
 static_key_disable_cpuslocked+0x156/0x1c0 kernel/jump_label.c:207
 static_key_disable+0x16/0x20 kernel/jump_label.c:215
 toggle_allocation_gate mm/kfence/core.c:746 [inline]
 toggle_allocation_gate+0x183/0x390 mm/kfence/core.c:724
 process_one_work+0x9df/0x16d0 kernel/workqueue.c:2298
 worker_thread+0x90/0xed0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
NMI backtrace for cpu 3 skipped: idling at native_safe_halt
arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 3 skipped: idling at arch_safe_halt
arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 3 skipped: idling at default_idle+0xb/0x10
arch/x86/kernel/process.c:733
NMI backtrace for cpu 2 skipped: idling at native_safe_halt
arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 2 skipped: idling at arch_safe_halt
arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 2 skipped: idling at default_idle+0xb/0x10
arch/x86/kernel/process.c:733
----------------
Code disassembly (best guess):
   0: 00 00                add    %al,(%rax)
   2: 0f 1f 00              nopl   (%rax)
   5: 65 48 8b 0c 25 40 70 mov    %gs:0x27040,%rcx
   c: 02 00
   e: bf 02 00 00 00        mov    $0x2,%edi
  13: 48 89 ce              mov    %rcx,%rsi
  16: 4c 8b 04 24          mov    (%rsp),%r8
  1a: e8 76 ff ff ff        callq  0xffffff95
  1f: 84 c0                test   %al,%al
  21: 74 20                je     0x43
  23: 48 8b 91 48 15 00 00 mov    0x1548(%rcx),%rdx
* 2a: 8b 89 44 15 00 00    mov    0x1544(%rcx),%ecx <-- trapping instruction
  30: 48 8b 02              mov    (%rdx),%rax
  33: 48 83 c0 01          add    $0x1,%rax
  37: 48 39 c1              cmp    %rax,%rcx
  3a: 76 07                jbe    0x43
  3c: 4c 89 04 c2          mov    %r8,(%rdx,%rax,8)

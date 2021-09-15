Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDFC40BD7A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 03:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbhIOCAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 22:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbhIOCAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 22:00:38 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54910C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 18:59:20 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id w8so1137221pgf.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 18:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/C/LhyGbRLqEeqH0g5prSRpdtP1xklTNILHX3cvUTzk=;
        b=Yo9asVxVQ4Uo30CZ9zXk5ucuTP8xQ8JuJs1UgIvsm/iRhTfdQWPn8TT+kaKbHCpGjx
         whOIyMlG4k1DZbiRUkwglfWOVu99jrZ9iK9w2TbjBf88dPhJ4kPd86GdTZSsbxHwzIPc
         Iw3V0f9wwG3JKQ3+ddzrJcgnlf1GncBLohB6jvHRg6tFpznFFuCPcG4apHJY3Kbxwfso
         CTWhOa9iTTIc8ewyMZ9iL+ohAL3hUuyOv26ddfyA1rvbMw3K0NQHbIM/jfAk3PUo3wIs
         7Rtf/KRgixyki7aNsh6bUk6tNCK5l/7nPMEXjN3qbHKunZAIH4ZbgPqZaSDonYpish7O
         Fq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/C/LhyGbRLqEeqH0g5prSRpdtP1xklTNILHX3cvUTzk=;
        b=AFi/vPVtPWHlCZk/ggGWohZwYtTM1rExYSKp8KKQCX179B0qSpV3PXaTitbXM6AT7s
         eC425zEBopBNtzbaE24YO4Qy6dj8gCbVzH+5s5GJoZ426BID4BMGCmTUmkvb69keOhsj
         vxe5G/8JoS1tQZN2NyowR97dOrQBmrxRKUGH5JJ9wnnB2W+S3SVzK6Aef64it3TyIB+W
         wm2Fin7sfhFCODhpfDdQH57VmHLC8tges6FzKrYNzy76x1GJ09f0oUIVw4mla8oD4EeJ
         Y1xbGkAV+7b+qyO0W2dm+daG40m9cnRGXcbZcNvo7kdgr8Eqm+CcnpZhtUrGWmS1/5aj
         qjkg==
X-Gm-Message-State: AOAM532fgknvJSoZfMMOp8uLqVUUSApZIju6/+aFCkJZeUWsKmJ8XPjy
        pjwAoauZFCXL7FbSU/I8S9f/han9j2YwaGNz8ZWRMcfo36PsZOc=
X-Google-Smtp-Source: ABdhPJwr1pY5YKHmiIZ5bDceJ2hGxjauudRbkVWReQiYakNbZSh0la2pFlCdtd37Wnv4z1Zx8xaor5ZpYv/EYO2Uncw=
X-Received: by 2002:a63:e04a:: with SMTP id n10mr17820589pgj.381.1631671159378;
 Tue, 14 Sep 2021 18:59:19 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Wed, 15 Sep 2021 09:59:08 +0800
Message-ID: <CACkBjsZa65=vqn_C+3wBRRPG6E_MC6j9KAJy9W+FYXo492Gy3Q@mail.gmail.com>
Subject: BUG: soft lockup in smp_call_function
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following two
similar crashes was triggered.

HEAD commit: 6880fa6c5660 Linux 5.15-rc1
git tree: upstream
console output:
https://drive.google.com/file/d/1W2g_mj5JPDXI5U7HibVepNdxMdChKS0_/view?usp=sharing
kernel config: https://drive.google.com/file/d/1rUzyMbe5vcs6khA3tL9EHTLJvsUdWcgB/view?usp=sharing
similar report: INFO: rcu detected stall in smp_call_function

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

watchdog: BUG: soft lockup - CPU#1 stuck for 157s! [kworker/1:8:14241]
Modules linked in:
irq event stamp: 371624
hardirqs last  enabled at (371623): [<ffffffff84400c02>]
asm_sysvec_apic_timer_interrupt+0x12/0x20
arch/x86/include/asm/idtentry.h:638
hardirqs last disabled at (371624): [<ffffffff8424818a>]
sysvec_apic_timer_interrupt+0xa/0xc0 arch/x86/kernel/apic/apic.c:1097
softirqs last  enabled at (337636): [<ffffffff84600398>]
softirq_handle_end kernel/softirq.c:401 [inline]
softirqs last  enabled at (337636): [<ffffffff84600398>]
__do_softirq+0x398/0x561 kernel/softirq.c:587
softirqs last disabled at (337625): [<ffffffff81235b42>]
invoke_softirq kernel/softirq.c:432 [inline]
softirqs last disabled at (337625): [<ffffffff81235b42>]
__irq_exit_rcu kernel/softirq.c:636 [inline]
softirqs last disabled at (337625): [<ffffffff81235b42>]
irq_exit_rcu+0xe2/0x100 kernel/softirq.c:648
CPU: 1 PID: 14241 Comm: kworker/1:8 Not tainted 5.15.0-rc1 #16
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Workqueue: rcu_gp wait_rcu_exp_gp
RIP: 0010:csd_lock_wait kernel/smp.c:440 [inline]
RIP: 0010:csd_lock kernel/smp.c:446 [inline]
RIP: 0010:smp_call_function_single+0x1a3/0x220 kernel/smp.c:745
Code: 48 c7 c3 80 a8 02 00 e8 cb b1 f1 02 89 c0 48 83 f8 07 77 6c 48
03 1c c5 80 98 62 85 8b 43 08 a8 01 74 0e e8 3f 9d 04 00 f3 90 <8b> 43
08 a8 01 75 f2 e8 31 9d 04 00 83 4b 08 01 48 89 de 44 89 e7
RSP: 0018:ffffc90001d4fd00 EFLAGS: 00000293
RAX: 0000000000000000 RBX: ffff88813dc2a880 RCX: 0000000000000000
RDX: ffff888112ac8000 RSI: ffffffff8132f4c1 RDI: ffffffff852d80e6
RBP: ffffc90001d4fd90 R08: 0000000000000001 R09: 0000000000000001
R10: ffffc90001d4fda8 R11: 0000000000000002 R12: 0000000000000002
R13: 0000000000000000 R14: ffffffff812ef7c0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055a15807ccf0 CR3: 0000000025f6b000 CR4: 0000000000750ee0
PKRU: 55555554
Call Trace:
 sync_rcu_exp_select_node_cpus+0x27b/0x440 kernel/rcu/tree_exp.h:393
 sync_rcu_exp_select_cpus+0x238/0x5d0 kernel/rcu/tree_exp.h:441
 rcu_exp_sel_wait_wake kernel/rcu/tree_exp.h:615 [inline]
 wait_rcu_exp_gp+0xa/0x20 kernel/rcu/tree_exp.h:629
 process_one_work+0x359/0x850 kernel/workqueue.c:2297
 worker_thread+0x41/0x4d0 kernel/workqueue.c:2444
 kthread+0x178/0x1b0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Sending NMI from CPU 1 to CPUs 0,2-3:
NMI backtrace for cpu 0
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.15.0-rc1 #16
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:__lock_acquire+0x14f/0x1d60 kernel/locking/lockdep.c:4955
Code: 00 48 89 43 08 48 8b 04 24 48 89 43 18 41 8b b5 dc 09 00 00 65
8b 05 08 ed d5 7e 85 c0 0f 95 c2 31 c0 85 f6 44 89 fe 0f 95 c0 <83> e1
03 c1 e6 07 8d 14 50 0f b6 43 21 83 e2 03 c1 e2 05 83 e0 1f
RSP: 0018:ffffc90000003c40 EFLAGS: 00000002
RAX: 0000000000000001 RBX: ffffffff858b2d70 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88813dd1a3d8
RBP: 0000000000000057 R08: 0000000000000001 R09: 0000000000000001
R10: ffff88813dd1a3d8 R11: 0000000000000003 R12: 0000000000000001
R13: ffffffff858b2300 R14: ffffffff858b2cf8 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055a1580bf6d7 CR3: 0000000025f6b000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
 <IRQ>
 lock_acquire+0x1f9/0x340 kernel/locking/lockdep.c:5625
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x38/0x50 kernel/locking/spinlock.c:162
 lock_hrtimer_base+0x2f/0x70 kernel/time/hrtimer.c:173
 hrtimer_try_to_cancel+0x6d/0x270 kernel/time/hrtimer.c:1331
 hrtimer_cancel+0x12/0x30 kernel/time/hrtimer.c:1443
 __disable_vblank drivers/gpu/drm/drm_vblank.c:434 [inline]
 drm_vblank_disable_and_save+0xca/0x130 drivers/gpu/drm/drm_vblank.c:478
 vblank_disable_fn+0x83/0xa0 drivers/gpu/drm/drm_vblank.c:495
 call_timer_fn+0xcb/0x3f0 kernel/time/timer.c:1421
 expire_timers kernel/time/timer.c:1466 [inline]
 __run_timers kernel/time/timer.c:1734 [inline]
 run_timer_softirq+0x6bd/0x820 kernel/time/timer.c:1747
 __do_softirq+0xe9/0x561 kernel/softirq.c:558
 invoke_softirq kernel/softirq.c:432 [inline]
 __irq_exit_rcu kernel/softirq.c:636 [inline]
 irq_exit_rcu+0xe2/0x100 kernel/softirq.c:648
 sysvec_apic_timer_interrupt+0x9e/0xc0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:default_idle+0xb/0x10 arch/x86/kernel/process.c:717
Code: 60 ce 25 84 75 09 48 83 c4 18 5b 5d 41 5c c3 e8 ab c4 fe ff cc
cc cc cc cc cc cc cc cc cc cc eb 07 0f 00 2d ff 00 5c 00 fb f4 <c3> 0f
1f 40 00 65 48 8b 04 25 40 70 01 00 f0 80 48 02 20 48 8b 10
RSP: 0018:ffffffff85803e90 EFLAGS: 00000202
RAX: 00000000010c94ab RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff85524f3d RDI: ffffffff853cbec6
RBP: ffffffff860d9290 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff85803be8 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff858b2300
 default_idle_call+0x6a/0x260 kernel/sched/idle.c:112
 cpuidle_idle_call kernel/sched/idle.c:194 [inline]
 do_idle+0x1e9/0x2b0 kernel/sched/idle.c:306
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:403
 start_kernel+0x839/0x860 init/main.c:1141
 secondary_startup_64_no_verify+0xb0/0xbb
NMI backtrace for cpu 2
CPU: 2 PID: 9794 Comm: sshd Not tainted 5.15.0-rc1 #16
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:__sanitizer_cov_trace_pc+0x37/0x60 kernel/kcov.c:197
Code: 65 48 8b 14 25 40 70 01 00 81 e1 00 01 00 00 a9 00 01 ff 00 74
0e 85 c9 74 35 8b 82 34 15 00 00 85 c0 74 2b 8b 82 10 15 00 00 <83> f8
02 75 20 48 8b 8a 18 15 00 00 8b 92 14 15 00 00 48 8b 01 48
RSP: 0018:ffffc900008cfa80 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff88807dc318e0 RCX: 0000000000000000
RDX: ffff88800e9c4480 RSI: ffffffff8132ebc0 RDI: 00000000ffffffff
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: ffffc900008cfa30 R11: 0000000000000000 R12: ffff88807dd2a900
R13: ffff88807dd2a908 R14: ffffffff85a27620 R15: 0000000000000000
FS:  00007f831f8568c0(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd76d1df1f CR3: 000000000fe3c000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 rep_nop arch/x86/include/asm/vdso/processor.h:13 [inline]
 cpu_relax arch/x86/include/asm/vdso/processor.h:18 [inline]
 csd_lock_wait kernel/smp.c:440 [inline]
 smp_call_function_many_cond+0x1d0/0x550 kernel/smp.c:969
 on_each_cpu_cond_mask+0x48/0x90 kernel/smp.c:1135
 __purge_vmap_area_lazy+0xd7/0xa40 mm/vmalloc.c:1683
 _vm_unmap_aliases+0x233/0x280 mm/vmalloc.c:2107
 change_page_attr_set_clr+0xb3/0x340 arch/x86/mm/pat/set_memory.c:1740
 change_page_attr_clear arch/x86/mm/pat/set_memory.c:1797 [inline]
 set_memory_ro+0x2b/0x40 arch/x86/mm/pat/set_memory.c:1943
 bpf_jit_binary_lock_ro include/linux/filter.h:890 [inline]
 bpf_int_jit_compile+0x65d/0x6b0 arch/x86/net/bpf_jit_comp.c:2338
 bpf_prog_select_runtime+0x173/0x1e0 kernel/bpf/core.c:1914
 bpf_migrate_filter net/core/filter.c:1295 [inline]
 bpf_prepare_filter+0x40d/0x5d0 net/core/filter.c:1343
 bpf_prog_create_from_user+0xcf/0x150 net/core/filter.c:1437
 seccomp_prepare_filter kernel/seccomp.c:666 [inline]
 seccomp_prepare_user_filter kernel/seccomp.c:703 [inline]
 seccomp_set_mode_filter kernel/seccomp.c:1824 [inline]
 do_seccomp+0x2ca/0xdb0 kernel/seccomp.c:1944
 prctl_set_seccomp+0x2f/0x60 kernel/seccomp.c:1997
 __do_sys_prctl kernel/sys.c:2346 [inline]
 __se_sys_prctl kernel/sys.c:2264 [inline]
 __x64_sys_prctl+0xd4/0x770 kernel/sys.c:2264
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f831d9cd54a
Code: 48 8b 0d 51 f9 2a 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 9d 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d 1e f9 2a 00 f7 d8 64 89 01 48
RSP: 002b:00007ffd76d1c428 EFLAGS: 00000246 ORIG_RAX: 000000000000009d
RAX: ffffffffffffffda RBX: 00005597d3a36f20 RCX: 00007f831d9cd54a
RDX: 00005597d32bdf50 RSI: 0000000000000002 RDI: 0000000000000016
RBP: 00005597d3a35d40 R08: 0000000000000000 R09: 0000000000000005
R10: 00007f831d9cd54a R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000028 R14: 0000000000000000 R15: 00007ffd76d1c870
NMI backtrace for cpu 3
CPU: 3 PID: 9782 Comm: syz-executor Not tainted 5.15.0-rc1 #16
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:kvm_wait+0x4a/0x70 arch/x86/kernel/kvm.c:893
Code: 5d c3 89 f3 48 89 fd 9c 58 fa f6 c4 02 75 30 0f b6 45 00 38 c3
74 16 e8 94 82 25 00 fb 5b 5d c3 eb 07 0f 00 2d 95 c1 6d 03 f4 <5b> 5d
c3 e8 7e 82 25 00 eb 07 0f 00 2d 83 c1 6d 03 fb f4 eb c0 e8
RSP: 0000:ffffc90000768e00 EFLAGS: 00000046
RAX: 0000000000000003 RBX: ffff888100998338 RCX: 0000000000000008
RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffff888100998338
RBP: ffff88813dd2a600 R08: 0000000000000000 R09: 0000000000000001
R10: ffffc90000768d20 R11: 0000000000000002 R12: 0000000000000001
R13: 0000000000000100 R14: 0000000000000000 R15: 0000000000100000
FS:  00007f849523b700(0000) GS:ffff88813dd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020400010 CR3: 0000000025f6b000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <IRQ>
 pv_wait arch/x86/include/asm/paravirt.h:597 [inline]
 pv_wait_head_or_lock kernel/locking/qspinlock_paravirt.h:470 [inline]
 __pv_queued_spin_lock_slowpath+0x262/0x330 kernel/locking/qspinlock.c:508
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:585 [inline]
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:85 [inline]
 do_raw_spin_lock+0xb6/0xc0 kernel/locking/spinlock_debug.c:115
 spin_lock include/linux/spinlock.h:363 [inline]
 drm_handle_vblank+0x86/0x530 drivers/gpu/drm/drm_vblank.c:1951
 vkms_vblank_simulate+0x5a/0x190 drivers/gpu/drm/vkms/vkms_crtc.c:29
 __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
 __hrtimer_run_queues+0xb8/0x610 kernel/time/hrtimer.c:1749
 hrtimer_interrupt+0xfe/0x280 kernel/time/hrtimer.c:1811
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline]
 __sysvec_apic_timer_interrupt+0x9c/0x2c0 arch/x86/kernel/apic/apic.c:1103
 sysvec_apic_timer_interrupt+0x99/0xc0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:__raw_spin_unlock_irq include/linux/spinlock_api_smp.h:169 [inline]
RIP: 0010:_raw_spin_unlock_irq+0x25/0x40 kernel/locking/spinlock.c:202
Code: 0f 1f 44 00 00 53 48 8b 74 24 08 48 89 fb 48 83 c7 18 e8 be ce
05 fd 48 89 df e8 f6 06 06 fd e8 e1 19 14 fd fb bf 01 00 00 00 <e8> 76
9c 01 fd 65 8b 05 df 93 db 7b 85 c0 74 02 5b c3 e8 9b 4c da
RSP: 0000:ffffc90001503e18 EFLAGS: 00000202
RAX: 00000000000b619e RBX: ffff88813dd18240 RCX: 0000000000000100
RDX: 0000000000000000 RSI: ffffffff85524f3d RDI: 0000000000000001
RBP: ffffc90001503e50 R08: 0000000000000001 R09: 0000000000000001
R10: ffffc90001503e28 R11: 0000000000000001 R12: ffff88810d86c9c0
R13: ffffc90001503e50 R14: ffffffff839a5e10 R15: ffffffff860d9290
 expire_timers kernel/time/timer.c:1465 [inline]
 __run_timers kernel/time/timer.c:1734 [inline]
 run_timer_softirq+0x6ae/0x820 kernel/time/timer.c:1747
 __do_softirq+0xe9/0x561 kernel/softirq.c:558
 invoke_softirq kernel/softirq.c:432 [inline]
 __irq_exit_rcu kernel/softirq.c:636 [inline]
 irq_exit_rcu+0xe2/0x100 kernel/softirq.c:648
 sysvec_apic_timer_interrupt+0x52/0xc0 arch/x86/kernel/apic/apic.c:1097
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0033:0x418dcf
Code: 1f 84 00 00 00 00 00 0f 1f 40 00 64 8b 04 25 08 03 00 00 41 89
c3 41 83 cb 02 41 39 c3 74 17 f0 64 44 0f b1 1c 25 08 03 00 00 <75> e7
41 83 e3 bb 41 83 fb 0a 74 01 c3 48 83 ec 08 64 48 c7 04 25
RSP: 002b:00007f849523a9b8 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000002 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000003 R15: 00000000204413a0
----------------
Code disassembly (best guess):
   0: 48 c7 c3 80 a8 02 00 mov    $0x2a880,%rbx
   7: e8 cb b1 f1 02        callq  0x2f1b1d7
   c: 89 c0                mov    %eax,%eax
   e: 48 83 f8 07          cmp    $0x7,%rax
  12: 77 6c                ja     0x80
  14: 48 03 1c c5 80 98 62 add    -0x7a9d6780(,%rax,8),%rbx
  1b: 85
  1c: 8b 43 08              mov    0x8(%rbx),%eax
  1f: a8 01                test   $0x1,%al
  21: 74 0e                je     0x31
  23: e8 3f 9d 04 00        callq  0x49d67
  28: f3 90                pause
* 2a: 8b 43 08              mov    0x8(%rbx),%eax <-- trapping instruction
  2d: a8 01                test   $0x1,%al
  2f: 75 f2                jne    0x23
  31: e8 31 9d 04 00        callq  0x49d67
  36: 83 4b 08 01          orl    $0x1,0x8(%rbx)
  3a: 48 89 de              mov    %rbx,%rsi
  3d: 44 89 e7              mov    %r12d,%edi


===== INFO: rcu detected stall in smp_call_function

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 0-....: (3203 ticks this GP) idle=417/1/0x4000000000000000
softirq=25875/25875 fqs=485
(t=10500 jiffies g=37621 q=38)
rcu: rcu_preempt kthread starved for 486 jiffies! g37621 f0x0
RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=3
rcu: Unless rcu_preempt kthread gets sufficient CPU time, OOM is now
expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:13832 pid:   16
ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0x323/0xae0 kernel/sched/core.c:6287
 schedule+0x36/0xe0 kernel/sched/core.c:6366
 schedule_timeout+0x2cb/0x430 kernel/time/timer.c:1881
 rcu_gp_fqs_loop+0x2f7/0x3e0 kernel/rcu/tree.c:1957
 rcu_gp_kthread+0xd0/0x160 kernel/rcu/tree.c:2130
 kthread+0x178/0x1b0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 0 to CPUs 3:
NMI backtrace for cpu 3
CPU: 3 PID: 14220 Comm: kworker/3:10 Not tainted 5.15.0-rc1 #16
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Workqueue: rcu_gp wait_rcu_exp_gp
RIP: 0010:csd_lock_wait kernel/smp.c:440 [inline]
RIP: 0010:csd_lock kernel/smp.c:446 [inline]
RIP: 0010:smp_call_function_single+0x1a6/0x220 kernel/smp.c:745
Code: 80 a8 02 00 e8 cb b1 f1 02 89 c0 48 83 f8 07 77 6c 48 03 1c c5
80 98 62 85 8b 43 08 a8 01 74 0e e8 3f 9d 04 00 f3 90 8b 43 08 <a8> 01
75 f2 e8 31 9d 04 00 83 4b 08 01 48 89 de 44 89 e7 4c 89 73
RSP: 0018:ffffc90005793d00 EFLAGS: 00000293
RAX: 0000000000000001 RBX: ffff88813dd2a880 RCX: 0000000000000000
RDX: ffff888103ddc480 RSI: ffffffff8132f4c1 RDI: ffffffff852d80e6
RBP: ffffc90005793d90 R08: 0000000000000001 R09: 0000000000000001
R10: ffffc90005793da8 R11: 0000000000000000 R12: 0000000000000002
R13: 0000000000000000 R14: ffffffff812ef7c0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88813dd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b72e9c2cd8 CR3: 000000000dedc000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 sync_rcu_exp_select_node_cpus+0x27b/0x440 kernel/rcu/tree_exp.h:393
 sync_rcu_exp_select_cpus+0x238/0x5d0 kernel/rcu/tree_exp.h:441
 rcu_exp_sel_wait_wake kernel/rcu/tree_exp.h:615 [inline]
 wait_rcu_exp_gp+0xa/0x20 kernel/rcu/tree_exp.h:629
 process_one_work+0x359/0x850 kernel/workqueue.c:2297
 worker_thread+0x41/0x4d0 kernel/workqueue.c:2444
 kthread+0x178/0x1b0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
NMI backtrace for cpu 0
CPU: 0 PID: 9 Comm: kworker/u9:0 Not tainted 5.15.0-rc1 #16
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Workqueue: events_unbound toggle_allocation_gate
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106
 nmi_cpu_backtrace+0x1e9/0x210 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x120/0x180 lib/nmi_backtrace.c:62
 trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
 rcu_dump_cpu_stacks+0x125/0x17b kernel/rcu/tree_stall.h:343
 print_cpu_stall kernel/rcu/tree_stall.h:627 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:711 [inline]
 rcu_pending kernel/rcu/tree.c:3880 [inline]
 rcu_sched_clock_irq+0xc20/0x1360 kernel/rcu/tree.c:2599
 update_process_times+0xac/0x100 kernel/time/timer.c:1785
 tick_sched_handle.isra.20+0x27/0x70 kernel/time/tick-sched.c:226
 tick_sched_timer+0x8a/0xb0 kernel/time/tick-sched.c:1421
 __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
 __hrtimer_run_queues+0x23e/0x610 kernel/time/hrtimer.c:1749
 hrtimer_interrupt+0xfe/0x280 kernel/time/hrtimer.c:1811
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline]
 __sysvec_apic_timer_interrupt+0x9c/0x2c0 arch/x86/kernel/apic/apic.c:1103
 sysvec_apic_timer_interrupt+0x99/0xc0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:csd_lock_wait kernel/smp.c:440 [inline]
RIP: 0010:smp_call_function_many_cond+0x1d2/0x550 kernel/smp.c:969
Code: a6 04 00 4c 63 fd 49 8b 1c 24 49 83 ff 07 0f 87 31 03 00 00 4a
03 1c fd 80 98 62 85 8b 43 08 a8 01 74 0e e8 40 a6 04 00 f3 90 <8b> 43
08 a8 01 75 f2 e8 32 a6 04 00 eb ad 48 83 c4 40 5b 5d 41 5c
RSP: 0018:ffffc9000067bc80 EFLAGS: 00000293
RAX: 0000000000000000 RBX: ffff88807dd2f9c0 RCX: 0000000000000000
RDX: ffff88800985c480 RSI: ffffffff8132ebc0 RDI: 0000000000000001
RBP: 0000000000000002 R08: 0000000000000001 R09: 0000000000000001
R10: ffffc9000067bc28 R11: 0000000000000000 R12: ffff88807dc2a900
R13: ffff88807dc2a908 R14: ffffffff85a27620 R15: 0000000000000002
 on_each_cpu_cond_mask+0x48/0x90 kernel/smp.c:1135
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:929 [inline]
 text_poke_bp_batch+0xb6/0x2c0 arch/x86/kernel/alternative.c:1114
 text_poke_flush arch/x86/kernel/alternative.c:1268 [inline]
 text_poke_finish+0x16/0x30 arch/x86/kernel/alternative.c:1275
 arch_jump_label_transform_apply+0x13/0x20 arch/x86/kernel/jump_label.c:146
 jump_label_update+0xbc/0x190 kernel/jump_label.c:830
 static_key_enable_cpuslocked+0x77/0xb0 kernel/jump_label.c:177
 static_key_enable+0x16/0x20 kernel/jump_label.c:190
 toggle_allocation_gate+0x71/0x240 mm/kfence/core.c:626
 process_one_work+0x359/0x850 kernel/workqueue.c:2297
 worker_thread+0x41/0x4d0 kernel/workqueue.c:2444
 kthread+0x178/0x1b0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Sending NMI from CPU 0 to CPUs 2:
----------------
Code disassembly (best guess), 2 bytes skipped:
   0: 02 00                add    (%rax),%al
   2: e8 cb b1 f1 02        callq  0x2f1b1d2
   7: 89 c0                mov    %eax,%eax
   9: 48 83 f8 07          cmp    $0x7,%rax
   d: 77 6c                ja     0x7b
   f: 48 03 1c c5 80 98 62 add    -0x7a9d6780(,%rax,8),%rbx
  16: 85
  17: 8b 43 08              mov    0x8(%rbx),%eax
  1a: a8 01                test   $0x1,%al
  1c: 74 0e                je     0x2c
  1e: e8 3f 9d 04 00        callq  0x49d62
  23: f3 90                pause
  25: 8b 43 08              mov    0x8(%rbx),%eax
* 28: a8 01                test   $0x1,%al <-- trapping instruction
  2a: 75 f2                jne    0x1e
  2c: e8 31 9d 04 00        callq  0x49d62
  31: 83 4b 08 01          orl    $0x1,0x8(%rbx)
  35: 48 89 de              mov    %rbx,%rsi
  38: 44 89 e7              mov    %r12d,%edi
  3b: 4c                    rex.WR
  3c: 89                    .byte 0x89
  3d: 73                    .byte 0x73

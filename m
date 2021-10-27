Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F8043BEB7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 03:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbhJ0BFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 21:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbhJ0BFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 21:05:24 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029ACC061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 18:02:59 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id lx5-20020a17090b4b0500b001a262880e99so786087pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 18:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=iRyYoOF4J7f2r8V9+5/TPonjIQZHr0zOHo9KYip9F/k=;
        b=N6Ybl3gmTgmpvtwrNP8dcXvCfGrUUgFVJf4pxdRjFItHmoWkSHHzTq0wQMnBecXBNa
         CbNjwgP/pA9G2po9MrPNad4clzubV4ZjeuRXUyLMmyBfRZwP+5EwHRaTsAnUC9dFsPOX
         gMU8KMunwTSw5mC/U71dGOtuMcJ4+GlHvMBjbKnkxDLzxNuQQMgscRyufqR06Jv3U0K0
         aLxvCwyAPUETY+pV75MnYQG5JIMfvOX4VKzPT45DWpUDOJXJVKE06JKyZ/cixgg/6Rdr
         4VfkY3JqcG/yZ1S4HVrIVpBjhtisfrekkwg53t7wsDSAI/uxftyPGEz85ck2kj1lS6UQ
         5D8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=iRyYoOF4J7f2r8V9+5/TPonjIQZHr0zOHo9KYip9F/k=;
        b=ScUPmXLD5Vt4SVpYNp9vuZav4+eRrearcB3r4O673gBq5p+DS1sXl7A9vWqf6wx2p5
         AzuKBgW+hP5ja12MA4yn2mfeIo50xvYxwrzlG0Pks3giuEIq2KCkPt+G7tbyT14qRVMl
         jGkH1EjNLY6TpQLmFLNl3hajoyMCUh0F+mzDE+vPXiKT8WcL4yatr4olCCwaaYgC4F2L
         rnE1h4ekOHNunipafzo+VXCvdHKZD4UcmQyw9y9Zj5p59KKmqYWtEj+6vV4csFqqG+br
         3xKetWJ18aOT7j/4DK1pX9git2vjBpUSEd9EFZN4WaEBpM7V6TMrG28TMzPGsz4O9BFG
         L+gg==
X-Gm-Message-State: AOAM533rw69T6286pYFsSmnJctCXABQScgT7mQQg6QW21deBYMhoKBDY
        yXo/Hsw4XEqjlWQ+Ya2wirGKFSXdCuedQcKuNg0jsqNd8AQqRxVWsQ==
X-Google-Smtp-Source: ABdhPJznLP5WscGIHI/vr6x0KthRaNhTdnXuyl6TVCkWEGg63AuxYhT2Rd3OT0h8d6vNc74wWiTAexvI/XHDGu4QlUQ=
X-Received: by 2002:a17:903:2348:b0:140:37e8:5944 with SMTP id
 c8-20020a170903234800b0014037e85944mr21323662plh.15.1635296579129; Tue, 26
 Oct 2021 18:02:59 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Wed, 27 Oct 2021 09:02:46 +0800
Message-ID: <CACkBjsYgp7a+cY-_M0UyTXgT9nOKgr2Sg-k31+wYnvb=OR50Yg@mail.gmail.com>
Subject: INFO: rcu detected stall in rebalance_domains
To:     tglx@linutronix.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 519d81956ee2 Linux 5.15-rc6
git tree: upstream
console output:
https://drive.google.com/file/d/1PEAbh2uWQjR5fKTNuxscyfV3zZO0OUoK/view?usp=sharing
kernel config: https://drive.google.com/file/d/12PUnxIM1EPBgW4ZJmI7WJBRaY1lA83an/view?usp=sharing

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 1-...!: (1 GPs behind) idle=7b3/1/0x4000000000000000
softirq=23497/23497 fqs=1376
(detected by 3, t=10502 jiffies, g=47689, q=10534)
Sending NMI from CPU 3 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 21 Comm: ksoftirqd/1 Not tainted 5.15.0-rc6 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:hrtimer_cancel+0x37/0x40 kernel/time/hrtimer.c:1447
Code: df e8 7d fa ff ff 31 ff 41 89 c4 89 c6 e8 11 28 10 00 45 85 e4
78 0c e8 a7 26 10 00 44 89 e0 5b 41 5c c3 e8 9b 26 10 00 f3 90 <eb> cd
0f 1f 80 00 00 00 00 41 54 45 31 e4 55 48 89 fd 53 89 f3 e8
RSP: 0018:ffffc900007b7b68 EFLAGS: 00000046
RAX: 0000000000000000 RBX: ffff888019911e40 RCX: ffff888100150000
RDX: 0000000000000000 RSI: ffff888100150000 RDI: 0000000000000002
RBP: ffff888104d3c828 R08: ffffffff81663825 R09: 0000000000000000
R10: 0000000000000005 R11: ffffed100c7c4478 R12: 00000000ffffffff
R13: 0000000000000046 R14: ffff888019910338 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff888135c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000400000 CR3: 000000001e917000 CR4: 0000000000350ee0
Call Trace:
 __disable_vblank drivers/gpu/drm/drm_vblank.c:434 [inline]
 drm_vblank_disable_and_save+0x286/0x3e0 drivers/gpu/drm/drm_vblank.c:478
 vblank_disable_fn+0x161/0x1b0 drivers/gpu/drm/drm_vblank.c:495
 call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1421
 expire_timers kernel/time/timer.c:1466 [inline]
 __run_timers.part.0+0x6b0/0xa90 kernel/time/timer.c:1734
 __run_timers kernel/time/timer.c:1715 [inline]
 run_timer_softirq+0xb6/0x1d0 kernel/time/timer.c:1747
 __do_softirq+0x1d7/0x93b kernel/softirq.c:558
 run_ksoftirqd kernel/softirq.c:920 [inline]
 run_ksoftirqd+0x2d/0x60 kernel/softirq.c:912
 smpboot_thread_fn+0x645/0x9c0 kernel/smpboot.c:164
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
rcu: rcu_preempt kthread starved for 7514 jiffies! g47689 f0x0
RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=2
rcu: Unless rcu_preempt kthread gets sufficient CPU time, OOM is now
expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:28416 pid:   16
ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 schedule_timeout+0x4ce/0x890 kernel/time/timer.c:1881
 rcu_gp_fqs_loop+0x497/0x850 kernel/rcu/tree.c:1957
 rcu_gp_kthread+0x1de/0x320 kernel/rcu/tree.c:2130
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 3 to CPUs 2:
NMI backtrace for cpu 2
CPU: 2 PID: 15631 Comm: sshd Not tainted 5.15.0-rc6 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:csd_lock_wait kernel/smp.c:440 [inline]
RIP: 0010:smp_call_function_many_cond+0x3db/0xc20 kernel/smp.c:969
Code: 0b 00 85 ed 74 4d 48 b8 00 00 00 00 00 fc ff df 4d 89 f4 4c 89
f5 49 c1 ec 03 83 e5 07 49 01 c4 83 c5 03 e8 87 46 0b 00 f3 90 <41> 0f
b6 04 24 40 38 c5 7c 08 84 c0 0f 85 a2 06 00 00 8b 43 08 31
RSP: 0018:ffffc90004c77630 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff888063e39d00 RCX: ffff888011b55580
RDX: 0000000000000000 RSI: ffff888011b55580 RDI: 0000000000000002
RBP: 0000000000000003 R08: ffffffff816b1839 R09: 0000000000000000
R10: 0000000000000005 R11: fffffbfff1adb0b8 R12: ffffed100c7c73a1
R13: 0000000000000000 R14: ffff888063e39d08 R15: 0000000000000001
FS:  00007f4823bf48c0(0000) GS:ffff888063f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff84d6af1f CR3: 000000001eb8d000 CR4: 0000000000350ee0
Call Trace:
 on_each_cpu_cond_mask+0x56/0xa0 kernel/smp.c:1135
 __purge_vmap_area_lazy+0x1f6/0x1c90 mm/vmalloc.c:1683
 _vm_unmap_aliases mm/vmalloc.c:2107 [inline]
 _vm_unmap_aliases+0x3b5/0x4c0 mm/vmalloc.c:2072
 change_page_attr_set_clr+0x1fa/0x730 arch/x86/mm/pat/set_memory.c:1740
 change_page_attr_clear arch/x86/mm/pat/set_memory.c:1797 [inline]
 set_memory_ro+0x78/0xa0 arch/x86/mm/pat/set_memory.c:1943
 bpf_jit_binary_lock_ro include/linux/filter.h:890 [inline]
 bpf_int_jit_compile+0xe62/0x1210 arch/x86/net/bpf_jit_comp.c:2368
 bpf_prog_select_runtime+0x3eb/0x680 kernel/bpf/core.c:1914
 bpf_migrate_filter net/core/filter.c:1295 [inline]
 bpf_prepare_filter net/core/filter.c:1343 [inline]
 bpf_prepare_filter+0x8a3/0xc90 net/core/filter.c:1309
 bpf_prog_create_from_user+0x1e4/0x2e0 net/core/filter.c:1437
 seccomp_prepare_filter kernel/seccomp.c:666 [inline]
 seccomp_prepare_user_filter kernel/seccomp.c:703 [inline]
 seccomp_set_mode_filter kernel/seccomp.c:1824 [inline]
 do_seccomp+0x388/0x2690 kernel/seccomp.c:1944
 prctl_set_seccomp+0x4a/0x70 kernel/seccomp.c:1997
 __do_sys_prctl kernel/sys.c:2346 [inline]
 __se_sys_prctl kernel/sys.c:2264 [inline]
 __x64_sys_prctl+0x667/0x1110 kernel/sys.c:2264
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f4821d6b54a
Code: 48 8b 0d 51 f9 2a 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 9d 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d 1e f9 2a 00 f7 d8 64 89 01 48
RSP: 002b:00007fff84d69e88 EFLAGS: 00000246 ORIG_RAX: 000000000000009d
RAX: ffffffffffffffda RBX: 0000564d693aee80 RCX: 00007f4821d6b54a
RDX: 0000564d686bdf50 RSI: 0000000000000002 RDI: 0000000000000016
RBP: 0000564d693b02f0 R08: 0000000000000000 R09: 0000000000000005
R10: 00007f4821d6b54a R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000028 R14: 0000000000000000 R15: 00007fff84d6a2d0
watchdog: BUG: soft lockup - CPU#2 stuck for 223s! [sshd:15631]
Modules linked in:
irq event stamp: 0
hardirqs last  enabled at (0): [<0000000000000000>] 0x0
hardirqs last disabled at (0): [<ffffffff81440c09>]
copy_process+0x1dd9/0x73d0 kernel/fork.c:2135
softirqs last  enabled at (0): [<ffffffff81440c4a>]
copy_process+0x1e1a/0x73d0 kernel/fork.c:2139
softirqs last disabled at (0): [<0000000000000000>] 0x0
CPU: 2 PID: 15631 Comm: sshd Not tainted 5.15.0-rc6 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:csd_lock_wait kernel/smp.c:440 [inline]
RIP: 0010:smp_call_function_many_cond+0x3db/0xc20 kernel/smp.c:969
Code: 0b 00 85 ed 74 4d 48 b8 00 00 00 00 00 fc ff df 4d 89 f4 4c 89
f5 49 c1 ec 03 83 e5 07 49 01 c4 83 c5 03 e8 87 46 0b 00 f3 90 <41> 0f
b6 04 24 40 38 c5 7c 08 84 c0 0f 85 a2 06 00 00 8b 43 08 31
RSP: 0018:ffffc90004c77630 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff888063e39d00 RCX: ffff888011b55580
RDX: 0000000000000000 RSI: ffff888011b55580 RDI: 0000000000000002
RBP: 0000000000000003 R08: ffffffff816b1839 R09: 0000000000000000
R10: 0000000000000005 R11: fffffbfff1adb0b8 R12: ffffed100c7c73a1
R13: 0000000000000000 R14: ffff888063e39d08 R15: 0000000000000001
FS:  00007f4823bf48c0(0000) GS:ffff888063f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff84d6af1f CR3: 000000001eb8d000 CR4: 0000000000350ee0
Call Trace:
 on_each_cpu_cond_mask+0x56/0xa0 kernel/smp.c:1135
 __purge_vmap_area_lazy+0x1f6/0x1c90 mm/vmalloc.c:1683
 _vm_unmap_aliases mm/vmalloc.c:2107 [inline]
 _vm_unmap_aliases+0x3b5/0x4c0 mm/vmalloc.c:2072
 change_page_attr_set_clr+0x1fa/0x730 arch/x86/mm/pat/set_memory.c:1740
 change_page_attr_clear arch/x86/mm/pat/set_memory.c:1797 [inline]
 set_memory_ro+0x78/0xa0 arch/x86/mm/pat/set_memory.c:1943
 bpf_jit_binary_lock_ro include/linux/filter.h:890 [inline]
 bpf_int_jit_compile+0xe62/0x1210 arch/x86/net/bpf_jit_comp.c:2368
 bpf_prog_select_runtime+0x3eb/0x680 kernel/bpf/core.c:1914
 bpf_migrate_filter net/core/filter.c:1295 [inline]
 bpf_prepare_filter net/core/filter.c:1343 [inline]
 bpf_prepare_filter+0x8a3/0xc90 net/core/filter.c:1309
 bpf_prog_create_from_user+0x1e4/0x2e0 net/core/filter.c:1437
 seccomp_prepare_filter kernel/seccomp.c:666 [inline]
 seccomp_prepare_user_filter kernel/seccomp.c:703 [inline]
 seccomp_set_mode_filter kernel/seccomp.c:1824 [inline]
 do_seccomp+0x388/0x2690 kernel/seccomp.c:1944
 prctl_set_seccomp+0x4a/0x70 kernel/seccomp.c:1997
 __do_sys_prctl kernel/sys.c:2346 [inline]
 __se_sys_prctl kernel/sys.c:2264 [inline]
 __x64_sys_prctl+0x667/0x1110 kernel/sys.c:2264
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f4821d6b54a
Code: 48 8b 0d 51 f9 2a 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 9d 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d 1e f9 2a 00 f7 d8 64 89 01 48
RSP: 002b:00007fff84d69e88 EFLAGS: 00000246 ORIG_RAX: 000000000000009d
RAX: ffffffffffffffda RBX: 0000564d693aee80 RCX: 00007f4821d6b54a
RDX: 0000564d686bdf50 RSI: 0000000000000002 RDI: 0000000000000016
RBP: 0000564d693b02f0 R08: 0000000000000000 R09: 0000000000000005
R10: 00007f4821d6b54a R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000028 R14: 0000000000000000 R15: 00007fff84d6a2d0
Sending NMI from CPU 2 to CPUs 0-1,3:
NMI backtrace for cpu 3
CPU: 3 PID: 15628 Comm: syz-executor Not tainted 5.15.0-rc6 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:csd_lock_wait kernel/smp.c:440 [inline]
RIP: 0010:smp_call_function_many_cond+0x3db/0xc20 kernel/smp.c:969
Code: 0b 00 85 ed 74 4d 48 b8 00 00 00 00 00 fc ff df 4d 89 f4 4c 89
f5 49 c1 ec 03 83 e5 07 49 01 c4 83 c5 03 e8 87 46 0b 00 f3 90 <41> 0f
b6 04 24 40 38 c5 7c 08 84 c0 0f 85 a2 06 00 00 8b 43 08 31
RSP: 0018:ffffc90004edf7e0 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff888135c39d20 RCX: ffff888019ef0000
RDX: 0000000000000000 RSI: ffff888019ef0000 RDI: 0000000000000002
RBP: 0000000000000003 R08: ffffffff816b1839 R09: 0000000000000000
R10: 0000000000000005 R11: fffff520009dbeec R12: ffffed1026b873a5
R13: 0000000000000001 R14: ffff888135c39d28 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff888135d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f57d8897000 CR3: 00000000189a5000 CR4: 0000000000350ee0
Call Trace:
 on_each_cpu_cond_mask+0x56/0xa0 kernel/smp.c:1135
 kvm_flush_tlb_multi+0x22b/0x320 arch/x86/kernel/kvm.c:603
 __flush_tlb_multi arch/x86/include/asm/paravirt.h:87 [inline]
 flush_tlb_multi arch/x86/mm/tlb.c:927 [inline]
 flush_tlb_mm_range+0x1d7/0x230 arch/x86/mm/tlb.c:1013
 tlb_flush arch/x86/include/asm/tlb.h:23 [inline]
 tlb_flush_mmu_tlbonly include/asm-generic/tlb.h:426 [inline]
 tlb_flush_mmu_tlbonly include/asm-generic/tlb.h:416 [inline]
 tlb_flush_mmu+0x274/0x610 mm/mmu_gather.c:248
 tlb_finish_mmu+0x93/0x3c0 mm/mmu_gather.c:340
 exit_mmap+0x1ea/0x650 mm/mmap.c:3173
 __mmput kernel/fork.c:1115 [inline]
 mmput+0x16d/0x440 kernel/fork.c:1136
 exit_mm kernel/exit.c:501 [inline]
 do_exit+0xad6/0x2dd0 kernel/exit.c:812
 do_group_exit+0x125/0x340 kernel/exit.c:922
 get_signal+0x4d5/0x25a0 kernel/signal.c:2868
 arch_do_signal_or_restart+0x2ed/0x1c40 arch/x86/kernel/signal.c:865
 handle_signal_work kernel/entry/common.c:148 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
 exit_to_user_mode_prepare+0x192/0x2a0 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7ff6bfd81c4d
Code: Unable to access opcode bytes at RIP 0x7ff6bfd81c23.
RSP: 002b:00007fff14698ea8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: 0000000000000000 RBX: 0000000000000064 RCX: 00007ff6bfd81c4d
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007ff6bfea80ac
RBP: 0000000000062530 R08: 00007fff14716090 R09: 0000000000000000
R10: 00007fff14698fc0 R11: 0000000000000246 R12: 00007ff6bfe3d500
R13: 0000000000062594 R14: 00007ff6bfea80ac R15: 000000000006252f
NMI backtrace for cpu 0
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.15.0-rc6 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:kvm_wait+0xb3/0x110 arch/x86/kernel/kvm.c:893
Code: 40 38 c6 74 1b 48 83 c4 10 c3 c3 e8 37 70 49 00 eb 07 0f 00 2d
de 1c 56 08 fb f4 48 83 c4 10 c3 eb 07 0f 00 2d ce 1c 56 08 f4 <48> 83
c4 10 c3 89 74 24 0c 48 89 3c 24 e8 5b 6e 49 00 8b 74 24 0c
RSP: 0018:ffffc90000007720 EFLAGS: 00000046
RAX: 0000000000000003 RBX: 0000000000000000 RCX: ffffffff815c2189
RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffff888019910338
RBP: ffff888019910338 R08: 0000000000000001 R09: ffffed1003322068
R10: ffff888019910338 R11: ffffed1003322067 R12: 0000000000000000
R13: ffffed1003322067 R14: 0000000000000001 R15: ffff888063e32840
FS:  0000000000000000(0000) GS:ffff888063e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 000000000b68e000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 pv_wait arch/x86/include/asm/paravirt.h:597 [inline]
 pv_wait_head_or_lock kernel/locking/qspinlock_paravirt.h:470 [inline]
 __pv_queued_spin_lock_slowpath+0x923/0xb80 kernel/locking/qspinlock.c:508
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:585 [inline]
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:85 [inline]
 do_raw_spin_lock+0x204/0x2d0 kernel/locking/spinlock_debug.c:115
 spin_lock include/linux/spinlock.h:363 [inline]
 drm_handle_vblank+0x126/0xc70 drivers/gpu/drm/drm_vblank.c:1951
 vkms_vblank_simulate+0xd0/0x3c0 drivers/gpu/drm/vkms/vkms_crtc.c:29
 __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
 __hrtimer_run_queues+0x1b8/0xdf0 kernel/time/hrtimer.c:1749
 hrtimer_interrupt+0x31c/0x790 kernel/time/hrtimer.c:1811
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x540 arch/x86/kernel/apic/apic.c:1103
 sysvec_apic_timer_interrupt+0x40/0xc0 arch/x86/kernel/apic/apic.c:1097
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:load_balance+0xe6d/0x26a0 kernel/sched/fair.c:9873
Code: 24 c0 00 00 00 00 0f 85 2a 05 00 00 9c 58 f6 c4 02 0f 85 04 07
00 00 48 83 bc 24 c0 00 00 00 00 74 01 fb 8b 84 24 38 01 00 00 <a8> 02
0f 85 0e 05 00 00 a8 04 0f 84 eb 06 00 00 48 83 bc 24 28 01
RSP: 0018:ffffc90000007c88 EFLAGS: 00000206
RAX: 0000000000000000 RBX: ffff888019ef00e8 RCX: 1ffffffff1adb839
RDX: 0000000000000000 RSI: ffffffff8b6bc640 RDI: ffffffff81555d5e
RBP: ffffc90000007e58 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000005 R11: ffffed100c7c6348 R12: ffff888063e31a40
R13: dffffc0000000000 R14: ffffc90000007dd8 R15: ffff888019ef0000
 rebalance_domains+0x66c/0xcd0 kernel/sched/fair.c:10232
 __do_softirq+0x1d7/0x93b kernel/softirq.c:558
 invoke_softirq kernel/softirq.c:432 [inline]
 __irq_exit_rcu kernel/softirq.c:636 [inline]
 irq_exit_rcu+0xf2/0x130 kernel/softirq.c:648
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:default_idle+0xb/0x10 arch/x86/kernel/process.c:717
Code: cb 41 88 f8 e9 6f fe ff ff e8 c1 41 88 f8 e9 3d fe ff ff e8 17
31 fd ff cc cc cc cc cc cc cc eb 07 0f 00 2d 87 88 50 00 fb f4 <c3> 0f
1f 40 00 41 54 be 08 00 00 00 53 65 48 8b 1c 25 40 f0 01 00
RSP: 0018:ffffffff8b607e28 EFLAGS: 00000246
RAX: 00000000000a6e22 RBX: 0000000000000000 RCX: ffffffff8932e632
RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffffffff8935b63d
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffed100c7c6542
R10: ffff888063e32a0b R11: ffffed100c7c6541 R12: 0000000000000000
R13: 0000000000000000 R14: ffffffff8d6d8dd0 R15: 0000000000000000
 default_idle_call+0xc4/0x420 kernel/sched/idle.c:112
 cpuidle_idle_call kernel/sched/idle.c:194 [inline]
 do_idle+0x3f9/0x570 kernel/sched/idle.c:306
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:403
 start_kernel+0x47a/0x49b init/main.c:1142
 secondary_startup_64_no_verify+0xb0/0xbb
NMI backtrace for cpu 1
CPU: 1 PID: 21 Comm: ksoftirqd/1 Not tainted 5.15.0-rc6 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:unlock_hrtimer_base kernel/time/hrtimer.c:1017 [inline]
RIP: 0010:hrtimer_try_to_cancel kernel/time/hrtimer.c:1336 [inline]
RIP: 0010:hrtimer_try_to_cancel+0x183/0x570 kernel/time/hrtimer.c:1316
Code: 45 84 e4 75 33 e8 dd 2a 10 00 4c 89 ea 48 8b 74 24 30 48 b8 00
00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 49 03 00 00 <49> 8b
7d 00 e8 94 91 cf 07 e9 f1 fe ff ff e8 aa 2a 10 00 48 c7 c6
RSP: 0018:ffffc900007b7ac0 EFLAGS: 00000046
RAX: dffffc0000000000 RBX: ffff888019911e40 RCX: ffff888100150000
RDX: 1ffff1100c7c4488 RSI: 0000000000000046 RDI: 0000000000000002
RBP: 1ffff920000f6f5a R08: ffffffff816633e3 R09: fffff520000f6f3e
R10: 0000000000000003 R11: fffff520000f6f3d R12: 0000000000000001
R13: ffff888063e22440 R14: 00000000ffffffff R15: ffff888019911e70
FS:  0000000000000000(0000) GS:ffff888135c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000400000 CR3: 000000001e917000 CR4: 0000000000350ee0
Call Trace:
 hrtimer_cancel+0x13/0x40 kernel/time/hrtimer.c:1443
 __disable_vblank drivers/gpu/drm/drm_vblank.c:434 [inline]
 drm_vblank_disable_and_save+0x286/0x3e0 drivers/gpu/drm/drm_vblank.c:478
 vblank_disable_fn+0x161/0x1b0 drivers/gpu/drm/drm_vblank.c:495
 call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1421
 expire_timers kernel/time/timer.c:1466 [inline]
 __run_timers.part.0+0x6b0/0xa90 kernel/time/timer.c:1734
 __run_timers kernel/time/timer.c:1715 [inline]
 run_timer_softirq+0xb6/0x1d0 kernel/time/timer.c:1747
 __do_softirq+0x1d7/0x93b kernel/softirq.c:558
 run_ksoftirqd kernel/softirq.c:920 [inline]
 run_ksoftirqd+0x2d/0x60 kernel/softirq.c:912
 smpboot_thread_fn+0x645/0x9c0 kernel/smpboot.c:164
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
----------------
Code disassembly (best guess), 1 bytes skipped:
   0: e8 7d fa ff ff        callq  0xfffffa82
   5: 31 ff                xor    %edi,%edi
   7: 41 89 c4              mov    %eax,%r12d
   a: 89 c6                mov    %eax,%esi
   c: e8 11 28 10 00        callq  0x102822
  11: 45 85 e4              test   %r12d,%r12d
  14: 78 0c                js     0x22
  16: e8 a7 26 10 00        callq  0x1026c2
  1b: 44 89 e0              mov    %r12d,%eax
  1e: 5b                    pop    %rbx
  1f: 41 5c                pop    %r12
  21: c3                    retq
  22: e8 9b 26 10 00        callq  0x1026c2
  27: f3 90                pause
* 29: eb cd                jmp    0xfffffff8 <-- trapping instruction
  2b: 0f 1f 80 00 00 00 00 nopl   0x0(%rax)
  32: 41 54                push   %r12
  34: 45 31 e4              xor    %r12d,%r12d
  37: 55                    push   %rbp
  38: 48 89 fd              mov    %rdi,%rbp
  3b: 53                    push   %rbx
  3c: 89 f3                mov    %esi,%ebx
  3e: e8                    .byte 0xe8

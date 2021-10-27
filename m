Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2749843BEB3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 02:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbhJ0BBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 21:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbhJ0BBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 21:01:46 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE5EC061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 17:59:21 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id n36-20020a17090a5aa700b0019fa884ab85so3712132pji.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 17:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ZDnNw76zNk8esqAJMHM+FCDdcc4eLMi8lxnTIFMjEoc=;
        b=DXfhJYiuQhl1piNtRl23M6vy3Q0Tn2/ZCvOwqepqhrJir5BdHdVqsWvDzXcQ5ESzUJ
         s+4gy+p52w3GCGpsA+OFnujJRYPHbkfGucb8ulaImYiN0TOm0A3DBjsXVQ0NhpJG8hl4
         tbfQsvpsY//hL1txkgiBJXFxNSnDDSWKjZNSBVAKNdLVt7hS68/9V+zAdYap6vpcTWQS
         k1ZBvsoVFYVjORNhjK5NudqlciFZJqGsD868kniPsYplcuoR2Tw+oC8bus6Iy8t0ZN8m
         MY9HuAS2LALwq61tvAfy0mGGi/GvUIUJFxjk/rtSWmgoqZ+s9JtVOPEgembKBC56096R
         7UNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZDnNw76zNk8esqAJMHM+FCDdcc4eLMi8lxnTIFMjEoc=;
        b=CVFCKZPAo92rBRg8ySMtA581OCqGxgMo1EoNXZaXy8po1XuxCnETWP72cV+W6qvLLp
         S52e8CWNJRB2BwaKSpGckcqj2qUQopp2cDFEY5Q7WEuLnGd5W/jBz5UTDssEwPbaVO27
         GIDVxHHBrmi0/EcznBPFVIRPokp4dKyvZ8jZri9SO/+VpOT0836VLBKmVW0MUbBrU+go
         h5AHQ0+MCb5P449XF6NN4p3ljxTUBtO0YHHOoTvwJ/KPlS2rVBYft4SMO43Zw5cmmAPH
         arI6PBwYFu7wfNnM5fyeXnWJR1stWSKGtYDLoUwFlXsxVnDUVtVRT9pDsTmAD3j8nYMd
         Bo9A==
X-Gm-Message-State: AOAM530nGMivgN3Xbueg/+ccLi0g1Shm8EKo/y6w0u2sNqGq73+e/nAy
        FbzJcjAQXfHlmATHF9lkpANGIG8COQRrpgkJcw==
X-Google-Smtp-Source: ABdhPJwD7ZQB+bXMIKdSSR8cwBls2ei3nwevqyLYfzClsAga5LkcSaX0n8AuCezFfDTOjXJ7m5ysia+yRPzyRp95fn8=
X-Received: by 2002:a17:903:2348:b0:140:37e8:5944 with SMTP id
 c8-20020a170903234800b0014037e85944mr21307645plh.15.1635296361233; Tue, 26
 Oct 2021 17:59:21 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Wed, 27 Oct 2021 08:59:08 +0800
Message-ID: <CACkBjsZunT9P+iddpDp7zQsYLoqs3tyWU3iZ2-zpoMbfqUNCFQ@mail.gmail.com>
Subject: INFO: rcu detected stall in do_idle
To:     tglx@linutronix.de, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@linux.ie,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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
https://drive.google.com/file/d/1_-g_-SXK01zc-1mhvVgiHr7ONSzO5WL8/view?usp=sharing
kernel config: https://drive.google.com/file/d/12PUnxIM1EPBgW4ZJmI7WJBRaY1lA83an/view?usp=sharing

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 0-...0: (1 GPs behind) idle=c05/0/0x1 softirq=126007/126009 fqs=5063
rcu: 3-...0: (6 ticks this GP) idle=2a3/0/0x3 softirq=116486/116488 fqs=5063
(detected by 1, t=10502 jiffies, g=215657, q=298)
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.15.0-rc6 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:mark_lock.part.0+0x136/0x27c0 kernel/locking/lockdep.c:4571
Code: 00 00 00 48 8d 04 52 48 c1 e0 06 48 05 40 ad cf 8f 48 8d 78 50
48 ba 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 80 3c 11 00 <0f> 85
aa 1d 00 00 4c 85 68 50 0f 84 b8 06 00 00 41 ba 01 00 00 00
RSP: 0018:ffffc900000077b0 EFLAGS: 00000046
RAX: ffffffff8fcfee80 RBX: 1ffff92000000efe RCX: 1ffffffff1f9fdda
RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffffffff8fcfeed0
RBP: ffffc90000007918 R08: 0000000000000001 R09: fffffbfff1f9f526
R10: ffffffff8fcfa92f R11: fffffbfff1f9f525 R12: ffffffff8b6bd0b0
R13: 0000000000000100 R14: 0000000000000008 R15: ffffffff8b6bd0d0
FS:  0000000000000000(0000) GS:ffff888063e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555557bec48 CR3: 000000000b68e000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 mark_lock kernel/locking/lockdep.c:4557 [inline]
 mark_usage kernel/locking/lockdep.c:4514 [inline]
 __lock_acquire+0x8e1/0x57e0 kernel/locking/lockdep.c:4969
 lock_acquire kernel/locking/lockdep.c:5625 [inline]
 lock_acquire+0x1ab/0x520 kernel/locking/lockdep.c:5590
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
 lock_hrtimer_base+0x76/0x140 kernel/time/hrtimer.c:173
 hrtimer_try_to_cancel kernel/time/hrtimer.c:1331 [inline]
 hrtimer_try_to_cancel+0xd6/0x570 kernel/time/hrtimer.c:1316
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
RSP: 0018:ffffffff8b607e28 EFLAGS: 00000202
RAX: 0000000000521dc7 RBX: 0000000000000000 RCX: ffffffff8932e632
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed100c7c6542
R10: ffff888063e32a0b R11: ffffed100c7c6541 R12: 0000000000000000
R13: 0000000000000000 R14: ffffffff8d6d8dd0 R15: 0000000000000000
 default_idle_call+0xc4/0x420 kernel/sched/idle.c:112
 cpuidle_idle_call kernel/sched/idle.c:194 [inline]
 do_idle+0x3f9/0x570 kernel/sched/idle.c:306
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:403
 start_kernel+0x47a/0x49b init/main.c:1142
 secondary_startup_64_no_verify+0xb0/0xbb
Sending NMI from CPU 1 to CPUs 3:
NMI backtrace for cpu 3
CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.15.0-rc6 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:kvm_wait+0xb3/0x110 arch/x86/kernel/kvm.c:893
Code: 40 38 c6 74 1b 48 83 c4 10 c3 c3 e8 37 70 49 00 eb 07 0f 00 2d
de 1c 56 08 fb f4 48 83 c4 10 c3 eb 07 0f 00 2d ce 1c 56 08 f4 <48> 83
c4 10 c3 89 74 24 0c 48 89 3c 24 e8 5b 6e 49 00 8b 74 24 0c
RSP: 0018:ffffc900008a08a0 EFLAGS: 00000046
RAX: 0000000000000003 RBX: 0000000000000000 RCX: ffffffff815c2189
RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffff8881050f0338
RBP: ffff8881050f0338 R08: 0000000000000001 R09: ffffed1020a1e068
R10: ffff8881050f0338 R11: ffffed1020a1e067 R12: 0000000000000000
R13: ffffed1020a1e067 R14: 0000000000000001 R15: ffff888135d32840
FS:  0000000000000000(0000) GS:ffff888135d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0901c7cdb8 CR3: 0000000101dc2000 CR4: 0000000000350ee0
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
RIP: 0010:__raw_spin_unlock_irq include/linux/spinlock_api_smp.h:169 [inline]
RIP: 0010:_raw_spin_unlock_irq+0x25/0x40 kernel/locking/spinlock.c:202
Code: 0f 1f 44 00 00 55 48 8b 74 24 08 48 89 fd 48 83 c7 18 e8 1e dc
25 f8 48 89 ef e8 a6 6b 26 f8 e8 d1 95 46 f8 fb bf 01 00 00 00 <e8> 36
d2 19 f8 65 8b 05 6f 2a cc 76 85 c0 74 02 5d c3 e8 bb 7f ca
RSP: 0018:ffffc900008a0e00 EFLAGS: 00000202
RAX: 0000000000627162 RBX: ffffffff866c4e90 RCX: 1ffffffff1adac49
RDX: 0000000000000000 RSI: 0000000000000102 RDI: 0000000000000001
RBP: ffff888135d20240 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000005 R11: ffffed1026ba4048 R12: ffff888135d20240
R13: ffffc900008a0e90 R14: 0000000000000000 R15: dffffc0000000000
 expire_timers kernel/time/timer.c:1465 [inline]
 __run_timers.part.0+0x6a0/0xa90 kernel/time/timer.c:1734
 __run_timers kernel/time/timer.c:1715 [inline]
 run_timer_softirq+0xb6/0x1d0 kernel/time/timer.c:1747
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
RSP: 0018:ffffc90000777de0 EFLAGS: 00000202
RAX: 000000000062715d RBX: 0000000000000003 RCX: ffffffff8932e632
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000003 R08: 0000000000000001 R09: ffffed1026ba6542
R10: ffff888135d32a0b R11: ffffed1026ba6541 R12: 0000000000000003
R13: 0000000000000003 R14: ffffffff8d6d8dd0 R15: 0000000000000000
 default_idle_call+0xc4/0x420 kernel/sched/idle.c:112
 cpuidle_idle_call kernel/sched/idle.c:194 [inline]
 do_idle+0x3f9/0x570 kernel/sched/idle.c:306
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:403
 start_secondary+0x227/0x2f0 arch/x86/kernel/smpboot.c:270
 secondary_startup_64_no_verify+0xb0/0xbb
watchdog: BUG: soft lockup - CPU#1 stuck for 223s! [syz-executor:10710]
Modules linked in:
irq event stamp: 52796
hardirqs last  enabled at (52795): [<ffffffff89400c02>]
asm_sysvec_apic_timer_interrupt+0x12/0x20
arch/x86/include/asm/idtentry.h:638
hardirqs last disabled at (52796): [<ffffffff8932d77b>]
sysvec_apic_timer_interrupt+0xb/0xc0 arch/x86/kernel/apic/apic.c:1097
softirqs last  enabled at (5040): [<ffffffff896005ab>]
softirq_handle_end kernel/softirq.c:401 [inline]
softirqs last  enabled at (5040): [<ffffffff896005ab>]
__do_softirq+0x5ab/0x93b kernel/softirq.c:587
softirqs last disabled at (5019): [<ffffffff81464c62>] invoke_softirq
kernel/softirq.c:432 [inline]
softirqs last disabled at (5019): [<ffffffff81464c62>] __irq_exit_rcu
kernel/softirq.c:636 [inline]
softirqs last disabled at (5019): [<ffffffff81464c62>]
irq_exit_rcu+0xf2/0x130 kernel/softirq.c:648
CPU: 1 PID: 10710 Comm: syz-executor Not tainted 5.15.0-rc6 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:csd_lock_wait kernel/smp.c:440 [inline]
RIP: 0010:smp_call_function_many_cond+0x3db/0xc20 kernel/smp.c:969
Code: 0b 00 85 ed 74 4d 48 b8 00 00 00 00 00 fc ff df 4d 89 f4 4c 89
f5 49 c1 ec 03 83 e5 07 49 01 c4 83 c5 03 e8 87 46 0b 00 f3 90 <41> 0f
b6 04 24 40 38 c5 7c 08 84 c0 0f 85 a2 06 00 00 8b 43 08 31
RSP: 0018:ffffc9000813f650 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff888063e39ce0 RCX: ffff888027a81c80
RDX: 0000000000000000 RSI: ffff888027a81c80 RDI: 0000000000000002
RBP: 0000000000000003 R08: ffffffff816b1839 R09: 0000000000000000
R10: 0000000000000005 R11: fffffbfff1f9f524 R12: ffffed100c7c739d
R13: 0000000000000000 R14: ffff888063e39ce8 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff888135c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f37fe3ec000 CR3: 000000000b68e000 CR4: 0000000000350ee0
Call Trace:
 on_each_cpu_cond_mask+0x56/0xa0 kernel/smp.c:1135
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:929 [inline]
 text_poke_bp_batch+0x1b3/0x560 arch/x86/kernel/alternative.c:1114
 text_poke_flush arch/x86/kernel/alternative.c:1268 [inline]
 text_poke_finish+0x16/0x30 arch/x86/kernel/alternative.c:1275
 arch_jump_label_transform_apply+0x13/0x20 arch/x86/kernel/jump_label.c:146
 jump_label_update+0x32d/0x440 kernel/jump_label.c:830
 static_key_disable_cpuslocked+0x156/0x1c0 kernel/jump_label.c:207
 static_key_disable+0x16/0x20 kernel/jump_label.c:215
 tracepoint_remove_func kernel/tracepoint.c:417 [inline]
 tracepoint_probe_unregister+0x608/0x9a0 kernel/tracepoint.c:551
 trace_event_reg+0x181/0x350 kernel/trace/trace_events.c:517
 perf_trace_event_unreg.isra.0+0xac/0x2b0 kernel/trace/trace_event_perf.c:162
 perf_trace_destroy+0xb5/0xf0 kernel/trace/trace_event_perf.c:243
 _free_event+0x213/0x1270 kernel/events/core.c:4982
 put_event+0x40/0x50 kernel/events/core.c:5076
 perf_event_release_kernel+0x6dd/0x8e0 kernel/events/core.c:5191
 perf_release+0x33/0x40 kernel/events/core.c:5201
 __fput+0x288/0x9f0 fs/file_table.c:280
 task_work_run+0xe0/0x1a0 kernel/task_work.c:164
 exit_task_work include/linux/task_work.h:32 [inline]
 do_exit+0xbbe/0x2dd0 kernel/exit.c:825
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
RIP: 0033:0x2000018a
Code: Unable to access opcode bytes at RIP 0x20000160.
RSP: 002b:00007f0901c5bbb8 EFLAGS: 00000202 ORIG_RAX: 0000000000000022
RAX: fffffffffffffdfe RBX: 0000000000000009 RCX: 000000002000018a
RDX: 0000000000000000 RSI: 000000008000005d RDI: 0000000000000003
RBP: 0000000000000052 R08: 0000000000000005 R09: 0000000000000006
R10: 0000000000000007 R11: 0000000000000202 R12: 000000000000000b
R13: 000000000000000c R14: 000000000000000d R15: 00007f0901c5bdc0
Sending NMI from CPU 1 to CPUs 0,2-3:
NMI backtrace for cpu 0
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.15.0-rc6 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:asm_exc_int3+0x0/0x40 arch/x86/include/asm/idtentry.h:566
Code: 0f 1f 84 00 00 00 00 00 66 90 0f 01 ca 6a ff e8 56 05 00 00 48
89 e7 e8 1e a7 f2 ff e9 09 06 00 00 66 0f 1f 84 00 00 00 00 00 <0f> 01
ca 6a ff f6 44 24 10 03 75 18 ff 74 24 28 ff 74 24 28 ff 74
RSP: 0018:ffffc90000007a68 EFLAGS: 00000046
RAX: 0000000000000000 RBX: 1ffff92000000f55 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888135d223d8
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: ffffed1026ba4478 R12: 0000000000000000
R13: ffff888135d223d8 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888063e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555557bec48 CR3: 000000000b68e000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
RIP: 0010:arch_static_branch arch/x86/include/asm/jump_label.h:27 [inline]
RIP: 0010:static_key_false include/linux/jump_label.h:212 [inline]
RIP: 0010:trace_lock_acquire include/trace/events/lock.h:13 [inline]
RIP: 0010:lock_acquire+0x84/0x520 kernel/locking/lockdep.c:5596
Code: f1 c7 40 04 f1 f1 00 00 c7 40 08 00 00 00 f3 c7 40 0c f3 f3 f3
f3 65 48 8b 04 25 28 00 00 00 48 89 84 24 a8 00 00 00 31 c0 cc <a2> 01
00 00 65 8b 15 d9 ec a5 7e 83 fa 07 0f 87 f3 03 00 00 89 d2
RSP: 0018:ffffc90000007a98 EFLAGS: 00000046
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
 lock_hrtimer_base+0x76/0x140 kernel/time/hrtimer.c:173
 hrtimer_try_to_cancel kernel/time/hrtimer.c:1331 [inline]
 hrtimer_try_to_cancel+0xd6/0x570 kernel/time/hrtimer.c:1316
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
RSP: 0018:ffffffff8b607e28 EFLAGS: 00000202
RAX: 0000000000521dc7 RBX: 0000000000000000 RCX: ffffffff8932e632
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed100c7c6542
R10: ffff888063e32a0b R11: ffffed100c7c6541 R12: 0000000000000000
R13: 0000000000000000 R14: ffffffff8d6d8dd0 R15: 0000000000000000
 default_idle_call+0xc4/0x420 kernel/sched/idle.c:112
 cpuidle_idle_call kernel/sched/idle.c:194 [inline]
 do_idle+0x3f9/0x570 kernel/sched/idle.c:306
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:403
 start_kernel+0x47a/0x49b init/main.c:1142
 secondary_startup_64_no_verify+0xb0/0xbb
NMI backtrace for cpu 3
CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.15.0-rc6 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:kvm_wait+0xb3/0x110 arch/x86/kernel/kvm.c:893
Code: 40 38 c6 74 1b 48 83 c4 10 c3 c3 e8 37 70 49 00 eb 07 0f 00 2d
de 1c 56 08 fb f4 48 83 c4 10 c3 eb 07 0f 00 2d ce 1c 56 08 f4 <48> 83
c4 10 c3 89 74 24 0c 48 89 3c 24 e8 5b 6e 49 00 8b 74 24 0c
RSP: 0018:ffffc900008a08a0 EFLAGS: 00000046
RAX: 0000000000000003 RBX: 0000000000000000 RCX: 1ffff11020a1e067
RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffff8881050f0338
RBP: ffff8881050f0338 R08: 0000000000000001 R09: ffffed1020a1e068
R10: ffff8881050f0338 R11: ffffed1020a1e067 R12: 0000000000000000
R13: ffffed1020a1e067 R14: 0000000000000001 R15: ffff888135d32840
FS:  0000000000000000(0000) GS:ffff888135d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0901c7cdb8 CR3: 0000000101dc2000 CR4: 0000000000350ee0
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
RIP: 0010:__raw_spin_unlock_irq include/linux/spinlock_api_smp.h:169 [inline]
RIP: 0010:_raw_spin_unlock_irq+0x25/0x40 kernel/locking/spinlock.c:202
Code: 0f 1f 44 00 00 55 48 8b 74 24 08 48 89 fd 48 83 c7 18 e8 1e dc
25 f8 48 89 ef e8 a6 6b 26 f8 e8 d1 95 46 f8 fb bf 01 00 00 00 <e8> 36
d2 19 f8 65 8b 05 6f 2a cc 76 85 c0 74 02 5d c3 e8 bb 7f ca
RSP: 0018:ffffc900008a0e00 EFLAGS: 00000202
RAX: 0000000000627162 RBX: ffffffff866c4e90 RCX: 1ffffffff1adac49
RDX: 0000000000000000 RSI: 0000000000000102 RDI: 0000000000000001
RBP: ffff888135d20240 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000005 R11: ffffed1026ba4048 R12: ffff888135d20240
R13: ffffc900008a0e90 R14: 0000000000000000 R15: dffffc0000000000
 expire_timers kernel/time/timer.c:1465 [inline]
 __run_timers.part.0+0x6a0/0xa90 kernel/time/timer.c:1734
 __run_timers kernel/time/timer.c:1715 [inline]
 run_timer_softirq+0xb6/0x1d0 kernel/time/timer.c:1747
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
RSP: 0018:ffffc90000777de0 EFLAGS: 00000202
RAX: 000000000062715d RBX: 0000000000000003 RCX: ffffffff8932e632
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000003 R08: 0000000000000001 R09: ffffed1026ba6542
R10: ffff888135d32a0b R11: ffffed1026ba6541 R12: 0000000000000003
R13: 0000000000000003 R14: ffffffff8d6d8dd0 R15: 0000000000000000
 default_idle_call+0xc4/0x420 kernel/sched/idle.c:112
 cpuidle_idle_call kernel/sched/idle.c:194 [inline]
 do_idle+0x3f9/0x570 kernel/sched/idle.c:306
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:403
 start_secondary+0x227/0x2f0 arch/x86/kernel/smpboot.c:270
 secondary_startup_64_no_verify+0xb0/0xbb
NMI backtrace for cpu 2 skipped: idling at native_safe_halt
arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 2 skipped: idling at arch_safe_halt
arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 2 skipped: idling at default_idle+0xb/0x10
arch/x86/kernel/process.c:716
----------------
Code disassembly (best guess):
   0: 00 00                add    %al,(%rax)
   2: 00 48 8d              add    %cl,-0x73(%rax)
   5: 04 52                add    $0x52,%al
   7: 48 c1 e0 06          shl    $0x6,%rax
   b: 48 05 40 ad cf 8f    add    $0xffffffff8fcfad40,%rax
  11: 48 8d 78 50          lea    0x50(%rax),%rdi
  15: 48 ba 00 00 00 00 00 movabs $0xdffffc0000000000,%rdx
  1c: fc ff df
  1f: 48 89 f9              mov    %rdi,%rcx
  22: 48 c1 e9 03          shr    $0x3,%rcx
  26: 80 3c 11 00          cmpb   $0x0,(%rcx,%rdx,1)
* 2a: 0f 85 aa 1d 00 00    jne    0x1dda <-- trapping instruction
  30: 4c 85 68 50          test   %r13,0x50(%rax)
  34: 0f 84 b8 06 00 00    je     0x6f2
  3a: 41 ba 01 00 00 00    mov    $0x1,%r10d

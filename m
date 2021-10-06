Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845EE423947
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 09:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237660AbhJFIBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 04:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbhJFIBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:01:08 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B38C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 00:59:16 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id j15so1152204plh.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 00:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=7kBPoF8Uw+BYGAzNj7twP8G2MD/YlOs7F9LUBeYt0e4=;
        b=BcfjCBVTi6PfFbDHxpOPP8fN9dNNKW3y2Io7jLvQ+H33Fsgu7VJscYH0JaIe0TPNxl
         rmimcBzH4n6UGJGJ03hUbB6IoUdRw8U7BmYZSAFponqL4mn77pTYXGDDeYaN1cBl+Xol
         K9zHIC3z5j100i3yA01ImGSJr+9Wl1EHG44pPri2+xlbG99zjR0qG+7ZHSNpnAJlR1nO
         fR1ESaXSGSC0J57c8cAna/OR3DdhzDrzPpEChJiNkJ/yvo2rFS0rbgX3pCcZSsYxAm1C
         4R7aXG915d7Tg5IRcmAu25LvMSJS+jQkvgIr0j22PGEMx+MFWxMb+/EsUKiHyMU/KyOU
         ryPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7kBPoF8Uw+BYGAzNj7twP8G2MD/YlOs7F9LUBeYt0e4=;
        b=FoEtqK5XTRwQZY880MvOot0BRKXIXUHq74EqPNJ2TLgUKoXiQegJ/RdhqJod9047/V
         BDouvTDLSDBXKs2NVWkGNCZClDhpefBN1uloZpvFyOIUcNQuIzfsTeJgutgj62Doe50u
         /926i739xic1LhFB3Iun6H8ov/LotfLZX0/u8DunEfaJSKu1FuYrdXbsmyVRsvvDquBX
         GyXUyNjRn7nVdczvb5zeIAN8QxMlkKR27OLIHRaAURwB8BKyQkHNDLkcd+qmTWvB1wWd
         gdvvbCn9vvnzamx7zpuWkqfbwD1vo+wX/ewL2tRThgismAxBV5Hwj9gyZpPSOxC8HsQA
         W0bg==
X-Gm-Message-State: AOAM530abBu41NhKJ/XdLSPdU73q3AgiGYCOe5wOhI3p8jsCN6mhvlfH
        B11ripkqwd5Qe0xGRcbBe/mrxe28ln2P+xqE4w==
X-Google-Smtp-Source: ABdhPJx6t8SP9k4SS0dJB/tFoaN0rEAbzNBMhUGxrwjT0T97hnPeeUc5ywBbsiYfrV95zJ/5FRFk/JldL3sfHbvC/h4=
X-Received: by 2002:a17:90a:a78f:: with SMTP id f15mr9384060pjq.106.1633507156187;
 Wed, 06 Oct 2021 00:59:16 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Wed, 6 Oct 2021 15:59:05 +0800
Message-ID: <CACkBjsZirrhVnGLRMY7PDCBskRAjr3fm7QJ7CAT2_uHOyhOJhw@mail.gmail.com>
Subject: BUG: soft lockup in prandom_reseed
To:     davem@davemloft.net, kuba@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 0513e464f900 Merge tag 'perf-tools-fixes-for-v5.15-2021-09-27'
git tree: upstream
console output:
https://drive.google.com/file/d/11jJ3cqNNYYQHu5j60QjoZxzNzmFORwVG/view?usp=sharing
kernel config: https://drive.google.com/file/d/1Jqhc4DpCVE8X7d-XBdQnrMoQzifTG5ho/view?usp=sharing

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

watchdog: BUG: soft lockup - CPU#3 stuck for 121s! [kworker/3:4:3028]
Modules linked in:
irq event stamp: 991777
hardirqs last  enabled at (991776): [<ffffffff84260ef0>]
__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160
[inline]
hardirqs last  enabled at (991776): [<ffffffff84260ef0>]
_raw_spin_unlock_irqrestore+0x50/0x70 kernel/locking/spinlock.c:194
hardirqs last disabled at (991777): [<ffffffff8424b3ca>]
sysvec_apic_timer_interrupt+0xa/0xc0 arch/x86/kernel/apic/apic.c:1097
softirqs last  enabled at (991728): [<ffffffff84600398>]
softirq_handle_end kernel/softirq.c:401 [inline]
softirqs last  enabled at (991728): [<ffffffff84600398>]
__do_softirq+0x398/0x561 kernel/softirq.c:587
softirqs last disabled at (991739): [<ffffffff81235bc2>]
invoke_softirq kernel/softirq.c:432 [inline]
softirqs last disabled at (991739): [<ffffffff81235bc2>]
__irq_exit_rcu kernel/softirq.c:636 [inline]
softirqs last disabled at (991739): [<ffffffff81235bc2>]
irq_exit_rcu+0xe2/0x100 kernel/softirq.c:648
CPU: 3 PID: 3028 Comm: kworker/3:4 Not tainted 5.15.0-rc3+ #21
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Workqueue: events_freezable_power_ sync_hw_clock
RIP: 0010:__raw_spin_unlock_irqrestore
include/linux/spinlock_api_smp.h:161 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x38/0x70 kernel/locking/spinlock.c:194
Code: 74 24 10 e8 8a 9c 05 fd 48 89 ef e8 c2 d4 05 fd 81 e3 00 02 00
00 75 25 9c 58 f6 c4 02 75 2d 48 85 db 74 01 fb bf 01 00 00 00 <e8> 33
6a 01 fd 65 8b 05 1c 61 db 7b 85 c0 74 0a 5b 5d c3 e8 60 e6
RSP: 0018:ffffc90000768df0 EFLAGS: 00000206
RAX: 0000000000000012 RBX: 0000000000000200 RCX: 0000000000000002
RDX: 0000000000000000 RSI: ffffffff85525cc5 RDI: 0000000000000001
RBP: ffff88813dd26728 R08: 0000000000000001 R09: 0000000000000001
R10: ffffc90000768d98 R11: 000000005b16a049 R12: ffff88813dd26728
R13: 0000000000000282 R14: 0000000000000001 R15: d9265d7923349dab
FS:  0000000000000000(0000) GS:ffff88813dd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055c01abad160 CR3: 0000000104f79000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <IRQ>
 spin_unlock_irqrestore include/linux/spinlock.h:418 [inline]
 get_random_u64+0x73/0xb0 drivers/char/random.c:2182
 get_random_long include/linux/random.h:61 [inline]
 prandom_reseed+0xb7/0x1c0 lib/random32.c:509
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
RIP: 0010:__raw_spin_unlock_irqrestore
include/linux/spinlock_api_smp.h:161 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x38/0x70 kernel/locking/spinlock.c:194
Code: 74 24 10 e8 8a 9c 05 fd 48 89 ef e8 c2 d4 05 fd 81 e3 00 02 00
00 75 25 9c 58 f6 c4 02 75 2d 48 85 db 74 01 fb bf 01 00 00 00 <e8> 33
6a 01 fd 65 8b 05 1c 61 db 7b 85 c0 74 0a 5b 5d c3 e8 60 e6
RSP: 0018:ffffc900007e7d38 EFLAGS: 00000206
RAX: 0000000000000002 RBX: 0000000000000200 RCX: 0000000000000006
RDX: 0000000000000000 RSI: ffffffff85525cc5 RDI: 0000000000000001
RBP: ffffffff858fa500 R08: 0000000000000001 R09: 0000000000000001
R10: ffffc900007e7ce0 R11: 0000000000000003 R12: 0000000000000000
R13: 0000000000000004 R14: 0000000000000010 R15: 0000000000000021
 spin_unlock_irqrestore include/linux/spinlock.h:418 [inline]
 mc146818_set_time+0x1cd/0x250 drivers/rtc/rtc-mc146818-lib.c:214
 rtc_set_time+0xeb/0x2f0 drivers/rtc/interface.c:158
 update_rtc kernel/time/ntp.c:597 [inline]
 sync_hw_clock+0x272/0x2a0 kernel/time/ntp.c:656
 process_one_work+0x359/0x850 kernel/workqueue.c:2297
 worker_thread+0x41/0x4d0 kernel/workqueue.c:2444
 kthread+0x178/0x1b0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Sending NMI from CPU 3 to CPUs 0-2:
NMI backtrace for cpu 2
CPU: 2 PID: 1 Comm: systemd Not tainted 5.15.0-rc3+ #21
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0033:0x55628528d760
Code: 66 2e 0f 1f 84 00 00 00 00 00 31 f6 48 89 df e8 76 62 03 00 e9
57 fd ff ff e8 7c 71 fb ff 66 66 66 2e 0f 1f 84 00 00 00 00 00 <53> 48
83 ec 10 64 48 8b 04 25 28 00 00 00 48 89 44 24 08 31 c0 48
RSP: 002b:00007ffc959581c8 EFLAGS: 00010206
RAX: 000055628528d760 RBX: 0000556286c4d630 RCX: 00007f1c5f9a102c
RDX: 0000000000000000 RSI: 00007ffc959581f8 RDI: 0000556286c3f220
RBP: 00007ffc9595821d R08: 00007f1c5f9a102c R09: 0000000000000003
R10: 0000000000000073 R11: 00007ffc95957ed8 R12: 00007ffc95958240
R13: 0000556286c3f220 R14: 0000556286c51400 R15: 0000556286c0c9a0
FS:  00007f1c5fc9e500 GS:  0000000000000000
NMI backtrace for cpu 1
CPU: 1 PID: 15100 Comm: sshd Not tainted 5.15.0-rc3+ #21
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0033:0x7ff7521ea5c0
Code: 06 a3 37 00 4c 8b 44 24 18 48 8b 4c 24 10 48 8b 54 24 08 8b 74
24 04 8b 3c 24 eb ae 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 <48> 8b
05 b1 88 37 00 64 48 03 04 25 00 00 00 00 c3 66 2e 0f 1f 84
RSP: 002b:00007ffe9448ad18 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 00007ff7522a5910
RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007ff7522a5900 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000073 R11: 0000000000000246 R12: 0000000000000003
R13: 00007ffe9448b1a0 R14: 0000000000000000 R15: 0000000000000000
FS:  00007ff75413c8c0 GS:  0000000000000000
NMI backtrace for cpu 0
CPU: 0 PID: 15098 Comm: kworker/u9:2 Not tainted 5.15.0-rc3+ #21
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:latency_exceeded block/blk-wbt.c:237 [inline]
RIP: 0010:wb_timer_fn+0x4b/0x990 block/blk-wbt.c:360
Code: 24 78 8b ab d0 00 00 00 8b 93 28 01 00 00 8b 83 80 01 00 00 4c
8b 6b 28 01 d5 01 c5 48 8b 43 60 4d 85 ed 48 8b 80 b0 00 00 00 <4c> 8b
b8 48 01 00 00 0f 84 95 00 00 00 e8 43 f7 0f ff 48 83 7b 30
RSP: 0018:ffffc90000003e38 EFLAGS: 00010246
RAX: ffff88800cdccc00 RBX: ffff88800ce08a00 RCX: 0000000000000100
RDX: 0000000000000000 RSI: ffffffff822799d6 RDI: ffff88800b3bc540
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: ffffc90000003d40 R11: 0000000000000005 R12: ffff88800b7a59c0
R13: 0000000000000000 R14: ffff88800b3bc550 R15: ffff88800b3bc550
FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556286c16e88 CR3: 000000000588a000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <IRQ>
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
RIP: 0010:csd_lock_wait kernel/smp.c:440 [inline]
RIP: 0010:smp_call_function_many_cond+0x1d2/0x550 kernel/smp.c:969
Code: a5 04 00 4c 63 fd 49 8b 1c 24 49 83 ff 07 0f 87 31 03 00 00 4a
03 1c fd 80 a8 62 85 8b 43 08 a8 01 74 0e e8 60 a5 04 00 f3 90 <8b> 43
08 a8 01 75 f2 e8 52 a5 04 00 eb ad 48 83 c4 40 5b 5d 41 5c
RSP: 0018:ffffc9000f21fc80 EFLAGS: 00000293
RAX: 0000000000000000 RBX: ffff88813dd2f9c0 RCX: 0000000000000000
RDX: ffff888010750000 RSI: ffffffff8132ec00 RDI: 0000000000000002
RBP: 0000000000000003 R08: 0000000000000001 R09: 0000000000000001
R10: ffffc9000f21fc28 R11: 0000000000000005 R12: ffff88807dc2a900
R13: ffff88807dc2a908 R14: ffffffff85a27660 R15: 0000000000000003
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
----------------
Code disassembly (best guess):
   0: 74 24                je     0x26
   2: 10 e8                adc    %ch,%al
   4: 8a 9c 05 fd 48 89 ef mov    -0x1076b703(%rbp,%rax,1),%bl
   b: e8 c2 d4 05 fd        callq  0xfd05d4d2
  10: 81 e3 00 02 00 00    and    $0x200,%ebx
  16: 75 25                jne    0x3d
  18: 9c                    pushfq
  19: 58                    pop    %rax
  1a: f6 c4 02              test   $0x2,%ah
  1d: 75 2d                jne    0x4c
  1f: 48 85 db              test   %rbx,%rbx
  22: 74 01                je     0x25
  24: fb                    sti
  25: bf 01 00 00 00        mov    $0x1,%edi
* 2a: e8 33 6a 01 fd        callq  0xfd016a62 <-- trapping instruction
  2f: 65 8b 05 1c 61 db 7b mov    %gs:0x7bdb611c(%rip),%eax        # 0x7bdb6152
  36: 85 c0                test   %eax,%eax
  38: 74 0a                je     0x44
  3a: 5b                    pop    %rbx
  3b: 5d                    pop    %rbp
  3c: c3                    retq
  3d: e8                    .byte 0xe8
  3e: 60                    (bad)
  3f: e6                    .byte 0xe6

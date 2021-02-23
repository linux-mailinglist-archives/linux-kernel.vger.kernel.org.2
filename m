Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFFB9322B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 14:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbhBWNgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 08:36:08 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:55033 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbhBWNgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 08:36:04 -0500
Received: by mail-io1-f71.google.com with SMTP id w26so5688932iow.21
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 05:35:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xXFs0FGY7w/7hFZ4ZbMJvgB6H8dk/uWKVTDu3ZuBdrI=;
        b=L5wQ7s06RYq+HLLONgXrW80uCZitru3T+MIuuaVYkpUWjyHY6z1BvI8hO5En+x1WGX
         s5XRypSBu5rNja5McjH081i9gqoQI/Qmkg8o5uBQXaXykUg7GfdoIOwdgNFjxhYujuKD
         LPz9t58aL/+uxuI6iI+9tbZDweFTquerKv0Kv2MtjZyxtBxiCg3j2xlr/njyeX5b16xc
         5PGQRr2zj2Zy1rSbIWlbZ7Q5o/OQgQK8xeuT+zTYPVJNwlhJZWNLfE3PEwQBu2d3KxY4
         Brm7/hfURPtk/5JH/CC//Y+8hCz2rnvFNYw6FwoS3p9Pw/BRkVlLxma79P9t7If6Eho5
         qGOA==
X-Gm-Message-State: AOAM530s680YLk7H+EQICuSJp+PuVojixWNYbEeSubyjOC66KSPWiu4c
        ybvF8tpQFWOvAdJCP3qfYnj3UzqbwjELs13f/pK9beNam60m
X-Google-Smtp-Source: ABdhPJyd4B661rhn2/cpIiU/Cda/J74QxsJG60bvqcm/re5a/YUoKUYTJksg+2lDdokGBOLj7HTvFincsZm6woV/3k73G/CZEia4
MIME-Version: 1.0
X-Received: by 2002:a05:6638:bcf:: with SMTP id g15mr27212848jad.58.1614087323902;
 Tue, 23 Feb 2021 05:35:23 -0800 (PST)
Date:   Tue, 23 Feb 2021 05:35:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000093e52e05bc00fdcb@google.com>
Subject: UBSAN: shift-out-of-bounds in detach_tasks
From:   syzbot <syzbot+f9131489729201445f66@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bp@alien8.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    31caf8b2 Merge branch 'linus' of git://git.kernel.org/pub/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=167b3f04d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f1351eea7b07cf47
dashboard link: https://syzkaller.appspot.com/bug?extid=f9131489729201445f66
compiler:       Debian clang version 11.0.1-2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f9131489729201445f66@syzkaller.appspotmail.com

================================================================================
UBSAN: shift-out-of-bounds in kernel/sched/fair.c:7712:14
shift exponent 78 is too large for 64-bit type 'unsigned long'
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.11.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x125/0x19e lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:148 [inline]
 __ubsan_handle_shift_out_of_bounds+0x432/0x4d0 lib/ubsan.c:395
 detach_tasks+0xd04/0x1110 kernel/sched/fair.c:7712
 load_balance+0x3a06/0x5aa0 kernel/sched/fair.c:9641
 rebalance_domains+0x4ca/0x9c0 kernel/sched/fair.c:10029
 __do_softirq+0x318/0x714 kernel/softirq.c:343
 asm_call_irq_on_stack+0xf/0x20
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
 do_softirq_own_stack+0x9a/0xe0 arch/x86/kernel/irq_64.c:77
 invoke_softirq kernel/softirq.c:226 [inline]
 __irq_exit_rcu+0x1d8/0x200 kernel/softirq.c:420
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:432
 sysvec_apic_timer_interrupt+0xe0/0xf0 arch/x86/kernel/apic/apic.c:1100
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:635
RIP: 0010:native_save_fl arch/x86/include/asm/irqflags.h:29 [inline]
RIP: 0010:arch_local_save_flags arch/x86/include/asm/irqflags.h:70 [inline]
RIP: 0010:arch_irqs_disabled arch/x86/include/asm/irqflags.h:137 [inline]
RIP: 0010:acpi_safe_halt drivers/acpi/processor_idle.c:111 [inline]
RIP: 0010:acpi_idle_do_entry drivers/acpi/processor_idle.c:516 [inline]
RIP: 0010:acpi_idle_enter+0x3c9/0x700 drivers/acpi/processor_idle.c:647
Code: 08 31 ff e8 f9 bc 5e fd 48 83 e3 08 0f 85 06 01 00 00 e8 8a b2 64 fd e9 0c 00 00 00 e8 30 b8 5e fd 0f 00 2d 09 aa 00 06 fb f4 <9c> 8f 44 24 10 48 8d 44 24 10 48 c1 e8 03 42 80 3c 38 00 74 0a 48
RSP: 0018:ffffc90000d47dc0 EFLAGS: 00000282
RAX: 36452ebac7a23f00 RBX: 0000000000000000 RCX: ffffffff8ff8aa03
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffff88801368e800 R08: ffffffff817e80e0 R09: ffffed10023b26f1
R10: ffffed10023b26f1 R11: 0000000000000000 R12: ffff8880186a0804
R13: ffff88801368e864 R14: 1ffff110030d4100 R15: dffffc0000000000
 cpuidle_enter_state+0x486/0xd50 drivers/cpuidle/cpuidle.c:237
 cpuidle_enter+0x59/0x90 drivers/cpuidle/cpuidle.c:351
 call_cpuidle kernel/sched/idle.c:158 [inline]
 cpuidle_idle_call kernel/sched/idle.c:239 [inline]
 do_idle+0x315/0x530 kernel/sched/idle.c:300
 cpu_startup_entry+0x15/0x20 kernel/sched/idle.c:397
 secondary_startup_64_no_verify+0xb0/0xbb
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

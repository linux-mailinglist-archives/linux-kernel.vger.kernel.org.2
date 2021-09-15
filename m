Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0574540BF8F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 08:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbhIOGHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 02:07:40 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:51777 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhIOGHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 02:07:38 -0400
Received: by mail-il1-f200.google.com with SMTP id f16-20020a92cb50000000b002376905517dso1208235ilq.18
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 23:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=oRcwdcQV1H0omKzYkhuLZ+wr8KRDqA6jkU+EpjgxD3Y=;
        b=ie9O2ySbKTbGV721iem8wVMYQbyHwass2BuKfkI3EH76u8W11EYL47knsmJHYvYkYv
         syx/PQwKF0tZowEGhwurNrya29PQVu6merOthv9mAdH6PC1kzdEfiZE+FXvEdcivwbx0
         0nNNtw76mi8aagMHBhNcs56V7Q0ofmBdNE41vzpCPyItzV+GFrvOfloelYljLBhif+yo
         /AiHLqNfL0UeDJ8YzlAUjqpnL2gFU6btiZBOPhjeu1qIKs1DLcMQ+qtGfSWqBTRH/Jno
         qc0aLEzEZd7hjuOazLb1mCjFPjU7SiFmmfFo2Bs4mDmeZKJt4k2C3F+VSU5sTMS1Nw9i
         DXeg==
X-Gm-Message-State: AOAM530JAcFQWVaX6JN+cCQm4VS+lRy+BrIH7hkyKfHOY5vDF791W4D0
        NJuw02m53GFUAt7dIch5oKbOVEDiNcNSe1zYpBVg9zvjbuyk
X-Google-Smtp-Source: ABdhPJzJepNg0KG6KKDUgKLpFoVKg7RsPcyXkE3Nr+qCW9M0EEoqfFshEstwnnB7MhsElkm50LdEOxQxbkxkTcoAeye7boaq2pOf
MIME-Version: 1.0
X-Received: by 2002:a92:cf50:: with SMTP id c16mr14991228ilr.8.1631685979681;
 Tue, 14 Sep 2021 23:06:19 -0700 (PDT)
Date:   Tue, 14 Sep 2021 23:06:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000343aaf05cc027f83@google.com>
Subject: [syzbot] WARNING in insert_work
From:   syzbot <syzbot+4546a69bfcab9a42f280@syzkaller.appspotmail.com>
To:     bp@alien8.de, dwmw@amazon.co.uk, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    926de8c4326c Merge tag 'acpi-5.15-rc1-3' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=123a37b9300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37df9ef5660a8387
dashboard link: https://syzkaller.appspot.com/bug?extid=4546a69bfcab9a42f280
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4546a69bfcab9a42f280@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/workqueue.c:633 set_work_data kernel/workqueue.c:633 [inline]
WARNING: CPU: 0 PID: 0 at kernel/workqueue.c:633 set_work_pwq kernel/workqueue.c:640 [inline]
WARNING: CPU: 0 PID: 0 at kernel/workqueue.c:633 insert_work+0x2a7/0x370 kernel/workqueue.c:1356
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.14.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:set_work_data kernel/workqueue.c:633 [inline]
RIP: 0010:set_work_pwq kernel/workqueue.c:640 [inline]
RIP: 0010:insert_work+0x2a7/0x370 kernel/workqueue.c:1356
Code: b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 cc 00 00 00 48 8b 7b 40 e8 30 93 05 00 eb 83 e8 09 86 2a 00 <0f> 0b e9 dc fd ff ff 48 89 ef e8 ca d0 71 00 e9 56 ff ff ff 4c 89
RSP: 0018:ffffc90000007c70 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff888088ac54b0 RCX: 0000000000000100
RDX: ffffffff8b6bc680 RSI: ffffffff814b8737 RDI: 0000000000000003
RBP: 0000000000000005 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff814b8511 R11: 0000000000000000 R12: ffff888010c69858
R13: ffff888147c49800 R14: ffff888010c69800 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4db76b6ab4 CR3: 000000000b68e000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
Call Trace:
 <IRQ>
 __queue_work+0x5ca/0xee0 kernel/workqueue.c:1519
 call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1421
 expire_timers kernel/time/timer.c:1461 [inline]
 __run_timers.part.0+0x49f/0xa20 kernel/time/timer.c:1734
 __run_timers kernel/time/timer.c:1715 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1747
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 invoke_softirq kernel/softirq.c:432 [inline]
 __irq_exit_rcu+0x123/0x180 kernel/softirq.c:636
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:648
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:native_save_fl arch/x86/include/asm/irqflags.h:29 [inline]
RIP: 0010:arch_local_save_flags arch/x86/include/asm/irqflags.h:70 [inline]
RIP: 0010:arch_irqs_disabled arch/x86/include/asm/irqflags.h:132 [inline]
RIP: 0010:acpi_safe_halt drivers/acpi/processor_idle.c:110 [inline]
RIP: 0010:acpi_idle_do_entry+0x1c6/0x250 drivers/acpi/processor_idle.c:553
Code: 89 de e8 dd 99 3e f8 84 db 75 ac e8 94 93 3e f8 e8 1f bd 44 f8 eb 0c e8 88 93 3e f8 0f 00 2d 81 5e b8 00 e8 7c 93 3e f8 fb f4 <9c> 5b 81 e3 00 02 00 00 fa 31 ff 48 89 de e8 c7 98 3e f8 48 85 db
RSP: 0018:ffffffff8b607d60 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffffffff8b6bc680 RSI: ffffffff893779c4 RDI: 0000000000000000
RBP: ffff8880145f4064 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff817c3708 R11: 0000000000000000 R12: 0000000000000001
R13: ffff8880145f4000 R14: ffff8880145f4064 R15: ffff8881407fa804
 acpi_idle_enter+0x361/0x500 drivers/acpi/processor_idle.c:688
 cpuidle_enter_state+0x1b1/0xc80 drivers/cpuidle/cpuidle.c:237
 cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:351
 call_cpuidle kernel/sched/idle.c:158 [inline]
 cpuidle_idle_call kernel/sched/idle.c:239 [inline]
 do_idle+0x3e8/0x590 kernel/sched/idle.c:306
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:403
 start_kernel+0x47a/0x49b init/main.c:1141
 secondary_startup_64_no_verify+0xb0/0xbb
----------------
Code disassembly (best guess):
   0:	89 de                	mov    %ebx,%esi
   2:	e8 dd 99 3e f8       	callq  0xf83e99e4
   7:	84 db                	test   %bl,%bl
   9:	75 ac                	jne    0xffffffb7
   b:	e8 94 93 3e f8       	callq  0xf83e93a4
  10:	e8 1f bd 44 f8       	callq  0xf844bd34
  15:	eb 0c                	jmp    0x23
  17:	e8 88 93 3e f8       	callq  0xf83e93a4
  1c:	0f 00 2d 81 5e b8 00 	verw   0xb85e81(%rip)        # 0xb85ea4
  23:	e8 7c 93 3e f8       	callq  0xf83e93a4
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	9c                   	pushfq <-- trapping instruction
  2b:	5b                   	pop    %rbx
  2c:	81 e3 00 02 00 00    	and    $0x200,%ebx
  32:	fa                   	cli
  33:	31 ff                	xor    %edi,%edi
  35:	48 89 de             	mov    %rbx,%rsi
  38:	e8 c7 98 3e f8       	callq  0xf83e9904
  3d:	48 85 db             	test   %rbx,%rbx


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

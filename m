Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFBE338280
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 01:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhCLAh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 19:37:28 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:55642 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhCLAhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 19:37:12 -0500
Received: by mail-io1-f72.google.com with SMTP id e15so16663659ioe.22
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 16:37:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=kzzLyjEooH5a1ePxMOJOMCLElnyMMvuRoZP/W6R9Py4=;
        b=RujiNzuf95HmtMALd4ejV0AvD6pQkP/LaUJ8/rvNp2IWtGYpUtNox1wZeTOxvOfqPy
         PJCuvmqpFXlbYDPljcOmr5B6GzB6mb1qEOrvqL7ggYVSTAjZ4xBlMVVKJ3ZXixxfG/iQ
         amGq50DPrXRkHQSCO0pTqHovMwK9lcy7uHDtlGPg7B2fC9BsATVuXRQnjPvA/1PvezXH
         HXeMr3HwukJYPMxaEK+HHuf3qECnYKSpkbvg5BG2BkO05MtOeR1ANfAMKQDrXcSoExfV
         Btubsgnvp4zpyuUI1TC9Ue+JPeHR6CN1siqTIal6SA32XEay5uqR6erkzDTzlxOmsVxX
         uSeg==
X-Gm-Message-State: AOAM532xS//PmZtsTLgMfiHAGijeS0s7YPWbAicObJdLIn4YUbY7nrYW
        5pE67Ag/eDJmJdESSb6w/81snaQIPehmf6y7gF49uoK4qGnG
X-Google-Smtp-Source: ABdhPJzrJY8+RgG1fy9BrJUCN4ZBicF49h/Ia+1gbtBU2f8M8/mlQPc44Bp9cwl2b3ADRvK/hfgQ0SZeP+HOZGfTDz+jxVtLBzgm
MIME-Version: 1.0
X-Received: by 2002:a92:730a:: with SMTP id o10mr900022ilc.160.1615509431996;
 Thu, 11 Mar 2021 16:37:11 -0800 (PST)
Date:   Thu, 11 Mar 2021 16:37:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d356ca05bd4c1974@google.com>
Subject: [syzbot] WARNING in handle_mm_fault
From:   syzbot <syzbot+7d7013084f0a806f3786@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, seanjc@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    05a59d79 Merge git://git.kernel.org:/pub/scm/linux/kernel/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16f493ead00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=750735fdbc630971
dashboard link: https://syzkaller.appspot.com/bug?extid=7d7013084f0a806f3786

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7d7013084f0a806f3786@syzkaller.appspotmail.com

------------[ cut here ]------------
raw_local_irq_restore() called with IRQs enabled
WARNING: CPU: 0 PID: 8412 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x1d/0x20 kernel/locking/irqflag-debug.c:10
Modules linked in:
CPU: 0 PID: 8412 Comm: syz-fuzzer Not tainted 5.12.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:warn_bogus_irq_restore+0x1d/0x20 kernel/locking/irqflag-debug.c:10
Code: be ff cc cc cc cc cc cc cc cc cc cc cc 80 3d 11 d1 ad 04 00 74 01 c3 48 c7 c7 20 79 6b 89 c6 05 00 d1 ad 04 01 e8 75 5b be ff <0f> 0b c3 48 39 77 10 0f 84 97 00 00 00 66 f7 47 22 f0 ff 74 4b 48
RSP: 0000:ffffc9000185fac8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff8880194268a0 RCX: 0000000000000000
RBP: 0000000000000200 R08: 0000000000000000 R09: 0000000000000000
R13: ffffed1003284d14 R14: 0000000000000001 R15: ffff8880b9c36000
FS:  000000c00002ec90(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
Call Trace:
 handle_mm_fault+0x1bc/0x7e0 mm/memory.c:4549
Code: 48 8d 05 97 25 3e 00 48 89 44 24 08 e8 6d 54 ea ff 90 e8 07 a1 ed ff eb a5 cc cc cc cc cc 8b 44 24 10 48 8b 4c 24 08 89 41 24 <c3> cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 48 8b
RAX: 00000000000047f6 RBX: 00000000000047f6 RCX: 0000000000d60000
RDX: 0000000000004c00 RSI: 0000000000d60000 RDI: 000000000181cad0
RBP: 000000c000301890 R08: 00000000000047f5 R09: 000000000059c5a0
R10: 000000c0004e2000 R11: 0000000000000020 R12: 00000000000000fa
R13: 00aaaaaaaaaaaaaa R14: 000000000093f064 R15: 0000000000000038
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 8412 Comm: syz-fuzzer Not tainted 5.12.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 panic+0x306/0x73d kernel/panic.c:231
 __warn.cold+0x35/0x44 kernel/panic.c:605
 report_bug+0x1bd/0x210 lib/bug.c:195
 handle_bug+0x3c/0x60 arch/x86/kernel/traps.c:239
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:259
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:575
RIP: 0010:warn_bogus_irq_restore+0x1d/0x20 kernel/locking/irqflag-debug.c:10
Code: be ff cc cc cc cc cc cc cc cc cc cc cc 80 3d 11 d1 ad 04 00 74 01 c3 48 c7 c7 20 79 6b 89 c6 05 00 d1 ad 04 01 e8 75 5b be ff <0f> 0b c3 48 39 77 10 0f 84 97 00 00 00 66 f7 47 22 f0 ff 74 4b 48
RSP: 0000:ffffc9000185fac8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff8880194268a0 RCX: 0000000000000000
RDX: ffff88802f7b2400 RSI: ffffffff815b4435 RDI: fffff5200030bf4b
RBP: 0000000000000200 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815ad19e R11: 0000000000000000 R12: 0000000000000003
R13: ffffed1003284d14 R14: 0000000000000001 R15: ffff8880b9c36000
 kvm_wait arch/x86/kernel/kvm.c:860 [inline]
 kvm_wait+0xc9/0xe0 arch/x86/kernel/kvm.c:837
 pv_wait arch/x86/include/asm/paravirt.h:564 [inline]
 pv_wait_head_or_lock kernel/locking/qspinlock_paravirt.h:470 [inline]
 __pv_queued_spin_lock_slowpath+0x8b8/0xb40 kernel/locking/qspinlock.c:508
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:554 [inline]
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:85 [inline]
 do_raw_spin_lock+0x200/0x2b0 kernel/locking/spinlock_debug.c:113
 spin_lock include/linux/spinlock.h:354 [inline]
 pmd_lock include/linux/mm.h:2264 [inline]
 huge_pmd_set_accessed+0x103/0x320 mm/huge_memory.c:1265
 __handle_mm_fault+0xeeb/0x4f70 mm/memory.c:4445
 handle_mm_fault+0x1bc/0x7e0 mm/memory.c:4549
 do_user_addr_fault+0x483/0x1210 arch/x86/mm/fault.c:1390
 handle_page_fault arch/x86/mm/fault.c:1475 [inline]
 exc_page_fault+0x9e/0x180 arch/x86/mm/fault.c:1531
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:577
RIP: 0033:0x59072c
Code: 48 8d 05 97 25 3e 00 48 89 44 24 08 e8 6d 54 ea ff 90 e8 07 a1 ed ff eb a5 cc cc cc cc cc 8b 44 24 10 48 8b 4c 24 08 89 41 24 <c3> cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 48 8b
RSP: 002b:000000c0003017b0 EFLAGS: 00010246
RAX: 00000000000047f6 RBX: 00000000000047f6 RCX: 0000000000d60000
RDX: 0000000000004c00 RSI: 0000000000d60000 RDI: 000000000181cad0
RBP: 000000c000301890 R08: 00000000000047f5 R09: 000000000059c5a0
R10: 000000c0004e2000 R11: 0000000000000020 R12: 00000000000000fa
R13: 00aaaaaaaaaaaaaa R14: 000000000093f064 R15: 0000000000000038
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

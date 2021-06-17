Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A870E3AA95D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 05:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhFQDK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 23:10:26 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:41780 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhFQDKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 23:10:24 -0400
Received: by mail-il1-f199.google.com with SMTP id v15-20020a92d24f0000b02901e85881a504so2957768ilg.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 20:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5wSLmuEKWVWZ4o/VdXK1flfdY5PDMnv9T0Pa0EDBKs4=;
        b=d7s2T0pbIGxfAslXrdsP3XVYpn8XjTeoEaMv5yFlgLDCdlBpJXCTY9D/UMOIWhe7H7
         GtDPHU88dAdOIdRgNY/FUsRKka+Jvd+uXJUbHUONTCM4NT+EragqOYsQ9zC/cQnS8w1y
         paHuyhEcOcplL1Keokv+yI+7DVe8aECOFn4KtuR5E0lD05w7VH4Y+QV2oRmCNpGEdR0U
         BWpd53RQe6SInYSXEmcjk8V1MWZniuvEvCvTPHxGYgltxeqI7azu8HfxaqPuDSMqblMW
         UGwbfWim45gSfCbsKMpKJYhgiJvSe9GLro99jmFwY2SezDD6n49D171DxsXNCfdfQhXw
         Mw3Q==
X-Gm-Message-State: AOAM533T/Slbp6nXT0PporvnoeUsNQ08ItgOmwTqWcxg4j+CB6Fun8ik
        Mjb/jXRWNNZiYsiKqi2XsHnLZ5YkT7YJgkt888yasQyQM3EJ
X-Google-Smtp-Source: ABdhPJzh2GSokZ9orEWjnJxDm6LyMifBqPM9STFtFZjv4eLrLTlSekPR1QxDjckQPnH80RRogOdC5oR2byHHws+Xj3znahYsBfHD
MIME-Version: 1.0
X-Received: by 2002:a6b:6617:: with SMTP id a23mr1881927ioc.0.1623899297776;
 Wed, 16 Jun 2021 20:08:17 -0700 (PDT)
Date:   Wed, 16 Jun 2021 20:08:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb8e3a05c4ed84bb@google.com>
Subject: [syzbot] KASAN: stack-out-of-bounds Read in __show_regs
From:   syzbot <syzbot+b17d3e853d5dce65f981@syzkaller.appspotmail.com>
To:     0x7f454c46@gmail.com, bp@alien8.de, chang.seok.bae@intel.com,
        hpa@zytor.com, krisman@collabora.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, sashal@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ad347abe Merge tag 'trace-v5.13-rc5-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11013e50300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=30f476588412c065
dashboard link: https://syzkaller.appspot.com/bug?extid=b17d3e853d5dce65f981
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164b6a70300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b17d3e853d5dce65f981@syzkaller.appspotmail.com

 irqentry_exit+0x31/0x80 kernel/entry/common.c:426
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:647
RIP: 891806d5:0xffffed1002495388
RSP: 4299d728:ffffc9000b90fbf8 EFLAGS: fffffe00 ORIG_RAX: ffffffff88b60c00
==================================================================
BUG: KASAN: stack-out-of-bounds in __show_regs.cold+0x4e/0x508 arch/x86/kernel/process_64.c:80
Read of size 8 at addr ffffc9000b90fb20 by task systemd-journal/4846

CPU: 0 PID: 4846 Comm: systemd-journal Not tainted 5.13.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5/0x2f8 mm/kasan/report.c:233
 __kasan_report mm/kasan/report.c:419 [inline]
 kasan_report.cold+0x7c/0xd8 mm/kasan/report.c:436
 __show_regs.cold+0x4e/0x508 arch/x86/kernel/process_64.c:80
 show_trace_log_lvl+0x25b/0x2ba arch/x86/kernel/dumpstack.c:298
 sched_show_task kernel/sched/core.c:7371 [inline]
 sched_show_task+0x443/0x590 kernel/sched/core.c:7345
 show_state_filter+0xf2/0x2d0 kernel/sched/core.c:7414
 k_spec drivers/tty/vt/keyboard.c:660 [inline]
 k_spec+0xe1/0x130 drivers/tty/vt/keyboard.c:649
 kbd_keycode drivers/tty/vt/keyboard.c:1512 [inline]
 kbd_event+0xc64/0x1750 drivers/tty/vt/keyboard.c:1531
 input_to_handler+0x3b9/0x4c0 drivers/input/input.c:118
 input_pass_values.part.0+0x284/0x700 drivers/input/input.c:145
 input_pass_values drivers/input/input.c:415 [inline]
 input_handle_event+0x67e/0x1440 drivers/input/input.c:415
 input_event drivers/input/input.c:446 [inline]
 input_event+0x8e/0xb0 drivers/input/input.c:438
 hidinput_hid_event+0x59d/0x18b0 drivers/hid/hid-input.c:1420
 hid_process_event+0x491/0x570 drivers/hid/hid-core.c:1522
 hid_input_field drivers/hid/hid-core.c:1580 [inline]
 hid_report_raw_event+0xe7f/0x11b0 drivers/hid/hid-core.c:1786
 hid_input_report+0x360/0x4c0 drivers/hid/hid-core.c:1853
 hid_irq_in+0x50e/0x690 drivers/hid/usbhid/hid-core.c:284
 __usb_hcd_giveback_urb+0x2b0/0x5c0 drivers/usb/core/hcd.c:1656
 usb_hcd_giveback_urb+0x367/0x410 drivers/usb/core/hcd.c:1726
 dummy_timer+0x11f4/0x32a0 drivers/usb/gadget/udc/dummy_hcd.c:1978
 call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1431
 expire_timers kernel/time/timer.c:1476 [inline]
 __run_timers.part.0+0x67c/0xa50 kernel/time/timer.c:1745
 __run_timers kernel/time/timer.c:1726 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1758
 __do_softirq+0x29b/0x9f6 kernel/softirq.c:559
 invoke_softirq kernel/softirq.c:433 [inline]
 __irq_exit_rcu+0x136/0x200 kernel/softirq.c:637
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1100
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:647
RIP: 0010:lock_is_held_type+0xfd/0x140 kernel/locking/lockdep.c:5560
Code: 00 00 b8 ff ff ff ff 65 0f c1 05 8e 7e eb 76 83 f8 01 75 29 9c 58 f6 c4 02 75 3d 48 f7 04 24 00 02 00 00 74 01 fb 48 83 c4 08 <44> 89 e8 5b 5d 41 5c 41 5d 41 5e 41 5f c3 45 31 ed eb b9 0f 0b 48
RSP: 0018:ffffc9000b62fd38 EFLAGS: 00000282
RAX: 0000000000000046 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffffff8bf79560 R08: 0000000000000000 R09: ffff888022132200
R10: ffffffff81a86a1f R11: 0000000000000000 R12: ffff88802c5754c0
R13: 0000000000000000 R14: 00000000ffffffff R15: ffffffff8dc99b08
 lock_is_held include/linux/lockdep.h:283 [inline]
 ___might_sleep+0x23f/0x2c0 kernel/sched/core.c:8304
 __might_fault+0x6e/0x180 mm/memory.c:5071
 strncpy_from_user+0x2f/0x3e0 lib/strncpy_from_user.c:117
 getname_flags.part.0+0x95/0x4f0 fs/namei.c:149
 getname_flags fs/namei.c:2734 [inline]
 user_path_at_empty+0xa1/0x100 fs/namei.c:2734
 user_path_at include/linux/namei.h:60 [inline]
 do_faccessat+0x127/0x850 fs/open.c:425
 do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7efdbd9139c7
Code: 83 c4 08 48 3d 01 f0 ff ff 73 01 c3 48 8b 0d c8 d4 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 b8 15 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a1 d4 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007fffaef68ff8 EFLAGS: 00000246 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 00007fffaef6bf10 RCX: 00007efdbd9139c7
RDX: 00007efdbe384a00 RSI: 0000000000000000 RDI: 000055b1c4e5f9a3
RBP: 00007fffaef69030 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000069 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fffaef6bf10 R15: 00007fffaef69520


Memory state around the buggy address:
 ffffc9000b90fa00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000b90fa80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc9000b90fb00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                               ^
 ffffc9000b90fb80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000b90fc00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

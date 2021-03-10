Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF684334570
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbhCJRqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:46:40 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:54620 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbhCJRqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:46:22 -0500
Received: by mail-il1-f197.google.com with SMTP id w8so13433116ilg.21
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:46:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5FPHwToO7ZQWGqAvlF2e4QNPWZDqlPuVg12iTCyWKIU=;
        b=l5LY27LBlRQITvAqWFKvMleCYz+ApMlmQ0yqP6GyqM55Xpl2sboCm07H3EG7epnIWj
         NQxh/s1TrQAYjZVdy61qoN6rdtaiQRA1jl2y8Ukx0Lt4UYFQ9zABDPSVuuJTuoENy8oJ
         KQiB7bxl0gjK1fXAhJnepX7xIcXM8z4MmAP7ZtwxfisO2ASlPljXvMjmQAK5CN1jB25k
         PgamcYStohUgFbNbBMCZJ5tCppxFtjuGPXD2RoCRCZ/sOXSeegPBZZhQEUkaaNmyhyqv
         B6SWfV5UbGO39dp6DFfDL7YzuXHE8s+qSG9/z5usPiPY5mPEvpqc9mLRHLSpgmlII+CC
         m3ng==
X-Gm-Message-State: AOAM5324sM0KZM757WVXMEfZMrPRf55tkgcTJds6Vtk55A00crW+6lr3
        QE2ufwcfRU5iOl5pY4iMKrtZTpJTDsA1Tibrc7YGlT9ahnE/
X-Google-Smtp-Source: ABdhPJy13ZTCtqZgR/r7EFvx5vWtdvf7fysI9carZq2GBuI7kH3NL9Io/9XRJQSAiF2B/eeNVnRoVXdvXGm9xh139sUliGoaMZaG
MIME-Version: 1.0
X-Received: by 2002:a5d:9e47:: with SMTP id i7mr3233340ioi.104.1615398381766;
 Wed, 10 Mar 2021 09:46:21 -0800 (PST)
Date:   Wed, 10 Mar 2021 09:46:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b750a505bd323e48@google.com>
Subject: [syzbot] WARNING in do_user_addr_fault
From:   syzbot <syzbot+beb50656d2e0b1940264@syzkaller.appspotmail.com>
To:     boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        longman@redhat.com, mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    05a59d79 Merge git://git.kernel.org:/pub/scm/linux/kernel/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=107f822ad00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=750735fdbc630971
dashboard link: https://syzkaller.appspot.com/bug?extid=beb50656d2e0b1940264

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+beb50656d2e0b1940264@syzkaller.appspotmail.com

------------[ cut here ]------------
raw_local_irq_restore() called with IRQs enabled
WARNING: CPU: 0 PID: 8407 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x1d/0x20 kernel/locking/irqflag-debug.c:10
Modules linked in:
CPU: 0 PID: 8407 Comm: syz-fuzzer Not tainted 5.12.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:warn_bogus_irq_restore+0x1d/0x20 kernel/locking/irqflag-debug.c:10
Code: be ff cc cc cc cc cc cc cc cc cc cc cc 80 3d 11 d1 ad 04 00 74 01 c3 48 c7 c7 20 79 6b 89 c6 05 00 d1 ad 04 01 e8 75 5b be ff <0f> 0b c3 48 39 77 10 0f 84 97 00 00 00 66 f7 47 22 f0 ff 74 4b 48
RSP: 0000:ffffc900010b7ab0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff888032907120 RCX: 0000000000000000
RDX: ffff888013bde340 RSI: ffffffff815b4435 RDI: fffff52000216f48
RBP: 0000000000000200 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815ad19e R11: 0000000000000000 R12: 0000000000000003
R13: ffffed1006520e24 R14: 0000000000000001 R15: ffff8880b9c36000
CR2: 000000c0002de000 CR3: 000000001a614000 CR4: 00000000001506f0
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 pv_wait arch/x86/include/asm/paravirt.h:564 [inline]
 pv_wait_head_or_lock kernel/locking/qspinlock_paravirt.h:470 [inline]
 __pv_queued_spin_lock_slowpath+0x8b8/0xb40 kernel/locking/qspinlock.c:508
 do_user_addr_fault+0x483/0x1210 arch/x86/mm/fault.c:1390
RIP: 0033:0x46cf33
Code: 00 48 81 eb 00 01 00 00 48 81 c7 00 01 00 00 48 81 fb 00 01 00 00 73 82 e9 07 ff ff ff c5 fd ef c0 48 81 fb 00 00 00 02 73 46 <c5> fe 7f 07 c5 fe 7f 47 20 c5 fe 7f 47 40 c5 fe 7f 47 60 48 81 eb
RSP: 002b:000000c0000c35f0 EFLAGS: 00010287
RAX: 0000000000000000 RBX: 00000000000001a0 RCX: 00000000000001a0
RDX: 00000000000001a0 RSI: 0000000000000000 RDI: 000000c0002de000
R10: 00007ff0c6f30b00 R11: 0000000000000000 R12: 0000000000000040


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

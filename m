Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794273B6904
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 21:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236456AbhF1TYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 15:24:55 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:49734 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbhF1TYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 15:24:54 -0400
Received: by mail-il1-f199.google.com with SMTP id a5-20020a056e020e05b02901ef113bb0fcso213273ilk.16
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 12:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=HKXlKMZ5iCn1XKDKNpSuZHaZl/SmVYQQ4/hei1bClL0=;
        b=Cn1cxXCcI8BkHrhf+w/RRvwLd0kbWj1IRRDsmSoLPxpOYVFFAeC4UsOCe+uiiI6euP
         B5yAAX4V0m2l8V5D8bQhuRPX2E/BYKWjz+J7eM/XkNvlEaaZyB1OOi7U2sjwDBLSd3l3
         Hh+N2WbOm0RhB/x55YNk3XSve1z26xixe/hHc94ftqqdgdSNjmoTREY5/qZghRZn2Oy5
         4rW07urVHS10nt7sGPMPOhaRIgVuV0W68MW6WB3vx1LzaQYawdnjtfzyD0Hu+BSGAXUb
         ElALpcXfKXWwvaOFdTxmPT5v9E59JgzeXnbL3xSvZfAeCcZ5tmNKqfLE0IXbJTmxG9UZ
         v+Hw==
X-Gm-Message-State: AOAM533ATsEYisMbXqOpnkS+16TzB/eXUSgjPaB/cJm2Z1H2vlfZZfFW
        iqmV8XHNdeh0EuHjhWAe78O8zLJL0ZTAHLmYTpH3av/Rxbk6
X-Google-Smtp-Source: ABdhPJwVFz7UoEUXRR9caZiSAnM9CUSv3TgmyHNPoMIm8fKF0GTZ5iYf/dtwScfIG6rYRm4/mLBbpNVSmlyutAFLE4JPg64YLidc
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b47:: with SMTP id f7mr19031227ilu.135.1624908147974;
 Mon, 28 Jun 2021 12:22:27 -0700 (PDT)
Date:   Mon, 28 Jun 2021 12:22:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f3e94a05c5d8686f@google.com>
Subject: [syzbot] BUG: sleeping function called from invalid context in __fdget_pos
From:   syzbot <syzbot+5d1bad8042a8f0e8117a@syzkaller.appspotmail.com>
To:     bp@alien8.de, dave.hansen@intel.com, hpa@zytor.com,
        jpa@git.mail.kapsi.fi, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7426cedc Merge tag 'spi-fix-v5.13-rc7' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=170e6c94300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=42ecca11b759d96c
dashboard link: https://syzkaller.appspot.com/bug?extid=5d1bad8042a8f0e8117a

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5d1bad8042a8f0e8117a@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at kernel/locking/mutex.c:938
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 29652, name: syz-executor.0
no locks held by syz-executor.0/29652.
Preemption disabled at:
[<ffffffff812aa454>] kernel_fpu_begin_mask+0x64/0x260 arch/x86/kernel/fpu/core.c:126
CPU: 0 PID: 29652 Comm: syz-executor.0 Not tainted 5.13.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 ___might_sleep.cold+0x1f1/0x237 kernel/sched/core.c:8337
 __mutex_lock_common kernel/locking/mutex.c:938 [inline]
 __mutex_lock+0xa9/0x10c0 kernel/locking/mutex.c:1104
 __fdget_pos+0xe9/0x100 fs/file.c:974
 fdget_pos include/linux/file.h:75 [inline]
 ksys_read+0x6e/0x250 fs/read_write.c:625
 do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x41935c
Code: ec 28 48 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 f9 fc ff ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 48 89 44 24 08 e8 2f fd ff ff 48
RSP: 002b:00007f4701c5d170 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: ffffffffffffffff RCX: 000000000041935c
RDX: 000000000000000f RSI: 00007f4701c5d1e0 RDI: 0000000000000005
RBP: 00007f4701c5d1d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc539a90af R14: 00007f4701c5d300 R15: 0000000000022000
BUG: scheduling while atomic: syz-executor.0/29652/0x00000002
no locks held by syz-executor.0/29652.
Modules linked in:
Preemption disabled at:
[<ffffffff812aa454>] kernel_fpu_begin_mask+0x64/0x260 arch/x86/kernel/fpu/core.c:126


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CEC353BCC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 07:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhDEFf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 01:35:26 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:53640 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhDEFfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 01:35:24 -0400
Received: by mail-io1-f72.google.com with SMTP id r10so10307190iod.20
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 22:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=74906PLmb2bB9Wr+TMqJpTERnwDEHoumRunGR2bac2w=;
        b=lcBbA8+726KvUGNoEwfe1Jjgq1bPTY6OqDFYKb246INidT3NFPRfMi7YnR9TIuOS9t
         /VcDMhgrsbSOQu6/OuPKBWcpxV8RJq7cuFHX8m8Epl3bfSOvTCSi2fCAVq5ytP9vg3s4
         BCvr9IGlNyOQYg5aOJVFPPXWcz1MhL/0liq8TUUQCBQ717XWvVTaZ63xxgSrH7dA/7Qf
         +TpTmMwwlHC9+OwGr/L2hAUT5ySpfmy4y4iMEymgqnIR3aV9YqSLnFKQZSTGxqY9tPsK
         BM+whFVnYcGgf9aHRRN6Nhfo7R7CSxjAQ2XoBSVUDsDBjQmcZSSgpi7QNDzLAki3gwdz
         tQEQ==
X-Gm-Message-State: AOAM533fOFyzKB9vVqFMBMqoKO6u/J7xhYH2E4W5pvAwEvGljfAdlkcE
        Ld7x/Yma22es6nRiVbIfG812rFIQsPgP9sknc9EihIw8XDgo
X-Google-Smtp-Source: ABdhPJzAEHdTbyX3YlCAwA9VG468yEVsuHtnlIoaQRY6DwFgQ0h7y8xn6472/yFwGlwdq3nmOvnQo+HQLwBQxmxW9M0qKp8s5XW/
MIME-Version: 1.0
X-Received: by 2002:a02:7f8c:: with SMTP id r134mr22241538jac.95.1617600919088;
 Sun, 04 Apr 2021 22:35:19 -0700 (PDT)
Date:   Sun, 04 Apr 2021 22:35:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002bb2bd05bf3310db@google.com>
Subject: [syzbot] WARNING: suspicious RCU usage in do_user_addr_fault
From:   syzbot <syzbot+3d5082ab6eec95ad4231@syzkaller.appspotmail.com>
To:     bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com,
        vincent.guittot@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d19cc4bf Merge tag 'trace-v5.12-rc5' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a22d16d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=78ef1d159159890
dashboard link: https://syzkaller.appspot.com/bug?extid=3d5082ab6eec95ad4231

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3d5082ab6eec95ad4231@syzkaller.appspotmail.com

WARNING: suspicious RCU usage
5.12.0-rc5-syzkaller #0 Not tainted
-----------------------------
kernel/sched/core.c:8294 Illegal context switch in RCU-bh read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 0
1 lock held by syz-executor.5/8582:
 #0: ffff888029093218 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:136 [inline]
 #0: ffff888029093218 (&mm->mmap_lock#2){++++}-{3:3}, at: do_user_addr_fault+0x285/0x1210 arch/x86/mm/fault.c:1331

stack backtrace:
CPU: 0 PID: 8582 Comm: syz-executor.5 Not tainted 5.12.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 ___might_sleep+0x229/0x2c0 kernel/sched/core.c:8294
 do_user_addr_fault+0x2c2/0x1210 arch/x86/mm/fault.c:1348
 handle_page_fault arch/x86/mm/fault.c:1475 [inline]
 exc_page_fault+0x9e/0x180 arch/x86/mm/fault.c:1531
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:577
RIP: 0033:0x406f13
Code: 00 00 e8 a0 a1 ff ff 85 c0 74 4e 8b 54 24 0c 49 8b 37 31 c0 48 8d 3d 79 7f 0b 00 e8 27 c3 ff ff 8b 44 24 6c 49 8d 4f 60 89 de <4d> 89 a7 b8 00 00 00 ba 40 00 00 00 44 89 ef 41 89 87 b4 00 00 00
RSP: 002b:00007fff2a8e7140 EFLAGS: 00010202
RAX: 0000000000000005 RBX: 0000000000000000 RCX: 0000000000544420
RDX: 0000000000000002 RSI: 0000000000000000 RDI: 00000000004bee7d
RBP: 00007fff2a8e7160 R08: 00007fff2a8e715c R09: 00007fff2a8e71f0
R10: 00007fff2a8e71c0 R11: 0000000000000202 R12: 00007fff2a8e71c0
R13: 0000000000000003 R14: 00007fff2a8e715c R15: 00000000005443c0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

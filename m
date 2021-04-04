Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C7335363B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 04:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbhDDCfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 22:35:24 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:49046 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236621AbhDDCfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 22:35:21 -0400
Received: by mail-io1-f69.google.com with SMTP id g12so8669974ion.15
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 19:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=PWAemxV0be6UqaxJc8Bb2wVrgTpFS1hQOmMm2LLPwTA=;
        b=JEPCitCuC4HOcC/lyq//rP+NJ4YletI3R6bkXxDr265VwdobW8s+wPcu8iYSoKr17e
         Dm7Texz45daIlFiwxvgJDZfNwXtjCghvZSb6FcOzoHeftnpl1cf8fp3dKm9uxu4xqxji
         QTyGgyNCWjdKBMD6UDkdz5N1rXLZtAsOp1FBij4ZT1lEWy/hT8tDAWlitEJFKItcCgZc
         uDwA7rlFsd1p/kJP6baxVv8MOppyP9/9Te4aQkos8KqcJybvpYcvvak75MJoJjGSJW6V
         2j03vhhyrZ08LJwXEpimqWB0UjLGIlUM0zzG661nB2B1LAOewxbIEsW5f+Z2pNyayp1Y
         HnDA==
X-Gm-Message-State: AOAM531qwbb7X/mNhHp3yYsXG3jyjCoFSfyiCNCSoM+Cm/m7rf34akaz
        zh/P45/arjS058vTgghAp/HTvxhAeq444fhFu0+wB8j8uUP8
X-Google-Smtp-Source: ABdhPJzddKv/SwKwBxhT7y+JihhMA+0Gyv0icOoWP8c3iSY14VEaCdyTcmQxO5qXG5Lne/jGi2UIhwRMbUlJmO9U7h3JIzfBrIHi
MIME-Version: 1.0
X-Received: by 2002:a02:694b:: with SMTP id e72mr18885596jac.89.1617503716246;
 Sat, 03 Apr 2021 19:35:16 -0700 (PDT)
Date:   Sat, 03 Apr 2021 19:35:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e0a8405bf1c6e8e@google.com>
Subject: [syzbot] WARNING: suspicious RCU usage in clear_huge_page
From:   syzbot <syzbot+7a0c25f9520c969c15f5@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d19cc4bf Merge tag 'trace-v5.12-rc5' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1611e681d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=78ef1d159159890
dashboard link: https://syzkaller.appspot.com/bug?extid=7a0c25f9520c969c15f5

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7a0c25f9520c969c15f5@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
5.12.0-rc5-syzkaller #0 Not tainted
-----------------------------
kernel/sched/core.c:8294 Illegal context switch in RCU-bh read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 0
1 lock held by syz-executor.2/10002:
 #0: ffff8880129669d8 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:136 [inline]
 #0: ffff8880129669d8 (&mm->mmap_lock#2){++++}-{3:3}, at: do_user_addr_fault+0x285/0x1210 arch/x86/mm/fault.c:1331

stack backtrace:
CPU: 0 PID: 10002 Comm: syz-executor.2 Not tainted 5.12.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 ___might_sleep+0x229/0x2c0 kernel/sched/core.c:8294
 process_huge_page mm/memory.c:5051 [inline]
 clear_huge_page+0x9c/0x560 mm/memory.c:5112
 __do_huge_pmd_anonymous_page mm/huge_memory.c:607 [inline]
 do_huge_pmd_anonymous_page+0x60e/0x2570 mm/huge_memory.c:772
 create_huge_pmd mm/memory.c:4189 [inline]
 __handle_mm_fault+0x2e59/0x4f70 mm/memory.c:4424
 handle_mm_fault+0x1bc/0x7e0 mm/memory.c:4551
 do_user_addr_fault+0x483/0x1210 arch/x86/mm/fault.c:1390
 handle_page_fault arch/x86/mm/fault.c:1475 [inline]
 exc_page_fault+0x9e/0x180 arch/x86/mm/fault.c:1531
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:577
RIP: 0033:0x461b6d
Code: 48 01 d0 eb 0b 0f 1f 84 00 00 00 00 00 48 89 f8 48 83 fa 20 72 49 48 83 fa 40 0f 87 9f 00 00 00 c5 fe 6f 06 c5 fe 6f 4c 16 e0 <c5> fe 7f 07 c5 fe 7f 4c 17 e0 c5 f8 77 c3 48 3b 15 7e 8e 04 01 0f
RSP: 002b:00007fffc28c60c8 EFLAGS: 00010287
RAX: 0000000020000080 RBX: 0000000000000003 RCX: 0000000000570000
RDX: 000000000000002b RSI: 0000000000570020 RDI: 0000000020000080
RBP: 00007fffc28c6188 R08: 0000000000970000 R09: 00007fffc2907090
R10: 000000000000a8e8 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: 000000000056bf60 R15: 0000000000035790


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

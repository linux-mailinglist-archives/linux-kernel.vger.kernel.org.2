Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A9C42A6AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 16:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237106AbhJLOFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 10:05:22 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:44581 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237015AbhJLOFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 10:05:21 -0400
Received: by mail-il1-f197.google.com with SMTP id i11-20020a92540b000000b0025456903645so12177828ilb.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 07:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=q/pqoxqAzyZZ8F1MtzXtJAA/iWzEt6hd22bQr+ZIXqo=;
        b=SV4VoKnIdVBrTp4Q091Ng1a3dRDAx38x8jkeH6HyyN4kVdoAeHAcwf7O7Waipi47ev
         amsgpO1ATjiClJyWq15iWoki4YF4XLhwg0qUc/hJCB5XxEJCyzl95mazTjUFWFLTfUmf
         3wfOAUNbah7W9qLz83MndDRhkffVRd48YG1DNMU66CqoylDrSFZ/N9KsLOizEmzDmSCi
         7gdx/YElvPG5Gv77/jb4GSD0wfnC8akrabxwwmkyMbsVh+OaP92ejCGTRyDN6jLOu+RV
         2wkSC1nTA0UIsTGYBkTe61dC26u99otKXCfxWwuZiM7Fd7JsvzKc3a8q7CiX8qw5p6rY
         a78w==
X-Gm-Message-State: AOAM5315nNROwqQdmIwqzPHxhlFf6LCT8yaSbvDgNFaHq63HnhnG/lzo
        ngKf9+MRG1iJSAgI/M+sBTb6nxDbWw87ChKZ6EUtXkPvqccs
X-Google-Smtp-Source: ABdhPJxjIThpoG8yba4yssGvvE6hjTqANDNUg0HyeCaEZK1/NzaUyGwG8HljKgdp5DPeZ8pagDP38f8//lFSMiN9UDrG2mJfYTKn
MIME-Version: 1.0
X-Received: by 2002:a92:c262:: with SMTP id h2mr5696463ild.204.1634047399207;
 Tue, 12 Oct 2021 07:03:19 -0700 (PDT)
Date:   Tue, 12 Oct 2021 07:03:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c6a82505ce284e4c@google.com>
Subject: [syzbot] BUG: sleeping function called from invalid context in copy_huge_page
From:   syzbot <syzbot+aae069be1de40fb11825@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1da38549dd64 Merge tag 'nfsd-5.15-3' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14379148b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=76f7496a8217e5ec
dashboard link: https://syzkaller.appspot.com/bug?extid=aae069be1de40fb11825
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aae069be1de40fb11825@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at mm/util.c:758
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 30700, name: syz-executor.2
2 locks held by syz-executor.2/30700:
 #0: ffff88806ee498a8 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_write_lock include/linux/mmap_lock.h:71 [inline]
 #0: ffff88806ee498a8 (&mm->mmap_lock#2){++++}-{3:3}, at: do_mbind+0x25d/0xeb0 mm/mempolicy.c:1314
 #1: ffff888145989e18 (&mapping->private_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:363 [inline]
 #1: ffff888145989e18 (&mapping->private_lock){+.+.}-{2:2}, at: __buffer_migrate_page+0x3af/0xca0 mm/migrate.c:723
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 30700 Comm: syz-executor.2 Not tainted 5.15.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 ___might_sleep.cold+0x1f3/0x239 kernel/sched/core.c:9538
 copy_huge_page+0x126/0x360 mm/util.c:758
 migrate_page_copy+0xfc/0x340 mm/migrate.c:619
 __buffer_migrate_page+0x8cb/0xca0 mm/migrate.c:758
 move_to_new_page+0x339/0xef0 mm/migrate.c:905
 __unmap_and_move mm/migrate.c:1070 [inline]
 unmap_and_move mm/migrate.c:1211 [inline]
 migrate_pages+0xfc5/0x39e0 mm/migrate.c:1488
 do_mbind+0xbc7/0xeb0 mm/mempolicy.c:1340
 kernel_mbind mm/mempolicy.c:1483 [inline]
 __do_sys_mbind mm/mempolicy.c:1490 [inline]
 __se_sys_mbind mm/mempolicy.c:1486 [inline]
 __x64_sys_mbind+0x233/0x2b0 mm/mempolicy.c:1486
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f408623f8d9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f40837b6188 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
RAX: ffffffffffffffda RBX: 00007f4086343f60 RCX: 00007f408623f8d9
RDX: 0000000000000000 RSI: 0000000000c00000 RDI: 0000000020012000
RBP: 00007f4086299cb4 R08: 0000000000000000 R09: 0000010000000002
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff13d3589f R14: 00007f40837b6300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

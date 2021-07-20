Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B693CF614
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 10:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbhGTHnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 03:43:00 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:44561 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbhGTHmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 03:42:23 -0400
Received: by mail-io1-f71.google.com with SMTP id k2-20020a5d8b020000b029050b6f9cfe31so14842450ion.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 01:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LTLNFNe5fZTV7orknvpMN64AKSu4eErZ/6vJ8u9oFvk=;
        b=sfR7bGAMjjZrxFwwq+CL/qBw1XkwZnf77IWHafWdCozP9ZUr/msQhmnU1Q3jUZv17q
         LzOoH5F2E0rQaTs6eNdKzeG6b7oeZw2ltHJnwwE6ELcvu8cTuEYRT2PSrrS1CJvaZU5f
         OAYWMHqo1kl4EqyS/Tv7pItf/z422GlcNgQh3pPqh9HELDBaG3EzMmFfStZdEftlISuT
         yl02lByuSGhdj8ZoJ6EyCQNUiRGOWvqIloMaRiMsTy4pBz43dbpxEe4rsj/uRq1K18Sq
         dmd4C2cYd1N/g745cNtL4w1aIdrJoGLjmYwZxlVIasWnSEjOxhHDQLHwrOE+nK/wmT1A
         C2vQ==
X-Gm-Message-State: AOAM531nStdd9xGedb9HSsaGaAC/tFNfnhf/rqTQkXNKko1dgDMFeUpb
        4TEeQiH1cLFThS0YpGegZINhMy2dReLiWGyjHfYMqxtr6GBF
X-Google-Smtp-Source: ABdhPJwTq7a0f2+Ys1jxsNeJeV3LCkGJ/mE8BAJrERGkzdChcM30kNfskvX7IXnI3D3G26fLQYkLkHLNAhjzWw2qAAfGxfhvJWlh
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1814:: with SMTP id t20mr17977138ioh.204.1626769343859;
 Tue, 20 Jul 2021 01:22:23 -0700 (PDT)
Date:   Tue, 20 Jul 2021 01:22:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000df51d905c789c027@google.com>
Subject: [syzbot] kernel BUG in put_ucounts
From:   syzbot <syzbot+6cd79f45bb8fa1c9eeae@syzkaller.appspotmail.com>
To:     ebiederm@xmission.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2734d6c1b1a0 Linux 5.14-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=175a9e12300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7273c75708b55890
dashboard link: https://syzkaller.appspot.com/bug?extid=6cd79f45bb8fa1c9eeae
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6cd79f45bb8fa1c9eeae@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at mm/slub.c:4255!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 17835 Comm: syz-executor.3 Not tainted 5.14.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:kfree+0x635/0x650 mm/slub.c:4255
Code: 74 00 00 e9 d6 fe ff ff 48 c7 c6 88 c7 12 8b 48 89 ef e8 9e 2a ed ff 0f 0b 48 c7 c6 90 5f 14 8b 4c 89 e7 e8 8d 2a ed ff 0f 0b <0f> 0b e8 14 91 6e 07 e9 d4 fe ff ff e8 ea 90 6e 07 e9 33 56 2e 07
RSP: 0000:ffffc9000dfffbf8 EFLAGS: 00010046
RAX: ffffea00002e13c8 RBX: ffffffff8eed1130 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81345ed4 RDI: 0000000000000003
RBP: ffffea00002e13c0 R08: 000000001fffffff R09: ffffffff8b84f003
R10: ffffffff81345f19 R11: 0000000000000000 R12: ffffffff8b84f060
R13: ffff8880109ac300 R14: ffff8880925a3718 R15: ffff88806d648848
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0063) knlGS:00000000f55d2b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000000000050 CR3: 000000001e7fe000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 put_ucounts kernel/ucount.c:200 [inline]
 put_ucounts+0x117/0x150 kernel/ucount.c:192
 __sigqueue_free.part.0+0x9b/0xe0 kernel/signal.c:467
 __sigqueue_free kernel/signal.c:464 [inline]
 dequeue_synchronous_signal kernel/signal.c:757 [inline]
 get_signal+0xbd5/0x2160 kernel/signal.c:2688
 arch_do_signal_or_restart+0x2a9/0x1c40 arch/x86/kernel/signal.c:865
 handle_signal_work kernel/entry/common.c:148 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
 exit_to_user_mode_prepare+0x17d/0x290 kernel/entry/common.c:209
 irqentry_exit_to_user_mode+0x5/0x40 kernel/entry/common.c:315
 exc_page_fault+0xc6/0x180 arch/x86/mm/fault.c:1534
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:568
RIP: 0023:0x80521e7
Code: 0c 50 e8 dc 5a 01 00 83 c4 10 85 c0 0f 84 b9 01 00 00 65 f0 83 2d d8 ff ff ff 01 8b 5c 24 08 e8 9f f7 00 00 8b 4c 24 0c 8b 00 <8b> 71 50 89 41 54 85 c0 75 05 83 fe ff 74 19 6b 44 24 1c 34 8b 4c
RSP: 002b:00000000f55d2640 EFLAGS: 00010283
RAX: 000000000000000e RBX: 0000000000000000 RCX: 0000000000000000
RDX: 00000000080521c4 RSI: 0000000000000003 RDI: 00000000080ea4f5
RBP: 000000000819afc0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 7833fd3a6afd4940 ]---
RIP: 0010:kfree+0x635/0x650 mm/slub.c:4255
Code: 74 00 00 e9 d6 fe ff ff 48 c7 c6 88 c7 12 8b 48 89 ef e8 9e 2a ed ff 0f 0b 48 c7 c6 90 5f 14 8b 4c 89 e7 e8 8d 2a ed ff 0f 0b <0f> 0b e8 14 91 6e 07 e9 d4 fe ff ff e8 ea 90 6e 07 e9 33 56 2e 07
RSP: 0000:ffffc9000dfffbf8 EFLAGS: 00010046
RAX: ffffea00002e13c8 RBX: ffffffff8eed1130 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81345ed4 RDI: 0000000000000003
RBP: ffffea00002e13c0 R08: 000000001fffffff R09: ffffffff8b84f003
R10: ffffffff81345f19 R11: 0000000000000000 R12: ffffffff8b84f060
R13: ffff8880109ac300 R14: ffff8880925a3718 R15: ffff88806d648848
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0063) knlGS:00000000f55d2b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000000000050 CR3: 000000001e7fe000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

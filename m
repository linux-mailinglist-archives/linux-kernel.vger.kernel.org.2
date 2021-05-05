Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8207B3735BB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 09:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhEEHnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 03:43:17 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:56182 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhEEHnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 03:43:15 -0400
Received: by mail-io1-f72.google.com with SMTP id c24-20020a5d9a980000b029040db7d17e09so609665iom.22
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 00:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ya+E1g89xMTBDEmcemt9FFZwadnYmRvfrssN8EvLq3Q=;
        b=kkn3WIgW5NBepCBbqhj6R/oEwTG7O1LZ+YD1xzGS1TiOzrnOfP8gIaREmez6+Y5WfK
         DYjruFHmukiUMFiYoFVGmTK4/35iE+9ju1QNMopwgCwuvqopHD+Jm4tw72QG2efQFK2P
         4dwZ4A09RSQIXMhD4vEdvPke2LSZQnzaR8ST9w5EgUiw/fwsbcF1XSjSSTkTwJmUrOaZ
         zeTZh6ILIsGhqDHbZTjPunUQVNEIsbw6utAhZQdxPnQvoZINlr+bxzr1UxcfDmTd4ifC
         DuiKYxLccJdj0Jp7j1DTis8UsncXuxP7nYXSPt0+3Izj5ki1YoI/oPf2FSg8usahjFXh
         yiYw==
X-Gm-Message-State: AOAM530G5/vqHGVh8EwjrcnjceLplTKSrQKeB4kkEZIHM3EipUc3/pTw
        SvZJHs1WzcJ/6E2WQxXP2cinAvEj65widBO3pExbcvipP3eH
X-Google-Smtp-Source: ABdhPJybl0X8SrKJXC9jch+sKWnvv3XrFOBUOGAdD6ciacQ7sKC+XPFckZdpBTBFmm72afE7FQ23SmQ5JKelGNcgKvhV6rx57d+R
MIME-Version: 1.0
X-Received: by 2002:a5d:8246:: with SMTP id n6mr8441830ioo.73.1620200539134;
 Wed, 05 May 2021 00:42:19 -0700 (PDT)
Date:   Wed, 05 May 2021 00:42:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000999e4705c1905503@google.com>
Subject: [syzbot] divide error in fill_meta_index
From:   syzbot <syzbot+7b98870d4fec9447b951@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, phillip@squashfs.org.uk,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d2b6f8a1 Merge tag 'xfs-5.13-merge-3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12d2d5a3d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53fdf14defd48c56
dashboard link: https://syzkaller.appspot.com/bug?extid=7b98870d4fec9447b951
compiler:       Debian clang version 11.0.1-2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1105f733d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b7af43d00000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12f60095d00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11f60095d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=16f60095d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7b98870d4fec9447b951@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 8
divide error: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8375 Comm: syz-executor040 Not tainted 5.12.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:fill_meta_index+0x242/0xf50 fs/squashfs/file.c:243
Code: 28 00 74 08 4c 89 ff e8 4c 79 91 ff 49 8b 07 48 89 44 24 60 48 63 4c 24 44 48 c1 e1 0b 49 63 c6 31 d2 48 89 8c 24 b8 00 00 00 <48> f7 f1 48 89 c3 31 ff 89 de e8 3f e5 4a ff 48 89 5c 24 58 85 db
RSP: 0018:ffffc90000eff1c0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00000000000000de RCX: 0000000000000000
RDX: 0000000000000000 RSI: 00000000ffffff10 RDI: ffffc90000eff2a0
RBP: ffffc90000eff330 R08: ffffffff8233f543 R09: fffff94000180631
R10: fffff94000180631 R11: 0000000000000000 R12: ffff8880331dc520
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff8880331dc4c0
FS:  0000000002199300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b45fc1d008 CR3: 0000000012688000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 read_blocklist+0x9f/0x320 fs/squashfs/file.c:332
 squashfs_readpage+0x4ce/0xba0 fs/squashfs/file.c:469
 read_pages+0x5d4/0x890 mm/readahead.c:145
 page_cache_ra_unbounded+0x82a/0x9a0 mm/readahead.c:238
 page_cache_sync_readahead include/linux/pagemap.h:864 [inline]
 filemap_get_pages+0x43d/0xd90 mm/filemap.c:2442
 filemap_read+0x39e/0x1030 mm/filemap.c:2525
 __kernel_read+0x596/0xa40 fs/read_write.c:454
 prepare_binprm fs/exec.c:1650 [inline]
 search_binary_handler fs/exec.c:1704 [inline]
 exec_binprm fs/exec.c:1761 [inline]
 bprm_execve+0x808/0x1470 fs/exec.c:1830
 do_execveat_common+0x487/0x5f0 fs/exec.c:1919
 do_execveat fs/exec.c:1998 [inline]
 __do_sys_execveat fs/exec.c:2074 [inline]
 __se_sys_execveat fs/exec.c:2066 [inline]
 __x64_sys_execveat+0xcd/0xe0 fs/exec.c:2066
 do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x443c09
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffff066cd08 EFLAGS: 00000246 ORIG_RAX: 0000000000000142
RAX: ffffffffffffffda RBX: 00000000004004a0 RCX: 0000000000443c09
RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000005
RBP: 00000000004034a0 R08: 0000000000000000 R09: 00000000004004a0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000403530
R13: 0000000000000000 R14: 00000000004b1018 R15: 00000000004004a0
Modules linked in:
---[ end trace 5a69392a838e0d97 ]---
RIP: 0010:fill_meta_index+0x242/0xf50 fs/squashfs/file.c:243
Code: 28 00 74 08 4c 89 ff e8 4c 79 91 ff 49 8b 07 48 89 44 24 60 48 63 4c 24 44 48 c1 e1 0b 49 63 c6 31 d2 48 89 8c 24 b8 00 00 00 <48> f7 f1 48 89 c3 31 ff 89 de e8 3f e5 4a ff 48 89 5c 24 58 85 db
RSP: 0018:ffffc90000eff1c0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00000000000000de RCX: 0000000000000000
RDX: 0000000000000000 RSI: 00000000ffffff10 RDI: ffffc90000eff2a0
RBP: ffffc90000eff330 R08: ffffffff8233f543 R09: fffff94000180631
R10: fffff94000180631 R11: 0000000000000000 R12: ffff8880331dc520
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff8880331dc4c0
FS:  0000000002199300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000560489adc160 CR3: 0000000012688000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

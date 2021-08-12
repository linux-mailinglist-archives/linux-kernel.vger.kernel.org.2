Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB18A3EA5D2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 15:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbhHLNnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 09:43:43 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:42705 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbhHLNnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 09:43:41 -0400
Received: by mail-io1-f70.google.com with SMTP id y10-20020a5e870a0000b029058d2e067004so3461169ioj.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 06:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=cGNJ1xbk5GNRdimlzJb+r5AxJewAsHWKddCCIaqm2a8=;
        b=r97mq9FvFHoLRq/lA0Fg4dyUxbbSZj+HtbmIwj45IYU5hW8avitfOtV5/F3YH6PAhb
         ovdfQbq5drT+vck26J0od4Hfl6knlDDIGbgtbMSgIMZLA034FGrki4NGTjQltrBM3w6T
         HAhre6ZREqXJwKRP+KmqHmrvLvocNSWlkPfPi3O0ZFmhG1zidOTZyg8ko6YAv5dMsZaY
         kzgmpNCqOlrI6UmG6ruoZoUOwU/xkMtI5Je1QkkoAjHMrCNeJTj25LXMwrangbVdtpXj
         5t1GSVCELWK1P7w1RNX/g1RHP+XwE2/gMw8eDywfv/740i5qHpHBMoDD2xGlelB2ABcn
         wzdg==
X-Gm-Message-State: AOAM533QiykDN0cMy85rlAhFtninw99ZojgHsDnZ5uU/MTZYFEahV2Q7
        fCgGv0ZZawLrNRfWM9BRsAf4e1nLOnTHj04HCEInROdokHxo
X-Google-Smtp-Source: ABdhPJyUfYG6OpAHCdWPHWu23lGWRgH9yis8VyXZIwQvLe/s+stmd06Tp6zCppFyNhCjRvztHHvP1g5wSKo5eMiJL7BKPRnGGJrM
MIME-Version: 1.0
X-Received: by 2002:a6b:f813:: with SMTP id o19mr3027821ioh.49.1628775796433;
 Thu, 12 Aug 2021 06:43:16 -0700 (PDT)
Date:   Thu, 12 Aug 2021 06:43:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c3e60005c95cea4b@google.com>
Subject: [syzbot] KASAN: stack-out-of-bounds Read in iov_iter_revert
From:   syzbot <syzbot+9671693590ef5aad8953@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1746f4db5135 Merge tag 'orphans-v5.14-rc6' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=111065fa300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3a20bae04b96ccd
dashboard link: https://syzkaller.appspot.com/bug?extid=9671693590ef5aad8953
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119dcaf6300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=120d216e300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9671693590ef5aad8953@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: stack-out-of-bounds in iov_iter_revert lib/iov_iter.c:1093 [inline]
BUG: KASAN: stack-out-of-bounds in iov_iter_revert+0x803/0x900 lib/iov_iter.c:1033
Read of size 8 at addr ffffc9000cf478b0 by task syz-executor673/8439

CPU: 0 PID: 8439 Comm: syz-executor673 Not tainted 5.14.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 print_address_description.constprop.0.cold+0xf/0x309 mm/kasan/report.c:233
 __kasan_report mm/kasan/report.c:419 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:436
 iov_iter_revert lib/iov_iter.c:1093 [inline]
 iov_iter_revert+0x803/0x900 lib/iov_iter.c:1033
 io_write+0x57b/0xed0 fs/io_uring.c:3459
 io_issue_sqe+0x28c/0x6920 fs/io_uring.c:6181
 __io_queue_sqe+0x1ac/0xf00 fs/io_uring.c:6464
 io_queue_sqe fs/io_uring.c:6507 [inline]
 io_submit_sqe fs/io_uring.c:6662 [inline]
 io_submit_sqes+0x63ea/0x7bc0 fs/io_uring.c:6778
 __do_sys_io_uring_enter+0xb03/0x1d40 fs/io_uring.c:9389
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x43f8a9
Code: 28 c3 e8 1a 15 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcc6759968 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000043f8a9
RDX: 0000000000000000 RSI: 00000000000052fe RDI: 0000000000000003
RBP: 00007ffcc6759988 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffcc6759990
R13: 0000000000000000 R14: 00000000004ae018 R15: 0000000000400488


addr ffffc9000cf478b0 is located in stack of task syz-executor673/8439 at offset 152 in frame:
 io_write+0x0/0xed0 fs/io_uring.c:3335

this frame has 3 objects:
 [48, 56) 'iovec'
 [80, 120) '__iter'
 [160, 288) 'inline_vecs'

Memory state around the buggy address:
 ffffc9000cf47780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000cf47800: 00 00 00 f1 f1 f1 f1 00 00 00 f2 f2 f2 00 00 00
>ffffc9000cf47880: 00 00 f2 f2 f2 f2 f2 00 00 00 00 00 00 00 00 00
                                     ^
 ffffc9000cf47900: 00 00 00 00 00 00 00 f3 f3 f3 f3 00 00 00 00 00
 ffffc9000cf47980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

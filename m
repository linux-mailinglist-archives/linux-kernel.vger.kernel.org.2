Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C393442002
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 19:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhKAS1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 14:27:33 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:42860 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbhKAS1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 14:27:10 -0400
Received: by mail-io1-f72.google.com with SMTP id ay5-20020a5d9d85000000b005e1949ee07eso3550962iob.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 11:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vd5ccxYB+aWeir9fWxGkpK5SM5TI1o21sLJ0dRX6QGo=;
        b=6HnWKhlleVka0UMuRsLaRxCz1wyYxw53Plg8AhL1oWJGHgE766wgsWdqpeNq5iUORF
         V8OAt+9hmLmpPHbymnOFoa85M6sW/Ks3QOIkfDhVrC/c/HGVSqL1u3xEdY35HORTMwT1
         3cDDilkiHYl7ge9cwcF/UL2LItURtjE/cXcWQo/jP72q+l0b8LAt6XNcNk97zG4Rfo92
         M6re2fCGPvbPsKZsZ1b9mgCuvNWOpjzcFhxxIvDQsBujz6v2Jtqf4ixCM8aSPifBWHdK
         7aiXyFjvbRvhK3RjXnlk9pRH4pBpcZuKx7LZ3DMUf6CMVbLkral9HbK6JP1hCk/ytrEO
         nBFQ==
X-Gm-Message-State: AOAM532kYIraU7+Gf6sgGPE4qLRMo3z6jCpdAs1qB6ogSvd1FFKLtTkU
        vGkAq/Pip2N+WtBdgFk6w80dzYrjOCca4oC6YT1C123uhyKT
X-Google-Smtp-Source: ABdhPJxYyhqeZ8T48RQ3JupJBFwH43ZRTzbgmUuznh5dx+xK6YPvTvZK3/mT8LJImWahOA9IQhB3NciDx0kOvwkSbG+5zZbDJt6T
MIME-Version: 1.0
X-Received: by 2002:a05:6602:20c3:: with SMTP id 3mr22432862ioz.145.1635791074273;
 Mon, 01 Nov 2021 11:24:34 -0700 (PDT)
Date:   Mon, 01 Nov 2021 11:24:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e8ad6005cfbe4960@google.com>
Subject: [syzbot] WARNING in io_poll_task_func
From:   syzbot <syzbot+50a186b2a3a0139929ab@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiaoguang.wang@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bdcc9f6a5682 Add linux-next specific files for 20211029
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=142531f4b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4b504bcb4c507265
dashboard link: https://syzkaller.appspot.com/bug?extid=50a186b2a3a0139929ab
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177a979ab00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1636cc5f300000

The issue was bisected to:

commit 34ced75ca1f63fac6148497971212583aa0f7a87
Author: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Date:   Mon Oct 25 05:38:48 2021 +0000

    io_uring: reduce frequent add_wait_queue() overhead for multi-shot poll request

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=121db4cab00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=111db4cab00000
console output: https://syzkaller.appspot.com/x/log.txt?x=161db4cab00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+50a186b2a3a0139929ab@syzkaller.appspotmail.com
Fixes: 34ced75ca1f6 ("io_uring: reduce frequent add_wait_queue() overhead for multi-shot poll request")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6637 at fs/io_uring.c:1183 req_ref_put_and_test fs/io_uring.c:1183 [inline]
WARNING: CPU: 0 PID: 6637 at fs/io_uring.c:1183 req_ref_put_and_test fs/io_uring.c:1178 [inline]
WARNING: CPU: 0 PID: 6637 at fs/io_uring.c:1183 io_put_req_find_next fs/io_uring.c:2392 [inline]
WARNING: CPU: 0 PID: 6637 at fs/io_uring.c:1183 io_poll_task_func+0x81d/0x9f0 fs/io_uring.c:5412
Modules linked in:
CPU: 0 PID: 6637 Comm: syz-executor446 Not tainted 5.15.0-rc7-next-20211029-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:req_ref_put_and_test fs/io_uring.c:1183 [inline]
RIP: 0010:req_ref_put_and_test fs/io_uring.c:1178 [inline]
RIP: 0010:io_put_req_find_next fs/io_uring.c:2392 [inline]
RIP: 0010:io_poll_task_func+0x81d/0x9f0 fs/io_uring.c:5412
Code: e8 e8 f3 da ff f0 ff 8d 80 00 00 00 0f 94 c3 31 ff 89 de e8 15 33 94 ff 84 db 0f 84 47 f8 ff ff e9 a4 fa ff ff e8 23 2f 94 ff <0f> 0b eb c5 e8 4a f0 da ff e9 0e f8 ff ff 4c 89 f7 e8 0d f0 da ff
RSP: 0018:ffffc90001f8fd98 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 000000000000007f RCX: 0000000000000000
RDX: ffff888016843a80 RSI: ffffffff81e39d0d RDI: 0000000000000003
RBP: ffff88806f8f9640 R08: 000000000000007f R09: ffff88806f8f96c3
R10: ffffffff81e39cd1 R11: 0000000000000000 R12: ffff88806f8f96c0
R13: ffff88806b400000 R14: 0000000000000143 R15: ffff88801c31f3c0
FS:  00007f5ca4281700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc595b2960 CR3: 0000000079b4d000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tctx_task_work+0x1b3/0x630 fs/io_uring.c:2207
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_signal include/linux/tracehook.h:214 [inline]
 handle_signal_work kernel/entry/common.c:146 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
 exit_to_user_mode_prepare+0x256/0x290 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f5ca42cfd19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5ca42812f8 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
RAX: 00000000000002ff RBX: 00007f5ca4357428 RCX: 00007f5ca42cfd19
RDX: 0000000000000000 RSI: 00000000000002ff RDI: 0000000000000003
RBP: 00007f5ca4357420 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5ca4325074
R13: 0000000000000000 R14: 00007f5ca4281400 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

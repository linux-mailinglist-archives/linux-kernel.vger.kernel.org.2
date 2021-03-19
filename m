Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87BF33418B0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 10:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhCSJp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 05:45:27 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:53119 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhCSJpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:45:20 -0400
Received: by mail-io1-f69.google.com with SMTP id v5so29634979ioq.19
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 02:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=GKPXbiVNuIwQHsRuMAbWdUTxkPnfWdxXiRjOZg6AQ8o=;
        b=bHEHEcgZ0mHVRjsBzlpRdKReGnQR6N3mTrPgDTEnnrm7YTj+dhVqbPDSt9CDwaTTTv
         WWdZBcJPi2fbl2k6WLkzOPPDALBxfRfu/gmP2mzZLWSRInEmCQqzKgsttr8inxzXNkFY
         GtwcX16K47Y4LiA8LL31WxtTxBZ2dex+iN8XHJGlRy8zsGN/Wsj0+9ZW5RWoBpS1I/Ov
         HUAkiRbzu3tOQBDtCgy8mh01gCRv86OIWzWaAyUwiw1uKkmVJieM32mFSYgJ1rNnK6jm
         zuCEcCXeOFRZOKmyStMUIqvRQgPSRvX63SGnqUR5WwYx1Hi2OpZoSz5VKG0WZ6c6U/kE
         W+IA==
X-Gm-Message-State: AOAM5300DycSd36pgTb1cgvQ/YRPnonPO+IvHHcQu0l1YJg3lo+t/acN
        fJKlTeIE7xtz+4Q+QDvwagKhwOrFHPWNx+TZn/4Phl0m5HYE
X-Google-Smtp-Source: ABdhPJzFsa8iygFbN7hXAnw0CQ8QrVL80j/Moe3pG4vWZO4TIsqy8BNsvqV6wI+wIxFnNVAI9mM6pRVrRHC7Hu2Ls5SXJl3Ra17u
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14cb:: with SMTP id b11mr2114361iow.175.1616147119654;
 Fri, 19 Mar 2021 02:45:19 -0700 (PDT)
Date:   Fri, 19 Mar 2021 02:45:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f8ca3305bde0922e@google.com>
Subject: [syzbot] WARNING in percpu_ref_exit (3)
From:   syzbot <syzbot+fedc0f6148b1b9a42593@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bf152b0b Merge tag 'for_linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14532c1ad00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2f52d48cfe68458
dashboard link: https://syzkaller.appspot.com/bug?extid=fedc0f6148b1b9a42593
compiler:       Debian clang version 11.0.1-2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fedc0f6148b1b9a42593@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 68 at lib/percpu-refcount.c:113 __percpu_ref_exit lib/percpu-refcount.c:113 [inline]
WARNING: CPU: 0 PID: 68 at lib/percpu-refcount.c:113 percpu_ref_exit+0x1e0/0x1f0 lib/percpu-refcount.c:134
Modules linked in:
CPU: 1 PID: 68 Comm: kworker/u4:2 Not tainted 5.12.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound io_ring_exit_work
RIP: 0010:__percpu_ref_exit lib/percpu-refcount.c:113 [inline]
RIP: 0010:percpu_ref_exit+0x1e0/0x1f0 lib/percpu-refcount.c:134
Code: c7 c7 80 67 ce 8c 4c 89 e6 e8 9c 96 84 05 48 8b 3c 24 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d e9 65 8b e8 fd e8 00 68 a5 fd <0f> 0b e9 d0 fe ff ff 66 0f 1f 84 00 00 00 00 00 41 57 41 56 41 55
RSP: 0018:ffffc90000fbfba0 EFLAGS: 00010293
RAX: ffffffff83d35710 RBX: 0000607f46034a90 RCX: ffff88801195b780
RDX: 0000000000000000 RSI: 0000607f46034a90 RDI: 0000000000000000
RBP: ffff8880292ae580 R08: ffffffff83d355a5 R09: fffffbfff1f290ca
R10: fffffbfff1f290ca R11: 0000000000000000 R12: ffff8880292ae590
R13: ffff8880121a6000 R14: 1ffff11002434c00 R15: 1ffff11002434c01
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32d23000 CR3: 0000000013897000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 io_ring_ctx_free fs/io_uring.c:8419 [inline]
 io_ring_exit_work+0x580/0xa90 fs/io_uring.c:8565
 process_one_work+0x789/0xfd0 kernel/workqueue.c:2275
 worker_thread+0xac1/0x1300 kernel/workqueue.c:2421
 kthread+0x39a/0x3c0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D751A40FEFE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 20:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245253AbhIQSIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 14:08:49 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:50759 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbhIQSIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 14:08:47 -0400
Received: by mail-io1-f69.google.com with SMTP id p71-20020a6b8d4a000000b005d323186f7cso12829587iod.17
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 11:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=veJzQ72AWxxL+dvzV9cICjYgzqmC1otqE4lYiPabm08=;
        b=cUbKv/OQWlAdk5xQWrAg9D05ukvG6fKFZpvzv51UeKCymLzgoVgHT94xcWcha1yTJE
         ODsHxbIkLc/zUcGljKWxWjUzDqVQR4waOwjQUg//9/HLBZiC9HLy7FD36FHuVlfJG3Q3
         0pb8e3VCW4UBqDJXXOlXvrPr+D9zZ0H3hlm52Ed6xFwsozJgXNZRsko0Ds8xutddp9Hu
         ewY28zt/af+9x6MsI1dws3A0o/YAhFj705LPZIZeIX18DNbmjGUSqvxR+XeAFZSNhFej
         K3gklAm/DEx0x9atNkXWQSN7dh3smZnvV0N01rOtSN03Mg12gA2zfupR/x5FZjgSFBlT
         RYww==
X-Gm-Message-State: AOAM533Z34UTasVYYK9bLqZwfNw8qMZBLlZQ/gBOGPEJ7Unvqg60+qCG
        qn9wXiIBJ1on1lqaFKfFGALa6gFI3AhZ6VRd1TUJBxDhdpky
X-Google-Smtp-Source: ABdhPJwZhNXAwwnK0Qh+clUHQDE/55QI/OcFJuZV51dTTflISlGp0fb9zKMHsL6rVoYkIjo93SoshYAbL7qWZ+uU6YCGz6apkw8K
MIME-Version: 1.0
X-Received: by 2002:a5d:9c53:: with SMTP id 19mr9335696iof.192.1631902045394;
 Fri, 17 Sep 2021 11:07:25 -0700 (PDT)
Date:   Fri, 17 Sep 2021 11:07:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b9605b05cc34cd28@google.com>
Subject: [syzbot] WARNING: locking bug in sco_sock_timeout
From:   syzbot <syzbot+91ba852bd0ad0581a0e3@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f11ee2ad25b2 net: mana: Prefer struct_size over open coded..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=14a96963300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=16e23f04679ec35e
dashboard link: https://syzkaller.appspot.com/bug?extid=91ba852bd0ad0581a0e3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+91ba852bd0ad0581a0e3@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 1 PID: 32344 at kernel/locking/lockdep.c:203 hlock_class kernel/locking/lockdep.c:203 [inline]
WARNING: CPU: 1 PID: 32344 at kernel/locking/lockdep.c:203 hlock_class kernel/locking/lockdep.c:192 [inline]
WARNING: CPU: 1 PID: 32344 at kernel/locking/lockdep.c:203 check_wait_context kernel/locking/lockdep.c:4688 [inline]
WARNING: CPU: 1 PID: 32344 at kernel/locking/lockdep.c:203 __lock_acquire+0x1344/0x54a0 kernel/locking/lockdep.c:4965
Modules linked in:
CPU: 1 PID: 32344 Comm: kworker/1:0 Not tainted 5.14.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events sco_sock_timeout
RIP: 0010:hlock_class kernel/locking/lockdep.c:203 [inline]
RIP: 0010:hlock_class kernel/locking/lockdep.c:192 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4688 [inline]
RIP: 0010:__lock_acquire+0x1344/0x54a0 kernel/locking/lockdep.c:4965
Code: 08 84 d2 0f 85 f1 3d 00 00 8b 05 df 9a 13 0c 85 c0 0f 85 f4 fd ff ff 48 c7 c6 60 03 8c 89 48 c7 c7 20 f7 8b 89 e8 79 ff 96 07 <0f> 0b 31 ed e9 b7 f0 ff ff e8 de 49 7b 02 85 c0 0f 84 12 fe ff ff
RSP: 0018:ffffc900161efa88 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffff88801ec820a0 RCX: 0000000000000000
RDX: ffff8880247b9c80 RSI: ffffffff815dbd58 RDI: fffff52002c3df43
RBP: 0000000000000b04 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815d5afe R11: 0000000000000000 R12: ffff8880247ba6c8
R13: ffff8880247b9c80 R14: 0000000000040000 R15: 0000000000040b04
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc98ea0b718 CR3: 000000001cc2b000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 lock_acquire kernel/locking/lockdep.c:5625 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
 _raw_spin_lock_bh+0x2f/0x40 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:368 [inline]
 lock_sock_nested+0x40/0x120 net/core/sock.c:3183
 lock_sock include/net/sock.h:1612 [inline]
 sco_sock_timeout+0xd2/0x290 net/bluetooth/sco.c:96
 process_one_work+0x9bf/0x16b0 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

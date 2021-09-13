Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57BE4083BE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 07:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbhIMFQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 01:16:40 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:57045 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbhIMFQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 01:16:39 -0400
Received: by mail-io1-f69.google.com with SMTP id z71-20020a6bc94a000000b005d09bfe2668so984306iof.23
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 22:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=dTVsWZPyEZSZb6YETT9aCHK9GgOqBT0Lc4pHP3Lx6e8=;
        b=ba3FWK3P/2robX9y+munkZDYty+kTcXd9r+fnRE7sR9+4+n/o7tRpFye6IOXFj0861
         3tQ+d/yvpoZBnCIiuapHWVxuStPkNWAK1T0eTc1G7Av7nsmiJEWUx09+nxbP71V1ylpz
         zjMGwm5r56C4qxWVwcHw7vce6U+AKH7a5WNKl+Ch1Y0va6sRc+lDVlkjm2lXbt3h28tx
         vTXuqcPDYlRR2+bVyvdViIRi4B7Qopem+eyKdO7e0xeIg9Gg7rIe6GBWDu3ftmTCxznr
         x3XmZ2p7SngthGoMnqsFXgiLH2QW/fuRluf0aMzM8ws16Q0b5+D6Fl637cN1TJQ4PdFC
         S5eg==
X-Gm-Message-State: AOAM531xQmBeAronVVCPKIGBpts1LCcQ7Zi9XxV0UWLhaC+tM69DNTz4
        MmXUrzj+sFtXwHu9yt1SLn8O0j0o0C75CezFSVJB4lLCMl1x
X-Google-Smtp-Source: ABdhPJwO7iV5Xgy+j0Lqk/9D8z0ZhHnqpHxWMiJvuG9Vcu9TbDCEif0fnrEUbAbQSchI7yx4o/iva7NqZw76Vn3WUO2k9LiIPSBi
MIME-Version: 1.0
X-Received: by 2002:a02:3b58:: with SMTP id i24mr8092839jaf.144.1631510123863;
 Sun, 12 Sep 2021 22:15:23 -0700 (PDT)
Date:   Sun, 12 Sep 2021 22:15:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000061641905cbd98d7b@google.com>
Subject: [syzbot] possible deadlock in rfcomm_sk_state_change
From:   syzbot <syzbot+d7ce59b06b3eb14fd218@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, davem@davemloft.net,
        desmondcheongzx@gmail.com, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tedd.an@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a3fa7a101dcf Merge branches 'akpm' and 'akpm-hotfixes' (pa..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d61a8b300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9b60f3b657f313d
dashboard link: https://syzkaller.appspot.com/bug?extid=d7ce59b06b3eb14fd218
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15247a7d300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a2642b300000

The issue was bisected to:

commit 1804fdf6e494e5e2938c65d8391690b59bcff897
Author: Tedd Ho-Jeong An <tedd.an@intel.com>
Date:   Thu Aug 5 00:32:19 2021 +0000

    Bluetooth: btintel: Combine setting up MSFT extension

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=125f4163300000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=115f4163300000
console output: https://syzkaller.appspot.com/x/log.txt?x=165f4163300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d7ce59b06b3eb14fd218@syzkaller.appspotmail.com
Fixes: 1804fdf6e494 ("Bluetooth: btintel: Combine setting up MSFT extension")

======================================================
WARNING: possible circular locking dependency detected
5.14.0-syzkaller #0 Not tainted
------------------------------------------------------
krfcommd/2875 is trying to acquire lock:
ffff888012b9d120 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1612 [inline]
ffff888012b9d120 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}, at: rfcomm_sk_state_change+0x63/0x300 net/bluetooth/rfcomm/sock.c:73

but task is already holding lock:
ffff88807cf12528 (&d->lock){+.+.}-{3:3}, at: __rfcomm_dlc_close+0x281/0x480 net/bluetooth/rfcomm/core.c:487

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&d->lock){+.+.}-{3:3}:
       lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5625
       __mutex_lock_common+0x1df/0x2550 kernel/locking/mutex.c:596
       __mutex_lock kernel/locking/mutex.c:729 [inline]
       mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:743
       __rfcomm_dlc_close+0x281/0x480 net/bluetooth/rfcomm/core.c:487
       rfcomm_process_dlcs+0x92/0x620 net/bluetooth/rfcomm/core.c:1844
       rfcomm_process_sessions+0x2f6/0x3f0 net/bluetooth/rfcomm/core.c:2003
       rfcomm_run+0x195/0x2c0 net/bluetooth/rfcomm/core.c:2086
       kthread+0x453/0x480 kernel/kthread.c:319
       ret_from_fork+0x1f/0x30

-> #1 (rfcomm_mutex){+.+.}-{3:3}:
       lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5625
       __mutex_lock_common+0x1df/0x2550 kernel/locking/mutex.c:596
       __mutex_lock kernel/locking/mutex.c:729 [inline]
       mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:743
       rfcomm_dlc_open+0x25/0x50 net/bluetooth/rfcomm/core.c:425
       rfcomm_sock_connect+0x285/0x470 net/bluetooth/rfcomm/sock.c:413
       __sys_connect_file net/socket.c:1896 [inline]
       __sys_connect+0x38a/0x410 net/socket.c:1913
       __do_sys_connect net/socket.c:1923 [inline]
       __se_sys_connect net/socket.c:1920 [inline]
       __x64_sys_connect+0x76/0x80 net/socket.c:1920
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3051 [inline]
       check_prevs_add kernel/locking/lockdep.c:3174 [inline]
       validate_chain+0x1dfb/0x8240 kernel/locking/lockdep.c:3789
       __lock_acquire+0x1382/0x2b00 kernel/locking/lockdep.c:5015
       lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5625
       lock_sock_nested+0xc6/0x110 net/core/sock.c:3191
       lock_sock include/net/sock.h:1612 [inline]
       rfcomm_sk_state_change+0x63/0x300 net/bluetooth/rfcomm/sock.c:73
       __rfcomm_dlc_close+0x2cc/0x480 net/bluetooth/rfcomm/core.c:489
       rfcomm_process_dlcs+0x92/0x620 net/bluetooth/rfcomm/core.c:1844
       rfcomm_process_sessions+0x2f6/0x3f0 net/bluetooth/rfcomm/core.c:2003
       rfcomm_run+0x195/0x2c0 net/bluetooth/rfcomm/core.c:2086
       kthread+0x453/0x480 kernel/kthread.c:319
       ret_from_fork+0x1f/0x30

other info that might help us debug this:

Chain exists of:
  sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM --> rfcomm_mutex --> &d->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&d->lock);
                               lock(rfcomm_mutex);
                               lock(&d->lock);
  lock(sk_lock-AF_BLUETOOTH-BTPROTO_RFCOMM);

 *** DEADLOCK ***

2 locks held by krfcommd/2875:
 #0: ffffffff8dac7488 (rfcomm_mutex){+.+.}-{3:3}, at: rfcomm_process_sessions+0x21/0x3f0 net/bluetooth/rfcomm/core.c:1979
 #1: ffff88807cf12528 (&d->lock){+.+.}-{3:3}, at: __rfcomm_dlc_close+0x281/0x480 net/bluetooth/rfcomm/core.c:487

stack backtrace:
CPU: 1 PID: 2875 Comm: krfcommd Not tainted 5.14.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1dc/0x2d8 lib/dump_stack.c:106
 check_noncircular+0x2f9/0x3b0 kernel/locking/lockdep.c:2131
 check_prev_add kernel/locking/lockdep.c:3051 [inline]
 check_prevs_add kernel/locking/lockdep.c:3174 [inline]
 validate_chain+0x1dfb/0x8240 kernel/locking/lockdep.c:3789
 __lock_acquire+0x1382/0x2b00 kernel/locking/lockdep.c:5015
 lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5625
 lock_sock_nested+0xc6/0x110 net/core/sock.c:3191
 lock_sock include/net/sock.h:1612 [inline]
 rfcomm_sk_state_change+0x63/0x300 net/bluetooth/rfcomm/sock.c:73
 __rfcomm_dlc_close+0x2cc/0x480 net/bluetooth/rfcomm/core.c:489
 rfcomm_process_dlcs+0x92/0x620 net/bluetooth/rfcomm/core.c:1844
 rfcomm_process_sessions+0x2f6/0x3f0 net/bluetooth/rfcomm/core.c:2003
 rfcomm_run+0x195/0x2c0 net/bluetooth/rfcomm/core.c:2086
 kthread+0x453/0x480 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

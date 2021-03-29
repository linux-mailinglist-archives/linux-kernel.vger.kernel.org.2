Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2EB34D8A4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 21:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhC2Tyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 15:54:49 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:52695 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbhC2TyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 15:54:15 -0400
Received: by mail-io1-f72.google.com with SMTP id d4so2347342iop.19
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 12:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9OCu5sQ+8X7Q7NTe9/T+gXBubybQ8Z+U2yosy/x1k7o=;
        b=MT4eU/lpja+HvoZFwZ2EuX+MELxk9woISHQEBS/PkTxuG2/f6GhIKOP0EpJGMSWi9D
         3tagU/N0WNzi8+6MihCrMnW/XJ7Tkf4g61pPQwopVXBlb4mzGye9As6iYItl541mbzyf
         6ZfZoCz/S7GbI9lr3oM0TMW4XNe+TNEGriM8XPc7Yhj1kN5FvAIPi0klfy0iJRHEk9wq
         bcqsKKWjMddSHom7o3r0T6X4//fv7ehFEpOeiXB6c8+Nzp0kDxMqBwy7QYnglEm0yaez
         XfmadG6BYSTPZvul5L718A1N8n09wbLbQzUgRLA9dL7tmYH/awImPCyojwqfJmJ/DVsC
         MPlA==
X-Gm-Message-State: AOAM530XB05ZedaEmShRNEhVzNtJGB5TF2UyV6zx18ZTxvowmH9mBPbW
        ybgeyA/9/UCDLaBYESikjW9w7qgVv2Dny6rL8aavsisZ0DPZ
X-Google-Smtp-Source: ABdhPJw6OTTQgLO+YTl8vtcI6YsQ685Og28Cp0wEBhDVnUP55Z4DdG1TxWttnlHkrIR2p+QVGfIGi+C0d/Hctq0QVcm9Nu8KeYGg
MIME-Version: 1.0
X-Received: by 2002:a05:6638:371f:: with SMTP id k31mr25949222jav.143.1617047655080;
 Mon, 29 Mar 2021 12:54:15 -0700 (PDT)
Date:   Mon, 29 Mar 2021 12:54:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000010eb3b05beb23f7a@google.com>
Subject: [syzbot] possible deadlock in do_ipv6_setsockopt (3)
From:   syzbot <syzbot+0eedf083894a053f17a5@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    75887e88 Merge branch '40GbE' of git://git.kernel.org/pub/..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1133dd06d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=daeff30c2474a60f
dashboard link: https://syzkaller.appspot.com/bug?extid=0eedf083894a053f17a5

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0eedf083894a053f17a5@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.12.0-rc4-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.0/11001 is trying to acquire lock:
ffff88805c53ef60 (sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1600 [inline]
ffff88805c53ef60 (sk_lock-AF_INET6){+.+.}-{0:0}, at: do_ipv6_setsockopt.constprop.0+0x31f/0x41f0 net/ipv6/ipv6_sockglue.c:418

but task is already holding lock:
ffffffff8d66b1a8 (rtnl_mutex){+.+.}-{3:3}, at: do_ipv6_setsockopt.constprop.0+0x315/0x41f0 net/ipv6/ipv6_sockglue.c:417

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (rtnl_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:949 [inline]
       __mutex_lock+0x139/0x1120 kernel/locking/mutex.c:1096
       ipv6_sock_mc_close+0xd7/0x110 net/ipv6/mcast.c:323
       mptcp6_release+0xb9/0x130 net/mptcp/protocol.c:3558
       __sock_release+0xcd/0x280 net/socket.c:599
       sock_close+0x18/0x20 net/socket.c:1258
       __fput+0x288/0x920 fs/file_table.c:280
       task_work_run+0xdd/0x1a0 kernel/task_work.c:140
       tracehook_notify_resume include/linux/tracehook.h:189 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
       exit_to_user_mode_prepare+0x249/0x250 kernel/entry/common.c:208
       __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
       syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:301
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (sk_lock-AF_INET6){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:2936 [inline]
       check_prevs_add kernel/locking/lockdep.c:3059 [inline]
       validate_chain kernel/locking/lockdep.c:3674 [inline]
       __lock_acquire+0x2b14/0x54c0 kernel/locking/lockdep.c:4900
       lock_acquire kernel/locking/lockdep.c:5510 [inline]
       lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5475
       lock_sock_nested+0xca/0x120 net/core/sock.c:3071
       lock_sock include/net/sock.h:1600 [inline]
       do_ipv6_setsockopt.constprop.0+0x31f/0x41f0 net/ipv6/ipv6_sockglue.c:418
       ipv6_setsockopt+0xd6/0x180 net/ipv6/ipv6_sockglue.c:1003
       tcp_setsockopt+0x136/0x24a0 net/ipv4/tcp.c:3643
       __sys_setsockopt+0x2db/0x610 net/socket.c:2117
       __do_sys_setsockopt net/socket.c:2128 [inline]
       __se_sys_setsockopt net/socket.c:2125 [inline]
       __x64_sys_setsockopt+0xba/0x150 net/socket.c:2125
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(rtnl_mutex);
                               lock(sk_lock-AF_INET6);
                               lock(rtnl_mutex);
  lock(sk_lock-AF_INET6);

 *** DEADLOCK ***

1 lock held by syz-executor.0/11001:
 #0: ffffffff8d66b1a8 (rtnl_mutex){+.+.}-{3:3}, at: do_ipv6_setsockopt.constprop.0+0x315/0x41f0 net/ipv6/ipv6_sockglue.c:417

stack backtrace:
CPU: 0 PID: 11001 Comm: syz-executor.0 Not tainted 5.12.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2127
 check_prev_add kernel/locking/lockdep.c:2936 [inline]
 check_prevs_add kernel/locking/lockdep.c:3059 [inline]
 validate_chain kernel/locking/lockdep.c:3674 [inline]
 __lock_acquire+0x2b14/0x54c0 kernel/locking/lockdep.c:4900
 lock_acquire kernel/locking/lockdep.c:5510 [inline]
 lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5475
 lock_sock_nested+0xca/0x120 net/core/sock.c:3071
 lock_sock include/net/sock.h:1600 [inline]
 do_ipv6_setsockopt.constprop.0+0x31f/0x41f0 net/ipv6/ipv6_sockglue.c:418
 ipv6_setsockopt+0xd6/0x180 net/ipv6/ipv6_sockglue.c:1003
 tcp_setsockopt+0x136/0x24a0 net/ipv4/tcp.c:3643
 __sys_setsockopt+0x2db/0x610 net/socket.c:2117
 __do_sys_setsockopt net/socket.c:2128 [inline]
 __se_sys_setsockopt net/socket.c:2125 [inline]
 __x64_sys_setsockopt+0xba/0x150 net/socket.c:2125
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x466459
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f67f5e8f188 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 000000000056c200 RCX: 0000000000466459
RDX: 000000000000002d RSI: 0000000000000029 RDI: 0000000000000006
RBP: 00000000004bf9fb R08: 0000000000000088 R09: 0000000000000000
R10: 0000000020000100 R11: 0000000000000246 R12: 000000000056c200
R13: 00007fff467656ef R14: 00007f67f5e8f300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

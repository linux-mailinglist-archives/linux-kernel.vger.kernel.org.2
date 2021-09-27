Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE75419D18
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbhI0RmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:42:16 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:38739 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236655AbhI0RmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:42:00 -0400
Received: by mail-il1-f200.google.com with SMTP id r13-20020a92440d000000b002498d6b85c1so19600023ila.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 10:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=cOJxCxUznvTNnYCobJsH1tRBzSWjJvrX+Y0xHoCPCGE=;
        b=NXK4Tj6Wl094geIuQX5M+H+YhPqBcByYZ0BFNelN/98ULWGXZpTnTEE/WL/wsUQGrj
         /7ug3LY3PNc8N34NV7Xh38JnUJgljNhEt0UCmfzcv7KluTfZ2BxjqGx0brmc/t5p2j5w
         N+DAYvYi4GYIAKoiFIvesxi16upQuRRUZkrq5XiRhrlxiRahsftAFUdpzv6cZAr0P9jm
         YAnWpU2bOiDe3kUlWUI00WtPfzeD8QG2K40gkVir9SwkzTSRAF3vSTFpWm7sewJyBGbU
         AbMMlRo9rvPVyNase33MMBi1jyNBzmaHSqmkd6QA9VdjJGwoCWU7ZLgSjpiJpqtNrokC
         F8MQ==
X-Gm-Message-State: AOAM533Wbkz07VoX6v7/HUSPYjANBHy1LFUgXvZq0oC3ivhg6ul/t15Y
        CIcJhhgFwl9jW3ivodC6/+3LdVk3MFfK8hIyWyf87V1GXwQB
X-Google-Smtp-Source: ABdhPJwCjJf8t4TklXsrTSVhPLmgvIPwNJGWMu6Lw8cb6sNYxjrAK4n1zSu+6uyA7Gu0sq6fHF8SSL2pBu6aN6b8sDO8mEClUCdy
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164e:: with SMTP id v14mr963848ilu.104.1632764422356;
 Mon, 27 Sep 2021 10:40:22 -0700 (PDT)
Date:   Mon, 27 Sep 2021 10:40:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000065872305ccfd975c@google.com>
Subject: [syzbot] WARNING: still has locks held in rxrpc_sendmsg
From:   syzbot <syzbot+ab47992aa36f7cc43f1b@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com, kuba@kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        marc.dionne@auristor.com, mingo@kernel.org, mingo@redhat.com,
        netdev@vger.kernel.org, peterz@infradead.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4c4f0c2bf341 Merge tag 'ceph-for-5.15-rc3' of git://github..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=148a7b5f300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=83fd90919369058f
dashboard link: https://syzkaller.appspot.com/bug?extid=ab47992aa36f7cc43f1b
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17750c6b300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14dc8087300000

The issue was bisected to:

commit 4d004099a668c41522242aa146a38cc4eb59cb1e
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Fri Oct 2 09:04:21 2020 +0000

    lockdep: Fix lockdep recursion

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=151246d1300000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=171246d1300000
console output: https://syzkaller.appspot.com/x/log.txt?x=131246d1300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ab47992aa36f7cc43f1b@syzkaller.appspotmail.com
Fixes: 4d004099a668 ("lockdep: Fix lockdep recursion")

====================================
WARNING: syz-executor718/13823 still has locks held!
5.15.0-rc2-syzkaller #0 Not tainted
------------------------------------
1 lock held by syz-executor718/13823:
 #0: ffff88815d3d9620 (sk_lock-AF_RXRPC){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1612 [inline]
 #0: ffff88815d3d9620 (sk_lock-AF_RXRPC){+.+.}-{0:0}, at: rxrpc_sendmsg+0x11a/0x8a0 net/rxrpc/af_rxrpc.c:520

stack backtrace:
CPU: 1 PID: 13823 Comm: syz-executor718 Not tainted 5.15.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x201/0x2d8 lib/dump_stack.c:106
 try_to_freeze include/linux/freezer.h:66 [inline]
 get_signal+0x185/0x20c0 kernel/signal.c:2663
 arch_do_signal_or_restart+0x9c/0x730 arch/x86/kernel/signal.c:865
 handle_signal_work kernel/entry/common.c:148 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
 exit_to_user_mode_prepare+0x191/0x220 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x2e/0x70 kernel/entry/common.c:300
 do_syscall_64+0x53/0xd0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fe10f2acb59
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe10f25d208 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: fffffffffffffe00 RBX: 00007fe10f3343e8 RCX: 00007fe10f2acb59
RDX: 0000000000000001 RSI: 0000000020001900 RDI: 0000000000000003
RBP: 00007fe10f3343e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe10f3343ec
R13: 00007ffdce01da0f R14: 00007fe10f25d300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

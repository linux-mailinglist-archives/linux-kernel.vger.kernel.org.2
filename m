Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860FC3FBD64
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 22:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbhH3UUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 16:20:25 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:56113 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237017AbhH3UUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 16:20:20 -0400
Received: by mail-il1-f199.google.com with SMTP id c16-20020a92cf500000b02902243aec7e27so9843572ilr.22
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 13:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=QZkpasqzKgqT+xZmsajBBcw/kv6RDRSIJuoe9agvRDM=;
        b=ew7tjnzxdOdbt7lJ5o/qlvK4sKA8xFqNiB3XUE73obXId/1YrAqyZa2ovM/+rl0MeY
         AFHrkt4YESS77iU9uGG+a2n43E7vI2T3WMUuQowA7tcX78MPrQBI6BcquG+MV9P5zkSX
         8HzkRyll01ks/gdaq3MvglomTvzkNDEUtFpfnTyA93PLaecvrYw17lk5xIKIujRNRMA1
         ZEsQ5HbBfFvAcSys+e9x6MIo6IS/q1+2WnYtEpb288mtZvQxw43EkA0Tm78VBvqU4wEt
         xBPdMlN9b3PyMmthGf/CQItOdmQ5xhRaGmwiF5O3oU2YmS/0Tf3W0VGh2fMlirAJJRis
         JrTw==
X-Gm-Message-State: AOAM5307vtxydNC0/MgBR47ioTk+0Rk4yR3QZc9IMRaoBbuGoR8C6kOO
        8KnyRqivxX3FlkC8ArcPa+pMDhsuKZ4ggxVqxUtl64Qtslb7
X-Google-Smtp-Source: ABdhPJwFNkrFwz2YjRkYl5/Kjj80freLjHikyTzWX9cYv/jET1LEGjHkcDHrrM+MTydKT07W8uitUhjIO9D9N6X+dRMTP+pFM8Mk
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0f:: with SMTP id s15mr18898654ild.158.1630354766183;
 Mon, 30 Aug 2021 13:19:26 -0700 (PDT)
Date:   Mon, 30 Aug 2021 13:19:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b2420c05cacc8c66@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in xfrm_get_default
From:   syzbot <syzbot+b2be9dd8ca6f6c73ee2d@syzkaller.appspotmail.com>
To:     antony.antony@secunet.com, christian.langrock@secunet.com,
        davem@davemloft.net, herbert@gondor.apana.org.au, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    eaf2aaec0be4 Merge tag 'wireless-drivers-next-2021-08-29' ..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1219326d300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f9d4c9ff8c5ae7
dashboard link: https://syzkaller.appspot.com/bug?extid=b2be9dd8ca6f6c73ee2d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e6e3a9300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10de8a6d300000

The issue was bisected to:

commit 2d151d39073aff498358543801fca0f670fea981
Author: Steffen Klassert <steffen.klassert@secunet.com>
Date:   Sun Jul 18 07:11:06 2021 +0000

    xfrm: Add possibility to set the default to block if we have no policy

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=114523fe300000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=134523fe300000
console output: https://syzkaller.appspot.com/x/log.txt?x=154523fe300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b2be9dd8ca6f6c73ee2d@syzkaller.appspotmail.com
Fixes: 2d151d39073a ("xfrm: Add possibility to set the default to block if we have no policy")

netlink: 172 bytes leftover after parsing attributes in process `syz-executor354'.
================================================================================
UBSAN: shift-out-of-bounds in net/xfrm/xfrm_user.c:2010:49
shift exponent 224 is too large for 32-bit type 'int'
CPU: 1 PID: 8447 Comm: syz-executor354 Not tainted 5.14.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:327
 xfrm_get_default.cold+0x1f/0x75 net/xfrm/xfrm_user.c:2010
 xfrm_user_rcv_msg+0x430/0xa20 net/xfrm/xfrm_user.c:2869
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2504
 xfrm_netlink_rcv+0x6b/0x90 net/xfrm/xfrm_user.c:2891
 netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1340
 netlink_sendmsg+0x86d/0xdb0 net/netlink/af_netlink.c:1929
 sock_sendmsg_nosec net/socket.c:704 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:724
 sock_no_sendpage+0xf3/0x130 net/core/sock.c:2980
 kernel_sendpage.part.0+0x1a0/0x340 net/socket.c:3496
 kernel_sendpage net/socket.c:3493 [inline]
 sock_sendpage+0xe5/0x140 net/socket.c:1003
 pipe_to_sendpage+0x2ad/0x380 fs/splice.c:364
 splice_from_pipe_feed fs/splice.c:418 [inline]
 __splice_from_pipe+0x43e/0x8a0 fs/splice.c:562
 splice_from_pipe fs/splice.c:597 [inline]
 generic_splice_sendpage+0xd4/0x140 fs/splice.c:746
 do_splice_from fs/splice.c:767 [inline]
 direct_splice_actor+0x110/0x180 fs/splice.c:936
 splice_direct_to_actor+0x34b/0x8c0 fs/splice.c:891
 do_splice_direct+0x1b3/0x280 fs/splice.c:979
 do_sendfile+0x9f0/0x1120 fs/read_write.c:1260
 __do_sys_sendfile64 fs/read_write.c:1325 [inline]
 __se_sys_sendfile64 fs/read_write.c:1311 [inline]
 __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1311
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x43f019
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd24165888 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 0000000000400488 RCX: 000000000043f019
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000005
RBP: 0000000000403000 R08: 0000000000400488 R09: 0000000000400488
R10: 0000000100000002 R11: 0000000000000246 R12: 0000000000403090
R13: 0000000000000000 R14: 00000000004ac018 R15: 0000000000400488
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

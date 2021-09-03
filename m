Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7BD40069D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 22:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350544AbhICU31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 16:29:27 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:34431 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbhICU3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 16:29:23 -0400
Received: by mail-il1-f199.google.com with SMTP id d17-20020a9287510000b0290223c9088c96so176360ilm.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 13:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=YqQoBa+5swqJi2f/q8s+E21AiT3GDQ9ApeVznX2E31s=;
        b=P2GldMcxmPWTYgJpoRmc3wCeeszhfP3O9TSYBnKPlrilZwTKv2aUwtepqJpz0cKegz
         jnv3cQuPoh7L3l7DPD9BWI7RyowjOm6u3mv4nFcmuxyt7+etkHOnQJRQ72EVwYPXevh2
         ebGLowJ2A6GE1vbfTBOZnju6kY8Wa/Dg5a3yAxohcL4vm/O8o7IFSWd8XjPg+LVuY57U
         svIEYVBFdsimlh/VkXemqQ6TWbqhhZ1F1TLLOYM6L90s4W5MaQRufyo3OwujWhurrdaq
         QFUu/v34FZaGowDaJoiWnwK2wXtalR5RMD+INQvO02lw0ag3llnm/7FRRJvzNzML3ORD
         +XZQ==
X-Gm-Message-State: AOAM533IxgmrSvMxNVUA6+uuSqCynONge2up4t4qhJIWcCz8aG4MfSzg
        LeK+zhKnlt661/3gl4mQ7+ep1jVuuejkTYw4YTikN4QC7yOn
X-Google-Smtp-Source: ABdhPJxLxOs3VDRLGIuQGTQecsG+6fJJkGBMvnX/wtjVa7OID2oVNvVZKK/ztYkQJd5LkmHpcyWPKVo+X70ptdQk+FwlOuDWLlMQ
MIME-Version: 1.0
X-Received: by 2002:a02:946d:: with SMTP id a100mr747732jai.118.1630700902717;
 Fri, 03 Sep 2021 13:28:22 -0700 (PDT)
Date:   Fri, 03 Sep 2021 13:28:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a9f3605cb1d2455@google.com>
Subject: [syzbot] WARNING in __static_key_slow_dec
From:   syzbot <syzbot+30622fb04ddd72a4d167@syzkaller.appspotmail.com>
To:     ardb@kernel.org, jbaron@akamai.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    835d31d319d9 Merge tag 'media/v5.15-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15193486300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d793523866f2daea
dashboard link: https://syzkaller.appspot.com/bug?extid=30622fb04ddd72a4d167
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1565e801300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16bd5513300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+30622fb04ddd72a4d167@syzkaller.appspotmail.com

8021q: adding VLAN 0 to HW filter on device bond5
------------[ cut here ]------------
jump label: negative count!
WARNING: CPU: 0 PID: 8606 at kernel/jump_label.c:235 static_key_slow_try_dec kernel/jump_label.c:235 [inline]
WARNING: CPU: 0 PID: 8606 at kernel/jump_label.c:235 __static_key_slow_dec_cpuslocked kernel/jump_label.c:243 [inline]
WARNING: CPU: 0 PID: 8606 at kernel/jump_label.c:235 __static_key_slow_dec+0xfb/0x150 kernel/jump_label.c:255
Modules linked in:
CPU: 0 PID: 8606 Comm: syz-executor165 Not tainted 5.14.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:static_key_slow_try_dec kernel/jump_label.c:235 [inline]
RIP: 0010:__static_key_slow_dec_cpuslocked kernel/jump_label.c:243 [inline]
RIP: 0010:__static_key_slow_dec+0xfb/0x150 kernel/jump_label.c:255
Code: c3 40 0f 94 c6 31 ff e8 63 34 d9 ff 84 db 75 1e e8 8a 31 d9 ff eb 24 e8 83 31 d9 ff 48 c7 c7 40 75 59 8a 31 c0 e8 25 8b a4 ff <0f> 0b eb 9f e8 6c 31 d9 ff 4c 89 f7 e8 54 f6 ff ff 48 c7 c7 c0 88
RSP: 0018:ffffc9000215e438 EFLAGS: 00010246
RAX: 5e2d18889f3c9100 RBX: 00000000ffffffff RCX: ffff8880224d3900
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 00000000ffffffff R08: ffffffff8166aff2 R09: ffffed1017383f2c
R10: ffffed1017383f2c R11: 0000000000000000 R12: 0000000000000000
R13: ffff8880356f00b0 R14: ffffffff90d9ec00 R15: 1ffff9200042bc01
FS:  00000000017be300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200001c0 CR3: 0000000036bed000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 bond_xdp_set drivers/net/bonding/bond_main.c:5233 [inline]
 bond_xdp+0x8dd/0xa10 drivers/net/bonding/bond_main.c:5264
 bond_enslave+0x40b7/0x5e20 drivers/net/bonding/bond_main.c:2187
 do_set_master net/core/rtnetlink.c:2521 [inline]
 do_setlink+0xfc3/0x4250 net/core/rtnetlink.c:2726
 __rtnl_newlink net/core/rtnetlink.c:3391 [inline]
 rtnl_newlink+0x16ee/0x1cf0 net/core/rtnetlink.c:3506
 rtnetlink_rcv_msg+0x91c/0xe50 net/core/rtnetlink.c:5572
 netlink_rcv_skb+0x1f0/0x460 net/netlink/af_netlink.c:2504
 netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
 netlink_unicast+0x7de/0x9b0 net/netlink/af_netlink.c:1340
 netlink_sendmsg+0x9e7/0xe00 net/netlink/af_netlink.c:1929
 sock_sendmsg_nosec net/socket.c:704 [inline]
 sock_sendmsg net/socket.c:724 [inline]
 ____sys_sendmsg+0x5a2/0x900 net/socket.c:2409
 ___sys_sendmsg net/socket.c:2463 [inline]
 __sys_sendmsg+0x319/0x400 net/socket.c:2492
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x440db9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcd41b2788 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000440db9
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000f0b5ff R09: 0000000000f0b5ff
R10: 0000000000f0b5ff R11: 0000000000000246 R12: 000000000000bd7b
R13: 00007ffcd41b27b0 R14: 00007ffcd41b27a0 R15: 00007ffcd41b2794


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

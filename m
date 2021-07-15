Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F963C9885
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 07:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239059AbhGOFwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 01:52:13 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:52054 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhGOFwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:52:11 -0400
Received: by mail-io1-f71.google.com with SMTP id x21-20020a5d99150000b02904e00bb129f0so2872376iol.18
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 22:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=WPN0W+LG0mp32ME22oVAjq2/8SSMhNnMVKYeba21W7s=;
        b=iDzqD1sOle+u4V2saIqif7E9SmQqXOqJ4RiHUzC5DOWLjWSX8UZcxGTI3m4+XbPdOK
         zSNdN9zY/lmvZQERwnJqN6y2/CHQXpyguV1sZPfd1pZMJ1WOIsOAyrD93s7i/SpgeyRd
         QF00YjN6oYOt8LphRD9xMKV8By5iqnXdbQt+u3mmqZhz8cdhvWWBj5+7XIX4Ias04GC5
         kCrn+EbIzIAaYWODpWhKl1p6Gb+lQCagzLmHP5sguN32PU1sNexansMQsJ0kF1KsDEiM
         U2GxHuEbJDAPDOjB++up6hUe+v9YNvh9+VagdXRp9zen9CXxPi1LPnlvHxJi+zIBtIl2
         t0YQ==
X-Gm-Message-State: AOAM533ZJZA3inw+mKH8CxJMrK5fHo1mVxn6icNjU8yEtznoZR7WkiGc
        JOxq6jIa+TM8ko01TtuN09p+JvxVa8ZVs1nBn8Uyspurf4Gw
X-Google-Smtp-Source: ABdhPJwLpsXgdKRFp9mhZjCz+VnccFp+UwO9HdMp5vbsmWQZAjkENntlo4tcyBNV8BGVakR3VWLjHSH17BSftOtJckBdFZ89KsJP
MIME-Version: 1.0
X-Received: by 2002:a02:94e5:: with SMTP id x92mr2241788jah.107.1626328159046;
 Wed, 14 Jul 2021 22:49:19 -0700 (PDT)
Date:   Wed, 14 Jul 2021 22:49:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003551a705c72308d7@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in csum_partial (3)
From:   syzbot <syzbot+ff8e1b9f2f36481e2efc@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        willemb@google.com, x86@kernel.org, xie.he.0141@gmail.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3dbdb38e2869 Merge branch 'for-5.14' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1054ebc2300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1700b0b2b41cd52c
dashboard link: https://syzkaller.appspot.com/bug?extid=ff8e1b9f2f36481e2efc
compiler:       Debian clang version 11.0.1-2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1170b0d2300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1454ebc2300000

The issue was bisected to:

commit fdafed459998e2be0e877e6189b24cb7a0183224
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon Oct 12 23:17:21 2020 +0000

    ip_gre: set dev->hard_header_len and dev->needed_headroom properly

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12e8b0d2300000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11e8b0d2300000
console output: https://syzkaller.appspot.com/x/log.txt?x=16e8b0d2300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ff8e1b9f2f36481e2efc@syzkaller.appspotmail.com
Fixes: fdafed459998 ("ip_gre: set dev->hard_header_len and dev->needed_headroom properly")

BUG: unable to handle page fault for address: ffff8880bfffd000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11401067 P4D 11401067 PUD 23ffff067 PMD 23fffe067 PTE 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8613 Comm: syz-executor500 Not tainted 5.13.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:do_csum arch/x86/lib/csum-partial_64.c:72 [inline]
RIP: 0010:csum_partial+0x184/0x470 arch/x86/lib/csum-partial_64.c:136
Code: 84 7c 00 00 00 41 ff ce 4c 89 f0 48 c1 e0 06 48 89 44 24 28 45 31 ff 48 8b 6c 24 08 66 2e 0f 1f 84 00 00 00 00 00 4c 03 6d 00 <4c> 13 6d 08 4c 13 6d 10 4c 13 6d 18 4c 13 6d 20 4c 13 6d 28 4c 13
RSP: 0018:ffffc9000203f050 EFLAGS: 00010282
RAX: ffffffff84277631 RBX: 000000001ffffffd RCX: ffff888031b08000
RDX: 0000000000000000 RSI: 0000000003ffffff RDI: 0000000000000000
RBP: ffff8880bfffcff8 R08: ffffffff842775d1 R09: 0000000000000000
R10: ffffed1007067160 R11: 0000000000000000 R12: 00000000ffffffec
R13: ceb3fe5867b5b00e R14: 0000000001e0cee1 R15: 0000000000000000
FS:  00007f6bd4cc4700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8880bfffd000 CR3: 000000003517b000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 lco_csum include/linux/skbuff.h:4662 [inline]
 gre_build_header+0x49d/0x880 include/net/gre.h:139
 __gre_xmit net/ipv4/ip_gre.c:467 [inline]
 ipgre_xmit+0x6ab/0x9e0 net/ipv4/ip_gre.c:653
 __netdev_start_xmit include/linux/netdevice.h:4944 [inline]
 netdev_start_xmit include/linux/netdevice.h:4958 [inline]
 xmit_one net/core/dev.c:3658 [inline]
 dev_hard_start_xmit+0x20b/0x450 net/core/dev.c:3674
 __dev_queue_xmit+0x1c40/0x3500 net/core/dev.c:4273
 packet_snd net/packet/af_packet.c:3016 [inline]
 packet_sendmsg+0x4cd4/0x66f0 net/packet/af_packet.c:3044
 sock_sendmsg_nosec net/socket.c:702 [inline]
 sock_sendmsg net/socket.c:722 [inline]
 kernel_sendmsg+0xf5/0x130 net/socket.c:742
 sock_no_sendpage+0x150/0x1b0 net/core/sock.c:2898
 kernel_sendpage+0x2ca/0x370 net/socket.c:3666
 sock_sendpage+0x7e/0xb0 net/socket.c:995
 pipe_to_sendpage+0x258/0x340 fs/splice.c:364
 splice_from_pipe_feed fs/splice.c:418 [inline]
 __splice_from_pipe+0x351/0x8b0 fs/splice.c:562
 splice_from_pipe fs/splice.c:597 [inline]
 generic_splice_sendpage+0x172/0x200 fs/splice.c:746
 do_splice_from fs/splice.c:767 [inline]
 do_splice+0x11e4/0x17c0 fs/splice.c:1079
 __do_splice fs/splice.c:1144 [inline]
 __do_sys_splice fs/splice.c:1350 [inline]
 __se_sys_splice+0x32c/0x430 fs/splice.c:1332
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x449009
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6bd4cc42e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 00000000004cf510 RCX: 0000000000449009
RDX: 0000000000000006 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00000000004cf51c R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000049e004
R13: 78902f0000000000 R14: 6d32cc5e8ead0600 R15: 00000000004cf518
Modules linked in:
CR2: ffff8880bfffd000
---[ end trace ff76c8da88e0ae91 ]---
RIP: 0010:do_csum arch/x86/lib/csum-partial_64.c:72 [inline]
RIP: 0010:csum_partial+0x184/0x470 arch/x86/lib/csum-partial_64.c:136
Code: 84 7c 00 00 00 41 ff ce 4c 89 f0 48 c1 e0 06 48 89 44 24 28 45 31 ff 48 8b 6c 24 08 66 2e 0f 1f 84 00 00 00 00 00 4c 03 6d 00 <4c> 13 6d 08 4c 13 6d 10 4c 13 6d 18 4c 13 6d 20 4c 13 6d 28 4c 13
RSP: 0018:ffffc9000203f050 EFLAGS: 00010282
RAX: ffffffff84277631 RBX: 000000001ffffffd RCX: ffff888031b08000
RDX: 0000000000000000 RSI: 0000000003ffffff RDI: 0000000000000000
RBP: ffff8880bfffcff8 R08: ffffffff842775d1 R09: 0000000000000000
R10: ffffed1007067160 R11: 0000000000000000 R12: 00000000ffffffec
R13: ceb3fe5867b5b00e R14: 0000000001e0cee1 R15: 0000000000000000
FS:  00007f6bd4cc4700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8880bfffd000 CR3: 000000003517b000 CR4: 00000000001506e0
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

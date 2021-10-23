Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787A8438502
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 21:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhJWThn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 15:37:43 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:50147 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhJWThj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 15:37:39 -0400
Received: by mail-il1-f198.google.com with SMTP id e10-20020a92194a000000b00258acd999afso4385633ilm.16
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 12:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nTKy/b1KEgyo1EeTP7Q3lB04zZjv6HkFcUrltUrjhvs=;
        b=yuvLdoAlakJZRcEB4GQ5+qSMO0GfJdFLXd5QOIAT20OwX3Yz2aQpBETYKndZEtw/VY
         52bU9xMN7gASlv5sdtjFca+Ugy2+52f0PFos6kKpk9tZ+B+oSa/2xhCLlyAQXTMrhhR1
         AtQLZmN3piuP3he96hHiJ8NYnIWeDHWY42KKABmmIZkNpP2D9ZuLf7olm5dzyDA0j3hj
         144+4fmcJrYJFK+vxWcmbGpN7/AnfKtCEWmd0Joadf2FF5b3bqdMITXmIW4FXxiNLZPh
         qkxSoo/F0uBRv/Ss1DEV9Bdzxak6ROYHYUokLLbhx4hKdM+Qjx2JXrPcEgTAerh1BfCZ
         IUJw==
X-Gm-Message-State: AOAM530BEvjEc5htrvoB7T43sfQp1FJysk1vrhMRwxbGasiGdvvFlekA
        KkmdF36KH96AUv3vjnR2n7uAJgUBF1hAMeDVOmuq0BDbG9jU
X-Google-Smtp-Source: ABdhPJwTsASnJUtJu6/m0KTF1qXMif/iV+YKRd289Nhhe4VX+V9dk8VgSpgnHF35tSxprZOEdq//emRWqAVpwkyyMWky8Qil1zRC
MIME-Version: 1.0
X-Received: by 2002:a05:6602:48c:: with SMTP id y12mr4807587iov.184.1635017719823;
 Sat, 23 Oct 2021 12:35:19 -0700 (PDT)
Date:   Sat, 23 Oct 2021 12:35:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064451505cf0a3aa2@google.com>
Subject: [syzbot] WARNING: refcount bug in memfd_secret
From:   syzbot <syzbot+75639e6a0331cd61d3e2@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, jordy@jordyzomer.github.io,
        jordy@pwning.systems, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9c0c4d24ac00 Merge tag 'block-5.15-2021-10-22' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=115a0328b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59f3ef2b4077575
dashboard link: https://syzkaller.appspot.com/bug?extid=75639e6a0331cd61d3e2
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a035c2b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ae869f300000

The issue was bisected to:

commit 110860541f443f950c1274f217a1a3e298670a33
Author: Jordy Zomer <jordy@jordyzomer.github.io>
Date:   Wed Sep 8 02:56:18 2021 +0000

    mm/secretmem: use refcount_t instead of atomic_t

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1433ea1cb00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1633ea1cb00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1233ea1cb00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+75639e6a0331cd61d3e2@syzkaller.appspotmail.com
Fixes: 110860541f44 ("mm/secretmem: use refcount_t instead of atomic_t")

------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 1 PID: 6529 at lib/refcount.c:25 refcount_warn_saturate+0x13d/0x1a0 lib/refcount.c:25
Modules linked in:
CPU: 1 PID: 6529 Comm: syz-executor563 Not tainted 5.15.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:refcount_warn_saturate+0x13d/0x1a0 lib/refcount.c:25
Code: c7 80 e1 b3 8a 31 c0 e8 31 8e 3b fd 0f 0b eb a3 e8 b8 79 71 fd c6 05 43 86 b6 09 01 48 c7 c7 e0 e1 b3 8a 31 c0 e8 13 8e 3b fd <0f> 0b eb 85 e8 9a 79 71 fd c6 05 26 86 b6 09 01 48 c7 c7 40 e2 b3
RSP: 0018:ffffc900012dfed0 EFLAGS: 00010246
RAX: f8bc46cda99bde00 RBX: 0000000000000002 RCX: ffff88801e03d580
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000002 R08: ffffffff81695fe2 R09: ffffed10173a57a8
R10: ffffed10173a57a8 R11: 0000000000000000 R12: ffff888078595180
R13: ffff88806f5e8030 R14: 0000000000000003 R15: dffffc0000000000
FS:  00005555558b2300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff91ea21000 CR3: 000000007077c000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __refcount_inc include/linux/refcount.h:250 [inline]
 refcount_inc include/linux/refcount.h:267 [inline]
 __do_sys_memfd_secret mm/secretmem.c:221 [inline]
 __se_sys_memfd_secret+0x2ea/0x350 mm/secretmem.c:194
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f09de6c7f79
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe81d58a98 EFLAGS: 00000246 ORIG_RAX: 00000000000001bf
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f09de6c7f79
RDX: 00007f09de68ae83 RSI: 0000000000000012 RDI: 0000000000000000
RBP: 00007f09de68bf60 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007f09de68bff0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

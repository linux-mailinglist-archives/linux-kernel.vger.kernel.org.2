Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C953BA76C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 07:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhGCFnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 01:43:50 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:56302 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhGCFnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 01:43:49 -0400
Received: by mail-io1-f72.google.com with SMTP id i13-20020a5d88cd0000b02904e5ab8bdc6cso8506250iol.22
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 22:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Xjufe8/uupoFVmY21qWlSTgp8wySY2FRac9z3X1dg2M=;
        b=MSefUGQ4xXoSR/m8aerrFqzJp7Psw5s97SJlO8YT8alPe5o/32JC+d/fIUR3fBCLLj
         dmdvadSMDk1m6Odq8aPWzvAjYjCeqBM8ARBqYsiqYPJk60yaXOK+Mm4ogPVx3JHoyt5r
         fVNh3gQLfEN73L0If/Qsld+D70Qh3GiuuTcvPxxH+FaxHYTEaA9ix9XPzEsPaSWN8iby
         4ZV+s2e+S9zx8COxPFkLCVsxBrO+KNQzcISdrZfOBo75S2CcbkkLkgTYn5xvTgGhfY48
         +fJcrdbxaTG9UIrrXUx+RERMgVWESQqzuhir1PAYZN1i2FX+uvN/YDjNg7eE6FzJRXVj
         H8iQ==
X-Gm-Message-State: AOAM533sjsBjb5cZWTScEw4pA6czixKQXuXuxu3eABG8Pa2nhLLtPVMY
        J1vSkLhWcSJTpUYhvG7HGux7gB13HCexV+AI4JvjVLRxpBtR
X-Google-Smtp-Source: ABdhPJyBRnciPv1NG7xfwO9BqI/DpEyU8Cq8H8+tMFgcY3CRTskWYCOzaqpOwJKI6155yjxPsscpSXoMOZrf0hHU1tI8KdgREr35
MIME-Version: 1.0
X-Received: by 2002:a92:de05:: with SMTP id x5mr2293951ilm.260.1625290875752;
 Fri, 02 Jul 2021 22:41:15 -0700 (PDT)
Date:   Fri, 02 Jul 2021 22:41:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004e5ec705c6318557@google.com>
Subject: [syzbot] general protection fault in legacy_parse_param
From:   syzbot <syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    62fb9874 Linux 5.13
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12ffa118300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=19404adbea015a58
dashboard link: https://syzkaller.appspot.com/bug?extid=d1e3b1d92d25abf97943
compiler:       Debian clang version 11.0.1-2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 20300 Comm: syz-executor.1 Not tainted 5.13.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:memchr+0x2f/0x70 lib/string.c:1054
Code: 41 54 53 48 89 d3 41 89 f7 45 31 f6 49 bc 00 00 00 00 00 fc ff df 0f 1f 44 00 00 48 85 db 74 3b 48 89 fd 48 89 f8 48 c1 e8 03 <42> 0f b6 04 20 84 c0 75 0f 48 ff cb 48 8d 7d 01 44 38 7d 00 75 db
RSP: 0018:ffffc90001dafd00 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000013 RCX: dffffc0000000000
RDX: 0000000000000013 RSI: 000000000000002c RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff81e171bf R09: ffffffff81e16f95
R10: 0000000000000002 R11: ffff88807e96b880 R12: dffffc0000000000
R13: ffff888020894000 R14: 0000000000000000 R15: 000000000000002c
FS:  00007fe01ae27700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005645a8 CR3: 0000000018afc000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 legacy_parse_param+0x461/0x7e0 fs/fs_context.c:537
 vfs_parse_fs_param+0x1e5/0x460 fs/fs_context.c:117
 vfs_fsconfig_locked fs/fsopen.c:265 [inline]
 __do_sys_fsconfig fs/fsopen.c:439 [inline]
 __se_sys_fsconfig+0xba9/0xff0 fs/fsopen.c:314
 do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665d9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe01ae27188 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665d9
RDX: 00000000200002c0 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 00000000004bfcb9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000020000300 R11: 0000000000000246 R12: 000000000056bf80
R13: 00007ffd4bb7c5bf R14: 00007fe01ae27300 R15: 0000000000022000
Modules linked in:
---[ end trace 5d7119165725bd63 ]---
RIP: 0010:memchr+0x2f/0x70 lib/string.c:1054
Code: 41 54 53 48 89 d3 41 89 f7 45 31 f6 49 bc 00 00 00 00 00 fc ff df 0f 1f 44 00 00 48 85 db 74 3b 48 89 fd 48 89 f8 48 c1 e8 03 <42> 0f b6 04 20 84 c0 75 0f 48 ff cb 48 8d 7d 01 44 38 7d 00 75 db
RSP: 0018:ffffc90001dafd00 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000013 RCX: dffffc0000000000
RDX: 0000000000000013 RSI: 000000000000002c RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff81e171bf R09: ffffffff81e16f95
R10: 0000000000000002 R11: ffff88807e96b880 R12: dffffc0000000000
R13: ffff888020894000 R14: 0000000000000000 R15: 000000000000002c
FS:  00007fe01ae27700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004e4da0 CR3: 0000000018afc000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

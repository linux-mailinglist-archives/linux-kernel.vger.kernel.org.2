Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7E13FDD4B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 15:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243667AbhIAN1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 09:27:20 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:54060 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbhIAN1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 09:27:19 -0400
Received: by mail-io1-f70.google.com with SMTP id n189-20020a6b8bc6000000b005b92c64b625so1614885iod.20
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 06:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=97OI2aiCfZTzehYBVPUAfTzBWyV58rvy2rJKLAtYCmg=;
        b=IufRBlcrI6mtmtMPq8lfBZb8bueK+tlRKHzRjsJFCnRF1EULQMFmDrrXyLt8Tg+yF9
         neVsmFkd40HfmuVoxCCvMu921I7FzsMQOhyBoYpGfRwzb6orHc0C6TqHbgc5nvy2SXrS
         BZsJ95RuFvsZYmUDhpgqXg38WOtAEyk5Y8mlbl1AeVOU7r1s0kJKD2KJhR2RpaSgI8hL
         I7h+SFMROc4KYNmoRCohcqu6AVRCLbgD+hSY2CcFsCWR5p4C51ioA2yX2JaIlXz4pldT
         /1of2hvbQUh5Z5r4VMBAXMNOM+zdNHQpNV3GosQ4Bdb+8qTKj+44I/wj2EatZisYrt/A
         hIkw==
X-Gm-Message-State: AOAM530iu8isiHKSL/DBRvk4WvTzGBokcoF3DxByyWHqyEQYIALJMEqU
        sR7q5ZMPzqBzucbnkuPW7ibIIpglVIneNyyqTv5BXWur1s0q
X-Google-Smtp-Source: ABdhPJzSAk8Kfq0gWWvRwJUKa9vnT89L8mpTY0XZzH1G1LXmUzYMN2BjSJEV5Tp8QZFRnURnGeBLnLB0fUdUN3ZHcIS0/WPT6P4x
MIME-Version: 1.0
X-Received: by 2002:a02:9082:: with SMTP id x2mr7929307jaf.44.1630502782717;
 Wed, 01 Sep 2021 06:26:22 -0700 (PDT)
Date:   Wed, 01 Sep 2021 06:26:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002b577805caef03d8@google.com>
Subject: [syzbot] WARNING in futex_requeue
From:   syzbot <syzbot+4d1bd0725ef09168e1a0@syzkaller.appspotmail.com>
To:     dave@stgolabs.net, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b91db6a0b52e Merge tag 'for-5.15/io_uring-vfs-2021-08-30' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17907235300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=961d30359ac81f8c
dashboard link: https://syzkaller.appspot.com/bug?extid=4d1bd0725ef09168e1a0
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1222185d300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4d1bd0725ef09168e1a0@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5701 at kernel/futex.c:2259 futex_requeue+0x1467/0x2d50 kernel/futex.c:2259
Modules linked in:
CPU: 1 PID: 5701 Comm: syz-executor.0 Not tainted 5.14.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:futex_requeue+0x1467/0x2d50 kernel/futex.c:2259
Code: 02 00 00 4c 8d 84 24 90 02 00 00 e8 63 6a 00 00 41 89 c7 31 ff 89 c6 e8 a7 4d 0c 00 45 85 ff 0f 84 d8 13 00 00 e8 89 49 0c 00 <0f> 0b eb 05 e8 80 49 0c 00 4c 89 fb 89 df 48 c7 c6 70 7c 73 8c e8
RSP: 0018:ffffc90001d5f640 EFLAGS: 00010293
RAX: ffffffff8174a337 RBX: 0000000000000df3 RCX: ffff888020e7b880
RDX: 0000000000000000 RSI: 00000000fffffffd RDI: 0000000000000000
RBP: ffffc90001d5f948 R08: ffffffff8174a329 R09: ffffed1005174a9e
R10: ffffed1005174a9e R11: 0000000000000000 R12: 0000000020048000
R13: dffffc0000000000 R14: 0000000000000000 R15: 00000000fffffffd
FS:  00007f4d7080c700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd72dab690 CR3: 000000001cf4d000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 do_futex+0x1b87/0x32b0 kernel/futex.c:3958
 __do_sys_futex kernel/futex.c:4009 [inline]
 __se_sys_futex+0x11c/0x4d0 kernel/futex.c:3990
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665f9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4d7080c188 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 000000000056c038 RCX: 00000000004665f9
RDX: 0000000000000001 RSI: 000000000000000c RDI: 000000002000cffc
RBP: 00000000004bfcc4 R08: 0000000020048000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056c038
R13: 00007fff6069004f R14: 00007f4d7080c300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

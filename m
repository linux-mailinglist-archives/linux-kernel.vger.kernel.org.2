Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC24B3B0D1F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 20:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhFVSqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 14:46:39 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:46673 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhFVSqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:46:37 -0400
Received: by mail-il1-f199.google.com with SMTP id q1-20020a92c0010000b02901ee39382336so123394ild.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 11:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=XbJKQt+JEqzoDQtvWUup1LTFuTo83jHaXQJMxx3ieyU=;
        b=gqKy4B3Ac8AMG93b0qLr5XCt1nxdcA1zHlI9YNEPyuMYhQHDlJId60rhNqr4U2oaf1
         ik57EoLBPiK42igaGFLg85KoQKLVqKrFDCCEwdPA5rgn9NynRgv0C2YLM9VWe5O9cbG/
         mrumwlbsF+Nie81sl3R0mXn82ePm7btszOouyLegzvDlGrIImzXy7cbcD6hfNAVLLwD4
         6FMXNuJC6auDxVpYp8Wd6E8OcgON8Sl1SVClPpVQJnAeQkY/JiWleHZV7pKHgaVZRbpo
         jPZ+GLE94dKUOCfsd8ZRmMzjZ+sVtUQBWWwBQMrWCcIrONBVXgoRKhDFV3CcA5HvWa/2
         +oRQ==
X-Gm-Message-State: AOAM5324ZL2l5ew9LSi88pupdoGu7eFmfXf/usvNmQVP+07gMiWCFFxt
        gLJyMMvWwLlS/1X/ewwp7/6K+00ipgUvQexRJrpi3DzDLs0d
X-Google-Smtp-Source: ABdhPJy3SiptAqisIOBRcFw+grWHGpcc63LULRkdnOqKur11R5Cte2dm6RFM/d8eoH7KACnpVzpf3sJ8/au78f6wtrYfmuCmYMfy
MIME-Version: 1.0
X-Received: by 2002:a5d:9549:: with SMTP id a9mr3890567ios.152.1624387461060;
 Tue, 22 Jun 2021 11:44:21 -0700 (PDT)
Date:   Tue, 22 Jun 2021 11:44:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000981c1f05c55f2db8@google.com>
Subject: [syzbot] BUG: corrupted list in kobject_add_internal (3)
From:   syzbot <syzbot+66264bf2fd0476be7e6c@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a1f92694 Add linux-next specific files for 20210518
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13c97d6fd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d612e75ffd53a6d3
dashboard link: https://syzkaller.appspot.com/bug?extid=66264bf2fd0476be7e6c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1369f4d7d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16027cd7d00000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12359310300000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11359310300000
console output: https://syzkaller.appspot.com/x/log.txt?x=16359310300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+66264bf2fd0476be7e6c@syzkaller.appspotmail.com

list_add double add: new=ffff88802037a420, prev=ffff88802037a420, next=ffff8881400e1000.
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:29!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8479 Comm: kworker/u5:4 Not tainted 5.13.0-rc2-next-20210518-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: hci5 hci_rx_work
RIP: 0010:__list_add_valid.cold+0x26/0x3c lib/list_debug.c:29
Code: 68 f3 eb fa 4c 89 e1 48 c7 c7 e0 1c e3 89 e8 aa 88 f2 ff 0f 0b 48 89 f2 4c 89 e1 48 89 ee 48 c7 c7 20 1e e3 89 e8 93 88 f2 ff <0f> 0b 48 89 f1 48 c7 c7 a0 1d e3 89 4c 89 e6 e8 7f 88 f2 ff 0f 0b
RSP: 0018:ffffc9000181f7d8 EFLAGS: 00010286
RAX: 0000000000000058 RBX: ffff8881400e1000 RCX: 0000000000000000
RDX: ffff88801f295580 RSI: ffffffff815dbea5 RDI: fffff52000303eed
RBP: ffff88802037a420 R08: 0000000000000058 R09: 0000000000000000
R10: ffffffff815d5cee R11: 0000000000000000 R12: ffff8881400e1000
R13: ffff8880198b1340 R14: ffff88802037a438 R15: ffff88802037a420
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000001f16748 CR3: 0000000027b36000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __list_add include/linux/list.h:67 [inline]
 list_add_tail include/linux/list.h:100 [inline]
 kobj_kset_join lib/kobject.c:196 [inline]
 kobject_add_internal+0x18d/0xa60 lib/kobject.c:246
 kobject_add_varg lib/kobject.c:390 [inline]
 kobject_add+0x150/0x1c0 lib/kobject.c:442
 device_add+0x36a/0x2100 drivers/base/core.c:3253
 hci_conn_add_sysfs+0x97/0x190 net/bluetooth/hci_sysfs.c:53
 hci_sync_conn_complete_evt.isra.0+0x54a/0x810 net/bluetooth/hci_event.c:4390
 hci_event_packet+0xf32/0x7c50 net/bluetooth/hci_event.c:6278
 hci_rx_work+0x4f8/0xd30 net/bluetooth/hci_core.c:5115
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Modules linked in:
---[ end trace 47d0cc8ab1bc8524 ]---
RIP: 0010:__list_add_valid.cold+0x26/0x3c lib/list_debug.c:29
Code: 68 f3 eb fa 4c 89 e1 48 c7 c7 e0 1c e3 89 e8 aa 88 f2 ff 0f 0b 48 89 f2 4c 89 e1 48 89 ee 48 c7 c7 20 1e e3 89 e8 93 88 f2 ff <0f> 0b 48 89 f1 48 c7 c7 a0 1d e3 89 4c 89 e6 e8 7f 88 f2 ff 0f 0b
RSP: 0018:ffffc9000181f7d8 EFLAGS: 00010286
RAX: 0000000000000058 RBX: ffff8881400e1000 RCX: 0000000000000000
RDX: ffff88801f295580 RSI: ffffffff815dbea5 RDI: fffff52000303eed
RBP: ffff88802037a420 R08: 0000000000000058 R09: 0000000000000000
R10: ffffffff815d5cee R11: 0000000000000000 R12: ffff8881400e1000
R13: ffff8880198b1340 R14: ffff88802037a438 R15: ffff88802037a420
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000001f16748 CR3: 000000000be8e000 CR4: 00000000001506e0
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

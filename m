Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D46359EAD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbhDIM3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:29:36 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:56906 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhDIM3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:29:35 -0400
Received: by mail-io1-f71.google.com with SMTP id y2so3616556ioa.23
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 05:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wFUjyFhof0Q99hIyHOKNxCnr0E7EoD9RhMCv37pZg4w=;
        b=owulVB/QJDUyYL6ZGL2nIRdlL3PT0fsKpSex6CRof9yHY41FgeTUQT2ITGgdaKMDzP
         h7lqWlBqPOQ7xrasmfBgtN0uX9Tb/HpD7zL+gqX1AJDCC8g+BdXpd6HVQ8gDm/808U6v
         pzIYP9qqTEi+Y843I2RbDqtkInoAREH/Ahd0QvSlVmtjFlWbS02rDjyZU9LNIGJftA4y
         qdQRrlTlNiKrGJ4TOcptLMSBLOpT8oZCmSaP5LZ4jw1jWr3K/OCgG56B1rRBE7JD+Nmv
         NT4HEaeYDmhsp8j5BPjVdLxSdrTauRe4FCygYP9Lqx8Dwn/rLze1Um60NkCiX98StrAl
         9LwQ==
X-Gm-Message-State: AOAM530cNQnsbxHqS15kMvYdNTA6XgvLOrUssnhH6hcOigiVPXfDhtsG
        KsJ4I/EK2Sn2jX+dU4As9ExiPuMjdxqRVrl/lL2CXaMrt3xH
X-Google-Smtp-Source: ABdhPJxETWL5wfv+6yUQ8f4AWmI7OBbO148Z8gFxuMLD+YKpAwpWWwnA+FJY3eszjXSQFc0x2+tAQfFk/zBSIrJwlVubhP7FX6B6
MIME-Version: 1.0
X-Received: by 2002:a6b:d80d:: with SMTP id y13mr11380488iob.75.1617971361916;
 Fri, 09 Apr 2021 05:29:21 -0700 (PDT)
Date:   Fri, 09 Apr 2021 05:29:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000048ab2905bf8950b4@google.com>
Subject: [syzbot] BUG: corrupted list in klist_dec_and_del
From:   syzbot <syzbot+f9f9397a8879e0b3cecc@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e49d033b Linux 5.12-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=167accfcd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f91155ccddaf919c
dashboard link: https://syzkaller.appspot.com/bug?extid=f9f9397a8879e0b3cecc
compiler:       Debian clang version 11.0.1-2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14981316d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=104fcc6ad00000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13882a36d00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10482a36d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=17882a36d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f9f9397a8879e0b3cecc@syzkaller.appspotmail.com

IPVS: ftp: loaded support on port[0] = 21
list_del corruption. prev->next should be ffff888018a74c68, but was ffff88801263b440
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:53!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8361 Comm: syz-executor523 Not tainted 5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__list_del_entry_valid+0xe1/0x100 lib/list_debug.c:51
Code: 72 b0 87 fd 0f 0b 48 c7 c7 80 a0 11 8a 4c 89 f6 31 c0 e8 5f b0 87 fd 0f 0b 48 c7 c7 e0 a0 11 8a 4c 89 f6 31 c0 e8 4c b0 87 fd <0f> 0b 48 c7 c7 40 a1 11 8a 4c 89 f6 31 c0 e8 39 b0 87 fd 0f 0b 66
RSP: 0000:ffffc900010bf9c8 EFLAGS: 00010246
RAX: 0000000000000054 RBX: ffff88801191b468 RCX: ae24f9509f195200
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8160b612 R09: ffffed1017385fe8
R10: ffffed1017385fe8 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff888018a74c68 R14: ffff888018a74c68 R15: ffff88801191b468
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9f12a2cbb0 CR3: 00000000213fc000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __list_del_entry include/linux/list.h:132 [inline]
 list_del include/linux/list.h:146 [inline]
 klist_release lib/klist.c:189 [inline]
 kref_put include/linux/kref.h:65 [inline]
 klist_dec_and_del+0x9c/0x430 lib/klist.c:206
 klist_put lib/klist.c:217 [inline]
 klist_del+0xa0/0x100 lib/klist.c:230
 device_del+0x29e/0xa90 drivers/base/core.c:3400
 hci_conn_del_sysfs+0xeb/0x190 net/bluetooth/hci_sysfs.c:78
 hci_conn_cleanup+0x495/0x640 net/bluetooth/hci_conn.c:138
 hci_conn_del+0x2ae/0x3b0 net/bluetooth/hci_conn.c:678
 hci_conn_hash_flush+0x1bd/0x240 net/bluetooth/hci_conn.c:1599
 hci_dev_do_close+0xa04/0xfe0 net/bluetooth/hci_core.c:1778
 hci_unregister_dev+0x301/0x18a0 net/bluetooth/hci_core.c:3989
 vhci_release+0x73/0xc0 drivers/bluetooth/hci_vhci.c:340
 __fput+0x352/0x7b0 fs/file_table.c:280
 task_work_run+0x146/0x1c0 kernel/task_work.c:140
 exit_task_work include/linux/task_work.h:30 [inline]
 do_exit+0x6b2/0x2290 kernel/exit.c:825
 do_group_exit+0x168/0x2d0 kernel/exit.c:922
 __do_sys_exit_group+0x13/0x20 kernel/exit.c:933
 __se_sys_exit_group+0x10/0x10 kernel/exit.c:931
 __x64_sys_exit_group+0x37/0x40 kernel/exit.c:931
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4443c9
Code: Unable to access opcode bytes at RIP 0x44439f.
RSP: 002b:00007ffff06d1d58 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00000000004cb370 RCX: 00000000004443c9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffffffffffb8 R09: 000000ff004c5fe0
R10: 00007ffff06d1820 R11: 0000000000000246 R12: 00000000004cb370
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
Modules linked in:
---[ end trace d8c06b4c2761f315 ]---
RIP: 0010:__list_del_entry_valid+0xe1/0x100 lib/list_debug.c:51
Code: 72 b0 87 fd 0f 0b 48 c7 c7 80 a0 11 8a 4c 89 f6 31 c0 e8 5f b0 87 fd 0f 0b 48 c7 c7 e0 a0 11 8a 4c 89 f6 31 c0 e8 4c b0 87 fd <0f> 0b 48 c7 c7 40 a1 11 8a 4c 89 f6 31 c0 e8 39 b0 87 fd 0f 0b 66
RSP: 0000:ffffc900010bf9c8 EFLAGS: 00010246
RAX: 0000000000000054 RBX: ffff88801191b468 RCX: ae24f9509f195200
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8160b612 R09: ffffed1017385fe8
R10: ffffed1017385fe8 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff888018a74c68 R14: ffff888018a74c68 R15: ffff88801191b468
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9f12a2cbb0 CR3: 000000000c48e000 CR4: 00000000001506f0
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

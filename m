Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98A0351187
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbhDAJJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:09:26 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:45280 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbhDAJJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:09:21 -0400
Received: by mail-il1-f198.google.com with SMTP id x7so3396016ilp.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=lblrzUsrvnZeE7d7MAFI+fm3G5rXT2J0duSM9MznKBw=;
        b=SAFPHBrFQgmHhlYZw5WJX8opQ4hxYvoO6jWlPgoztslkL0xfE4fv/6xWcNOK2gwOKo
         5qFBm9m9NyQcN/9xCFDtWrpatIyFA39xQukw8jmL79Klv+dgjCDH/ofXw7OEhrt869B8
         T1D+3cnnZ7ClEH9hw0Pbt0F4MS4uvYrlJWV9SFhNwRGI2GSkaDUQHnCfbRw/nSeLJy9e
         r+hHfPp31h7L5armOTEwdbGhRdpVsbD/5EC0mxbDT6VFPbLuzRRIe/PInRmu26qCBF2R
         8gSlpd0TTsYKG9Wd/uqPrLNkADs5nu/A1dUlqcG7oDDDJ1KlWcOEbZbJZGs+gaTtuj3T
         d0Ew==
X-Gm-Message-State: AOAM533HI3jO9CrIiUXn4C5Tq9z10fLTZPs3hilkQvUzHnzec4oT7Kn4
        ++Qr7cdGJa1Dz7TVwfjXmadZP6/oRafDwsFiLXbCYiMw2+K3
X-Google-Smtp-Source: ABdhPJw/EU4plDqg66CKGgDBKJkmoL4LqfzDWDi0iro96kig9lQTtCjaeeUiqP4t8r3l1/qm34BsRPkUFXUaCU4lF5s/2x2GTSb7
MIME-Version: 1.0
X-Received: by 2002:a02:971a:: with SMTP id x26mr6848162jai.61.1617268160745;
 Thu, 01 Apr 2021 02:09:20 -0700 (PDT)
Date:   Thu, 01 Apr 2021 02:09:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a565e05bee596f2@google.com>
Subject: [syzbot] WARNING in mntput_no_expire (2)
From:   syzbot <syzbot+c88a7030da47945a3cc3@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d19cc4bf Merge tag 'trace-v5.12-rc5' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1018f281d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1a3d65a48dbd1bc
dashboard link: https://syzkaller.appspot.com/bug?extid=c88a7030da47945a3cc3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f50d11d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137694a1d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c88a7030da47945a3cc3@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8409 at fs/namespace.c:1186 mntput_no_expire+0xaca/0xcb0 fs/namespace.c:1186
Modules linked in:
CPU: 1 PID: 8409 Comm: syz-executor035 Not tainted 5.12.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:mntput_no_expire+0xaca/0xcb0 fs/namespace.c:1186
Code: ff 48 c7 c2 e0 cb 78 89 be c2 02 00 00 48 c7 c7 a0 cb 78 89 c6 05 e5 6d e5 0b 01 e8 ff e1 f6 06 e9 3f fd ff ff e8 c6 a5 a8 ff <0f> 0b e9 fc fc ff ff e8 ba a5 a8 ff e8 55 dc 94 ff 31 ff 89 c5 89
RSP: 0018:ffffc9000165fc78 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 1ffff920002cbf95 RCX: 0000000000000000
RDX: ffff88802072d4c0 RSI: ffffffff81cb4b8a RDI: 0000000000000003
RBP: ffff888011656900 R08: 0000000000000000 R09: ffffffff8fa978af
R10: ffffffff81cb4884 R11: 0000000000000000 R12: 0000000000000008
R13: ffffc9000165fcc8 R14: dffffc0000000000 R15: 00000000ffffffff
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055a722053160 CR3: 000000000bc8e000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 mntput fs/namespace.c:1232 [inline]
 cleanup_mnt+0x523/0x530 fs/namespace.c:1132
 task_work_run+0xdd/0x1a0 kernel/task_work.c:140
 exit_task_work include/linux/task_work.h:30 [inline]
 do_exit+0xbfc/0x2a60 kernel/exit.c:825
 do_group_exit+0x125/0x310 kernel/exit.c:922
 __do_sys_exit_group kernel/exit.c:933 [inline]
 __se_sys_exit_group kernel/exit.c:931 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:931
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x446af9
Code: Unable to access opcode bytes at RIP 0x446acf.
RSP: 002b:00000000005dfe48 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00000000004ce450 RCX: 0000000000446af9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffffffffffbc R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004ce450
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

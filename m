Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E464D3955D1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 09:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhEaHPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 03:15:14 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:34507 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhEaHPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 03:15:02 -0400
Received: by mail-io1-f69.google.com with SMTP id i13-20020a5d9e4d0000b0290497b9f55318so967181ioi.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 00:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=atZnnwuSSB/aNkrcLst1qeZwbrR7f9UeO1phz8QNpwE=;
        b=VbAuNquCkBJTdAvsgbM2hp3jOpmN3j9v8ufOL3GIOqbGEPzCnqylZsPiMCNzi2mEmS
         K5zwdWY1vizMwvpuRugBPMf/xOFzntL4E0yxgbURyucxoiaHhAlSYrosxkCcktQiIzuW
         lhKLhS7gVX0Bfenb4ETqLx7SHSJ5Kvq+80eRM/lXiy+VqjodNYwZt4pinrkVr8oEjEkx
         BRCFKz8hlBWywhEiUa8J2vKdl3uL38TbN/bz3n5tPUYFCQsWhj9lRCJIHlqjqAp9dO2F
         3mqhUOC6JRCQ6dKE4fYrmZ+z5JhcAVim2Msjq36dzqXGcjGdJDS6pFdYhAcim11ldTY6
         7BsA==
X-Gm-Message-State: AOAM532CIx4YLfOhIhZOUcMJsubqOZzBvTm071TvFAPrz03rnbTJSVyi
        lga6EWlsk099b6GXin+oA9AQbEy3ItBqfAB9MG1NAhU6GQ+E
X-Google-Smtp-Source: ABdhPJwNLgs/nZ7rcu3+6n3VkwPfpmac5r8gjOCJKck2wK9dal6zMltI8wLooodq4Bb3nN3UXD0J0/3gFtVzwbiUz+toCqkrJYzW
MIME-Version: 1.0
X-Received: by 2002:a6b:3b4c:: with SMTP id i73mr15943275ioa.149.1622445202582;
 Mon, 31 May 2021 00:13:22 -0700 (PDT)
Date:   Mon, 31 May 2021 00:13:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f7b23005c39af5c1@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in
 drm_fb_helper_damage_work (2)
From:   syzbot <syzbot+545dc60af42828d1e70b@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7ac3a1c1 Merge tag 'mtd/fixes-for-5.13-rc4' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1619b4b5d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=266cda122a0b56c
dashboard link: https://syzkaller.appspot.com/bug?extid=545dc60af42828d1e70b
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+545dc60af42828d1e70b@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffffc9000dc68008
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 11000067 P4D 11000067 PUD 111b3067 PMD 1ba2c067 PTE 0
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 2 PID: 16890 Comm: kworker/2:36 Not tainted 5.13.0-rc3-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: events drm_fb_helper_damage_work
RIP: 0010:rep_movs arch/x86/lib/iomem.c:12 [inline]
RIP: 0010:memcpy_toio+0x83/0xe0 arch/x86/lib/iomem.c:57
Code: 8c fd 49 89 dd 31 ff 41 83 e5 02 4c 89 ee e8 c4 c2 8c fd 4d 85 ed 75 2e e8 9a ba 8c fd 48 89 e9 48 89 df 4c 89 e6 48 c1 e9 02 <f3> a5 40 f6 c5 02 74 02 66 a5 40 f6 c5 01 74 01 a4 5b 5d 41 5c 41
RSP: 0018:ffffc9000e73fbc8 EFLAGS: 00010202
RAX: 0000000000000000 RBX: ffffc9000dc68008 RCX: 00000000000000fe
RDX: ffff888015340000 RSI: ffffc9000bdd9008 RDI: ffffc9000dc68008
RBP: 00000000000003f8 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff83e81e1c R11: 0000000000000000 R12: ffffc9000bdd9008
R13: 0000000000000000 R14: ffffc9000bdd9008 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000dc68008 CR3: 000000006c062000 CR4: 0000000000152ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 dma_buf_map_memcpy_to include/linux/dma-buf-map.h:245 [inline]
 drm_fb_helper_damage_blit_real drivers/gpu/drm/drm_fb_helper.c:388 [inline]
 drm_fb_helper_damage_blit drivers/gpu/drm/drm_fb_helper.c:419 [inline]
 drm_fb_helper_damage_work+0x733/0xac0 drivers/gpu/drm/drm_fb_helper.c:450
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2276
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2422
 kthread+0x3b1/0x4a0 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Modules linked in:
CR2: ffffc9000dc68008
---[ end trace 7f8625a9b15be223 ]---
RIP: 0010:rep_movs arch/x86/lib/iomem.c:12 [inline]
RIP: 0010:memcpy_toio+0x83/0xe0 arch/x86/lib/iomem.c:57
Code: 8c fd 49 89 dd 31 ff 41 83 e5 02 4c 89 ee e8 c4 c2 8c fd 4d 85 ed 75 2e e8 9a ba 8c fd 48 89 e9 48 89 df 4c 89 e6 48 c1 e9 02 <f3> a5 40 f6 c5 02 74 02 66 a5 40 f6 c5 01 74 01 a4 5b 5d 41 5c 41
RSP: 0018:ffffc9000e73fbc8 EFLAGS: 00010202
RAX: 0000000000000000 RBX: ffffc9000dc68008 RCX: 00000000000000fe
RDX: ffff888015340000 RSI: ffffc9000bdd9008 RDI: ffffc9000dc68008
RBP: 00000000000003f8 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff83e81e1c R11: 0000000000000000 R12: ffffc9000bdd9008
R13: 0000000000000000 R14: ffffc9000bdd9008 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000dc68008 CR3: 000000006c062000 CR4: 0000000000152ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

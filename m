Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4FF382B44
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 13:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbhEQLiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 07:38:46 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:51973 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236827AbhEQLij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 07:38:39 -0400
Received: by mail-io1-f72.google.com with SMTP id h7-20020a5d9e070000b029041a1f6bccc8so3068883ioh.18
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 04:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=uJypXfcIh2pxPc/qA3hgx74dyrY/++HWKDlgAb2tH8Y=;
        b=Gbe7w277D7Vo6C8OWk+Zsd53PIThqshKhJc/GoANRm4tfp3Aut3fJc4XCcUB12UWZD
         01K+QFCRO/Gxy7lPKhFxhdTnNzolqLnyhatH/ei7kueMIyceFRhNizEl/ynKXDEvar4t
         ZMNrsCqYmZnH3eUl1JXcD3P5Dk7xvLB+XsH9qnbX6GB2qQ+4vlER4hOrA1xwLEsVnB/2
         uz5TwC0W7vMwLbmQa3Y7GT498z+lsUDAvzxCLyxFzGnilL29fSfLeO6FaGtxmkO6BKHn
         OE+mk5GCR4LVr8NZ6HeksJBudRAL31q1UZHIWP5Teqz+rDyU3a0BRS+ErYcVwTUnta3D
         CYZg==
X-Gm-Message-State: AOAM530yuFL8e/jiUp2L62MBC6bA9DbdgXDUQgAuEDtxV+hmPNEUnf18
        eOo0PUrG/dmlhEsjPRPS/CQdZAQvTkRAQmC4T6gBaIiB2fNr
X-Google-Smtp-Source: ABdhPJwIIcfn4UbpLgnnkNAJKw1cQKM8w8vu1f5LT70yl9QlFFVe/PyC4G7pDE9wddj7Yt7dQ26+sAZyNCO3+5pHk+41g7pCrwE+
MIME-Version: 1.0
X-Received: by 2002:a6b:b48d:: with SMTP id d135mr44797043iof.107.1621251441863;
 Mon, 17 May 2021 04:37:21 -0700 (PDT)
Date:   Mon, 17 May 2021 04:37:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000048af8c05c2850418@google.com>
Subject: [syzbot] WARNING in i2cdev_detach_adapter
From:   syzbot <syzbot+8c9d567bbd8a4ed98b55@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e77a830c Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=119458aed00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0a6882014fd3d45
dashboard link: https://syzkaller.appspot.com/bug?extid=8c9d567bbd8a4ed98b55
compiler:       Debian clang version 11.0.1-2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=166354cdd00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b89bbdd00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8c9d567bbd8a4ed98b55@syzkaller.appspotmail.com

pvrusb2: Attached sub-driver cx25840
pvrusb2: ***WARNING*** pvrusb2 device hardware appears to be jammed and I can't clear it.
pvrusb2: You might need to power cycle the pvrusb2 device in order to recover.
------------[ cut here ]------------
sysfs group 'power' not found for kobject 'i2c-1'
WARNING: CPU: 1 PID: 3952 at fs/sysfs/group.c:281 sysfs_remove_group+0x16e/0x280 fs/sysfs/group.c:279
Modules linked in:
CPU: 1 PID: 3952 Comm: pvrusb2-context Not tainted 5.12.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:sysfs_remove_group+0x16e/0x280 fs/sysfs/group.c:279
Code: 89 e0 48 c1 e8 03 42 80 3c 28 00 74 08 4c 89 e7 e8 57 da c8 ff 49 8b 14 24 48 c7 c7 c0 1b 22 8a 4c 89 f6 31 c0 e8 32 bc 4e ff <0f> 0b 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 a0 59 82 ff 49 8d 5e 20
RSP: 0018:ffffc9000307f988 EFLAGS: 00010246
RAX: b99ebc47a3964000 RBX: ffff88802fb9e048 RCX: ffff88801def9c40
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 1ffffffff1519c68 R08: ffffffff8164f2f2 R09: ffffed10173a3f1c
R10: ffffed10173a3f1c R11: 0000000000000000 R12: ffff88802fb9e018
R13: dffffc0000000000 R14: ffffffff8a8ce300 R15: ffff888013f9b488
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007efda09df018 CR3: 0000000025e72000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 device_del+0x2ed/0xc10 drivers/base/core.c:3398
 cdev_device_del+0x22/0xe0 fs/char_dev.c:573
 put_i2c_dev drivers/i2c/i2c-dev.c:93 [inline]
 i2cdev_detach_adapter+0x24f/0x2c0 drivers/i2c/i2c-dev.c:689
 i2cdev_notifier_call+0x38/0x60 drivers/i2c/i2c-dev.c:704
 notifier_call_chain kernel/notifier.c:83 [inline]
 blocking_notifier_call_chain+0x108/0x1b0 kernel/notifier.c:337
 device_del+0x2de/0xc10 drivers/base/core.c:3395
 device_unregister+0x1a/0xc0 drivers/base/core.c:3454
 i2c_del_adapter+0x370/0x7f0 drivers/i2c/i2c-core-base.c:1693
 pvr2_i2c_core_done+0x55/0xb0 drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c:652
 pvr2_hdw_destroy+0x150/0x2b0 drivers/media/usb/pvrusb2/pvrusb2-hdw.c:2679
 pvr2_context_destroy+0x7a/0x3c0 drivers/media/usb/pvrusb2/pvrusb2-context.c:70
 pvr2_context_check drivers/media/usb/pvrusb2/pvrusb2-context.c:137 [inline]
 pvr2_context_thread_func+0x41d/0xb30 drivers/media/usb/pvrusb2/pvrusb2-context.c:158
 kthread+0x39a/0x3c0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

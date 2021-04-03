Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63543353426
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 15:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbhDCNd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 09:33:27 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:56353 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhDCNd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 09:33:26 -0400
Received: by mail-io1-f69.google.com with SMTP id y2so8021058ioa.23
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 06:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0Yrrdrc7Xyc8EKXZ2srufZwz7LRa+7Ezw+JRKNnRmss=;
        b=rqUez4u2TvTZQNOz3SkM3bCH6RZKcRy9pWHunVoSQO+9NLEXYA/qIZUUVR9FXwbNsl
         /65PLTkmRsLKQidVv0oVeq0RFHzxxqrzHXAWwlePd2frlr/vYszOp7oFxzgYcsn89DgB
         HR85Na9k7TipyRirMJpHdWqYwgbj9ww4ZSln60bEcab1uOkm95axL/FPrbZ0jOznqjvQ
         QhQbDwZ2zbtKbj+8XEPxVRk8J8dLV5a8J9S87qwIuLct3bYuBX7d9jcHbzhGRx1ecsqS
         GpqXHo13uXzvlGRLA1rXWEOJOi+6LNrCLS9bVqcM5vwXJdgYgsfYF91JNQs5LpHRyw6/
         Y4pw==
X-Gm-Message-State: AOAM5326HZRpnPEeWmMMp80XbInXpH55MOsCBEHoq1iDR0OHYM0NZJlj
        K5BMbkQ1fdsj3/yTLjVOA/3f6MZCAQVk7Pu3QRTA3fRad6Ef
X-Google-Smtp-Source: ABdhPJyqLb3L3ut9C0CWmZwSTwEEEXgT7pEJxpUcoIxUflJ/X+U8EATX/ymGFRJjUFL4WZ1idbFDS9GRm78Jfejy4xEZ84FBDAqz
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d04:: with SMTP id c4mr14737840iow.182.1617456802051;
 Sat, 03 Apr 2021 06:33:22 -0700 (PDT)
Date:   Sat, 03 Apr 2021 06:33:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020424005bf118296@google.com>
Subject: [syzbot] WARNING in fw_load_sysfs_fallback
From:   syzbot <syzbot+b064fbd5fc8b2cfae49d@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1e43c377 Merge tag 'xtensa-20210329' of git://github.com/j..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=105dc64ad00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=71a75beb62b62a34
dashboard link: https://syzkaller.appspot.com/bug?extid=b064fbd5fc8b2cfae49d
compiler:       Debian clang version 11.0.1-2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b064fbd5fc8b2cfae49d@syzkaller.appspotmail.com

------------[ cut here ]------------
sysfs group 'power' not found for kobject 'ueagle-atm!eagleI.fw'
WARNING: CPU: 1 PID: 20 at fs/sysfs/group.c:281 sysfs_remove_group+0x16e/0x280 fs/sysfs/group.c:279
Modules linked in:

CPU: 1 PID: 20 Comm: kworker/1:0 Not tainted 5.12.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events request_firmware_work_func
RIP: 0010:sysfs_remove_group+0x16e/0x280 fs/sysfs/group.c:279
Code: 89 e0 48 c1 e8 03 42 80 3c 28 00 74 08 4c 89 e7 e8 c7 96 cb ff 49 8b 14 24 48 c7 c7 80 18 c2 89 4c 89 f6 31 c0 e8 72 94 56 ff <0f> 0b 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 e0 af 87 ff 49 8d 5e 20
RSP: 0018:ffffc90000da7a90 EFLAGS: 00010246
RAX: 66443487ebe21600 RBX: ffff888024835038 RCX: ffff888011610000
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 1ffffffff1459be0 R08: ffffffff8160b612 R09: ffffed10173a3f1c
R10: ffffed10173a3f1c R11: 0000000000000000 R12: ffff888024835008
R13: dffffc0000000000 R14: ffffffff8a2cdec0 R15: ffff88801dfdee80
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563e05f63160 CR3: 00000000230ab000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 device_del+0x26a/0xa90 drivers/base/core.c:3398
 fw_load_sysfs_fallback+0x53e/0x720 drivers/base/firmware_loader/fallback.c:543
 fw_load_from_user_helper+0x242/0x320 drivers/base/firmware_loader/fallback.c:581
 _request_firmware+0x2c5/0x4c0 drivers/base/firmware_loader/main.c:831
 request_firmware_work_func+0xb8/0x1e0 drivers/base/firmware_loader/main.c:1077
 process_one_work+0x789/0xfd0 kernel/workqueue.c:2275
 worker_thread+0xac1/0x1300 kernel/workqueue.c:2421
 kthread+0x39a/0x3c0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB92368D3B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 08:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbhDWGj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 02:39:58 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:56124 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhDWGj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 02:39:57 -0400
Received: by mail-il1-f197.google.com with SMTP id v1-20020a92d2410000b02901533f3ed5dbso20728381ilg.22
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 23:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mz6YscuvZogBNVtCM3+B/kPlahbgXIU6kxtAJ38URss=;
        b=QLi/RqIlnBQkAF/2B+yqh6VOldcL4rmcT2zm8yWReZuYbl0O7XRIkkPh3E4qBbu3t2
         NW+IiWDCpxUWz9aNMFL3bdN4pgwMnx6mLfUX4ySA7KapnlX2Z6vg9QvqAwgo9fxUUjeT
         6Ck2nIQ1loU9hwcTD6FRnz8rryiiqTWm8A3y9/ttLosbBH4NwqjtPSuKhwjTX7aNOgxz
         Drw3iCPYZsXwt4ekCiKr4L1ArVt3ETZLm6pkV5lTv+izM8tGNJhk0kW1Ey0xIVJyYkXp
         aVBMoBQ1kI30uANHY2VBiNkZ0mr5ofQ+Y56Ci56dJ3bXlQc1MJHbUD/1eJFhfa2d6S3R
         QdSQ==
X-Gm-Message-State: AOAM533f1GjIKqn/cewzIRM9i82svxLBDay7EG3FC7gwHHfgd6qTsKtq
        X0+QC0ccxZl7gSo6qfM/m8AL0WmJBSw9q3Gyyoz4mqxg+hO1
X-Google-Smtp-Source: ABdhPJx5rVdBAWR6yLoY6VS2F6GSO1mNHqq/d0GsQrzl6UBCH65Jgfp7PUakW2CmpeMeqZ/hWaLTDe13ZTnq27h8fMBEuNQ02WIa
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154d:: with SMTP id j13mr1694340ilu.46.1619159959603;
 Thu, 22 Apr 2021 23:39:19 -0700 (PDT)
Date:   Thu, 22 Apr 2021 23:39:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a11a005c09e0e6e@google.com>
Subject: [syzbot] general protection fault in qca_power_shutdown
From:   syzbot <syzbot+adafc67b05ed63665d5e@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c98ff1d0 Merge tag 'scsi-fixes' of git://git.kernel.org/pu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16d44341d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=339c2ecce8fdd1d0
dashboard link: https://syzkaller.appspot.com/bug?extid=adafc67b05ed63665d5e

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+adafc67b05ed63665d5e@syzkaller.appspotmail.com

Bluetooth: hci7: Reading QCA version information failed (-110)
Bluetooth: hci7: Retry BT power ON:0
general protection fault, probably for non-canonical address 0xdffffc000000000f: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000078-0x000000000000007f]
CPU: 1 PID: 6293 Comm: kworker/u5:5 Not tainted 5.12.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: hci7 hci_power_on
RIP: 0010:dev_get_drvdata include/linux/device.h:666 [inline]
RIP: 0010:serdev_device_get_drvdata include/linux/serdev.h:117 [inline]
RIP: 0010:qca_soc_type drivers/bluetooth/hci_qca.c:240 [inline]
RIP: 0010:qca_power_shutdown+0x77/0x3b0 drivers/bluetooth/hci_qca.c:1821
Code: 4c 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 e8 02 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 75 08 49 8d 7e 78 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 ae 02 00 00 4d 85 f6 4d 8b 6e 78 41 bc 01 00 00
RSP: 0018:ffffc9000193f978 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff888024c82000 RCX: 0000000000000000
RDX: 000000000000000f RSI: ffffffff864835a6 RDI: 0000000000000078
RBP: ffff88802818b800 R08: 0000000000000024 R09: 0000000000000000
R10: ffffffff815bdabe R11: 0000000000000000 R12: dffffc0000000000
R13: ffff88802818b800 R14: 0000000000000000 R15: ffff88802818b808
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004e4a61 CR3: 000000007172f000 CR4: 00000000001526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 qca_setup+0x912/0x2070 drivers/bluetooth/hci_qca.c:1740
 hci_uart_setup+0x1b1/0x480 drivers/bluetooth/hci_ldisc.c:423
 hci_dev_do_open+0x3e1/0x1a00 net/bluetooth/hci_core.c:1499
 hci_power_on+0x133/0x650 net/bluetooth/hci_core.c:2247
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Modules linked in:
---[ end trace d4921a9b71de1581 ]---
RIP: 0010:dev_get_drvdata include/linux/device.h:666 [inline]
RIP: 0010:serdev_device_get_drvdata include/linux/serdev.h:117 [inline]
RIP: 0010:qca_soc_type drivers/bluetooth/hci_qca.c:240 [inline]
RIP: 0010:qca_power_shutdown+0x77/0x3b0 drivers/bluetooth/hci_qca.c:1821
Code: 4c 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 e8 02 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 75 08 49 8d 7e 78 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 ae 02 00 00 4d 85 f6 4d 8b 6e 78 41 bc 01 00 00
RSP: 0018:ffffc9000193f978 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff888024c82000 RCX: 0000000000000000
RDX: 000000000000000f RSI: ffffffff864835a6 RDI: 0000000000000078
RBP: ffff88802818b800 R08: 0000000000000024 R09: 0000000000000000
R10: ffffffff815bdabe R11: 0000000000000000 R12: dffffc0000000000
R13: ffff88802818b800 R14: 0000000000000000 R15: ffff88802818b808
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004e4a61 CR3: 000000007172f000 CR4: 00000000001526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

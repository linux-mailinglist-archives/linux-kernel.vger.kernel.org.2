Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11EEF38E2C2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 10:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbhEXIxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 04:53:52 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:35489 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhEXIxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 04:53:51 -0400
Received: by mail-io1-f72.google.com with SMTP id l2-20020a5e82020000b02903c2fa852f92so26718939iom.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 01:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Rzp9fGJjSJC7K5y9I9mQJfK8PLYGfna2g33NB2NJj8k=;
        b=nmiMnc/NMw+Z/FJ1e92Q93T6PzpapV72QLsirRewJNN23Ygmv1CcYKyZCYBF3zJE+2
         95krmyXk8vWc0M+gAPZ87pNeVBu7H2y11SnczBRtbUEnGV1bCTOvRUyFPmKC2aZc+zww
         Oz7tr4zysV17T13T///1E3jccqSC1uKMgQ1Iy81gGBEDB+SpPC73vFdYD6/r7UNm4CIl
         po1pwWduxU/AIxvJxgPfjoX2JH8fNyd5Z/pdt7t3PMg82iR4IvJnqN4ML85Ze/eZyapp
         ZaQXYsL1SFj/aJ7SiC2XZB+lBI5elDK1KMx3LYY5b8VVCLzdw4SdqsG6apuhwAp5gWR6
         YvCg==
X-Gm-Message-State: AOAM531Pp7D5UC/yLGV9FVRhxUpD2zNJ+9m7hq769jqxg7s+yiyZHjmH
        LsCk9tPjwsg2EFhPW/ZeXIEYNYX1f9iMrFa8fubbv9ETjId/
X-Google-Smtp-Source: ABdhPJwowSwZnKUl6XfvLPDdhMGS/Q8ohqrJPCjE1vR3p7oHyiCvKfKxxtQd5Y4FX03XBPLmte5AVZ2N0uZDuKM+AIiv0R1JR3lx
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:c3:: with SMTP id r3mr13200082ilq.280.1621846343449;
 Mon, 24 May 2021 01:52:23 -0700 (PDT)
Date:   Mon, 24 May 2021 01:52:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002e839a05c30f870b@google.com>
Subject: [syzbot] WARNING in osif_probe/usb_submit_urb
From:   syzbot <syzbot+9d7dadd15b8819d73f41@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mathias.nyman@linux.intel.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5cc59c41 USB: core: WARN if pipe direction != setup packet..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1072de73d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1206ee92dd3d988d
dashboard link: https://syzkaller.appspot.com/bug?extid=9d7dadd15b8819d73f41
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1576dc03d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11730bd7d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9d7dadd15b8819d73f41@syzkaller.appspotmail.com

usb 1-1: New USB device found, idVendor=1964, idProduct=0001, bcdDevice=52.6b
usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1: Product: syz
usb 1-1: Manufacturer: syz
usb 1-1: SerialNumber: syz
------------[ cut here ]------------
usb 1-1: BOGUS control dir, pipe 80000280 doesn't match bRequestType c1
WARNING: CPU: 1 PID: 55 at drivers/usb/core/urb.c:410 usb_submit_urb+0x14aa/0x1830 drivers/usb/core/urb.c:410
Modules linked in:
CPU: 1 PID: 55 Comm: kworker/1:2 Not tainted 5.13.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:usb_submit_urb+0x14aa/0x1830 drivers/usb/core/urb.c:410
Code: 84 4c 01 00 00 e8 a6 14 b3 fd 4c 89 f7 e8 4e a7 1b ff 45 89 e8 44 89 e1 48 89 ea 48 89 c6 48 c7 c7 c0 09 63 86 e8 18 f1 fb 01 <0f> 0b 49 8d 4f 5c 48 b8 00 00 00 00 00 fc ff df 48 89 ca 48 89 4c
RSP: 0018:ffffc90000276f60 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88811a940058 RCX: 0000000000000000
RDX: ffff8881079d8000 RSI: ffffffff812a6013 RDI: fffff5200004edde
RBP: ffff88810e157758 R08: 0000000000000001 R09: 0000000000000000
R10: ffffffff814b996b R11: 0000000000000000 R12: 0000000080000280
R13: 00000000000000c1 R14: ffff88811a9400a8 R15: ffff88810779ba00
FS:  0000000000000000(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005647593b8160 CR3: 0000000007825000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 usb_start_wait_urb+0x101/0x4c0 drivers/usb/core/message.c:58
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
 osif_usb_read drivers/i2c/busses/i2c-robotfuzz-osif.c:41 [inline]
 osif_probe+0x288/0x500 drivers/i2c/busses/i2c-robotfuzz-osif.c:156
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
 really_probe+0x291/0xf60 drivers/base/dd.c:576
 driver_probe_device+0x298/0x410 drivers/base/dd.c:763
 __device_attach_driver+0x203/0x2c0 drivers/base/dd.c:870
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:431
 __device_attach+0x228/0x4b0 drivers/base/dd.c:938
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0xbe0/0x2100 drivers/base/core.c:3320
 usb_set_configuration+0x113f/0x1910 drivers/usb/core/message.c:2164
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
 really_probe+0x291/0xf60 drivers/base/dd.c:576
 driver_probe_device+0x298/0x410 drivers/base/dd.c:763
 __device_attach_driver+0x203/0x2c0 drivers/base/dd.c:870
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:431
 __device_attach+0x228/0x4b0 drivers/base/dd.c:938
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0xbe0/0x2100 drivers/base/core.c:3320
 usb_new_device.cold+0x721/0x1058 drivers/usb/core/hub.c:2556
 hub_port_connect drivers/usb/core/hub.c:5297 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5437 [inline]
 port_event drivers/usb/core/hub.c:5583 [inline]
 hub_event+0x2357/0x4330 drivers/usb/core/hub.c:5665
 process_one_work+0x98d/0x1580 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x38c/0x460 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

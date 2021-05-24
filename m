Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8044C38E310
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 11:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbhEXJOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 05:14:54 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:34766 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbhEXJOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 05:14:45 -0400
Received: by mail-il1-f198.google.com with SMTP id e7-20020a056e020b27b02901bb39f4204dso31107093ilu.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 02:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Jf+FICWnfIcMfRYw8dN7mobZL8MANLgdSAKNoL4wGrE=;
        b=cpu0YRqVEDPpIhPvMxn4vHEBx+Y3NpQURA8mebEmxn+SbCcE3nVqZyxP1oWjVf1oAN
         L5jcP4a0Nn0SgohBJ+JXLrPDfVpZOiQXTauv0RGeHABB8IXY35LTQB3HXfPP78v1dvwF
         VY+zQnjpWr8qfCBQm2l2mRyxJ+J08z2uz3qov7kkGtBJX/UjhfJg+Uqe4bKP5semTciV
         JCPC/FDC/sZePYm7fUMjx8NpRD+FAHB3tMNRfnnybrkkmoI7pn2vxbgehTElAbVlyPnb
         iGBpYrNWXxUlEkKjxhwjWCoQ5kSqHXNF2MNv4W3ik+/xnHfa3+di5Y/roVnnaYU5tIjH
         w3ew==
X-Gm-Message-State: AOAM530DhMDOr5XLKzxOsS0bwtRP4WekfYc7edhaFiOgfd09Fcy3AlD2
        7Ts1ggJAAAfY3xtbOVkMMpSsePo9HfA0Vl+NEn6G33crNwZZ
X-Google-Smtp-Source: ABdhPJzcSXXDSY2yzJ39CXBL+Nh4N7wVG7Tx4Vy0Hvi3qJsy33Djn86/i73tgFv4o2JoQsqiUStk2x2oZvfg4KCt1ROVccH6pZLg
MIME-Version: 1.0
X-Received: by 2002:a02:7110:: with SMTP id n16mr23306086jac.69.1621847598044;
 Mon, 24 May 2021 02:13:18 -0700 (PDT)
Date:   Mon, 24 May 2021 02:13:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f61b1905c30fd185@google.com>
Subject: [syzbot] WARNING in e2i_init/usb_submit_urb
From:   syzbot <syzbot+5d0b6bcdaaa6d1cb6ef3@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=17a30553d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1206ee92dd3d988d
dashboard link: https://syzkaller.appspot.com/bug?extid=5d0b6bcdaaa6d1cb6ef3

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5d0b6bcdaaa6d1cb6ef3@syzkaller.appspotmail.com

------------[ cut here ]------------
usb 6-1: BOGUS control dir, pipe 80001d80 doesn't match bRequestType 2
WARNING: CPU: 0 PID: 7 at drivers/usb/core/urb.c:410 usb_submit_urb+0x14aa/0x1830 drivers/usb/core/urb.c:410
Modules linked in:
CPU: 0 PID: 7 Comm: kworker/0:1 Not tainted 5.13.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:usb_submit_urb+0x14aa/0x1830 drivers/usb/core/urb.c:410
Code: 84 4c 01 00 00 e8 a6 14 b3 fd 4c 89 f7 e8 4e a7 1b ff 45 89 e8 44 89 e1 48 89 ea 48 89 c6 48 c7 c7 c0 09 63 86 e8 18 f1 fb 01 <0f> 0b 49 8d 4f 5c 48 b8 00 00 00 00 00 fc ff df 48 89 ca 48 89 4c
RSP: 0018:ffffc9000007eee0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88811f21b058 RCX: 0000000000000000
RDX: 0000000000040000 RSI: ffffffff812a6013 RDI: fffff5200000fdce
RBP: ffff888100bf5e60 R08: 0000000000000001 R09: 0000000000000000
R10: ffffffff814b996b R11: 0000000000000000 R12: 0000000080001d80
R13: 0000000000000002 R14: ffff88811f21b0a8 R15: ffff88813b0c7800
FS:  0000000000000000(0000) GS:ffff8881f6800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000014a53ad CR3: 0000000007825000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 usb_start_wait_urb+0x101/0x4c0 drivers/usb/core/message.c:58
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
 e2i_init+0xb3/0x150 drivers/input/touchscreen/usbtouchscreen.c:254
 usbtouch_probe+0xfc9/0x1c40 drivers/input/touchscreen/usbtouchscreen.c:1771
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
 process_scheduled_works kernel/workqueue.c:2337 [inline]
 worker_thread+0x82b/0x1120 kernel/workqueue.c:2423
 kthread+0x38c/0x460 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

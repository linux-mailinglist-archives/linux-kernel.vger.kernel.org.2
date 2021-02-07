Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A79931223F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 08:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhBGHlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 02:41:08 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:34689 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhBGHky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 02:40:54 -0500
Received: by mail-io1-f72.google.com with SMTP id c3so217919ioa.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 23:40:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=hfHaHS7Sx/il8GwdfHMXOne3PmLGuB8k3bCrl0MIyVQ=;
        b=moWldvs5Ahe8lGvvDp3b5eyezEXeF26VOrkVTiI+Y5GPW5HKWR8EzEKJs/kaJtwbN4
         OounMoB5cufIFOR09trq9RRBNKnvDJGWwplt5zjjgxFS/qDTc0X0ZtLM34RlVh49yZhS
         sCS7V9drCaUOw9r26AlxDqC67MvNhD2hV4yDTdUZ/ugXM9QdFKA2SnAQnciGWCRlPDlo
         o/EvDzAe9d++d4V5ZxY/X/nO3eL4OUAsoDyNYswnROPHsFE+ryJWG42Nr6UCUuZKlXP0
         3p5e22PmbMfaRX0/OTxjgmigGgQ9VXFcxp/WQw6oOJI/yMxf69WJBwtclDuCROCkKyAf
         CifQ==
X-Gm-Message-State: AOAM532f19hepLdNTufmvjkYIrYtFDZfT9kh2on1gQFpdIIWQbnPRifD
        KcHr7ly6ErYJ77QcF0/77ulqZ1lOw4JS7+fKnrZhohP+KGIE
X-Google-Smtp-Source: ABdhPJzoQcmON1Oz8o9OsEFUpoPutWZG7GO3rfR61f7Z8odbVVAh7wGavF92DA6RSjVDuo3GJbUJ/F2o2SB8Z3+vof1KPDp8atXr
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:11af:: with SMTP id 15mr11298002ilj.302.1612683613789;
 Sat, 06 Feb 2021 23:40:13 -0800 (PST)
Date:   Sat, 06 Feb 2021 23:40:13 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef60e905baba29d0@google.com>
Subject: WARNING in go7007_usb_onboard_write_interrupt/usb_submit_urb
From:   syzbot <syzbot+d4ebc877b1223f20d5a0@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, andriy.shevchenko@linux.intel.com,
        gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mathias.nyman@linux.intel.com, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    64eaa0fa platform/chrome: cros_ec_typec: Fix call to typec..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=12d5c090d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=29ec25b819cb42f3
dashboard link: https://syzkaller.appspot.com/bug?extid=d4ebc877b1223f20d5a0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b47dd8d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164896c4d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d4ebc877b1223f20d5a0@syzkaller.appspotmail.com

usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1: SerialNumber: syz
usb 1-1: config 0 descriptor??
------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 2 != type 3
WARNING: CPU: 0 PID: 2608 at drivers/usb/core/urb.c:493 usb_submit_urb+0xd27/0x1540 drivers/usb/core/urb.c:493
Modules linked in:
CPU: 0 PID: 2608 Comm: kworker/0:2 Not tainted 5.11.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:usb_submit_urb+0xd27/0x1540 drivers/usb/core/urb.c:493
Code: 84 d4 02 00 00 e8 e9 e9 ba fd 4c 89 ef e8 f1 3d 1d ff 41 89 d8 44 89 e1 4c 89 f2 48 89 c6 48 c7 c7 00 6a 61 86 e8 31 ee f9 01 <0f> 0b e9 81 f8 ff ff e8 bd e9 ba fd 48 81 c5 30 06 00 00 e9 ad f7
RSP: 0018:ffffc90006cf6c70 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: ffff88810a895040 RSI: ffffffff81299db3 RDI: fffff52000d9ed80
RBP: ffff88810155f8a0 R08: 0000000000000001 R09: 0000000000000000
R10: ffffffff8149c4ab R11: 0000000000000000 R12: 0000000000000002
R13: ffff8881121670a0 R14: ffff8881031c06e0 R15: ffff888102b46f00
FS:  0000000000000000(0000) GS:ffff8881f6800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055bfb7b520d0 CR3: 000000010a1f1000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 usb_start_wait_urb+0x101/0x4c0 drivers/usb/core/message.c:58
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
 go7007_usb_onboard_write_interrupt+0x26a/0x340 drivers/media/usb/go7007/go7007-usb.c:735
 go7007_usb_interface_reset+0x139/0x540 drivers/media/usb/go7007/go7007-usb.c:649
 go7007_load_encoder+0x11f/0x510 drivers/media/usb/go7007/go7007-driver.c:107
 go7007_boot_encoder+0x2a/0xe0 drivers/media/usb/go7007/go7007-driver.c:131
 go7007_usb_probe+0x80e/0x21f0 drivers/media/usb/go7007/go7007-usb.c:1161
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
 really_probe+0x291/0xe60 drivers/base/dd.c:554
 driver_probe_device+0x26b/0x3d0 drivers/base/dd.c:740
 __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:846
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:431
 __device_attach+0x228/0x4a0 drivers/base/dd.c:914
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0xbc4/0x1d90 drivers/base/core.c:3109
 usb_set_configuration+0x113c/0x1910 drivers/usb/core/message.c:2164
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
 really_probe+0x291/0xe60 drivers/base/dd.c:554
 driver_probe_device+0x26b/0x3d0 drivers/base/dd.c:740
 __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:846
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:431
 __device_attach+0x228/0x4a0 drivers/base/dd.c:914
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0xbc4/0x1d90 drivers/base/core.c:3109
 usb_new_device.cold+0x721/0x1058 drivers/usb/core/hub.c:2555
 hub_port_connect drivers/usb/core/hub.c:5223 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
 port_event drivers/usb/core/hub.c:5509 [inline]
 hub_event+0x2357/0x4320 drivers/usb/core/hub.c:5591
 process_one_work+0x98d/0x1580 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x38c/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

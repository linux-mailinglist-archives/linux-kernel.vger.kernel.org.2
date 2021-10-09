Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627A7427963
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 13:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhJILQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 07:16:24 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:33489 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbhJILQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 07:16:23 -0400
Received: by mail-il1-f197.google.com with SMTP id r18-20020a056e02109200b0025920bc2e5eso2009350ilj.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 04:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=pwHzytuOLbM8wQAkLqWi6P86FJuSP9gw7ny5OBo/tUA=;
        b=nkxzvgtBHRWPPpN6zuBVVHoiFkVgSoGlRiuw6XfrI4bgyq7pWtmj+Exn+/XEzuMFh8
         pvOKW+ggSfUhqzYijCm8C6CFtKMuB4aEi4KbiXzbI3h6BPlP1Km6tUrTI8DDEZGSwQnS
         Ju2Xh+PsI6e3SEGKMmjbjtjQp81d8Riu2o7CcnhHQTLrW7jv/DMFVvjfqYiThCQnxD9K
         4Ly0L8iF6/I+HvrL0TECtEw6Dk2GiRNzBEb8ypjNRoMTjGWm298Ctyb85N2zCk9iluNs
         4dgHmOI5wPRskbcHKaaVu1Hr19UiPGWj5x5IcPjrH9SZHKC+Bw3byL9aZPkhTFrCK+0K
         pWtg==
X-Gm-Message-State: AOAM5327iaE3wD6kmleZ3MSyiKgaROoldV/D5Ag2vva29zqMhZj/mA7j
        lG4luGcaTN4HsGRx7s5/d9XxCK4Z2DcbPi0KrpFT78z6idTm
X-Google-Smtp-Source: ABdhPJwur+gA/yZVetuCbDgK2mR8soyYi2g2JJW5ahqXVSjd4wk07kh7tfi3x8urQrl+ezyxEnPfQmIFBL+a9eFi0We5k6kpoeVB
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c3:: with SMTP id i3mr11859002ilm.145.1633778066191;
 Sat, 09 Oct 2021 04:14:26 -0700 (PDT)
Date:   Sat, 09 Oct 2021 04:14:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000046faa305cde9998e@google.com>
Subject: [syzbot] KASAN: global-out-of-bounds Read in usb_match_device
From:   syzbot <syzbot+cf1553a86d1962a0c79f@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, hadess@hadess.net, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        m.v.b@runbox.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    89e84f946479 usb: typec: tipd: Remove FIXME about testing ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1638063f300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cd8a1eadba1e4ce4
dashboard link: https://syzkaller.appspot.com/bug?extid=cf1553a86d1962a0c79f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=158c3deb300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1190df03300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cf1553a86d1962a0c79f@syzkaller.appspotmail.com

usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1: Product: syz
usb 1-1: Manufacturer: syz
usb 1-1: SerialNumber: syz
usb 1-1: config 0 descriptor??
==================================================================
BUG: KASAN: global-out-of-bounds in usb_match_device+0x4dc/0x550 drivers/usb/core/driver.c:641
Read of size 2 at addr ffffffff87bdfd50 by task kworker/0:1/7

CPU: 0 PID: 7 Comm: kworker/0:1 Not tainted 5.15.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xf/0x309 mm/kasan/report.c:256
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
 usb_match_device+0x4dc/0x550 drivers/usb/core/driver.c:641
 usb_match_one_id drivers/usb/core/driver.c:722 [inline]
 usb_match_id.part.0+0x10d/0x1b0 drivers/usb/core/driver.c:816
 usb_match_id+0x23/0x40 drivers/usb/core/driver.c:806
 ehset_prepare_port_for_testing+0x4a/0xf0 drivers/usb/misc/ehset.c:43
 ehset_probe+0x271/0x460 drivers/usb/misc/ehset.c:82
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x245/0xcc0 drivers/base/dd.c:596
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:751
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:781
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:898
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:969
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xc35/0x21b0 drivers/base/core.c:3359
 usb_set_configuration+0x113f/0x1910 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x245/0xcc0 drivers/base/dd.c:596
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:751
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:781
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:898
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:969
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xc35/0x21b0 drivers/base/core.c:3359
 usb_new_device.cold+0x63f/0x108e drivers/usb/core/hub.c:2563
 hub_port_connect drivers/usb/core/hub.c:5348 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5488 [inline]
 port_event drivers/usb/core/hub.c:5634 [inline]
 hub_event+0x2357/0x4330 drivers/usb/core/hub.c:5716
 process_one_work+0x9bf/0x1620 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x3c2/0x4a0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

The buggy address belongs to the variable:
 platform_bus+0x530/0x560

Memory state around the buggy address:
 ffffffff87bdfc00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffffff87bdfc80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffffff87bdfd00: 00 00 00 00 00 00 00 00 00 f9 f9 f9 f9 f9 f9 f9
                                                 ^
 ffffffff87bdfd80: 00 00 00 00 00 00 00 00 00 00 f9 f9 f9 f9 f9 f9
 ffffffff87bdfe00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8397337A9DC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 16:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbhEKOvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 10:51:41 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:45855 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbhEKOva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 10:51:30 -0400
Received: by mail-il1-f197.google.com with SMTP id l13-20020a92d8cd0000b02901bb0166907aso4632588ilo.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 07:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=WK0rCpddaIotUh6/rcU63RftGn9uHXAHck5F5PO4UIw=;
        b=tO0JRCkoAwocjfHRGAtZvXCzRjJ8CROAWsLLgysbK5DTkVC5uF0OWacxDryalq2Km+
         T/qRFOhMlbeubWuoIV3z3hTT4dZ2MUc1PaGGkVTywGdrFZHpPch4GSgYpuIGHhxvN3V6
         pKAViRUrQ9Jedwa6tnd/9Y5uGtdajNv9jujFGaQNfbusD1+Q8/ffOMCoDjFbyi8FaWuP
         xd/xoSMmi9PYeRVH3PiLe0W+KgpoPvQ48E+JRgS8UAb9Mwt2/51q9SsOOkIh6hapNMLm
         eaN28iMZIUC/Znp4CbZEW7HiGi41MW6/iqiKroahYensOfpb9ZV61bZ4jy4LxGCodGF9
         O5zw==
X-Gm-Message-State: AOAM532OwjmHWBKhhFDFVbjGR/fEOKa0Y/s5u5BRU+QewSXzkb/PZqOI
        Am7mqYyj/sKwuo7ZS8Np/Jrk4ZH3CxnWiTvr54M67rurY12v
X-Google-Smtp-Source: ABdhPJyCL0dFpyleG/qWV9b3J/9KXy6CKUPoLxGnpVYfWnwmYvKoUVhLaud8brcZUdWwZzsFhyxueGKja33l+ZN1tCNiT+bbv168
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1142:: with SMTP id o2mr14052018ill.9.1620744623524;
 Tue, 11 May 2021 07:50:23 -0700 (PDT)
Date:   Tue, 11 May 2021 07:50:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008ea13f05c20f0390@google.com>
Subject: [syzbot] WARNING in input_unregister_device
From:   syzbot <syzbot+96f19ddb26662d2cd6f5@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    83a9d2a0 usb: isp1760: hcd: refactor mempool config and se..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=10275a63d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a73b8d06863cd18d
dashboard link: https://syzkaller.appspot.com/bug?extid=96f19ddb26662d2cd6f5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12126d2dd00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109ea9b3d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+96f19ddb26662d2cd6f5@syzkaller.appspotmail.com

usb 1-1: USB disconnect, device number 46
------------[ cut here ]------------
add_uevent_var: buffer size too small
WARNING: CPU: 0 PID: 2210 at lib/kobject_uevent.c:671 add_uevent_var+0x311/0x380 lib/kobject_uevent.c:671
Modules linked in:
CPU: 0 PID: 2210 Comm: kworker/0:2 Not tainted 5.12.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:add_uevent_var+0x311/0x380 lib/kobject_uevent.c:671
Code: 48 c7 c7 60 70 21 86 e8 54 ed 7e 03 0f 0b 41 bd f4 ff ff ff e9 55 ff ff ff e8 6b 4d 37 ff 48 c7 c7 00 71 21 86 e8 36 ed 7e 03 <0f> 0b 41 bd f4 ff ff ff e9 37 ff ff ff 4c 89 ee 48 c7 c7 40 1e d6
RSP: 0018:ffffc90006c7f2d0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88811c1ca000 RCX: 0000000000000000
RDX: ffff88810f073680 RSI: ffffffff812a3e73 RDI: fffff52000d8fe4c
RBP: ffffc90006c7f3c0 R08: 0000000000000001 R09: 0000000000000000
R10: ffffffff814b72cb R11: 0000000000000000 R12: 1ffff92000d8fe5d
R13: 00000000000007de R14: ffff88811c1ca218 R15: 00000000000007de
FS:  0000000000000000(0000) GS:ffff8881f6a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000560185d39040 CR3: 000000011042d000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 kobject_uevent_env+0xdda/0x1650 lib/kobject_uevent.c:605
 device_del+0x7eb/0xd40 drivers/base/core.c:3517
 input_unregister_device+0xb4/0xf0 drivers/input/input.c:2379
 hidinput_disconnect+0x15e/0x3d0 drivers/hid/hid-input.c:2013
 hid_disconnect+0x13f/0x1a0 drivers/hid/hid-core.c:2029
 hid_hw_stop+0x12/0x70 drivers/hid/hid-core.c:2076
 ms_remove+0x12/0x90 drivers/hid/hid-microsoft.c:409
 hid_device_remove+0xed/0x240 drivers/hid/hid-core.c:2317
 __device_release_driver+0x3bd/0x6f0 drivers/base/dd.c:1181
 device_release_driver_internal drivers/base/dd.c:1212 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1235
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:533
 device_del+0x502/0xd40 drivers/base/core.c:3507
 hid_remove_device drivers/hid/hid-core.c:2488 [inline]
 hid_destroy_device+0xe1/0x150 drivers/hid/hid-core.c:2507
 usbhid_disconnect+0x9f/0xe0 drivers/hid/usbhid/hid-core.c:1436
 usb_unbind_interface+0x1d8/0x8d0 drivers/usb/core/driver.c:458
 __device_release_driver+0x3bd/0x6f0 drivers/base/dd.c:1181
 device_release_driver_internal drivers/base/dd.c:1212 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1235
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:533
 device_del+0x502/0xd40 drivers/base/core.c:3507
 usb_disable_device+0x35b/0x7b0 drivers/usb/core/message.c:1413
 usb_disconnect.cold+0x27d/0x791 drivers/usb/core/hub.c:2219
 hub_port_connect drivers/usb/core/hub.c:5127 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5416 [inline]
 port_event drivers/usb/core/hub.c:5562 [inline]
 hub_event+0x1c9c/0x4320 drivers/usb/core/hub.c:5644
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19CE4588CA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 06:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhKVFYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 00:24:34 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:44775 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhKVFYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 00:24:33 -0500
Received: by mail-io1-f72.google.com with SMTP id 7-20020a6b0107000000b005ed196a2546so230044iob.11
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 21:21:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=AfGbe8pSXev/P+LkZEL8O6Kdv4ktDQehCAQGE4pUMyQ=;
        b=oujMSGxEhaSC1A4sxaRUHrvPP2JBUA6vJcXDCo+n7fkGsy9+5EBcnPkBoWZrAy0+vC
         8/UhbFLfm+XxOAegio+Dkb1VCBZX7LLMZC17QUxy+E2Pry0qFaaMN7of09G0kAzUqoO9
         cWA3dWMhGor9o0NPN2R4sznClec4iNVjGDunSutd2L4AfbYHVLU+zm5XRCO8nepxQmO4
         1855eKOo1+unfo5yrg7eeRZKrmDHUfJ2051t6AGJP8/bivh9aCK2zbwa7Ihcb5xn2Gnf
         ltlP+KNobPbJfPq2BI6oC08Zu+aQBe9vfW3piH4dJJW55gcNtharpGNE22jtjhLJ1Hh/
         SnCg==
X-Gm-Message-State: AOAM533WP0pV0pmk/r2+iFn0FhgNSOMo4xjVFR61lfSVDi1DMK8jHtEA
        lgNSBa3JEeOWFtrpk2jZsnezfwkjTXICeKId9a8RXsJfIf1W
X-Google-Smtp-Source: ABdhPJzQREm2oDznoIFaInXKIuHhsovnfaznepYR4+2eDSKfHCsrVVDY2vWdTItLwPOQ6YGz7k3DR6zElJI6d18pcduNK7yykECh
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1607:: with SMTP id x7mr46156355jas.27.1637558487660;
 Sun, 21 Nov 2021 21:21:27 -0800 (PST)
Date:   Sun, 21 Nov 2021 21:21:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f4ba3505d159cbf7@google.com>
Subject: [syzbot] possible deadlock in usb_reset_and_verify_device
From:   syzbot <syzbot+7f3f8da319285fc76bcb@syzkaller.appspotmail.com>
To:     Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mathias.nyman@linux.intel.com, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5191249f8803 Add linux-next specific files for 20211118
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=126edbc9b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fca39774e64812b0
dashboard link: https://syzkaller.appspot.com/bug?extid=7f3f8da319285fc76bcb
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7f3f8da319285fc76bcb@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.16.0-rc1-next-20211118-syzkaller #0 Not tainted
------------------------------------------------------
kworker/1:2/136 is trying to acquire lock:
ffff88801d292c68 (hcd->address0_mutex){+.+.}-{3:3}, at: usb_reset_and_verify_device+0x3ee/0xee0 drivers/usb/core/hub.c:5923

but task is already holding lock:
ffff88801da345c0 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_lock_port drivers/usb/core/hub.c:3086 [inline]
ffff88801da345c0 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_port_resume+0x2a6/0x1950 drivers/usb/core/hub.c:3644

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&port_dev->status_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:607 [inline]
       __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:740
       usb_lock_port drivers/usb/core/hub.c:3086 [inline]
       hub_port_connect drivers/usb/core/hub.c:5279 [inline]
       hub_port_connect_change drivers/usb/core/hub.c:5493 [inline]
       port_event drivers/usb/core/hub.c:5639 [inline]
       hub_event+0x21c1/0x4450 drivers/usb/core/hub.c:5721
       process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
       worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
       kthread+0x405/0x4f0 kernel/kthread.c:327
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

-> #0 (hcd->address0_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3063 [inline]
       check_prevs_add kernel/locking/lockdep.c:3186 [inline]
       validate_chain kernel/locking/lockdep.c:3801 [inline]
       __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5027
       lock_acquire kernel/locking/lockdep.c:5637 [inline]
       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
       __mutex_lock_common kernel/locking/mutex.c:607 [inline]
       __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:740
       usb_reset_and_verify_device+0x3ee/0xee0 drivers/usb/core/hub.c:5923
       finish_port_resume drivers/usb/core/hub.c:3499 [inline]
       usb_port_resume+0x12f7/0x1950 drivers/usb/core/hub.c:3699
       usb_generic_driver_resume+0x40/0xa0 drivers/usb/core/generic.c:305
       usb_resume_device drivers/usb/core/driver.c:1288 [inline]
       usb_resume_both+0x627/0x8d0 drivers/usb/core/driver.c:1512
       __rpm_callback+0xc9/0x330 drivers/base/power/runtime.c:377
       rpm_callback+0x1da/0x220 drivers/base/power/runtime.c:504
       rpm_resume+0xf5d/0x1bd0 drivers/base/power/runtime.c:879
       __pm_runtime_resume+0xb7/0x170 drivers/base/power/runtime.c:1110
       pm_runtime_get_sync include/linux/pm_runtime.h:393 [inline]
       usb_autoresume_device+0x1e/0x60 drivers/usb/core/driver.c:1705
       usb_remote_wakeup+0x8b/0xe0 drivers/usb/core/hub.c:3723
       hub_port_connect_change drivers/usb/core/hub.c:5479 [inline]
       port_event drivers/usb/core/hub.c:5639 [inline]
       hub_event+0x2d69/0x4450 drivers/usb/core/hub.c:5721
       process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
       worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
       kthread+0x405/0x4f0 kernel/kthread.c:327
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&port_dev->status_lock);
                               lock(hcd->address0_mutex);
                               lock(&port_dev->status_lock);
  lock(hcd->address0_mutex);

 *** DEADLOCK ***

5 locks held by kworker/1:2/136:
 #0: ffff888011abb138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888011abb138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888011abb138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff888011abb138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff888011abb138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff888011abb138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x896/0x1690 kernel/workqueue.c:2269
 #1: ffffc900027ffdb0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8ca/0x1690 kernel/workqueue.c:2273
 #2: ffff88801da31220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #2: ffff88801da31220 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c1/0x4450 drivers/usb/core/hub.c:5667
 #3: ffff88814a94a220 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:760 [inline]
 #3: ffff88814a94a220 (&dev->mutex){....}-{3:3}, at: usb_remote_wakeup+0x1f/0xe0 drivers/usb/core/hub.c:3720
 #4: ffff88801da345c0 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_lock_port drivers/usb/core/hub.c:3086 [inline]
 #4: ffff88801da345c0 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_port_resume+0x2a6/0x1950 drivers/usb/core/hub.c:3644

stack backtrace:
CPU: 1 PID: 136 Comm: kworker/1:2 Not tainted 5.16.0-rc1-next-20211118-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2143
 check_prev_add kernel/locking/lockdep.c:3063 [inline]
 check_prevs_add kernel/locking/lockdep.c:3186 [inline]
 validate_chain kernel/locking/lockdep.c:3801 [inline]
 __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5027
 lock_acquire kernel/locking/lockdep.c:5637 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5602
 __mutex_lock_common kernel/locking/mutex.c:607 [inline]
 __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:740
 usb_reset_and_verify_device+0x3ee/0xee0 drivers/usb/core/hub.c:5923
 finish_port_resume drivers/usb/core/hub.c:3499 [inline]
 usb_port_resume+0x12f7/0x1950 drivers/usb/core/hub.c:3699
 usb_generic_driver_resume+0x40/0xa0 drivers/usb/core/generic.c:305
 usb_resume_device drivers/usb/core/driver.c:1288 [inline]
 usb_resume_both+0x627/0x8d0 drivers/usb/core/driver.c:1512
 __rpm_callback+0xc9/0x330 drivers/base/power/runtime.c:377
 rpm_callback+0x1da/0x220 drivers/base/power/runtime.c:504
 rpm_resume+0xf5d/0x1bd0 drivers/base/power/runtime.c:879
 __pm_runtime_resume+0xb7/0x170 drivers/base/power/runtime.c:1110
 pm_runtime_get_sync include/linux/pm_runtime.h:393 [inline]
 usb_autoresume_device+0x1e/0x60 drivers/usb/core/driver.c:1705
 usb_remote_wakeup+0x8b/0xe0 drivers/usb/core/hub.c:3723
 hub_port_connect_change drivers/usb/core/hub.c:5479 [inline]
 port_event drivers/usb/core/hub.c:5639 [inline]
 hub_event+0x2d69/0x4450 drivers/usb/core/hub.c:5721
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
usb 4-1: USB disconnect, device number 2
usblp0: removed
usb 6-1: new high-speed USB device number 2 using dummy_hcd
usb 6-1: Using ep0 maxpacket: 32
usb 6-1: config 1 interface 0 altsetting 0 endpoint 0x81 has an invalid bInterval 0, changing to 7
usb 6-1: config 1 interface 0 altsetting 0 endpoint 0x81 has invalid wMaxPacketSize 0
usb 6-1: config 1 interface 1 altsetting 1 endpoint 0x82 has invalid wMaxPacketSize 0
usb 6-1: config 1 interface 1 altsetting 1 bulk endpoint 0x82 has invalid maxpacket 0
usb 6-1: config 1 interface 1 altsetting 1 endpoint 0x3 has invalid wMaxPacketSize 0
usb 6-1: config 1 interface 1 altsetting 1 bulk endpoint 0x3 has invalid maxpacket 0
usb 6-1: New USB device found, idVendor=0525, idProduct=a4a1, bcdDevice= 0.40
usb 6-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 6-1: Product: syz
usb 6-1: Manufacturer: syz
usb 6-1: SerialNumber: syz
cdc_ncm 6-1:1.0: bind() failure
cdc_ncm 6-1:1.1: CDC Union missing and no IAD found
cdc_ncm 6-1:1.1: bind() failure
usb 6-1: USB disconnect, device number 2


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

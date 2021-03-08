Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D628A331565
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 19:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhCHSAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 13:00:47 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:39409 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhCHSAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 13:00:25 -0500
Received: by mail-io1-f69.google.com with SMTP id x6so8189334ioj.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 10:00:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0NbBWQ1KfCtcmv0cSJMvFDglmPH0B/XJ2ahm45ucYXM=;
        b=sr9gF4bPi3OgODOYrJawwpYdBHKu3apeaGA7oVnwWyiALpBv4NZse0Q3G+6W7G9xXR
         8XexkU8C9pxBQWLakBa2VYFqeU8ZYIbrC6fkVjkt074kguBPwSHAe6ljCQ225D3450xk
         iPUUZZKFHi7lvoxdLEoH+/35x5LO8mtPFhc8EzGIbJUemDrvd1m/zmG2aj53/MFt3OoH
         XjzZLKzIQj32QjLbgRqjEUiDU3llxghc/5nAy6Sc0Z8DI/kElnXy9Gufbm9+vgO3AyiY
         71FjR21GfRqTivT/VXzWjt2Ba7jKbWUIWPk95tC0Cb0nV5B70CEwFFBslFzOod2HaXql
         BS8A==
X-Gm-Message-State: AOAM533tnydnak6Y/Jtkl9h2EO2cm2NBQmWo4cC70C+XIskzy0leUJC8
        91SkSUsag68raqFzOYn0A5q2cIja30k7Ssziz6GxErB/DiWD
X-Google-Smtp-Source: ABdhPJzY5RoRr6PRC9kxQ7IMuGZuTBI+WT+hqPEzzMyik8k6hA/PK9LZ05cAZQi2E3BrBZIldYrQ2WlP05nOFHqFNQRgzjffZyFU
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:14c2:: with SMTP id o2mr21888577ilk.91.1615226425111;
 Mon, 08 Mar 2021 10:00:25 -0800 (PST)
Date:   Mon, 08 Mar 2021 10:00:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004cfc1705bd0a35c4@google.com>
Subject: [syzbot] general protection fault in usb_audio_probe
From:   syzbot <syzbot+719da9b149a931f5143f@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, kai.heng.feng@canonical.com,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4641b323 Add linux-next specific files for 20210305
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12584542d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b87b6a083d302a90
dashboard link: https://syzkaller.appspot.com/bug?extid=719da9b149a931f5143f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125b52aed00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123df2aed00000

The issue was bisected to:

commit 9799110825dba087c2bdce886977cf84dada2005
Author: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu Mar 4 04:34:16 2021 +0000

    ALSA: usb-audio: Disable USB autosuspend properly in setup_disable_autosuspend()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=178418a2d00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=144418a2d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=104418a2d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+719da9b149a931f5143f@syzkaller.appspotmail.com
Fixes: 9799110825db ("ALSA: usb-audio: Disable USB autosuspend properly in setup_disable_autosuspend()")

usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1: Product: syz
usb 1-1: Manufacturer: syz
usb 1-1: SerialNumber: syz
usb 1-1: 0:2 : does not exist
general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 0 PID: 2965 Comm: kworker/0:2 Not tainted 5.12.0-rc1-next-20210305-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:usb_audio_probe+0xa80/0x2c70 sound/usb/card.c:833
Code: 8b 74 24 08 48 89 df e8 0e 31 06 00 e8 59 64 8d fa 48 8b 04 24 48 8d 78 12 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 af
RSP: 0018:ffffc900016cf0c8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888023e48e88 RCX: 0000000000000000
RDX: 0000000000000002 RSI: ffffffff86e61767 RDI: 0000000000000012
RBP: 0000000000000020 R08: 0000000000000000 R09: ffffffff8d580a07
R10: ffffffff86e61bfe R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: dffffc0000000000 R15: 000000000000001f
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056098ddcb140 CR3: 00000000147bd000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
 really_probe+0x291/0xe60 drivers/base/dd.c:554
 driver_probe_device+0x26b/0x3d0 drivers/base/dd.c:740
 __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:846
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:431
 __device_attach+0x228/0x4a0 drivers/base/dd.c:914
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0xbdb/0x1db0 drivers/base/core.c:3242
 usb_set_configuration+0x113f/0x1910 drivers/usb/core/message.c:2164
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
 really_probe+0x291/0xe60 drivers/base/dd.c:554
 driver_probe_device+0x26b/0x3d0 drivers/base/dd.c:740
 __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:846
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:431
 __device_attach+0x228/0x4a0 drivers/base/dd.c:914
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0xbdb/0x1db0 drivers/base/core.c:3242
 usb_new_device.cold+0x721/0x1058 drivers/usb/core/hub.c:2555
 hub_port_connect drivers/usb/core/hub.c:5223 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
 port_event drivers/usb/core/hub.c:5509 [inline]
 hub_event+0x2357/0x4320 drivers/usb/core/hub.c:5591
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Modules linked in:
---[ end trace 4d5988887d9521a9 ]---
RIP: 0010:usb_audio_probe+0xa80/0x2c70 sound/usb/card.c:833
Code: 8b 74 24 08 48 89 df e8 0e 31 06 00 e8 59 64 8d fa 48 8b 04 24 48 8d 78 12 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 af
RSP: 0018:ffffc900016cf0c8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888023e48e88 RCX: 0000000000000000
RDX: 0000000000000002 RSI: ffffffff86e61767 RDI: 0000000000000012
RBP: 0000000000000020 R08: 0000000000000000 R09: ffffffff8d580a07
R10: ffffffff86e61bfe R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: dffffc0000000000 R15: 000000000000001f
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005572425f2908 CR3: 0000000020f01000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

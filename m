Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CADF382788
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 10:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbhEQIxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 04:53:33 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:56150 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbhEQIxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 04:53:30 -0400
Received: by mail-io1-f71.google.com with SMTP id p2-20020a5d98420000b029043b3600ac76so1317ios.22
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 01:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3SRqX4XYa1OubWuc+nsCa3NBcKx9gujWq3URJrBjN/4=;
        b=F2WiDZWcsiEWaoqM1BNJjwNt1NU3uf+/GKm6ugy/AsJS3QTyzDq8uDbxc59b1cskAm
         Tog9Jh+H39TddEgALaO77jBP0lErGZrHf3Y0E1s/Vgrg1tvGmDG+Nm5OPlpucplHNr9K
         x9+1fzxuFk+h5OszaW8yTX39YUFWui3mjsvSg6MNBLH3500Hb+VdiRBL41RbKwyL47jq
         crKPWTzdz6XyTduoTWIZGZ5VFm81uIEQ5yMZ8ECGNLo4cryXBf9pZKqmqoBsYIEPqJjw
         zwH0X4RrMiDCn+FdR6QmIFEWAK8AUOI/HT1QAq/Ws5MXFYYu5hqM/kNnYPU5NuWBC4oF
         YcGw==
X-Gm-Message-State: AOAM531jgXCYQkfixv+UzMvzgV+otDr+owZC2AEbzOctiX71CVDwxCse
        RuvdMfpkj3P2qw6OdJsqqGnRiJm39YRbBSVjNz8wNp6/ddwi
X-Google-Smtp-Source: ABdhPJzpRaGkv/AeS2mGRekr9VX6LgH+E1Xi4eIXn8LZaC58udxuB33cxstvybyUg3CZDHEZpwNkHBp9Zg6d5/+y6+ggiC6YLbFq
MIME-Version: 1.0
X-Received: by 2002:a05:6602:164c:: with SMTP id y12mr42180306iow.78.1621241533833;
 Mon, 17 May 2021 01:52:13 -0700 (PDT)
Date:   Mon, 17 May 2021 01:52:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b82bdb05c282b5ff@google.com>
Subject: [syzbot] memory leak in snd_ctl_led_register
From:   syzbot <syzbot+08a7d8b51ea048a74ffb@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e4866123 Merge tag 's390-5.13-2' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1052b345d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e724a3033c441e3
dashboard link: https://syzkaller.appspot.com/bug?extid=08a7d8b51ea048a74ffb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117d4593d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100509b3d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+08a7d8b51ea048a74ffb@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888113a0ca00 (size 256):
  comm "kworker/1:1", pid 35, jiffies 4294942586 (age 13.780s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 ca a0 13 81 88 ff ff  ................
    08 ca a0 13 81 88 ff ff a0 5c 60 82 ff ff ff ff  .........\`.....
  backtrace:
    [<ffffffff8260b58c>] kmalloc include/linux/slab.h:556 [inline]
    [<ffffffff8260b58c>] kzalloc include/linux/slab.h:686 [inline]
    [<ffffffff8260b58c>] device_private_init drivers/base/core.c:3161 [inline]
    [<ffffffff8260b58c>] device_add+0x85c/0xd70 drivers/base/core.c:3211
    [<ffffffff8356aaef>] snd_ctl_led_sysfs_add sound/core/control_led.c:670 [inline]
    [<ffffffff8356aaef>] snd_ctl_led_register+0x1af/0x2f0 sound/core/control_led.c:361
    [<ffffffff8355e0a8>] snd_ctl_dev_register+0x78/0xb0 sound/core/control.c:2156
    [<ffffffff83563fab>] __snd_device_register sound/core/device.c:149 [inline]
    [<ffffffff83563fab>] __snd_device_register sound/core/device.c:145 [inline]
    [<ffffffff83563fab>] snd_device_register_all+0x7b/0xd0 sound/core/device.c:197
    [<ffffffff8355ccc0>] snd_card_register+0x90/0x2b0 sound/core/init.c:773
    [<ffffffff83648737>] usX2Y_usb_probe sound/usb/usx2y/usbusx2y.c:382 [inline]
    [<ffffffff83648737>] snd_usX2Y_probe+0x277/0x2f0 sound/usb/usx2y/usbusx2y.c:398
    [<ffffffff82bcf687>] usb_probe_interface+0x177/0x370 drivers/usb/core/driver.c:396
    [<ffffffff82610359>] really_probe+0x159/0x500 drivers/base/dd.c:576
    [<ffffffff8261078b>] driver_probe_device+0x8b/0x100 drivers/base/dd.c:763
    [<ffffffff82610eb6>] __device_attach_driver+0xf6/0x120 drivers/base/dd.c:870
    [<ffffffff8260d247>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:431
    [<ffffffff82610a32>] __device_attach+0x122/0x260 drivers/base/dd.c:938
    [<ffffffff8260eee6>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:491
    [<ffffffff8260b305>] device_add+0x5d5/0xd70 drivers/base/core.c:3319
    [<ffffffff82bccc29>] usb_set_configuration+0x9d9/0xb90 drivers/usb/core/message.c:2164
    [<ffffffff82bdcfbc>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238

BUG: memory leak
unreferenced object 0xffff888113a0c900 (size 256):
  comm "kworker/1:1", pid 35, jiffies 4294942586 (age 13.780s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 c9 a0 13 81 88 ff ff  ................
    08 c9 a0 13 81 88 ff ff a0 5c 60 82 ff ff ff ff  .........\`.....
  backtrace:
    [<ffffffff8260b58c>] kmalloc include/linux/slab.h:556 [inline]
    [<ffffffff8260b58c>] kzalloc include/linux/slab.h:686 [inline]
    [<ffffffff8260b58c>] device_private_init drivers/base/core.c:3161 [inline]
    [<ffffffff8260b58c>] device_add+0x85c/0xd70 drivers/base/core.c:3211
    [<ffffffff8356aaef>] snd_ctl_led_sysfs_add sound/core/control_led.c:670 [inline]
    [<ffffffff8356aaef>] snd_ctl_led_register+0x1af/0x2f0 sound/core/control_led.c:361
    [<ffffffff8355e0a8>] snd_ctl_dev_register+0x78/0xb0 sound/core/control.c:2156
    [<ffffffff83563fab>] __snd_device_register sound/core/device.c:149 [inline]
    [<ffffffff83563fab>] __snd_device_register sound/core/device.c:145 [inline]
    [<ffffffff83563fab>] snd_device_register_all+0x7b/0xd0 sound/core/device.c:197
    [<ffffffff8355ccc0>] snd_card_register+0x90/0x2b0 sound/core/init.c:773
    [<ffffffff83648737>] usX2Y_usb_probe sound/usb/usx2y/usbusx2y.c:382 [inline]
    [<ffffffff83648737>] snd_usX2Y_probe+0x277/0x2f0 sound/usb/usx2y/usbusx2y.c:398
    [<ffffffff82bcf687>] usb_probe_interface+0x177/0x370 drivers/usb/core/driver.c:396
    [<ffffffff82610359>] really_probe+0x159/0x500 drivers/base/dd.c:576
    [<ffffffff8261078b>] driver_probe_device+0x8b/0x100 drivers/base/dd.c:763
    [<ffffffff82610eb6>] __device_attach_driver+0xf6/0x120 drivers/base/dd.c:870
    [<ffffffff8260d247>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:431
    [<ffffffff82610a32>] __device_attach+0x122/0x260 drivers/base/dd.c:938
    [<ffffffff8260eee6>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:491
    [<ffffffff8260b305>] device_add+0x5d5/0xd70 drivers/base/core.c:3319
    [<ffffffff82bccc29>] usb_set_configuration+0x9d9/0xb90 drivers/usb/core/message.c:2164
    [<ffffffff82bdcfbc>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238

BUG: memory leak
unreferenced object 0xffff888112c771c0 (size 32):
  comm "kworker/1:1", pid 35, jiffies 4294943217 (age 7.470s)
  hex dump (first 32 bytes):
    63 61 72 64 33 00 00 00 00 00 00 00 00 00 00 00  card3...........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82253d3c>] kvasprintf+0x6c/0xf0 lib/kasprintf.c:25
    [<ffffffff82253e18>] kvasprintf_const+0x58/0x110 lib/kasprintf.c:49
    [<ffffffff8231b16b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:289
    [<ffffffff82605c03>] dev_set_name+0x63/0x90 drivers/base/core.c:3105
    [<ffffffff8356aabe>] snd_ctl_led_sysfs_add sound/core/control_led.c:666 [inline]
    [<ffffffff8356aabe>] snd_ctl_led_register+0x17e/0x2f0 sound/core/control_led.c:361
    [<ffffffff8355e0a8>] snd_ctl_dev_register+0x78/0xb0 sound/core/control.c:2156
    [<ffffffff83563fab>] __snd_device_register sound/core/device.c:149 [inline]
    [<ffffffff83563fab>] __snd_device_register sound/core/device.c:145 [inline]
    [<ffffffff83563fab>] snd_device_register_all+0x7b/0xd0 sound/core/device.c:197
    [<ffffffff8355ccc0>] snd_card_register+0x90/0x2b0 sound/core/init.c:773
    [<ffffffff83648737>] usX2Y_usb_probe sound/usb/usx2y/usbusx2y.c:382 [inline]
    [<ffffffff83648737>] snd_usX2Y_probe+0x277/0x2f0 sound/usb/usx2y/usbusx2y.c:398
    [<ffffffff82bcf687>] usb_probe_interface+0x177/0x370 drivers/usb/core/driver.c:396
    [<ffffffff82610359>] really_probe+0x159/0x500 drivers/base/dd.c:576
    [<ffffffff8261078b>] driver_probe_device+0x8b/0x100 drivers/base/dd.c:763
    [<ffffffff82610eb6>] __device_attach_driver+0xf6/0x120 drivers/base/dd.c:870
    [<ffffffff8260d247>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:431
    [<ffffffff82610a32>] __device_attach+0x122/0x260 drivers/base/dd.c:938
    [<ffffffff8260eee6>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:491



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

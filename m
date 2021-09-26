Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE57418564
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 03:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhIZB37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 21:29:59 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:47965 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhIZB36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 21:29:58 -0400
Received: by mail-io1-f69.google.com with SMTP id t4-20020a056602140400b005d60162d0c4so15412975iov.14
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 18:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=HNCIZF7mMlfTzdEwJGaHpKL1MIacRllG7TXjajL083s=;
        b=cXcrmnEmC8XdfS2yf7bfUDwGAhJa9lN/sBqq+v6dafT55eE3KPFxtXrezqdBo4xPOV
         ILeqUAsVyzVpmf/vzJZxZjLTCWiUFGnC0GZYLNX2uvSOrG9tQcsR2B718KBNJBdrkjz/
         OO/7dMF8/OhH9PT0MrYNSyTMHCQ7RnX7b7D7yCLTQx2JvwIeSKryUNtZK90Kb0JBUJ8u
         Ve1gJczsg83+DPPLoSQCertQKFQqzD3AWG+mfOBHClpvVKXuyo+Q2q4NHjr4wTwCHNNi
         SjgWIqoSl+Hbd6byPBHBe+/6U0UhESkg7B5wlYo9OcqDvqzjMBFWTKbaLM4ufOJHHCCX
         7t+A==
X-Gm-Message-State: AOAM531LrV8Va9NXENQTTonggiB23UrOPhBIHStVXkR11PcayLWWs0Xs
        swk9o7NKYKYU8ahfa/vgMZkxzijKyEkxsS1YHv0+pBKSg8UV
X-Google-Smtp-Source: ABdhPJw5wPMMCNyGOHzL/mAmzeRqxUeX0tr68es6eY99cKPWWPFdDF73yOMIGvljAXTcl2knYwIN6GywOjuTG97447CqxtLBb6Nu
MIME-Version: 1.0
X-Received: by 2002:a5d:8183:: with SMTP id u3mr14715404ion.67.1632619702363;
 Sat, 25 Sep 2021 18:28:22 -0700 (PDT)
Date:   Sat, 25 Sep 2021 18:28:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069acee05ccdbe5a7@google.com>
Subject: [syzbot] memory leak in __mdiobus_register
From:   syzbot <syzbot+398e7dc692ddbbb4cfec@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d9fb678414c0 Merge tag 'afs-fixes-20210913' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=131c754b300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f0de362a1f17687e
dashboard link: https://syzkaller.appspot.com/bug?extid=398e7dc692ddbbb4cfec
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145650d1300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105ccde7300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+398e7dc692ddbbb4cfec@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888114032e00 (size 256):
  comm "kworker/1:3", pid 2960, jiffies 4294943572 (age 15.920s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 2e 03 14 81 88 ff ff  ................
    08 2e 03 14 81 88 ff ff 90 76 65 82 ff ff ff ff  .........ve.....
  backtrace:
    [<ffffffff8265cfab>] kmalloc include/linux/slab.h:591 [inline]
    [<ffffffff8265cfab>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff8265cfab>] device_private_init drivers/base/core.c:3203 [inline]
    [<ffffffff8265cfab>] device_add+0x89b/0xdf0 drivers/base/core.c:3253
    [<ffffffff828dd643>] __mdiobus_register+0xc3/0x450 drivers/net/phy/mdio_bus.c:537
    [<ffffffff828cb835>] __devm_mdiobus_register+0x75/0xf0 drivers/net/phy/mdio_devres.c:87
    [<ffffffff82b92a00>] ax88772_init_mdio drivers/net/usb/asix_devices.c:676 [inline]
    [<ffffffff82b92a00>] ax88772_bind+0x330/0x480 drivers/net/usb/asix_devices.c:786
    [<ffffffff82baa33f>] usbnet_probe+0x3ff/0xdf0 drivers/net/usb/usbnet.c:1745
    [<ffffffff82c36e17>] usb_probe_interface+0x177/0x370 drivers/usb/core/driver.c:396
    [<ffffffff82661d17>] call_driver_probe drivers/base/dd.c:517 [inline]
    [<ffffffff82661d17>] really_probe.part.0+0xe7/0x380 drivers/base/dd.c:596
    [<ffffffff826620bc>] really_probe drivers/base/dd.c:558 [inline]
    [<ffffffff826620bc>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:751
    [<ffffffff826621ba>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:781
    [<ffffffff82662a26>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:898
    [<ffffffff8265eca7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff826625a2>] __device_attach+0x122/0x260 drivers/base/dd.c:969
    [<ffffffff82660916>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:487
    [<ffffffff8265cd0b>] device_add+0x5fb/0xdf0 drivers/base/core.c:3359
    [<ffffffff82c343b9>] usb_set_configuration+0x9d9/0xb90 drivers/usb/core/message.c:2170
    [<ffffffff82c4473c>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238

BUG: memory leak
unreferenced object 0xffff888116f06900 (size 32):
  comm "kworker/0:2", pid 2670, jiffies 4294944448 (age 7.160s)
  hex dump (first 32 bytes):
    75 73 62 2d 30 30 31 3a 30 30 33 00 00 00 00 00  usb-001:003.....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81484516>] kstrdup+0x36/0x70 mm/util.c:60
    [<ffffffff814845a3>] kstrdup_const+0x53/0x80 mm/util.c:83
    [<ffffffff82296ba2>] kvasprintf_const+0xc2/0x110 lib/kasprintf.c:48
    [<ffffffff82358d4b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:289
    [<ffffffff826575f3>] dev_set_name+0x63/0x90 drivers/base/core.c:3147
    [<ffffffff828dd63b>] __mdiobus_register+0xbb/0x450 drivers/net/phy/mdio_bus.c:535
    [<ffffffff828cb835>] __devm_mdiobus_register+0x75/0xf0 drivers/net/phy/mdio_devres.c:87
    [<ffffffff82b92a00>] ax88772_init_mdio drivers/net/usb/asix_devices.c:676 [inline]
    [<ffffffff82b92a00>] ax88772_bind+0x330/0x480 drivers/net/usb/asix_devices.c:786
    [<ffffffff82baa33f>] usbnet_probe+0x3ff/0xdf0 drivers/net/usb/usbnet.c:1745
    [<ffffffff82c36e17>] usb_probe_interface+0x177/0x370 drivers/usb/core/driver.c:396
    [<ffffffff82661d17>] call_driver_probe drivers/base/dd.c:517 [inline]
    [<ffffffff82661d17>] really_probe.part.0+0xe7/0x380 drivers/base/dd.c:596
    [<ffffffff826620bc>] really_probe drivers/base/dd.c:558 [inline]
    [<ffffffff826620bc>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:751
    [<ffffffff826621ba>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:781
    [<ffffffff82662a26>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:898
    [<ffffffff8265eca7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff826625a2>] __device_attach+0x122/0x260 drivers/base/dd.c:969



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

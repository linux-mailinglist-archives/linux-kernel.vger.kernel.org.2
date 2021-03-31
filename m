Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445CD35074C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 21:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbhCaTS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 15:18:27 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:41716 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbhCaTSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 15:18:15 -0400
Received: by mail-il1-f197.google.com with SMTP id g11so2284284ilc.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 12:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zI5rz79lvwSeB44SWVVZPpyrakLxjesZfijHo0YURIM=;
        b=iWLgyO1lqprqXP1wPbidEMS0nE8zDTGw8QrpvWSBRrdnsaQTHuUa7WBTWagxvyvuKs
         XLBTSf2QzC6tMDa9YzxfYinQTk13tSC//VwcwztzTb5WCIpGF4qZzUYAISXDM+bFrBQT
         kArvvAM6HVFAd1X35woNqw7jFoni911wFkekKvxaKTAL9gw/LPvaNGdgBE0ns6bJ7otB
         8RukXzy6NYirIHvSg99Ar7UjQWON+Y1eKzGwGBJgKeJQe1i3gAAWZCOJVt+6us4wIv2m
         bhfklSX8mwg10IBzZMhGXyXDoil5tlmG/dPUGfhWyqWwqgUdwYeJAUFZTjbwoAquWkA9
         NzEQ==
X-Gm-Message-State: AOAM5334/t5ujJvs3G5TVD4IbAbidOXEMGQnfiTHyviASfqmybG7kYFc
        +lKJny7gIpEFbWNA22YMtdZns5RKKDsPWGobJvKsL4rXGd8C
X-Google-Smtp-Source: ABdhPJzEAeCWDEVGLDiG0xJyfXDqxE1ox/wzziCBmS4IFhCcdS+LnHaSpE5wOfDF/TG3zQMabHvf39+0yr2wo7O1B070EDESvDUX
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:eaf:: with SMTP id u15mr3502042ilj.45.1617218295308;
 Wed, 31 Mar 2021 12:18:15 -0700 (PDT)
Date:   Wed, 31 Mar 2021 12:18:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000004274005bed9fa32@google.com>
Subject: [syzbot] memory leak in hdcs_probe_1020
From:   syzbot <syzbot+990626a4ef6f043ed4cd@syzkaller.appspotmail.com>
To:     hverkuil@xs4all.nl, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mchehab@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0f4498ce Merge tag 'for-5.12/dm-fixes-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e1514ad00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=49f2683f4e7a4347
dashboard link: https://syzkaller.appspot.com/bug?extid=990626a4ef6f043ed4cd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fb3d9ed00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117539aad00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+990626a4ef6f043ed4cd@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888110dd9f00 (size 64):
  comm "kworker/0:0", pid 5, jiffies 4294944081 (age 15.000s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 18 00 00 00  ................
    04 00 00 00 60 01 00 00 30 01 00 00 04 00 00 00  ....`...0.......
  backtrace:
    [<ffffffff8424c055>] kmalloc include/linux/slab.h:554 [inline]
    [<ffffffff8424c055>] hdcs_probe_1020 drivers/media/usb/gspca/stv06xx/stv06xx_hdcs.c:428 [inline]
    [<ffffffff8424c055>] hdcs_probe_1020.cold+0x39/0x96 drivers/media/usb/gspca/stv06xx/stv06xx_hdcs.c:413
    [<ffffffff82fe2db7>] stv06xx_config+0x107/0x190 drivers/media/usb/gspca/stv06xx/stv06xx.c:575
    [<ffffffff842427ca>] gspca_dev_probe2+0x359/0x6c5 drivers/media/usb/gspca/gspca.c:1529
    [<ffffffff84242b78>] gspca_dev_probe.cold+0x42/0x4a drivers/media/usb/gspca/gspca.c:1606
    [<ffffffff82ba7c87>] usb_probe_interface+0x177/0x370 drivers/usb/core/driver.c:396
    [<ffffffff825f6079>] really_probe+0x159/0x4a0 drivers/base/dd.c:554
    [<ffffffff825f6444>] driver_probe_device+0x84/0x100 drivers/base/dd.c:740
    [<ffffffff825f6b5e>] __device_attach_driver+0xee/0x110 drivers/base/dd.c:846
    [<ffffffff825f2ff7>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:431
    [<ffffffff825f66f2>] __device_attach+0x122/0x250 drivers/base/dd.c:914
    [<ffffffff825f4c96>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:491
    [<ffffffff825f11e5>] device_add+0x5d5/0xc40 drivers/base/core.c:3242
    [<ffffffff82ba5229>] usb_set_configuration+0x9d9/0xb90 drivers/usb/core/message.c:2164
    [<ffffffff82bb568c>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<ffffffff82ba73ec>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<ffffffff825f6079>] really_probe+0x159/0x4a0 drivers/base/dd.c:554



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

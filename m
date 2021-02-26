Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED31326455
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 15:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhBZOsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 09:48:05 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:40248 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhBZOsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:48:01 -0500
Received: by mail-il1-f198.google.com with SMTP id j7so7238795ilu.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 06:47:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=W1S5B4bK9C7BXUt+vz8qQzy7anosGhMHUOVweTQwoOg=;
        b=Mmgcikhi8aPiUQzLbKS7TLmmoeCegH99+KN2NUhrBqQ9gOKduFZRO7AanabkWcYFsg
         Du2ZEXKgvStHDqO64Uj1LO6vNPWBfz1LWshZomFgDOWck9j7cpvNFZdWX8+TfC4Ue38/
         Gp21QW7GPVxzxecm7mwIh7RCKWbCDBdrF328i7PFJj6i1Jyr5EHG0hbNkjVp85OHmKF4
         PPIbat3CKAvIr3h6mutTjU+M7zoTNTxPLHeROZs6i1ZehYA83/PNyz95VrRS9mC+bj5K
         DZEFjz/Y33lfo2o2Mb2izmt2S4LRkRbNUDf4YH5PZOfgQT+apGE0QH9EVsAmbQ6gSioj
         4uIw==
X-Gm-Message-State: AOAM5313BS9mz+8hMBqJWh5YWiCO+WpokNrkESx9bqaA0h0pr9Q4v3ax
        rPQY2pa5s8UpY7coNMdkI5xboU1o/WToauiqV7cL2q9pl5TG
X-Google-Smtp-Source: ABdhPJz/PllE9/nxt7h+qRzHkPZSV4FFXIwC2e0lrQcQ6BPQLcDN74jfrJ+0RfthOE/Nzx09N9/p3qQ6Ig2egMaKlbzjzxKkZNFZ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1806:: with SMTP id a6mr2733423ilv.8.1614350840203;
 Fri, 26 Feb 2021 06:47:20 -0800 (PST)
Date:   Fri, 26 Feb 2021 06:47:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005f907b05bc3e584e@google.com>
Subject: memory leak in hdcs_probe_1x00
From:   syzbot <syzbot+e7f4c64a4248a0340c37@syzkaller.appspotmail.com>
To:     hverkuil@xs4all.nl, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mchehab@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2c87f7a3 Merge tag 'pwm/for-5.12-rc1' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16400946d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3dfc598676a6f0b5
dashboard link: https://syzkaller.appspot.com/bug?extid=e7f4c64a4248a0340c37
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123a6632d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1689a292d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e7f4c64a4248a0340c37@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff8881100c0300 (size 64):
  comm "kworker/0:3", pid 3861, jiffies 4294943205 (age 14.560s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 08 00 00 00  ................
    08 00 00 00 68 01 00 00 28 01 00 00 04 00 00 00  ....h...(.......
  backtrace:
    [<000000004eb4188f>] kmalloc include/linux/slab.h:554 [inline]
    [<000000004eb4188f>] hdcs_probe_1x00 drivers/media/usb/gspca/stv06xx/stv06xx_hdcs.c:371 [inline]
    [<000000004eb4188f>] hdcs_probe_1x00.cold+0x39/0xc1 drivers/media/usb/gspca/stv06xx/stv06xx_hdcs.c:356
    [<0000000031bd6da6>] stv06xx_config+0xdf/0x190 drivers/media/usb/gspca/stv06xx/stv06xx.c:571
    [<000000007be62196>] gspca_dev_probe2+0x359/0x6c5 drivers/media/usb/gspca/gspca.c:1529
    [<00000000afeef2a3>] gspca_dev_probe.cold+0x42/0x4a drivers/media/usb/gspca/gspca.c:1606
    [<000000006d63a9d3>] usb_probe_interface+0x177/0x370 drivers/usb/core/driver.c:396
    [<000000004f1fef67>] really_probe+0x159/0x4a0 drivers/base/dd.c:554
    [<00000000ced991e0>] driver_probe_device+0x84/0x100 drivers/base/dd.c:740
    [<000000001687c39d>] __device_attach_driver+0xee/0x110 drivers/base/dd.c:846
    [<0000000046da487b>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:431
    [<00000000df1d85bd>] __device_attach+0x122/0x250 drivers/base/dd.c:914
    [<00000000fa336975>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:491
    [<000000002214a827>] device_add+0x5d5/0xc40 drivers/base/core.c:3242
    [<00000000782f72d5>] usb_set_configuration+0x9d9/0xb90 drivers/usb/core/message.c:2164
    [<000000000815ea76>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<0000000028850013>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<000000004f1fef67>] really_probe+0x159/0x4a0 drivers/base/dd.c:554



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E500933D16E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 11:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236508AbhCPKJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 06:09:34 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:34840 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbhCPKJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 06:09:20 -0400
Received: by mail-il1-f199.google.com with SMTP id y8so4035769ill.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 03:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5WiJbVhzNFJgw/m/1/NQNnaFvQ7uA64sdgHOTVzhjbw=;
        b=rJYaF83Az3mtDKrUbZN4VlhL/EKCV7SiHU7mCsN8wjVMDkSEs/YcEs5IVTs5QrN70p
         FejFR9kCqrowfo8ROqsZfsjGnh0CXnBrhILWe+NPjUdsCc6lJCcz9C6bV3RxedeHfJmW
         vZLDZJNDWmaUUHjR63pAvlA4daAf3/m7wRt9v6AjWeZOIjLS9bTGwlDsaRA+FlC5+EtY
         aus+XJTO95iEjl8VQAYnV1REeRxWLWqwARXbPDWSdbHVEglsFlW8iqy6fWYV+cVwkDfK
         2QvMHAj5g1JzfjweHMvtjZ4LLm+GXBK1lurxbAPzWzky/o3m0XgHjkgkKfKgV8xhfiBF
         V7og==
X-Gm-Message-State: AOAM530+Qdo2QS+lYgL8amSG+ZR/TpVoya8Uvdz79x+VIJrM6bPbwA0T
        up2/X0G43AZjVJgD/8oaDXjnAaSTMWWPvQ1qPnRvcW+2dT5P
X-Google-Smtp-Source: ABdhPJypv2R7YhuQO/iH8LLvUQoxn08bn04FORZhETMszwg2fHQ1Eo/+lBcZM3fNg/XmmhJInveXlEF85+FtXENk6AiDVPL+ABy4
MIME-Version: 1.0
X-Received: by 2002:a92:7311:: with SMTP id o17mr3126840ilc.231.1615889359476;
 Tue, 16 Mar 2021 03:09:19 -0700 (PDT)
Date:   Tue, 16 Mar 2021 03:09:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000449ccf05bda48f08@google.com>
Subject: [syzbot] memory leak in em28xx_dvb_init
From:   syzbot <syzbot+889397c820fa56adf25d@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1a4431a5 Merge tag 'afs-fixes-20210315' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11013a7cd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff6b8b2e9d5a1227
dashboard link: https://syzkaller.appspot.com/bug?extid=889397c820fa56adf25d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1559ae3ad00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176985c6d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+889397c820fa56adf25d@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888110082700 (size 64):
  comm "kworker/1:2", pid 57, jiffies 4294943656 (age 13.350s)
  hex dump (first 32 bytes):
    c0 40 0d 0d 81 88 ff ff 40 4b 0d 0d 81 88 ff ff  .@......@K......
    c0 bc d4 0f 81 88 ff ff 00 b3 d4 0f 81 88 ff ff  ................
  backtrace:
    [<ffffffff8304c141>] kmalloc_array.constprop.0+0x41/0x60 include/linux/slab.h:594
    [<ffffffff8304dba2>] kcalloc include/linux/slab.h:623 [inline]
    [<ffffffff8304dba2>] em28xx_alloc_urbs+0x102/0x550 drivers/media/usb/em28xx/em28xx-core.c:930
    [<ffffffff84279fa7>] em28xx_dvb_init drivers/media/usb/em28xx/em28xx-dvb.c:1517 [inline]
    [<ffffffff84279fa7>] em28xx_dvb_init.cold+0xa3/0x2bb1 drivers/media/usb/em28xx/em28xx-dvb.c:1483
    [<ffffffff8304e33b>] em28xx_init_extension+0x9b/0xe0 drivers/media/usb/em28xx/em28xx-core.c:1126
    [<ffffffff83050143>] request_module_async+0x33/0x40 drivers/media/usb/em28xx/em28xx-cards.c:3406
    [<ffffffff81259229>] process_one_work+0x2c9/0x600 kernel/workqueue.c:2275
    [<ffffffff81259dbb>] process_scheduled_works kernel/workqueue.c:2337 [inline]
    [<ffffffff81259dbb>] worker_thread+0x2fb/0x5d0 kernel/workqueue.c:2426
    [<ffffffff81261228>] kthread+0x178/0x1b0 kernel/kthread.c:292
    [<ffffffff8100227f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

BUG: memory leak
unreferenced object 0xffff8881100825c0 (size 64):
  comm "kworker/1:2", pid 57, jiffies 4294943656 (age 13.350s)
  hex dump (first 32 bytes):
    00 00 b8 10 81 88 ff ff 00 00 b8 0b 81 88 ff ff  ................
    00 00 b9 0b 81 88 ff ff 00 00 16 13 81 88 ff ff  ................
  backtrace:
    [<ffffffff8304c141>] kmalloc_array.constprop.0+0x41/0x60 include/linux/slab.h:594
    [<ffffffff8304dbbc>] kcalloc include/linux/slab.h:623 [inline]
    [<ffffffff8304dbbc>] em28xx_alloc_urbs+0x11c/0x550 drivers/media/usb/em28xx/em28xx-core.c:934
    [<ffffffff84279fa7>] em28xx_dvb_init drivers/media/usb/em28xx/em28xx-dvb.c:1517 [inline]
    [<ffffffff84279fa7>] em28xx_dvb_init.cold+0xa3/0x2bb1 drivers/media/usb/em28xx/em28xx-dvb.c:1483
    [<ffffffff8304e33b>] em28xx_init_extension+0x9b/0xe0 drivers/media/usb/em28xx/em28xx-core.c:1126
    [<ffffffff83050143>] request_module_async+0x33/0x40 drivers/media/usb/em28xx/em28xx-cards.c:3406
    [<ffffffff81259229>] process_one_work+0x2c9/0x600 kernel/workqueue.c:2275
    [<ffffffff81259dbb>] process_scheduled_works kernel/workqueue.c:2337 [inline]
    [<ffffffff81259dbb>] worker_thread+0x2fb/0x5d0 kernel/workqueue.c:2426
    [<ffffffff81261228>] kthread+0x178/0x1b0 kernel/kthread.c:292
    [<ffffffff8100227f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

BUG: memory leak
unreferenced object 0xffff88810d0d40c0 (size 192):
  comm "kworker/1:2", pid 57, jiffies 4294943656 (age 13.350s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 d8 40 0d 0d 81 88 ff ff  .........@......
  backtrace:
    [<ffffffff82b9eda6>] kmalloc include/linux/slab.h:559 [inline]
    [<ffffffff82b9eda6>] usb_alloc_urb+0x66/0xe0 drivers/usb/core/urb.c:74
    [<ffffffff8304dd07>] em28xx_alloc_urbs+0x267/0x550 drivers/media/usb/em28xx/em28xx-core.c:952
    [<ffffffff84279fa7>] em28xx_dvb_init drivers/media/usb/em28xx/em28xx-dvb.c:1517 [inline]
    [<ffffffff84279fa7>] em28xx_dvb_init.cold+0xa3/0x2bb1 drivers/media/usb/em28xx/em28xx-dvb.c:1483
    [<ffffffff8304e33b>] em28xx_init_extension+0x9b/0xe0 drivers/media/usb/em28xx/em28xx-core.c:1126
    [<ffffffff83050143>] request_module_async+0x33/0x40 drivers/media/usb/em28xx/em28xx-cards.c:3406
    [<ffffffff81259229>] process_one_work+0x2c9/0x600 kernel/workqueue.c:2275
    [<ffffffff81259dbb>] process_scheduled_works kernel/workqueue.c:2337 [inline]
    [<ffffffff81259dbb>] worker_thread+0x2fb/0x5d0 kernel/workqueue.c:2426
    [<ffffffff81261228>] kthread+0x178/0x1b0 kernel/kthread.c:292
    [<ffffffff8100227f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

BUG: memory leak
unreferenced object 0xffff88810d0d4b40 (size 192):
  comm "kworker/1:2", pid 57, jiffies 4294943656 (age 13.350s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 58 4b 0d 0d 81 88 ff ff  ........XK......
  backtrace:
    [<ffffffff82b9eda6>] kmalloc include/linux/slab.h:559 [inline]
    [<ffffffff82b9eda6>] usb_alloc_urb+0x66/0xe0 drivers/usb/core/urb.c:74
    [<ffffffff8304dd07>] em28xx_alloc_urbs+0x267/0x550 drivers/media/usb/em28xx/em28xx-core.c:952
    [<ffffffff84279fa7>] em28xx_dvb_init drivers/media/usb/em28xx/em28xx-dvb.c:1517 [inline]
    [<ffffffff84279fa7>] em28xx_dvb_init.cold+0xa3/0x2bb1 drivers/media/usb/em28xx/em28xx-dvb.c:1483
    [<ffffffff8304e33b>] em28xx_init_extension+0x9b/0xe0 drivers/media/usb/em28xx/em28xx-core.c:1126
    [<ffffffff83050143>] request_module_async+0x33/0x40 drivers/media/usb/em28xx/em28xx-cards.c:3406
    [<ffffffff81259229>] process_one_work+0x2c9/0x600 kernel/workqueue.c:2275
    [<ffffffff81259dbb>] process_scheduled_works kernel/workqueue.c:2337 [inline]
    [<ffffffff81259dbb>] worker_thread+0x2fb/0x5d0 kernel/workqueue.c:2426
    [<ffffffff81261228>] kthread+0x178/0x1b0 kernel/kthread.c:292
    [<ffffffff8100227f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

BUG: memory leak
unreferenced object 0xffff88810fd4bcc0 (size 192):
  comm "kworker/1:2", pid 57, jiffies 4294943656 (age 13.350s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 d8 bc d4 0f 81 88 ff ff  ................
  backtrace:
    [<ffffffff82b9eda6>] kmalloc include/linux/slab.h:559 [inline]
    [<ffffffff82b9eda6>] usb_alloc_urb+0x66/0xe0 drivers/usb/core/urb.c:74
    [<ffffffff8304dd07>] em28xx_alloc_urbs+0x267/0x550 drivers/media/usb/em28xx/em28xx-core.c:952
    [<ffffffff84279fa7>] em28xx_dvb_init drivers/media/usb/em28xx/em28xx-dvb.c:1517 [inline]
    [<ffffffff84279fa7>] em28xx_dvb_init.cold+0xa3/0x2bb1 drivers/media/usb/em28xx/em28xx-dvb.c:1483
    [<ffffffff8304e33b>] em28xx_init_extension+0x9b/0xe0 drivers/media/usb/em28xx/em28xx-core.c:1126
    [<ffffffff83050143>] request_module_async+0x33/0x40 drivers/media/usb/em28xx/em28xx-cards.c:3406
    [<ffffffff81259229>] process_one_work+0x2c9/0x600 kernel/workqueue.c:2275
    [<ffffffff81259dbb>] process_scheduled_works kernel/workqueue.c:2337 [inline]
    [<ffffffff81259dbb>] worker_thread+0x2fb/0x5d0 kernel/workqueue.c:2426
    [<ffffffff81261228>] kthread+0x178/0x1b0 kernel/kthread.c:292
    [<ffffffff8100227f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

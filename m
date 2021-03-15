Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B3933AA83
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 05:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhCOEih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 00:38:37 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:40703 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhCOEiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 00:38:15 -0400
Received: by mail-il1-f197.google.com with SMTP id j7so23475331ilu.7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 21:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=diYvy2DgYzQd4xMt3hZgbe5SyNhdYftQCAAqge3ISJ4=;
        b=Fo8D0Ek7GBOUSbDLzdA/7UgoyWRaPKdJSoN01UgLUagLDoF+pta6oLbOwTJI1R7a3X
         vveqgel1l/qVqUl0Pa9hXrgCkIPCDfPMDB3e4iUCwxLZJESzeXuALeLNopJ6k2UiCN2f
         usxVBkpp1KONpDbM8Ajbj3cNAKyxsPzyW9D74fVnnxeWaBqHjOWpC5LtzEwmfSxbJjLq
         Q/iJCq7gxrlI7z17Dih9Y7uHPOL/YUg3iuDggaxVPKkRFxQnQiWFEbx+QHDon501fQF1
         3lQOqr5F5ragIZOs3WEiYq0oK6kgbEncJZTf10skII60+cRGOCEPsZ73Vn7cpQpfUr8M
         HCWA==
X-Gm-Message-State: AOAM5323HQmRsdnnsn4auqw3x/cpjOT8eZySzwF37zFWXxZBLfdJY4VJ
        moRdTN0hbUUQqrIdvM7wG2SCGpdjyqvbTdGRWzoCieYCEfy9
X-Google-Smtp-Source: ABdhPJz5P91P7/VV0fOMLaweY2oSJz2o1Bs87dY4mAa47DpoH4eKU8ggFvPzTcOeDenUPJdKvuuYfLUlJ1Yil/uOefsrhMy4pm3b
MIME-Version: 1.0
X-Received: by 2002:a92:3652:: with SMTP id d18mr10615431ilf.100.1615783094993;
 Sun, 14 Mar 2021 21:38:14 -0700 (PDT)
Date:   Sun, 14 Mar 2021 21:38:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000694b0805bd8bd16c@google.com>
Subject: [syzbot] memory leak in hub_event (2)
From:   syzbot <syzbot+636c58f40a86b4a879e7@syzkaller.appspotmail.com>
To:     a.darwish@linutronix.de, balbi@kernel.org, bigeasy@linutronix.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    05a59d79 Merge git://git.kernel.org:/pub/scm/linux/kernel/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=164e6ba2d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=796675cee501159f
dashboard link: https://syzkaller.appspot.com/bug?extid=636c58f40a86b4a879e7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111849ecd00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16037376d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+636c58f40a86b4a879e7@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888109985800 (size 2048):
  comm "kworker/1:1", pid 35, jiffies 4294966369 (age 27.230s)
  hex dump (first 32 bytes):
    ff ff ff ff 31 00 00 00 00 00 00 00 00 00 00 00  ....1...........
    00 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00  ................
  backtrace:
    [<000000004dfe56d1>] kmalloc include/linux/slab.h:554 [inline]
    [<000000004dfe56d1>] kzalloc include/linux/slab.h:684 [inline]
    [<000000004dfe56d1>] usb_alloc_dev+0x32/0x450 drivers/usb/core/usb.c:582
    [<00000000d2920859>] hub_port_connect drivers/usb/core/hub.c:5129 [inline]
    [<00000000d2920859>] hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
    [<00000000d2920859>] port_event drivers/usb/core/hub.c:5509 [inline]
    [<00000000d2920859>] hub_event+0x1171/0x20c0 drivers/usb/core/hub.c:5591
    [<0000000099d99129>] process_one_work+0x2c9/0x600 kernel/workqueue.c:2275
    [<00000000a83d9aee>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2421
    [<00000000aaaf0fda>] kthread+0x178/0x1b0 kernel/kthread.c:292
    [<00000000d2888c70>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

BUG: memory leak
unreferenced object 0xffff88810cec9900 (size 32):
  comm "kworker/1:1", pid 35, jiffies 4294966421 (age 26.710s)
  hex dump (first 32 bytes):
    00 65 d0 10 81 88 ff ff 00 00 00 00 00 00 00 00  .e..............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000008a69447c>] kmalloc include/linux/slab.h:559 [inline]
    [<000000008a69447c>] kzalloc include/linux/slab.h:684 [inline]
    [<000000008a69447c>] usb_get_configuration+0xce/0x1dd0 drivers/usb/core/config.c:887
    [<00000000a636fc1f>] usb_enumerate_device drivers/usb/core/hub.c:2388 [inline]
    [<00000000a636fc1f>] usb_new_device+0x1a9/0x2e0 drivers/usb/core/hub.c:2524
    [<0000000024685ce9>] hub_port_connect drivers/usb/core/hub.c:5223 [inline]
    [<0000000024685ce9>] hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
    [<0000000024685ce9>] port_event drivers/usb/core/hub.c:5509 [inline]
    [<0000000024685ce9>] hub_event+0x142e/0x20c0 drivers/usb/core/hub.c:5591
    [<0000000099d99129>] process_one_work+0x2c9/0x600 kernel/workqueue.c:2275
    [<00000000a83d9aee>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2421
    [<00000000aaaf0fda>] kthread+0x178/0x1b0 kernel/kthread.c:292
    [<00000000d2888c70>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

BUG: memory leak
unreferenced object 0xffff88810b1b75c0 (size 32):
  comm "kworker/1:1", pid 35, jiffies 4294966448 (age 26.440s)
  hex dump (first 32 bytes):
    73 79 7a 00 00 00 00 00 00 00 00 00 00 00 00 00  syz.............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000007889c4a2>] kmalloc include/linux/slab.h:559 [inline]
    [<000000007889c4a2>] usb_cache_string+0x8a/0xf0 drivers/usb/core/message.c:1025
    [<00000000c372c0b9>] usb_enumerate_device drivers/usb/core/hub.c:2398 [inline]
    [<00000000c372c0b9>] usb_new_device+0x98/0x2e0 drivers/usb/core/hub.c:2524
    [<0000000024685ce9>] hub_port_connect drivers/usb/core/hub.c:5223 [inline]
    [<0000000024685ce9>] hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
    [<0000000024685ce9>] port_event drivers/usb/core/hub.c:5509 [inline]
    [<0000000024685ce9>] hub_event+0x142e/0x20c0 drivers/usb/core/hub.c:5591
    [<0000000099d99129>] process_one_work+0x2c9/0x600 kernel/workqueue.c:2275
    [<00000000a83d9aee>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2421
    [<00000000aaaf0fda>] kthread+0x178/0x1b0 kernel/kthread.c:292
    [<00000000d2888c70>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

BUG: memory leak
unreferenced object 0xffff88810cec9800 (size 32):
  comm "kworker/1:1", pid 35, jiffies 4294966452 (age 26.400s)
  hex dump (first 32 bytes):
    73 79 7a 00 00 00 00 00 00 00 00 00 00 00 00 00  syz.............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000007889c4a2>] kmalloc include/linux/slab.h:559 [inline]
    [<000000007889c4a2>] usb_cache_string+0x8a/0xf0 drivers/usb/core/message.c:1025
    [<00000000b8074d2b>] usb_enumerate_device drivers/usb/core/hub.c:2399 [inline]
    [<00000000b8074d2b>] usb_new_device+0xae/0x2e0 drivers/usb/core/hub.c:2524
    [<0000000024685ce9>] hub_port_connect drivers/usb/core/hub.c:5223 [inline]
    [<0000000024685ce9>] hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
    [<0000000024685ce9>] port_event drivers/usb/core/hub.c:5509 [inline]
    [<0000000024685ce9>] hub_event+0x142e/0x20c0 drivers/usb/core/hub.c:5591
    [<0000000099d99129>] process_one_work+0x2c9/0x600 kernel/workqueue.c:2275
    [<00000000a83d9aee>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2421
    [<00000000aaaf0fda>] kthread+0x178/0x1b0 kernel/kthread.c:292
    [<00000000d2888c70>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

BUG: memory leak
unreferenced object 0xffff88810cec9140 (size 32):
  comm "kworker/1:1", pid 35, jiffies 4294966456 (age 26.360s)
  hex dump (first 32 bytes):
    73 79 7a 00 00 00 00 00 00 00 00 00 00 00 00 00  syz.............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000007889c4a2>] kmalloc include/linux/slab.h:559 [inline]
    [<000000007889c4a2>] usb_cache_string+0x8a/0xf0 drivers/usb/core/message.c:1025
    [<000000002dd0377f>] usb_enumerate_device drivers/usb/core/hub.c:2401 [inline]
    [<000000002dd0377f>] usb_new_device+0xc4/0x2e0 drivers/usb/core/hub.c:2524
    [<0000000024685ce9>] hub_port_connect drivers/usb/core/hub.c:5223 [inline]
    [<0000000024685ce9>] hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
    [<0000000024685ce9>] port_event drivers/usb/core/hub.c:5509 [inline]
    [<0000000024685ce9>] hub_event+0x142e/0x20c0 drivers/usb/core/hub.c:5591
    [<0000000099d99129>] process_one_work+0x2c9/0x600 kernel/workqueue.c:2275
    [<00000000a83d9aee>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2421
    [<00000000aaaf0fda>] kthread+0x178/0x1b0 kernel/kthread.c:292
    [<00000000d2888c70>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

BUG: memory leak
unreferenced object 0xffff8881101a8800 (size 256):
  comm "kworker/1:1", pid 35, jiffies 4294966459 (age 26.330s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 88 1a 10 81 88 ff ff  ................
    08 88 1a 10 81 88 ff ff 30 23 5e 82 ff ff ff ff  ........0#^.....
  backtrace:
    [<000000002a4ba0cb>] kmalloc include/linux/slab.h:554 [inline]
    [<000000002a4ba0cb>] kzalloc include/linux/slab.h:684 [inline]
    [<000000002a4ba0cb>] device_private_init drivers/base/core.c:3084 [inline]
    [<000000002a4ba0cb>] device_add+0x811/0xc40 drivers/base/core.c:3134
    [<00000000440fa047>] usb_new_device.cold+0x16a/0x582 drivers/usb/core/hub.c:2555
    [<0000000024685ce9>] hub_port_connect drivers/usb/core/hub.c:5223 [inline]
    [<0000000024685ce9>] hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
    [<0000000024685ce9>] port_event drivers/usb/core/hub.c:5509 [inline]
    [<0000000024685ce9>] hub_event+0x142e/0x20c0 drivers/usb/core/hub.c:5591
    [<0000000099d99129>] process_one_work+0x2c9/0x600 kernel/workqueue.c:2275
    [<00000000a83d9aee>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2421
    [<00000000aaaf0fda>] kthread+0x178/0x1b0 kernel/kthread.c:292
    [<00000000d2888c70>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

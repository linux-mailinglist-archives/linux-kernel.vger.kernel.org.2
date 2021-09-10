Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B67F406B1D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 14:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbhIJMCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 08:02:41 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:51005 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbhIJMCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 08:02:37 -0400
Received: by mail-il1-f197.google.com with SMTP id x4-20020a92b004000000b0022b3cb3b4deso1889705ilh.17
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 05:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Kqw3KOJ0hAkof7W58MnmW/e5NU9beZ5FxzmAgktwmu8=;
        b=8BP4fBdxHlr0piynUAosxst/DlBJvVfuX5JOFCZpptqQ6sn4o7d+hPPheLMHgLee8c
         0cLbnjdNGXCNknfSpuJdOMlMW+h7JdXFqHfJeaIcU6cRV11wW5eAI0snwK88iLYyVegE
         oySTNcyG07b4FuMqNMU7nVQ8Ox9fX9bVfzus1CUyhyA6t5F3cEQJaATl4gI2odUQErWq
         xyFUCV25Mi40TZKOpe3IQQLgI73sh53j4qqUCfsNkUUj2lZvmJtq7chG6/NP2XAMLHPq
         KN4/QZTfKyQVVIGDkV8UjdcCpZ9qmM3LzEPwjrZcBQNMQ1lzraA6JEqUrSO5w6SDoKsx
         WhIw==
X-Gm-Message-State: AOAM533CU4R7gjkGsiKWwDsJH/v3jem71hkr/2G+hsd8fqtQsVuIeEZQ
        c6btH2r8+9ve6gfeEae0Q5AlAiuGjIMmvdjQ6SGebpoKi2/H
X-Google-Smtp-Source: ABdhPJw1CqK6gFqJiL+HbU58scHkQc4Wl4YQO1gbNwzHJl9bKwbufW4PmrZX0k0stDFIkKMhhku0rpp0no+2OLHXdeduhoM9LoRc
MIME-Version: 1.0
X-Received: by 2002:a92:c80e:: with SMTP id v14mr6265170iln.57.1631275286128;
 Fri, 10 Sep 2021 05:01:26 -0700 (PDT)
Date:   Fri, 10 Sep 2021 05:01:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f5edbe05cba2df23@google.com>
Subject: [syzbot] memory leak in bsg_register_queue
From:   syzbot <syzbot+cfe9b7cf55bb54ed4e57@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0319b848b155 binfmt: a.out: Fix bogus semicolon
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1776fab5300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d196bb8b1e038c0
dashboard link: https://syzkaller.appspot.com/bug?extid=cfe9b7cf55bb54ed4e57
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b2e115300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f2147d300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cfe9b7cf55bb54ed4e57@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff8881170d6200 (size 256):
  comm "kworker/u4:4", pid 2996, jiffies 4294948949 (age 23.430s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 62 0d 17 81 88 ff ff  .........b......
    08 62 0d 17 81 88 ff ff 10 26 65 82 ff ff ff ff  .b.......&e.....
  backtrace:
    [<ffffffff82657f2b>] kmalloc include/linux/slab.h:591 [inline]
    [<ffffffff82657f2b>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff82657f2b>] device_private_init drivers/base/core.c:3203 [inline]
    [<ffffffff82657f2b>] device_add+0x89b/0xdf0 drivers/base/core.c:3253
    [<ffffffff81577864>] cdev_device_add+0x84/0xe0 fs/char_dev.c:549
    [<ffffffff822547ff>] bsg_register_queue+0x10f/0x1d0 block/bsg.c:206
    [<ffffffff82730abf>] scsi_sysfs_add_sdev+0x13f/0x380 drivers/scsi/scsi_sysfs.c:1376
    [<ffffffff8272e309>] scsi_sysfs_add_devices drivers/scsi/scsi_scan.c:1727 [inline]
    [<ffffffff8272e309>] scsi_finish_async_scan drivers/scsi/scsi_scan.c:1812 [inline]
    [<ffffffff8272e309>] do_scan_async+0x109/0x200 drivers/scsi/scsi_scan.c:1855
    [<ffffffff812752a4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff81263d1f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81264629>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126db28>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff8100234f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff8881170da100 (size 32):
  comm "kworker/u4:4", pid 2996, jiffies 4294948956 (age 23.360s)
  hex dump (first 32 bytes):
    38 3a 30 3a 30 3a 31 00 00 00 00 00 00 00 00 00  8:0:0:1.........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8147fc76>] kstrdup+0x36/0x70 mm/util.c:60
    [<ffffffff8147fd03>] kstrdup_const+0x53/0x80 mm/util.c:83
    [<ffffffff82293362>] kvasprintf_const+0xc2/0x110 lib/kasprintf.c:48
    [<ffffffff8235545b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:289
    [<ffffffff82652573>] dev_set_name+0x63/0x90 drivers/base/core.c:3147
    [<ffffffff822547d1>] bsg_register_queue+0xe1/0x1d0 block/bsg.c:201
    [<ffffffff82730abf>] scsi_sysfs_add_sdev+0x13f/0x380 drivers/scsi/scsi_sysfs.c:1376
    [<ffffffff8272e309>] scsi_sysfs_add_devices drivers/scsi/scsi_scan.c:1727 [inline]
    [<ffffffff8272e309>] scsi_finish_async_scan drivers/scsi/scsi_scan.c:1812 [inline]
    [<ffffffff8272e309>] do_scan_async+0x109/0x200 drivers/scsi/scsi_scan.c:1855
    [<ffffffff812752a4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff81263d1f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81264629>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126db28>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff8100234f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff8881157cde00 (size 256):
  comm "kworker/u4:4", pid 2996, jiffies 4294948956 (age 23.360s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 de 7c 15 81 88 ff ff  ..........|.....
    08 de 7c 15 81 88 ff ff 10 26 65 82 ff ff ff ff  ..|......&e.....
  backtrace:
    [<ffffffff82657f2b>] kmalloc include/linux/slab.h:591 [inline]
    [<ffffffff82657f2b>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff82657f2b>] device_private_init drivers/base/core.c:3203 [inline]
    [<ffffffff82657f2b>] device_add+0x89b/0xdf0 drivers/base/core.c:3253
    [<ffffffff81577864>] cdev_device_add+0x84/0xe0 fs/char_dev.c:549
    [<ffffffff822547ff>] bsg_register_queue+0x10f/0x1d0 block/bsg.c:206
    [<ffffffff82730abf>] scsi_sysfs_add_sdev+0x13f/0x380 drivers/scsi/scsi_sysfs.c:1376
    [<ffffffff8272e309>] scsi_sysfs_add_devices drivers/scsi/scsi_scan.c:1727 [inline]
    [<ffffffff8272e309>] scsi_finish_async_scan drivers/scsi/scsi_scan.c:1812 [inline]
    [<ffffffff8272e309>] do_scan_async+0x109/0x200 drivers/scsi/scsi_scan.c:1855
    [<ffffffff812752a4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff81263d1f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81264629>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126db28>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff8100234f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888110f3b620 (size 32):
  comm "kworker/u4:4", pid 2996, jiffies 4294948968 (age 23.240s)
  hex dump (first 32 bytes):
    38 3a 30 3a 30 3a 32 00 00 00 00 00 00 00 00 00  8:0:0:2.........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8147fc76>] kstrdup+0x36/0x70 mm/util.c:60
    [<ffffffff8147fd03>] kstrdup_const+0x53/0x80 mm/util.c:83
    [<ffffffff82293362>] kvasprintf_const+0xc2/0x110 lib/kasprintf.c:48
    [<ffffffff8235545b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:289
    [<ffffffff82652573>] dev_set_name+0x63/0x90 drivers/base/core.c:3147
    [<ffffffff822547d1>] bsg_register_queue+0xe1/0x1d0 block/bsg.c:201
    [<ffffffff82730abf>] scsi_sysfs_add_sdev+0x13f/0x380 drivers/scsi/scsi_sysfs.c:1376
    [<ffffffff8272e309>] scsi_sysfs_add_devices drivers/scsi/scsi_scan.c:1727 [inline]
    [<ffffffff8272e309>] scsi_finish_async_scan drivers/scsi/scsi_scan.c:1812 [inline]
    [<ffffffff8272e309>] do_scan_async+0x109/0x200 drivers/scsi/scsi_scan.c:1855
    [<ffffffff812752a4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff81263d1f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81264629>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126db28>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff8100234f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888114f6c160 (size 32):
  comm "kworker/u4:4", pid 2996, jiffies 4294948949 (age 24.710s)
  hex dump (first 32 bytes):
    38 3a 30 3a 30 3a 30 00 00 00 00 00 00 00 00 00  8:0:0:0.........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8147fc76>] kstrdup+0x36/0x70 mm/util.c:60
    [<ffffffff8147fd03>] kstrdup_const+0x53/0x80 mm/util.c:83
    [<ffffffff82293362>] kvasprintf_const+0xc2/0x110 lib/kasprintf.c:48
    [<ffffffff8235545b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:289
    [<ffffffff82652573>] dev_set_name+0x63/0x90 drivers/base/core.c:3147
    [<ffffffff822547d1>] bsg_register_queue+0xe1/0x1d0 block/bsg.c:201
    [<ffffffff82730abf>] scsi_sysfs_add_sdev+0x13f/0x380 drivers/scsi/scsi_sysfs.c:1376
    [<ffffffff8272e309>] scsi_sysfs_add_devices drivers/scsi/scsi_scan.c:1727 [inline]
    [<ffffffff8272e309>] scsi_finish_async_scan drivers/scsi/scsi_scan.c:1812 [inline]
    [<ffffffff8272e309>] do_scan_async+0x109/0x200 drivers/scsi/scsi_scan.c:1855
    [<ffffffff812752a4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff81263d1f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81264629>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126db28>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff8100234f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff8881170d6200 (size 256):
  comm "kworker/u4:4", pid 2996, jiffies 4294948949 (age 24.710s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 62 0d 17 81 88 ff ff  .........b......
    08 62 0d 17 81 88 ff ff 10 26 65 82 ff ff ff ff  .b.......&e.....
  backtrace:
    [<ffffffff82657f2b>] kmalloc include/linux/slab.h:591 [inline]
    [<ffffffff82657f2b>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff82657f2b>] device_private_init drivers/base/core.c:3203 [inline]
    [<ffffffff82657f2b>] device_add+0x89b/0xdf0 drivers/base/core.c:3253
    [<ffffffff81577864>] cdev_device_add+0x84/0xe0 fs/char_dev.c:549
    [<ffffffff822547ff>] bsg_register_queue+0x10f/0x1d0 block/bsg.c:206
    [<ffffffff82730abf>] scsi_sysfs_add_sdev+0x13f/0x380 drivers/scsi/scsi_sysfs.c:1376
    [<ffffffff8272e309>] scsi_sysfs_add_devices drivers/scsi/scsi_scan.c:1727 [inline]
    [<ffffffff8272e309>] scsi_finish_async_scan drivers/scsi/scsi_scan.c:1812 [inline]
    [<ffffffff8272e309>] do_scan_async+0x109/0x200 drivers/scsi/scsi_scan.c:1855
    [<ffffffff812752a4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff81263d1f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81264629>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126db28>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff8100234f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff8881170da100 (size 32):
  comm "kworker/u4:4", pid 2996, jiffies 4294948956 (age 24.640s)
  hex dump (first 32 bytes):
    38 3a 30 3a 30 3a 31 00 00 00 00 00 00 00 00 00  8:0:0:1.........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8147fc76>] kstrdup+0x36/0x70 mm/util.c:60
    [<ffffffff8147fd03>] kstrdup_const+0x53/0x80 mm/util.c:83
    [<ffffffff82293362>] kvasprintf_const+0xc2/0x110 lib/kasprintf.c:48
    [<ffffffff8235545b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:289
    [<ffffffff82652573>] dev_set_name+0x63/0x90 drivers/base/core.c:3147
    [<ffffffff822547d1>] bsg_register_queue+0xe1/0x1d0 block/bsg.c:201
    [<ffffffff82730abf>] scsi_sysfs_add_sdev+0x13f/0x380 drivers/scsi/scsi_sysfs.c:1376
    [<ffffffff8272e309>] scsi_sysfs_add_devices drivers/scsi/scsi_scan.c:1727 [inline]
    [<ffffffff8272e309>] scsi_finish_async_scan drivers/scsi/scsi_scan.c:1812 [inline]
    [<ffffffff8272e309>] do_scan_async+0x109/0x200 drivers/scsi/scsi_scan.c:1855
    [<ffffffff812752a4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff81263d1f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81264629>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126db28>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff8100234f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff8881157cde00 (size 256):
  comm "kworker/u4:4", pid 2996, jiffies 4294948956 (age 24.640s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 de 7c 15 81 88 ff ff  ..........|.....
    08 de 7c 15 81 88 ff ff 10 26 65 82 ff ff ff ff  ..|......&e.....
  backtrace:
    [<ffffffff82657f2b>] kmalloc include/linux/slab.h:591 [inline]
    [<ffffffff82657f2b>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff82657f2b>] device_private_init drivers/base/core.c:3203 [inline]
    [<ffffffff82657f2b>] device_add+0x89b/0xdf0 drivers/base/core.c:3253
    [<ffffffff81577864>] cdev_device_add+0x84/0xe0 fs/char_dev.c:549
    [<ffffffff822547ff>] bsg_register_queue+0x10f/0x1d0 block/bsg.c:206
    [<ffffffff82730abf>] scsi_sysfs_add_sdev+0x13f/0x380 drivers/scsi/scsi_sysfs.c:1376
    [<ffffffff8272e309>] scsi_sysfs_add_devices drivers/scsi/scsi_scan.c:1727 [inline]
    [<ffffffff8272e309>] scsi_finish_async_scan drivers/scsi/scsi_scan.c:1812 [inline]
    [<ffffffff8272e309>] do_scan_async+0x109/0x200 drivers/scsi/scsi_scan.c:1855
    [<ffffffff812752a4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff81263d1f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81264629>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126db28>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff8100234f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888114f6c160 (size 32):
  comm "kworker/u4:4", pid 2996, jiffies 4294948949 (age 28.480s)
  hex dump (first 32 bytes):
    38 3a 30 3a 30 3a 30 00 00 00 00 00 00 00 00 00  8:0:0:0.........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8147fc76>] kstrdup+0x36/0x70 mm/util.c:60
    [<ffffffff8147fd03>] kstrdup_const+0x53/0x80 mm/util.c:83
    [<ffffffff82293362>] kvasprintf_const+0xc2/0x110 lib/kasprintf.c:48
    [<ffffffff8235545b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:289
    [<ffffffff82652573>] dev_set_name+0x63/0x90 drivers/base/core.c:3147
    [<ffffffff822547d1>] bsg_register_queue+0xe1/0x1d0 block/bsg.c:201
    [<ffffffff82730abf>] scsi_sysfs_add_sdev+0x13f/0x380 drivers/scsi/scsi_sysfs.c:1376
    [<ffffffff8272e309>] scsi_sysfs_add_devices drivers/scsi/scsi_scan.c:1727 [inline]
    [<ffffffff8272e309>] scsi_finish_async_scan drivers/scsi/scsi_scan.c:1812 [inline]
    [<ffffffff8272e309>] do_scan_async+0x109/0x200 drivers/scsi/scsi_scan.c:1855
    [<ffffffff812752a4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff81263d1f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81264629>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126db28>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff8100234f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff8881170d6200 (size 256):
  comm "kworker/u4:4", pid 2996, jiffies 4294948949 (age 28.480s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 62 0d 17 81 88 ff ff  .........b......
    08 62 0d 17 81 88 ff ff 10 26 65 82 ff ff ff ff  .b.......&e.....
  backtrace:
    [<ffffffff82657f2b>] kmalloc include/linux/slab.h:591 [inline]
    [<ffffffff82657f2b>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff82657f2b>] device_private_init drivers/base/core.c:3203 [inline]
    [<ffffffff82657f2b>] device_add+0x89b/0xdf0 drivers/base/core.c:3253
    [<ffffffff81577864>] cdev_device_add+0x84/0xe0 fs/char_dev.c:549
    [<ffffffff822547ff>] bsg_register_queue+0x10f/0x1d0 block/bsg.c:206
    [<ffffffff82730abf>] scsi_sysfs_add_sdev+0x13f/0x380 drivers/scsi/scsi_sysfs.c:1376
    [<ffffffff8272e309>] scsi_sysfs_add_devices drivers/scsi/scsi_scan.c:1727 [inline]
    [<ffffffff8272e309>] scsi_finish_async_scan drivers/scsi/scsi_scan.c:1812 [inline]
    [<ffffffff8272e309>] do_scan_async+0x109/0x200 drivers/scsi/scsi_scan.c:1855
    [<ffffffff812752a4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff81263d1f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81264629>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126db28>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff8100234f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff8881170da100 (size 32):
  comm "kworker/u4:4", pid 2996, jiffies 4294948956 (age 28.410s)
  hex dump (first 32 bytes):
    38 3a 30 3a 30 3a 31 00 00 00 00 00 00 00 00 00  8:0:0:1.........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8147fc76>] kstrdup+0x36/0x70 mm/util.c:60
    [<ffffffff8147fd03>] kstrdup_const+0x53/0x80 mm/util.c:83
    [<ffffffff82293362>] kvasprintf_const+0xc2/0x110 lib/kasprintf.c:48
    [<ffffffff8235545b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:289
    [<ffffffff82652573>] dev_set_name+0x63/0x90 drivers/base/core.c:3147
    [<ffffffff822547d1>] bsg_register_queue+0xe1/0x1d0 block/bsg.c:201
    [<ffffffff82730abf>] scsi_sysfs_add_sdev+0x13f/0x380 drivers/scsi/scsi_sysfs.c:1376
    [<ffffffff8272e309>] scsi_sysfs_add_devices drivers/scsi/scsi_scan.c:1727 [inline]
    [<ffffffff8272e309>] scsi_finish_async_scan drivers/scsi/scsi_scan.c:1812 [inline]
    [<ffffffff8272e309>] do_scan_async+0x109/0x200 drivers/scsi/scsi_scan.c:1855
    [<ffffffff812752a4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff81263d1f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81264629>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126db28>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff8100234f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff8881157cde00 (size 256):
  comm "kworker/u4:4", pid 2996, jiffies 4294948956 (age 28.410s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 de 7c 15 81 88 ff ff  ..........|.....
    08 de 7c 15 81 88 ff ff 10 26 65 82 ff ff ff ff  ..|......&e.....
  backtrace:
    [<ffffffff82657f2b>] kmalloc include/linux/slab.h:591 [inline]
    [<ffffffff82657f2b>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff82657f2b>] device_private_init drivers/base/core.c:3203 [inline]
    [<ffffffff82657f2b>] device_add+0x89b/0xdf0 drivers/base/core.c:3253
    [<ffffffff81577864>] cdev_device_add+0x84/0xe0 fs/char_dev.c:549
    [<ffffffff822547ff>] bsg_register_queue+0x10f/0x1d0 block/bsg.c:206
    [<ffffffff82730abf>] scsi_sysfs_add_sdev+0x13f/0x380 drivers/scsi/scsi_sysfs.c:1376
    [<ffffffff8272e309>] scsi_sysfs_add_devices drivers/scsi/scsi_scan.c:1727 [inline]
    [<ffffffff8272e309>] scsi_finish_async_scan drivers/scsi/scsi_scan.c:1812 [inline]
    [<ffffffff8272e309>] do_scan_async+0x109/0x200 drivers/scsi/scsi_scan.c:1855
    [<ffffffff812752a4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff81263d1f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81264629>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126db28>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff8100234f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888114f6c160 (size 32):
  comm "kworker/u4:4", pid 2996, jiffies 4294948949 (age 29.750s)
  hex dump (first 32 bytes):
    38 3a 30 3a 30 3a 30 00 00 00 00 00 00 00 00 00  8:0:0:0.........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8147fc76>] kstrdup+0x36/0x70 mm/util.c:60
    [<ffffffff8147fd03>] kstrdup_const+0x53/0x80 mm/util.c:83
    [<ffffffff82293362>] kvasprintf_const+0xc2/0x110 lib/kasprintf.c:48
    [<ffffffff8235545b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:289
    [<ffffffff82652573>] dev_set_name+0x63/0x90 drivers/base/core.c:3147
    [<ffffffff822547d1>] bsg_register_queue+0xe1/0x1d0 block/bsg.c:201
    [<ffffffff82730abf>] scsi_sysfs_add_sdev+0x13f/0x380 drivers/scsi/scsi_sysfs.c:1376
    [<ffffffff8272e309>] scsi_sysfs_add_devices drivers/scsi/scsi_scan.c:1727 [inline]
    [<ffffffff8272e309>] scsi_finish_async_scan drivers/scsi/scsi_scan.c:1812 [inline]
    [<ffffffff8272e309>] do_scan_async+0x109/0x200 drivers/scsi/scsi_scan.c:1855
    [<ffffffff812752a4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff81263d1f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81264629>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126db28>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff8100234f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff8881170d6200 (size 256):
  comm "kworker/u4:4", pid 2996, jiffies 4294948949 (age 29.760s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 62 0d 17 81 88 ff ff  .........b......
    08 62 0d 17 81 88 ff ff 10 26 65 82 ff ff ff ff  .b.......&e.....
  backtrace:
    [<ffffffff82657f2b>] kmalloc include/linux/slab.h:591 [inline]
    [<ffffffff82657f2b>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff82657f2b>] device_private_init drivers/base/core.c:3203 [inline]
    [<ffffffff82657f2b>] device_add+0x89b/0xdf0 drivers/base/core.c:3253
    [<ffffffff81577864>] cdev_device_add+0x84/0xe0 fs/char_dev.c:549
    [<ffffffff822547ff>] bsg_register_queue+0x10f/0x1d0 block/bsg.c:206
    [<ffffffff82730abf>] scsi_sysfs_add_sdev+0x13f/0x380 drivers/scsi/scsi_sysfs.c:1376
    [<ffffffff8272e309>] scsi_sysfs_add_devices drivers/scsi/scsi_scan.c:1727 [inline]
    [<ffffffff8272e309>] scsi_finish_async_scan drivers/scsi/scsi_scan.c:1812 [inline]
    [<ffffffff8272e309>] do_scan_async+0x109/0x200 drivers/scsi/scsi_scan.c:1855
    [<ffffffff812752a4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff81263d1f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81264629>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126db28>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff8100234f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff8881170da100 (size 32):
  comm "kworker/u4:4", pid 2996, jiffies 4294948956 (age 29.690s)
  hex dump (first 32 bytes):
    38 3a 30 3a 30 3a 31 00 00 00 00 00 00 00 00 00  8:0:0:1.........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8147fc76>] kstrdup+0x36/0x70 mm/util.c:60
    [<ffffffff8147fd03>] kstrdup_const+0x53/0x80 mm/util.c:83
    [<ffffffff82293362>] kvasprintf_const+0xc2/0x110 lib/kasprintf.c:48
    [<ffffffff8235545b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:289
    [<ffffffff82652573>] dev_set_name+0x63/0x90 drivers/base/core.c:3147
    [<ffffffff822547d1>] bsg_register_queue+0xe1/0x1d0 block/bsg.c:201
    [<ffffffff82730abf>] scsi_sysfs_add_sdev+0x13f/0x380 drivers/scsi/scsi_sysfs.c:1376
    [<ffffffff8272e309>] scsi_sysfs_add_devices drivers/scsi/scsi_scan.c:1727 [inline]
    [<ffffffff8272e309>] scsi_finish_async_scan drivers/scsi/scsi_scan.c:1812 [inline]
    [<ffffffff8272e309>] do_scan_async+0x109/0x200 drivers/scsi/scsi_scan.c:1855
    [<ffffffff812752a4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff81263d1f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81264629>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126db28>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff8100234f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff8881157cde00 (size 256):
  comm "kworker/u4:4", pid 2996, jiffies 4294948956 (age 29.690s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 de 7c 15 81 88 ff ff  ..........|.....
    08 de 7c 15 81 88 ff ff 10 26 65 82 ff ff ff ff  ..|......&e.....
  backtrace:
    [<ffffffff82657f2b>] kmalloc include/linux/slab.h:591 [inline]
    [<ffffffff82657f2b>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff82657f2b>] device_private_init drivers/base/core.c:3203 [inline]
    [<ffffffff82657f2b>] device_add+0x89b/0xdf0 drivers/base/core.c:3253
    [<ffffffff81577864>] cdev_device_add+0x84/0xe0 fs/char_dev.c:549
    [<ffffffff822547ff>] bsg_register_queue+0x10f/0x1d0 block/bsg.c:206
    [<ffffffff82730abf>] scsi_sysfs_add_sdev+0x13f/0x380 drivers/scsi/scsi_sysfs.c:1376
    [<ffffffff8272e309>] scsi_sysfs_add_devices drivers/scsi/scsi_scan.c:1727 [inline]
    [<ffffffff8272e309>] scsi_finish_async_scan drivers/scsi/scsi_scan.c:1812 [inline]
    [<ffffffff8272e309>] do_scan_async+0x109/0x200 drivers/scsi/scsi_scan.c:1855
    [<ffffffff812752a4>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff81263d1f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81264629>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126db28>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff8100234f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

executing program
executing program
executing program
executing program


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9BA4384D6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 20:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhJWTAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 15:00:48 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:50138 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhJWTAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 15:00:46 -0400
Received: by mail-io1-f71.google.com with SMTP id l17-20020a05660227d100b005d6609eb90eso5693475ios.16
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 11:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=eCivDOpGNwJ3PvYvmEJEwXEnX0U6KVVQYKAd0WYoqUQ=;
        b=l5Oe0DlAhVLW2jFQbdsl1Cj+lORZnABqk/0YUK5WJF/goEfuDo6y+4exZLjjmazqgp
         ANVOf0Ie9f6+mCPmBlAFeCVOvE+tVl420Ha6NBgwSKRjEJaH9BnEzYU1l+TagCB78IVv
         HEFk4XemtEGaxC9BAtTrw6cmQRJsRJJ81xqE5FKViXNOO89af6YISoSzHsTbt0Dhkt49
         +UQgWA1PONkiYPHXhdPvMmVvtHJrqF8iRaExpWCfBzbKfpdPSUnegDq7yNTdw6plQc8T
         YEgs2diDaQcA/996h8gb4qxLW9ruP0aGuim8IUO2moYvubGf+/My+9SdJlkmiYcRHOLn
         fbNg==
X-Gm-Message-State: AOAM532KA+mu6/TDX7zx1144vPAA/x1VnS20cuoUsyhzO4VrAQchcL7w
        D9DXkXMW9vS29R75Zyv3rBgJSjODqSGgy7uSs6rWzm4o6MP3
X-Google-Smtp-Source: ABdhPJyZbEzHvvsdjRIXP2qZL+wuOQzbRZUt+s8X3dbAGfjjAKRHhxTl5dVi75AjMydIXvOQA7+15tTKrqxbyZ5CyLURN3WIHJSN
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ba5:: with SMTP id n5mr1803268ili.249.1635015507189;
 Sat, 23 Oct 2021 11:58:27 -0700 (PDT)
Date:   Sat, 23 Oct 2021 11:58:27 -0700
In-Reply-To: <0000000000004ee28405cbe8d287@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000082261505cf09b69c@google.com>
Subject: Re: [syzbot] memory leak in blk_iolatency_init
From:   syzbot <syzbot+01321b15cc98e6bf96d6@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, cgroups@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        noreply@bizcloud-server.changyang.com.tw, sashal@kernel.org,
        stable@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tj@kernel.org, yanfei.xu@windriver.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    9c0c4d24ac00 Merge tag 'block-5.15-2021-10-22' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1709f5c4b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d25eeb482b0f99b
dashboard link: https://syzkaller.appspot.com/bug?extid=01321b15cc98e6bf96d6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102280acb00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=144b96f8b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+01321b15cc98e6bf96d6@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888104729800 (size 96):
  comm "kworker/u4:2", pid 156, jiffies 4294937755 (age 219.670s)
  hex dump (first 32 bytes):
    00 49 c9 85 ff ff ff ff e0 b0 8b 03 81 88 ff ff  .I..............
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82268cf8>] kmalloc include/linux/slab.h:591 [inline]
    [<ffffffff82268cf8>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff82268cf8>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:724
    [<ffffffff8225f71e>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1193
    [<ffffffff82228fca>] blk_alloc_queue+0x22a/0x2e0 block/blk-core.c:584
    [<ffffffff8223ee35>] blk_mq_init_queue_data block/blk-mq.c:3119 [inline]
    [<ffffffff8223ee35>] __blk_mq_alloc_disk+0x25/0xd0 block/blk-mq.c:3143
    [<ffffffff826a187f>] floppy_alloc_disk+0x2f/0x130 drivers/block/floppy.c:4495
    [<ffffffff86f2aaa9>] do_floppy_init drivers/block/floppy.c:4566 [inline]
    [<ffffffff86f2aaa9>] floppy_async_init+0x10f/0x1329 drivers/block/floppy.c:4731
    [<ffffffff81277354>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff81265dbf>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff812666c9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126fc48>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888104729400 (size 96):
  comm "kworker/u4:2", pid 156, jiffies 4294937755 (age 219.670s)
  hex dump (first 32 bytes):
    00 49 c9 85 ff ff ff ff 90 a8 8b 03 81 88 ff ff  .I..............
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82268cf8>] kmalloc include/linux/slab.h:591 [inline]
    [<ffffffff82268cf8>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff82268cf8>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:724
    [<ffffffff8225f71e>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1193
    [<ffffffff82228fca>] blk_alloc_queue+0x22a/0x2e0 block/blk-core.c:584
    [<ffffffff8223ee35>] blk_mq_init_queue_data block/blk-mq.c:3119 [inline]
    [<ffffffff8223ee35>] __blk_mq_alloc_disk+0x25/0xd0 block/blk-mq.c:3143
    [<ffffffff826a187f>] floppy_alloc_disk+0x2f/0x130 drivers/block/floppy.c:4495
    [<ffffffff86f2aaa9>] do_floppy_init drivers/block/floppy.c:4566 [inline]
    [<ffffffff86f2aaa9>] floppy_async_init+0x10f/0x1329 drivers/block/floppy.c:4731
    [<ffffffff81277354>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff81265dbf>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff812666c9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126fc48>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888104767e00 (size 96):
  comm "kworker/u4:2", pid 156, jiffies 4294937755 (age 219.670s)
  hex dump (first 32 bytes):
    00 49 c9 85 ff ff ff ff 40 a0 8b 03 81 88 ff ff  .I......@.......
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82268cf8>] kmalloc include/linux/slab.h:591 [inline]
    [<ffffffff82268cf8>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff82268cf8>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:724
    [<ffffffff8225f71e>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1193
    [<ffffffff82228fca>] blk_alloc_queue+0x22a/0x2e0 block/blk-core.c:584
    [<ffffffff8223ee35>] blk_mq_init_queue_data block/blk-mq.c:3119 [inline]
    [<ffffffff8223ee35>] __blk_mq_alloc_disk+0x25/0xd0 block/blk-mq.c:3143
    [<ffffffff826a187f>] floppy_alloc_disk+0x2f/0x130 drivers/block/floppy.c:4495
    [<ffffffff86f2aaa9>] do_floppy_init drivers/block/floppy.c:4566 [inline]
    [<ffffffff86f2aaa9>] floppy_async_init+0x10f/0x1329 drivers/block/floppy.c:4731
    [<ffffffff81277354>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff81265dbf>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff812666c9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126fc48>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888104767500 (size 96):
  comm "kworker/u4:2", pid 156, jiffies 4294937755 (age 219.670s)
  hex dump (first 32 bytes):
    00 49 c9 85 ff ff ff ff 60 31 88 03 81 88 ff ff  .I......`1......
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82268cf8>] kmalloc include/linux/slab.h:591 [inline]
    [<ffffffff82268cf8>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff82268cf8>] blk_iolatency_init+0x28/0x190 block/blk-iolatency.c:724
    [<ffffffff8225f71e>] blkcg_init_queue+0xee/0x1c0 block/blk-cgroup.c:1193
    [<ffffffff82228fca>] blk_alloc_queue+0x22a/0x2e0 block/blk-core.c:584
    [<ffffffff8223ee35>] blk_mq_init_queue_data block/blk-mq.c:3119 [inline]
    [<ffffffff8223ee35>] __blk_mq_alloc_disk+0x25/0xd0 block/blk-mq.c:3143
    [<ffffffff826a187f>] floppy_alloc_disk+0x2f/0x130 drivers/block/floppy.c:4495
    [<ffffffff86f2aaa9>] do_floppy_init drivers/block/floppy.c:4566 [inline]
    [<ffffffff86f2aaa9>] floppy_async_init+0x10f/0x1329 drivers/block/floppy.c:4731
    [<ffffffff81277354>] async_run_entry_fn+0x24/0xf0 kernel/async.c:127
    [<ffffffff81265dbf>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff812666c9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126fc48>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory


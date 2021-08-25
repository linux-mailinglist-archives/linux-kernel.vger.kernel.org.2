Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751763F6CA4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 02:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236583AbhHYAcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 20:32:09 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:50688 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbhHYAcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 20:32:08 -0400
Received: by mail-io1-f70.google.com with SMTP id b202-20020a6bb2d3000000b005b7fb465c4aso13411835iof.17
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 17:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=vmWstVnnb830DoJmVbDhGcXaqdb96d+LhOSkNAujwuU=;
        b=fjRbjhWHzAa7reIJ1tegljkGqW78yLovW8f3NGsH4IoztHRxqlDzGWN0jweBK9YnWO
         824wZgTsUqntJqkrNDqz3vfbySjF9tlOKN0QGpVCTobcVoyydLgqA+24GHd9oAw3/w9L
         qeqP7ryjNMWU+7AwfnYCXtvFAUI2u+2UPkXcUac/ctKI72zfFuRLNsWM1wOoREdmGSQT
         MaVJH23WrONtFTEKpGSthzgbkyskI7xGD6Frd3MKQsiOIhZaWy9cN4w7g2N/TdGrYwmO
         euGW7oizev1wwiEaswSOGnHp1tMZlau2fE/DjBNloT/muGC5SWTS1wfKiGHPTBUh8xwK
         ESbw==
X-Gm-Message-State: AOAM531HHcxshB/oASlKLK1sH25+jz3I8Y8nIjaHgHNXq56v5bw3q84M
        ojvY4UmLU0FL/Xv19LXkC5mvVK2RF3CeCWNotHNN79Jdrroz
X-Google-Smtp-Source: ABdhPJxT4wQRRiP5lkaHhBuxDJTHTz91hHXUA4+ybJWwz26CUCPKUbk99Hk7WuQcKftqx0oHzfWz1oif8it4eqm9fLsnxrXn3qWD
MIME-Version: 1.0
X-Received: by 2002:a92:7304:: with SMTP id o4mr27933562ilc.75.1629851482954;
 Tue, 24 Aug 2021 17:31:22 -0700 (PDT)
Date:   Tue, 24 Aug 2021 17:31:22 -0700
In-Reply-To: <00000000000065b14e05c282fd15@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ada11305ca575e1e@google.com>
Subject: Re: [syzbot] memory leak in mgmt_cmd_complete
From:   syzbot <syzbot+4c4ffd1e1094dae61035@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org,
        phind.uet@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    6e764bcd1cf7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=174af485300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a938918bd15e088e
dashboard link: https://syzkaller.appspot.com/bug?extid=4c4ffd1e1094dae61035
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1355278d300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=150997c5300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4c4ffd1e1094dae61035@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88811858bb00 (size 232):
  comm "kworker/u5:10", pid 8505, jiffies 4294950224 (age 25.730s)
  hex dump (first 32 bytes):
    d0 14 3d 18 81 88 ff ff d0 14 3d 18 81 88 ff ff  ..=.......=.....
    00 00 00 00 00 00 00 00 00 14 3d 18 81 88 ff ff  ..........=.....
  backtrace:
    [<ffffffff836e557f>] __alloc_skb+0x20f/0x280 net/core/skbuff.c:414
    [<ffffffff83d1c5ed>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83d1c5ed>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83cdc8ee>] send_settings_rsp net/bluetooth/mgmt.c:1129 [inline]
    [<ffffffff83cdc8ee>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1282
    [<ffffffff83d1c8d6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83ce80bc>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8583
    [<ffffffff83cb8786>] hci_dev_do_close+0x5b6/0x710 net/bluetooth/hci_core.c:1774
    [<ffffffff812636d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81263fc9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126d428>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888111f7c600 (size 512):
  comm "kworker/u5:10", pid 8505, jiffies 4294950224 (age 25.730s)
  hex dump (first 32 bytes):
    01 00 03 00 07 00 05 00 00 82 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff836e544f>] kmalloc_reserve net/core/skbuff.c:355 [inline]
    [<ffffffff836e544f>] __alloc_skb+0xdf/0x280 net/core/skbuff.c:426
    [<ffffffff83d1c5ed>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83d1c5ed>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83cdc8ee>] send_settings_rsp net/bluetooth/mgmt.c:1129 [inline]
    [<ffffffff83cdc8ee>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1282
    [<ffffffff83d1c8d6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83ce80bc>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8583
    [<ffffffff83cb8786>] hci_dev_do_close+0x5b6/0x710 net/bluetooth/hci_core.c:1774
    [<ffffffff812636d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81263fc9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126d428>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff88811858bb00 (size 232):
  comm "kworker/u5:10", pid 8505, jiffies 4294950224 (age 25.780s)
  hex dump (first 32 bytes):
    d0 14 3d 18 81 88 ff ff d0 14 3d 18 81 88 ff ff  ..=.......=.....
    00 00 00 00 00 00 00 00 00 14 3d 18 81 88 ff ff  ..........=.....
  backtrace:
    [<ffffffff836e557f>] __alloc_skb+0x20f/0x280 net/core/skbuff.c:414
    [<ffffffff83d1c5ed>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83d1c5ed>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83cdc8ee>] send_settings_rsp net/bluetooth/mgmt.c:1129 [inline]
    [<ffffffff83cdc8ee>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1282
    [<ffffffff83d1c8d6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83ce80bc>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8583
    [<ffffffff83cb8786>] hci_dev_do_close+0x5b6/0x710 net/bluetooth/hci_core.c:1774
    [<ffffffff812636d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81263fc9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126d428>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888111f7c600 (size 512):
  comm "kworker/u5:10", pid 8505, jiffies 4294950224 (age 25.780s)
  hex dump (first 32 bytes):
    01 00 03 00 07 00 05 00 00 82 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff836e544f>] kmalloc_reserve net/core/skbuff.c:355 [inline]
    [<ffffffff836e544f>] __alloc_skb+0xdf/0x280 net/core/skbuff.c:426
    [<ffffffff83d1c5ed>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83d1c5ed>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83cdc8ee>] send_settings_rsp net/bluetooth/mgmt.c:1129 [inline]
    [<ffffffff83cdc8ee>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1282
    [<ffffffff83d1c8d6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83ce80bc>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8583
    [<ffffffff83cb8786>] hci_dev_do_close+0x5b6/0x710 net/bluetooth/hci_core.c:1774
    [<ffffffff812636d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81263fc9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126d428>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff88811858bb00 (size 232):
  comm "kworker/u5:10", pid 8505, jiffies 4294950224 (age 25.840s)
  hex dump (first 32 bytes):
    d0 14 3d 18 81 88 ff ff d0 14 3d 18 81 88 ff ff  ..=.......=.....
    00 00 00 00 00 00 00 00 00 14 3d 18 81 88 ff ff  ..........=.....
  backtrace:
    [<ffffffff836e557f>] __alloc_skb+0x20f/0x280 net/core/skbuff.c:414
    [<ffffffff83d1c5ed>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83d1c5ed>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83cdc8ee>] send_settings_rsp net/bluetooth/mgmt.c:1129 [inline]
    [<ffffffff83cdc8ee>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1282
    [<ffffffff83d1c8d6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83ce80bc>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8583
    [<ffffffff83cb8786>] hci_dev_do_close+0x5b6/0x710 net/bluetooth/hci_core.c:1774
    [<ffffffff812636d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81263fc9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126d428>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888111f7c600 (size 512):
  comm "kworker/u5:10", pid 8505, jiffies 4294950224 (age 25.840s)
  hex dump (first 32 bytes):
    01 00 03 00 07 00 05 00 00 82 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff836e544f>] kmalloc_reserve net/core/skbuff.c:355 [inline]
    [<ffffffff836e544f>] __alloc_skb+0xdf/0x280 net/core/skbuff.c:426
    [<ffffffff83d1c5ed>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83d1c5ed>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83cdc8ee>] send_settings_rsp net/bluetooth/mgmt.c:1129 [inline]
    [<ffffffff83cdc8ee>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1282
    [<ffffffff83d1c8d6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83ce80bc>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8583
    [<ffffffff83cb8786>] hci_dev_do_close+0x5b6/0x710 net/bluetooth/hci_core.c:1774
    [<ffffffff812636d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81263fc9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126d428>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff88811858bb00 (size 232):
  comm "kworker/u5:10", pid 8505, jiffies 4294950224 (age 25.900s)
  hex dump (first 32 bytes):
    d0 14 3d 18 81 88 ff ff d0 14 3d 18 81 88 ff ff  ..=.......=.....
    00 00 00 00 00 00 00 00 00 14 3d 18 81 88 ff ff  ..........=.....
  backtrace:
    [<ffffffff836e557f>] __alloc_skb+0x20f/0x280 net/core/skbuff.c:414
    [<ffffffff83d1c5ed>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83d1c5ed>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83cdc8ee>] send_settings_rsp net/bluetooth/mgmt.c:1129 [inline]
    [<ffffffff83cdc8ee>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1282
    [<ffffffff83d1c8d6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83ce80bc>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8583
    [<ffffffff83cb8786>] hci_dev_do_close+0x5b6/0x710 net/bluetooth/hci_core.c:1774
    [<ffffffff812636d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81263fc9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126d428>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888111f7c600 (size 512):
  comm "kworker/u5:10", pid 8505, jiffies 4294950224 (age 25.900s)
  hex dump (first 32 bytes):
    01 00 03 00 07 00 05 00 00 82 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff836e544f>] kmalloc_reserve net/core/skbuff.c:355 [inline]
    [<ffffffff836e544f>] __alloc_skb+0xdf/0x280 net/core/skbuff.c:426
    [<ffffffff83d1c5ed>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83d1c5ed>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83cdc8ee>] send_settings_rsp net/bluetooth/mgmt.c:1129 [inline]
    [<ffffffff83cdc8ee>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1282
    [<ffffffff83d1c8d6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83ce80bc>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8583
    [<ffffffff83cb8786>] hci_dev_do_close+0x5b6/0x710 net/bluetooth/hci_core.c:1774
    [<ffffffff812636d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81263fc9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126d428>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff88811858bb00 (size 232):
  comm "kworker/u5:10", pid 8505, jiffies 4294950224 (age 25.950s)
  hex dump (first 32 bytes):
    d0 14 3d 18 81 88 ff ff d0 14 3d 18 81 88 ff ff  ..=.......=.....
    00 00 00 00 00 00 00 00 00 14 3d 18 81 88 ff ff  ..........=.....
  backtrace:
    [<ffffffff836e557f>] __alloc_skb+0x20f/0x280 net/core/skbuff.c:414
    [<ffffffff83d1c5ed>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83d1c5ed>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83cdc8ee>] send_settings_rsp net/bluetooth/mgmt.c:1129 [inline]
    [<ffffffff83cdc8ee>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1282
    [<ffffffff83d1c8d6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83ce80bc>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8583
    [<ffffffff83cb8786>] hci_dev_do_close+0x5b6/0x710 net/bluetooth/hci_core.c:1774
    [<ffffffff812636d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81263fc9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126d428>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888111f7c600 (size 512):
  comm "kworker/u5:10", pid 8505, jiffies 4294950224 (age 25.950s)
  hex dump (first 32 bytes):
    01 00 03 00 07 00 05 00 00 82 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff836e544f>] kmalloc_reserve net/core/skbuff.c:355 [inline]
    [<ffffffff836e544f>] __alloc_skb+0xdf/0x280 net/core/skbuff.c:426
    [<ffffffff83d1c5ed>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83d1c5ed>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83cdc8ee>] send_settings_rsp net/bluetooth/mgmt.c:1129 [inline]
    [<ffffffff83cdc8ee>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1282
    [<ffffffff83d1c8d6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83ce80bc>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8583
    [<ffffffff83cb8786>] hci_dev_do_close+0x5b6/0x710 net/bluetooth/hci_core.c:1774
    [<ffffffff812636d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81263fc9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126d428>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff88811858bb00 (size 232):
  comm "kworker/u5:10", pid 8505, jiffies 4294950224 (age 26.010s)
  hex dump (first 32 bytes):
    d0 14 3d 18 81 88 ff ff d0 14 3d 18 81 88 ff ff  ..=.......=.....
    00 00 00 00 00 00 00 00 00 14 3d 18 81 88 ff ff  ..........=.....
  backtrace:
    [<ffffffff836e557f>] __alloc_skb+0x20f/0x280 net/core/skbuff.c:414
    [<ffffffff83d1c5ed>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83d1c5ed>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83cdc8ee>] send_settings_rsp net/bluetooth/mgmt.c:1129 [inline]
    [<ffffffff83cdc8ee>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1282
    [<ffffffff83d1c8d6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83ce80bc>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8583
    [<ffffffff83cb8786>] hci_dev_do_close+0x5b6/0x710 net/bluetooth/hci_core.c:1774
    [<ffffffff812636d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81263fc9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126d428>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888111f7c600 (size 512):
  comm "kworker/u5:10", pid 8505, jiffies 4294950224 (age 26.010s)
  hex dump (first 32 bytes):
    01 00 03 00 07 00 05 00 00 82 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff836e544f>] kmalloc_reserve net/core/skbuff.c:355 [inline]
    [<ffffffff836e544f>] __alloc_skb+0xdf/0x280 net/core/skbuff.c:426
    [<ffffffff83d1c5ed>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83d1c5ed>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83cdc8ee>] send_settings_rsp net/bluetooth/mgmt.c:1129 [inline]
    [<ffffffff83cdc8ee>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1282
    [<ffffffff83d1c8d6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83ce80bc>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8583
    [<ffffffff83cb8786>] hci_dev_do_close+0x5b6/0x710 net/bluetooth/hci_core.c:1774
    [<ffffffff812636d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81263fc9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126d428>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff88811858bb00 (size 232):
  comm "kworker/u5:10", pid 8505, jiffies 4294950224 (age 26.060s)
  hex dump (first 32 bytes):
    d0 14 3d 18 81 88 ff ff d0 14 3d 18 81 88 ff ff  ..=.......=.....
    00 00 00 00 00 00 00 00 00 14 3d 18 81 88 ff ff  ..........=.....
  backtrace:
    [<ffffffff836e557f>] __alloc_skb+0x20f/0x280 net/core/skbuff.c:414
    [<ffffffff83d1c5ed>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83d1c5ed>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83cdc8ee>] send_settings_rsp net/bluetooth/mgmt.c:1129 [inline]
    [<ffffffff83cdc8ee>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1282
    [<ffffffff83d1c8d6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83ce80bc>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8583
    [<ffffffff83cb8786>] hci_dev_do_close+0x5b6/0x710 net/bluetooth/hci_core.c:1774
    [<ffffffff812636d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81263fc9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126d428>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888111f7c600 (size 512):
  comm "kworker/u5:10", pid 8505, jiffies 4294950224 (age 26.070s)
  hex dump (first 32 bytes):
    01 00 03 00 07 00 05 00 00 82 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff836e544f>] kmalloc_reserve net/core/skbuff.c:355 [inline]
    [<ffffffff836e544f>] __alloc_skb+0xdf/0x280 net/core/skbuff.c:426
    [<ffffffff83d1c5ed>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83d1c5ed>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83cdc8ee>] send_settings_rsp net/bluetooth/mgmt.c:1129 [inline]
    [<ffffffff83cdc8ee>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1282
    [<ffffffff83d1c8d6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83ce80bc>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8583
    [<ffffffff83cb8786>] hci_dev_do_close+0x5b6/0x710 net/bluetooth/hci_core.c:1774
    [<ffffffff812636d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81263fc9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126d428>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff88811858bb00 (size 232):
  comm "kworker/u5:10", pid 8505, jiffies 4294950224 (age 26.120s)
  hex dump (first 32 bytes):
    d0 14 3d 18 81 88 ff ff d0 14 3d 18 81 88 ff ff  ..=.......=.....
    00 00 00 00 00 00 00 00 00 14 3d 18 81 88 ff ff  ..........=.....
  backtrace:
    [<ffffffff836e557f>] __alloc_skb+0x20f/0x280 net/core/skbuff.c:414
    [<ffffffff83d1c5ed>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83d1c5ed>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83cdc8ee>] send_settings_rsp net/bluetooth/mgmt.c:1129 [inline]
    [<ffffffff83cdc8ee>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1282
    [<ffffffff83d1c8d6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83ce80bc>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8583
    [<ffffffff83cb8786>] hci_dev_do_close+0x5b6/0x710 net/bluetooth/hci_core.c:1774
    [<ffffffff812636d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81263fc9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126d428>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888111f7c600 (size 512):
  comm "kworker/u5:10", pid 8505, jiffies 4294950224 (age 26.120s)
  hex dump (first 32 bytes):
    01 00 03 00 07 00 05 00 00 82 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff836e544f>] kmalloc_reserve net/core/skbuff.c:355 [inline]
    [<ffffffff836e544f>] __alloc_skb+0xdf/0x280 net/core/skbuff.c:426
    [<ffffffff83d1c5ed>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83d1c5ed>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83cdc8ee>] send_settings_rsp net/bluetooth/mgmt.c:1129 [inline]
    [<ffffffff83cdc8ee>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1282
    [<ffffffff83d1c8d6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83ce80bc>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8583
    [<ffffffff83cb8786>] hci_dev_do_close+0x5b6/0x710 net/bluetooth/hci_core.c:1774
    [<ffffffff812636d9>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81263fc9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126d428>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295



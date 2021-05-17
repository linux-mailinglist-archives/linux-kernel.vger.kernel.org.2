Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956FB3827FF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbhEQJQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:16:55 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:35678 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235929AbhEQJNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:13:32 -0400
Received: by mail-io1-f72.google.com with SMTP id l2-20020a5e82020000b02903c2fa852f92so2904215iom.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mRyf9lv2g3j7nk1w/H4T1H1jAQgqzoEpGRqMuq86u2E=;
        b=UilOXrDnr97MVDRxfA16d8hZE+YYSqYCVKPsBypeVyZMb3KMjCnjSZhmjARwpQtHgC
         ADqlWXL9yQUduk6aCOwubMyE35wvUEwMmso/qxe/nOf2G7ImqT12s4hrlDHPH9BcDq85
         i0+I9Ue/N01yBaDmTYJBWd9oyGxNCwBSzAbyRuhAhMV5TkSNqDn4HSb1nKvipllObvM3
         vpGFCFRrSCbJ5UOtsyOB35XpuDmbL2FDUKwu1oqo71RBKp8QuhzCfXHiQM2dkdQ6t4+L
         NfdXN8goEtNMu845khG3vVLBiB9RF7mqw00qA9MPNOux3ijl4Ia+nbQcS65XaLFJB0Em
         ZC3g==
X-Gm-Message-State: AOAM531JDTzMhjTY0xFo8Bo7kREgYVzkHnZYaLlA2i/sBGy1gWkQjlnE
        TbvCOWm793IekIQ2N1nKDp+1tX5H4NTaexu78ogsiwPlDykE
X-Google-Smtp-Source: ABdhPJyw89HcafgTnmnXd8Q0mhLCT8K6VI+UsYJH2lobE3ZOmBIIsPzLBSnQG2WX+XN+ZZl9SZvDwQ/xb7l6drPRY+J3+UJmZYnw
MIME-Version: 1.0
X-Received: by 2002:a5e:930d:: with SMTP id k13mr43881968iom.61.1621242736388;
 Mon, 17 May 2021 02:12:16 -0700 (PDT)
Date:   Mon, 17 May 2021 02:12:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000065b14e05c282fd15@google.com>
Subject: [syzbot] memory leak in mgmt_cmd_complete
From:   syzbot <syzbot+4c4ffd1e1094dae61035@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9f67672a Merge tag 'ext4_for_linus' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=136256a5d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5427806e749e612b
dashboard link: https://syzkaller.appspot.com/bug?extid=4c4ffd1e1094dae61035
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a4d5a3d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4c4ffd1e1094dae61035@syzkaller.appspotmail.com

2021/05/01 15:27:37 executed programs: 23
BUG: memory leak
unreferenced object 0xffff8881131d9100 (size 232):
  comm "kworker/u5:7", pid 8471, jiffies 4294965136 (age 11.710s)
  hex dump (first 32 bytes):
    d0 94 18 27 81 88 ff ff d0 94 18 27 81 88 ff ff  ...'.......'....
    00 00 00 00 00 00 00 00 00 94 18 27 81 88 ff ff  ...........'....
  backtrace:
    [<ffffffff83678b3f>] __alloc_skb+0x20f/0x280 net/core/skbuff.c:413
    [<ffffffff83c9cedd>] alloc_skb include/linux/skbuff.h:1107 [inline]
    [<ffffffff83c9cedd>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83c5d46e>] send_settings_rsp net/bluetooth/mgmt.c:1126 [inline]
    [<ffffffff83c5d46e>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1279
    [<ffffffff83c9d1c6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83c68c3c>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8575
    [<ffffffff83c392e9>] hci_dev_do_close+0x579/0x720 net/bluetooth/hci_core.c:1776
    [<ffffffff8125d109>] process_one_work+0x2c9/0x600 kernel/workqueue.c:2275
    [<ffffffff8125d9f9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2421
    [<ffffffff81265268>] kthread+0x178/0x1b0 kernel/kthread.c:313
    [<ffffffff8100227f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

BUG: memory leak
unreferenced object 0xffff888126cdce00 (size 512):
  comm "kworker/u5:7", pid 8471, jiffies 4294965136 (age 11.710s)
  hex dump (first 32 bytes):
    01 00 00 00 07 00 05 00 00 82 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff83678a0f>] kmalloc_reserve net/core/skbuff.c:354 [inline]
    [<ffffffff83678a0f>] __alloc_skb+0xdf/0x280 net/core/skbuff.c:425
    [<ffffffff83c9cedd>] alloc_skb include/linux/skbuff.h:1107 [inline]
    [<ffffffff83c9cedd>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83c5d46e>] send_settings_rsp net/bluetooth/mgmt.c:1126 [inline]
    [<ffffffff83c5d46e>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1279
    [<ffffffff83c9d1c6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83c68c3c>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8575
    [<ffffffff83c392e9>] hci_dev_do_close+0x579/0x720 net/bluetooth/hci_core.c:1776
    [<ffffffff8125d109>] process_one_work+0x2c9/0x600 kernel/workqueue.c:2275
    [<ffffffff8125d9f9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2421
    [<ffffffff81265268>] kthread+0x178/0x1b0 kernel/kthread.c:313
    [<ffffffff8100227f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A5B407A7E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 23:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbhIKVUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 17:20:31 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:49089 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbhIKVU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 17:20:29 -0400
Received: by mail-io1-f70.google.com with SMTP id z26-20020a05660200da00b005b86e36a1f4so11523106ioe.15
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 14:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Jmi3yBWyM3sCdQcNUG7hYrR527zmNHaostTgpyWLE4g=;
        b=T26Drfl1PHbFTQhJHshs24nO5BgBKqAYUf3/CBA3enKjsWZaU6TiymVgt8lOYrbw/0
         8Xrmp+2VGytJshNQMW98kbn0zlrVio//u0aWzyz57xx2/2C+IJDqo7zou8f/MYJDcjSC
         fzHqqnMRbBWBWtCjZKbeOaueTi64a89Di5n5+aYjKYC6JWR//lV+cWT9bKydNVkygHZw
         6m8tTy2vLcNmPkPl9RRFEkyX1v2PsgwBuKUce4bTwQKr/A0uEQbQU/L5S9lYvj0VDQt9
         Jc7ciES/DB3Ga5h6Bb5Q7dRlmGnE4iIvemx90WkxvVsUa/Gm4NRpJvZQjjSwGz85YBT9
         8gpg==
X-Gm-Message-State: AOAM532lzZJSs/OncLq/h+j4H0b3ZDMi7+zL5OyQQ2dTdcC5bSmoJfPS
        QeUbh6h/oNiR7093ApxjG5BggqatlbJcr0g4B1C5lcHsOVF/
X-Google-Smtp-Source: ABdhPJw/wl4HsYKJ/UzPjAAqOxVZVC5DXtimWwIUaaY3Vyc+6GHMU1aF05QQWQLEMf8bn3QU3fpznvpVfWUS70bysyXwRprS2A6h
MIME-Version: 1.0
X-Received: by 2002:a6b:7b4b:: with SMTP id m11mr3067729iop.165.1631395156119;
 Sat, 11 Sep 2021 14:19:16 -0700 (PDT)
Date:   Sat, 11 Sep 2021 14:19:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c4d45205cbbec87f@google.com>
Subject: [syzbot] riscv/fixes test error: BUG: unable to handle kernel paging
 request in corrupted
From:   syzbot <syzbot+fd2f89c6e52024e6118d@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7d2a07b76933 Linux 5.14
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=1153e67d300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8211b06020972e8
dashboard link: https://syzkaller.appspot.com/bug?extid=fd2f89c6e52024e6118d
compiler:       riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
userspace arch: riscv64

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fd2f89c6e52024e6118d@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address 1ffffffff07aa547
Oops [#1]
Modules linked in:
CPU: 0 PID: 3309 Comm: kworker/0:5 Not tainted 5.14.0-syzkaller #0
Hardware name: riscv-virtio,qemu (DT)
Workqueue: events nsim_dev_trap_report_work
epc : slab_alloc_node mm/slub.c:2884 [inline]
epc : __kmalloc_node_track_caller+0xb0/0x3d2 mm/slub.c:4653
 ra : slab_pre_alloc_hook mm/slab.h:494 [inline]
 ra : slab_alloc_node mm/slub.c:2880 [inline]
 ra : __kmalloc_node_track_caller+0x70/0x3d2 mm/slub.c:4653
epc : ffffffff803e2a20 ra : ffffffff803e29e0 sp : ffffffe0095c3b20
 gp : ffffffff83f967d8 tp : ffffffe00ba397c0 t0 : ffffffe008b544a8
 t1 : 0000000000000001 t2 : ffffffffeddd472a s0 : ffffffe0095c3bc0
 s1 : ffffffe005602140 a0 : 0000000000000000 a1 : 0000000000000007
 a2 : 1ffffffff07aa51f a3 : ffffffff80a9711a a4 : 0000000004000000
 a5 : 0000000000000000 a6 : 0000000000f00000 a7 : 78e919c5cf7e2f00
 s2 : ffffffff83f96adc s3 : 0000000000082a20 s4 : 0000000000001000
 s5 : ffffffffffffffff s6 : ffffffff81538164 s7 : ffffffff83f9a0d0
 s8 : 0000000000000000 s9 : 0000000000082a20 s10: 0000000000000000
 s11: ffffffe008b545c8 t3 : 78e919c5cf7e2f00 t4 : ffffffc40116a8bb
 t5 : ffffffc40116a8bc t6 : ffffffe00eede026
status: 0000000000000120 badaddr: 1ffffffff07aa547 cause: 000000000000000f
[<ffffffff803e2a20>] slab_alloc_node mm/slub.c:2884 [inline]
[<ffffffff803e2a20>] __kmalloc_node_track_caller+0xb0/0x3d2 mm/slub.c:4653
[<ffffffff821a8952>] kmalloc_reserve net/core/skbuff.c:355 [inline]
[<ffffffff821a8952>] __alloc_skb+0xee/0x2e2 net/core/skbuff.c:426
[<ffffffff81538164>] alloc_skb include/linux/skbuff.h:1112 [inline]
[<ffffffff81538164>] nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:664 [inline]
[<ffffffff81538164>] nsim_dev_trap_report drivers/net/netdevsim/dev.c:721 [inline]
[<ffffffff81538164>] nsim_dev_trap_report_work+0x1cc/0x5e6 drivers/net/netdevsim/dev.c:762
[<ffffffff80063b62>] process_one_work+0x5e0/0xf82 kernel/workqueue.c:2276
[<ffffffff8006485a>] worker_thread+0x356/0x8e6 kernel/workqueue.c:2422
[<ffffffff80076554>] kthread+0x25c/0x2c6 kernel/kthread.c:319
[<ffffffff8000515e>] ret_from_exception+0x0/0x14
---[ end trace fa569262b4bfae4f ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

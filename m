Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD5441102D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 09:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbhITHhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 03:37:46 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:43833 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbhITHhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 03:37:43 -0400
Received: by mail-il1-f197.google.com with SMTP id n17-20020a922611000000b0023db5ee1cafso38367076ile.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 00:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JaIDXQKCEKWvjojQXkSeD2DVMnB3ry8L5mp2UX+QrXI=;
        b=LS78/S3K4u0Gr3rR0IfTVT99gofEk5wBCp+yHE2iX/Brljmut9bdBP4jaqZvFHO3GH
         H7rEcwYZfXPD3ytspeRh+KoG0jmtUK/Q4ThzpBAS+A2QFDSHe1BQbiT5dVcR/beVZGAx
         Sj/Qyjr7vm3L11GlP8Bns7cvQOruLV2VhCfvCaD1hY/yjYj0Y0GMyXvWyA0MqaeZoheH
         wTt/kJKWSnj5uDa8nTzMff1FWX1dxJmHz/kBE+bMoP7Uwq9hrgeY3LUDnhNnh/LnCJXr
         Cgv++SESPf8X2MJv7RmJyhyOCIFuxY27ITUYt3aMtdidwvEoBxdobLn3hyjo2Cjj1XJ3
         iNgA==
X-Gm-Message-State: AOAM530ElrtwAdQYwk71ak7dadoVGVC+v/0OI9Wqh+GRZXPbtlrBpHH4
        zuag7+PkcNDHh3npxLRjPV4NdfDNypOzm43rC7qSgoomPMrx
X-Google-Smtp-Source: ABdhPJxvmmQFPASqaGE1IcSLk0anDTaE5bMiSNLh2Z3J3XWszHM2YWH0yvvgaQtSPy7OIrWEIBqlljAAVp/k7uTP7Chl5Sl8upca
MIME-Version: 1.0
X-Received: by 2002:a02:a46:: with SMTP id 67mr18038303jaw.142.1632123377157;
 Mon, 20 Sep 2021 00:36:17 -0700 (PDT)
Date:   Mon, 20 Sep 2021 00:36:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020104105cc685624@google.com>
Subject: [syzbot] kernel BUG in __free_one_page
From:   syzbot <syzbot+afe1d3c5ccb5940c372a@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d4d016caa4b8 alpha: move __udiv_qrnnd library function to ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1564ae79300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d93fe4341f98704
dashboard link: https://syzkaller.appspot.com/bug?extid=afe1d3c5ccb5940c372a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+afe1d3c5ccb5940c372a@syzkaller.appspotmail.com

 io_mem_free.part.0+0xf7/0x140 fs/io_uring.c:8708
 io_mem_free fs/io_uring.c:8703 [inline]
 io_ring_ctx_free fs/io_uring.c:9250 [inline]
 io_ring_exit_work+0xf20/0x1980 fs/io_uring.c:9408
 process_one_work+0x9bf/0x16b0 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
------------[ cut here ]------------
kernel BUG at mm/page_alloc.c:1073!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.15.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: mm_percpu_wq vmstat_update
RIP: 0010:__free_one_page+0xa10/0xe30 mm/page_alloc.c:1073
Code: 43 34 85 c0 0f 84 79 f9 ff ff 48 c7 c6 80 1b 97 89 48 89 ef e8 61 dd f6 ff 0f 0b 48 c7 c6 60 1a 97 89 4c 89 ef e8 50 dd f6 ff <0f> 0b 0f 0b 48 c7 c6 c0 1a 97 89 4c 89 ef e8 3d dd f6 ff 0f 0b 48
RSP: 0018:ffffc90000ca7968 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffffc90000ca7a60 RCX: 0000000000000000
RDX: ffff888010e40000 RSI: ffffffff81b2f6b0 RDI: 0000000000000003
RBP: 0000000000152200 R08: 0000000000000018 R09: 00000000ffffffff
R10: ffffffff88f44b19 R11: 00000000ffffffff R12: 0000000000000009
R13: ffffea0005488000 R14: 0000000000000000 R15: ffff88823fff8e00
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 0000000036db1000 CR4: 00000000001526f0
Call Trace:
 free_pcppages_bulk+0x533/0x8a0 mm/page_alloc.c:1537
 drain_zone_pages+0x173/0x440 mm/page_alloc.c:3079
 refresh_cpu_vm_stats+0x355/0x5d0 mm/vmstat.c:874
 vmstat_update+0xe/0xa0 mm/vmstat.c:1910
 process_one_work+0x9bf/0x16b0 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Modules linked in:
---[ end trace e038b7c668ec2f59 ]---
RIP: 0010:__free_one_page+0xa10/0xe30 mm/page_alloc.c:1073
Code: 43 34 85 c0 0f 84 79 f9 ff ff 48 c7 c6 80 1b 97 89 48 89 ef e8 61 dd f6 ff 0f 0b 48 c7 c6 60 1a 97 89 4c 89 ef e8 50 dd f6 ff <0f> 0b 0f 0b 48 c7 c6 c0 1a 97 89 4c 89 ef e8 3d dd f6 ff 0f 0b 48
RSP: 0018:ffffc90000ca7968 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffffc90000ca7a60 RCX: 0000000000000000
RDX: ffff888010e40000 RSI: ffffffff81b2f6b0 RDI: 0000000000000003
RBP: 0000000000152200 R08: 0000000000000018 R09: 00000000ffffffff
R10: ffffffff88f44b19 R11: 00000000ffffffff R12: 0000000000000009
R13: ffffea0005488000 R14: 0000000000000000 R15: ffff88823fff8e00
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 0000000036db1000 CR4: 00000000001526f0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

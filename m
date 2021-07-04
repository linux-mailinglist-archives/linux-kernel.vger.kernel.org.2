Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C738F3BAC13
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 10:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhGDIUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 04:20:05 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:52945 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhGDIUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 04:20:04 -0400
Received: by mail-io1-f72.google.com with SMTP id r3-20020a6b8f030000b02904e159249245so10905509iod.19
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 01:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nNhcC/aUAlX8toxDVfr9RUSI+nx8VnmoNpMNwmaRF/c=;
        b=YHS45at/B6EaHIx0iQSwNGroMlvvmfrroyql6wjb8vWdj8G6Dje7CCgfo6ziaynYio
         5ufPL6W7Ql+WUz4AdFES4b8gTQBBiXAFZtj/LDJc5GBHLKWA4o8xoJDC01GOWnWS1vYP
         fOQzitBIVafdIkZloAToHGFAyZL/r+9Z/HLSlHeYbmdnES2u0q3FJGaC2zUXRSWkd3w4
         F6Lq5xFCIOLnMaszNzKv0dhWrPraaYbEjRIhs2dljRLZEK2bHDnWVycfIoCCm0ndyTrv
         wCAg3D4RrFDfXQuD+P3kMY6LWgzAvMsm21a9T+KUx7A1W5PGGEd+5MD//VQQq8WxYhzh
         Ogvw==
X-Gm-Message-State: AOAM530ZHJ7AdhCR6k3qQEhhhtM9qpTxfQ/54XM8eh+TDoSVH7aNSxBr
        /etboKy04xuvjpRLghKSnBtaaZyYE80vGCpx+GPCu0rZmTjt
X-Google-Smtp-Source: ABdhPJwYw21a5ZiY/KUKXYnLKmZkl0yu4ifuB4HdHl6HYfv8swSAN+uXYDzE24Q7oP3Jb4gIoiMyqI9oDes99y6GQDJu17cQGD8K
MIME-Version: 1.0
X-Received: by 2002:a6b:e916:: with SMTP id u22mr6985068iof.155.1625386649300;
 Sun, 04 Jul 2021 01:17:29 -0700 (PDT)
Date:   Sun, 04 Jul 2021 01:17:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dab30c05c647d15a@google.com>
Subject: [syzbot] BUG: sleeping function called from invalid context in stack_depot_save
From:   syzbot <syzbot+b07d8440edb5f8988eea@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3dbdb38e Merge branch 'for-5.14' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144d5280300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=90b227e3653ac0d7
dashboard link: https://syzkaller.appspot.com/bug?extid=b07d8440edb5f8988eea
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117952e2300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13fbb394300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b07d8440edb5f8988eea@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at mm/page_alloc.c:5179
in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 9731, name: kworker/0:5
INFO: lockdep is turned off.
irq event stamp: 0
hardirqs last  enabled at (0): [<0000000000000000>] 0x0
hardirqs last disabled at (0): [<ffffffff81433b3b>] copy_process+0x1e1b/0x74c0 kernel/fork.c:2061
softirqs last  enabled at (0): [<ffffffff81433b7c>] copy_process+0x1e5c/0x74c0 kernel/fork.c:2065
softirqs last disabled at (0): [<0000000000000000>] 0x0
CPU: 0 PID: 9731 Comm: kworker/0:5 Tainted: G        W         5.13.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events pcpu_balance_workfn
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:96
 ___might_sleep.cold+0x1f1/0x237 kernel/sched/core.c:9153
 prepare_alloc_pages+0x3da/0x580 mm/page_alloc.c:5179
 __alloc_pages+0x12f/0x500 mm/page_alloc.c:5375
 alloc_pages+0x18c/0x2a0 mm/mempolicy.c:2272
 stack_depot_save+0x39d/0x4e0 lib/stackdepot.c:303
 save_stack+0x15e/0x1e0 mm/page_owner.c:120
 __set_page_owner+0x50/0x290 mm/page_owner.c:181
 prep_new_page mm/page_alloc.c:2445 [inline]
 __alloc_pages_bulk+0x8b9/0x1870 mm/page_alloc.c:5313
 alloc_pages_bulk_array_node include/linux/gfp.h:557 [inline]
 vm_area_alloc_pages mm/vmalloc.c:2775 [inline]
 __vmalloc_area_node mm/vmalloc.c:2845 [inline]
 __vmalloc_node_range+0x39d/0x960 mm/vmalloc.c:2947
 __vmalloc_node mm/vmalloc.c:2996 [inline]
 __vmalloc+0x69/0x80 mm/vmalloc.c:3010
 pcpu_mem_zalloc mm/percpu.c:517 [inline]
 pcpu_mem_zalloc+0x51/0xa0 mm/percpu.c:509
 pcpu_alloc_chunk mm/percpu.c:1455 [inline]
 pcpu_create_chunk+0xd7/0x720 mm/percpu-vm.c:337
 pcpu_balance_populated mm/percpu.c:2111 [inline]
 pcpu_balance_workfn+0xb13/0xd10 mm/percpu.c:2232
 process_one_work+0x98d/0x1630 kernel/workqueue.c:2276
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): wlan1: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
IPv6: ADDRCONF(NETDEV_CHANGE): wlan1: link becomes ready


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

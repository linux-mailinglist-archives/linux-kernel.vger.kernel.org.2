Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77133333F2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 04:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhCJDqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 22:46:24 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:45603 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbhCJDqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 22:46:08 -0500
Received: by mail-io1-f69.google.com with SMTP id u1so11934155ior.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 19:46:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=6KmbIryMnJRuVB/jrFecitp60+EqhV5C/4UGROrP/H4=;
        b=G882EXwEQZypBrT0iNQDYTfpRm4j/yS4hTdazpLqkI6f+YB0N0qMu2pN71XIgYM5Uv
         GP9ExGN6P+Sq6POVGqqfUMgI01vsLabJ4C9h+9xQbZVfkfJ9QDwHjMp6mnCawbApCC1F
         MmNixu/6VlHoJnCOzJ3DUq5didxSOKrF9OgSceo1nfd5rtw9Fnn2b8bALkLeY1+yYJPH
         T/D73EHM0xn56d4hOtOj3dDTMizoPyuQKJXDxHviDMndjEkbqaaTrgnoKwK/tqmUNCVg
         0D+h+ZlBzuoafsEtf/lXwEpmd5ik9X96HdDY30r0UhelFFIilKKxkNVZP5OgG9ZjVo0X
         tNhg==
X-Gm-Message-State: AOAM531t1Y70Uhaaph1dD0i7k85501zcCxJF4j2/mhkqRZ06Wgb5+cwl
        aCtNJtdOk5dYbFjRC5BohKSyXXsS5uTyNY1XXqDeaO8KS15f
X-Google-Smtp-Source: ABdhPJzLOmNxiRH6nceNk75CrvxwAUHBaDZHYkKoDlys3iwBS4YbeuzcGCb89sHaO1kUSXcUoVXp8vWkoI/PBBv+nfCOdFBBtNau
MIME-Version: 1.0
X-Received: by 2002:a05:6638:381c:: with SMTP id i28mr1347794jav.60.1615347967972;
 Tue, 09 Mar 2021 19:46:07 -0800 (PST)
Date:   Tue, 09 Mar 2021 19:46:07 -0800
In-Reply-To: <179d05df-3c1f-1609-b941-a737f8fb13e0@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d1da9c05bd26815d@google.com>
Subject: Re: [syzbot] possible deadlock in io_sq_thread_finish
From:   syzbot <syzbot+ac39856cb1b332dbbdda@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in io_sq_thread

==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x3e6f/0x54c0 kernel/locking/lockdep.c:4770
Read of size 8 at addr ffff888023e47c78 by task iou-sqp-10156/10158

CPU: 0 PID: 10158 Comm: iou-sqp-10156 Not tainted 5.12.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:232
 __kasan_report mm/kasan/report.c:399 [inline]
 kasan_report.cold+0x7c/0xd8 mm/kasan/report.c:416
 __lock_acquire+0x3e6f/0x54c0 kernel/locking/lockdep.c:4770
 lock_acquire kernel/locking/lockdep.c:5510 [inline]
 lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5475
 down_write+0x92/0x150 kernel/locking/rwsem.c:1406
 io_sq_thread+0x1220/0x1b10 fs/io_uring.c:6754
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

Allocated by task 10156:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:427 [inline]
 ____kasan_kmalloc mm/kasan/common.c:506 [inline]
 ____kasan_kmalloc mm/kasan/common.c:465 [inline]
 __kasan_kmalloc+0x99/0xc0 mm/kasan/common.c:515
 kmalloc include/linux/slab.h:554 [inline]
 kzalloc include/linux/slab.h:684 [inline]
 io_get_sq_data fs/io_uring.c:7153 [inline]
 io_sq_offload_create fs/io_uring.c:7827 [inline]
 io_uring_create fs/io_uring.c:9443 [inline]
 io_uring_setup+0x154b/0x2940 fs/io_uring.c:9523
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 3392:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:357
 ____kasan_slab_free mm/kasan/common.c:360 [inline]
 ____kasan_slab_free mm/kasan/common.c:325 [inline]
 __kasan_slab_free+0xf5/0x130 mm/kasan/common.c:367
 kasan_slab_free include/linux/kasan.h:199 [inline]
 slab_free_hook mm/slub.c:1562 [inline]
 slab_free_freelist_hook+0x92/0x210 mm/slub.c:1600
 slab_free mm/slub.c:3161 [inline]
 kfree+0xe5/0x7f0 mm/slub.c:4213
 io_put_sq_data fs/io_uring.c:7095 [inline]
 io_sq_thread_finish+0x48e/0x5b0 fs/io_uring.c:7113
 io_ring_ctx_free fs/io_uring.c:8355 [inline]
 io_ring_exit_work+0x333/0xcf0 fs/io_uring.c:8525
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

The buggy address belongs to the object at ffff888023e47c00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 120 bytes inside of
 512-byte region [ffff888023e47c00, ffff888023e47e00)
The buggy address belongs to the page:
page:00000000200f7571 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888023e47400 pfn:0x23e44
head:00000000200f7571 order:2 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head)
raw: 00fff00000010200 ffffea00005f6908 ffffea0000527508 ffff88800fc41c80
raw: ffff888023e47400 000000000010000f 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888023e47b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888023e47b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888023e47c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                ^
 ffff888023e47c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888023e47d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         dc5c40fb io_uring: always wait for sqd exited when stoppin..
git tree:       git://git.kernel.dk/linux-block io_uring-5.12
console output: https://syzkaller.appspot.com/x/log.txt?x=16cd022cd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b3c6cab008c50864
dashboard link: https://syzkaller.appspot.com/bug?extid=ac39856cb1b332dbbdda
compiler:       


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC513321362
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 10:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhBVJqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 04:46:49 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:40191 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhBVJpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:45:02 -0500
Received: by mail-io1-f70.google.com with SMTP id x26so8984543ior.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 01:44:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=sRSCXXLsLWScZcV2GmQdhJ4oAzh+7mRFWLA+pAoZM5g=;
        b=eB87rrmKSsYJ5XIsUZWGzkVtK3zvkecYawY84zMt1LnQn/la5G9sihJMW+Yi0bB1aT
         8OJNjaMPoqxoyfcvu+9Jj5g3UcpuXSxBolg/amWjrOm3P/cU3lHZyqKiLjFOK9n+8zAx
         Yb0gYKYjJDicxgvZv9i86FdOh+I5jDk6U70u3CUnGWjro7OAFQPEEBTgjyPIhCiW7/vi
         qgx8JsQZXnIpT/kJRjmwuJB3J33GvZEtb3PpSRgxxwMh7jStzz01KFFEdN+/EbSX4OPH
         9FuzT0zg0xC/9xLO/c5pyqIdTFAIM/3t3u92f/IkQzrLP7gOYp3kFb1GixK5giPISWCi
         4KuQ==
X-Gm-Message-State: AOAM533kyiW4rBO+yk2MdwMfc/712f6HcbkFt+ZtNm23r8pRrV7LSQyk
        qv0JvtwIOU4ADeAiLlIoKCJSBFhNaFU8L/dZrEqftbJex00O
X-Google-Smtp-Source: ABdhPJxD++H36CqpT/ewBnXlM/rGUgIrB8psiXFHsxchOpCZzo1S041vEtSvVA/OwV+h7clEtw7YD/oruAjqzjjE6lGec9U87XHP
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1381:: with SMTP id d1mr3514145ilo.45.1613987061399;
 Mon, 22 Feb 2021 01:44:21 -0800 (PST)
Date:   Mon, 22 Feb 2021 01:44:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007786a205bbe9a5d6@google.com>
Subject: KASAN: invalid-free in io_req_caches_free
From:   syzbot <syzbot+30b4936dcdb3aafa4fb4@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    31caf8b2 Merge branch 'linus' of git://git.kernel.org/pub/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15a8afa6d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a8f3a57fabb4015
dashboard link: https://syzkaller.appspot.com/bug?extid=30b4936dcdb3aafa4fb4

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+30b4936dcdb3aafa4fb4@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: double-free or invalid-free in io_req_caches_free.constprop.0+0x3ce/0x530 fs/io_uring.c:8709

CPU: 1 PID: 243 Comm: kworker/u4:6 Not tainted 5.11.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound io_ring_exit_work
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0xfa/0x151 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2c6 mm/kasan/report.c:230
 kasan_report_invalid_free+0x51/0x80 mm/kasan/report.c:355
 ____kasan_slab_free+0xcc/0xe0 mm/kasan/common.c:341
 kasan_slab_free include/linux/kasan.h:192 [inline]
 __cache_free mm/slab.c:3424 [inline]
 kmem_cache_free_bulk+0x4b/0x1b0 mm/slab.c:3744
 io_req_caches_free.constprop.0+0x3ce/0x530 fs/io_uring.c:8709
 io_ring_ctx_free fs/io_uring.c:8764 [inline]
 io_ring_exit_work+0x518/0x6b0 fs/io_uring.c:8846
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

Allocated by task 11900:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:401 [inline]
 ____kasan_kmalloc.constprop.0+0x7f/0xa0 mm/kasan/common.c:429
 kasan_slab_alloc include/linux/kasan.h:209 [inline]
 slab_post_alloc_hook mm/slab.h:512 [inline]
 kmem_cache_alloc_bulk+0x2c2/0x460 mm/slab.c:3534
 io_alloc_req fs/io_uring.c:2014 [inline]
 io_submit_sqes+0x18e8/0x2b60 fs/io_uring.c:6915
 __do_sys_io_uring_enter+0x1154/0x1f50 fs/io_uring.c:9454
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 11900:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:356
 ____kasan_slab_free+0xb0/0xe0 mm/kasan/common.c:362
 kasan_slab_free include/linux/kasan.h:192 [inline]
 __cache_free mm/slab.c:3424 [inline]
 kmem_cache_free_bulk+0x4b/0x1b0 mm/slab.c:3744
 io_req_caches_free.constprop.0+0x3ce/0x530 fs/io_uring.c:8709
 io_uring_flush+0x483/0x6e0 fs/io_uring.c:9237
 filp_close+0xb4/0x170 fs/open.c:1286
 close_files fs/file.c:403 [inline]
 put_files_struct fs/file.c:418 [inline]
 put_files_struct+0x1d0/0x350 fs/file.c:415
 exit_files+0x7e/0xa0 fs/file.c:435
 do_exit+0xc27/0x2ae0 kernel/exit.c:820
 do_group_exit+0x125/0x310 kernel/exit.c:922
 get_signal+0x42c/0x2100 kernel/signal.c:2773
 arch_do_signal_or_restart+0x2a8/0x1eb0 arch/x86/kernel/signal.c:811
 handle_signal_work kernel/entry/common.c:147 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x148/0x250 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:301
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff888012eaae00
 which belongs to the cache io_kiocb of size 208
The buggy address is located 0 bytes inside of
 208-byte region [ffff888012eaae00, ffff888012eaaed0)
The buggy address belongs to the page:
page:0000000091458aed refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x12eaa
flags: 0xfff00000000200(slab)
raw: 00fff00000000200 ffff8880188dcd50 ffff8880188dcd50 ffff888141b4ff00
raw: 0000000000000000 ffff888012eaa040 000000010000000c 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888012eaad00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888012eaad80: fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888012eaae00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888012eaae80: fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc fc
 ffff888012eaaf00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

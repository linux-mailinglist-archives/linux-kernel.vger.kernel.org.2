Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768463BCA02
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 12:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhGFKgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 06:36:09 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:51949 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhGFKgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 06:36:08 -0400
Received: by mail-il1-f198.google.com with SMTP id w19-20020a056e0213f3b02901ee5bb29e91so12312160ilj.18
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 03:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=HTEh+SMOm59WI4CodXAnvM9DEZpap7cETt1TV35bhnU=;
        b=L2Pw4/cfTWiaXb1/K1Ph5h6bmE+/QbfHxNvWu7Q1SVWAC7vDyyo5UIEQpkcm+3vMGk
         CuWynH9AW1WD72hRbclcvJ3nRjmtDqyVovidNYTtLLuaZUr5vJoitOJbHfrDzsB7U+p8
         jzyz0J9VUzjnjmiDnG0vkGMeimiQovYkutwl2Pkk4z69B1wKRndldANS26RGY2GPSSjt
         tTlFftdgfKpnTxnKqwtzb5/+MoPvSAUw7o+IOFdHJbFvMDh2Fvb0/bzzbs+kIfrjNkbt
         kt/unBKGHgMRHy+jExKY1oQVKtm87/1zIRPyIMBwj5uJU3F5hCIFGEOT85JTBTzu6lrE
         T8tA==
X-Gm-Message-State: AOAM532CvjAhDz8k0YugUWgIXRbSUKqP2GnAdZxcXZLsIe0jbkVL4vf8
        xs4RyBgriohaBX7C2eAcMGsw7ovQrE407xJvmxTSQ9rzWHaG
X-Google-Smtp-Source: ABdhPJxwZ6ebRQZi8N2jP4eLnHB684uP4HD+NZUVQmbxC6t/NQpf2rarA4672EzSlXNxDEIM03HUvvp1tNcmrzAepD/FURGxq2Wx
MIME-Version: 1.0
X-Received: by 2002:a02:ce94:: with SMTP id y20mr3518795jaq.18.1625567609708;
 Tue, 06 Jul 2021 03:33:29 -0700 (PDT)
Date:   Tue, 06 Jul 2021 03:33:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef663405c671f3a5@google.com>
Subject: [syzbot] upstream boot error: BUG: sleeping function called from
 invalid context in stack_depot_save
From:   syzbot <syzbot+0fb43da032dd2c0d2dbb@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    79160a60 Merge tag 'usb-5.14-rc1' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11052e78300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c86f97408164ca1
dashboard link: https://syzkaller.appspot.com/bug?extid=0fb43da032dd2c0d2dbb

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0fb43da032dd2c0d2dbb@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at mm/page_alloc.c:5178
in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 2, name: kthreadd
1 lock held by kthreadd/2:
 #0: ffff8880b9c31660 (lock#2){....}-{2:2}, at: __alloc_pages_bulk+0x4ad/0x1870 mm/page_alloc.c:5290
irq event stamp: 1804
hardirqs last  enabled at (1803): [<ffffffff81ba1f82>] slab_alloc_node mm/slab.c:3256 [inline]
hardirqs last  enabled at (1803): [<ffffffff81ba1f82>] kmem_cache_alloc_node_trace+0x412/0x5d0 mm/slab.c:3617
hardirqs last disabled at (1804): [<ffffffff81b17107>] __alloc_pages_bulk+0x1017/0x1870 mm/page_alloc.c:5290
softirqs last  enabled at (1716): [<ffffffff812b1cec>] memcpy include/linux/fortify-string.h:191 [inline]
softirqs last  enabled at (1716): [<ffffffff812b1cec>] fpu__copy+0x16c/0x660 arch/x86/kernel/fpu/core.c:241
softirqs last disabled at (1714): [<ffffffff812b1c21>] fpu__copy+0xa1/0x660 arch/x86/kernel/fpu/core.c:229
CPU: 0 PID: 2 Comm: kthreadd Not tainted 5.13.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:96
 ___might_sleep.cold+0x1f1/0x237 kernel/sched/core.c:9153
 prepare_alloc_pages+0x3da/0x580 mm/page_alloc.c:5178
 __alloc_pages+0x12f/0x500 mm/page_alloc.c:5374
 alloc_pages+0x18c/0x2a0 mm/mempolicy.c:2244
 stack_depot_save+0x39d/0x4e0 lib/stackdepot.c:303
 save_stack+0x15e/0x1e0 mm/page_owner.c:120
 __set_page_owner+0x50/0x290 mm/page_owner.c:181
 prep_new_page mm/page_alloc.c:2444 [inline]
 __alloc_pages_bulk+0x8b9/0x1870 mm/page_alloc.c:5312
 alloc_pages_bulk_array_node include/linux/gfp.h:557 [inline]
 vm_area_alloc_pages mm/vmalloc.c:2793 [inline]
 __vmalloc_area_node mm/vmalloc.c:2863 [inline]
 __vmalloc_node_range+0x39d/0x960 mm/vmalloc.c:2966
 alloc_thread_stack_node kernel/fork.c:245 [inline]
 dup_task_struct kernel/fork.c:875 [inline]
 copy_process+0x8db/0x74d0 kernel/fork.c:1952
 kernel_clone+0xe7/0xac0 kernel/fork.c:2509
 kernel_thread+0xb5/0xf0 kernel/fork.c:2561
 create_kthread kernel/kthread.c:342 [inline]
 kthreadd+0x4ea/0x750 kernel/kthread.c:685
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

============================================
WARNING: possible recursive locking detected
5.13.0-syzkaller #0 Tainted: G        W        
--------------------------------------------
kthreadd/2 is trying to acquire lock:
ffff8880b9c31660 (lock#2){....}-{2:2}, at: rmqueue_pcplist mm/page_alloc.c:3674 [inline]
ffff8880b9c31660 (lock#2){....}-{2:2}, at: rmqueue mm/page_alloc.c:3712 [inline]
ffff8880b9c31660 (lock#2){....}-{2:2}, at: get_page_from_freelist+0x486/0x2f80 mm/page_alloc.c:4174

but task is already holding lock:
ffff8880b9c31660 (lock#2){....}-{2:2}, at: __alloc_pages_bulk+0x4ad/0x1870 mm/page_alloc.c:5290

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(lock#2);
  lock(lock#2);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

1 lock held by kthreadd/2:
 #0: ffff8880b9c31660 (lock#2){....}-{2:2}, at: __alloc_pages_bulk+0x4ad/0x1870 mm/page_alloc.c:5290

stack backtrace:
CPU: 0 PID: 2 Comm: kthreadd Tainted: G        W         5.13.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:96
 print_deadlock_bug kernel/locking/lockdep.c:2944 [inline]
 check_deadlock kernel/locking/lockdep.c:2987 [inline]
 validate_chain kernel/locking/lockdep.c:3776 [inline]
 __lock_acquire.cold+0x149/0x3ab kernel/locking/lockdep.c:5015
 lock_acquire kernel/locking/lockdep.c:5625 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
 local_lock_acquire include/linux/local_lock_internal.h:42 [inline]
 rmqueue_pcplist mm/page_alloc.c:3674 [inline]
 rmqueue mm/page_alloc.c:3712 [inline]
 get_page_from_freelist+0x4aa/0x2f80 mm/page_alloc.c:4174
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5385
 alloc_pages+0x18c/0x2a0 mm/mempolicy.c:2244
 stack_depot_save+0x39d/0x4e0 lib/stackdepot.c:303
 save_stack+0x15e/0x1e0 mm/page_owner.c:120
 __set_page_owner+0x50/0x290 mm/page_owner.c:181
 prep_new_page mm/page_alloc.c:2444 [inline]
 __alloc_pages_bulk+0x8b9/0x1870 mm/page_alloc.c:5312
 alloc_pages_bulk_array_node include/linux/gfp.h:557 [inline]
 vm_area_alloc_pages mm/vmalloc.c:2793 [inline]
 __vmalloc_area_node mm/vmalloc.c:2863 [inline]
 __vmalloc_node_range+0x39d/0x960 mm/vmalloc.c:2966
 alloc_thread_stack_node kernel/fork.c:245 [inline]
 dup_task_struct kernel/fork.c:875 [inline]
 copy_process+0x8db/0x74d0 kernel/fork.c:1952
 kernel_clone+0xe7/0xac0 kernel/fork.c:2509
 kernel_thread+0xb5/0xf0 kernel/fork.c:2561
 create_kthread kernel/kthread.c:342 [inline]
 kthreadd+0x4ea/0x750 kernel/kthread.c:685
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

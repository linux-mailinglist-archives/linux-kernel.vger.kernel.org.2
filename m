Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3423499B1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 19:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhCYSs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 14:48:28 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:50882 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhCYSsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 14:48:18 -0400
Received: by mail-io1-f70.google.com with SMTP id a1so4431574iow.17
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 11:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=V9Wask0hVRTmvlZyaticoP0PIF3ZK9JtwdK+sjrFf+U=;
        b=Vx5gdpBLJt9cnTnqqKIHVjTrxO5ACHMRHYNzIDXxeI6PFRVTEcZxI9uA6BYdkwTDBY
         n5UeX0bFN84Gi+uwYxhRWfixRWZVo5hEWJpJCfIBcaW4wxDSpvWRZECZLnf5eV54c1ov
         2M221OGZFzmspHw8x9cqDkCicoIeKsgRt8VEMxFkdqWNhGhA61ahtlnm7iyTJuJInqmU
         I/4BLyWKjjGrZSbeb6EQ1eBEEInZLyZrrMDd+xi0hfTC+COliPbPBwnJRKpijhS9pVo3
         BvDlKVDRoNLkvB+S+1SKZQnyzJi0JMz6ZU6nNvyGTBkcLYzegjXIfG7Tll5Ziv863TB6
         3aew==
X-Gm-Message-State: AOAM532bkH/Fp6cFZ+M+dMOQVkXB9RzRGEcCFcQpNC8HUCBXAYWHhTIl
        V74UT8yBeJwfm+b4kKvrmVszkk3E6VrhCXVydaYsHEihCjsK
X-Google-Smtp-Source: ABdhPJytdaKW5rEtYo7fJAYwLwuXHkZTiKJndJ6rhIS+53KBlIomGm2FzVxucwbI8R11eKyY5qMKT8Euou0lI+uZoRJ2M2/ANm+z
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180d:: with SMTP id a13mr7856563ilv.142.1616698097995;
 Thu, 25 Mar 2021 11:48:17 -0700 (PDT)
Date:   Thu, 25 Mar 2021 11:48:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d7142c05be60db47@google.com>
Subject: [syzbot] BUG: soft lockup in get_page_from_freelist
From:   syzbot <syzbot+b6c93d85a3f77fca7f13@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e1381380 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11238fb2d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=460abe93fbc821a4
dashboard link: https://syzkaller.appspot.com/bug?extid=b6c93d85a3f77fca7f13
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b6c93d85a3f77fca7f13@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [syz-executor.1:22367]
Modules linked in:
irq event stamp: 4562
hardirqs last  enabled at (4561): [<ffff8000143e4dd8>] exit_to_kernel_mode+0x38/0x230 arch/arm64/kernel/entry-common.c:59
hardirqs last disabled at (4562): [<ffff8000143e54a0>] enter_el1_irq_or_nmi+0x10/0x20 arch/arm64/kernel/entry-common.c:101
softirqs last  enabled at (4442): [<ffff8000100109e0>] _stext+0x9e0/0x1084
softirqs last disabled at (4203): [<ffff80001015a04c>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
softirqs last disabled at (4203): [<ffff80001015a04c>] invoke_softirq kernel/softirq.c:228 [inline]
softirqs last disabled at (4203): [<ffff80001015a04c>] __irq_exit_rcu+0x46c/0x510 kernel/softirq.c:422
CPU: 0 PID: 22367 Comm: syz-executor.1 Not tainted 5.12.0-rc4-syzkaller-00223-ge138138003eb #0
Hardware name: linux,dummy-virt (DT)
pstate: 00000005 (nzcv daif -PAN -UAO -TCO BTYPE=--)
pc : clear_page+0x14/0x28 arch/arm64/lib/clear_page.S:23
lr : clear_highpage include/linux/highmem.h:203 [inline]
lr : kernel_init_free_pages+0x74/0x180 mm/page_alloc.c:1212
sp : ffff0000105e7630
x29: ffff0000105e7630 x28: fffffc0000180f00 
x27: ffff00007fc13ec0 x26: ffff00000a7be378 
x25: ffff6000014f7c6f x24: 00000000000014b8 
x23: ffff00000a7bcec0 x22: fffffc0000180f40 
x21: ffff8000154f3398 x20: dfff800000000000 
x19: fffffc0000180f00 x18: 0000000000000000 
x17: 0000000000000000 x16: 0000000000000000 
x15: 0000000000000000 x14: 1fffe000020bce90 
x13: 0000000000000001 x12: ffff7f80000301e7 
x11: 1fffff80000301e6 x10: ffff7f80000301e6 
x9 : 0000000000000000 x8 : ffff600000c07a00 
x7 : 0000000000000000 x6 : 000000000000003f 
x5 : 0000000000000040 x4 : 1ffff00002fa7950 
x3 : 1fffe000014f79d9 x2 : 0000000000000004 
x1 : 0000000000000040 x0 : ffff00000603cf40 
Call trace:
 clear_page+0x14/0x28 arch/arm64/lib/clear_page.S:21
 post_alloc_hook+0x130/0x1fc mm/page_alloc.c:2305
 prep_new_page mm/page_alloc.c:2311 [inline]
 get_page_from_freelist+0x2024/0x2a40 mm/page_alloc.c:3951
 __alloc_pages_nodemask+0x2a0/0x24dc mm/page_alloc.c:5001
 alloc_pages_vma+0xb4/0x510 mm/mempolicy.c:2240
 alloc_zeroed_user_highpage_movable include/linux/highmem.h:197 [inline]
 do_anonymous_page mm/memory.c:3548 [inline]
 handle_pte_fault mm/memory.c:4316 [inline]
 __handle_mm_fault+0xc88/0x21d4 mm/memory.c:4453
 handle_mm_fault+0x1cc/0x4dc mm/memory.c:4551
 __do_page_fault arch/arm64/mm/fault.c:507 [inline]
 do_page_fault+0x228/0x880 arch/arm64/mm/fault.c:591
 do_translation_fault+0x1a4/0x210 arch/arm64/mm/fault.c:672
 do_mem_abort+0x64/0x1c0 arch/arm64/mm/fault.c:805
 el0_da+0x3c/0x50 arch/arm64/kernel/entry-common.c:308
 el0_sync_compat_handler+0x114/0x140 arch/arm64/kernel/entry-common.c:506
 el0_sync_compat+0x174/0x180 arch/arm64/kernel/entry.S:708


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE94B340E46
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 20:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbhCRTbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 15:31:35 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:38638 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbhCRTbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 15:31:19 -0400
Received: by mail-il1-f199.google.com with SMTP id o7so32824045ilt.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 12:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=43oaLHeDqYPFRF709YvRp5LNYGvRqhu+ea7V+7EDzxo=;
        b=inJ3zXvzl6QeT3/S5wJKDtWP+YFv4SB0udvAWxguFwU2wgi3zkf2pohk6hAE+cgFF+
         N4o+ZptQy1fSHFsMnwDD8omi9Eg5SMK8k7+3aGbBcf/0sI9/7vTWqbKEgqmLPPLzzzoW
         6uIT88unRh//8rIXxJXEdIJv7K55Lxv1Kr8UX4ljM43NX/Derc/uqoJAzXdQ2GgdzxhT
         EHg7LnQV6edBQwO71f/mnC9GXIsnjf/wngzr3Lor2LCI4Z42a9CTRSMxMpXV9bRsrjug
         Y78oovYEa4fAiPYY+KzHAtC5275JhwdCBUip86sTwlmKfeZLXmki+CmYsQ4ugIAsrdyd
         x8Xw==
X-Gm-Message-State: AOAM530UofGonZaUm9fzXsWw78uSTuqGy7AT5DEgfcxEvWqL/pnbGa5o
        H0C4qB+W5YHYT2NKeKp8GkxahA+eVaiR7nxW49w6vDEfV8cU
X-Google-Smtp-Source: ABdhPJybDMwh0F0N5bv6PxRz1yFnCnivEPho+nec3y6aoVb2dARy/tbdOtM7+3iHE6TBurtxu5TAa3bZbukv8DT4oQeAaSApdl6v
MIME-Version: 1.0
X-Received: by 2002:a5d:9f4a:: with SMTP id u10mr121650iot.186.1616095879251;
 Thu, 18 Mar 2021 12:31:19 -0700 (PDT)
Date:   Thu, 18 Mar 2021 12:31:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce4c9505bdd4a48f@google.com>
Subject: [syzbot] BUG: soft lockup in do_wp_page (4)
From:   syzbot <syzbot+0b036374a865ba0efa8e@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bf152b0b Merge tag 'for_linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17d5264ed00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c9917c41f0bc04b
dashboard link: https://syzkaller.appspot.com/bug?extid=0b036374a865ba0efa8e
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0b036374a865ba0efa8e@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [syz-executor.1:3684]
Modules linked in:
irq event stamp: 10067468
hardirqs last  enabled at (10067467): [<ffff8000143de478>] exit_to_kernel_mode+0x38/0x230 arch/arm64/kernel/entry-common.c:59
hardirqs last disabled at (10067468): [<ffff8000143deb40>] enter_el1_irq_or_nmi+0x10/0x20 arch/arm64/kernel/entry-common.c:101
softirqs last  enabled at (10067362): [<ffff8000100109e0>] _stext+0x9e0/0x1084
softirqs last disabled at (10067297): [<ffff80001015976c>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
softirqs last disabled at (10067297): [<ffff80001015976c>] invoke_softirq kernel/softirq.c:228 [inline]
softirqs last disabled at (10067297): [<ffff80001015976c>] __irq_exit_rcu+0x46c/0x510 kernel/softirq.c:422
CPU: 0 PID: 3684 Comm: syz-executor.1 Not tainted 5.12.0-rc3-syzkaller-00036-gbf152b0b41dc #0
Hardware name: linux,dummy-virt (DT)
pstate: 00000005 (nzcv daif -PAN -UAO -TCO BTYPE=--)
pc : clear_page+0x14/0x28 arch/arm64/lib/clear_page.S:23
lr : clear_highpage include/linux/highmem.h:203 [inline]
lr : kernel_init_free_pages+0x74/0x180 mm/page_alloc.c:1212
sp : ffff00000c6cf4a0
x29: ffff00000c6cf4a0 x28: fffffc0000180b00 
x27: ffff00007fc13ec0 x26: ffff00000b709458 
x25: ffff6000016e128b x24: 0000000000001458 
x23: ffff00000b708000 x22: fffffc0000180b40 
x21: ffff8000154e2938 x20: dfff800000000000 
x19: fffffc0000180b00 x18: 0000000000000000 
x17: 0000000000000000 x16: 0000000000000000 
x15: 0000000000000000 x14: 1fffe000018d9e5e 
x13: 0000000000000001 x12: ffff7f8000030167 
x11: 1fffff8000030166 x10: ffff7f8000030166 
x9 : 0000000000000000 x8 : ffff600000c05a00 
x7 : 0000000000000000 x6 : 000000000000003f 
x5 : 0000000000000040 x4 : 1ffff00002fa5748 
x3 : 1fffe000016e1001 x2 : 0000000000000004 
x1 : 0000000000000040 x0 : ffff00000602ce00 
Call trace:
 clear_page+0x14/0x28 arch/arm64/lib/clear_page.S:21
 post_alloc_hook+0x130/0x1fc mm/page_alloc.c:2305
 prep_new_page mm/page_alloc.c:2311 [inline]
 get_page_from_freelist+0x2024/0x2a40 mm/page_alloc.c:3951
 __alloc_pages_nodemask+0x2a0/0x24dc mm/page_alloc.c:5001
 alloc_pages_vma+0xb4/0x510 mm/mempolicy.c:2240
 wp_page_copy+0x198/0x16e0 mm/memory.c:2853
 do_wp_page+0x1d8/0xbbc mm/memory.c:3160
 handle_pte_fault mm/memory.c:4336 [inline]
 __handle_mm_fault+0x1020/0x21d4 mm/memory.c:4453
 handle_mm_fault+0x1cc/0x4dc mm/memory.c:4551
 __do_page_fault arch/arm64/mm/fault.c:507 [inline]
 do_page_fault+0x228/0x880 arch/arm64/mm/fault.c:591
 do_mem_abort+0x64/0x1c0 arch/arm64/mm/fault.c:805
 el0_da+0x3c/0x50 arch/arm64/kernel/entry-common.c:308
 el0_sync_handler+0x168/0x1b0 arch/arm64/kernel/entry-common.c:435
 el0_sync+0x170/0x180 arch/arm64/kernel/entry.S:699


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC40401259
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 03:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238476AbhIFBGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 21:06:45 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:54972 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbhIFBGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 21:06:44 -0400
Received: by mail-io1-f71.google.com with SMTP id e2-20020a056602044200b005c23c701e26so4039554iov.21
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 18:05:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+rZ8z9tqSM6UQv/Jg7EoW4+EH9LkcJd9v/lEDs76fmo=;
        b=aU5VK7n0KIlL1BH60i2PhBNcdW3C1zREIYoySuHSBfiNfTRfIzoq+4TcjtCAEsGGA3
         PVBc2+8psnB5ee/e+WjtM0Xa7+X63BC7vqOJsCmpL4kBFTu1dQYaUXiAhNoKZKWFvqLh
         CVo9AD9GuU/rIWVfuaZArpHG5als/Kc8VMwFRlfr004j4uRmmkQyh7BQuWG3GtepBoNC
         o/mHm1nqCIYuSkhMclLYGjoZBL4Fy5z+jQiZbNAVYZacHaLEvRBGGkrMs9tx6TxR8jad
         94EsXOPIDUeIRV73at9KqTqWsX+w2NRTkjPuKMBYgCQ3FGM9Sdqdu+bYyWTHcQH1TZaj
         9shA==
X-Gm-Message-State: AOAM530CLSyFwj94eB5ued++BEZpikaxuanaS8SUdHMyFzUpt/00E76j
        +nBTozQcIMLqLq31FMAJJdFlt6iU92jMa5Z+fh47dN/0oUR9
X-Google-Smtp-Source: ABdhPJyeGPZ+qvqjWrHDvPV/Q4XCGVoEHJbbR8mHPwan4DNd3wae9rmhn+MQ+9dBR6HrlPuZHF/+gxSZaPch1beeThu4WT+/1waY
MIME-Version: 1.0
X-Received: by 2002:a02:ab98:: with SMTP id t24mr8425758jan.115.1630890340082;
 Sun, 05 Sep 2021 18:05:40 -0700 (PDT)
Date:   Sun, 05 Sep 2021 18:05:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000063692b05cb493f6d@google.com>
Subject: [syzbot] BUG: soft lockup in handle_mm_fault (2)
From:   syzbot <syzbot+aa7a876b8108f1622bc3@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    49624efa65ac Merge tag 'denywrite-for-5.15' of git://githu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12eff4b3300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c598149362d97396
dashboard link: https://syzkaller.appspot.com/bug?extid=aa7a876b8108f1622bc3
compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aa7a876b8108f1622bc3@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [syz-executor.1:26449]
Modules linked in:
irq event stamp: 248
hardirqs last  enabled at (247): [<ffff8000145ed108>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:81 [inline]
hardirqs last  enabled at (247): [<ffff8000145ed108>] exit_to_kernel_mode+0x38/0x230 arch/arm64/kernel/entry-common.c:91
hardirqs last disabled at (248): [<ffff8000145ed0c0>] enter_el1_irq_or_nmi+0x10/0x20 arch/arm64/kernel/entry-common.c:227
softirqs last  enabled at (182): [<ffff800010010964>] _stext+0x964/0xff8
softirqs last disabled at (41): [<ffff800010160f58>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
softirqs last disabled at (41): [<ffff800010160f58>] invoke_softirq kernel/softirq.c:439 [inline]
softirqs last disabled at (41): [<ffff800010160f58>] __irq_exit_rcu+0x208/0x4f0 kernel/softirq.c:636
CPU: 0 PID: 26449 Comm: syz-executor.1 Not tainted 5.14.0-syzkaller-09416-g49624efa65ac #0
Hardware name: linux,dummy-virt (DT)
pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : clear_page+0x14/0x28 arch/arm64/lib/clear_page.S:23
lr : clear_highpage include/linux/highmem.h:181 [inline]
lr : kernel_init_free_pages.part.0+0x6c/0x17c mm/page_alloc.c:1286
sp : ffff800019be75e0
x29: ffff800019be75e0 x28: 0000000000000000 x27: 0000000000000000
x26: ffff000009d64940 x25: ffff6000013ac928 x24: 00000000000014c0
x23: ffff000009d63480 x22: fffffc0000173340 x21: ffff800015794a78
x20: dfff800000000000 x19: fffffc0000173300 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 1ffff0000337ce86 x13: 0000000000000013 x12: ffff7f800002e667
x11: 1fffff800002e666 x10: ffff7f800002e666 x9 : 0000000000000000
x8 : ffff600000b99a00 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : 1ffff00003060d98 x3 : 1fffe000013ac691
x2 : 0000000000000004 x1 : 0000000000000040 x0 : ffff000005ccc880
Call trace:
 clear_page+0x14/0x28 arch/arm64/lib/clear_page.S:21
 kernel_init_free_pages mm/page_alloc.c:1283 [inline]
 post_alloc_hook+0x1ac/0x25c mm/page_alloc.c:2426
 prep_new_page mm/page_alloc.c:2436 [inline]
 get_page_from_freelist+0x184c/0x2320 mm/page_alloc.c:4168
 __alloc_pages+0x1a8/0x21d0 mm/page_alloc.c:5390
 alloc_pages_vma+0xbc/0x530 mm/mempolicy.c:2252
 alloc_zeroed_user_highpage_movable+0x9c/0xd0 arch/arm64/mm/fault.c:926
 do_anonymous_page mm/memory.c:3767 [inline]
 handle_pte_fault mm/memory.c:4556 [inline]
 __handle_mm_fault+0xbc4/0x2210 mm/memory.c:4693
 handle_mm_fault+0x1dc/0x4f0 mm/memory.c:4791
 __do_page_fault arch/arm64/mm/fault.c:499 [inline]
 do_page_fault+0x230/0x8c0 arch/arm64/mm/fault.c:599
 do_translation_fault+0x1a4/0x210 arch/arm64/mm/fault.c:680
 do_mem_abort+0x64/0x1c0 arch/arm64/mm/fault.c:813
 el0_da+0x7c/0x2b0 arch/arm64/kernel/entry-common.c:481
 el0t_64_sync_handler+0x168/0x1b0 arch/arm64/kernel/entry-common.c:616
 el0t_64_sync+0x1a0/0x1a4 arch/arm64/kernel/entry.S:572


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

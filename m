Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4C53880CF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 21:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351968AbhERTyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 15:54:38 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:48880 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240654AbhERTyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 15:54:37 -0400
Received: by mail-il1-f197.google.com with SMTP id z11-20020a92d6cb0000b02901bb992c83cbso3636027ilp.15
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 12:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=aaDl7ZbSnxqEBT8DwnM37+j8F2fz8t9QTBf+BxiEuNI=;
        b=HugwvcUp6TTBVKuKpIXsoA7L3mKkxogzL+YxbNhP8+KRvgfiOQt/rTrcj1IzC9frCl
         RWoPRKkjUZcpQC5PmXJGZV+1MFIzxPlK3OSyALBbknCA7zitXdujkzTjETRrqaU8D0Rv
         h6ml3ej6y5tHZpdGc7vhz/XwLWiOqk3/2whV6PZmt0OTERc42KQMSHcpHKcQtaPPjibc
         IfCLd7khhJgZUjSg0D1hVrfgar00CyK7oBPgSRuK9R1rl8xyhFB4Kteq+8EWNz4CJnU1
         LnuAOOF80DXjtEB4eyp0qOGoXIJDsdjnqzSdCUVeZvuzae57T1p/Qz/95xpe7q745FyJ
         nhuQ==
X-Gm-Message-State: AOAM533t/xnkxKw/pTaNLfxtF2ZGh+s6MVIzNFEimQbE/D7Bi6Evm6rQ
        SGJ+P+nK073ncUYytpSxbXLN9CaF6Rz00D0ayTuMnlfsTJOX
X-Google-Smtp-Source: ABdhPJxETxnuivD7MMYBDaid1+rPUtG22VcoNttlhnusQpVn9sp/TE+iCKWc6ver8lttvD0k3EZ34F7+fg3RoO9VcEEkd0cWscVC
MIME-Version: 1.0
X-Received: by 2002:a02:8787:: with SMTP id t7mr7660502jai.53.1621367597493;
 Tue, 18 May 2021 12:53:17 -0700 (PDT)
Date:   Tue, 18 May 2021 12:53:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b2f48705c2a00f67@google.com>
Subject: [syzbot] BUG: soft lockup in handle_mm_fault
From:   syzbot <syzbot+44b5132ce1d2d712a574@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d07f6ca9 Linux 5.13-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1772d265d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2302c3f03979672
dashboard link: https://syzkaller.appspot.com/bug?extid=44b5132ce1d2d712a574
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+44b5132ce1d2d712a574@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [syz-executor.1:13795]
Modules linked in:
irq event stamp: 2262
hardirqs last  enabled at (2261): [<ffff8000144b1da8>] exit_to_kernel_mode+0x38/0x230 arch/arm64/kernel/entry-common.c:63
hardirqs last disabled at (2262): [<ffff8000144b2470>] enter_el1_irq_or_nmi+0x10/0x20 arch/arm64/kernel/entry-common.c:105
softirqs last  enabled at (2200): [<ffff8000100109e0>] _stext+0x9e0/0x1084
softirqs last disabled at (2117): [<ffff80001015e8d4>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
softirqs last disabled at (2117): [<ffff80001015e8d4>] invoke_softirq kernel/softirq.c:440 [inline]
softirqs last disabled at (2117): [<ffff80001015e8d4>] __irq_exit_rcu+0x494/0x550 kernel/softirq.c:637
CPU: 0 PID: 13795 Comm: syz-executor.1 Not tainted 5.13.0-rc2-syzkaller #0
Hardware name: linux,dummy-virt (DT)
pstate: 00000005 (nzcv daif -PAN -UAO -TCO BTYPE=--)
pc : clear_page+0x14/0x28 arch/arm64/lib/clear_page.S:23
lr : clear_highpage include/linux/highmem.h:203 [inline]
lr : kernel_init_free_pages+0x74/0x180 mm/page_alloc.c:1238
sp : ffff8000199874c0
x29: ffff8000199874c0 x28: ffff00007fc13ec0 x27: 0000000000000000
x26: ffff00000b47af00 x25: ffff60000168f5e0 x24: 00000000000014c0
x23: ffff00000b479a40 x22: fffffc0000185bc0 x21: ffff80001560e558
x20: dfff800000000000 x19: fffffc0000185b80 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 1ffff00003330e62 x13: 0000000000000001 x12: ffff7f8000030b77
x11: 1fffff8000030b76 x10: ffff7f8000030b76 x9 : 0000000000000000
x8 : ffff600000c2de00 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : 1ffff000030ec350 x3 : 1fffe0000168f349
x2 : 0000000000000004 x1 : 0000000000000040 x0 : ffff00000616ef40
Call trace:
 clear_page+0x14/0x28 arch/arm64/lib/clear_page.S:21
 post_alloc_hook+0x108/0x21c mm/page_alloc.c:2350
 prep_new_page mm/page_alloc.c:2358 [inline]
 get_page_from_freelist+0x1998/0x235c mm/page_alloc.c:3994
 __alloc_pages+0x1a8/0x21e0 mm/page_alloc.c:5200
 alloc_pages_vma+0xb4/0x510 mm/mempolicy.c:2236
 wp_page_copy+0x198/0x1720 mm/memory.c:2896
 do_wp_page+0x1d8/0xbbc mm/memory.c:3203
 handle_pte_fault mm/memory.c:4385 [inline]
 __handle_mm_fault+0x10c8/0x26f0 mm/memory.c:4502
 handle_mm_fault+0x1cc/0x4e0 mm/memory.c:4600
 __do_page_fault arch/arm64/mm/fault.c:507 [inline]
 do_page_fault+0x230/0x8c0 arch/arm64/mm/fault.c:607
 do_mem_abort+0x64/0x1c0 arch/arm64/mm/fault.c:821
 el0_da+0x3c/0x50 arch/arm64/kernel/entry-common.c:306
 el0_sync_handler+0x168/0x1b0 arch/arm64/kernel/entry-common.c:427
 el0_sync+0x198/0x1c0 arch/arm64/kernel/entry.S:734


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

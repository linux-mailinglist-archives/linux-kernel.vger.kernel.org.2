Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDA640F34D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240616AbhIQHcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:32:41 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:35667 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhIQHck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:32:40 -0400
Received: by mail-il1-f198.google.com with SMTP id f4-20020a056e0204c400b0022dbd3f8b18so20309757ils.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/BCpZC2CEqwllBmiEKngtnImQFDYFKH06oLpAqVHbAc=;
        b=VUqvgu9zxtr2s+jds2L9S9ylh68QYTxhl1vZQpXpQ0jFwtufpz5OnirB9ifu4lodlz
         Y9pnJiIZwEpCJQl4GBGBW+0VOBo1QzIEutLII4wPDDU4A0HLU6wh9foGhU1cVCA3YHtL
         Czz8p5LypM24UNPGGiI7ADwINNTkxjsshP+kh9M4LApLCmnEUOfVuUbp1udAtpelkgmH
         deRNoXIDplEa3XUdT5jTEyRGZO7rpPuHiNi5wEcjlXc8XNCfYgyPj64quhBP5Uqx+4cX
         RLWwK/bNorFoEoixwbpnHS1pj68dluMn6SKSyHQny7wr3yWZmjtMBmf/Cg69/YJFDtO1
         L70g==
X-Gm-Message-State: AOAM530mBvy/PKVAGpbqYOQVysZ7ey1MnLaevSAzKh0tlI5m3wbpNpHZ
        IaaRUuo9rhOLSLXm8+u24solPzdstg4ReHdPn/x5VUo5ay5R
X-Google-Smtp-Source: ABdhPJxL2s+a4rCD83BCkK1TE5yHvrFTEO9uDY/FepB8U20cSUSnzaZbnhR3DzIlaGD8atv+YqQDJubc8JtTC9+7ZtOesrR6V1TV
MIME-Version: 1.0
X-Received: by 2002:a02:5442:: with SMTP id t63mr7525825jaa.7.1631863878696;
 Fri, 17 Sep 2021 00:31:18 -0700 (PDT)
Date:   Fri, 17 Sep 2021 00:31:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cfc3ae05cc2bea91@google.com>
Subject: [syzbot] BUG: soft lockup in kjournald2 (2)
From:   syzbot <syzbot+50f834e0ee66561f76fe@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ac08b1c68d1b Merge tag 'pci-v5.15-changes' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17d44ab3300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b196c22f1ee14fd4
dashboard link: https://syzkaller.appspot.com/bug?extid=50f834e0ee66561f76fe
compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+50f834e0ee66561f76fe@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [jbd2/vda-8:3107]
Modules linked in:
irq event stamp: 373534
hardirqs last  enabled at (373533): [<ffff8000145f8e78>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:81 [inline]
hardirqs last  enabled at (373533): [<ffff8000145f8e78>] exit_to_kernel_mode+0x38/0x230 arch/arm64/kernel/entry-common.c:91
hardirqs last disabled at (373534): [<ffff8000145f8e30>] enter_el1_irq_or_nmi+0x10/0x20 arch/arm64/kernel/entry-common.c:227
softirqs last  enabled at (373478): [<ffff800010010964>] _stext+0x964/0xff8
softirqs last disabled at (373447): [<ffff800010161e88>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
softirqs last disabled at (373447): [<ffff800010161e88>] invoke_softirq kernel/softirq.c:439 [inline]
softirqs last disabled at (373447): [<ffff800010161e88>] __irq_exit_rcu+0x208/0x4f0 kernel/softirq.c:636
CPU: 1 PID: 3107 Comm: jbd2/vda-8 Not tainted 5.14.0-syzkaller-10318-gac08b1c68d1b #0
Hardware name: linux,dummy-virt (DT)
pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : clear_page+0x14/0x28 arch/arm64/lib/clear_page.S:23
lr : clear_highpage include/linux/highmem.h:181 [inline]
lr : kernel_init_free_pages.part.0+0x6c/0x17c mm/page_alloc.c:1286
sp : ffff80001ef77070
x29: ffff80001ef77070 x28: 0000000000000000 x27: 0000000000000000
x26: ffff00001026e378 x25: ffff60000204dc6f x24: 00000000000014b8
x23: ffff00001026cec0 x22: fffffc0000173f40 x21: ffff8000157be698
x20: dfff800000000000 x19: fffffc0000173f00 x18: ffff00006aa76c08
x17: 0000000000000000 x16: 0000000000000000 x15: ffff00006aa76c3c
x14: 1ffff00003deedd8 x13: 0000000000000013 x12: ffff7f800002e7e7
x11: 1fffff800002e7e6 x10: ffff7f800002e7e6 x9 : 0000000000000000
x8 : ffff600000b9fa00 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : 1ffff00003067da0 x3 : 1fffe0000204d9d9
x2 : 0000000000000004 x1 : 0000000000000040 x0 : ffff000005cfc8c0
Call trace:
 clear_page+0x14/0x28 arch/arm64/lib/clear_page.S:21
 kernel_init_free_pages mm/page_alloc.c:1283 [inline]
 post_alloc_hook+0x1ac/0x25c mm/page_alloc.c:2426
 prep_new_page mm/page_alloc.c:2436 [inline]
 get_page_from_freelist+0x184c/0x2320 mm/page_alloc.c:4168
 __alloc_pages+0x1a8/0x21d0 mm/page_alloc.c:5390
 alloc_pages+0x23c/0x3b0 mm/mempolicy.c:2291
 __page_cache_alloc mm/filemap.c:1022 [inline]
 pagecache_get_page+0x4ac/0x930 mm/filemap.c:1940
 find_or_create_page include/linux/pagemap.h:420 [inline]
 grow_dev_page fs/buffer.c:949 [inline]
 grow_buffers fs/buffer.c:1014 [inline]
 __getblk_slow+0x178/0x6bc fs/buffer.c:1041
 __getblk_gfp+0x7c/0xa0 fs/buffer.c:1334
 __getblk include/linux/buffer_head.h:382 [inline]
 jbd2_journal_get_descriptor_buffer+0xf0/0x3f0 fs/jbd2/journal.c:1014
 journal_submit_commit_record.part.0+0x88/0x7fc fs/jbd2/commit.c:131
 journal_submit_commit_record fs/jbd2/commit.c:128 [inline]
 jbd2_journal_commit_transaction+0x2ad4/0x4270 fs/jbd2/commit.c:925
 kjournald2+0x190/0x734 fs/jbd2/journal.c:213
 kthread+0x334/0x3dc kernel/kthread.c:319
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

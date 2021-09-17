Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9317440F363
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241355AbhIQHjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241219AbhIQHjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:39:20 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3042C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:37:58 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id c8-20020a9d6c88000000b00517cd06302dso11710233otr.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ieEsVRV9Qoysgfimh3k7jq5I/5iERhZWS3sMgWukkvs=;
        b=Yb44cleTqY3lTGNiJSNC6d+eStRWrplea4vPPL9N+9oaAAxAPa+QYT5lpsvfyeTEK/
         fbwW1S3bwOI4i038r5cWUCZ6lJKJ513ZLLGAldsfoQxPVF2zWzUsWfb2agCN/u5PsU/v
         esUnqxdLQHF/tZsdxmaSb0skKN84d2mgVFowL0CnHzNGRcd/ll26yiQNDfmdEJdt41xC
         br4v1ogcvqG7cF4opRyyxMXaImJEsMMhzLvjC8+PIbWPIRvmL6jEjwAEevsWodrka2is
         LOg3RcGm3pUxl7taLECOHo9/h5O9uIhZ+Z3AGaozh5SZirQd2ENZvIUUOhfy/VtJLZp+
         SRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ieEsVRV9Qoysgfimh3k7jq5I/5iERhZWS3sMgWukkvs=;
        b=6lfHvorlCX3dSD6bYdIh5fuwsKJVoJg7CK7w5RHTmkjZfEeJaC5wTqAWWoSvjFdPg4
         4+1f/lcL/EzEh4Nq/0LvGnMmXrtNL9ponY2NPWhlg/10CNWuqCfQTkt2uMxdnduWJuVS
         yeEBtslbNG/yrYWgtZ9YusmGcjLpe+oyoOcvonHCCuffE3qOPAIw6UW7CyZzBJp8NMFA
         QcbYz3uruLOyJQlGS/iyzzvo5LYXvqAt8p9S9sB5grk4gW2VgCxWHM6Lt3MiZp2nFDot
         jDnCoMgvUSfBFdNJX/BcZIYfuZLx/2LVvdoWz0VoCzqetYO5/ZQVVkCYaDpNh6FVTRkp
         x5bQ==
X-Gm-Message-State: AOAM530EOYg7qMtPC4gGjPF6QXMI5RAe/ixI59XwKDbHCG9Ln4G089K6
        aTPbKeswRQiEOIugvZyRAcTGZAHzSLBHMew0G0LLtw==
X-Google-Smtp-Source: ABdhPJxtkHJ0OY5DqFpPqIWbVD3NJURRP9xPEdK+HfiANQnSOmghdmkIJCfP9A/qEeZ8tgTrkmxGhIrywOimK5TmPX4=
X-Received: by 2002:a9d:7244:: with SMTP id a4mr8528050otk.137.1631864277871;
 Fri, 17 Sep 2021 00:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000cfc3ae05cc2bea91@google.com>
In-Reply-To: <000000000000cfc3ae05cc2bea91@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 17 Sep 2021 09:37:47 +0200
Message-ID: <CACT4Y+Yv9NEPidRkoubADmpi_U2kfJaFoO_S4M=BixuYRVb0iQ@mail.gmail.com>
Subject: Re: [syzbot] BUG: soft lockup in kjournald2 (2)
To:     syzbot <syzbot+50f834e0ee66561f76fe@syzkaller.appspotmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sept 2021 at 09:31, syzbot
<syzbot+50f834e0ee66561f76fe@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    ac08b1c68d1b Merge tag 'pci-v5.15-changes' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17d44ab3300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b196c22f1ee14fd4
> dashboard link: https://syzkaller.appspot.com/bug?extid=50f834e0ee66561f76fe
> compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> userspace arch: arm64
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+50f834e0ee66561f76fe@syzkaller.appspotmail.com
>
> watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [jbd2/vda-8:3107]
> Modules linked in:
> irq event stamp: 373534
> hardirqs last  enabled at (373533): [<ffff8000145f8e78>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:81 [inline]
> hardirqs last  enabled at (373533): [<ffff8000145f8e78>] exit_to_kernel_mode+0x38/0x230 arch/arm64/kernel/entry-common.c:91
> hardirqs last disabled at (373534): [<ffff8000145f8e30>] enter_el1_irq_or_nmi+0x10/0x20 arch/arm64/kernel/entry-common.c:227
> softirqs last  enabled at (373478): [<ffff800010010964>] _stext+0x964/0xff8
> softirqs last disabled at (373447): [<ffff800010161e88>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
> softirqs last disabled at (373447): [<ffff800010161e88>] invoke_softirq kernel/softirq.c:439 [inline]
> softirqs last disabled at (373447): [<ffff800010161e88>] __irq_exit_rcu+0x208/0x4f0 kernel/softirq.c:636
> CPU: 1 PID: 3107 Comm: jbd2/vda-8 Not tainted 5.14.0-syzkaller-10318-gac08b1c68d1b #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : clear_page+0x14/0x28 arch/arm64/lib/clear_page.S:23
> lr : clear_highpage include/linux/highmem.h:181 [inline]
> lr : kernel_init_free_pages.part.0+0x6c/0x17c mm/page_alloc.c:1286
> sp : ffff80001ef77070
> x29: ffff80001ef77070 x28: 0000000000000000 x27: 0000000000000000
> x26: ffff00001026e378 x25: ffff60000204dc6f x24: 00000000000014b8
> x23: ffff00001026cec0 x22: fffffc0000173f40 x21: ffff8000157be698
> x20: dfff800000000000 x19: fffffc0000173f00 x18: ffff00006aa76c08
> x17: 0000000000000000 x16: 0000000000000000 x15: ffff00006aa76c3c
> x14: 1ffff00003deedd8 x13: 0000000000000013 x12: ffff7f800002e7e7
> x11: 1fffff800002e7e6 x10: ffff7f800002e7e6 x9 : 0000000000000000
> x8 : ffff600000b9fa00 x7 : 0000000000000000 x6 : 000000000000003f
> x5 : 0000000000000040 x4 : 1ffff00003067da0 x3 : 1fffe0000204d9d9
> x2 : 0000000000000004 x1 : 0000000000000040 x0 : ffff000005cfc8c0
> Call trace:
>  clear_page+0x14/0x28 arch/arm64/lib/clear_page.S:21
>  kernel_init_free_pages mm/page_alloc.c:1283 [inline]
>  post_alloc_hook+0x1ac/0x25c mm/page_alloc.c:2426
>  prep_new_page mm/page_alloc.c:2436 [inline]
>  get_page_from_freelist+0x184c/0x2320 mm/page_alloc.c:4168
>  __alloc_pages+0x1a8/0x21d0 mm/page_alloc.c:5390
>  alloc_pages+0x23c/0x3b0 mm/mempolicy.c:2291
>  __page_cache_alloc mm/filemap.c:1022 [inline]
>  pagecache_get_page+0x4ac/0x930 mm/filemap.c:1940
>  find_or_create_page include/linux/pagemap.h:420 [inline]
>  grow_dev_page fs/buffer.c:949 [inline]
>  grow_buffers fs/buffer.c:1014 [inline]
>  __getblk_slow+0x178/0x6bc fs/buffer.c:1041
>  __getblk_gfp+0x7c/0xa0 fs/buffer.c:1334
>  __getblk include/linux/buffer_head.h:382 [inline]
>  jbd2_journal_get_descriptor_buffer+0xf0/0x3f0 fs/jbd2/journal.c:1014
>  journal_submit_commit_record.part.0+0x88/0x7fc fs/jbd2/commit.c:131
>  journal_submit_commit_record fs/jbd2/commit.c:128 [inline]
>  jbd2_journal_commit_transaction+0x2ad4/0x4270 fs/jbd2/commit.c:925
>  kjournald2+0x190/0x734 fs/jbd2/journal.c:213
>  kthread+0x334/0x3dc kernel/kthread.c:319
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756

+linux-arm-kernels

This is caused by broken CONFIG_CMDLINE support on arm64, for context see:
https://lore.kernel.org/lkml/CACT4Y+a4S-oXsjgwDh3SmERqKFF1QbapvX6NiSpn51KRtqvTiQ@mail.gmail.com/

syzbot should use 150s stall timeout, but it got's default 20s which
produces false positive flakes.

#syz dup: BUG: soft lockup in handle_mm_fault (2)

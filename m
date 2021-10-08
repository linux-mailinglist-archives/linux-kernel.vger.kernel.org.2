Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F569426E8E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 18:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhJHQWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 12:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhJHQWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 12:22:52 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BC9C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 09:20:55 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id h2so22142329ybi.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 09:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WbpqBG1YQa7jgZ7Xg/LUvMqcMj/e4xUqlnDR3VFNVxQ=;
        b=UIkASagcUJKOLIsR4xgyAUUqbC8307RLetJG+kurS2qk8UIUG8qxAj/RqBj5x/lUGy
         EBwiBFOu3R0gLdWerUPc00zraXwvnv1/pR/2pgXvs/A7yjJ1y/qDMdxE06yqNlFYnf0d
         5hL8CAd/Sjc7uj61Ea+CE1w4VxqluoMiz1y3BiCH0Il+yVBHxbjpqHxDMxpI2ItFRepu
         GYgN7gjA3WbkA0WdI1Gd3RP5c59+MuRFfDD1jUl0DLZz/3SX79EcU9ig0mI/x7m5lKe0
         w0NqhcOQIi5KBbHBE/mamGc9dP0Gc75NOpKZAA/KEXly6XyLNeRqW1GRrX2XlwJ1sKz2
         DD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WbpqBG1YQa7jgZ7Xg/LUvMqcMj/e4xUqlnDR3VFNVxQ=;
        b=3qVRVdIaYnA+n8L8I2pJv00/cKR2lfbvs+hwuux0MdZS1fPeiJurNf3zpdv67CNtcA
         ZbJ+H2zuAdKJrAmFxpmBZpVgDdAh25guf2lledtZm7eIW9bRd7h+2HH1Bw2Flq53IPkK
         6QXeTLPH+PVCXhUy35FgXNoUwzpuhw7PU8+4K1YLkpLl5Eexe+vajLhuLN1/1AiJTbYW
         q3KQEUMrkEsgMgcRw3wTHyQYMGN4mRS8WbSmsqVk+5ULlfFW7zE7t29DsDblLxAjFWWO
         5v8YDXbr2J2GOiipyQjDOhNc9lPHuPctvREq5VNy99h8ll9CpZeoZNjt2Pl8vdi3P+N3
         3zcQ==
X-Gm-Message-State: AOAM530njUvYJmsrnwqMF9nJVbnmcF7DWrK5FJ/UU6siMRAbPWwOyaKw
        9dIeo4SkWwoXcFvjIq5o9QHHCVPQ55uYIcQO21NHdA==
X-Google-Smtp-Source: ABdhPJznc865GfL2wZPpFhMF0eUz9hIq2Bz5wGehdboZMEWXlw8O+EI2ITp2goIZnicRuwIRBsS5iolIcrrkyz/QxQ0=
X-Received: by 2002:a25:7415:: with SMTP id p21mr4531647ybc.78.1633710054416;
 Fri, 08 Oct 2021 09:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211001174947.135123-1-eric.dumazet@gmail.com> <CAD-N9QVtBrWrtAFQkyd=zRwnA4AjnBBeqhD_P-QFXz-QtUOzog@mail.gmail.com>
In-Reply-To: <CAD-N9QVtBrWrtAFQkyd=zRwnA4AjnBBeqhD_P-QFXz-QtUOzog@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 8 Oct 2021 09:20:43 -0700
Message-ID: <CANn89iL2qqVNFVUjSOnq52Aw+k5=Hcv1dSO-PSjgGKt0yxB0FQ@mail.gmail.com>
Subject: Re: [PATCH] mm/mempolicy: do not allow illegal MPOL_F_NUMA_BALANCING
 | MPOL_LOCAL in mbind()
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        syzbot <syzkaller@googlegroups.com>,
        "Huang, Ying" <ying.huang@intel.com>, Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 7, 2021 at 10:26 PM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>
> On Sat, Oct 2, 2021 at 1:49 AM Eric Dumazet <eric.dumazet@gmail.com> wrote:
> >
> > From: Eric Dumazet <edumazet@google.com>
> >
> > syzbot reported access to unitialized memory in mbind() [1]
> >
> > Issue came with commit bda420b98505 ("numa balancing: migrate on
> > fault among multiple bound nodes")
> >
> > This commit added a new bit in MPOL_MODE_FLAGS, but only checked
> > valid combination (MPOL_F_NUMA_BALANCING can only be used with MPOL_BIND)
> > in do_set_mempolicy()
> >
> > This patch moves the check in sanitize_mpol_flags() so that it
> > is also used by mbind()
> >
> > [1]
> > BUG: KMSAN: uninit-value in __mpol_equal+0x567/0x590 mm/mempolicy.c:2260
> >  __mpol_equal+0x567/0x590 mm/mempolicy.c:2260
> >  mpol_equal include/linux/mempolicy.h:105 [inline]
> >  vma_merge+0x4a1/0x1e60 mm/mmap.c:1190
> >  mbind_range+0xcc8/0x1e80 mm/mempolicy.c:811
> >  do_mbind+0xf42/0x15f0 mm/mempolicy.c:1333
> >  kernel_mbind mm/mempolicy.c:1483 [inline]
> >  __do_sys_mbind mm/mempolicy.c:1490 [inline]
> >  __se_sys_mbind+0x437/0xb80 mm/mempolicy.c:1486
> >  __x64_sys_mbind+0x19d/0x200 mm/mempolicy.c:1486
> >  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> >  do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> >
> > Uninit was created at:
> >  slab_alloc_node mm/slub.c:3221 [inline]
> >  slab_alloc mm/slub.c:3230 [inline]
> >  kmem_cache_alloc+0x751/0xff0 mm/slub.c:3235
> >  mpol_new mm/mempolicy.c:293 [inline]
> >  do_mbind+0x912/0x15f0 mm/mempolicy.c:1289
> >  kernel_mbind mm/mempolicy.c:1483 [inline]
> >  __do_sys_mbind mm/mempolicy.c:1490 [inline]
> >  __se_sys_mbind+0x437/0xb80 mm/mempolicy.c:1486
> >  __x64_sys_mbind+0x19d/0x200 mm/mempolicy.c:1486
> >  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> >  do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > =====================================================
> > Kernel panic - not syncing: panic_on_kmsan set ...
> > CPU: 0 PID: 15049 Comm: syz-executor.0 Tainted: G    B             5.15.0-rc2-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0x1ff/0x28e lib/dump_stack.c:106
> >  dump_stack+0x25/0x28 lib/dump_stack.c:113
> >  panic+0x44f/0xdeb kernel/panic.c:232
> >  kmsan_report+0x2ee/0x300 mm/kmsan/report.c:186
> >  __msan_warning+0xd7/0x150 mm/kmsan/instrumentation.c:208
> >  __mpol_equal+0x567/0x590 mm/mempolicy.c:2260
> >  mpol_equal include/linux/mempolicy.h:105 [inline]
> >  vma_merge+0x4a1/0x1e60 mm/mmap.c:1190
> >  mbind_range+0xcc8/0x1e80 mm/mempolicy.c:811
> >  do_mbind+0xf42/0x15f0 mm/mempolicy.c:1333
> >  kernel_mbind mm/mempolicy.c:1483 [inline]
> >  __do_sys_mbind mm/mempolicy.c:1490 [inline]
> >  __se_sys_mbind+0x437/0xb80 mm/mempolicy.c:1486
> >  __x64_sys_mbind+0x19d/0x200 mm/mempolicy.c:1486
> >  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> >  do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > RIP: 0033:0x7f4a41b2c709
> > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f4a3f0a3188 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
> > RAX: ffffffffffffffda RBX: 00007f4a41c30f60 RCX: 00007f4a41b2c709
> > RDX: 0000000000002001 RSI: 0000000000c00007 RDI: 0000000020012000
> > RBP: 00007f4a41b86cb4 R08: 0000000000000000 R09: 0000010000000002
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007f4a42164b2f R14: 00007f4a3f0a3300 R15: 0000000000022000
> >
>
> Hi Eric,
>
> this crash seems like the bug report [1] on Syzbot dashboard.
>
> [1] https://syzkaller.appspot.com/bug?id=028833194204bb15c2c43d822b8f7401360d57f5
>
> If yes, maybe you can push a patch testing request.
>

No, it was a different syzbot report, currently held in our queue.

(Andrew Morton has access to our internal bug, I CC him (b/201266830))

I can release it, at the expense of more noise to various mailing
lists, but really the bug is trivial.

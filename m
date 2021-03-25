Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC9B3499F4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 20:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbhCYTHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 15:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhCYTH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:07:29 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0ABC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 12:07:28 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id q12so1732262qvc.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 12:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qae9E1zKJn6LK5b4omUvZSYxmxFxZOk4nKw6EcIS+b8=;
        b=E1QouEL8MZ9bYUcNnI4vEeFCZ3th/q4BbLzX0CF5FbtAcRiSXVaXq8M9rphikU7lzL
         301d3sm2KKvRk2K3c9v6h9/U73xtpqYtWnT9uK0YxmqdCkQsF4e1W83l9RjgI04qEj6i
         +n4BwReoTRLzgzolY0CT8HUpg8wJkf7Y+1v+U/Qv18eCJoEi3Dqc7kJp05z25xd8z7a9
         P9XUq4uy1lxMMbDK+gDWXpATFVCtBTI3dVqxoFByZGq+ewfk1W6Ok5rUWtLvqB3jyn8C
         AOVMmO0tE4W9tp02HBJdV9xYZt64u6NxzeuRjJGxpVl7sjEETE0VwYnEYsWTrGHcobpx
         hp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qae9E1zKJn6LK5b4omUvZSYxmxFxZOk4nKw6EcIS+b8=;
        b=bVa+jmRdgXW40wDv/kPEGcDFo9tVzPvhzlnd2UX92OXrneQ0dOZChaL0Xa8o89FCjr
         vN1fgYXYnz74H5IYjhtJAmm8FzfAQQG0TcS1bxmCAJORQ/HSMnY4FNc7LXq2+AkjRjmR
         3LfaDv77/T2TWgli4T6lb3+XkuMbnNfMg3IsqZ6VHE3btUie5j71hhykVy70Hcu/8I1A
         PQp0Rb97HH0hpoJhrzD2FCHPFQMM0PCMkSzmY5wi9/6hUqrN2IzFtI+1aRQhJmY5jCjj
         MfARqaaILN+Y75cdtwdecHypr6e7v8lN8BnfBg2qF5JDjxqgqHopr8KhTd1QWP1mdS2w
         Z5GA==
X-Gm-Message-State: AOAM530/gZwOTA1bMzMpWdotNNQ/9oeAwVYnSj+FvFbaVpARH4xQSzaL
        3TyZPRz+FxIPyb/MKp9wWZA79qLbhRvilpGk6p4kAg==
X-Google-Smtp-Source: ABdhPJxBkVTeEflQ036PDh3N/5TXozrR6xVegmW2Stcg05vTbImy/ViESo5KxGUwnIpj2wHdkC4yI7GmMrRHK4BMSDY=
X-Received: by 2002:a05:6214:2607:: with SMTP id gu7mr9729906qvb.18.1616699247783;
 Thu, 25 Mar 2021 12:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d7142c05be60db47@google.com>
In-Reply-To: <000000000000d7142c05be60db47@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 25 Mar 2021 20:07:16 +0100
Message-ID: <CACT4Y+aQnxiGOp6Am_MyqZy0TxOnxEJB-SnQRRWgjD1g4n1wjw@mail.gmail.com>
Subject: Re: [syzbot] BUG: soft lockup in get_page_from_freelist
To:     syzbot <syzbot+b6c93d85a3f77fca7f13@syzkaller.appspotmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kernel-team@android.com, Will Deacon <will@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 7:48 PM syzbot
<syzbot+b6c93d85a3f77fca7f13@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    e1381380 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11238fb2d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=460abe93fbc821a4
> dashboard link: https://syzkaller.appspot.com/bug?extid=b6c93d85a3f77fca7f13
> userspace arch: arm
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b6c93d85a3f77fca7f13@syzkaller.appspotmail.com
>
> watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [syz-executor.1:22367]

/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\

This is also due to arm64 removal of CMDLINE support.
syzbot sets watchdog_thresh=165, but this fired after 22s.

#syz dup: BUG: soft lockup in do_wp_page (4)


> Modules linked in:
> irq event stamp: 4562
> hardirqs last  enabled at (4561): [<ffff8000143e4dd8>] exit_to_kernel_mode+0x38/0x230 arch/arm64/kernel/entry-common.c:59
> hardirqs last disabled at (4562): [<ffff8000143e54a0>] enter_el1_irq_or_nmi+0x10/0x20 arch/arm64/kernel/entry-common.c:101
> softirqs last  enabled at (4442): [<ffff8000100109e0>] _stext+0x9e0/0x1084
> softirqs last disabled at (4203): [<ffff80001015a04c>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
> softirqs last disabled at (4203): [<ffff80001015a04c>] invoke_softirq kernel/softirq.c:228 [inline]
> softirqs last disabled at (4203): [<ffff80001015a04c>] __irq_exit_rcu+0x46c/0x510 kernel/softirq.c:422
> CPU: 0 PID: 22367 Comm: syz-executor.1 Not tainted 5.12.0-rc4-syzkaller-00223-ge138138003eb #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 00000005 (nzcv daif -PAN -UAO -TCO BTYPE=--)
> pc : clear_page+0x14/0x28 arch/arm64/lib/clear_page.S:23
> lr : clear_highpage include/linux/highmem.h:203 [inline]
> lr : kernel_init_free_pages+0x74/0x180 mm/page_alloc.c:1212
> sp : ffff0000105e7630
> x29: ffff0000105e7630 x28: fffffc0000180f00
> x27: ffff00007fc13ec0 x26: ffff00000a7be378
> x25: ffff6000014f7c6f x24: 00000000000014b8
> x23: ffff00000a7bcec0 x22: fffffc0000180f40
> x21: ffff8000154f3398 x20: dfff800000000000
> x19: fffffc0000180f00 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000
> x15: 0000000000000000 x14: 1fffe000020bce90
> x13: 0000000000000001 x12: ffff7f80000301e7
> x11: 1fffff80000301e6 x10: ffff7f80000301e6
> x9 : 0000000000000000 x8 : ffff600000c07a00
> x7 : 0000000000000000 x6 : 000000000000003f
> x5 : 0000000000000040 x4 : 1ffff00002fa7950
> x3 : 1fffe000014f79d9 x2 : 0000000000000004
> x1 : 0000000000000040 x0 : ffff00000603cf40
> Call trace:
>  clear_page+0x14/0x28 arch/arm64/lib/clear_page.S:21
>  post_alloc_hook+0x130/0x1fc mm/page_alloc.c:2305
>  prep_new_page mm/page_alloc.c:2311 [inline]
>  get_page_from_freelist+0x2024/0x2a40 mm/page_alloc.c:3951
>  __alloc_pages_nodemask+0x2a0/0x24dc mm/page_alloc.c:5001
>  alloc_pages_vma+0xb4/0x510 mm/mempolicy.c:2240
>  alloc_zeroed_user_highpage_movable include/linux/highmem.h:197 [inline]
>  do_anonymous_page mm/memory.c:3548 [inline]
>  handle_pte_fault mm/memory.c:4316 [inline]
>  __handle_mm_fault+0xc88/0x21d4 mm/memory.c:4453
>  handle_mm_fault+0x1cc/0x4dc mm/memory.c:4551
>  __do_page_fault arch/arm64/mm/fault.c:507 [inline]
>  do_page_fault+0x228/0x880 arch/arm64/mm/fault.c:591
>  do_translation_fault+0x1a4/0x210 arch/arm64/mm/fault.c:672
>  do_mem_abort+0x64/0x1c0 arch/arm64/mm/fault.c:805
>  el0_da+0x3c/0x50 arch/arm64/kernel/entry-common.c:308
>  el0_sync_compat_handler+0x114/0x140 arch/arm64/kernel/entry-common.c:506
>  el0_sync_compat+0x174/0x180 arch/arm64/kernel/entry.S:708
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000d7142c05be60db47%40google.com.

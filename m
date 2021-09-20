Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17D9411065
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 09:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbhITHo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 03:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbhITHo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 03:44:26 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC70C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 00:43:00 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id n78so10330546oig.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 00:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=49jVXnghB6poIDSvM4LgKCb9bcAvYA/ir6Ru3tRkU/8=;
        b=fK2ik8Zisaqc+Z856BI2UOSShF5hzyv/VJz+1sK982FVD55sBfOWRXC6n2q37lYi7B
         8rPL9WQn7h2AashaaxxCK+HzikrDy/v3+XJkJTNo3mw52KeKvy0dUWUtTGIV7cihSZQe
         1ulSLHdXj1a2e6eHX3o4oxA1im/5DZju7GIUUGdbcvIddRMeQUyNMtRi2YxWCl/5SVEH
         IdMJtuTzz1SDaEu/ZxcgR4oEHzpbKuJqH89i1yQRdWezIO95pipirW93FcYBI/m+Ie/p
         lAk/zyJ5n2TAZbhErlkkE+4ckQeUDOjZz/KIUuArADemcX0/KC82OEmUlEahi9+Ert74
         fIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=49jVXnghB6poIDSvM4LgKCb9bcAvYA/ir6Ru3tRkU/8=;
        b=0oBukGZuvSiOK/s0qBsEjTFpT2dcaRDSsZhFQ78cmV2Yrl+3qlvbIsJchrEErPD3Bb
         64T6QqblUPOWjwGn6IPUBMtdPM1XTv/QSODvTfvxGhVBvcN7QiuLNJ1AeLABjIqj5IVF
         z+QVeJ+LGA6PDGXF7SRotejLqaC9Fu6CbA7399wVYAQsagZws9pyhkahVVk51xiw6wB2
         hpNBsVT74xCjGHGUqcTUcdBY2mT8qdUzSC/WgrBbZKIlXY+niFIb6qpBlcktT09SRgv6
         PHCRnaAqu9SMQ51ZMW0XjbLRq+k+rs27rSNhtKmnzwVkPxhd0gDe8GJbUUbM9Z9aoTWS
         5aqw==
X-Gm-Message-State: AOAM5322TEA5CuOFU6kD/ZBUb8FCLUbqty50IMF14u7/BE/JuQOPgkyC
        xZBcY1me0iz5LXqOwdLg2swxRZD24fxN9b5JMcJC3ckZ2xs=
X-Google-Smtp-Source: ABdhPJx/OxO/zcoKfTxTeh9Zg6lY+fddmYbXlrVzs+a0ThwElWA9OrFLs5x6CdzZqU1oCcYROchxu05dfuzCJ4mZpxI=
X-Received: by 2002:aca:3083:: with SMTP id w125mr3109358oiw.109.1632123779609;
 Mon, 20 Sep 2021 00:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000020104105cc685624@google.com>
In-Reply-To: <00000000000020104105cc685624@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 20 Sep 2021 09:42:48 +0200
Message-ID: <CACT4Y+b+KKtY=Ok3Ha0-i2JO6v6Mpe9fE6HXM+qagf_b12wENQ@mail.gmail.com>
Subject: Re: [syzbot] kernel BUG in __free_one_page
To:     syzbot <syzbot+afe1d3c5ccb5940c372a@syzkaller.appspotmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sept 2021 at 09:36, syzbot
<syzbot+afe1d3c5ccb5940c372a@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    d4d016caa4b8 alpha: move __udiv_qrnnd library function to ..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1564ae79300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6d93fe4341f98704
> dashboard link: https://syzkaller.appspot.com/bug?extid=afe1d3c5ccb5940c372a
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+afe1d3c5ccb5940c372a@syzkaller.appspotmail.com

Looking at the page description printed before the BUG in the console
output, I think the root cause is in +io_uring.

>  io_mem_free.part.0+0xf7/0x140 fs/io_uring.c:8708
>  io_mem_free fs/io_uring.c:8703 [inline]
>  io_ring_ctx_free fs/io_uring.c:9250 [inline]
>  io_ring_exit_work+0xf20/0x1980 fs/io_uring.c:9408
>  process_one_work+0x9bf/0x16b0 kernel/workqueue.c:2297
>  worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
>  kthread+0x3e5/0x4d0 kernel/kthread.c:319
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> ------------[ cut here ]------------
> kernel BUG at mm/page_alloc.c:1073!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.15.0-rc1-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: mm_percpu_wq vmstat_update
> RIP: 0010:__free_one_page+0xa10/0xe30 mm/page_alloc.c:1073
> Code: 43 34 85 c0 0f 84 79 f9 ff ff 48 c7 c6 80 1b 97 89 48 89 ef e8 61 dd f6 ff 0f 0b 48 c7 c6 60 1a 97 89 4c 89 ef e8 50 dd f6 ff <0f> 0b 0f 0b 48 c7 c6 c0 1a 97 89 4c 89 ef e8 3d dd f6 ff 0f 0b 48
> RSP: 0018:ffffc90000ca7968 EFLAGS: 00010093
> RAX: 0000000000000000 RBX: ffffc90000ca7a60 RCX: 0000000000000000
> RDX: ffff888010e40000 RSI: ffffffff81b2f6b0 RDI: 0000000000000003
> RBP: 0000000000152200 R08: 0000000000000018 R09: 00000000ffffffff
> R10: ffffffff88f44b19 R11: 00000000ffffffff R12: 0000000000000009
> R13: ffffea0005488000 R14: 0000000000000000 R15: ffff88823fff8e00
> FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000000 CR3: 0000000036db1000 CR4: 00000000001526f0
> Call Trace:
>  free_pcppages_bulk+0x533/0x8a0 mm/page_alloc.c:1537
>  drain_zone_pages+0x173/0x440 mm/page_alloc.c:3079
>  refresh_cpu_vm_stats+0x355/0x5d0 mm/vmstat.c:874
>  vmstat_update+0xe/0xa0 mm/vmstat.c:1910
>  process_one_work+0x9bf/0x16b0 kernel/workqueue.c:2297
>  worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
>  kthread+0x3e5/0x4d0 kernel/kthread.c:319
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> Modules linked in:
> ---[ end trace e038b7c668ec2f59 ]---
> RIP: 0010:__free_one_page+0xa10/0xe30 mm/page_alloc.c:1073
> Code: 43 34 85 c0 0f 84 79 f9 ff ff 48 c7 c6 80 1b 97 89 48 89 ef e8 61 dd f6 ff 0f 0b 48 c7 c6 60 1a 97 89 4c 89 ef e8 50 dd f6 ff <0f> 0b 0f 0b 48 c7 c6 c0 1a 97 89 4c 89 ef e8 3d dd f6 ff 0f 0b 48
> RSP: 0018:ffffc90000ca7968 EFLAGS: 00010093
> RAX: 0000000000000000 RBX: ffffc90000ca7a60 RCX: 0000000000000000
> RDX: ffff888010e40000 RSI: ffffffff81b2f6b0 RDI: 0000000000000003
> RBP: 0000000000152200 R08: 0000000000000018 R09: 00000000ffffffff
> R10: ffffffff88f44b19 R11: 00000000ffffffff R12: 0000000000000009
> R13: ffffea0005488000 R14: 0000000000000000 R15: ffff88823fff8e00
> FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000000 CR3: 0000000036db1000 CR4: 00000000001526f0
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000020104105cc685624%40google.com.

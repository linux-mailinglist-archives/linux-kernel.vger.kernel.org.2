Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F1242AB53
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 19:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhJLR6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 13:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbhJLR6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 13:58:02 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B86C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 10:56:00 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g8so2629378edt.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 10:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=soBzo+qbALf37mSRAz8nmH9lQXp3XIT1ObUNt0qkGj0=;
        b=hsP4DmTGF3eAqU7bNHruL62nilE9S5zruKtdwfxzdWmwWMd7RaETqY+rY/mKRbl9Da
         V5a2yUMkbEhqaAdQ13ZyHgnAdrbgLpmT/UpVE7o/RyJa+9MVNOWebEbFUwzBHqsYorNt
         ChT4f396/OBMkZ5LC6mLfN16v+J9kwqiJZIt9nLufEPwgxZREUELX4snhCLondSFFMWU
         pPWLC490tDJI2PaA93aPEOywPaSkAE+YTPIzD/qUhMYRi+E8foUVMDwlMv5Ik9Aoi4k8
         eFYcM/g7spIA1jjjX0TlJo1FgwytwfB9kH9IDmPuT1Ogu7SZQA3QVjsH3OenNlhAF77i
         Z0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=soBzo+qbALf37mSRAz8nmH9lQXp3XIT1ObUNt0qkGj0=;
        b=bWEACCUisZ/zkunyqmcPK/DXKl1M9MBaDhNZ0lowcyRSsYuoDRFRK3YfXq9XMf6GXy
         LZxYT8m1FSAzvgClIDBDJqqSYK6PbfL6ckWJDj5kiZJZUM1W3njcyeslsPWaGM5kZhTy
         5P0FmHlsHqxmvYWUpRa6UHBWF4Mdbdi/yHAmy8x5b0ajBuUDPJH+2hdgGylB5W0MWdwO
         InSHYU69VKKtu5P0Y2s/PqPre06PHpfFu0oUzcCA2OyzEMpB0a/TE99XyWcf89iIPeE6
         9jjAEO4Fi0ySI05UaG2iNT/H30YApnDyLRyQxwRPEDlgD+m52Q/sARBKn7LnQGcqnK3H
         /QSA==
X-Gm-Message-State: AOAM530PkfBshm87vEG3OYGHnZLE4y0fpYq/Iga5b/nmxIXheRUPirFB
        vGKkteBKEtNqytRlso9i8WSBwzPvhFcqQn0u7qY=
X-Google-Smtp-Source: ABdhPJzqqdCdy3PLxYA0+ffbkkFCnRh9E8V3xG+QVrjXZWe+XLIXJAGAO4KXVstkq4dDF3UcdIuQh2Ozoim+W/SLiXE=
X-Received: by 2002:a17:906:c7d0:: with SMTP id dc16mr34668619ejb.555.1634061357851;
 Tue, 12 Oct 2021 10:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c6a82505ce284e4c@google.com>
In-Reply-To: <000000000000c6a82505ce284e4c@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 12 Oct 2021 10:55:45 -0700
Message-ID: <CAHbLzkoFaowaG8AU6tg_WMPdjcAdyE+Wafs7TJz1Z23TRg_d8A@mail.gmail.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in copy_huge_page
To:     syzbot <syzbot+aae069be1de40fb11825@syzkaller.appspotmail.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 7:03 AM syzbot
<syzbot+aae069be1de40fb11825@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    1da38549dd64 Merge tag 'nfsd-5.15-3' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14379148b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=76f7496a8217e5ec
> dashboard link: https://syzkaller.appspot.com/bug?extid=aae069be1de40fb11825
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+aae069be1de40fb11825@syzkaller.appspotmail.com
>
> BUG: sleeping function called from invalid context at mm/util.c:758
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 30700, name: syz-executor.2
> 2 locks held by syz-executor.2/30700:
>  #0: ffff88806ee498a8 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_write_lock include/linux/mmap_lock.h:71 [inline]
>  #0: ffff88806ee498a8 (&mm->mmap_lock#2){++++}-{3:3}, at: do_mbind+0x25d/0xeb0 mm/mempolicy.c:1314
>  #1: ffff888145989e18 (&mapping->private_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:363 [inline]
>  #1: ffff888145989e18 (&mapping->private_lock){+.+.}-{2:2}, at: __buffer_migrate_page+0x3af/0xca0 mm/migrate.c:723
> Preemption disabled at:
> [<0000000000000000>] 0x0
> CPU: 1 PID: 30700 Comm: syz-executor.2 Not tainted 5.15.0-rc4-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  ___might_sleep.cold+0x1f3/0x239 kernel/sched/core.c:9538
>  copy_huge_page+0x126/0x360 mm/util.c:758
>  migrate_page_copy+0xfc/0x340 mm/migrate.c:619
>  __buffer_migrate_page+0x8cb/0xca0 mm/migrate.c:758

It seems like this one has the similar root cause with
https://lore.kernel.org/lkml/CACkBjsYwLYLRmX8GpsDpMthagWOjWWrNxqY6ZLNQVr6yx+f5vA@mail.gmail.com/.
The THP is collapsed for page cache from raw block device. Then the
THP got migrated by calling buffer_migrate_page_norefs() in this BUG
report, which takes mapping->private_lock and is used by raw block
device.

So skipping the non-regular file in khugepaged
(https://lore.kernel.org/linux-mm/a07564a3-b2fc-9ffe-3ace-3f276075ea5c@google.com/)
seems like a proper fix.

>  move_to_new_page+0x339/0xef0 mm/migrate.c:905
>  __unmap_and_move mm/migrate.c:1070 [inline]
>  unmap_and_move mm/migrate.c:1211 [inline]
>  migrate_pages+0xfc5/0x39e0 mm/migrate.c:1488
>  do_mbind+0xbc7/0xeb0 mm/mempolicy.c:1340
>  kernel_mbind mm/mempolicy.c:1483 [inline]
>  __do_sys_mbind mm/mempolicy.c:1490 [inline]
>  __se_sys_mbind mm/mempolicy.c:1486 [inline]
>  __x64_sys_mbind+0x233/0x2b0 mm/mempolicy.c:1486
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f408623f8d9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f40837b6188 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
> RAX: ffffffffffffffda RBX: 00007f4086343f60 RCX: 00007f408623f8d9
> RDX: 0000000000000000 RSI: 0000000000c00000 RDI: 0000000020012000
> RBP: 00007f4086299cb4 R08: 0000000000000000 R09: 0000010000000002
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fff13d3589f R14: 00007f40837b6300 R15: 0000000000022000
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

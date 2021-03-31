Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6088D34F88F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 08:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbhCaGMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 02:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbhCaGLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 02:11:51 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4A1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 23:11:50 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id g15so18338634qkl.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 23:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6INTPgWlEnrhVd4h4tKDStyM3fx+lc1+I1kuctBwQZo=;
        b=QahTuf8WRm0Wvssb8vr/kC/McyQ4tMsEK5dmMufr2MVfy8e5MWOtFQt1MF/0Z2U7RS
         +pQNjm+I7tuEbhSRUamIpPkV//Wc1zJbxDkSWyEamtWRadARD0firNy1QbWavWNf+vyk
         p7qzYXEWXb8HS/Ss0aRzNxkcg9+AyDAT7Cue2OikUlhlm5idKyu+stWUSgtcUeAlNTQq
         UR8n4dfceW2fHTtwctZmPb691mRrSijXFrQmQPTo7YzJfiLuiEfwwNjAds31uP6ZUgBR
         rjY5RWwz0LaT4JweRcAVzTFDOklkBymiD7OFGJ1JvBaFfPIHcGsbvVwLlXHhD60fXKKj
         YExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6INTPgWlEnrhVd4h4tKDStyM3fx+lc1+I1kuctBwQZo=;
        b=b9kLQsP3vQEgpGbwZ+y4IkqJpaWFeu9gWmeXYTXS82ZWD9iFUU/15BIyW0vuxD/WTM
         2tmOL3xY5hpu2rMZpaY1wNS0RJjEJei+qqvU5XNyimednY9TY6tHtbflcPwiu2qQpfRH
         YpcT2j45z2RL+0H28M6N+ApZ+t0iFu1xKpbzKL7CMnKVY4YyId1iryWtdsgQYyAfGLRy
         dOwHTZxZ+wu3I9ePH9+Q7wbly2v3MbN2BTMZ/ABfAFSdTq31yhE5PdZJ0T/NGq2IlYg/
         cfJYW3kATNrWGhewZdLi5tt9PjB6+5EaF0szqgZfZd2sOmWxoj+NxVcnPjdzzzg/6iOf
         EfKA==
X-Gm-Message-State: AOAM533252j7J1jSmI+/hav8iOp1ayGVwsLVCBWnKPeZU3aGQVpl+NBN
        pJf6Vz0GQ1IaZX0+17XZHbLRY99mzoL1NBTmE2v6ug==
X-Google-Smtp-Source: ABdhPJy+A+HN+IKs7ksdevFpMagRXsh9kCCdfs1oYOtKhGE92I41ncRF6wCjDqveP5wTGfdJIU+ATYhriuss4M6tWTY=
X-Received: by 2002:a05:620a:2095:: with SMTP id e21mr1657175qka.265.1617171109670;
 Tue, 30 Mar 2021 23:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000086695705bec87c9f@google.com>
In-Reply-To: <00000000000086695705bec87c9f@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 31 Mar 2021 08:11:38 +0200
Message-ID: <CACT4Y+YuKj_f8dy3UShSmzj4=D_3CgndbgDY6kcFbhb-EYw=dw@mail.gmail.com>
Subject: Re: [syzbot] WARNING: suspicious RCU usage in copy_page_range
To:     syzbot <syzbot+1a33233ccd8201ec2322@syzkaller.appspotmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        LKML <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 12:26 AM syzbot
<syzbot+1a33233ccd8201ec2322@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    db24726b Merge tag 'integrity-v5.12-fix' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16c16b7cd00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=daeff30c2474a60f
> dashboard link: https://syzkaller.appspot.com/bug?extid=1a33233ccd8201ec2322
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1a33233ccd8201ec2322@syzkaller.appspotmail.com

I think this is a LOCKDEP issue. +LOCKDEP maintainers.

Another bug happened on another thread ("WARNING: possible circular
locking dependency detected"). Lockdep disabled lock tracking
("debug_locks = 0" in the report), which probably made it miss
rcu_unlock somewhere, but it did not turn off reporting yet and
produced the false positive first.

I think if LOCKDEP disables lock tracking, it must also disable
reporting of issues that require lock tracking. That would avoid false
positives.

Some LOCKDEP-detectable bug that happens very frequently was added
recently, and syzbot got a dozen of such assorted one-off false
positive reports from LOCKDEP.
Or has something changed in LOCKDEP recently so it started producing
such false positives?

Excerpt from console output:

[  312.003258][ T8401] =============================
[  312.003263][ T8401] WARNING: suspicious RCU usage
[  312.003268][ T8401] 5.12.0-rc4-syzkaller #0 Not tainted
[  312.005611][T16839] ======================================================
[  312.005617][T16839] WARNING: possible circular locking dependency detected
[  312.005623][T16839] 5.12.0-rc4-syzkaller #0 Not tainted
[  312.005631][T16839] ------------------------------------------------------




> =============================
> WARNING: suspicious RCU usage
> 5.12.0-rc4-syzkaller #0 Not tainted
> -----------------------------
> kernel/sched/core.c:8294 Illegal context switch in RCU-bh read-side critical section!
>
> other info that might help us debug this:
>
>
> rcu_scheduler_active = 2, debug_locks = 0
> 3 locks held by syz-executor.0/8401:
>  #0: ffffffff8c03e5b0 (dup_mmap_sem){++++}-{0:0}, at: dup_mmap kernel/fork.c:479 [inline]
>  #0: ffffffff8c03e5b0 (dup_mmap_sem){++++}-{0:0}, at: dup_mm+0x108/0x1380 kernel/fork.c:1368
>  #1: ffff888018d08858 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
>  #1: ffff888018d08858 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap kernel/fork.c:480 [inline]
>  #1: ffff888018d08858 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mm+0x12e/0x1380 kernel/fork.c:1368
>  #2: ffff88801888c058 (&mm->mmap_lock/1){+.+.}-{3:3}, at: mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
>  #2: ffff88801888c058 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap kernel/fork.c:489 [inline]
>  #2: ffff88801888c058 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mm+0x18a/0x1380 kernel/fork.c:1368
>
> stack backtrace:
> CPU: 0 PID: 8401 Comm: syz-executor.0 Not tainted 5.12.0-rc4-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x141/0x1d7 lib/dump_stack.c:120
>  ___might_sleep+0x229/0x2c0 kernel/sched/core.c:8294
>  copy_pte_range mm/memory.c:1010 [inline]
>  copy_pmd_range mm/memory.c:1064 [inline]
>  copy_pud_range mm/memory.c:1101 [inline]
>  copy_p4d_range mm/memory.c:1125 [inline]
>  copy_page_range+0x1270/0x3fd0 mm/memory.c:1198
>  dup_mmap kernel/fork.c:594 [inline]
>  dup_mm+0x9ed/0x1380 kernel/fork.c:1368
>  copy_mm kernel/fork.c:1424 [inline]
>  copy_process+0x2b99/0x7150 kernel/fork.c:2107
>  kernel_clone+0xe7/0xab0 kernel/fork.c:2500
>  __do_sys_clone+0xc8/0x110 kernel/fork.c:2617
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x464a4b
> Code: ed 0f 85 60 01 00 00 64 4c 8b 0c 25 10 00 00 00 45 31 c0 4d 8d 91 d0 02 00 00 31 d2 31 f6 bf 11 00 20 01 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 89 00 00 00 41 89 c5 85 c0 0f 85 90 00 00
> RSP: 002b:00007ffd44303270 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000464a4b
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
> RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000002e94400
> R10: 0000000002e946d0 R11: 0000000000000246 R12: 0000000000000001
> R13: 0000000000000000 R14: 0000000000000000 R15: 00007ffd44303360
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000086695705bec87c9f%40google.com.

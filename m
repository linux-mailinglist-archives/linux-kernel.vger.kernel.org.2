Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDB735E604
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 20:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347520AbhDMSLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 14:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhDMSLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 14:11:33 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269E0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 11:11:13 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id ef17so2873179qvb.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 11:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EbjN2qgyylIxptriBP8xjTcrzsIUK7NPVHheYkzWTx0=;
        b=SFNBkVAI8DgbvH8Q8/yBgc6VSKWr6iYyV9eWCOLzMMKWSAa4VeCylORFe3v+FRs7Tf
         sw5e1oDUIrBKKy25tfxXUQ29vC6mhaMygokMsOn2JA1gKLSiseAbhYrpOyfFz/yydKfw
         /yPh8RoN4qh7B7EE04p09qdj5WES57g/XI4kszQR053Mhr3+CySNRkxPMOkWGHfZLa3x
         xeA/iVH0LF8vXOdzGdBvyZukrhnQvJaYnI5gk8y9xzQ4m62fo+PoB+7XiriAfInAeh9+
         kbaPROT0k6V1BvZvj3UH+I6ZzkoSgpkbpBLUlCVZ1wycGqYMtpPFnBciJEd6y+lhsqcP
         zydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EbjN2qgyylIxptriBP8xjTcrzsIUK7NPVHheYkzWTx0=;
        b=TIekL7vjR8XAPT7teu8IFTrfjZXYQZOEli5WEkRawa8kelAhM5tFxXtzmzoRtMy066
         kThJnOgGy7t7WbMC2uT3oUn1by89juF6e4AXKlqM9dK2M5LV/V9EJdsXVgmGmkjc1iFp
         FYM7E/2OJxi2o1tGInBl92qcNHNUJSggEiY++Y/vfxRs1oNPh2nIDFYtW7RB+FPZw41T
         Jvc/WO+Ab9MTJZbk77nupyYO36+DsNYCjCsNHN/z9+nGY9r1b5CAcdtDrwPXWiE/wfiW
         6CpFBsJO5rMy8zpJy791SbznIXCv0QXN0Uh2JjhxiQbgv/6TBha36fQ6rqOHGoiGhvq5
         KczA==
X-Gm-Message-State: AOAM531DJbbofEKMf74mA6ZoQqm18VBGFs1+dbYwEKa61hGjmbgWr467
        FcpLNX2+91a8+uhd0FLQlS4uyz7QCXnLb5mxN5Qchw==
X-Google-Smtp-Source: ABdhPJzBOLNJhkmbLNEil9eaU/PAi+m6VZdIIi+X0unvqFCGELJcwps6owjf+CXap57oql6GSNQsZljO+A0vYx5WCrE=
X-Received: by 2002:a05:6214:3eb:: with SMTP id cf11mr2207324qvb.37.1618337472075;
 Tue, 13 Apr 2021 11:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000002bb2bd05bf3310db@google.com>
In-Reply-To: <0000000000002bb2bd05bf3310db@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 13 Apr 2021 20:11:00 +0200
Message-ID: <CACT4Y+Y+duc4e5NitrFkZUGXboL_tU40nGuxPqTi1Kd5z4+j+A@mail.gmail.com>
Subject: Re: [syzbot] WARNING: suspicious RCU usage in do_user_addr_fault
To:     syzbot <syzbot+3d5082ab6eec95ad4231@syzkaller.appspotmail.com>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Benjamin Segall <bsegall@google.com>, dietmar.eggemann@arm.com,
        Juri Lelli <juri.lelli@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 5, 2021 at 7:35 AM syzbot
<syzbot+3d5082ab6eec95ad4231@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    d19cc4bf Merge tag 'trace-v5.12-rc5' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17a22d16d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=78ef1d159159890
> dashboard link: https://syzkaller.appspot.com/bug?extid=3d5082ab6eec95ad4231
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3d5082ab6eec95ad4231@syzkaller.appspotmail.com

#syz dup: WARNING: suspicious RCU usage in getname_flags

> WARNING: suspicious RCU usage
> 5.12.0-rc5-syzkaller #0 Not tainted
> -----------------------------
> kernel/sched/core.c:8294 Illegal context switch in RCU-bh read-side critical section!
>
> other info that might help us debug this:
>
>
> rcu_scheduler_active = 2, debug_locks = 0
> 1 lock held by syz-executor.5/8582:
>  #0: ffff888029093218 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:136 [inline]
>  #0: ffff888029093218 (&mm->mmap_lock#2){++++}-{3:3}, at: do_user_addr_fault+0x285/0x1210 arch/x86/mm/fault.c:1331
>
> stack backtrace:
> CPU: 0 PID: 8582 Comm: syz-executor.5 Not tainted 5.12.0-rc5-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x141/0x1d7 lib/dump_stack.c:120
>  ___might_sleep+0x229/0x2c0 kernel/sched/core.c:8294
>  do_user_addr_fault+0x2c2/0x1210 arch/x86/mm/fault.c:1348
>  handle_page_fault arch/x86/mm/fault.c:1475 [inline]
>  exc_page_fault+0x9e/0x180 arch/x86/mm/fault.c:1531
>  asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:577
> RIP: 0033:0x406f13
> Code: 00 00 e8 a0 a1 ff ff 85 c0 74 4e 8b 54 24 0c 49 8b 37 31 c0 48 8d 3d 79 7f 0b 00 e8 27 c3 ff ff 8b 44 24 6c 49 8d 4f 60 89 de <4d> 89 a7 b8 00 00 00 ba 40 00 00 00 44 89 ef 41 89 87 b4 00 00 00
> RSP: 002b:00007fff2a8e7140 EFLAGS: 00010202
> RAX: 0000000000000005 RBX: 0000000000000000 RCX: 0000000000544420
> RDX: 0000000000000002 RSI: 0000000000000000 RDI: 00000000004bee7d
> RBP: 00007fff2a8e7160 R08: 00007fff2a8e715c R09: 00007fff2a8e71f0
> R10: 00007fff2a8e71c0 R11: 0000000000000202 R12: 00007fff2a8e71c0
> R13: 0000000000000003 R14: 00007fff2a8e715c R15: 00000000005443c0
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000002bb2bd05bf3310db%40google.com.

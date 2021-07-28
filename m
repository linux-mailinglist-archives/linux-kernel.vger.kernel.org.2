Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFDD3D89E1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 10:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbhG1Ih6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 04:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbhG1Ih5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 04:37:57 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE80C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 01:37:56 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id h27so800352qtu.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 01:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ntjsgpYj676ip5nA9sO8ajckACLH/fcEpxbzMHArEw4=;
        b=sBj05RFxGXF2zQPF4lg2FRMGTcPE9Aidhtc7L3I0rz9vk8f0dP2eB9gV+ufyUI7IQy
         j1MWtm9lARMmgakoRnsVyrTxwVoUsKKEA4MMaUX1UzIgWfV/UJshpYrIJFuEU12Vf77x
         /0eK5x1sHuWg2an+qyyWF0QcbOPbvbadYNECwde7+1Z8I4pKehMJZ7cswUPt7YZWtm/w
         uf6RQcoaTSgFpSRi0J8vvOJ6v/5UAvFipo/fW7CuXNXMgHyG5IugtC4GGSLOoeZIcoog
         flLrUBZoEvzAdslaX/si2vKfU2BYqSoZrVYnUWGsE2cnu4B3QVBU36e6zgo/BamEiYJS
         IODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ntjsgpYj676ip5nA9sO8ajckACLH/fcEpxbzMHArEw4=;
        b=IE8VWsZrAzn9+ETEZvdbPAylYxl3oX5BFQEKth5Q5msvQ2YwRVUZYf4bNA3lq6AB66
         m2cCwUeraBhbP4YiRyZe1zohi4HQ6BDTAA87IFCs432TWHVtLKgCQGzhlTOVtSSOskjq
         MlQGJp4f0Xd4NYfpa9jYhqlHmB5toXXfnXwY7S/ozcX3owQQlAkK2et3AOg+ttfN/sPv
         iZR7FG2jW6Rx3hNCx/w25AloZ6htN1dR/lrfDl4BjKFqMQgesMcDDBaXBlqcLL26Yj0J
         7ZhL+wP9wUqQTy8vqIJvCjceBQZ5eDXFYnOHNw8FpV3xX6IvxQJr9mPZAohzF9YuFc9x
         ePOw==
X-Gm-Message-State: AOAM533j/lmV+7ftW8J9pZBEq9C5Rq7Gqq3aaNN4qV2aWG1uhsYHstNd
        9IQfxQ57IRzOVKxrNjq0gsyBJ80hukRaxDZMj6FRyA==
X-Google-Smtp-Source: ABdhPJx7CWGL5egLB84A5y7BVDRFzz7JZ6FJIUQXsAffa67YArW7r8XevseThv2HZZXYqX7kCZsRmHa5ckQaXPPgfe8=
X-Received: by 2002:ac8:4d0b:: with SMTP id w11mr23455617qtv.66.1627461475427;
 Wed, 28 Jul 2021 01:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000001e294505c72eec63@google.com> <2613cb2-2a80-2077-c16e-9618dcb69c9f@google.com>
In-Reply-To: <2613cb2-2a80-2077-c16e-9618dcb69c9f@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 28 Jul 2021 10:37:44 +0200
Message-ID: <CACT4Y+apS=TXOSNkTaVXxARNDmOZ_R-ntvV8t-tXMk1ggGGspg@mail.gmail.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in munlock_vma_pages_range
To:     syzbot <syzbot+2e3ee45ea14cd0b81f26@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jul 2021 at 23:25, 'Hugh Dickins' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On Thu, 15 Jul 2021, syzbot wrote:
>
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    98f7fdced2e0 Merge tag 'irq-urgent-2021-07-11' of git://gi..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13576e9c300000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=da2203b984f4af9f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=2e3ee45ea14cd0b81f26
> > compiler:       Debian clang version 11.0.1-2
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+2e3ee45ea14cd0b81f26@syzkaller.appspotmail.com
> >
> > BUG: sleeping function called from invalid context at mm/mlock.c:482
>
> Fixed by
> 023e1a8dd502 ("mm/rmap: fix new bug: premature return from page_mlock_one()")
> which went into the tree soon after the HEAD shown above
> (but was posted before any syzbot report, so contained no syzbot tag).

#syz fix: mm/rmap: fix new bug: premature return from page_mlock_one()


> > in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 14373, name: syz-executor.5
> > INFO: lockdep is turned off.
> > Preemption disabled at:
> > [<0000000000000000>] 0x0
> > CPU: 1 PID: 14373 Comm: syz-executor.5 Tainted: G        W         5.13.0-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0x1d3/0x29f lib/dump_stack.c:105
> >  ___might_sleep+0x4e5/0x6b0 kernel/sched/core.c:9154
> >  munlock_vma_pages_range+0xa80/0xf60 mm/mlock.c:482
> >  mlock_fixup+0x40f/0x580 mm/mlock.c:552
> >  apply_mlockall_flags mm/mlock.c:768 [inline]
> >  __do_sys_munlockall+0x1ef/0x310 mm/mlock.c:810
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > RIP: 0033:0x4665d9
> > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f448bc37188 EFLAGS: 00000246 ORIG_RAX: 0000000000000098
> > RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665d9
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: 00000000004bfcb9 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
> > R13: 00007ffe7eb2d2ef R14: 00007f448bc37300 R15: 0000000000022000
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/2613cb2-2a80-2077-c16e-9618dcb69c9f%40google.com.

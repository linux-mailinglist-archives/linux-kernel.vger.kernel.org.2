Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D9A3390E8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbhCLPMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbhCLPMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:12:31 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5997C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:12:29 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id c6so3945775qtc.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DyVA826gppINawo6JgubiSmdPww/CYUYD3ZLTreGL7w=;
        b=tFIPJ65LRLgMpSVeSNRpM8lnfe4GIOvvKUmAS2ffAt4BqlpwZzmsUJp8II5/zBMwis
         cOPn6EbxtDmAJ+nF+0rYGQM0vB54z6nphsAeGTIwmou/7bS5LxrA5JOCKDWibqTGnrF+
         +mnudZ5uLnoWP2U+klQHtE/ryW6mL+VSbSrEOoh5ojpJz8NGr6Eb6C2CJApFNKS10m4B
         qjPzjIur3t13eWO4cAZD8xNreEa0zHkKeKIY6jX9JzNxlvsh2yDV12rYBcVZu/QkavsK
         S+uArISOesJRuK945yajvP+42q31ll6jvo/fXOL8Zv5yra8KTUyS6bV7dPjv+lj/AByk
         LAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DyVA826gppINawo6JgubiSmdPww/CYUYD3ZLTreGL7w=;
        b=igrXLDsIfbJIuOqXNou2fXPw8TdkFABqimRPQ3H7wmjySkvhkZ/nEO2+ArudHO9VSU
         zg+1UluEHoQV7nPBt+MwaPtWcghRq0XqNSsieHMqt6KTHsI/50ovfEJnHMH7qNRkwdOP
         qvzFC+9JYpwZNfuHSOk3a0YVuFoR1rQP+tdVV+uuuYvijaWu0BjMVQZRrkNG7NQzxKpm
         AVz1GkBkth8AA3QPg6pzFL5RqPhlkv8PT0d5zMBItbXYY2yEj2EhIueE8Z/kYL6OV0TX
         LwVOroQlo+d8M3k2JprKwgOsT5fWWxXG1lurkjh9+X/XuMpHYzTE0U/Q12PrM4vEynbd
         TZyw==
X-Gm-Message-State: AOAM531k3x2ARdRzH9tynJSQcR5ADDPeOqPXOcQ2QJaKHkmYF7FfDnQv
        jIjd99yBh42i1AYWWy78g08dzucF+4IgB5/urkAeJQ==
X-Google-Smtp-Source: ABdhPJwQnq4SHt4jNFkKya1RPA8rCmYvSKLKR6cbeKiCaLk98KpYapZE6HW4dXSQU0ZB86atJ10H2EVRBgfv4aMmhak=
X-Received: by 2002:ac8:4558:: with SMTP id z24mr1159749qtn.66.1615561948503;
 Fri, 12 Mar 2021 07:12:28 -0800 (PST)
MIME-Version: 1.0
References: <000000000000b74f1b05bd316729@google.com> <CACT4Y+ZHMYijYAkeLMX=p9jx6pBivJz06h_1rGt-k9=AgfkWQg@mail.gmail.com>
 <84b0471d-42c1-175f-ae1d-a18c310c7f77@codethink.co.uk>
In-Reply-To: <84b0471d-42c1-175f-ae1d-a18c310c7f77@codethink.co.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 12 Mar 2021 16:12:16 +0100
Message-ID: <CACT4Y+ZsSRdQ5LzYMsgjrBAukgP-Vv8WSQsSoxguYjWvB1QnrA@mail.gmail.com>
Subject: Re: [syzbot] BUG: unable to handle kernel access to user memory in schedule_tail
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     syzbot <syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
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

On Fri, Mar 12, 2021 at 2:50 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>
> On 10/03/2021 17:16, Dmitry Vyukov wrote:
> > On Wed, Mar 10, 2021 at 5:46 PM syzbot
> > <syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.com> wrote:
> >>
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    0d7588ab riscv: process: Fix no prototype for arch_dup_tas..
> >> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=1212c6e6d00000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=e3c595255fb2d136
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=e74b94fe601ab9552d69
> >> userspace arch: riscv64
> >>
> >> Unfortunately, I don't have any reproducer for this issue yet.
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >> Reported-by: syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.com
> >
> > +riscv maintainers
> >
> > This is riscv64-specific.
> > I've seen similar crashes in put_user in other places. It looks like
> > put_user crashes in the user address is not mapped/protected (?).
>
> I've been having a look, and this seems to be down to access of the
> tsk->set_child_tid variable. I assume the fuzzing here is to pass a
> bad address to clone?
>
>  From looking at the code, the put_user() code should have set the
> relevant SR_SUM bit (the value for this, which is 1<<18 is in the
> s2 register in the crash report) and from looking at the compiler
> output from my gcc-10, the code looks to be dong the relevant csrs
> and then csrc around the put_user
>
> So currently I do not understand how the above could have happened
> over than something re-tried the code seqeunce and ended up retrying
> the faulting instruction without the SR_SUM bit set.

I would maybe blame qemu for randomly resetting SR_SUM, but it's
strange that 99% of these crashes are in schedule_tail. If it would be
qemu, then they would be more evenly distributed...

Another observation: looking at a dozen of crash logs, in none of
these cases fuzzer was actually trying to fuzz clone with some insane
arguments. So it looks like completely normal clone's (e..g coming
from pthread_create) result in this crash.

I also wonder why there is ret_from_exception, is it normal? I see
handle_exception disables SR_SUM:
https://elixir.bootlin.com/linux/v5.12-rc2/source/arch/riscv/kernel/entry.S#L73

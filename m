Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F976339514
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhCLRfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbhCLRfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:35:00 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4628C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 09:35:00 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 30so4613834qva.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 09:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0hmXxAjdRD0U+F/dWy2tB3crefQXhKAVgphSKNgBkZI=;
        b=LJKFyFZysUttEVg/EispgxcOMcKAWVL4b8RRreOAgmXiEXIZNORrkX3bGWMBCKeQwf
         D6DGD0e7WNL/yjBasxw/GSI1NwSx1+bbq7mRageKwoBPB+paA3PXQCMowrQMqJrO4TgR
         NIRHv+ZAE+UQJSVNbqBS2C0Pi3k+HnP2iUDQ5c5LrCz+9B8CRo4/dmmYQYXF6AgxIQkd
         vPjYS4F9KA85o09krYEhE7l66w4kPLQ1WJhYMlojcHB3BQxzRgZxccOXHhbgZYGWzAsn
         OA/kvorL4k8pHF5z8OogGbv6sTmmKUW8eeZHu9QtbIKQsV78d9W7a4GXVqQ4rSF/l0ip
         Q4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0hmXxAjdRD0U+F/dWy2tB3crefQXhKAVgphSKNgBkZI=;
        b=OJE9Y4AqwmAKqmVMM81RYxpXA7RmyVL1dKyK1zNmsa16FvTTdenavuIzr8mI8k9xJx
         V00LoReScrkMyLk+vHxU2Nuk+C/WHxx3e/KXEulTtdU1dz4tsa8UiVohffzdbJzzPF8v
         JtcIECY0j9CTxGj/qYaNl41L1xQxwnW3HjI8IEkdcCrdaZ/ggZFXfU+jPojNJ2OPnght
         10lJlUJc8jjRlSgBsAFWwUMHl2bqcm6waM3DBaTsORaiPPUjzB6xsLCeLfc2iIZ1C8SY
         oeFlWs+tGtC5fOpWMrbcRWG/EPOsuE43a1DdmkKOVONA2chFvtbwhogsQ4bfZVvMyhHC
         UDHA==
X-Gm-Message-State: AOAM5316oflEOl5/4x0YPhhd9PpOAuiMRZU7l3YVdoIsPLMjlbk2/4xN
        USLqaKrpu+dCkKYRRYQ5WK4UTDG6e2oTrhMQ37fOEg==
X-Google-Smtp-Source: ABdhPJy0Ycg8McTa0upnBCtJshrTVqwY8X05iu/YLBxxC/1ebGERdoRiIZlCKLb5YeXDi109AUFJazSTl1hWW/r4NCE=
X-Received: by 2002:a0c:8304:: with SMTP id j4mr13448301qva.18.1615570499546;
 Fri, 12 Mar 2021 09:34:59 -0800 (PST)
MIME-Version: 1.0
References: <000000000000b74f1b05bd316729@google.com> <CACT4Y+ZHMYijYAkeLMX=p9jx6pBivJz06h_1rGt-k9=AgfkWQg@mail.gmail.com>
 <84b0471d-42c1-175f-ae1d-a18c310c7f77@codethink.co.uk> <CACT4Y+ZsSRdQ5LzYMsgjrBAukgP-Vv8WSQsSoxguYjWvB1QnrA@mail.gmail.com>
 <aa801bc7-cf6f-b77a-bbb0-28b0ff36e8ba@codethink.co.uk> <816870e9-9354-ffbd-936b-40e38e4276a4@codethink.co.uk>
 <4ce57c7e-6e5d-d136-0a81-395a4207ba44@codethink.co.uk>
In-Reply-To: <4ce57c7e-6e5d-d136-0a81-395a4207ba44@codethink.co.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 12 Mar 2021 18:34:48 +0100
Message-ID: <CACT4Y+ZJwJ9vcgCyabDUny0CnYmbHLRqU6m_KccdObS+7bBoGw@mail.gmail.com>
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

On Fri, Mar 12, 2021 at 5:36 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>
> On 12/03/2021 16:34, Ben Dooks wrote:
> > On 12/03/2021 16:30, Ben Dooks wrote:
> >> On 12/03/2021 15:12, Dmitry Vyukov wrote:
> >>> On Fri, Mar 12, 2021 at 2:50 PM Ben Dooks <ben.dooks@codethink.co.uk>
> >>> wrote:
> >>>>
> >>>> On 10/03/2021 17:16, Dmitry Vyukov wrote:
> >>>>> On Wed, Mar 10, 2021 at 5:46 PM syzbot
> >>>>> <syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.com> wrote:
> >>>>>>
> >>>>>> Hello,
> >>>>>>
> >>>>>> syzbot found the following issue on:
> >>>>>>
> >>>>>> HEAD commit:    0d7588ab riscv: process: Fix no prototype for
> >>>>>> arch_dup_tas..
> >>>>>> git tree:
> >>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
> >>>>>> console output:
> >>>>>> https://syzkaller.appspot.com/x/log.txt?x=1212c6e6d00000
> >>>>>> kernel config:
> >>>>>> https://syzkaller.appspot.com/x/.config?x=e3c595255fb2d136
> >>>>>> dashboard link:
> >>>>>> https://syzkaller.appspot.com/bug?extid=e74b94fe601ab9552d69
> >>>>>> userspace arch: riscv64
> >>>>>>
> >>>>>> Unfortunately, I don't have any reproducer for this issue yet.
> >>>>>>
> >>>>>> IMPORTANT: if you fix the issue, please add the following tag to
> >>>>>> the commit:
> >>>>>> Reported-by: syzbot+e74b94fe601ab9552d69@syzkaller.appspotmail.com
> >>>>>
> >>>>> +riscv maintainers
> >>>>>
> >>>>> This is riscv64-specific.
> >>>>> I've seen similar crashes in put_user in other places. It looks like
> >>>>> put_user crashes in the user address is not mapped/protected (?).
> >>>>
> >>>> I've been having a look, and this seems to be down to access of the
> >>>> tsk->set_child_tid variable. I assume the fuzzing here is to pass a
> >>>> bad address to clone?
> >>>>
> >>>>   From looking at the code, the put_user() code should have set the
> >>>> relevant SR_SUM bit (the value for this, which is 1<<18 is in the
> >>>> s2 register in the crash report) and from looking at the compiler
> >>>> output from my gcc-10, the code looks to be dong the relevant csrs
> >>>> and then csrc around the put_user
> >>>>
> >>>> So currently I do not understand how the above could have happened
> >>>> over than something re-tried the code seqeunce and ended up retrying
> >>>> the faulting instruction without the SR_SUM bit set.
> >>>
> >>> I would maybe blame qemu for randomly resetting SR_SUM, but it's
> >>> strange that 99% of these crashes are in schedule_tail. If it would be
> >>> qemu, then they would be more evenly distributed...
> >>>
> >>> Another observation: looking at a dozen of crash logs, in none of
> >>> these cases fuzzer was actually trying to fuzz clone with some insane
> >>> arguments. So it looks like completely normal clone's (e..g coming
> >>> from pthread_create) result in this crash.
> >>>
> >>> I also wonder why there is ret_from_exception, is it normal? I see
> >>> handle_exception disables SR_SUM:
> >>> https://elixir.bootlin.com/linux/v5.12-rc2/source/arch/riscv/kernel/entry.S#L73
> >>>
> >>
> >> So I think if SR_SUM is set, then it faults the access to user memory
> >> which the _user() routines clear to allow them access.
> >>
> >> I'm thinking there is at least one issue here:
> >>
> >> - the test in fault is the wrong way around for die kernel
> >> - the handler only catches this if the page has yet to be mapped.
> >>
> >> So I think the test should be:
> >>
> >>          if (!user_mode(regs) && addr < TASK_SIZE &&
> >>                          unlikely(regs->status & SR_SUM)
> >>
> >> This then should continue on and allow the rest of the handler to
> >> complete mapping the page if it is not there.
> >>
> >> I have been trying to create a very simple clone test, but so far it
> >> has yet to actually trigger anything.
> >
> > I should have added there doesn't seem to be a good way to use mmap()
> > to allocate memory but not insert a vm-mapping post the mmap().
> >
> How difficult is it to try building a branch with the above test
> modified?

I don't have access to hardware, I don't have other qemu versions ready to use.
But I can teach you how to run syzkaller locally :)
I am not sure anybody run it on real riscv hardware at all. When
Tobias ported syzkaller, Tobias also used qemu I think.

I am now building with an inverted check to test locally.

I don't fully understand but this code, but does handle_exception
reset SR_SUM around do_page_fault? If so, then looking at SR_SUM in
do_page_fault won't work with positive nor negative check.

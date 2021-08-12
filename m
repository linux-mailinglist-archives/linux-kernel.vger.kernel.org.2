Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E751E3EA1B4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 11:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbhHLJQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 05:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbhHLJQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 05:16:06 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519AEC061765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 02:15:41 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id b1so4626246qtx.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 02:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j+62UaqqgeDoZH7BF0vQ97XVYxQ3scOJGO1nBvJT+Tw=;
        b=owNe+QJI0dMyLtavpwmx0wiNU02kH4ptszzGn4B8vR5K8WIM+ixcjZvDghxj8bEvsS
         Mf02RIQ0YLTsVm4VLOAdPPds1PDB1YXMVH8U8hxHU4Cc7ZHiH5376Rk2YNjpZuL7WzPe
         jKM3QbZtqjw8gbA9T98AvrJkWFp1p3SDZSYZV4tAnZ2zedgBUGkMbbzHA8/4yShUCrQM
         /xhmT7Gbi22Be/Ba7I/mIARVKWQMSiCBm+psMPTCBkW8SGZKkXPn1mJDhDz0hb94ikUx
         /mUXjRgGPAducqDuBDVQgRoy62OSeOD+6or4vOYvL5s6cATfJU4pkCO56nAN/wbjxdLK
         R2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j+62UaqqgeDoZH7BF0vQ97XVYxQ3scOJGO1nBvJT+Tw=;
        b=mfduQ7uOLNb71yCIpsa6ifv7a94SqJwu5XgF7v5eUEzdzTYNyh/j5ScmfPV+NBpuZw
         uQPs7Zx0GPo5kEB114nOSZObzCsZXcfBUZpkD6axoTSGMd1I8oKNNxp4qjktN60D1k10
         Ufth8ZOReNZeWGNsD4DxqIhqoz6cjMnMzukmQoH0Wlc44QO4Nm2SVybH7s9jTHw9zItX
         inyvnnrY3kcltA/X1Zz4ophJwfbg5UYN1M6oJblBwscd2+1z0V/Z/dkWRVB7atHny+ls
         9A9BnI5aeWOptvhx7VElsUYI2/BmCt1rWnYlUGRHsh1BvB5JNdba3P4M+sE6XUF/lLwd
         UJiw==
X-Gm-Message-State: AOAM531tKOfLRrxuvY8aoLLw6mDDmaRf0wvRZJZvD57fRC89DvA2JtjA
        J6FIfeSQReWMi+TVuYIM13ZL7M+2NJy7QnM6j7xkOQ==
X-Google-Smtp-Source: ABdhPJy/S9W0uNSmo1S+gB9shUiRSIaS18xglTXhGBp1pkIn9RMfwpaJdd+7r23a3luUUxWXbUeavKcpMQERoBOSvyw=
X-Received: by 2002:ac8:6781:: with SMTP id b1mr2857198qtp.290.1628759740213;
 Thu, 12 Aug 2021 02:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+YvovgRNC5EFhN_d=jApwSAsWcNj35=FCJf1k867vBqfw@mail.gmail.com>
 <067b8eea-3c77-c1f0-8e68-b99e6bf0c033@leemhuis.info>
In-Reply-To: <067b8eea-3c77-c1f0-8e68-b99e6bf0c033@leemhuis.info>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 12 Aug 2021 11:15:28 +0200
Message-ID: <CACT4Y+byh0_z-+H3=-oojSLe+VesknKCXLPA5uVhue8zZaCb5A@mail.gmail.com>
Subject: Re: finding regressions with syzkaller
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     regressions@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        automated-testing@yoctoproject.org,
        Sasha Levin <sashalevin@google.com>,
        Marco Elver <elver@google.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Mara Mihali <mihalimara22@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2021 at 13:25, Thorsten Leemhuis <linux@leemhuis.info> wrote:
>
> [CCing Lukas]
>
> Hi Dmitry!
>
> On 10.08.21 19:08, Dmitry Vyukov wrote:
> > [...]
> > The idea is to generate random test programs (as syzkaller does) and
> > then execute them on 2 different kernels and compare results (so
> > called "differential fuzzing"). This has the potential of finding not
> > just various "crashes" but also logical bugs and regressions.
>
> Hmmm, interesting concept!
>
> > The major issue is various false positive differences caused by
> > timings, non-determinism, accumulated state, intentional and
> > semi-intentional changes (e.g. subtle API extensions), etc. We learnt
> > how to deal with some of these to some degree, but feasibility is
> > still an open question.
>
> Sounds complicated and like a lot of manual work.
>
> Do you have in mind that Linus and hence many other Kernel developers
> afaics only care about regressions someone actually observed in a
> practice? Like a software or script breaking due to a kernel-side change?
>
> To quote Linus from
> https://lore.kernel.org/lkml/CA+55aFx3RswnjmCErk8QhCo0KrCvxZnuES3WALBR1NkPbUZ8qw@mail.gmail.com/
>
> ```The Linux "no regressions" rule is not about some theoretical
> "the ABI changed". It's about actual observed regressions.
>
> So if we can improve the ABI without any user program or workflow
> breaking, that's fine.```
>
> His stance on that afaik has not changed since then.
>
> Thus after ruling our all false positives syzkaller might find, there
> will always be the follow-up question "well, does anything/anyone
> actually care?". That might be hard to answer and requires yet more
> manual work by some human. Maybe this working hours at least for now are
> better spend in other areas.

Hi Thorsten,

Good point. At this point the nature and volume of regressions such a
system can find is unknown, so it's hard to make any conclusions.
But some additional theoretical arguments in favor of such a system:
1. Any regressions also need to be found quickly (ideally before the
release). And as far as I understand currently lots of regressions are
found only after 1-3 years when the new kernel reaches some distro and
users update to the new version. Year-long latency has its own
problems. In particular there may now be users of the new (implicit)
API as well, and then it's simply not possible to resolve the breakage
at all.

2. As far as I understand most regressions happen due to patches that
are not even known to change anything (the change wasn't
known/described). So such a system could at least surface this
information. For example, was it intentional/known/realized that this
commit changes API?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d25e3a3de0d6fb2f660dbc7d643b2c632beb1743
Amusingly the commit description says:
"Retain compatibility with how attaching works, so that any attempt to
attach to an fd that doesn't exist, or isn't an io_uring fd, will fail
like it did before".
which turns out to be false, it does not fail like it did before, it
fails differently.

3. It may be possible to prioritize some API changes as more likely to
be problematic (e.g. a change from errno 0 to some particular values,
or changes file contents after the same sequence of syscalls). The
importance can also be different for different kernels. For example,
for LTS .1 -> .y I assume any changes may be worth being aware of.



> > Since this work is in very early stage, I only have very high-level questions:
> >  - what do you think about feasibility/usefulness of this idea in general?
>
> TBH I'm a bit sceptical due to the above factors. Don't get me wrong,
> making syzkaller look out for regressions sounds great, but I wonder if
> there are more pressing issues that are worth getting at first.
>
> Another aspect: CI testing already finds quite a few regressions,

Quite a few in absolute numbers or relative to the total number of
regressions? :)

> but
> those that are harder to catch are afaics often in driver code. And you
> often can't test that without the hardware, which makes me assume that
> syzkaller wouldn't help here (or am I wrong?)

It depends.
syzbot runs on VMs at the moment, but anybody is free to run syzkaller
on any h/w. And it's quite popular at least for Android phones as far
as I understand.
And at some point we may be getting more testable drivers than we have
now (few).
But also could anybody predict how many bugs syzkaller would find
before it came into existence? So I would not give up on generic
kernel code right away :)


> >  - any suggestions on how to make the tool find more differences/bugs
> > or how to make it more reliable?
> >  - is there a list or pointers to some known past regressions that
> > would be useful to find with such tool? (I've looked at the things
> > reported on the regressions@ list, but it's mostly crashes/not
> > booting, but that's what syzkaller can find already well)
>
> I first wanted to tell you "look up the reports I compiled in 2017 in
> the LKML archives", but I guess the way better solution is: just grep
> for "regression" in the commit log.

Good idea.
It seems that something like this can give enough subsystem-targeted
info for initial analysis:

git log --no-merges --oneline --grep "fix.*regression" fs/ | grep -v
"performance regression"

> >  - anybody else we should CC?
>
> I guess the people from the Elisa project might be interested in this,
> that's why I CCed Lukas.
>
> Ciao, Thorsten

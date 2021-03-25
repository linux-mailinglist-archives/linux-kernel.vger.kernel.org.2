Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB927349A25
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 20:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhCYTZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 15:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhCYTZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:25:06 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDD8C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 12:25:06 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id x9so2529433qto.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 12:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BH1rH6caE39g0jiGK70AFedQ5v5dokTeZNKhqTkmX2s=;
        b=IRyc9FFAqElCbGemY1KCq9/RoV8KmD7cggTOOPBanhNENLNuJHxLEB42OGsXSGwdD/
         BvuKH+lQqy/5wxBzh/CwNBLPveUQdXHulwbst0Y2ogYm3pE91nBpp1gQJsee3ODCkAdc
         atYaTp8GtEi7tjFyTGnyAi/ZBWyvjDi4rd/e3mNzNk5LhSANV5mD75BTXCMRYXYl0xIq
         kzIso6ezn8Xs8+cPakmGFeF/3NN4LHE8C1TvDcIK34eX2IFqDEAuFY7MP2eqivwl6cYP
         r0yH4fRkAM4JzQME8N/kYAY5s6JMvmMMhVz1Cr4zaInWdxqTQ3SP/TI2Nwe9PGgbT3c6
         UJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BH1rH6caE39g0jiGK70AFedQ5v5dokTeZNKhqTkmX2s=;
        b=i/ZgUdPG1Ss2AxmCBw2IcCAy+tNaQDvXVbLBm6NZeEUPCzsiFerZWXHzxXvq1VF2Ld
         BQBfZ0S/oQ2mDADpQbTdGX8pUyK53PMgRVjL+jDZNhgL7A8BdUwq+JQMTkmLoO02KefW
         /WMWYXRz7OmVfkgw3PG7lIFm92lwKJvbkg08EG4b+fXQ87A+bUq1/HIShczPWQArJUg1
         x5J51oVabSDtIzfkFMXrYk3Iv11dX9UUG262ak5zD7+J1ASasZHhvLCkVl+hDLQHE1iI
         y06jtzTeHXihzDC1pKew8tVgwB+lWdhaXoB8NGLwQeTjk9ieirHhJbS1L5ZjORb3+eH8
         bCzA==
X-Gm-Message-State: AOAM5327FZJhz9had7edK1lM9LHLELPVU1L5xq9WNvPSvY32uVOsnGH9
        8GD13U0MAgK8WGN90Mimo+ch1tlE0ng0SM6Xwvh5jLb44uvukg==
X-Google-Smtp-Source: ABdhPJzaaXwX20v3NiqHfohJ32Zo0GA4QEkkDe8IObPTlCwdXwL/E9UZWjDpgXw6Zg/5DXDYCK+x5Rl4DXsDf6eh7Dw=
X-Received: by 2002:ac8:4558:: with SMTP id z24mr9125555qtn.66.1616700305523;
 Thu, 25 Mar 2021 12:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ce4c9505bdd4a48f@google.com> <CACT4Y+a4S-oXsjgwDh3SmERqKFF1QbapvX6NiSpn51KRtqvTiQ@mail.gmail.com>
 <20210325182046.GA15860@willie-the-truck> <CACT4Y+b833yyxekjK61PpFKLmdJq0Jb6vLUo=EBYCLKr9+ksow@mail.gmail.com>
 <20210325191006.GE15860@willie-the-truck>
In-Reply-To: <20210325191006.GE15860@willie-the-truck>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 25 Mar 2021 20:24:53 +0100
Message-ID: <CACT4Y+Y-iROPw8bvpjzpSoUfHs+6ridjKfnLbs8Hhv9ciP7dYw@mail.gmail.com>
Subject: Re: [syzbot] BUG: soft lockup in do_wp_page (4)
To:     Will Deacon <will@kernel.org>
Cc:     syzbot <syzbot+0b036374a865ba0efa8e@syzkaller.appspotmail.com>,
        kernel-team@android.com, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 8:10 PM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Mar 25, 2021 at 07:34:54PM +0100, Dmitry Vyukov wrote:
> > On Thu, Mar 25, 2021 at 7:20 PM Will Deacon <will@kernel.org> wrote:
> > >
> > > On Thu, Mar 18, 2021 at 08:34:16PM +0100, Dmitry Vyukov wrote:
> > > > On Thu, Mar 18, 2021 at 8:31 PM syzbot
> > > > <syzbot+0b036374a865ba0efa8e@syzkaller.appspotmail.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > syzbot found the following issue on:
> > > > >
> > > > > HEAD commit:    bf152b0b Merge tag 'for_linus' of git://git.kernel.org/pub..
> > > > > git tree:       upstream
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=17d5264ed00000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=2c9917c41f0bc04b
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=0b036374a865ba0efa8e
> > > > > userspace arch: arm64
> > > > >
> > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > >
> > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > Reported-by: syzbot+0b036374a865ba0efa8e@syzkaller.appspotmail.com
> > > > >
> > > > > watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [syz-executor.1:3684]
> > > >
> > > > +Will, arm
> > > >
> > > > If I am reading this commit correctly, this is caused by:
> > > >
> > > > commit cae118b6acc309539b33339e846cbb19187c164c
> > > > Author: Will Deacon
> > > > Date:   Wed Mar 3 13:49:27 2021 +0000
> > > >     arm64: Drop support for CMDLINE_EXTEND
> > > >
> > > > syzbot passes lots of critical things in CONFIG_CMDLINE:
> > > > https://github.com/google/syzkaller/blob/c3c81c94865791469d376eba84f4a2d7763d3f71/dashboard/config/linux/upstream-arm64-kasan.config#L495
> > > > but also wants the bootloader args to be appended.
> > > > What is the way to do it now?
> > >
> > > For now, there isn't a way to do it with CONFIG_CMDLINE, so I think you can
> > > either:
> > >
> > >   * Revert my patch for your kernels
> > >   * Pass the arguments via QEMU's -append option
> > >   * Take a look at one of the series which should hopefully add this
> > >     functionality back (but with well-defined semantics) [1] [2]
> >
> > Unfortunately none of these work for syzbot (and I assume other
> > testing environments).
> >
> > syzbot does not support custom patches by design:
> > http://bit.do/syzbot#no-custom-patches
> > As any testing system, it tests the official trees.
> >
> > It's not humans who start these VMs, so it's not as easy as changing
> > the command line after typing...
> > There is no support for passing args specifically to qemu, syzkaller
> > support not just qemu, so these things are specifically localized in
> > the config. Additionally there is an issue of communicating all these
> > scattered details to developers in bug reports. Currently syzbot
> > reports the kernel config and it as well captures command line.
> >
> > Could you revert the patch? Is there any point in removing the
> > currently supported feature before the new feature lands?
>
> Well, we only just merged it (in 5.10 I think?), and the semantics of the
> new version will be different, so I really don't see the value in supporting
> both (even worse, Android has its own implementation which is different
> again). The timeline was: we merged CMDLINE_EXTEND, then we noticed it was
> broken, my fixes were rejected, so we removed the feature rather than
> support the broken version. In the relatively small window while it was
> merged, syzbot started using it :(

I didn't realize it was just introduced :)
We used CMDLINE_EXTEND on x86, and I looked for a similar option for
arm64 and found it.

> So I really think the best bet is to wait until the patches are sorted out.
> I think Christophe is about to spin a new version, and I reviewed his last
> copy, so I don't see this being far off,

If it's expected to be merged soon, let's wait.

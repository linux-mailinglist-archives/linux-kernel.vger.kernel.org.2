Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9878538C05C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 09:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbhEUHI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 03:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbhEUHIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 03:08:50 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5874AC06138F
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 00:04:52 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id y12so14607572qtx.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 00:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AEw/2V7/xpmVmNpjjOkVlxPAcJgRBwQ9KZP9S0+LhGs=;
        b=vgb3uAFmlPGVXAd91EJa6J4LHy8LHu+U29axDVp5UZhMh+fe91loAj1CTq+Gdm3t9H
         HDxcGhiah+7YPM/Hk6PLL4W0/2u1/z0X5YNxOVspAv2Ku8vnZPWkQti+J9JjowrHG7bI
         z46AGqk0o6qyNmV3pBM2jC81hIDUfUkrkQXCDBc/ci7c8Fqt3LcLGF/q25GEFtJVbDQg
         3TDJUYCgV+ROCX6L2zmMWVjPqOGLgLDwjeMTsS2XWhjM5OwAL2QoEzl17X1Kk5AzWcYs
         8wXTqDa+d6CARDy0yZ8IJ7ZvbYrcC9aYEzH9LO7cWosbxY/dBTZeQz1MxNs7qKVEc5J7
         TAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AEw/2V7/xpmVmNpjjOkVlxPAcJgRBwQ9KZP9S0+LhGs=;
        b=XWrKb5MhE8pZOOZs6Ga1rLubvuzNbXprSIs+g9GnusqewDsCxWMKpc9NUw5THyUzQe
         Cjsp0qoltRBVNWKhzcCbQqXEMBrbGYtKkzOFIFqOs2WnTG4hx08BIG9W9bzxUmyTlw3i
         sm5bozFuiw4mDFycRSLg01OzUEQ7tYelXSuo8ltzmCo+D4gMXnpJI9fSvS/YLviZZgw9
         QmM3jlQB8KvO4PMMnkRwcABZs1QmwMA21ZgMeV/TquQVpyIJIjOyKQnTW5vvLSm6qPUI
         /PMxWY9JLpGVxZ2hB6ewoQ60HVQlFdDh/UnnT4ghshAz4EL0pEvtAJCM7OaoI3MDKZcU
         eg8g==
X-Gm-Message-State: AOAM530ufwP06WjMfYvuvuC312wyle4drnEmKhqrx11rFiWJHS6IIIOy
        rj7PdjjCkWrmfbdrqRJluFdqGeSiGcyxZu5BwuWVuw==
X-Google-Smtp-Source: ABdhPJxBl69YJ2DivfUpEV1speNJDfx8ufFZ4oirpKc3gjTnIcoQhKPkIj8PsdvtwiF9BnwCBN/zC96sHLv1rhA0bxc=
X-Received: by 2002:ac8:4e21:: with SMTP id d1mr9657232qtw.290.1621580691240;
 Fri, 21 May 2021 00:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000003687bd05c2b2401d@google.com> <CACT4Y+YJDGFN4q-aTPritnjjHEXiFovOm9eO6Ay4xC1YOa5z3w@mail.gmail.com>
 <c545268c-fe62-883c-4c46-974b3bb3cea1@infradead.org> <CACT4Y+aEtYPAdrU7KkE303yDw__QiG7m1tWVJewV8C_Mt9=1qg@mail.gmail.com>
 <208cd812-214f-ef2f-26ec-cc7a73953885@i-love.sakura.ne.jp>
In-Reply-To: <208cd812-214f-ef2f-26ec-cc7a73953885@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 21 May 2021 09:04:39 +0200
Message-ID: <CACT4Y+Y8KmaoEj0L8g=wX4owS38mjNLVMMLsjyoN8DU9n=FrrQ@mail.gmail.com>
Subject: Re: [syzbot] BUG: MAX_LOCKDEP_KEYS too low! (2)
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Miller <davem@davemloft.net>,
        syzbot <syzbot+a70a6358abd2c3f9550f@syzkaller.appspotmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        WireGuard mailing list <wireguard@lists.zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 7:02 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2021/05/20 5:09, Dmitry Vyukov wrote:
> > On Wed, May 19, 2021 at 9:58 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>
> >> On 5/19/21 12:48 PM, Dmitry Vyukov wrote:
> >>> On Wed, May 19, 2021 at 7:35 PM syzbot
> >>> <syzbot+a70a6358abd2c3f9550f@syzkaller.appspotmail.com> wrote:
> >>>>
> >>>> Hello,
> >>>>
> >>>> syzbot found the following issue on:
> >>>>
> >>>> HEAD commit:    b81ac784 net: cdc_eem: fix URL to CDC EEM 1.0 spec
> >>>> git tree:       net
> >>>> console output: https://syzkaller.appspot.com/x/log.txt?x=15a257c3d00000
> >>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=5b86a12e0d1933b5
> >>>> dashboard link: https://syzkaller.appspot.com/bug?extid=a70a6358abd2c3f9550f
> >>>>
> >>>> Unfortunately, I don't have any reproducer for this issue yet.
> >>>>
> >>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >>>> Reported-by: syzbot+a70a6358abd2c3f9550f@syzkaller.appspotmail.com
> >>>>
> >>>> BUG: MAX_LOCKDEP_KEYS too low!
> >>>
> >>
> >> include/linux/lockdep.h
> >>
> >> #define MAX_LOCKDEP_KEYS_BITS           13
> >> #define MAX_LOCKDEP_KEYS                (1UL << MAX_LOCKDEP_KEYS_BITS)
> >
> > Ouch, so it's not configurable yet :(
>
> I didn't try to make this value configurable, for
>
> > Unless, of course, we identify the offender that produced thousands of
> > lock classes in the log and fix it.
>
> number of currently active locks should decrease over time.
> If this message is printed, increasing this value unlikely helps.
>
> We have https://lkml.kernel.org/r/c099ad52-0c2c-b886-bae2-c64bd8626452@ozlabs.ru
> which seems to be unresolved.
>
> Regarding this report, cleanup of bonding device is too slow to catch up to
> creation of bonding device?
>
> We might need to throttle creation of BPF, bonding etc. which involve WQ operation for clean up?

I see, thanks for digging into it.

Unbounded asynchronous queueing is always a recipe for disaster... I
assume such issues can affect production as well, if some program
creates namespaces/devices in a loop. So I think ideally such things
are throttled/restricted in the kernel, e.g. new namespaces/devices
are not created if some threshold is reached.

Potentially syzkaller could throttle creation of new
namespaces/devices if we find a good and reliable way to monitor
backlog. Something like the length of a particular workqueue. It may
also help with OOMs. But so far I haven't found it.

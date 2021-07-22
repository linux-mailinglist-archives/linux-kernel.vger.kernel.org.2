Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4135B3D20F9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 11:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhGVIyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 04:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhGVIyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 04:54:15 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1A6C061575;
        Thu, 22 Jul 2021 02:34:50 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id v14so3793119plg.9;
        Thu, 22 Jul 2021 02:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vmOmuaK7LWo43TRzwjBM1rShoFVgmRr+DkytbYWjobM=;
        b=ajOxZtQ71qB4NgzbVp+CaqQT7nOhGqilPP/1YpGTptF0Wta3yCrfzemAqFt6L5XrlX
         0hDRtSORTMMwFfLf8kguUfOVWELdX+XHdJxbaR9GexW/xxM/YXVE3ptXqYgiM0dmw/8r
         2PuD4tU1gt+YGQMxPfesyx1r0Wuo5U8qSePMge8m2Ca7CiymFsiiRXGScdh9xUmvpxWM
         TbcdVaVs25qEJ/w85bHQwtyXs88wgIxPLUB/KT7qIi3NFRiX7pozdPyuVsYhpgT9ANC/
         9UXf6MUszhnCdgSadlDEh/jqM3a0ytzqNwlkOlMpAqWrbklTbyW4SXny4yjc9FyEflng
         kCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vmOmuaK7LWo43TRzwjBM1rShoFVgmRr+DkytbYWjobM=;
        b=Mr3KJjD0pHKy8j+fUlcMSqqM5X95VQO0zoQ1V674qVFUQiH0K6cKnruZ31DLQg2HUu
         42V8HaO7B1P5OydPYBf71AuBRHGnNpEnMtfY+uN0jvI/lXdAsM8Ex6lG9G6zYNckRJyi
         Jg1+LPsFe4fkNS/qCdOW8Q/VZ27qk95Lo/nelcBS86J4go15qcfUb7PwTr5n9pxpNgr2
         7crxCdmne93moN6i8wJkw4sJK25Wxs8xSZGS/J8Jzk8oHnPF0steHCwukuF/eNtsCFjr
         LLj7i6n4Ge34r9RN0odJy3q1gxD4pxnQd0moEbIvEncmzxg59TIK1eOp9w7xFWnNZMtq
         4ldw==
X-Gm-Message-State: AOAM533WtcQBLXK6t6/+RyAE+3qhk+93lhbufpDYHBLloEeXzgnXjkk/
        RL2miI63jM91QxFewQ9nmopdBdNP3iljxiGp59Q=
X-Google-Smtp-Source: ABdhPJzieBPLPtbomp2eYEOuqvzd/dnwMiQHJV30oU+LY04cUblzlgUBsQbgA37ho8E69oD0YKE0dy00pEhCIsAL49o=
X-Received: by 2002:a63:d014:: with SMTP id z20mr40356488pgf.203.1626946489997;
 Thu, 22 Jul 2021 02:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210715120752.29174-1-andriy.shevchenko@linux.intel.com>
 <20210715120752.29174-2-andriy.shevchenko@linux.intel.com>
 <7941107fda10f075395870528f0e52d42e502d92.camel@nxp.com> <YPGHbvaCv/x/JlgH@smile.fi.intel.com>
 <bfa0c16e88c0d445137290b2bef104e5fa74d78a.camel@nxp.com> <YPVrkAarqSBMY1tV@smile.fi.intel.com>
 <6b2a6408fcff0d064746d7a77db7b9502c66ad20.camel@nxp.com> <CAHp75VeTyWe6SWpWMRYh4Ah6LYULNHBuSo7Tq2AX=vdsObnTLw@mail.gmail.com>
 <3cd7393a34ca991184722e57b6c64737973b31c4.camel@nxp.com>
In-Reply-To: <3cd7393a34ca991184722e57b6c64737973b31c4.camel@nxp.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 22 Jul 2021 12:34:10 +0300
Message-ID: <CAHp75VduRAcZLOxvk+QByn=Uw6JcEwfsby2QPib1OZTNETeObQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] clk: fractional-divider: Introduce NO_PRESCALER flag
To:     Liu Ying <victor.liu@nxp.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 12:11 PM Liu Ying <victor.liu@nxp.com> wrote:
> On Thu, 2021-07-22 at 10:24 +0300, Andy Shevchenko wrote:
> > On Thu, Jul 22, 2021 at 9:04 AM Liu Ying <victor.liu@nxp.com> wrote:
> > > On Mon, 2021-07-19 at 15:09 +0300, Andy Shevchenko wrote:
> > > > On Mon, Jul 19, 2021 at 11:16:07AM +0800, Liu Ying wrote:
> > > > > On Fri, 2021-07-16 at 16:19 +0300, Andy Shevchenko wrote:
> > > > > > On Fri, Jul 16, 2021 at 10:43:57AM +0800, Liu Ying wrote:
> > > > > > > On Thu, 2021-07-15 at 15:07 +0300, Andy Shevchenko wrote:

...

> > > > core (or even TTY) has a specific function to approximate the baud rate and it
> > > > tries it 2 or 3 times. In case of *saturated* values it won't progress anyhow
> > > > because from best rational approximation algorithm the very first attempt would
> > > > be done against the best possible clock rate.
> > > >
> > > > Can you provide some code skeleton to see?
> > >
> > > Perhaps, two approaches can be taken in driver which uses the
> > > fractional divider clock:
> > > 1) Tune prescaler to generate higher rate or lower rate accordingly
> > > when clk_round_rate() for the fractional divider clock returns lower or
> > > higher rates then desired rate. This might take several rounds until
> > > desired rate is satisfied w/wo a tolerated bias.
> > > 2) Put working clock rates and/or parent clock rates in a table as sort
> > > of prior knowledge, which means less code for rate negotiation.
> >
> > Often 2) is a bad idea which I'm against from day 1. I prefer to
> > calculate what can be calculated.
> > The 1) looks better but requires several (unnecessary IIRC) rounds.
> > Why not supply the additional parameter(s) to tell that we have a
> > prescaller with certain limitations?
>
> To me, it's kinda too much information to this common frational divider
> clk driver.  Making the common driver simple and easy to maintain is
> important.

But it has to have it due to the nature of the hardware design. If you
leave it w/o that you have immediately come into the situation where
the clock rate will be far too wrong because of *saturated* values.
Have you done the arithmetics on the paper by the way?

...

> > I might disagree on the grounds of the HW hierarchy and the best that
> > we may achieve in _one_ pass. For example, for a 16-bit additional
> > prescaler it will require up to 16 steps to get the best possible
>
> Would that be an unacceptable performance penalty?

Yes.

> > values for the m/n. Instead we may supply to this driver the
> > information about subordinate prescaler and get the best m/n. The
> > caller will need to just divide the resulting rate by the asked rate
> > to get a prescaler value.
>
> IMHO, a simpler fractional divider clk driver without the prescaler
> knowledge wins the tradeoff.

I'm far from being convinced.

...

> > > > TL;DR: please send a code to discuss.

^^^^ I am tired of telling you this, btw.

> > > It seems that you have some experience on those intel drivers, this
> > > clock driver and rational algorithm driver and you probably have intel
> > > HWs to test.  May I encourage you to look into this and decouple the
> > > prescaler knowledge out :-)
> > >
> > > > Thanks for review and you review of v2 is warmly welcomed!
> > >
> > > I'd like to see patches to decouple the prescaler knowledge out.
> >
> > Then produce them! Currently the code works for all its users and does
> > not need any changes (documentation is indeed a gap).
>
> IIUC, only the two Intel drivers mentioned before are affected.
> Rockchip has it's own ->approximation() callback

...which is using the same algo, look at the patch 1 of the series. It
seems you missed to actually review. Just review the series as a
whole, please!

>  and i.MX7ulp hasn't
> the prescaler(IIUC), thus kinda not affected.  So, perhaps you may help
> look into this and decouple the prescaler knowledge out, as it seems
> that you have experience on the relevant drivers and HW to test.

> Anyway, to me, it is _not_ a must to have if you really think it's hard
> to do or unnesessary :-)

...

> > > V2, like v1, tries to consolidate the knowledge in this fractional
> > > divider clk driver. So, not the right direction I think.
> >
> > Then why are you commenting here and not there? :-)
>
> Maybe v2 was sent too quickly as the decoupling comment on v1 hasn't
> been sufficiently discussed :-)

Maybe.

> I'll comment v2 briefly.

Thanks!

...

> > I think I would drop patch 2 from the set (patch 1 is Acked and patch
> > 3 is definitely needed to describe current state of affairs) on the
> > grounds of the comments.
>
> Please consider i.MX7ulp, as it hasn't the prescaler IIUC. i.MX7ulp
> needs NO_PRESCALER flag, if we keep the prescaler knowledge in this
> driver ofc.

Then  we need a flag and v2 can go as is.

-- 
With Best Regards,
Andy Shevchenko

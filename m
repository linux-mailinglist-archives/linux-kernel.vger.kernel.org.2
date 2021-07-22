Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77A73D1EF8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 09:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhGVGoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 02:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbhGVGoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 02:44:15 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1B4C061575;
        Thu, 22 Jul 2021 00:24:49 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id q13so2539698plx.7;
        Thu, 22 Jul 2021 00:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DbhXmwk5Pgzr5UQORj6l6ot/ogt5bLsSYD4MP0zFRBc=;
        b=HYM6RoWm5g49/PXCJj6Xhe0GgOE7DxU0Tehwo88pZh91j1akuzczp8zKDb2T1iFFQe
         eCXo2v0YdFrCPB79U8SuoEnCAucDkzipdL87DTcc1ln5uOcXJUlN2FDo2j/yjy2fIJGQ
         tXuV3X9Z1TGg/wIcbJE4ar7x7rYa/IBfbULL1hVY2qNRReGOaI1gYXUTa1Eoi9FTWCCl
         siNQUupjNVtUw5E4QbYpQ+h3t2chJp/6TUIDbbjyDZCMsJBdAJoAuZpAREb8vWPOo/Eu
         cGDCdlkQ2wwv1Lhc+PWPFu53iHJRxlsob5o7y3xgBGKpb8cbHNzkPXR/DHVVVeVVNxdV
         pvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DbhXmwk5Pgzr5UQORj6l6ot/ogt5bLsSYD4MP0zFRBc=;
        b=i78vy1SUBZBxaY7L85N+ZJ4z9zv7Q39CnlVFWO3ylUjoI79IjWeZ0l32HHcxXLzF7M
         56WC6IcGlNNvFELT5IW4GWRqvKdFh5M9BihLc1PyzWo7Miw2vDIt37q+LYWkpafFTNq9
         z7UImGpGg5w8XKjZS7CUSeIrNTmCHI/ss/Rj26kELiq6h7ZyCTr5KH4Q3YnVjXYVh333
         kOpXTxjk2R2lLLTaMD9IKZwcxfa6niJ0qlKBGKS1Y6TJh+82qXSU2n42d7vepqNzOBRG
         57VdGF4BMRzdbqDMSddt0EDGpe8PE0UhBdyehRyig/f0nQayJPSRQWOuEWbjV6CvdxV/
         IDtg==
X-Gm-Message-State: AOAM531MRqSQhxpntMk4ib6Dl1VWxqHME4aezucxhKmv1cY7vMWV0pWl
        OzPCernrnSOG+asM5TGdMkdsdio5//ws9b8vje0=
X-Google-Smtp-Source: ABdhPJyyEcKv27+DRphwUCE/WWwYG6XnZHoQbnNglY/CmSuTPJUUWByMD+hhoqNyl3YfpxsO7BnV8vSVeMNShlm1AzQ=
X-Received: by 2002:a17:902:fe97:b029:12b:aebf:6484 with SMTP id
 x23-20020a170902fe97b029012baebf6484mr1236099plm.0.1626938689114; Thu, 22 Jul
 2021 00:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210715120752.29174-1-andriy.shevchenko@linux.intel.com>
 <20210715120752.29174-2-andriy.shevchenko@linux.intel.com>
 <7941107fda10f075395870528f0e52d42e502d92.camel@nxp.com> <YPGHbvaCv/x/JlgH@smile.fi.intel.com>
 <bfa0c16e88c0d445137290b2bef104e5fa74d78a.camel@nxp.com> <YPVrkAarqSBMY1tV@smile.fi.intel.com>
 <6b2a6408fcff0d064746d7a77db7b9502c66ad20.camel@nxp.com>
In-Reply-To: <6b2a6408fcff0d064746d7a77db7b9502c66ad20.camel@nxp.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 22 Jul 2021 10:24:12 +0300
Message-ID: <CAHp75VeTyWe6SWpWMRYh4Ah6LYULNHBuSo7Tq2AX=vdsObnTLw@mail.gmail.com>
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

On Thu, Jul 22, 2021 at 9:04 AM Liu Ying <victor.liu@nxp.com> wrote:
> On Mon, 2021-07-19 at 15:09 +0300, Andy Shevchenko wrote:
> > On Mon, Jul 19, 2021 at 11:16:07AM +0800, Liu Ying wrote:
> > > On Fri, 2021-07-16 at 16:19 +0300, Andy Shevchenko wrote:
> > > > On Fri, Jul 16, 2021 at 10:43:57AM +0800, Liu Ying wrote:
> > > > > On Thu, 2021-07-15 at 15:07 +0300, Andy Shevchenko wrote:

> > > > > Second and more important, it seems that it would be good to decouple
> > > > > the prescaler knowledge from this fractional divider clk driver so as
> > > > > to make it simple(Output rate = (m / n) * parent_rate).  This way, the
> > > > > CLK_FRAC_DIVIDER_NO_PRESCALER flag is not even needed at the first
> > > > > place, which means rational_best_approximation() just _directly_
> > > > > offer best_{numerator,denominator} for all cases.
> > > >
> > > > Feel free to submit a patch, just give a good test to avoid breakage of almost
> > > > all users of this driver.
> > >
> > > Maybe someone may do that.
> >
> > Perhaps. The idea per se is good I think, but I doubt that the implementation
> > will be plausible.
> >
> > > I just shared my thought that it sounds
> > > like a good idea
> >
> > Thanks!
> >
> > > to decouple the prescaler knowledge from this
> > > fractional divider clk driver.
> >
> > Are you suggesting that each of the device that has _private_ pre-scaler has to
> > be a clock provider at the same time?
>
> Maybe it depends on specific devices.  But, if a device is designed to
> dedicatedly control clocks, being a clock provider seems to be
> intuitive.

OK.

> > OTOH you will probably need irrespresentable hierarchy to avoid saturated values.
> >
> > At least those two issues I believe makes the idea fade in complications of the
> > actual implementation. But again, send the code (you or anybody else) and we will
> > see how it looks like.
>
> Aside from making this fractional divider clk driver simple, there
> seems to be another reason for decoupling the prescaler knowledge from
> the driver.  That is, the 'left shifting' done in
> clk_fd_general_approximation()/clk_fd_round_rate() is likely to cause
> mis-match bewteen 'rate = clk_round_rate(clk, r);' and
> 'clk_set_rate(clk, r); rate = clk_get_rate(clk);' as kerneldoc
> of clk_round_rate() mentions that they are kinda equivalent
> in include/linux/clk.h. clk_fd_set_rate() doesn't really contain the
> 'left shifting'.
>
> So, it looks like decoupling is the right way to go.

OK.

...

> > > > > Further more, is it
> > > > > possilbe for rational_best_approximation() to make sure there is no
> > > > > risk of overflow for best_{numerator,denominator}, since
> > > > > max_{numerator,denominator} are already handed over to
> > > > > rational_best_approximation()?
> > > >
> > > > How? It can not be satisfied for all possible inputs.
> > >
> > > Just have rational_best_approximation() make sure
> > > best_{numerator,denominator} are in the range of
> > > [1, max_{numerator,denominator}] for all given_{numerator,denominator}.
> > > At the same time, best_numerator/best_denominator should be as close
> > > to given_numerator/given_denominator as possible. For this particular
> > > fractional divider clk use case, clk_round_rate() can be called
> > > multiple times until users find rounded rate is ok.
> >
> > How is it supposed to work IRL? E.g. this driver is being used for UART. Serial
>
> I guess the drivers are drivers/acpi/acpi_lpss.c and drivers/mfd/intel-
> lpss.c? Both for Intel.

At least those I have knowledge of. Others, if any, seem to have taken
this into account.

> > core (or even TTY) has a specific function to approximate the baud rate and it
> > tries it 2 or 3 times. In case of *saturated* values it won't progress anyhow
> > because from best rational approximation algorithm the very first attempt would
> > be done against the best possible clock rate.
> >
> > Can you provide some code skeleton to see?
>
> Perhaps, two approaches can be taken in driver which uses the
> fractional divider clock:
> 1) Tune prescaler to generate higher rate or lower rate accordingly
> when clk_round_rate() for the fractional divider clock returns lower or
> higher rates then desired rate. This might take several rounds until
> desired rate is satisfied w/wo a tolerated bias.
> 2) Put working clock rates and/or parent clock rates in a table as sort
> of prior knowledge, which means less code for rate negotiation.

Often 2) is a bad idea which I'm against from day 1. I prefer to
calculate what can be calculated.
The 1) looks better but requires several (unnecessary IIRC) rounds.
Why not supply the additional parameter(s) to tell that we have a
prescaller with certain limitations?

...

> > > > > Overflowed/unreasonable
> > > > > best_{numerator,denominator} don't sound like the "best" offered value.
> > > >
> > > > I don't follow here. If you got saturated values it means that your input is
> > > > not convergent. In practice it means that we will supply quite a bad value to
> > > > the caller.
> > >
> > > Just like I mentioned above, if given_{numerator,denominator} are not
> > > convergent, best_numerator/best_denominator should be as close
> > > to given_numerator/given_denominator as possible and at the same time
> > > best_{numerator,denominator} are in the range of
> > > [1, max_{numerator,denominator}].  This way, caller may have chance to
> > > propose convergent inputs.
> >
> > How? Again, provide some code to understand this better.
> > (Spoiler: arithmetics won't allow you to do this. Or maybe
> >  I'm badly missing something very simple and obvious...)
> >
> > And, if it's possible to achieve, are you suggesting that part of
> > what CCF driver should do the users will have been doing by their
> > own?
>
> Well, I just think it doesn't seem to be necessary for the CCF/common
> frational drivider clk driver to have the prescaler knowledge. The
> prescaler knowledge can be in a dedicated clk provider(if appropriate)
> or somewhere else.

I might disagree on the grounds of the HW hierarchy and the best that
we may achieve in _one_ pass. For example, for a 16-bit additional
prescaler it will require up to 16 steps to get the best possible
values for the m/n. Instead we may supply to this driver the
information about subordinate prescaler and get the best m/n. The
caller will need to just divide the resulting rate by the asked rate
to get a prescaler value.

...

> > TL;DR: please send a code to discuss.
>
> It seems that you have some experience on those intel drivers, this
> clock driver and rational algorithm driver and you probably have intel
> HWs to test.  May I encourage you to look into this and decouple the
> prescaler knowledge out :-)
>
> >
> > Thanks for review and you review of v2 is warmly welcomed!
>
> I'd like to see patches to decouple the prescaler knowledge out.

Then produce them! Currently the code works for all its users and does
not need any changes (documentation is indeed a gap).

> V2, like v1, tries to consolidate the knowledge in this fractional
> divider clk driver. So, not the right direction I think.

Then why are you commenting here and not there? :-)
I think I would drop patch 2 from the set (patch 1 is Acked and patch
3 is definitely needed to describe current state of affairs) on the
grounds of the comments.

-- 
With Best Regards,
Andy Shevchenko

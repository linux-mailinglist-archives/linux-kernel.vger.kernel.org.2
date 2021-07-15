Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D523C9A56
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 10:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240627AbhGOISV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 04:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbhGOIST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 04:18:19 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831C5C06175F;
        Thu, 15 Jul 2021 01:15:26 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c15so2783767pls.13;
        Thu, 15 Jul 2021 01:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rKH5yIjq0jJFltXOeJaynJubsDFRTimc5RpOqZh+T3A=;
        b=FT3IQsooQviFEYlQhzJ1Nz5dBfogA5d06q93ipnt5O/KIYUdH5fF7hdbjFfSoeZytI
         erwryLvbsav+2I7WNXPSgnxD/qWLRMTKrDgI96Rc/dU9d0fibp9giZR14coM2IIYmRSI
         mn4Q/D0NXwotgQTPF6rFTkbOptvASFgQ9odJmeRJQA8kfK8Z85wNync/KLEUivgvUd2m
         4nhsbF4sRihC/WI9WeeIEq4GGKD9y4A65EPQvMZ2y1jKu/18MB68zV6T6JOb5vu6Z3dR
         8UAs5aK1DHRk1E9c9sDfEzb8xgmBSkW3GL/jNbfYTHGS6c1ISNGh8Uw1JPUF0kshhNtH
         J8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rKH5yIjq0jJFltXOeJaynJubsDFRTimc5RpOqZh+T3A=;
        b=jAhKhQeR782Vt1cbwz0No4x8vJXnzMnfC6w8+1uric+BOkgvQ57A3gp2WBUAq71xKu
         VBdv5c0NbAzkw53/BpKcGSB4vRUjtcefUxMrM37OImiE9boY5JJT8Ahee8mrcBfxW2mC
         +88QmrB9vR4CcSbXuHHDeIv/62DBqNlFUFEC3x8O0HxYtvRSI6jDOvObw+9481TYGEv/
         t42cuT4/JJiqQwax8t7m5WMAvIpLzNO+A5K7dJlr9hat/rFBC2fsCuzVZv7jgBqucB9Y
         TV1tKsNtmF8Div44ftlMCj8bPHAnLjuHmzvLXI/gQwnWhgAX/g0CLjDQA8HzTFiiRPNB
         a9qA==
X-Gm-Message-State: AOAM531mRSnStXkOAKGWA7WodGgppOLOOoIsiOTAd1cCrN4B2UPXUcWs
        yfcWqoy19d/JGG6Hc6szDoViv/RgrbTB7YZ3N34=
X-Google-Smtp-Source: ABdhPJzIqYSecEpzXpgWGN9+q/4BKqqWPcPHri/IHKkfOYQiHjgrCnDPRtUhckwsZzvsFfuirjvZSdysSLCvFws/wb8=
X-Received: by 2002:a17:90b:1194:: with SMTP id gk20mr4135216pjb.181.1626336926028;
 Thu, 15 Jul 2021 01:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210714064129.1321277-1-victor.liu@nxp.com> <YO6qfQMcvr9szZTJ@smile.fi.intel.com>
 <1f1b38f9c42093bea5e6a8ccb458bdf799069157.camel@nxp.com> <YO6+nkzDlNM/KJio@smile.fi.intel.com>
 <YO7AcaHyB8js9FJg@smile.fi.intel.com> <0ae047e216298e6239e39ec40a2d545ac07a7406.camel@nxp.com>
 <CAHp75VfHuBJAYqms0tx_y3qjFfJJ_ynCOkbeYchBY0CvDJBp=Q@mail.gmail.com>
In-Reply-To: <CAHp75VfHuBJAYqms0tx_y3qjFfJJ_ynCOkbeYchBY0CvDJBp=Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 15 Jul 2021 11:14:49 +0300
Message-ID: <CAHp75VfFx4eDF484QKXgB=rhu3AptnDvX+2C+qd+U_3atfjnjQ@mail.gmail.com>
Subject: Re: [RFC PATCH] clk: fractional-divider: Correct max_{m,n} handed
 over to rational_best_approximation()
To:     Liu Ying <victor.liu@nxp.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 11:02 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Jul 15, 2021 at 8:51 AM Liu Ying <victor.liu@nxp.com> wrote:
> > On Wed, 2021-07-14 at 13:46 +0300, Andy Shevchenko wrote:
> > > On Wed, Jul 14, 2021 at 01:38:22PM +0300, Andy Shevchenko wrote:
> > > > On Wed, Jul 14, 2021 at 06:10:46PM +0800, Liu Ying wrote:
> > > > > On Wed, 2021-07-14 at 12:12 +0300, Andy Shevchenko wrote:
> > > > > > On Wed, Jul 14, 2021 at 02:41:29PM +0800, Liu Ying wrote:
> > > >
> > > > ...
> > > >
> > > > > > > /*
> > > > > > >  * Get rate closer to *parent_rate to guarantee there is no overflow
> > > > > > >  * for m and n. In the result it will be the nearest rate left shifted
> > > > > > >  * by (scale - fd->nwidth) bits.
> > > > > > >  */
> > > > > >
> > > > > > I don't know how to rephrase above comment better.
> > > > > >
> > > > > > > scale = fls_long(*parent_rate / rate - 1);
> > > > > > > if (scale > fd->nwidth)
> > > > > > >       rate <<= scale - fd->nwidth;
> > > > > >
> > > > > > This takes an advantage of the numbers be in a form of
> > > > > >
> > > > > >         n = k * 2^m, (1)
> > > > > >
> > > > > > where m will be scale in the snippet above. Thus, if n can be represented by
> > > > > > (1), we opportunistically reduce amount of bits needed for it by shifting right
> > > > > > by m bits.
> > > > > > Does it make sense?
> > > > >
> > > > > Thanks for your explaination.
> > > > > But, sorry, Jacky and I still don't understand this.
> > >
> > > It seems I poorly chose the letters for (1). Let's rewrite above as
> > >
> > > This takes an advantage of the numbers be in a form of
> > >
> > >       a = k * 2^b, (1)
> > >
> > > where b will be scale in the snippet above. Thus, if a can be represented by
> > > (1), we opportunistically reduce amount of bits needed for it by shifting right
> > > by b bits.
> > >
> > > Also note, "shifting right" here is about the result of n (see below).
> > >
> > > > Okay, We have two values in question:
> > > >  r_o (original rate of the parent clock)
> > > >  r_u (the rate user asked for)
> > > >
> > > > We have a pre-scaler block which asks for
> > > >  m (denominator)
> > > >  n (nominator)
> > > > values to be provided to satisfy the (2)
> > > >
> > > >     r_u ~= r_o * m / n, (2)
> > > >
> > > > where we try our best to make it "=" instead of "~=".
> > > >
> > > > Now, m and n have the limitation by a range, e.g.
> > > >
> > > >     n >= 1, n < N_lim, where N_lim = 2^nlim. (3)
> > > >
> > > > Hence, from (2) and (3), assuming the worst case m = 1,
> > > >
> > > >     ln2(r_o / r_u) <= nlim. (4)
> > > >
> > > > The above code tries to satisfy (4).
> > > >
> > > > Have you got it now?
> >
> > I'm afraid I haven't, sorry. Jacky, what about you?
>
> You may take a pen and paper and model different cases. After all it's
> not rocket science, just arithmetics :-)
>
> > Is that snippet really needed?
>
> Yes. The (4)  shows why.

Now I realize one more item which is missed in the big picture.
When we have overflowed the denominator (n) and shifted the values, we
are expecting that the caller will check the rate and use another
2^scale (see (6) below) prescaler if needed to drop frequency to the
needed values. The first few users of this were the drivers of the IPs
which have an additional prescaler themselves. I dunno if there is any
flag in CCF to show that the set frequency is 2^scale higher than
asked.

It means if

        r_o / r_u >> N_lim (5)

we will get m and n *saturated* without this snipped, while with it
they will be much much better with a nuance that resulting frequency
is shifted left by

        scale = ln2(r_o/r_u) - nlim (6)

scale bits.

> > Without that snippet, it seems that rational_best_approximation() is
> > able to offer best_numerator and best_denominator without the risk of
> > overflow for m and n, since max_numerator and max_denominator are
> > already handed over to rational_best_approximation()?
>
> No.
>
> > Does rational_best_approximation() always offer best_numerator by the
> > range of [1, max_numerator] and best_denominator [1, max_denominator]?
>
> Of course not, when it goes out of the range.

> > > > > > The code looks good to me, btw, although I dunno if you need to call the newly
> > > > > > introduced function before or after the above mentioned snippet.
> > > > >
> > > > > Assuming that snippet is fully orthogonal to this patch, then it
> > > > > doesn't matter if it's before or after.
> > > >
> > > > Please, double check this. Because you play with limits, while we expect them
> > > > to satisfy (3).

-- 
With Best Regards,
Andy Shevchenko

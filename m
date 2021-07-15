Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAC73C9A11
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 10:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238428AbhGOIFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 04:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhGOIFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 04:05:50 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194BFC06175F;
        Thu, 15 Jul 2021 01:02:58 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g4-20020a17090ace84b029017554809f35so5459821pju.5;
        Thu, 15 Jul 2021 01:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1pKUusKUmF9NNKcCMMGNxkZBMtZ72m760G1DqfW+IwE=;
        b=s4MAqQpKgoeB/unBUesPsWvW+zbRem/vhJYZzfNernf5m+tmDkI2yzbinkLSSGEi7K
         L65OMQkBhv2FZI9qqSHLl5Z1HCV5e24HHKnagP6zMqQzmx667FavhSw3NkAdl2O2fTlK
         myOcRpkWrTwJ1/GyW107s9msWuabcHq8+mIyA98UBCJoIK4t46OeK0QDF0rh2xuubkE4
         0IR5kvE5l1yntsFFg8b9+ro29r76ONhTkDaY61VuTORQobasU7HGmKLsnYvggQogDSzP
         qr0B2cDzSc4k0S1rCeX95H7pWIy8MFxNFiC/o9rjgDymxz74f8J36AyaYbzpQlM/d6cl
         vXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1pKUusKUmF9NNKcCMMGNxkZBMtZ72m760G1DqfW+IwE=;
        b=g1BhYaiHF0ZLiOIP6HFMqL3cWwwWRq1nYh56lU3DcQDBIKt7WAsFlnERzRc4C7YE/K
         lButlLx0Qy8VLo69n6pQchQ2sC5w2BOQyWN9Fwx8UJgemitkvjCWwaTuLMOz9nRZg4c7
         OAHUSEWiMXN8lgYp/QpELB8v4Rt44KQvXe5MUdupSGOVFnLtxHbzVEu6pBmDIiLbHzHO
         hWIstXusS0c1ts0A0XDD4EkxeGsspDm6mhsuE++JOvt2DRZfbt8Tc+GVFA5hee72uC5T
         taTuMmH02hg401csEjyp7yaviTIJKNAG79lP0GmOwXtcaIQXYk+LszO0E3X5ZfrwrXVo
         mejA==
X-Gm-Message-State: AOAM5323Z2Fo/UFZb8RtdrZ6D3tVm/8tmpIe3+FHJ9zgurYoFzcScVZ5
        HSgcf85jF4j8jrfUtYxOcpoyAVBzYrgnnDslqjk=
X-Google-Smtp-Source: ABdhPJxHjtMehseTq+QJqdyaXXkyAPUPORzl2UfLXjHieckrpiRM+DWqqgjecBTnYDwkBa+KKQaVK+DSUnKE4yerkkE=
X-Received: by 2002:a17:903:3005:b029:12b:54cf:c513 with SMTP id
 o5-20020a1709033005b029012b54cfc513mr2203345pla.21.1626336177467; Thu, 15 Jul
 2021 01:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210714064129.1321277-1-victor.liu@nxp.com> <YO6qfQMcvr9szZTJ@smile.fi.intel.com>
 <1f1b38f9c42093bea5e6a8ccb458bdf799069157.camel@nxp.com> <YO6+nkzDlNM/KJio@smile.fi.intel.com>
 <YO7AcaHyB8js9FJg@smile.fi.intel.com> <0ae047e216298e6239e39ec40a2d545ac07a7406.camel@nxp.com>
In-Reply-To: <0ae047e216298e6239e39ec40a2d545ac07a7406.camel@nxp.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 15 Jul 2021 11:02:21 +0300
Message-ID: <CAHp75VfHuBJAYqms0tx_y3qjFfJJ_ynCOkbeYchBY0CvDJBp=Q@mail.gmail.com>
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

On Thu, Jul 15, 2021 at 8:51 AM Liu Ying <victor.liu@nxp.com> wrote:
> On Wed, 2021-07-14 at 13:46 +0300, Andy Shevchenko wrote:
> > On Wed, Jul 14, 2021 at 01:38:22PM +0300, Andy Shevchenko wrote:
> > > On Wed, Jul 14, 2021 at 06:10:46PM +0800, Liu Ying wrote:
> > > > On Wed, 2021-07-14 at 12:12 +0300, Andy Shevchenko wrote:
> > > > > On Wed, Jul 14, 2021 at 02:41:29PM +0800, Liu Ying wrote:
> > >
> > > ...
> > >
> > > > > > /*
> > > > > >  * Get rate closer to *parent_rate to guarantee there is no overflow
> > > > > >  * for m and n. In the result it will be the nearest rate left shifted
> > > > > >  * by (scale - fd->nwidth) bits.
> > > > > >  */
> > > > >
> > > > > I don't know how to rephrase above comment better.
> > > > >
> > > > > > scale = fls_long(*parent_rate / rate - 1);
> > > > > > if (scale > fd->nwidth)
> > > > > >       rate <<= scale - fd->nwidth;
> > > > >
> > > > > This takes an advantage of the numbers be in a form of
> > > > >
> > > > >         n = k * 2^m, (1)
> > > > >
> > > > > where m will be scale in the snippet above. Thus, if n can be represented by
> > > > > (1), we opportunistically reduce amount of bits needed for it by shifting right
> > > > > by m bits.
> > > > > Does it make sense?
> > > >
> > > > Thanks for your explaination.
> > > > But, sorry, Jacky and I still don't understand this.
> >
> > It seems I poorly chose the letters for (1). Let's rewrite above as
> >
> > This takes an advantage of the numbers be in a form of
> >
> >       a = k * 2^b, (1)
> >
> > where b will be scale in the snippet above. Thus, if a can be represented by
> > (1), we opportunistically reduce amount of bits needed for it by shifting right
> > by b bits.
> >
> > Also note, "shifting right" here is about the result of n (see below).
> >
> > > Okay, We have two values in question:
> > >  r_o (original rate of the parent clock)
> > >  r_u (the rate user asked for)
> > >
> > > We have a pre-scaler block which asks for
> > >  m (denominator)
> > >  n (nominator)
> > > values to be provided to satisfy the (2)
> > >
> > >     r_u ~= r_o * m / n, (2)
> > >
> > > where we try our best to make it "=" instead of "~=".
> > >
> > > Now, m and n have the limitation by a range, e.g.
> > >
> > >     n >= 1, n < N_lim, where N_lim = 2^nlim. (3)
> > >
> > > Hence, from (2) and (3), assuming the worst case m = 1,
> > >
> > >     ln2(r_o / r_u) <= nlim. (4)
> > >
> > > The above code tries to satisfy (4).
> > >
> > > Have you got it now?
>
> I'm afraid I haven't, sorry. Jacky, what about you?

You may take a pen and paper and model different cases. After all it's
not rocket science, just arithmetics :-)

> Is that snippet really needed?

Yes. The (4)  shows why.

> Without that snippet, it seems that rational_best_approximation() is
> able to offer best_numerator and best_denominator without the risk of
> overflow for m and n, since max_numerator and max_denominator are
> already handed over to rational_best_approximation()?

No.

> Does rational_best_approximation() always offer best_numerator by the
> range of [1, max_numerator] and best_denominator [1, max_denominator]?

Of course not, when it goes out of the range.

> > > > > The code looks good to me, btw, although I dunno if you need to call the newly
> > > > > introduced function before or after the above mentioned snippet.
> > > >
> > > > Assuming that snippet is fully orthogonal to this patch, then it
> > > > doesn't matter if it's before or after.
> > >
> > > Please, double check this. Because you play with limits, while we expect them
> > > to satisfy (3).


-- 
With Best Regards,
Andy Shevchenko

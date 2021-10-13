Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D9A42C5FE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 18:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhJMQSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhJMQSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:18:08 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A3AC061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 09:16:04 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id q13so5617283uaq.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 09:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/7Qx+OEie0gSqWlYizjczzNQI5RdPd4gS+f9DE5RC6M=;
        b=TAtmebWqDtsQvSj+wedbdKfw3KfJtU64Hvm670jPpDvO3ubBmLUbBPvxtkljTv2hq3
         Q4tsKzTuw5c92sL2UX4ka8DUwbrMWmRQOA//9Evz8J9UBdyqO2R/vj0V7fMnbtkfEgTG
         mu2hg8osTOlkv4FRFtvGPyNzsOdEXPP5KLpZRrpdVlLCU7vSeAs+NhcJOTw2weBGZDx/
         XvzlA1qALhJY6uQbB+36hzvInSWa24Z/6JjnoZB714QgHZG65RUbKYbnKSzTOgh8bMT9
         EW+1bHKnXxUX7X3rs3XgJs2OAgofQej6mHcAQ20pt03ry0raINMZFWk++vhJeh3h/Y7C
         tOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/7Qx+OEie0gSqWlYizjczzNQI5RdPd4gS+f9DE5RC6M=;
        b=xvZQOjQMcHqQUYQU7mY2yzlqTEq3c/kLgtVxiObJSpbaSmuViO8YQw/uctEtoDvOOK
         wVZwJScYdyhRb952ItcT/yu42ya258RiMi5y1sjHZ+PRrCiXQaNg/jU40KpplRRT+Vaq
         p7eDOH4AaJ43Lg1Jfd5If6wtTGnDJoG5zMvjTDy3SXxsYusUjirxVcJdQbBA5SczpcOn
         6Nu+fKn86S+rFlyr8lMuHQcKnr2676IlkLUNt3ZN9nD8fao7Tx0QRrfl97Z9R1coxcU8
         ZPHcPh4haUeXySNkpZtD+9GtRJdqdjAPvnujQLa0iZpIIv8AktqgeWY7YWOjy5aUw9U4
         w7pw==
X-Gm-Message-State: AOAM533l5DZldknROIcBL/WWGKxhGMvfv3ZU2+zsY6qJg2d4bLIrW5Tm
        hfHjUYGh11Ce3d9ICKKJGi8wlKNCUnVE1K3mPqzC4w==
X-Google-Smtp-Source: ABdhPJyfSYIbD8ITgTHO+mQ9LRzqMdotK/9M8dbpk0/XiAyMyu2t1w5t0fhujSmZVsYezQYhVjSZR+QuaM6VB2HuUtU=
X-Received: by 2002:a67:1781:: with SMTP id 123mr38953015vsx.1.1634141762897;
 Wed, 13 Oct 2021 09:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211007182158.7490-1-semen.protsenko@linaro.org>
 <YWXaKevf8D0kKYXo@smile.fi.intel.com> <CAPLW+4==u6Lpi-tRpGCFjuCBUARsarJx=Lg2QVAbvXX7hOyRVg@mail.gmail.com>
 <YWbaHtQpVyrrGm0k@smile.fi.intel.com>
In-Reply-To: <YWbaHtQpVyrrGm0k@smile.fi.intel.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 13 Oct 2021 19:15:51 +0300
Message-ID: <CAPLW+4ke431EN2A-WqA_h-Rk+y1ccm2pu2Dhvx2-rRtZc6ad7w@mail.gmail.com>
Subject: Re: [PATCH v5] clk: Add write operation for clk_parent debugfs node
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mike Tipton <mdtipton@codeaurora.org>,
        Andy Shevchenko <andy@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2021 at 16:07, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Oct 13, 2021 at 02:35:48PM +0300, Sam Protsenko wrote:
> > On Tue, 12 Oct 2021 at 21:55, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Oct 07, 2021 at 09:21:58PM +0300, Sam Protsenko wrote:
>
> ...
>
> > > > +#ifdef CLOCK_ALLOW_WRITE_DEBUGFS
> > > > +     if (core->num_parents > 1)
> > > > +             debugfs_create_file("clk_parent", 0644, root, core,
> > > > +                                 &current_parent_rw_fops);
> > > > +     else
> > > > +#endif
> > >
> > > > +     {
> > > > +             if (core->num_parents > 0)
> > > > +                     debugfs_create_file("clk_parent", 0444, root, core,
> > > > +                                         &current_parent_fops);
> > > > +     }
> > >
> > > Currently there is no need to add the {} along with increased indentation
> > > level. I.o.w. the 'else if' is valid in C.
> >
> > Without those {} we have two bad options:
> >
> >   1. When putting subsequent 'if' block on the same indentation level
> > as 'else': looks ok-ish for my taste (though inconsistent with #ifdef
> > code) and checkpatch swears:
> >
> >         WARNING: suspect code indent for conditional statements (8, 8)
> >         #82: FILE: drivers/clk/clk.c:3334:
> >         +    else
> >         [...]
> >              if (core->num_parents > 0)
>
> >   2. When adding 1 additional indentation level for subsequent 'if'
> > block: looks plain ugly to me, inconsistent for the case when
> > CLOCK_ALLOW_WRITE_DEBUGFS is not defined, but checkpatch is happy
> >
> > I still think that the way I did that (with curly braces) is better
> > one: it's consistent for all cases, looking ok, checkpatch is happy
> > too. But isn't it hairsplitting? This particular case is not described
> > in kernel coding style doc, so it's about personal preferences.
> >
> > If it's still important to you -- please provide exact code snippet
> > here (with indentations) for what you desire, I'll send v6. But
> > frankly I'd rather spend my time on something more useful. This is
> > minor patch, and I don't see any maintainers wishing to pull it yet.
>
> I meant
>
> #ifdef CLOCK_ALLOW_WRITE_DEBUGFS
>         if (core->num_parents > 1)
>                 debugfs_create_file("clk_parent", 0644, root, core,
>                                     &current_parent_rw_fops);
>         else
> #endif
>         if (core->num_parents > 0)
>                 debugfs_create_file("clk_parent", 0444, root, core,
>                                     &current_parent_fops);
>
> But after looking at the present code, this variant is occurred 5x-10x
> times less. So, only nit-picks then (note additional {} along with no
> blank line):
>
> #ifdef CLOCK_ALLOW_WRITE_DEBUGFS
>         if (core->num_parents > 1) {
>                 debugfs_create_file("clk_parent", 0644, root, core,
>                                     &current_parent_rw_fops);
>         } else
> #endif
>         {
>                 if (core->num_parents > 0)
>                         debugfs_create_file("clk_parent", 0444, root, core,
>                                             &current_parent_fops);
>         }
>

No problem, will add those {} in v6.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>

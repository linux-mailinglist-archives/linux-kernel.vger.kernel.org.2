Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC03842C752
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 19:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbhJMRPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 13:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhJMRP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 13:15:28 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E4EC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:13:24 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id u5so5869266uao.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FqK/jWK79PuifDKA1/UfvqVKqumXLq/7p6XMlR8ggyA=;
        b=MAEKzS3+RMUT1I7/97OKNNhT+hVWFG4OM53Pe/WUzd4eT3GOMZcPsQQmJCR8aFQSRy
         /f8Z9lVDXi9aEnkr/x3Tm+QYLfyW1fKkcXRHbOrrH6G9NXQgkrm3ZlL3gi5jBIXGnT/5
         4xFYj9egElMU7OI4G1UeAFz/Hpd3WKNUz3LHQ4QmqkYrfqbB5vUs1ao5sYkEUdVVx790
         xrNFHyqMCq2ICTlkh+X7wYGzIXl5d0AHPHq+02HIfKczyllEdjFF2Y1hdLi/aX8Dph+a
         CvKKxuW753lK6huHPr9YTFJpD4DE47bn+3PDoUVfyhzVxiv8Ggc+3wlN/gJxeHs8GrKt
         jw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FqK/jWK79PuifDKA1/UfvqVKqumXLq/7p6XMlR8ggyA=;
        b=4JiXNwMTUDLcE0PKor4hokngmT98AohI4tAaj+Rzd/X2V1NVVSwBxjM1FriuLDgksJ
         81/xs8OBnNGCqRl8NqWMki4AG7/j6OAMiNDqAqKbRT+Oa8XN4D/lzxyGhuDYgu4CNgB6
         2wEMQk+2cQazMPE7J1KqC7xQELzATg/UyT8XQMrVGjskxfy2/wUCBY5XtPLoDZVvqP2C
         FkbWzDenxWu96NWPY+swJeJL+HbbHIIIHC1RLgLP5N0vFC8em5gwRisDB0RRBLvafwyH
         BVoTe/ZMR/uSN15arxploXc2EptcwDdbkT7A6HHEN7PUs/R+oQ3M+w5qqrkt+NmW7D/V
         ydDw==
X-Gm-Message-State: AOAM5334wa5l4T15UNy654rP6r5mQr0zuM2CD/LpSKXmQkSybOlITbak
        NIGIJD5CEfka9YQWR6TdW1bmh+r3KawHMPAJKkw10Q==
X-Google-Smtp-Source: ABdhPJzvE1QVPK3BjPqCjduwVBx7y3jvdvgME1PG0alC7Qswg1nyX8kkTyqACtDHadH5YqzcixhuWS8DfQTSd+fVD8A=
X-Received: by 2002:a67:d289:: with SMTP id z9mr308540vsi.39.1634145203777;
 Wed, 13 Oct 2021 10:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211007182158.7490-1-semen.protsenko@linaro.org>
 <YWXaKevf8D0kKYXo@smile.fi.intel.com> <CAPLW+4==u6Lpi-tRpGCFjuCBUARsarJx=Lg2QVAbvXX7hOyRVg@mail.gmail.com>
 <CAMuHMdXmp5qngW9XKSzFwBGMQs4YduQbw3zxDfSAjho_deMjaQ@mail.gmail.com> <CAPLW+4muEHPijg2yZJ-gu--6Sbg9DvTeSz5QcwOR+eAVniczyA@mail.gmail.com>
In-Reply-To: <CAPLW+4muEHPijg2yZJ-gu--6Sbg9DvTeSz5QcwOR+eAVniczyA@mail.gmail.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 13 Oct 2021 20:13:11 +0300
Message-ID: <CAPLW+4=dK400WSFaBS_TGOTypCY9oWnDWS3xBp22b5n-ae=R-w@mail.gmail.com>
Subject: Re: [PATCH v5] clk: Add write operation for clk_parent debugfs node
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mike Tipton <mdtipton@codeaurora.org>,
        Andy Shevchenko <andy@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2021 at 19:30, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> On Wed, 13 Oct 2021 at 16:08, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> >   Hi Sam,
> >
> > On Wed, Oct 13, 2021 at 1:36 PM Sam Protsenko
> > <semen.protsenko@linaro.org> wrote:
> > > On Tue, 12 Oct 2021 at 21:55, Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Thu, Oct 07, 2021 at 09:21:58PM +0300, Sam Protsenko wrote:
> > > > > Useful for testing mux clocks. One can write the index of the parent to
> > > > > be set into clk_parent node, starting from 0. Example
> > > > >
> > > > >     # cd /sys/kernel/debug/clk/mout_peri_bus
> > > > >     # cat clk_possible_parents
> > > > >       dout_shared0_div4 dout_shared1_div4
> > > > >     # cat clk_parent
> > > > >       dout_shared0_div4
> > > > >     # echo 1 > clk_parent
> > > > >     # cat clk_parent
> > > > >       dout_shared1_div4
> > > > >
> > > > > CLOCK_ALLOW_WRITE_DEBUGFS has to be defined in drivers/clk/clk.c in
> > > > > order to use this feature.
> > > >
> > > > ...
> > > >
> > > > > +#ifdef CLOCK_ALLOW_WRITE_DEBUGFS
> > > > > +     if (core->num_parents > 1)
> > > > > +             debugfs_create_file("clk_parent", 0644, root, core,
> > > > > +                                 &current_parent_rw_fops);
> > > > > +     else
> > > > > +#endif
> > > >
> > > > > +     {
> > > > > +             if (core->num_parents > 0)
> > > > > +                     debugfs_create_file("clk_parent", 0444, root, core,
> > > > > +                                         &current_parent_fops);
> > > > > +     }
> > > >
> > > > Currently there is no need to add the {} along with increased indentation
> > > > level. I.o.w. the 'else if' is valid in C.
> > >
> > > Without those {} we have two bad options:
> > >
> > >   1. When putting subsequent 'if' block on the same indentation level
> > > as 'else': looks ok-ish for my taste (though inconsistent with #ifdef
> > > code) and checkpatch swears:
> > >
> > >         WARNING: suspect code indent for conditional statements (8, 8)
> > >         #82: FILE: drivers/clk/clk.c:3334:
> > >         +    else
> > >         [...]
> > >              if (core->num_parents > 0)
> > >
> > >   2. When adding 1 additional indentation level for subsequent 'if'
> > > block: looks plain ugly to me, inconsistent for the case when
> > > CLOCK_ALLOW_WRITE_DEBUGFS is not defined, but checkpatch is happy
> > >
> > > I still think that the way I did that (with curly braces) is better
> > > one: it's consistent for all cases, looking ok, checkpatch is happy
> > > too. But isn't it hairsplitting? This particular case is not described
> > > in kernel coding style doc, so it's about personal preferences.
> > >
> > > If it's still important to you -- please provide exact code snippet
> > > here (with indentations) for what you desire, I'll send v6. But
> > > frankly I'd rather spend my time on something more useful. This is
> > > minor patch, and I don't see any maintainers wishing to pull it yet.
> >
> > Note that checkpatch is just a tool, providing advice. It is not perfect,
> > and if there is a good reason to ignore it, I'm all for that.
> >
>
> Agreed. Actually I did the same grepping as Andy mentioned in previous
> mails, and used that style because that's what other people often do.
> checkpatch is more like excuse for me in this case :)
>
> > Personally, I would write:
> >
> >     #ifdef CLOCK_ALLOW_WRITE_DEBUGFS
> >             if (core->num_parents > 1)
> >                     debugfs_create_file("clk_parent", 0644, root, core,
> >                                         &current_parent_rw_fops);
> >             else
> >     #endif
> >             if (core->num_parents > 0)
> >                     debugfs_create_file("clk_parent", 0444, root, core,
> >                                         &current_parent_fops);
> >             }
> >
>

Actually... After considering all options and looking at actual diff,
I'll go with that option: looks least cluttered, and the delta is
really minimal.

> That looks good to me. But I'd keep it as is, if you don't have a
> strong opinion about this: looks better with braces, because it's
> multi-line blocks (although physically and not semantically).
>
> > Then, I'm wondering if it really is worth it to have separate cases for
> > "num_parents> 1" and "num_parents > 0".  If there's a single parent,
> > current_parent_write() should still work fine with "0", wouldn't it?
> > Then the only differences are the file mode and the fops.
> > You could handle that with #defines above, like is currently done for
> > clk_rate_mode.  And the checkpatch issue is gone ;-)
> >
>
> I considered such case. But it would be inconsistent with this already
> existing code:
>
>     if (core->num_parents > 1)
>         debugfs_create_file("clk_possible_parents", 0444, root, core,
>                     &possible_parents_fops);
>
> Because user would probably want to use both 'clk_parent' and
> 'clk_possible_parents' together (e.g. see my example in commit
> message). From logical point of view, I designed that code for testing
> MUX clocks, and I doubt there are any MUXes with only one parent
> (input signal). So I'd like to keep this logic as is, if you don't
> mind, even though it might appear bulky.
>
> So for v6 I'm going to go exactly with what Andy suggested, hope it's
> fine with you?
>
> > Gr{oetje,eeting}s,
> >
> >                         Geert
> >
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> >
> > In personal conversations with technical people, I call myself a hacker. But
> > when I'm talking to journalists I just say "programmer" or something like that.
> >                                 -- Linus Torvalds

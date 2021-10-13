Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F99742C66B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 18:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbhJMQcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235623AbhJMQcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:32:47 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C383C061749
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 09:30:43 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id u5so5589160uao.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 09:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RQVZgR9vR5gKO2AWmj0QSl4XKIORrQl7GMS2ORJmghU=;
        b=zxfyt4ljWth1az70Crk7yJesWaR+pVM+xVX/MS4b63MGjSZtFKPF0GmXW0+rlIXaKN
         HkM/735csrWOVj1moVP9RDxwTpkNdGq4kGTJtKlez9c/4qbkLuhb0EOY81VWKNm/bmhG
         JsxH4C5HsTUzafo4yOREq4XZC5ry1jUhOHlXrYmbW4kad+VE3d+OlHXY6XKpE4oyA+FQ
         oAJhu1mQXLwqTRyh7RUfpXAEsQmF5Z1ITGQ4mucaq8/ZCXV7Cyb2v62/xnYZV023FyLy
         DEf3FWIoSDabfTa4SmXP1H1FWYwKs4PnXFBzcgCkHtWQGcZCIVCvculhijmvSpPSUgZn
         0r6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RQVZgR9vR5gKO2AWmj0QSl4XKIORrQl7GMS2ORJmghU=;
        b=rvCpJxB9E4yccmd2Je+hjPdhP03quZLzkowYtqsXK39Yj9QlxsEoG4y2ATMbcSZAJV
         7Gvmvz2dN9A8yFltAgJDf4VuvlKO5Qlf/PrpJsq7iKbPxsS2rZMfjBX2KPLgLgBr9c7m
         ukYjHq6UrF2/1nRuH85+6fxEbWekhN76zr7cvkxlflDmjSNE0+5PBquSRd7Q5dBN5Nkn
         hWzlnYD6yZrDl0sgEE5Q4YImopRHX7TPUOeO/M9YdnPI/al6WV3UhroEx6hlcWhFnhGE
         2o8GgXo7Ab/n0ArIq6rD/YnDPQs2u+YOdKgDFP27RU1twX+B1r7SU+p3YNT/cXS5Tdyl
         Pojw==
X-Gm-Message-State: AOAM53186Im/2gp68xg1/Ty0K3JlMnf4YuD0DPX/7dDUZuQShxB9SY5D
        SAqkMFtDMH+vf/b2Fa1/uMEhoz+ak7lKzQ49zpVMJQ==
X-Google-Smtp-Source: ABdhPJzGhkcqE/GkhFMVy6YeXIKi4m6UCC2DYgFhtgkoyPTMvCwCh//cxIFWrFeNNl0kY2Ye7K2FWrROTiIx5gIA5hQ=
X-Received: by 2002:a67:ed5a:: with SMTP id m26mr6766vsp.35.1634142642361;
 Wed, 13 Oct 2021 09:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211007182158.7490-1-semen.protsenko@linaro.org>
 <YWXaKevf8D0kKYXo@smile.fi.intel.com> <CAPLW+4==u6Lpi-tRpGCFjuCBUARsarJx=Lg2QVAbvXX7hOyRVg@mail.gmail.com>
 <CAMuHMdXmp5qngW9XKSzFwBGMQs4YduQbw3zxDfSAjho_deMjaQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXmp5qngW9XKSzFwBGMQs4YduQbw3zxDfSAjho_deMjaQ@mail.gmail.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 13 Oct 2021 19:30:30 +0300
Message-ID: <CAPLW+4muEHPijg2yZJ-gu--6Sbg9DvTeSz5QcwOR+eAVniczyA@mail.gmail.com>
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

On Wed, 13 Oct 2021 at 16:08, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
>   Hi Sam,
>
> On Wed, Oct 13, 2021 at 1:36 PM Sam Protsenko
> <semen.protsenko@linaro.org> wrote:
> > On Tue, 12 Oct 2021 at 21:55, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Oct 07, 2021 at 09:21:58PM +0300, Sam Protsenko wrote:
> > > > Useful for testing mux clocks. One can write the index of the parent to
> > > > be set into clk_parent node, starting from 0. Example
> > > >
> > > >     # cd /sys/kernel/debug/clk/mout_peri_bus
> > > >     # cat clk_possible_parents
> > > >       dout_shared0_div4 dout_shared1_div4
> > > >     # cat clk_parent
> > > >       dout_shared0_div4
> > > >     # echo 1 > clk_parent
> > > >     # cat clk_parent
> > > >       dout_shared1_div4
> > > >
> > > > CLOCK_ALLOW_WRITE_DEBUGFS has to be defined in drivers/clk/clk.c in
> > > > order to use this feature.
> > >
> > > ...
> > >
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
> >
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
> Note that checkpatch is just a tool, providing advice. It is not perfect,
> and if there is a good reason to ignore it, I'm all for that.
>

Agreed. Actually I did the same grepping as Andy mentioned in previous
mails, and used that style because that's what other people often do.
checkpatch is more like excuse for me in this case :)

> Personally, I would write:
>
>     #ifdef CLOCK_ALLOW_WRITE_DEBUGFS
>             if (core->num_parents > 1)
>                     debugfs_create_file("clk_parent", 0644, root, core,
>                                         &current_parent_rw_fops);
>             else
>     #endif
>             if (core->num_parents > 0)
>                     debugfs_create_file("clk_parent", 0444, root, core,
>                                         &current_parent_fops);
>             }
>

That looks good to me. But I'd keep it as is, if you don't have a
strong opinion about this: looks better with braces, because it's
multi-line blocks (although physically and not semantically).

> Then, I'm wondering if it really is worth it to have separate cases for
> "num_parents> 1" and "num_parents > 0".  If there's a single parent,
> current_parent_write() should still work fine with "0", wouldn't it?
> Then the only differences are the file mode and the fops.
> You could handle that with #defines above, like is currently done for
> clk_rate_mode.  And the checkpatch issue is gone ;-)
>

I considered such case. But it would be inconsistent with this already
existing code:

    if (core->num_parents > 1)
        debugfs_create_file("clk_possible_parents", 0444, root, core,
                    &possible_parents_fops);

Because user would probably want to use both 'clk_parent' and
'clk_possible_parents' together (e.g. see my example in commit
message). From logical point of view, I designed that code for testing
MUX clocks, and I doubt there are any MUXes with only one parent
(input signal). So I'd like to keep this logic as is, if you don't
mind, even though it might appear bulky.

So for v6 I'm going to go exactly with what Andy suggested, hope it's
fine with you?

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

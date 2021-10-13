Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2411D42C0FF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbhJMNKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:10:53 -0400
Received: from mail-ua1-f46.google.com ([209.85.222.46]:34535 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbhJMNKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:10:52 -0400
Received: by mail-ua1-f46.google.com with SMTP id h4so4381691uaw.1;
        Wed, 13 Oct 2021 06:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e70ZGQ5tbBAmM8hpsBFgeuMrXUs03WqPhKmll1O0FNQ=;
        b=SZSttMG6wBT/sBuZHH/vbgJkn0Xfmp9f0Uau3YKtJT3M4R5llbhLH/TIAZc+rH/6hV
         oRIUlSuSn2wLqmcRjXLumIPGfZLfUGPaH1YjcU9muS9cEGJc5PPlbzB0ubzzAxJSHsuQ
         bGGxsjcumN4dMPVCfjWRxkFG/WsJfNZ5oO5N/0urlv3Jvq232S8qu+GaSJGp/hxv/+hr
         FDf6uyWjaUAH0IZUItaUemtasXx1/kPSBldSTLQfiRzPIV6TjpMAMxoVPOLFdq5TTsAJ
         9wCf+ZdSDM5T7H4ZJEiKTkWt2pHdqlS0D0OJyeicXXjvLylaqzLgCvG2EbVLtkrjbxAX
         iTrA==
X-Gm-Message-State: AOAM533m1e1UKJlJofsIUKctsqQkw1ro7lJgO4N+JSd86lGZgwdDU1eM
        wOSkCAmAuMmnpB27mzIch0N6vX+7A2gKCyGk78w=
X-Google-Smtp-Source: ABdhPJzzTnqMQ1H8/zxnS6rBpfwGWrPlgqwFBcbKeZ5QjGmd5ALyVtkAZrEjaLT34o+/6EAJu8G8bzb3kKOKq2cEdJc=
X-Received: by 2002:a67:cb0a:: with SMTP id b10mr38971206vsl.9.1634130528502;
 Wed, 13 Oct 2021 06:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211007182158.7490-1-semen.protsenko@linaro.org>
 <YWXaKevf8D0kKYXo@smile.fi.intel.com> <CAPLW+4==u6Lpi-tRpGCFjuCBUARsarJx=Lg2QVAbvXX7hOyRVg@mail.gmail.com>
In-Reply-To: <CAPLW+4==u6Lpi-tRpGCFjuCBUARsarJx=Lg2QVAbvXX7hOyRVg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Oct 2021 15:08:37 +0200
Message-ID: <CAMuHMdXmp5qngW9XKSzFwBGMQs4YduQbw3zxDfSAjho_deMjaQ@mail.gmail.com>
Subject: Re: [PATCH v5] clk: Add write operation for clk_parent debugfs node
To:     Sam Protsenko <semen.protsenko@linaro.org>
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

  Hi Sam,

On Wed, Oct 13, 2021 at 1:36 PM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
> On Tue, 12 Oct 2021 at 21:55, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Oct 07, 2021 at 09:21:58PM +0300, Sam Protsenko wrote:
> > > Useful for testing mux clocks. One can write the index of the parent to
> > > be set into clk_parent node, starting from 0. Example
> > >
> > >     # cd /sys/kernel/debug/clk/mout_peri_bus
> > >     # cat clk_possible_parents
> > >       dout_shared0_div4 dout_shared1_div4
> > >     # cat clk_parent
> > >       dout_shared0_div4
> > >     # echo 1 > clk_parent
> > >     # cat clk_parent
> > >       dout_shared1_div4
> > >
> > > CLOCK_ALLOW_WRITE_DEBUGFS has to be defined in drivers/clk/clk.c in
> > > order to use this feature.
> >
> > ...
> >
> > > +#ifdef CLOCK_ALLOW_WRITE_DEBUGFS
> > > +     if (core->num_parents > 1)
> > > +             debugfs_create_file("clk_parent", 0644, root, core,
> > > +                                 &current_parent_rw_fops);
> > > +     else
> > > +#endif
> >
> > > +     {
> > > +             if (core->num_parents > 0)
> > > +                     debugfs_create_file("clk_parent", 0444, root, core,
> > > +                                         &current_parent_fops);
> > > +     }
> >
> > Currently there is no need to add the {} along with increased indentation
> > level. I.o.w. the 'else if' is valid in C.
>
> Without those {} we have two bad options:
>
>   1. When putting subsequent 'if' block on the same indentation level
> as 'else': looks ok-ish for my taste (though inconsistent with #ifdef
> code) and checkpatch swears:
>
>         WARNING: suspect code indent for conditional statements (8, 8)
>         #82: FILE: drivers/clk/clk.c:3334:
>         +    else
>         [...]
>              if (core->num_parents > 0)
>
>   2. When adding 1 additional indentation level for subsequent 'if'
> block: looks plain ugly to me, inconsistent for the case when
> CLOCK_ALLOW_WRITE_DEBUGFS is not defined, but checkpatch is happy
>
> I still think that the way I did that (with curly braces) is better
> one: it's consistent for all cases, looking ok, checkpatch is happy
> too. But isn't it hairsplitting? This particular case is not described
> in kernel coding style doc, so it's about personal preferences.
>
> If it's still important to you -- please provide exact code snippet
> here (with indentations) for what you desire, I'll send v6. But
> frankly I'd rather spend my time on something more useful. This is
> minor patch, and I don't see any maintainers wishing to pull it yet.

Note that checkpatch is just a tool, providing advice. It is not perfect,
and if there is a good reason to ignore it, I'm all for that.

Personally, I would write:

    #ifdef CLOCK_ALLOW_WRITE_DEBUGFS
            if (core->num_parents > 1)
                    debugfs_create_file("clk_parent", 0644, root, core,
                                        &current_parent_rw_fops);
            else
    #endif
            if (core->num_parents > 0)
                    debugfs_create_file("clk_parent", 0444, root, core,
                                        &current_parent_fops);
            }

Then, I'm wondering if it really is worth it to have separate cases for
"num_parents> 1" and "num_parents > 0".  If there's a single parent,
current_parent_write() should still work fine with "0", wouldn't it?
Then the only differences are the file mode and the fops.
You could handle that with #defines above, like is currently done for
clk_rate_mode.  And the checkpatch issue is gone ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

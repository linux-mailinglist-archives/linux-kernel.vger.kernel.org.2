Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C01630D438
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 08:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbhBCHqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 02:46:17 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:37381 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbhBCHqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 02:46:14 -0500
Received: by mail-ot1-f50.google.com with SMTP id h14so22523530otr.4;
        Tue, 02 Feb 2021 23:45:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tl2HQz+y+iOPiQILzhqqnPhDi9CBql1fJsRNfHL12Q0=;
        b=oG1RRYBkkmvma1MULMt1aKqHDeMoY1evle65gjdANYEFWaWWH0wus0ZJ8qCInGbIsp
         N0rRHPSgv+tjG00/QuNvDSbxc7rpKrH6eMezJavMsCKsIQQ3EyPeCPk6iaTHVdvknEdd
         mm3PLcEtaZijCJuhasM4MxXlZ9wRrNMBy6RrCF/+oK34qHauYuKiHEZkvuB+H5Q50mBF
         JnRKI4zs1uki2KK+AAQcHIWfv5hlJVHAMrfzR1DhjQqwngC4dIjnTpPiICFf4wD7fxS8
         YrMzVsnMnUTDPWVknsiw24nus5UhV5fgbNdx7kh2tmWikh1lez/OHpt/gkT5zdMOCo2S
         g9zg==
X-Gm-Message-State: AOAM530Wxc9VpWTyZOLljS9fKcdIUoCoYWF1NrZA35vrDfEx7bCoxUJC
        zuOEv0XSA5r1QKtzAtBvgDBe3hokI2rglbnFy8Y=
X-Google-Smtp-Source: ABdhPJx9yZoxbg+9CSe33TkzPC+sv+1KS9raIvmdY3DrG/UQPjHtQB4ehiLgkRgipyn5NeUe8XLh5bBW9yzj3ZDOG3A=
X-Received: by 2002:a9d:3604:: with SMTP id w4mr1148270otb.107.1612338333629;
 Tue, 02 Feb 2021 23:45:33 -0800 (PST)
MIME-Version: 1.0
References: <20210202192016.49028-1-swboyd@chromium.org> <CAMuHMdWKr5q1OrwJ5DEnFvqYYXJqXhH_isKQnJozf5tu=ZVViA@mail.gmail.com>
 <CAK8P3a0AETMRBJ3=kFi1zJUR3tywGz5aOx_uBYOVuJ7=d_peog@mail.gmail.com>
In-Reply-To: <CAK8P3a0AETMRBJ3=kFi1zJUR3tywGz5aOx_uBYOVuJ7=d_peog@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 3 Feb 2021 08:45:22 +0100
Message-ID: <CAMuHMdVP9tEpQpGNe9pupeDHinm_vzRsc7HAfk-d5wm8bXk3Gg@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: da7218: Drop CONFIG_OF ifdef
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, kernel test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, Feb 2, 2021 at 9:50 PM Arnd Bergmann <arnd@kernel.org> wrote:
> On Tue, Feb 2, 2021 at 9:06 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Feb 2, 2021 at 8:20 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > This reverts commit a06cd8cf97a3 ("ASoC: da7218: skip of_device_id table
> > > when !CONFIG_OF") because we want to make of_match_device() stop using
> > > of_match_ptr() internally, confusing compilers and causing ifdef
> a> > pollution.
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Mark Brown <broonie@kernel.org>
> > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> >
> > Thanks for your patch!
> >
> > > ---
> > >
> > > Changes from v1:
> > >  * Dropped of_match_ptr() in driver too
> > >
> > >  sound/soc/codecs/da7218.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > >
> > > diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
> > > index 2bfafbe9e3dc..83cace9d0139 100644
> > > --- a/sound/soc/codecs/da7218.c
> > > +++ b/sound/soc/codecs/da7218.c
> > > @@ -2278,14 +2278,12 @@ static irqreturn_t da7218_irq_thread(int irq, void *data)
> > >   * DT
> > >   */
> > >
> > > -#ifdef CONFIG_OF
> > >  static const struct of_device_id da7218_of_match[] = {
> > >         { .compatible = "dlg,da7217", .data = (void *) DA7217_DEV_ID },
> > >         { .compatible = "dlg,da7218", .data = (void *) DA7218_DEV_ID },
> > >         { }
> > >  };
> > >  MODULE_DEVICE_TABLE(of, da7218_of_match);
> > > -#endif
> > >
> > >  static inline int da7218_of_get_id(struct device *dev)
> > >  {
> > > @@ -3311,7 +3309,7 @@ MODULE_DEVICE_TABLE(i2c, da7218_i2c_id);
> > >  static struct i2c_driver da7218_i2c_driver = {
> > >         .driver = {
> > >                 .name = "da7218",
> > > -               .of_match_table = of_match_ptr(da7218_of_match),
> > > +               .of_match_table = da7218_of_match,
> >
> > This does mean the compiler can no longer optimize the table away
> > in the CONFIG_OF=n case. Is that intentional?
>
> It already couldn't do that because of the other reference.

But that will be fixed by the conversion to of_device_get_match_data(),
right?

> In general, I don't see much value in optimizing the match table
> away regardless, since most drivers that have one do not work
> without a devicetree anyway. It seems that this could in theory
> work using a locally defined platform device, but I don't see any
> such users in the mainline kernel.

For platform devices, limited to one SoC or SoC family, I agree.

Given this is an i2c driver with a MODULE_DEVICE_TABLE listing multiple
entries, I wouldn't be surprised if there are out-of-tree users, using
i2c_register_board_info() or echo > /sys/.../new_device.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

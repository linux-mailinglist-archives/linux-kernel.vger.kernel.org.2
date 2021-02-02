Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B14730CD50
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 21:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbhBBUvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 15:51:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:41784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231290AbhBBUvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 15:51:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B044764F64;
        Tue,  2 Feb 2021 20:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612299026;
        bh=0mTNXSXJiLDfS2Ig0qegLjDSnuECgIT1sNYyTLI0WSA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oKpTcT85/YoHIkA0z8EauB0cDmt7GBua6KtcUtNsjN7AlkcBnVPy93cGTzaWXQqgh
         oTyK59AcV5Cv3694avWxK2F7xIznRjC+cQqXe+DS1NGCrbslgnSjtO9z45j5sFHdzV
         LVQxYEQayjrLTXSFkZvM5qRxVNV+I5mPOg3M0/TgjLZ55Un4btnd17h4MloROroMg0
         Fcf+A1qQy1fykJyAKnaMCL4zuLHzipM75yDC9HOghC2raYWtwZfMA8rI8y4bb7koIX
         nw8dxH4uvPe2daZskoRfO71Wg1tFVG8XSSzJphw2094btee1hde0xHvnS3mjXqG0NP
         tcU6cdD+hhpWw==
Received: by mail-oi1-f172.google.com with SMTP id k142so9853724oib.7;
        Tue, 02 Feb 2021 12:50:26 -0800 (PST)
X-Gm-Message-State: AOAM531oX4G38B5IE6lsWSiX9l2xlatqTKgIPRHETXyaQ+EnZ3efV+IN
        WC6wzmsixAjgJKXA60BRYxRDaq2Or9O8C0mvOj4=
X-Google-Smtp-Source: ABdhPJzCHpxLziqT6fPidBpSp/W6SWFO7qjP3F8LCIXtgxAGenNX7XFHLMKMiPHTx8W4C2SJa3Iodpm8Z+MimyXOqJ0=
X-Received: by 2002:aca:d908:: with SMTP id q8mr3920842oig.67.1612299026079;
 Tue, 02 Feb 2021 12:50:26 -0800 (PST)
MIME-Version: 1.0
References: <20210202192016.49028-1-swboyd@chromium.org> <CAMuHMdWKr5q1OrwJ5DEnFvqYYXJqXhH_isKQnJozf5tu=ZVViA@mail.gmail.com>
In-Reply-To: <CAMuHMdWKr5q1OrwJ5DEnFvqYYXJqXhH_isKQnJozf5tu=ZVViA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 2 Feb 2021 21:50:10 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0AETMRBJ3=kFi1zJUR3tywGz5aOx_uBYOVuJ7=d_peog@mail.gmail.com>
Message-ID: <CAK8P3a0AETMRBJ3=kFi1zJUR3tywGz5aOx_uBYOVuJ7=d_peog@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: da7218: Drop CONFIG_OF ifdef
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

On Tue, Feb 2, 2021 at 9:06 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, Feb 2, 2021 at 8:20 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > This reverts commit a06cd8cf97a3 ("ASoC: da7218: skip of_device_id table
> > when !CONFIG_OF") because we want to make of_match_device() stop using
> > of_match_ptr() internally, confusing compilers and causing ifdef
a> > pollution.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Mark Brown <broonie@kernel.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>
> Thanks for your patch!
>
> > ---
> >
> > Changes from v1:
> >  * Dropped of_match_ptr() in driver too
> >
> >  sound/soc/codecs/da7218.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
> > index 2bfafbe9e3dc..83cace9d0139 100644
> > --- a/sound/soc/codecs/da7218.c
> > +++ b/sound/soc/codecs/da7218.c
> > @@ -2278,14 +2278,12 @@ static irqreturn_t da7218_irq_thread(int irq, void *data)
> >   * DT
> >   */
> >
> > -#ifdef CONFIG_OF
> >  static const struct of_device_id da7218_of_match[] = {
> >         { .compatible = "dlg,da7217", .data = (void *) DA7217_DEV_ID },
> >         { .compatible = "dlg,da7218", .data = (void *) DA7218_DEV_ID },
> >         { }
> >  };
> >  MODULE_DEVICE_TABLE(of, da7218_of_match);
> > -#endif
> >
> >  static inline int da7218_of_get_id(struct device *dev)
> >  {
> > @@ -3311,7 +3309,7 @@ MODULE_DEVICE_TABLE(i2c, da7218_i2c_id);
> >  static struct i2c_driver da7218_i2c_driver = {
> >         .driver = {
> >                 .name = "da7218",
> > -               .of_match_table = of_match_ptr(da7218_of_match),
> > +               .of_match_table = da7218_of_match,
>
> This does mean the compiler can no longer optimize the table away
> in the CONFIG_OF=n case. Is that intentional?

It already couldn't do that because of the other reference.

In general, I don't see much value in optimizing the match table
away regardless, since most drivers that have one do not work
without a devicetree anyway. It seems that this could in theory
work using a locally defined platform device, but I don't see any
such users in the mainline kernel.

       Arnd

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C362305E94
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbhA0OrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbhA0Oqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:46:54 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B9CC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 06:46:13 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ke15so2971086ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 06:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LB+KnXDk08QSztygvS1XRrmtygQ3Z6NLwB4B/K64vk4=;
        b=MCq9nT9sjOH/xAmhsgEVlDS04AvCloSKoqpwLu4kkOM9mXA5U807sI6Bq+S0kWd1q+
         hVdknbWzaif7Mpl0GXvRD6W48szElaiBkZpwzK4g3z3ezTApPwstKC9stF9yQTey2aTT
         23RmLCQzkzXAuXHb8Zo8RbYDcGG53pTUXkhA4yLSlUYeWXHVKkEYOm4ZA2kwxN0mnNMF
         qTU3Z07/1z2VIrHlJYvIMj59fGwPnRGVlPPPk7FJQ0uMCeJFfb3CUfQOPZNLAbkaCeNZ
         1GH8J0+NeysPMLvfMKWBrktDcpsTiNIDZ3BNjdyXUJ3jxNotrmD9eEgRBxGkRo8G5h/m
         pb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LB+KnXDk08QSztygvS1XRrmtygQ3Z6NLwB4B/K64vk4=;
        b=o2y+nhNdByOqIiGwZNyCx7CjvF4PFAZUMFP2vYUoZ/U8KrIa+D6QZXLg4qX8+2ujLo
         +jFV82cdDRX/K6nApoaHprmZ5WpM5hCLEIvo5BptJP7dG1ZIme8RS2127NUbstdwAOs0
         4hX9idu+ZuZS/U0HSVYdspttP4zF32htiPn7CE4iins7iJUDGPfTEHcuR8MwMX65lkAi
         u2OQ1mzW8pqV5DFM7KhwyKse+BVs1rF9O3xVAJwOMZZAAC2Jk/iR1NGdrWaikVSWYib3
         cxbTlomsckbegxwhc134GdpjdWeqlmU0lZCJ8558MVWOs129/Wb7nXguZCEGEp5YAn9v
         lcgA==
X-Gm-Message-State: AOAM5310CHsqjYni9989PmkaoQnlWNtxvw1kCXdb7Ae3UNTT02UyNrCW
        2HM2qmZcooh7y9LFD3PX0u9p2ElMjQpixkf8gmTNqA==
X-Google-Smtp-Source: ABdhPJyY9Gpe6UV949iqRFcQXeo6eAH+lz7i0n80n61UAFSWAuJJqxJzMnOoy8jNyXqG8JdO34YZgV6MmRfPXZapNVI=
X-Received: by 2002:a17:907:2632:: with SMTP id aq18mr117344ejc.445.1611758772511;
 Wed, 27 Jan 2021 06:46:12 -0800 (PST)
MIME-Version: 1.0
References: <20210120004548.31692-1-digetx@gmail.com> <CACRpkdZynT6T8wnN3xY6hUmZy5emWUe5ep9N3BEV8iQEZLnEew@mail.gmail.com>
In-Reply-To: <CACRpkdZynT6T8wnN3xY6hUmZy5emWUe5ep9N3BEV8iQEZLnEew@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 27 Jan 2021 15:46:01 +0100
Message-ID: <CAMpxmJX2BwN1Lj1GpGqoq9Yd_jGsJoRDO4ur-6nZY18DE++vVw@mail.gmail.com>
Subject: Re: [PATCH v1] gpio: tegra: Fix irq_set_affinity
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 1:56 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Jan 20, 2021 at 1:46 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> > The irq_set_affinity callback should not be set if parent IRQ domain
> > doesn't present because gpio-tegra driver callback fails in this case,
> > causing a noisy error messages on system suspend:
> >
> >  Disabling non-boot CPUs ...
> >  IRQ 26: no longer affine to CPU1
> >  IRQ128: set affinity failed(-22).
> >  IRQ130: set affinity failed(-22).
> >  IRQ131: set affinity failed(-22).
> >  IRQ 27: no longer affine to CPU2
> >  IRQ128: set affinity failed(-22).
> >  IRQ130: set affinity failed(-22).
> >  IRQ131: set affinity failed(-22).
> >  IRQ 28: no longer affine to CPU3
> >  IRQ128: set affinity failed(-22).
> >  IRQ130: set affinity failed(-22).
> >  IRQ131: set affinity failed(-22).
> >  Entering suspend state LP1
> >
> > Hence just don't specify the irq_set_affinity callback if parent PMC
> > IRQ domain is missing. Tegra isn't capable of setting affinity per GPIO,
> > affinity could be set only per GPIO bank, thus there is nothing to do
> > for gpio-tegra in regards to CPU affinity without the parent IRQ domain.
> >
> > Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
> > Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
> > Tested-by: Dmitry Osipenko <digetx@gmail.com> # A500 T20 and Nexus7 T30
> > Fixes: efcdca286eef ("gpio: tegra: Convert to gpio_irq_chip")
> > Reported-by: Matt Merhar <mattmerhar@protonmail.com>
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>
> Ick, sorry for the noise!
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij

Patch applied, thanks!

Bartosz

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C89B44B5C5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 23:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344097AbhKIWWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 17:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245423AbhKIWVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 17:21:02 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF76C061239
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 14:17:48 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id l7-20020a0568302b0700b0055ae988dcc8so843530otv.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 14:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tm6yQehIZfxegQ8LQXmzpFcIGj8PrEgZNef1SIRm8V4=;
        b=gW0Q1vghMpdNvpEzqaYw/vBySsb/uRGOLQyXIpWbwKfyLOIK5TbfKgHgOHsomzNzQ1
         iqSUqrjeZ94H3uNw+UFDShc83N0fCNS6vZxdNtWsAMMAt48s6BUSzc31oLPZh5ZSz+NI
         oXhBndndVnFgNqFVoC2Tg0vcycUpR5I5FfGlec0wPa9/ylYz2GwNkIrTESXkqLDnMm7v
         mDstpsh66kKPpBp4PvtnTkI3ObI1NQmy4Ze1y008VeSMhqa4bu7wd2mCzot6zpNNDP8s
         JeX0a8SeaBdsRPlcN8Tj+AR44DQiLz/YA6CQggSwGYRajUI36iL/8V4mI9jnGtTxCeeU
         3h+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tm6yQehIZfxegQ8LQXmzpFcIGj8PrEgZNef1SIRm8V4=;
        b=68jp8RiN8yancQxCqmKYNuxEoOFpRdvOFF9XvpErP4mruO0LvK8LKkcU8E3Tnu8dZA
         CSoreojvY5AykS2JdwbyHGw1COmc1VTPOAFNYawzVJLGKWBCjeeoToAUL9ywdv3UJGUJ
         wZyh6qD5mbFY5Eq7ZCez7xAJXg9hGF8ZstEWCsByFds4XlkUJx6d0+tsWA0pXX2udVMT
         b94oWBY9/94nBBiPJn8zQrOnq23iixeTjtvQlEBP9Ak+nAE369jUUkJoXKBbpL2wB60q
         EprAx441mDaF7CKaW72qJ05rF9Q6FOY+3tcKxAe0Bs3Dht8hGRgyx0x19LpqZt6YpD6M
         2elw==
X-Gm-Message-State: AOAM530ptH1844lIVsuSFWN8AQFdrTHQNJv5ECWtZxuA2pJ4rkKkQOUH
        isfVdMnv4JZx869CclRk7rSZhFywbKBQTvV8uaymaA==
X-Google-Smtp-Source: ABdhPJzo4LmUY1pFN2oW/gS3+tIDlYsTBZs9R18Xd1P3754m/dv0m7cnbD7ZvDQF9ZkQEmbRVyX6LHfPFNWuBda049M=
X-Received: by 2002:a9d:6348:: with SMTP id y8mr9026567otk.179.1636496268074;
 Tue, 09 Nov 2021 14:17:48 -0800 (PST)
MIME-Version: 1.0
References: <20211109100207.2474024-1-arnd@kernel.org> <20211109100207.2474024-6-arnd@kernel.org>
 <YYpMcKlcZ3JWqp5M@smile.fi.intel.com> <CAK8P3a0VsDG3af1YkRRb=5bmvZ4zP3Du492hE_jyUWOwnYph_w@mail.gmail.com>
In-Reply-To: <CAK8P3a0VsDG3af1YkRRb=5bmvZ4zP3Du492hE_jyUWOwnYph_w@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 23:17:34 +0100
Message-ID: <CACRpkdacYt4kS2QS4-W83ZtWWtTaAETeH8Buer2wOXBOoBK=qA@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] gpiolib: shrink further
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 12:18 PM Arnd Bergmann <arnd@kernel.org> wrote:

> Ideally we should only use linux/gpio/consumer.h, which is required for
> gpiod_set_debounce(). of_gpio.h is still needed for of_get_named_gpio()
> and should be taken out once we change this to gpiod_get(), while
> linux/gpio.h is still needed for gpio_is_valid()/gpio_get_value() and should
> be removed when those are changed to the gpiod_ versions.
>
> We could do an intermediate patch that converts one half of the
> interface, something like

When I convert stuff I try to go all the way when I can. It can
be a bit daring if no one is there to test changes.

The patch looks good though apart from:

> -               ts->gpio_pendown = pdata->gpio_pendown;
> +               ts->gpio_pendown = gpio_to_desc(pdata->gpio_pendown);

I usually even go into the defined platform data and try to convert
the boardfile to use a descriptor table so this is never needed.
(But, more work.)

Examples:
git log -p --author=Walleij arch/arm/mach-pxa/

> -       pdata->gpio_pendown = of_get_named_gpio(dev->of_node,
> "pendown-gpio", 0);
> +       ts->gpio_pendown = gpiod_get(dev, "pendown-gpio", GPIOD_IN);

Needs to be just gpiod_get(dev, "pendown", GPIOD_IN); the new
API tries the "-gpio[s]" suffixes when going into the device tree.

Yours,
Linus Walleij

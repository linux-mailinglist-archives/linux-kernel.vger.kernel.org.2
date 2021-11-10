Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E2044B983
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 01:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhKJAGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 19:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhKJAGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 19:06:39 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F69C061767
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 16:03:53 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id r26so1840113oiw.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 16:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ex3FTl74QW3tE5vZKlAyIh2nQ76GasOzWY712By4q7Q=;
        b=nz35NBQpCwebMfC4qJ/iN9iKacj6CluV5tZh9dWADjGXBTRFXfPHCnA3/gPH/AOEFy
         Qi68PxiTe3kXlIkJa/KeHy35jUV78n1QxqOdj5NEldZdW56idj04p3aHuFkNUI2uaJL9
         BO5OEKTP+VGR4h5JelX0jJ9jYP5kFg/gQTzLOyZJnq+UADTMnHzewZLq711v1660zgMy
         1MlUEkdlCNKJHaB/z/tjwWEbf2iCQXPujfMF89KDGa/u8H9/HSM2Ch5aMLQFfZ1wL02S
         9FXF9rq7+J+pyXAXLR2M5PtYI0/3XOrXQ0F6CfDuE9/ssJ9/AS8vLGepUkkdZAVWZ6cA
         mulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ex3FTl74QW3tE5vZKlAyIh2nQ76GasOzWY712By4q7Q=;
        b=WC84UFw7GeofP+hTliGw0qKfms24aQyjEu6/0TyjimHEzx7HEaLEAZGA9COkkfN7aw
         sFG7X8DwHUzwqUWdsGcodnZlqXKwo0c/P1gW3Fp+eIRU+Rvxr+TPqdDF5fmMCRQPIy64
         9tqdStuec6LT8ARj+qJbHMGk/8LI2pQgyqnpEW6K5y6meNr+UlsVmmCtOIKltF2V91Dz
         vm5pmsXTegAy9/PsY2By+m4Gq7vtvAsilRg7tzLz7QYcJlLTkTZXTwvcZzreTRtZcjdk
         PUzfbdSYyAHTwd1N7PVh7tFL8arw+Pyewb4krhW2qNKlQZlbl9ulTMB7SgYczhuyWf2b
         WQ6w==
X-Gm-Message-State: AOAM5323Hwrhu3QTk8R75hVi5vknM6kwlAz0pjYBg8DVJ0gxUlTexU0d
        9LEOl4sT4IsK1hFo1/8EcIHDmmAxy7LvE7UI9UILuw==
X-Google-Smtp-Source: ABdhPJwoBG6zw/ToNJoeYVsxzPxnjF1p3mLyfasl2FJHFDY84Mv43Y9zsw+ptdymwyhGsYw1VT5GEI7H46VItvzLaE8=
X-Received: by 2002:a54:4791:: with SMTP id o17mr9816139oic.114.1636502632428;
 Tue, 09 Nov 2021 16:03:52 -0800 (PST)
MIME-Version: 1.0
References: <20211109100207.2474024-1-arnd@kernel.org> <20211109100207.2474024-7-arnd@kernel.org>
 <YYpN3LzXz638l6FG@smile.fi.intel.com> <CAK8P3a24wkBEAnWG8=LYoVR1oiTo0VKZ3iME+FYbDuHXJDjMOw@mail.gmail.com>
 <CACRpkdZaJQqwyosnXhaOc=mF5jJxaDKDKAQxJGJvQAWpU7MNQQ@mail.gmail.com> <CAK8P3a0J1f9+o6Uqdn4QeQ=30oW6p+fOaFU7-5L0cW-zihfNxg@mail.gmail.com>
In-Reply-To: <CAK8P3a0J1f9+o6Uqdn4QeQ=30oW6p+fOaFU7-5L0cW-zihfNxg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Nov 2021 01:03:40 +0100
Message-ID: <CACRpkda8mL9DGenPaGtXEiK9v4-pWo_kA5khK6Mk0i5i5fs1SA@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] gpiolib: remove legacy gpio_export
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

On Tue, Nov 9, 2021 at 11:47 PM Arnd Bergmann <arnd@kernel.org> wrote:

> v3.18 676
> v4.1 669
> v4.4 646
> v4.9 639
> v4.14 614
> v4.19 553
> v5.4 465
> v5.10 381
> v5.15 354

Hey :D I didn't know it was working out that well. OK this give me hope!

> I've also started a patch series to remove some of the less common
> of_gpio portions, which gets rid of of_get_gpio(), of_get_gpio_flags()
> and of_get_named_gpio_flags() but leaves of_get_named_gpio() in
> place for now. I'm much less confident about that work though, so I
> haven't posted that. I think killing off the of_gpio consumer-side
> interfaces entirely would likely make the biggest impact, as those
> appear to still be used a lot in relatively modern drivers, while the
> traditional gpio_request() interfaces are mainly used in drivers for
> legacy boards that don't have a long future ahead of them unless
> they get converted to DT.

OK you got a point. I am running around in SA1100 systems and
stuff like that :/ getting rid of of_gpio.h would be a real nice feat.

Yours,
Linus Walleij

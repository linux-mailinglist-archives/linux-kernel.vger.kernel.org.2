Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6937F3DC179
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 01:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbhG3XK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 19:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbhG3XKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 19:10:52 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68ECBC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 16:10:47 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ba4so3388752vsb.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 16:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1TbM8t6BNkSg4D2ia1l4JTeH7i8cCps/pEqFiTm27VI=;
        b=pQrODr43Tq85sO7xev8VokbneJbm5zeP5yoYuIENZPWPGzqaou9BgZY6fwo8YMfy6q
         DEFyoI0Tx3ZLIau3mYWwHsSB/8Kg2TJawcyxM1fcczHY+wiJFggCXrMuRL7kQwc69fn5
         ON1gNh74Lzl4gbRJPb3Bs2yS/iisOBmc54wJYt9sU4bVuNDZobMpypQ3IvmA8SVuQlh9
         F9BHRVHFYm7u3dtmaNYHIQlhS3yVdC7cuuarR8UBtAAKEwIPbpdVSIGbVrrLnPyVtYAp
         fBNaIGi2wmKmLVl5CqYRJUbFkTmA8e+stGXBEqNEaykxSePM9u8UKNBbEabeb6oqGo2J
         rCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1TbM8t6BNkSg4D2ia1l4JTeH7i8cCps/pEqFiTm27VI=;
        b=FsGCuAR1ry/Osfm30JnuRZX5uDSXmfSkGJe/jCuum91ZUzVu1xgHyhUBRIK+r3HPuK
         1JM8RybOBhEERNnQw+S/zBn13hFVXrtG0BuBorczV4BS9alqvszDy6IeQHV22JM2XLxa
         /vBbvmKWiORVosSPwNp9Xgv5aEwiEuPmQWnmhLAlto0ApFo6yn9IQSrouwf1KPGdWSlf
         BD/4HdnrJ/RJTB7aaSwf6W9TE521Qj9awu60QIbx53zrSiMThWCiz/Glwhla7HoflMpd
         gZzc9xq/8C0leQPY6Q8d9Em7a4gSWOEe7Hk3GF+BkjFTjLNycubc4cuLlTgoN9uAIyLA
         mXcA==
X-Gm-Message-State: AOAM530T3nW/T4vddr8FAeyD/FVynKuVS3UVykAmxLT25AjMosHJG1LX
        GronZEXABFQ6PyCm0FyvK88bA0P2Ifj6kTVxrzziDw==
X-Google-Smtp-Source: ABdhPJzjN4/BBXYdmqDYw3Auz5/+2Hw4s/UhDtBUqd4bFeznRfXGoaUAkywM5B9TqucDz/hqA+hxev/WRZVElP9J8As=
X-Received: by 2002:a05:6102:21b:: with SMTP id z27mr4528245vsp.27.1627686646549;
 Fri, 30 Jul 2021 16:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210730144922.29111-1-semen.protsenko@linaro.org>
 <20210730144922.29111-7-semen.protsenko@linaro.org> <5826bc3e-e9e8-a9bb-4541-21c1b944a60e@canonical.com>
In-Reply-To: <5826bc3e-e9e8-a9bb-4541-21c1b944a60e@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Sat, 31 Jul 2021 02:10:35 +0300
Message-ID: <CAPLW+4=yOETYdVWvG_YUzewRDg9wB1h+z4i3DRDxJQHeVgu1EQ@mail.gmail.com>
Subject: Re: [PATCH 06/12] tty: serial: samsung: Add Exynos850 SoC data
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Ryu Euiyoul <ryu.real@samsung.com>,
        Tom Gall <tom.gall@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jul 2021 at 19:05, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 30/07/2021 16:49, Sam Protsenko wrote:
> > Add serial driver data for Exynos850 SoC. This driver data is basically
> > reusing EXYNOS_COMMON_SERIAL_DRV_DATA, which is common for all Exynos
> > chips, but also enables USI init, which was added in previous commit:
> > "tty: serial: samsung: Init USI to keep clocks running".
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >  drivers/tty/serial/samsung_tty.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> > index 75ccbb08df4a..d059b516a0f4 100644
> > --- a/drivers/tty/serial/samsung_tty.c
> > +++ b/drivers/tty/serial/samsung_tty.c
> > @@ -2814,11 +2814,19 @@ static struct s3c24xx_serial_drv_data exynos5433_serial_drv_data = {
> >       .fifosize = { 64, 256, 16, 256 },
> >  };
> >
> > +static struct s3c24xx_serial_drv_data exynos850_serial_drv_data = {
> > +     EXYNOS_COMMON_SERIAL_DRV_DATA_USI(1),
> > +     .fifosize = { 0, },
>
> This does not look correct. You rely on samsung,uart-fifosize property
> but it is optional.
>

Good point. I will replace fifosize elements (in patch series v2) with
this code (the reasoning is below):

    .fifosize = { 256, 64, 64, 64 }

TRM mentions that USI block has configurable FIFO of 16/32/64/128/256
byte. In vendor kernel they are setting default values in dtsi instead
of driver, that's where fifosize = { 0 } appeared from. And in vendor
dtsi they set 256 for serial_0 (USI UART instance), 64 for serial_1
(CMGP0 UART instance) and 64 for serial_2 (CMGP1 UART instance). I
tested 256 and 64 for serial_0 (which is used for serial console)

As for fifosize array elements count: though it's possible to
configure up to 7 UARTs in Exynos850 (it has 5 USI blocks and 2 CMGP
blocks, which can be configured as USIs), in a regular case it's only
3 UARTs (1 in USI and 2 in CMGP). This is how it's done in vendor's
device tree, and I doubt someone is going to need more than 3 serials
anyway, looks like very specific case for a mobile SoC. But
CONFIG_SERIAL_SAMSUNG_UARTS_4=y is set by default when using arm64
defconfig, and I'd like to keep minimal delta for this defconfig for
now.

Hope you are ok with this?

Thanks!

>
> Best regards,
> Krzysztof

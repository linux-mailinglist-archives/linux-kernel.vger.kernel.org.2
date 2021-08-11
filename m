Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078C23E8F64
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 13:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237340AbhHKLUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 07:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237321AbhHKLUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 07:20:38 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2388BC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 04:20:15 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id y14so992239uai.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 04:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t0kEBolSkLS2sqce8sXfB33QiH70Nq/WEHar/RhDH00=;
        b=EXu9onjXPrdieAXb4oXgi7XDK2Cs0n7NV6W1fs65ZqHGgYhojmH+np0TMd9X9TqyuL
         mOnHJv7IMjvM9aW6URokLeKObx1Hr9sjULLeVyDoJV4IKgi8fwJ//B4u5gldK+Z5wFx9
         BKtL5eL2UislHCHvFKd2LH1s/w/8kUDgOikyU9jhJ/2FvWAV5lYtV4zP5KAHH5VelCmZ
         OILdkPwbA6BPx1xP6y3Vmt5x8OAnk13uX69egwyyuj2xCe/JXUzlmQ1/WZHG02cohJit
         nyEOMegmP/pDz8Yx19iIhYRG2XssOk/biOMEYxoM2J5Xg5LaVzEzM6IeYbKxMX6BoUG0
         DcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t0kEBolSkLS2sqce8sXfB33QiH70Nq/WEHar/RhDH00=;
        b=NSNvlvzWQJUZVbcongbntFfKk1C/jFBdhzB4wfRWegaxYh1HGPAXiS9Egw0yoTX5SP
         2PFM2Va0lHucC00UttUf1FU1yb/xFN1oJFGQ13bvuHX7vJ8OyqkQyu7qzjuMyImDO6E6
         mDn9jR3yRK2FRHDtdUcNVed3bn7loVPcpzjtzJWWAzdH1l3yVgDuRDNyBaxQM0P7IX4y
         9jx9G7WtJinIn8eJ1LLnZGP8oUIGjvDEqPa6QlLd6kiVytccZQTp/h24g+BwsTzuxOu0
         Aj/Iw85VsDRUAF/rXUnRRLq0K1J1JwMC7CMpj3LT+xWtgVJOz7II742/42stIu0nvmAc
         6UzQ==
X-Gm-Message-State: AOAM532MxwFcVf5YXU6NahXa7mwHV5bhUyIgfOPsyKaQw3wdzaRHLXCO
        Oy9IYRJYOx7JHfO/JYxHX4Wl/zm+f5Ie6K6s3914XA==
X-Google-Smtp-Source: ABdhPJzHREh3TtpeK5LboogIOTf9B16ur3hdtF1iwFqcdwjhPQLqbrAfGLqvXhyblELiy1U/5s3uTaTrZeYTfryBy8o=
X-Received: by 2002:ab0:7014:: with SMTP id k20mr10843046ual.9.1628680814267;
 Wed, 11 Aug 2021 04:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210806152146.16107-1-semen.protsenko@linaro.org>
 <20210806152146.16107-8-semen.protsenko@linaro.org> <3add6f87-7293-e1ae-8f9e-c69e9de18cf5@canonical.com>
 <CGME20210809194915eucas1p19999295aef3127f95ffe4c75a8acc63f@eucas1p1.samsung.com>
 <CAPLW+4=-uUcoLCjjBAC2K5NLswnXGXW1qrsTJrb_uZDgOQ5Ehw@mail.gmail.com> <bb69e79d-55a8-2090-e51c-fdfea755cf99@samsung.com>
In-Reply-To: <bb69e79d-55a8-2090-e51c-fdfea755cf99@samsung.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 11 Aug 2021 14:20:02 +0300
Message-ID: <CAPLW+4mPrPSeukiJY6DmpEz0V=bjEYbjzLTnJ28T01yqoQY=mg@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] clk: samsung: Add Exynos850 clock driver stub
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
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

On Tue, 10 Aug 2021 at 10:55, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> On 09.08.2021 21:48, Sam Protsenko wrote:
> >>> +/* Will be extracted to bindings header once proper clk driver is implemented */
> >>> +#define OSCCLK               1
> >>> +#define DOUT_UART    2
> >>> +#define CLK_NR_CLKS  3
> >>> +
> >>> +/* Fixed rate clocks generated outside the SoC */
> >>> +static struct samsung_fixed_rate_clock exynos850_fixed_rate_ext_clks[] __initdata = {
> >>> +     FRATE(OSCCLK, "fin_pll", NULL, 0, 26000000),
> >>> +};
> >>> +
> >>> +/*
> >>> + * Model the UART clock as a fixed-rate clock for now, to make serial driver
> >>> + * work. This clock is already configured in the bootloader.
> >>> + */
> >>> +static const struct samsung_fixed_rate_clock exynos850_peri_clks[] __initconst = {
> >>> +     FRATE(DOUT_UART, "DOUT_UART", NULL, 0, 200000000),
> >>> +};
> >>> +
> >>> +static const struct of_device_id ext_clk_match[] __initconst = {
> >>> +     { .compatible = "samsung,exynos850-oscclk" },
> >>
> >> One more thing - I am not sure anymore if this is correct. AFAIR, we
> >> wanted to drop compatibles for external clocks.
> >>
> > I'll remove oscclk from the clock driver and device tree. It's not
> > needed right now anyway, as that driver is just a stub.
> >
> > But I'd still like to know the proper way to define external clocks. I
> > can see that in exynos7.dtsi and exynos5433.dtsi there is just regular
> > fixed clock defined for "oscclk" (or "fin_pll"), and then that clock
> > is referenced in corresponding clock driver by its
> > 'clock-output-names' property. I guess that approach is the
> > recommended one?
>
> Yes, we should use generic "fixed-clock" in DT to model the external
> root clock. Registering the external clock from within the CMU driver
> is a legacy method that predates generic "fixed-clock" and should be
> avoided.
>

Thanks for confirming this. I'll go with generic fixed clock in my
clock patch series then.

> That said I think this temporary stub driver is not needed at all,
> you could well define a fixed clock in DT and reference it in the UART
> node, as Krzysztof suggested.
>

Ok, I'll remove the stub clock driver in v3. Using fixed clock in
device tree for serial seems to work fine.

> --
> Regards,
> Sylwester

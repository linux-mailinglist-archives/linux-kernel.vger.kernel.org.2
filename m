Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239C240CF2A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 00:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhIOWCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 18:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbhIOWCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 18:02:23 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC71C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 15:01:03 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id n17so3593018vsr.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 15:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zGSJw2mijcD917fI6iH/7Zmw4K7gJ7WwhrleRMcWjCU=;
        b=LBVx6jNrGw1ARumMNWN8gjXgHRgv4QoeCFG8s+d30GDiNRCUhBeoZQEOGM7at5+ZxA
         YlEDaKkfE5T7wQapssiYzPc+0mfn6SZ/qKsDr+6dxxaaxJDNlXqE2cQyCaf8JsOeBJtt
         2DydeWngGgU1+3u/dMVj1mSx/JrPW/muOAaZpp14KzYOlfAwXayfBekr8wcM9P0lSs7e
         MC3kq/lnoI/L08K+K39Zbzny5g3GEjc5zqitkcDi5qmEajO+XqcXSXqoq59PE1cGB1G3
         7FT/N/gdr8LyRl0DqThGvCtJx3a/TTWQd2V9//rJqXUrkyyHVUq41e/kEEuFibfVoKuy
         ocWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zGSJw2mijcD917fI6iH/7Zmw4K7gJ7WwhrleRMcWjCU=;
        b=dcVQfHo/+muqc1fIJYX+5Eov3FyieE1Hxmr4+EcirzNH/G+n4rAG2tPbNOLesrbD8Z
         FmpycZsObrr+2CNkm1AG3G/2DS6nkkvPn9CGN+kzB40PC0PtFrnYkHuHcI6FFH+vpbtO
         48TK1m8xoGAX/6KVaXDe1Rk8Wvj2Qpa7aMej2QefCeA8jb62h2Ar22hHBnQMEjL53Q7n
         lX5ofizPgQJF8sDabvW608GQ569vPMbzxn7ru7MYBnyMTkBop0o1ynIPVhaO2dovZ3wF
         UPUD4ALEQhlvawprhjWsdZRI8YqKtBXCsMsmdnbM0i8bcx7d8Zu29JZkp39hZ4uU1wkW
         V4mQ==
X-Gm-Message-State: AOAM5328/NoctDnP94BAScqHkayYZBcpVW25p1VGsa1aBm30rL6hKzRa
        J5yUgYHN1mIHygjxmZtWy0IwaBUEGRq11UVo0PorZg==
X-Google-Smtp-Source: ABdhPJyOr8yGWQEsGudvQrYqjyuQgXeLh226eqUsm3m0MrCX91sh9IJVmTTEPi2a0+PjKOMEygDNsAmyA5u+GuSIjMo=
X-Received: by 2002:a67:d589:: with SMTP id m9mr2041213vsj.30.1631743262794;
 Wed, 15 Sep 2021 15:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210914155607.14122-1-semen.protsenko@linaro.org>
 <20210914155607.14122-7-semen.protsenko@linaro.org> <1428bfc4-520f-9af3-5255-b17308881243@gmail.com>
In-Reply-To: <1428bfc4-520f-9af3-5255-b17308881243@gmail.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 16 Sep 2021 01:00:51 +0300
Message-ID: <CAPLW+4k8ZihQtnpYGULcS1uOP+9tvFi_yo27GadP3aa8KNC7aQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] clk: samsung: Introduce Exynos850 clock driver
To:     Chanwoo Choi <cwchoi00@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Ryu Euiyoul <ryu.real@samsung.com>,
        Tom Gall <tom.gall@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sept 2021 at 21:05, Chanwoo Choi <cwchoi00@gmail.com> wrote:
>
> Hi Sam,
>
> On 21. 9. 15. =EC=98=A4=EC=A0=84 12:56, Sam Protsenko wrote:
> > This is the initial implementation adding only basic clocks like UART,
> > MMC, I2C and corresponding parent clocks. Design is influenced by
> > Exynos7 and Exynos5433 clock drivers.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >   drivers/clk/samsung/Makefile        |   1 +
> >   drivers/clk/samsung/clk-exynos850.c | 700 +++++++++++++++++++++++++++=
+
> >   2 files changed, 701 insertions(+)
> >   create mode 100644 drivers/clk/samsung/clk-exynos850.c
> >
> > diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefil=
e
> > index 028b2e27a37e..c46cf11e4d0b 100644
> > --- a/drivers/clk/samsung/Makefile
> > +++ b/drivers/clk/samsung/Makefile
> > @@ -17,6 +17,7 @@ obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)       +=3D clk-=
exynos5433.o
> >   obj-$(CONFIG_EXYNOS_AUDSS_CLK_CON) +=3D clk-exynos-audss.o
> >   obj-$(CONFIG_EXYNOS_CLKOUT) +=3D clk-exynos-clkout.o
> >   obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)       +=3D clk-exynos7.o
> > +obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)        +=3D clk-exynos850.o
> >   obj-$(CONFIG_S3C2410_COMMON_CLK)+=3D clk-s3c2410.o
> >   obj-$(CONFIG_S3C2410_COMMON_DCLK)+=3D clk-s3c2410-dclk.o
> >   obj-$(CONFIG_S3C2412_COMMON_CLK)+=3D clk-s3c2412.o
> > diff --git a/drivers/clk/samsung/clk-exynos850.c b/drivers/clk/samsung/=
clk-exynos850.c
> > new file mode 100644
> > index 000000000000..1028caa2102e
> > --- /dev/null
> > +++ b/drivers/clk/samsung/clk-exynos850.c
> > @@ -0,0 +1,700 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2021 Linaro Ltd.
> > + * Author: Sam Protsenko <semen.protsenko@linaro.org>
> > + *
> > + * Common Clock Framework support for Exynos850 SoC.
> > + */
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +
> > +#include <dt-bindings/clock/exynos850.h>
> > +
> > +#include "clk.h"
> > +
> > +/* Gate register bits */
> > +#define GATE_MANUAL          BIT(20)
> > +#define GATE_ENABLE_HWACG    BIT(28)
> > +
> > +/* Gate register offsets range */
> > +#define GATE_OFF_START               0x2000
> > +#define GATE_OFF_END         0x2fff
> > +
> > +/**
> > + * exynos850_init_clocks - Set clocks initial configuration
> > + * @np:                      CMU device tree node with "reg" property =
(CMU addr)
> > + * @reg_offs:                Register offsets array for clocks to init
> > + * @reg_offs_len:    Number of register offsets in reg_offs array
> > + *
> > + * Set manual control mode for all gate clocks.
> > + */
> > +static void __init exynos850_init_clocks(struct device_node *np,
> > +             const unsigned long *reg_offs, size_t reg_offs_len)
> > +{
> > +     const __be32 *regaddr_p;
> > +     u64 regaddr;
> > +     u32 base;
> > +     size_t i;
> > +
> > +     /* Get the base address ("reg" property in dts) */
> > +     regaddr_p =3D of_get_address(np, 0, NULL, NULL);
> > +     if (!regaddr_p)
> > +             panic("%s: failed to get reg regaddr\n", __func__);
> > +
> > +     regaddr =3D of_translate_address(np, regaddr_p);
> > +     if (regaddr =3D=3D OF_BAD_ADDR || !regaddr)
> > +             panic("%s: bad reg regaddr\n", __func__);
> > +
> > +     base =3D (u32)regaddr;
> > +
> > +     for (i =3D 0; i < reg_offs_len; ++i) {
> > +             void __iomem *reg;
> > +             u32 val;
> > +
> > +             /* Modify only gate clock registers */
> > +             if (reg_offs[i] < GATE_OFF_START || reg_offs[i] > GATE_OF=
F_END)
> > +                     continue; > +
> > +             reg =3D ioremap(base + reg_offs[i], 4);
> > +             val =3D ioread32(reg);
> > +             val |=3D GATE_MANUAL;
> > +             val &=3D ~GATE_ENABLE_HWACG;
> > +             iowrite32(val, reg);
> > +             iounmap(reg);
>
> I understand your intention for disabling HWACG.
> But, it is not good to execute ioreamp/iounmap for each clock gate
> register. I think that we need to consider the more pretty method
> to initialize the clock register before clock registration.
>
> [snip]
>

Hi guys,

Thanks for the quick review! I'll address all your comments once I get
back from vacation (in two weeks), and will send v2.

> --
> Best Regards,
> Samsung Electronics
> Chanwoo Choi

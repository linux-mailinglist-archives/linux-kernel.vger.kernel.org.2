Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A5D34E396
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhC3IzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhC3IzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:55:00 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5830C061762;
        Tue, 30 Mar 2021 01:54:59 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id e14so23587907ejz.11;
        Tue, 30 Mar 2021 01:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P7HNS/Ipii5EIzZR9IYki1b0ukYKIl9NuAxV1POMrSE=;
        b=sG8lmF6BKVCyZ3vjjdjhF/BAGuXOpGhu3mjj1LvcoWKJ9jYIh6B/fXjLtU7M6gvpqu
         6Hlpqnizr405/YY2FCulW6jBt0wamgpPi62GW+FuK1gmc8M92hTfKkGBStPtEiGrbvA8
         Iwka7d/nPKJjBhYNUogKVN+2IlkNmPK9F6mkb0oOxRBwmemJliVeQePa3SvVK+MBhV1v
         +VaLxBd3PYkdkowFqqHG4pNiUJaXivLuhQeyLVncv+X5lU9xTga14CZlduKZtP98hvPS
         bbM9VnbFGCG5V/a0gcjZZzOA4oW/7xuY0U359MyTasWA4djf4FStJh4I3368jkDQ5zF3
         vGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P7HNS/Ipii5EIzZR9IYki1b0ukYKIl9NuAxV1POMrSE=;
        b=kSnk3P3bVenK0Q16nOa4PSgQmzWquwXcthJun3FVmo3Hn3ShidpLwmEKeP06fYLJKO
         Wu3eHcwEuN6Pb3RoVH/o8998NLIakjE4ApHlVTaw85zOfxYUxn/il5eavPHTdhOAfP4u
         4IbgBtHkVHwRViFPU+jFKt8WEJlu0FZn9/z2B8Q8NXolCc2dG+jkdrjeFCNV6GkQ/xXS
         NRmTrKIVV1BX2AHrAlFeuLpBdpjyz77WcmGb/P7tyU1n/A4iqkst0jhd9EZySmhBmBcJ
         /rpLnxUyt3O9lLxsrABOehu+WmFbv0uvGWq1kxPO8Wgf3epFUDlj9Xvd/+FjIPuQHEM0
         G5gg==
X-Gm-Message-State: AOAM531kazjtp8YlsPJSOzxc19rhPL/83ClL4bTHsE4wzp/1zt29WEBO
        2e4760Lh1XEPgSii4H+rOee49sV/j5/enjllt1M=
X-Google-Smtp-Source: ABdhPJy027q9fOnoFIO4xK0TfOdIcvSRegQVIDdJgpm87bR0iMSQWOJC8NT5qh6SSjodeYl60vtNBi0tJz5i5muZD8E=
X-Received: by 2002:a17:906:9515:: with SMTP id u21mr32912350ejx.86.1617094498524;
 Tue, 30 Mar 2021 01:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210330083514.5874-1-adrien.grassein@gmail.com>
 <20210330083514.5874-3-adrien.grassein@gmail.com> <0d173681-7eb6-798f-7d9b-66a221625d34@pengutronix.de>
In-Reply-To: <0d173681-7eb6-798f-7d9b-66a221625d34@pengutronix.de>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Tue, 30 Mar 2021 10:54:47 +0200
Message-ID: <CABkfQAE_RkqGW5f6TkPJVGNZKOWVRr5LLTeRvWQuJ4riiR+SVw@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] arm64: dts: imx8mq-nitrogen: add USB HOST support
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     DTML <devicetree@vger.kernel.org>, will@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        bjorn.andersson@linaro.org, Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>, catalin.marinas@arm.com,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ahmad,

Le mar. 30 mars 2021 =C3=A0 10:38, Ahmad Fatoum <a.fatoum@pengutronix.de> a=
 =C3=A9crit :
>
> Hello Adrien,
>
> On 30.03.21 10:35, Adrien Grassein wrote:
> > Add the description for the USB host port.
> > At this time, the port will not work directly from the
> > kernel because it's connected through a resettable hub
> > that is not handle in the kernel. It should be controlled
> > in the bootloader or in the userspace.
>
> Couldn't you add a gpio-hog that gets the hub out of reset?
>

Let's try, I didn't think about this solution ^^.

> Cheers,
> Ahmad
>
> >
> > In the case of the Boundary's u-boot, this is done on the
> > boot script:
> > "
> > starting USB...
> > Bus usb@38100000: Register 2000140 NbrPorts 2
> > Starting the controller
> > USB XHCI 1.10
> > Bus usb@38200000: Register 2000140 NbrPorts 2
> > Starting the controller
> > USB XHCI 1.10
> > scanning bus usb@38100000 for devices... 1 USB Device(s) found
> > scanning bus usb@38200000 for devices... 3 USB Device(s) found
> > "
> >
> > Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> > ---
> >  .../boot/dts/freescale/imx8mq-nitrogen.dts    | 22 +++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts b/arch/a=
rm64/boot/dts/freescale/imx8mq-nitrogen.dts
> > index b46f45a82be1..7a52e247c527 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
> > @@ -213,6 +213,22 @@ &usb3_phy0 {
> >       status =3D "okay";
> >  };
> >
> > +&usb_dwc3_1 {
> > +     dr_mode =3D "host";
> > +     status =3D "okay";
> > +};
> > +
> > +/*
> > + * On this board, USB host is connected to a resettable hub.
> > + * The reset signal is connected to the GPIO <&gpio1 14 GPIO_ACTIVE_LO=
W>.
> > + * You need to activate it in the bootloader or in the userspace.
> > + */
> > +&usb3_phy1 {
> > +     status =3D "okay";
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_usb3_1>;
> > +};
> > +
> >  &usdhc1 {
> >       assigned-clocks =3D <&clk IMX8MQ_CLK_USDHC1>;
> >       assigned-clock-rates =3D <400000000>;
> > @@ -388,6 +404,12 @@ MX8MQ_IOMUXC_GPIO1_IO13_USB1_OTG_OC              0=
x16
> >               >;
> >       };
> >
> > +     pinctrl_usb3_1: usb3-1grp {
> > +             fsl,pins =3D <
> > +                     MX8MQ_IOMUXC_GPIO1_IO14_GPIO1_IO14              0=
x16
> > +             >;
> > +     };
> > +
> >       pinctrl_usdhc1: usdhc1grp {
> >               fsl,pins =3D <
> >                       MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK                 0=
x83
> >
>
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  =
|
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|

Thanks,
Adrien

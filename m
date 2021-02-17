Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF6131DCFA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbhBQQLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbhBQQKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:10:49 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA1BC061756;
        Wed, 17 Feb 2021 08:10:09 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id n13so16544524ejx.12;
        Wed, 17 Feb 2021 08:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=03cx8++fHv1vOr5cXDZTnrzyqgUgVS/HcOU7fN/snmg=;
        b=vCPtKvajJE+H/yV2/tTgm2v6kJomW1pKdBPaGmOX1J/YKFSlybm+4ztSZ2xKaXgOeX
         HwtPpvVgNsEV8fKtsRmzvlZL8RvvSXZPSoaCR0O1EODS7QF0esFrAgTQnDtaIvGQuYi+
         qccApU7FPix5EVXcWxTwuVqKdQw7YlkM/8hSPia1DbXofLfvGgRB+g7SCYlTucN/jGrH
         yOLm42MpB6twGPb7L5Rup5RMydoNdHAlraIZ+fhhtcn7rvpdGFU9NM4XCLgZb6rEg09q
         3SFxxGHrmnfZzid326d/a0GhxHOoyT+AEpA/iGM/j6FLySeEtv5+s2ma7FSqtFIRACgH
         5Ifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=03cx8++fHv1vOr5cXDZTnrzyqgUgVS/HcOU7fN/snmg=;
        b=FJarpE0eYy+cuEvcO0R3nwYNaJZjAx3wTWmUHukJHV1RCgEeRGGOACxWHxc7jXunvY
         qOehR3V47iJ9TbZcWUsQPZcZ1ZRgBiITQ1WxROUve7trrYftlwUWrqDeySfs6xD6m+02
         BAvRa9rZl5NTjHReeUpUl74wtn7Xwd86ZS/kSJ0BbC0mZnh61ZjmOJamJacX0V77XwxN
         la+JVKjsvnh/wGTxsRfgYxSq5Vt9sfwWPB9PLxZUR6hYwsbkGm3bgtXnM5rQllyDLbTm
         UyWw/JOwyuK/sJncKcDQIQadPmcXvsQEPj+i/TGE6ed0XG1ARLqu+I2qfKhOxUugZSeS
         92pw==
X-Gm-Message-State: AOAM532mLJMdtEv/muNsTtNTO0Nqx38yRhMzpbV58c3kiRenAe3upAYD
        c9E2QVXDqAOJOj6MVXqcTNyanQoTfPR3Q/9N2sw=
X-Google-Smtp-Source: ABdhPJwNcLTDBN7lJLmcMz0CC/l4jlYWdkU85mV6UwUBJ3vclTiTGn6AvMklINPcrDB/h1Sz0upQwjWY6WDy3P588kA=
X-Received: by 2002:a17:906:8519:: with SMTP id i25mr26843954ejx.106.1613578208332;
 Wed, 17 Feb 2021 08:10:08 -0800 (PST)
MIME-Version: 1.0
References: <20210215231943.36910-1-adrien.grassein@gmail.com>
 <20210215231943.36910-5-adrien.grassein@gmail.com> <20210217142248.klq36mraspeehiqj@kozik-lap>
In-Reply-To: <20210217142248.klq36mraspeehiqj@kozik-lap>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Wed, 17 Feb 2021 17:09:57 +0100
Message-ID: <CABkfQAHn6jDz4iF1yaQSq-BNa=4hSf41+-F6Em7D23xUpx+huA@mail.gmail.com>
Subject: Re: [PATCH 4/8] arm64: dts: imx8mm-nitrogen-r2: add uarts
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer. 17 f=C3=A9vr. 2021 =C3=A0 15:22, Krzysztof Kozlowski <krzk@kernel.o=
rg> a =C3=A9crit :
>
> On Tue, Feb 16, 2021 at 12:19:39AM +0100, Adrien Grassein wrote:
> > Add description and pinmuxing for uarts.
> >
> > Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> > ---
> >  .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 53 ++++++++++++++++++-
> >  1 file changed, 52 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arc=
h/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> > index 22acde0f3ba8..3c5b692f6ad1 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> > @@ -206,6 +206,15 @@ rtc@68 {
> >       };
> >  };
> >
> > +/* BT */
> > +&uart1 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_uart1>;
> > +     assigned-clocks =3D <&clk IMX8MM_CLK_UART1>;
>
> I see you have it also for uart2 - what is the purpose of it? What does
> the "assigned-clocks" property alone do?
>

 It was a mistake. I forgot to remove this property.

> > +     uart-has-rtscts;
> > +     status =3D "okay";
> > +};
> > +
> >  /* console */
> >  &uart2 {
> >       pinctrl-names =3D "default";
> > @@ -215,6 +224,23 @@ &uart2 {
> >       status =3D "okay";
> >  };
> >
> > +/* J15 */
> > +&uart3 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_uart3>;
> > +     assigned-clocks =3D <&clk IMX8MM_CLK_UART3>;
> > +     uart-has-rtscts;
> > +     status =3D "okay";
> > +};
> > +
> > +/* J9 */
> > +&uart4 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_uart4>;
> > +     assigned-clocks =3D <&clk IMX8MM_CLK_UART4>;
> > +     status =3D "okay";
> > +};
> > +
> >  /* eMMC */
> >  &usdhc1 {
> >       bus-width =3D <8>;
> > @@ -353,6 +379,15 @@ MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20 0x16
> >               >;
> >       };
> >
> > +     pinctrl_uart1: uart1grp {
> > +             fsl,pins =3D <
> > +                     MX8MM_IOMUXC_UART1_RXD_UART1_DCE_RX 0x140
> > +                     MX8MM_IOMUXC_UART1_TXD_UART1_DCE_TX 0x140
> > +                     MX8MM_IOMUXC_UART3_RXD_UART1_DCE_CTS_B 0x140
> > +                     MX8MM_IOMUXC_UART3_TXD_UART1_DCE_RTS_B 0x140
> > +             >;
> > +     };
> > +
> >       pinctrl_uart2: uart2grp {
> >               fsl,pins =3D <
> >                       MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX 0x140
> > @@ -360,6 +395,22 @@ MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX 0x140
> >               >;
> >       };
> >
> > +     pinctrl_uart3: uart3grp {
> > +             fsl,pins =3D <
> > +                     MX8MM_IOMUXC_ECSPI1_SCLK_UART3_DCE_RX 0x140
> > +                     MX8MM_IOMUXC_ECSPI1_MOSI_UART3_DCE_TX 0x140
> > +                     MX8MM_IOMUXC_ECSPI1_SS0_UART3_DCE_RTS_B 0x140
> > +                     MX8MM_IOMUXC_ECSPI1_MISO_UART3_DCE_CTS_B 0x140
> > +             >;
> > +     };
> > +
> > +     pinctrl_uart4: uart4grp {
> > +             fsl,pins =3D <
> > +                     MX8MM_IOMUXC_UART4_RXD_UART4_DCE_RX 0x140
> > +                     MX8MM_IOMUXC_UART4_TXD_UART4_DCE_TX 0x140
> > +             >;
> > +     };
> > +
> >       pinctrl_usbotg1: usbotg1grp {
> >               fsl,pins =3D <
> >                       MX8MM_IOMUXC_GPIO1_IO12_USB1_OTG_PWR    0x16
> > @@ -370,7 +421,7 @@ MX8MM_IOMUXC_GPIO1_IO13_USB1_OTG_OC       0x156
> >       pinctrl_usbotg2: usbotg2grp {
> >               fsl,pins =3D <
> >                       MX8MM_IOMUXC_GPIO1_IO14_USB2_OTG_PWR    0x16
> > -                     MX8MM_IOMUXC_GPIO1_IO15_USB2_OTG_OC     0x156
> > +                     MX8MM_IOMUXC_GPIO1_IO15_USB2_OTG_OC     0x15
>
> This is not relevant to the topic.
>

Thanks, this was also a mistake at rebasing time.

> Best regards,
> Krzysztof

Best regards,
Adrien

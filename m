Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC633A7B11
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 11:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhFOJte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 05:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbhFOJta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 05:49:30 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED29C061574;
        Tue, 15 Jun 2021 02:47:24 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id q18so1325217ile.10;
        Tue, 15 Jun 2021 02:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LSF7fVkAyjfTfk+C4/blOksGWBjSPOMB2T0fLhOb1ik=;
        b=BIps0zIihdPtUJ4Rw/eFNV4Fy+ldVabnDNccVPqJmqaJk5jJsWZADljcNBDRnoWIm0
         dY16YwciESnDMjEbo34Yp/ljy1I+ZszI7o8/LjKaBgaXYswhy0GmZyzYvIfM0KFlNaRt
         zALlaeEfiSNTdI+QpNRrLRkH4X38jq+ly+f5AXZaqN/Mk6oRxwiV49vSFUZPrSPz8Cbq
         iswE1yIzIk4EWCOhPPP4doqXcPMzq0nQJbs614MD5EWXsXvQcueNQGSJ0W+tWBb6WUvS
         ELWAwIcJrU0PM/BlpkgnE2v942TBpi8LOv/r1LhB7GanQyPMHP2Xkk5N90F/6SsF7ZE7
         D5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LSF7fVkAyjfTfk+C4/blOksGWBjSPOMB2T0fLhOb1ik=;
        b=DfJiU+g8p8CQGBN2xKP1X+v7x0VQ3eE571d/lMa143LmgtSRvtRWBVUbiUlTiPbsDs
         0sGzVgi+uH3yAs6YBgHZ8TQrnqlB/2K0o3oAiJ+MwLFXH6zcsILmnN8rIFbKPI6P7GOj
         Z7UeAMpfG5+YRE5UreF+QrzR+tYUCrnHXfQBrLo+Oo0l5Nq5MiF4XRRzOVpY5lOGaulj
         aFqGxhm37j/TpWvhUcUABkGMn+DG9lyXBwmgrTd/2/YHRoC9DtkHM0cX3ClSijnUQl49
         IgT9GPp42qf95Er0v/dMlKxtRtU/MOTXBkF1ymzXGEaQhY+jlB/rmJ1PfOwlXpWB+Ej4
         g/EA==
X-Gm-Message-State: AOAM531O2esTzfw2DDWkAz62tqmbmuHMD76FpV2/eb5FlPrPhigyBJH+
        aXs9Fy6bxBScElGaEr2iFYEs9AphJr3PrAM+F6w=
X-Google-Smtp-Source: ABdhPJz90OnS76WibLN+/cJ/HQOhLIAVtRtXm4LWoDpjThLmvE4jOiV2B0gr6dGMtIOyUYmjoxRoIdXJNpqVr8rylnk=
X-Received: by 2002:a05:6e02:d51:: with SMTP id h17mr17487947ilj.177.1623750443818;
 Tue, 15 Jun 2021 02:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210418210003.2806-1-alistair@alistair23.me> <20210513133512.GZ3425@dragon>
In-Reply-To: <20210513133512.GZ3425@dragon>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Tue, 15 Jun 2021 19:46:57 +1000
Message-ID: <CAKmqyKPRo2vp50ENXZgXwro=G-wB8q9Qf02jF84VhTMbojgezw@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx7d-remarkable2.dts: Add WiFi support
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.co>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 11:35 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Mon, Apr 19, 2021 at 07:00:03AM +1000, Alistair Francis wrote:
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
>
> I would suggest you add some commit log, and have subject like below.
>
> ARM: dts: imx7d-remarkable2: Add WiFi support

Done!

>
> > ---
> >  arch/arm/boot/dts/imx7d-remarkable2.dts | 91 +++++++++++++++++++++++++
> >  1 file changed, 91 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
> > index 8cbae656395c..c3dda2b92fe6 100644
> > --- a/arch/arm/boot/dts/imx7d-remarkable2.dts
> > +++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
> > @@ -21,6 +21,27 @@ memory@80000000 {
> >               device_type = "memory";
> >               reg = <0x80000000 0x40000000>;
> >       };
> > +
> > +     reg_brcm: regulator-brcm {
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "brcm_reg";
> > +             regulator-min-microvolt = <3300000>;
> > +             regulator-max-microvolt = <3300000>;
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&pinctrl_brcm_reg>;
> > +             gpio = <&gpio6 13 GPIO_ACTIVE_HIGH>;
> > +             enable-active-high;
> > +             startup-delay-us = <150>;
> > +     };
> > +
> > +     wifi_pwrseq: wifi_pwrseq {
> > +             compatible = "mmc-pwrseq-simple";
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&pinctrl_wifi>;
> > +             reset-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
> > +             clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;
> > +             clock-names = "ext_clock";
> > +     };
> >  };
> >
> >  &clks {
> > @@ -56,6 +77,27 @@ &usbotg2 {
> >       status = "okay";
> >  };
> >
> > +&usdhc2 {
> > +     #address-cells = <1>;
> > +     #size-cells = <0>;
> > +     pinctrl-names = "default", "state_100mhz", "sleep";
> > +     pinctrl-0 = <&pinctrl_usdhc2>;
> > +     pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
>
> state_200mhz is missing.

Ah, sorry about that. Fixed.

Alistair

>
> Shawn
>
> > +     pinctrl-2 = <&pinctrl_usdhc2>;
> > +     mmc-pwrseq = <&wifi_pwrseq>;
> > +     vmmc-supply = <&reg_brcm>;
> > +     bus-width = <4>;
> > +     non-removable;
> > +     keep-power-in-suspend;
> > +     cap-power-off-card;
> > +     status = "okay";
> > +
> > +     brcmf: bcrmf@1 {
> > +             reg = <1>;
> > +             compatible = "brcm,bcm4329-fmac";
> > +     };
> > +};
> > +
> >  &usdhc3 {
> >       pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
> >       pinctrl-0 = <&pinctrl_usdhc3>;
> > @@ -76,6 +118,13 @@ &wdog1 {
> >  };
> >
> >  &iomuxc {
> > +     pinctrl_brcm_reg: brcmreggrp {
> > +             fsl,pins = <
> > +                     /* WIFI_PWR_EN */
> > +                     MX7D_PAD_SAI1_TX_BCLK__GPIO6_IO13       0x14
> > +             >;
> > +     };
> > +
> >       pinctrl_uart1: uart1grp {
> >               fsl,pins = <
> >                       MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX    0x79
> > @@ -90,6 +139,39 @@ MX7D_PAD_EPDC_DATA08__UART6_DCE_RX                0x79
> >               >;
> >       };
> >
> > +     pinctrl_usdhc2: usdhc2grp {
> > +             fsl,pins = <
> > +                     MX7D_PAD_SD2_CMD__SD2_CMD               0x59
> > +                     MX7D_PAD_SD2_CLK__SD2_CLK               0x19
> > +                     MX7D_PAD_SD2_DATA0__SD2_DATA0           0x59
> > +                     MX7D_PAD_SD2_DATA1__SD2_DATA1           0x59
> > +                     MX7D_PAD_SD2_DATA2__SD2_DATA2           0x59
> > +                     MX7D_PAD_SD2_DATA3__SD2_DATA3           0x59
> > +             >;
> > +     };
> > +
> > +     pinctrl_usdhc2_100mhz: usdhc2grp_100mhz {
> > +             fsl,pins = <
> > +                     MX7D_PAD_SD2_CMD__SD2_CMD               0x5a
> > +                     MX7D_PAD_SD2_CLK__SD2_CLK               0x1a
> > +                     MX7D_PAD_SD2_DATA0__SD2_DATA0           0x5a
> > +                     MX7D_PAD_SD2_DATA1__SD2_DATA1           0x5a
> > +                     MX7D_PAD_SD2_DATA2__SD2_DATA2           0x5a
> > +                     MX7D_PAD_SD2_DATA3__SD2_DATA3           0x5a
> > +             >;
> > +     };
> > +
> > +     pinctrl_usdhc2_200mhz: usdhc2grp_200mhz {
> > +             fsl,pins = <
> > +                     MX7D_PAD_SD2_CMD__SD2_CMD               0x5b
> > +                     MX7D_PAD_SD2_CLK__SD2_CLK               0x1b
> > +                     MX7D_PAD_SD2_DATA0__SD2_DATA0           0x5b
> > +                     MX7D_PAD_SD2_DATA1__SD2_DATA1           0x5b
> > +                     MX7D_PAD_SD2_DATA2__SD2_DATA2           0x5b
> > +                     MX7D_PAD_SD2_DATA3__SD2_DATA3           0x5b
> > +             >;
> > +     };
> > +
> >       pinctrl_usdhc3: usdhc3grp {
> >               fsl,pins = <
> >                       MX7D_PAD_SD3_CMD__SD3_CMD               0x59
> > @@ -143,4 +225,13 @@ pinctrl_wdog: wdoggrp {
> >                       MX7D_PAD_ENET1_COL__WDOG1_WDOG_ANY      0x74
> >               >;
> >       };
> > +
> > +     pinctrl_wifi: wifigrp {
> > +             fsl,pins = <
> > +                     /* WiFi Reg On */
> > +                     MX7D_PAD_SD2_CD_B__GPIO5_IO9            0x00000014
> > +                     /* WiFi Sleep 32k */
> > +                     MX7D_PAD_SD1_WP__CCM_CLKO2              0x00000014
> > +             >;
> > +     };
> >  };
> > --
> > 2.31.1
> >

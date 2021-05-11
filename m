Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9FF37AF69
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 21:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbhEKThi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 15:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbhEKThf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 15:37:35 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EC0C061761;
        Tue, 11 May 2021 12:36:27 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u21so31414300ejo.13;
        Tue, 11 May 2021 12:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=05zZZjc7y6WQTTPW2NVb4ONKI0/ly7nNr9xWWzLqImw=;
        b=UR+cNc7m19yoK94EtOFOiwy4y38mH3SoS/2MjVXwyuTYFaO0esWb94Tf/10mN8OQdl
         TeF7QmiLyRnz9skbSL2/78CpG9Rs/FjwtLJjDaNYJH0Z9ksQHFX+6Unan+J9UBadTQSw
         Avy2XOK7M7fedMbrdarqKG7eUeXBFKNZ9XnmCOqsdZiLJZD8fBMa4+SIime1/67QK7Ik
         fnYuStK7JWc201t5qEls0dqP+VFKjwkUzzfb4zlqeZDxohHyRFHmCmnKITckKtc7ihh8
         IFBINs3PXjWZ+HELF4KkJFLk8nlsWF0jjh/szJ85ZK9KmytxvtGrS6s7+BLUqVxjZBy5
         SnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=05zZZjc7y6WQTTPW2NVb4ONKI0/ly7nNr9xWWzLqImw=;
        b=rdIfTYm/4cTh9Ie/niBJX8WzxSd5kW8ABVU6bKKy2vf6JNswsj70Fo1wZEE5/xS0St
         rcJLi4oB+IXkfRoePVJXNRH386neSDmnhjyDXl7k/Bm9dbEjyyTGRq/vcqIzaW6kEniu
         StT8X+yYkvliFvwMESf1ncQIJF0zdCVYDl9fPLkAkiOIo6OdxpVQ3EapBEvempuZzCgf
         Lw8+W3PKExgossGTWc/kSn/+gyPxwW/HEd2WpghJbxu+CnpcAsoDz27JJr2+ctCF0VuN
         dNPYvOaP9k2LmerM/j92eJU9JfkC7pd982F0LJCjImLRMEMCSawveVljbqKkwWEFGJll
         5llA==
X-Gm-Message-State: AOAM533oiF9IllucbeQm5wU0nWLhodUaRvietWRCYxkjcDxK6k3tKnC9
        9pYZoLXk1ocJEZsxFiG+jwoaGgzrEIu3p74g2Kc=
X-Google-Smtp-Source: ABdhPJxHY6GRA0dJoJzZoKeRf9MaAI3VfRY0rnMJR/x2PcXGFZupMdAB/pmjWboB8R4mFZCz+WEphATULaGvHctI6nk=
X-Received: by 2002:a17:907:75f6:: with SMTP id jz22mr32971508ejc.504.1620761786072;
 Tue, 11 May 2021 12:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210331232356.2204476-1-adrien.grassein@gmail.com>
 <20210331232356.2204476-4-adrien.grassein@gmail.com> <20210511022725.GC3425@dragon>
In-Reply-To: <20210511022725.GC3425@dragon>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Tue, 11 May 2021 21:36:14 +0200
Message-ID: <CABkfQAHLttLVgOv29T0DRY1F=2z3k_K1f=40ZURLX4gE_tLXoQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] arm64: dts: imx8mq-nitrogen: add lt8912 MIPI-DSI
 to HDMI
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

Thanks for your review.

Le mar. 11 mai 2021 =C3=A0 04:27, Shawn Guo <shawnguo@kernel.org> a =C3=A9c=
rit :
>
> On Thu, Apr 01, 2021 at 01:23:55AM +0200, Adrien Grassein wrote:
> > Add support of the lt8912b in the DTB.
> > This adds the support of the DB_DSIHD daugther board from
> > Boundary Devices.
> >
> > Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> > ---
> >  .../boot/dts/freescale/imx8mq-nitrogen.dts    | 120 ++++++++++++++++++
> >  1 file changed, 120 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts b/arch/a=
rm64/boot/dts/freescale/imx8mq-nitrogen.dts
> > index 04992cbba56e..4ffd23ea705f 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
> > @@ -34,6 +34,19 @@ power {
> >               };
> >       };
> >
> > +     hdmi-connector {
> > +             compatible =3D "hdmi-connector";
> > +             ddc-i2c-bus =3D <&ddc_i2c_bus>;
> > +             label =3D "hdmi";
> > +             type =3D "a";
> > +
> > +             port {
> > +                     hdmi_connector_in: endpoint {
> > +                             remote-endpoint =3D <&lt8912_out>;
> > +                     };
> > +             };
> > +     };
> > +
> >       reg_usb_otg_vbus: regulator-usb-otg-vbus {
> >               compatible =3D "regulator-fixed";
> >               pinctrl-names =3D "default";
> > @@ -81,6 +94,9 @@ reg_vref_5v: regulator-vref-5v {
> >       };
> >  };
> >
> > +&dphy {
> > +     status =3D "okay";
> > +};
> >
> >  &fec1 {
> >       pinctrl-names =3D "default";
> > @@ -193,6 +209,97 @@ rtc@68 {
> >       };
> >  };
> >
> > +&i2c4 {
> > +     clock-frequency =3D <100000>;
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_i2c4>;
> > +     status =3D "okay";
> > +
> > +     pca9546: i2cmux9546@70 {
>
> Node name should be generic, so 9546 should be dropped from there?
>
> > +             compatible =3D "nxp,pca9546";
> > +             reg =3D <0x70>;
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +
> > +             i2c4@0 {
>
> Is number 4 really needed in node name?
>
I add 4 to keep it coherent with the DTS file (i2c1@0 for example).

> > +                     reg =3D <0>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +                     clock-frequency =3D <100000>;
> > +
> > +                     hdmi-bridge@48 {
> > +                             compatible =3D "lontium,lt8912b";
> > +                             reg =3D <0x48> ;
> > +                             reset-gpios =3D <&max7323 0 GPIO_ACTIVE_L=
OW>;
> > +
> > +                             ports {
> > +                                     #address-cells =3D <1>;
> > +                                     #size-cells =3D <0>;
> > +
> > +                                     port@0 {
> > +                                             reg =3D <0>;
> > +
> > +                                             hdmi_out_in: endpoint {
> > +                                                     data-lanes =3D <1=
 2 3 4>;
> > +                                                     remote-endpoint =
=3D <&mipi_dsi_out>;
> > +                                             };
> > +                                     };
> > +
> > +                                     port@1 {
> > +                                             reg =3D <1>;
> > +
> > +                                             lt8912_out: endpoint {
> > +                                                     remote-endpoint =
=3D <&hdmi_connector_in>;
> > +                                             };
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> > +             ddc_i2c_bus: i2c4@1 {
> > +                     reg =3D <1>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +                     clock-frequency =3D <100000>;
> > +             };
> > +
> > +             i2c4@3 {
> > +                     reg =3D <3>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +                     clock-frequency =3D <100000>;
> > +
> > +                     max7323: max7323@68 {
>
> Can we have a generic node name for this device?
>
> > +                             compatible =3D "maxim,max7323";
> > +                             pinctrl-names =3D "default";
> > +                             pinctrl-0 =3D <&pinctrl_max7323>;
> > +                             gpio-controller;
> > +                             reg =3D <0x68>;
> > +                             #gpio-cells =3D <2>;
> > +                     };
> > +             };
> > +     };
> > +};
> > +
> > +&lcdif {
> > +     status =3D "okay";
> > +};
> > +
> > +&mipi_dsi {
> > +     status =3D "okay";
>
> Move it to end of property list.
>
> > +     #address-cells =3D <1>;
> > +     #size-cells =3D <0>;
> > +
> > +     ports {
> > +             port@1 {
> > +                     reg =3D <1>;
>
> Newline between property and child node.
>
> Shawn
>
> > +                     mipi_dsi_out: endpoint {
> > +                             remote-endpoint =3D <&hdmi_out_in>;
> > +                     };
> > +             };
> > +     };
> > +};
> > +
> >  &uart1 { /* console */
> >       pinctrl-names =3D "default";
> >       pinctrl-0 =3D <&pinctrl_uart1>;
> > @@ -368,6 +475,19 @@ MX8MQ_IOMUXC_GPIO1_IO06_GPIO1_IO6                0=
x49
> >               >;
> >       };
> >
> > +     pinctrl_i2c4: i2c4grp {
> > +             fsl,pins =3D <
> > +                     MX8MQ_IOMUXC_I2C4_SCL_I2C4_SCL                  0=
x4000007f
> > +                     MX8MQ_IOMUXC_I2C4_SDA_I2C4_SDA                  0=
x4000007f
> > +             >;
> > +     };
> > +
> > +     pinctrl_max7323: max7323grp {
> > +             fsl,pins =3D <
> > +                     MX8MQ_IOMUXC_NAND_RE_B_GPIO3_IO15 0x19
> > +             >;
> > +     };
> > +
> >       pinctrl_reg_arm_dram: reg-arm-dramgrp {
> >               fsl,pins =3D <
> >                       MX8MQ_IOMUXC_SAI5_RXD3_GPIO3_IO24       0x16
> > --
> > 2.25.1
> >

The other comments are OK.
I will send you an updated patch set.

Thanks again,

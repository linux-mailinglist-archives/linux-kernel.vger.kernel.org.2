Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C354D307C66
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 18:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbhA1R1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 12:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbhA1RYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 12:24:32 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2A4C0613D6;
        Thu, 28 Jan 2021 09:23:46 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id rv9so8898458ejb.13;
        Thu, 28 Jan 2021 09:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xwqptOfKJOvj+WMHLITcBO/IWNTki2q4DL6qr9299OU=;
        b=O2lOg5F1byof2iwy7RNpBOLVHq35KxmxXUe/eu3vqZS+LBhxnaqfkcpZqtj/Seqb4D
         eZCIilDxB32FusahGrO70vr2itEQpwE7knO3T8GZlRzBIlnoZ++xv8KaP7W/AyHHSuvY
         GH1QGuIPpRyXNZYLyyHEW1NbZgzNjbopkAJqly+WydGeYaU6ZYiMzDMX2OfrD0bN9efh
         TfcAGum/NfV4v0PNLzcvGztoLRi7mRkfZFyVSDA9OOtHmJD0IMA35e5BDEhiBgHbcgGL
         dnKs3kMT0GqJxN2rGw9U2RCO/NEYQiktBy6L7+p3xA+79Fit5EAogN1T/aQ3MdvEQYzG
         3efw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xwqptOfKJOvj+WMHLITcBO/IWNTki2q4DL6qr9299OU=;
        b=Pc1PxACxUL9z7cJK0eaHCMOIGFuQb6RI5L3ttM6uuC3YpNNpKXfSF+dwFwTxaSvV2h
         G+VKaKCmZ7xYww/px7XOYyOvKuDeEYz3soMDKCdJ8BfAnWI33XastOAyX4u8aylJbwfu
         oE3Jmqp9RADhDlYJJNLOxU1fmKikHB4Y0K2tKaeUPW0CiCC+7VxR2/6EneDqinHH6ZiQ
         EB/2RaC2tOHmU/jW9JOgPp3b7CQNr+bwbBty9egIuhvVywpi8jTxnHCK9VkEwnMrNx+Z
         v4ihSZT0SJ++42g+1zKburqTb/MkNY37XraPvRlcRcAaDQZq6TMQYqYyR3WQ/F7xxZba
         C6DA==
X-Gm-Message-State: AOAM530nMV4T4mRQh5+skL9u4AkDVnZ8zLCoo77IP4FgTPTERdnK/shp
        3khM13ldANYHWoKShniIWXt4VX13Nm2Vf/XusdM=
X-Google-Smtp-Source: ABdhPJzxqD4RKkShBnqYxaiCw4nf63bgEIIp4IzUrMT21SILOGFGy8+quF93quMp8zBNTFBUhw7vMrxlc0/WEL/ruck=
X-Received: by 2002:a17:906:6407:: with SMTP id d7mr418294ejm.133.1611854625536;
 Thu, 28 Jan 2021 09:23:45 -0800 (PST)
MIME-Version: 1.0
References: <20210118111531.903154-1-adrien.grassein@gmail.com>
 <20210118111531.903154-3-adrien.grassein@gmail.com> <20210128161845.lvex3vh6xfa64b3h@pengutronix.de>
In-Reply-To: <20210128161845.lvex3vh6xfa64b3h@pengutronix.de>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Thu, 28 Jan 2021 18:23:34 +0100
Message-ID: <CABkfQAHDoFpJQSE3Ls5V_jyiq5N-VO=LvZbb+pvdCRZpm+PjwA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] arm64: dts: imx: Add i.mx8mm nitrogen8mm basic dts support
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     DTML <devicetree@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

Thanks for your time.

Le jeu. 28 janv. 2021 =C3=A0 17:18, Marco Felsch <m.felsch@pengutronix.de> =
a =C3=A9crit :
>
> Hi Adrien,
>
> thanks for the patch. I've made only a few comments inline.
>
> On 21-01-18 12:15, Adrien Grassein wrote:
> > Tested with a basic Build Root configuration booting from sdcard.
> >
> > Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> > Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  arch/arm64/boot/dts/freescale/Makefile        |   1 +
> >  .../dts/freescale/imx8mm-nitrogen8mm_rev2.dts | 395 ++++++++++++++++++
> >  2 files changed, 396 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_re=
v2.dts
> >
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/d=
ts/freescale/Makefile
> > index 38559943c15d..398b5cb4f3e2 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -49,6 +49,7 @@ dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-librem5-devkit.dtb
> >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-librem5-r2.dtb
> >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-librem5-r3.dtb
> >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-nitrogen.dtb
> > +dtb-$(CONFIG_ARCH_MXC) +=3D imx8mm-nitrogen8mm_rev2.dtb
> >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-phanbell.dtb
> >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-pico-pi.dtb
> >  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-thor96.dtb
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_rev2.dts =
b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_rev2.dts
> > new file mode 100644
> > index 000000000000..755088387ea5
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_rev2.dts
> > @@ -0,0 +1,395 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Device Tree file for Boundary Devices i.MX8MMini Nitrogen8MM Rev2 b=
oard.
> > + * Adrien Grassein <adrien.grassein@gmail.com.com>
> > + */
> > +/dts-v1/;
> > +#include "imx8mm.dtsi"
> > +
> > +/ {
> > +     model =3D "Boundary Devices i.MX8MMini Nitrogen8MM Rev2";
> > +     compatible =3D "boundary,imx8mm-nitrogen8mm", "fsl,imx8mm";
> > +};
> > +
> > +&A53_0 {
> > +     cpu-supply =3D <&reg_sw3>;
> > +};
> > +
> > +&A53_1 {
> > +     cpu-supply =3D <&reg_sw3>;
> > +};
> > +
> > +&A53_2 {
> > +     cpu-supply =3D <&reg_sw3>;
> > +};
> > +
> > +&A53_3 {
> > +     cpu-supply =3D <&reg_sw3>;
> > +};
> > +
> > +&fec1 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_fec1>;
> > +     phy-mode =3D "rgmii-id";
> > +     phy-handle =3D <&ethphy0>;
> > +     fsl,magic-packet;
> > +     status =3D "okay";
> > +
> > +     mdio {
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +
> > +             ethphy0: ethernet-phy@4 {
> > +                     compatible =3D "ethernet-phy-id004d.d072",
>                                                       ^
>                         Do we really need to add the id here?

Yes, I don't know why, but the chip it's not recognized via the mdio interf=
ace.
I will do further tests but I think it's needed.

> > +                             "ethernet-phy-ieee802.3-c22";
> > +                     reg =3D <4>;
> > +                     interrupts-extended =3D <&gpio3 16 IRQ_TYPE_LEVEL=
_LOW>;
> > +             };
> > +     };
> > +};
> > +
> > +&i2c1 {
> > +     clock-frequency =3D <400000>;
>                             ^
>                 Is the i2c errata fixed on the imx8?

I don't know. What is this errata?
Should I set a lower speed for the particular i2c?

>
> > +     pinctrl-names =3D "default", "gpio";
>                                      ^
>                         no pinctrl for gpio.

Yes, it's a bug, thanks

> > +     pinctrl-0 =3D <&pinctrl_i2c1>;
> > +     status =3D "okay";
> > +
> > +     pmic@8 {
> > +             compatible =3D "nxp,pf8121a";
> > +             reg =3D <0x8>;
> > +
> > +             regulators {
> > +                 reg_ldo1: ldo1 {
>                         ^
>                    alignment

OK

> > +                             regulator-min-microvolt =3D <1500000>;
> > +                             regulator-max-microvolt =3D <5000000>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     reg_ldo2: ldo2 {
> > +                             regulator-min-microvolt =3D <1500000>;
> > +                             regulator-max-microvolt =3D <5000000>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     reg_ldo3: ldo3 {
> > +                             regulator-min-microvolt =3D <1500000>;
> > +                             regulator-max-microvolt =3D <5000000>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     reg_ldo4: ldo4 {
> > +                             regulator-min-microvolt =3D <1500000>;
> > +                             regulator-max-microvolt =3D <5000000>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     reg_buck1: buck1 {
> > +                             regulator-min-microvolt =3D <400000>;
> > +                             regulator-max-microvolt =3D <1800000>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     reg_buck2: buck2 {
> > +                             regulator-min-microvolt =3D <400000>;
> > +                             regulator-max-microvolt =3D <1800000>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     reg_sw3: buck3 {
> > +                             regulator-min-microvolt =3D <400000>;
> > +                             regulator-max-microvolt =3D <1800000>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     reg_buck4: buck4 {
> > +                             regulator-min-microvolt =3D <400000>;
> > +                             regulator-max-microvolt =3D <1800000>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     reg_buck5: buck5 {
> > +                             regulator-min-microvolt =3D <400000>;
> > +                             regulator-max-microvolt =3D <1800000>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     reg_buck6: buck6 {
> > +                             regulator-min-microvolt =3D <400000>;
> > +                             regulator-max-microvolt =3D <1800000>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     reg_buck7: buck7 {
> > +                             regulator-min-microvolt =3D <3300000>;
> > +                             regulator-max-microvolt =3D <3300000>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                     };
> > +
> > +                     reg_vsnvs: vsnvs {
> > +                             regulator-min-microvolt =3D <1800000>;
> > +                             regulator-max-microvolt =3D <3300000>;
> > +                             regulator-boot-on;
> > +                             regulator-always-on;
> > +                     };
>
> Do we really need to have all regulators marked as always-on?
>
I used the definition present on the example.
I will remove this (for the one I don't use).
> > +             };
> > +     };
> > +};
> > +
> > +&i2c3 {
> > +     clock-frequency =3D <100000>;
> > +     pinctrl-names =3D "default", "gpio";
> > +     pinctrl-0 =3D <&pinctrl_i2c3>;
> > +     status =3D "okay";
> > +
> > +     i2cmux@70 {
> > +             compatible =3D "nxp,pca9540";
> > +             reg =3D <0x70>;
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <0>;
> > +
> > +             i2c3 {
> > +                     reg =3D <0>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <0>;
> > +
> > +                     rtc@68 {
> > +                             compatible =3D "microcrystal,rv4162";
> > +                             pinctrl-names =3D "default";
> > +                             pinctrl-0 =3D <&pinctrl_i2c3a_rv4162>;
> > +                             reg =3D <0x68>;
>
> reg should be the 2nd property, after the compatible.
>
OK.

> > +                             interrupts-extended =3D <&gpio4 22 IRQ_TY=
PE_LEVEL_LOW>;
> > +                             wakeup-source;
> > +                     };
> > +             };
> > +     };
> > +};
> > +
> > +/* console */
> > +&uart2 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_uart2>;
> > +     assigned-clocks =3D <&clk IMX8MM_CLK_UART2>;
> > +     assigned-clock-parents =3D <&clk IMX8MM_CLK_24M>;
> > +     status =3D "okay";
> > +};
> > +
> > +/* eMMC */
> > +&usdhc1 {
> > +     bus-width =3D <8>;
> > +     sdhci-caps-mask =3D <0x80000000 0x0>;
>                 ^
> This is a SD host controller property according the doc.
>
Yes, I don't understand the point, sorry.
This property is read by the host driver, but should be present here
(like in some other dts).

> > +     non-removable;
> > +     pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> > +     pinctrl-0 =3D <&pinctrl_usdhc1>;
> > +     pinctrl-1 =3D <&pinctrl_usdhc1_100mhz>;
> > +     pinctrl-2 =3D <&pinctrl_usdhc1_200mhz>;
> > +     status =3D "okay";
> > +};
> > +
> > +/* sdcard */
> > +&usdhc2 {
> > +     bus-width =3D <4>;
> > +     cd-gpios =3D <&gpio2 12 GPIO_ACTIVE_LOW>;
> > +     pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> > +     pinctrl-0 =3D <&pinctrl_usdhc2>;
> > +     pinctrl-1 =3D <&pinctrl_usdhc2_100mhz>;
> > +     pinctrl-2 =3D <&pinctrl_usdhc2_200mhz>;
> > +     vqmmc-supply =3D <&reg_ldo2>;
> > +     status =3D "okay";
> > +};
> > +
> > +&wdog1 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_wdog>;
> > +     fsl,ext-reset-output;
> > +     status =3D "okay";
> > +};
> > +
> > +&iomuxc {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&pinctrl_hog>;
>
> It would be nice to avoid such hog's. Instead those gpios should get
> configured by the device(s) using those.
>
Once again (sorry), I don't understand the point.
I did this like any other imx8 board (imx8mq-nitrogem for example).

> Regards,
>   Marco
>
> > +
> > +     pinctrl_fec1: fec1grp {
> > +             fsl,pins =3D <
> > +                     MX8MM_IOMUXC_ENET_MDC_ENET1_MDC                 0=
x3
> > +                     MX8MM_IOMUXC_ENET_MDIO_ENET1_MDIO               0=
x3
> > +                     MX8MM_IOMUXC_ENET_TD3_ENET1_RGMII_TD3           0=
x1f
> > +                     MX8MM_IOMUXC_ENET_TD2_ENET1_RGMII_TD2           0=
x1f
> > +                     MX8MM_IOMUXC_ENET_TD1_ENET1_RGMII_TD1           0=
x1f
> > +                     MX8MM_IOMUXC_ENET_TD0_ENET1_RGMII_TD0           0=
x1f
> > +                     MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3           0=
x91
> > +                     MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2           0=
x91
> > +                     MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1           0=
x91
> > +                     MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0           0=
x91
> > +                     MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC           0=
x1f
> > +                     MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC           0=
x91
> > +                     MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL     0=
x91
> > +                     MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL     0=
x1f
> > +                     MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16            0=
x159
> > +             >;
> > +     };
> > +
> > +     pinctrl_hog: hoggrp {
> > +             fsl,pins =3D <
> > +                     MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3 0x09
> > +                     MX8MM_IOMUXC_GPIO1_IO08_GPIO1_IO8 0x09
> > +             >;
> > +     };
> > +
> > +     pinctrl_i2c1: i2c1grp {
> > +             fsl,pins =3D <
> > +                     MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL 0x400001c3
> > +                     MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA 0x400001c3
> > +             >;
> > +     };
> > +
> > +     pinctrl_i2c3: i2c3grp {
> > +             fsl,pins =3D <
> > +                     MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL 0x400001c3
> > +                     MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA 0x400001c3
> > +             >;
> > +     };
> > +
> > +     pinctrl_i2c3a_rv4162: i2c3a-rv4162grp {
> > +             fsl,pins =3D <
> > +                     MX8MM_IOMUXC_SAI2_RXC_GPIO4_IO22 0x1c0
> > +             >;
> > +     };
> > +
> > +     pinctrl_uart2: uart2grp {
> > +             fsl,pins =3D <
> > +                     MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX 0x140
> > +                     MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX 0x140
> > +             >;
> > +     };
> > +
> > +     pinctrl_usdhc1: usdhc1grp {
> > +             fsl,pins =3D <
> > +                     MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK         0x190
> > +                     MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD         0x1d0
> > +                     MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0     0x1d0
> > +                     MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1     0x1d0
> > +                     MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2     0x1d0
> > +                     MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3     0x1d0
> > +                     MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4     0x1d0
> > +                     MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5     0x1d0
> > +                     MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6     0x1d0
> > +                     MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7     0x1d0
> > +                     MX8MM_IOMUXC_SD1_RESET_B_GPIO2_IO10     0x141
> > +             >;
> > +     };
> > +
> > +     pinctrl_usdhc1_100mhz: usdhc1-100mhz-grp {
> > +             fsl,pins =3D <
> > +                     MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK         0x194
> > +                     MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD         0x1d4
> > +                     MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0     0x1d4
> > +                     MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1     0x1d4
> > +                     MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2     0x1d4
> > +                     MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3     0x1d4
> > +                     MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4     0x1d4
> > +                     MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5     0x1d4
> > +                     MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6     0x1d4
> > +                     MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7     0x1d4
> > +             >;
> > +     };
> > +
> > +     pinctrl_usdhc1_200mhz: usdhc1-200mhz-grp {
> > +             fsl,pins =3D <
> > +                     MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK         0x196
> > +                     MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD         0x1d6
> > +                     MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0     0x1d6
> > +                     MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1     0x1d6
> > +                     MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2     0x1d6
> > +                     MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3     0x1d6
> > +                     MX8MM_IOMUXC_SD1_DATA4_USDHC1_DATA4     0x1d6
> > +                     MX8MM_IOMUXC_SD1_DATA5_USDHC1_DATA5     0x1d6
> > +                     MX8MM_IOMUXC_SD1_DATA6_USDHC1_DATA6     0x1d6
> > +                     MX8MM_IOMUXC_SD1_DATA7_USDHC1_DATA7     0x1d6
> > +             >;
> > +     };
> > +
> > +     pinctrl_usdhc2: usdhc2grp {
> > +             fsl,pins =3D <
> > +                     MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK         0x190
> > +                     MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD         0x1d0
> > +                     MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0     0x1d0
> > +                     MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1     0x1d0
> > +                     MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2     0x1d0
> > +                     MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3     0x1d0
> > +                     MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12        0x1c4
> > +             >;
> > +     };
> > +
> > +     pinctrl_usdhc2_100mhz: usdhc2-100mhz-grp {
> > +             fsl,pins =3D <
> > +                     MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK         0x194
> > +                     MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD         0x1d4
> > +                     MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0     0x1d4
> > +                     MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1     0x1d4
> > +                     MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2     0x1d4
> > +                     MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3     0x1d4
> > +             >;
> > +     };
> > +
> > +     pinctrl_usdhc2_200mhz: usdhc2-200mhz-grp {
> > +             fsl,pins =3D <
> > +                     MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK         0x196
> > +                     MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD         0x1d6
> > +                     MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0     0x1d6
> > +                     MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1     0x1d6
> > +                     MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2     0x1d6
> > +                     MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3     0x1d6
> > +             >;
> > +     };
> > +
> > +     pinctrl_usdhc3: usdhc3grp {
> > +             fsl,pins =3D <
> > +                     MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK               0=
x190
> > +                     MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD               0=
x1d0
> > +                     MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0           0=
x1d0
> > +                     MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1           0=
x1d0
> > +                     MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2           0=
x1d0
> > +                     MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3           0=
x1d0
> > +                     MX8MM_IOMUXC_GPIO1_IO00_ANAMIX_REF_CLK_32K      0=
x03
> > +             >;
> > +     };
> > +
> > +     pinctrl_usdhc3_100mhz: usdhc3-100mhz-grp {
> > +             fsl,pins =3D <
> > +                     MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK       0x194
> > +                     MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD       0x1d4
> > +                     MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0   0x1d4
> > +                     MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1   0x1d4
> > +                     MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2   0x1d4
> > +                     MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3   0x1d4
> > +             >;
> > +     };
> > +
> > +     pinctrl_usdhc3_200mhz: usdhc3-200mhz-grp {
> > +             fsl,pins =3D <
> > +                     MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK       0x196
> > +                     MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD       0x1d6
> > +                     MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0   0x1d6
> > +                     MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1   0x1d6
> > +                     MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2   0x1d6
> > +                     MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3   0x1d6
> > +             >;
> > +     };
> > +
> > +     pinctrl_wdog: wdoggrp {
> > +             fsl,pins =3D <
> > +                     MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B 0x140
> > +             >;
> > +     };
> > +};
> > --
> > 2.25.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
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

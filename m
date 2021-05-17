Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9183825E6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 09:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbhEQHzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 03:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhEQHzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 03:55:03 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F747C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 00:53:47 -0700 (PDT)
Received: from ktm (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id AA3E88065C;
        Mon, 17 May 2021 09:53:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1621238023;
        bh=+oFOD5axhaR2QxMG/99ig+HlPXW2khmyuitHw6lo6LM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bq2sKYA76WIFNjvTHI33ZleQuK0cIxTIQmLd8iI3Jkzdy0WCtjf2oMMvKSDOacpw2
         Jx966G31FJqNY7APQ1aW+NqDaIVO/Y5xPfkSe7tZmzEA4E7JHKg0LdkwXwKdASjcsF
         BdTHU9jWo5hbwQzP4IiuKutkY3+lvYW/V19mqWlHHktesCu5praOHz98zFdPRaOf+Z
         mXGdVXsZvtnFBQrllVJR/zJXk/co0/jLfnPTwQBahFvxpFAiY2OfWOrox5lDv89FLJ
         xU4ln/pn2zbx1DTooxl7HbZrX9HFE8etLIBWD/4R8p8mL3JAkdjtxu4aHS0O1XHQzN
         md0hy39jNiS3Q==
Date:   Mon, 17 May 2021 09:53:33 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: imx28: Add DTS description of imx28 based
 XEA board
Message-ID: <20210517095333.48d811be@ktm>
In-Reply-To: <20210513033631.GL3425@dragon>
References: <20210409122036.31628-1-lukma@denx.de>
        <20210513033631.GL3425@dragon>
Organization: denx.de
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/pqViHQNJP4pms0nw.KJFIvk"; protocol="application/pgp-signature"
X-Virus-Scanned: clamav-milter 0.102.4 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pqViHQNJP4pms0nw.KJFIvk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

Thank you for your feedback.

> On Fri, Apr 09, 2021 at 02:20:36PM +0200, Lukasz Majewski wrote:
> > This patch adds DTS definition of the imx278 based XEA board.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> >=20
> > ---
> > Changes for v2:
> > - Fix 'memory' node and remove regulators subnode
> > - Rename 'flash0: s25fl256s0@0' to flash@0
> > - Add proper compatible for XEA board
> > ---
> >  arch/arm/boot/dts/Makefile       |   3 +-
> >  arch/arm/boot/dts/imx28-lwe.dtsi | 174
> > +++++++++++++++++++++++++++++++ arch/arm/boot/dts/imx28-xea.dts  |
> > 99 ++++++++++++++++++ 3 files changed, 275 insertions(+), 1
> > deletion(-) create mode 100644 arch/arm/boot/dts/imx28-lwe.dtsi
> >  create mode 100644 arch/arm/boot/dts/imx28-xea.dts
> >=20
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 8e5d4ab4e75e..d2398a090e4d 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -721,7 +721,8 @@ dtb-$(CONFIG_ARCH_MXS) +=3D \
> >  	imx28-m28evk.dtb \
> >  	imx28-sps1.dtb \
> >  	imx28-ts4600.dtb \
> > -	imx28-tx28.dtb
> > +	imx28-tx28.dtb \
> > +	imx28-xea.dtb
> >  dtb-$(CONFIG_ARCH_NOMADIK) +=3D \
> >  	ste-nomadik-s8815.dtb \
> >  	ste-nomadik-nhk15.dtb
> > diff --git a/arch/arm/boot/dts/imx28-lwe.dtsi
> > b/arch/arm/boot/dts/imx28-lwe.dtsi new file mode 100644
> > index 000000000000..2d14a8ae91f8
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx28-lwe.dtsi
> > @@ -0,0 +1,174 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> > +/*
> > + * Copyright 2021
> > + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> > + */
> > +
> > +/dts-v1/;
> > +#include "imx28.dtsi"
> > +
> > +/ {
> > +	aliases {
> > +		spi2 =3D &ssp3;
> > +	};
> > +
> > +	chosen {
> > +		bootargs =3D "root=3D/dev/mmcblk0p2 rootfstype=3Dext4 ro
> > rootwait console=3DttyAMA0,115200 panic=3D1"; =20
>=20
> Shouldn't it come from bootloader?

This is used when we start from the "Falcon boot". It is usefull to
have such "fallback" in the dtb.

>=20
> > +	};
> > +
> > +	memory@0x40000000 { =20
>=20
> memory@40000000
>=20
> > +		reg =3D <0x40000000 0x08000000>;
> > +	};
> > +
> > +	reg_3v3: regulator-reg-3v3 {
> > +		compatible =3D "regulator-fixed";
> > +		regulator-name =3D "3V3";
> > +		regulator-min-microvolt =3D <3300000>;
> > +		regulator-max-microvolt =3D <3300000>;
> > +		regulator-always-on; =20
>=20
> regulator-always-on makes no sense to a regulator that doesn't on/off
> control at all.

I think that this is some kind of leftover from U-Boot specific dts.

I will remove it.

>=20
> > +	};
> > +
> > +	reg_usb_5v: regulator-reg-usb-5v {
> > +		compatible =3D "regulator-fixed";
> > +		regulator-name =3D "usb_vbus";
> > +		regulator-min-microvolt =3D <5000000>;
> > +		regulator-max-microvolt =3D <5000000>;
> > +		enable-active-high; =20
>=20
> enable-active-high is meaningful only when there is a GPIO controlling
> on/off.

Thanks for the tip - I've removed it.

>=20
> > +	};
> > +
> > +	reg_fec_3v3: regulator-reg-fec-3v3 {
> > +		compatible =3D "regulator-fixed";
> > +		regulator-name =3D "fec-phy";
> > +		regulator-min-microvolt =3D <3300000>;
> > +		regulator-max-microvolt =3D <3300000>;
> > +		enable-active-high;
> > +		regulator-boot-on; =20
>=20
> Ditto
>=20
> > +	};
> > +};
> > +
> > +&duart {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&duart_pins_a>;
> > +	status =3D "okay";
> > +};
> > +
> > +&i2c0 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&i2c0_pins_a>;
> > +	status =3D "okay";
> > +};
> > +
> > +&saif0 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&saif0_pins_a>;
> > +	#sound-dai-cells =3D <0>;
> > +	assigned-clocks =3D <&clks 53>;
> > +	assigned-clock-rates =3D <12000000>;
> > +	status =3D "okay";
> > +};
> > +
> > +&saif1 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&saif1_pins_a>;
> > +	fsl,saif-master =3D <&saif0>;
> > +	#sound-dai-cells =3D <0>;
> > +	status =3D "okay";
> > +};
> > +
> > +&spi3_pins_a {
> > +	fsl,pinmux-ids =3D <
> > +		MX28_PAD_AUART2_RX__SSP3_D4
> > +		MX28_PAD_AUART2_TX__SSP3_D5
> > +		MX28_PAD_SSP3_SCK__SSP3_SCK
> > +		MX28_PAD_SSP3_MOSI__SSP3_CMD
> > +		MX28_PAD_SSP3_MISO__SSP3_D0
> > +		MX28_PAD_SSP3_SS0__SSP3_D3
> > +		MX28_PAD_AUART2_TX__GPIO_3_9
> > +	>;
> > +};
> > +
> > +&ssp3 {
> > +	compatible =3D "fsl,imx28-spi";
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&spi3_pins_a>;
> > +	status =3D "okay";
> > +
> > +	flash@0 {
> > +		compatible =3D "jedec,spi-nor";
> > +		spi-max-frequency =3D <40000000>;
> > +		reg =3D <0>;
> > +
> > +		partitions {
> > +			compatible =3D "fixed-partitions";
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <1>;
> > +
> > +			partition@0 {
> > +				label =3D "u-boot";
> > +				reg =3D <0 0x80000>;
> > +				read-only;
> > +			};
> > +
> > +			partition@80000 {
> > +				label =3D "env0";
> > +				reg =3D <0x80000 0x10000>;
> > +			};
> > +
> > +			partition@90000 {
> > +				label =3D "env1";
> > +				reg =3D <0x90000 0x10000>;
> > +			};
> > +
> > +			partition@100000 {
> > +				label =3D "kernel";
> > +				reg =3D <0x100000 0x400000>;
> > +			};
> > +
> > +			partition@500000 {
> > +				label =3D "swupdate";
> > +				reg =3D <0x500000 0x800000>;
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&ssp2 {
> > +	compatible =3D "fsl,imx28-spi";
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&spi2_pins_a>;
> > +	status =3D "okay";
> > +};
> > +
> > +&ssp0 {
> > +	compatible =3D "fsl,imx28-mmc";
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&mmc0_8bit_pins_a>;
> > +	bus-width =3D <8>;
> > +	vmmc-supply =3D <&reg_3v3>;
> > +	non-removable;
> > +	status =3D "okay";
> > +}; =20
>=20
> The order should be like:
>=20
> &ssp0
> &ssp2
> &ssp3

Ok

>=20
> > +
> > +&usb0 {
> > +	vbus-supply =3D <&reg_usb_5v>;
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&usb0_pins_b>, <&usb0_id_pins_a>;
> > +	dr_mode =3D "host";
> > +	status =3D "okay";
> > +};
> > +
> > +&usbphy0 {
> > +	status =3D "okay";
> > +};
> > +
> > +&usb1 {
> > +	vbus-supply =3D <&reg_usb_5v>;
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&usb1_pins_b>;
> > +	dr_mode =3D "host";
> > +	status =3D "okay";
> > +};
> > +
> > +&usbphy1 {
> > +	status =3D "okay";
> > +};
> > diff --git a/arch/arm/boot/dts/imx28-xea.dts
> > b/arch/arm/boot/dts/imx28-xea.dts new file mode 100644
> > index 000000000000..a400c108f66a
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx28-xea.dts
> > @@ -0,0 +1,99 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> > +/*
> > + * Copyright 2021
> > + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> > + */
> > +
> > +/dts-v1/;
> > +#include "imx28-lwe.dtsi"
> > +
> > +/ {
> > +	compatible =3D "lwn,imx28-xea", "fsl,imx28"; =20
>=20
> Compatible needs to be documented.
>=20
> > +};
> > +
> > +&can0 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&can1_pins_a>;
> > +	status =3D "okay";
> > +};
> > +
> > +&i2c1 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&i2c1_pins_b>;
> > +	status =3D "okay";
> > +};
> > +
> > +&pinctrl {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&hog_pins_a &hog_pins_tiva>;
> > +
> > +	hog_pins_a: hog@0 {
> > +		reg =3D <0>;
> > +		fsl,pinmux-ids =3D <
> > +			MX28_PAD_GPMI_D00__GPIO_0_0
> > +			MX28_PAD_GPMI_D02__GPIO_0_2
> > +			MX28_PAD_GPMI_D05__GPIO_0_5
> > +			MX28_PAD_GPMI_CE1N__GPIO_0_17
> > +			MX28_PAD_GPMI_RDY0__GPIO_0_20
> > +			MX28_PAD_GPMI_RDY1__GPIO_0_21
> > +			MX28_PAD_GPMI_RDY2__GPIO_0_22
> > +			MX28_PAD_GPMI_RDN__GPIO_0_24
> > +			MX28_PAD_GPMI_CLE__GPIO_0_27
> > +			MX28_PAD_LCD_VSYNC__GPIO_1_28
> > +			MX28_PAD_SSP1_SCK__GPIO_2_12
> > +			MX28_PAD_SSP1_CMD__GPIO_2_13
> > +			MX28_PAD_SSP2_SS1__GPIO_2_20
> > +			MX28_PAD_SSP2_SS2__GPIO_2_21
> > +			MX28_PAD_LCD_D00__GPIO_1_0
> > +			MX28_PAD_LCD_D01__GPIO_1_1
> > +			MX28_PAD_LCD_D02__GPIO_1_2
> > +			MX28_PAD_LCD_D03__GPIO_1_3
> > +			MX28_PAD_LCD_D04__GPIO_1_4
> > +			MX28_PAD_LCD_D05__GPIO_1_5
> > +			MX28_PAD_LCD_D06__GPIO_1_6
> > +		>;
> > +		fsl,drive-strength =3D <MXS_DRIVE_4mA>;
> > +		fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
> > +		fsl,pull-up =3D <MXS_PULL_DISABLE>;
> > +	};
> > +
> > +	hog_pins_tiva: hog@1 {
> > +		reg =3D <1>;
> > +		fsl,pinmux-ids =3D <
> > +			MX28_PAD_GPMI_RDY3__GPIO_0_23
> > +			MX28_PAD_GPMI_WRN__GPIO_0_25
> > +		>;
> > +		fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
> > +		fsl,pull-up =3D <MXS_PULL_DISABLE>;
> > +	};
> > +
> > +	hog_pins_coding: hog@2 {
> > +		reg =3D <2>;
> > +		fsl,pinmux-ids =3D <
> > +			MX28_PAD_GPMI_D01__GPIO_0_1
> > +			MX28_PAD_GPMI_D03__GPIO_0_3
> > +			MX28_PAD_GPMI_D04__GPIO_0_4
> > +			MX28_PAD_GPMI_D06__GPIO_0_6
> > +			MX28_PAD_GPMI_D07__GPIO_0_7
> > +		>;
> > +		fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
> > +		fsl,pull-up =3D <MXS_PULL_DISABLE>;
> > +	};
> > +};
> > +
> > +&reg_fec_3v3 {
> > +	gpio =3D <&gpio0 0 0>;
> > +};
> > +
> > +&reg_usb_5v {
> > +	gpio =3D <&gpio0 2 0>;
> > +};
> > +
> > +&spi2_pins_a { =20
>=20
> Out of order.

As fair as I can tell it is alphabethically ordered.

I need to put this here (in the imx28-xea.dts file) as the spi2 has
different wiring for other board, which I also plan to upstream.

>=20
> Shawn
>=20
> > +	fsl,pinmux-ids =3D <
> > +		MX28_PAD_SSP2_SCK__SSP2_SCK
> > +		MX28_PAD_SSP2_MOSI__SSP2_CMD
> > +		MX28_PAD_SSP2_MISO__SSP2_D0
> > +		MX28_PAD_SSP2_SS0__GPIO_2_19
> > +	>;
> > +};
> > --=20
> > 2.20.1
> >  =20



Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/pqViHQNJP4pms0nw.KJFIvk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmCiIP0ACgkQAR8vZIA0
zr2/bwf/eG7aBbjCqGzEYF33xGuQKpoGq6PqHDjJGnu5ImwzW4dSbAf8AIzbqmct
EeKyjd2oJBea3oEP5OV5WewB+/M0LnYjGVo4K26BqhMRoXdn9AqJHnE+zL4Mf5ns
eSagg72kotrJZNHLmHY/HOFo4XYl3dwHGpQ+SJqtc+o67qZtER29MxDzLMLDpdv3
JHWNGAyHgvINjcAU+aNHqoxw8+YDdlm/yC4JQsz4okCqH55JMXDh/Y8HBks5fzel
lyZ4LZFRodOockOQy++Bo0wNQC84smqLYHz1FTmEpxJEYpbtIugj53OlYpJnFuxa
fk71ybArPvhHDzS7gbObrlTPD1Vn0Q==
=miD2
-----END PGP SIGNATURE-----

--Sig_/pqViHQNJP4pms0nw.KJFIvk--

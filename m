Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6189631F8A8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 12:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhBSLwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 06:52:19 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:33693 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230144AbhBSLwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 06:52:16 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id BF72858017B;
        Fri, 19 Feb 2021 06:51:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 19 Feb 2021 06:51:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=aZern2yKBkAYfT9tSyK4y/aYiC2
        GCcYVc0aQT81xeHw=; b=UK68A0rIVZrH6G9Y+0w0XT5pM0OV8NE+quAmg0XT6qA
        3Olbig5PU39gxOg/MdZZHlBbIeHLKlrFn3sX6WbhE0OpPVuF24phUoXcyHYag6s0
        cDP3WWaEYlddDtmGdJCEV96i+WM9kFHMR8I65cRgRxBlX3cHhvnp7GZdu+MtPmma
        6rdMqw9T4sAKwvz2HmFLGV9U/twe0pb4aurl5zhfL9AVRICzbKEkmLxurTXRM9L+
        3LlEEoPVtD3muv9TDV8X2TwI+D6+ApdGM6YD3tFoNb6MejRWlnLD98KPPrKudE8h
        Bj6IFe8ExUvPgUKjTadcWd7zOb/RED4lz+WOdoqE0Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=aZern2
        yKBkAYfT9tSyK4y/aYiC2GCcYVc0aQT81xeHw=; b=kzkNuBxBlDx3vpbYeGVS4T
        BD3XNKpE7df0iyskfEECt2uxZl9C4z8HMJaGJ1fyBQsOh5eQZHUaCfQVCg2EllV4
        cBKSbpCnkD9Csl4zGzd2YAFQoygUdoYF5OmY+4pNjUkhqo4TIyEx9Vp192HAcnNt
        oSZqJJcdy13eZXtQwCKOFwZfUOtSiYIGRuR2P7uLu3oJqofZ2zb/0Mh/Um6mhFM5
        xUOyD8vnMtsgvt6azDuxvAGbuJP6xlQbjp6jTh61g/pK6/8yRYhFjiSlwLZ466z7
        eCMobWqp6krep6rK19IH/pS42uMadQXFP5npr9opRPIh6drBylbDvHcIziEslPIw
        ==
X-ME-Sender: <xms:P6YvYId7T8bQfzfqvs6n-7yaEM0dBaHmLLzoFIy0aMfmxSjbROEJ1Q>
    <xme:P6YvYKP-PBO_RAqwATVDJcpoHlDZgmFTF2Czggr4S5LTe6WwYNvlK0psXT5q_Y9hG
    bi1OTmrZPEQAgz43WQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrjeeigdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:P6YvYJg1Yw3wyzosPbX-VRDn2CSO8pePHe3a9qH-bQ_UGgt_6kOoXQ>
    <xmx:P6YvYN_NZ1KpyII-3Pd_jHFNOOMVfYDXekemSbYHmJ7OEz3Zeh2UiQ>
    <xmx:P6YvYEvGAMFlHhWwe-ulbLpsGOaxHLO-lCasCIUQnV7UYyC2SsaTgA>
    <xmx:QaYvYEERBNKaC-HgmSNQvfVkK-GzGBldl2y1gJ_WneIfaEjrQgH6mA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6A68E240065;
        Fri, 19 Feb 2021 06:51:27 -0500 (EST)
Date:   Fri, 19 Feb 2021 12:51:24 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Pascal Roeleven <dev@pascalroeleven.nl>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Martin Cerveny <m.cerveny@computer.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH RESEND v3 2/2] ARM: dts: sun4i: Add support for Topwise
 A721 tablet
Message-ID: <20210219115124.lneiioiksjflbsuo@gilmour>
References: <20210216165954.43135-1-dev@pascalroeleven.nl>
 <20210216165954.43135-3-dev@pascalroeleven.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mtxopajle64dkerr"
Content-Disposition: inline
In-Reply-To: <20210216165954.43135-3-dev@pascalroeleven.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mtxopajle64dkerr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 16, 2021 at 05:59:54PM +0100, Pascal Roeleven wrote:
> The Topwise A721/LY-F1 tablet is a tablet sold around 2012 under
> different brands. The mainboard mentions A721 clearly, so this tablet
> is best known under this name.
>=20
> Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>
> ---
>  arch/arm/boot/dts/Makefile                   |   3 +-
>  arch/arm/boot/dts/sun4i-a10-topwise-a721.dts | 242 +++++++++++++++++++
>  2 files changed, 244 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/sun4i-a10-topwise-a721.dts
>=20
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 3d1ea0b251..ba25b4235a 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1103,7 +1103,8 @@ dtb-$(CONFIG_MACH_SUN4I) +=3D \
>  	sun4i-a10-olinuxino-lime.dtb \
>  	sun4i-a10-pcduino.dtb \
>  	sun4i-a10-pcduino2.dtb \
> -	sun4i-a10-pov-protab2-ips9.dtb
> +	sun4i-a10-pov-protab2-ips9.dtb \
> +	sun4i-a10-topwise-a721.dtb
>  dtb-$(CONFIG_MACH_SUN5I) +=3D \
>  	sun5i-a10s-auxtek-t003.dtb \
>  	sun5i-a10s-auxtek-t004.dtb \
> diff --git a/arch/arm/boot/dts/sun4i-a10-topwise-a721.dts b/arch/arm/boot=
/dts/sun4i-a10-topwise-a721.dts
> new file mode 100644
> index 0000000000..936171d30b
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun4i-a10-topwise-a721.dts
> @@ -0,0 +1,242 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2020 Pascal Roeleven <dev@pascalroeleven.nl>
> + */
> +
> +/dts-v1/;
> +#include "sun4i-a10.dtsi"
> +#include "sunxi-common-regulators.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/pwm/pwm.h>
> +
> +/ {
> +	model =3D "Topwise A721";
> +	compatible =3D "topwise,a721", "allwinner,sun4i-a10";
> +
> +	aliases {
> +		serial0 =3D &uart0;
> +	};
> +
> +	backlight: backlight {
> +		compatible =3D "pwm-backlight";
> +		pwms =3D <&pwm 0 100000 PWM_POLARITY_INVERTED>;
> +		power-supply =3D <&reg_vbat>;
> +		enable-gpios =3D <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
> +		brightness-levels =3D <0 30 40 50 60 70 80 90 100>;
> +		default-brightness-level =3D <8>;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +
> +	panel: panel {
> +		compatible =3D "starry,kr070pe2t";
> +		backlight =3D <&backlight>;
> +		power-supply =3D <&reg_lcd_power>;
> +
> +		port {
> +			panel_input: endpoint {
> +				remote-endpoint =3D <&tcon0_out_panel>;
> +			};
> +		};
> +	};
> +
> +	reg_lcd_power: reg-lcd-power {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "reg-lcd-power";
> +		gpio =3D <&pio 7 8 GPIO_ACTIVE_HIGH>; /* PH8 */
> +		enable-active-high;
> +	};
> +
> +	reg_vbat: reg-vbat {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vbat";
> +		regulator-min-microvolt =3D <3700000>;
> +		regulator-max-microvolt =3D <3700000>;
> +	};
> +
> +};
> +
> +&codec {
> +	status =3D "okay";
> +};
> +
> +&cpu0 {
> +	cpu-supply =3D <&reg_dcdc2>;
> +};
> +
> +&de {
> +	status =3D "okay";
> +};
> +
> +&ehci0 {
> +	status =3D "okay";
> +};
> +
> +&ehci1 {
> +	status =3D "okay";
> +};
> +
> +&i2c0 {
> +	status =3D "okay";
> +
> +	axp209: pmic@34 {
> +		reg =3D <0x34>;
> +		interrupts =3D <0>;
> +	};
> +};
> +
> +#include "axp209.dtsi"
> +
> +&ac_power_supply {
> +	status =3D "okay";
> +};
> +
> +&battery_power_supply {
> +	status =3D "okay";
> +};
> +
> +&i2c1 {
> +	status =3D "okay";
> +
> +	mma7660: accelerometer@4c {

Chances are you don't need that label?

> +		compatible =3D "fsl,mma7660";
> +		reg =3D <0x4c>;
> +	};
> +};
> +
> +&i2c2 {
> +	status =3D "okay";
> +
> +	ft5406ee8: touchscreen@38 {

Ditto

> +		compatible =3D "edt,edt-ft5406";
> +		reg =3D <0x38>;
> +		interrupt-parent =3D <&pio>;
> +		interrupts =3D <7 21 IRQ_TYPE_EDGE_FALLING>;
> +		touchscreen-size-x =3D <800>;
> +		touchscreen-size-y =3D <480>;
> +		vcc-supply =3D <&reg_vcc3v3>;
> +	};
> +};
> +
> +&lradc {
> +	vref-supply =3D <&reg_ldo2>;
> +	status =3D "okay";
> +
> +	button-vol-down {
> +		label =3D "Volume Down";
> +		linux,code =3D <KEY_VOLUMEDOWN>;
> +		channel =3D <0>;
> +		voltage =3D <761904>;
> +	};
> +
> +	button-vol-up {
> +		label =3D "Volume Up";
> +		linux,code =3D <KEY_VOLUMEUP>;
> +		channel =3D <0>;
> +		voltage =3D <571428>;
> +	};

Those two nodes will raise a warning during the DT validation, please
make sure it doesn't have any warning.

Maxime

--mtxopajle64dkerr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYC+mPAAKCRDj7w1vZxhR
xZGnAQCn/7v3lF2ukZHZeOJUN81E9GDut370DPQCWW3XFzAnEwD8DuS7ICW8HSoa
UWbbNcjkHUaCL1O/dw/JXnUCvEkL5gQ=
=oAqU
-----END PGP SIGNATURE-----

--mtxopajle64dkerr--

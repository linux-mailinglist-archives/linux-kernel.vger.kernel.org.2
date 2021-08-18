Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3803EFFD0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 11:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhHRJCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 05:02:19 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:45993 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231218AbhHRJCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 05:02:18 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 68BC5580B7E;
        Wed, 18 Aug 2021 05:01:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 18 Aug 2021 05:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=jhTIW1a1kmlpxAu4bV1fbcgHtmq
        GkW/kzMFN8LO4whw=; b=1gd+tK3X+jenGDI3ZJio617KA1L7b2t/i2S2E3tuRbj
        5oD8HzL/CiD2DHRnIiBorduvFjDDGB0mo6fjNB6A2QG8xbfNXEUbOsmuAyJIolFw
        yDZ3QkKjkOdvP5Lafj3p5LGxOSeyxskJ7i3JvcbFWaG2FYem7IMKibksv2tBxreU
        2Hjly85XBwDOoEFld1tkNP9XIFaVcgNXdqjY7RP/woDMCPnYoGJLpE+QcfEYEpKk
        /oNImmme8HyKi/ZCrm/yG1Lr9uNq+2iXayUs9X9YTZl1i6TgeL2yWsp5rG50HKin
        5vvIjREeQsxcEt1TA02nKN+51TRSEPHo8L9ZXOf9c8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=jhTIW1
        a1kmlpxAu4bV1fbcgHtmqGkW/kzMFN8LO4whw=; b=qIUla/DgaeUBRJYUjD7HAO
        FB2TnV+lbb0ln0WpyzFXleV9ZCHpNVfeH2CZpWvIAn71347O2vPRS9kxpkIFUkmK
        KKeYgvaxifCN/mW2Z2bxD5k+sFflc9HV1yUmYe6EzIWKFvKK/rLVl8encF14AuI3
        KaohVvbMugJvLTcHreb/sHsp9s5ZObbu7qMCPXhfCgu2/2wb8776oL9W3Y8eLPzm
        YFUaZwk5JqKp+H21AtEi2W127SoNbo7rpPYYo+l0aROG7DMzcxOS/gk9JkVRAJ96
        00+AEbVsJhQr0ewNL/67m/0wrOb4i4QnwCg1r2L2QH6hcGigK4BaQYVu+94OwWRw
        ==
X-ME-Sender: <xms:dcwcYZo1iFzO5QYJyBsuSDlNppE-8nxqow45fdY0OTyH3t7cMQF7yQ>
    <xme:dcwcYbpKFQQ-rSX-7MGyQq3l_hpvzkL_Ggqb2zweqPZWfXr_oREBLMu4-_Gl3PuGz
    V8UUY4DSMg86flrHMc>
X-ME-Received: <xmr:dcwcYWNFDAUZbIgWGo2frGJz13COcEE3BVEuDoZK58zPpHdCXBk4B-c_rZid7RxKDTDTZUSF054RDI6ROoEBCMjJm4pWJPbEouer>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleehgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:dcwcYU7pt0LVw_zs7imzfF9XuuaRxl5QHPdz9kOGezspexN2UdoMuw>
    <xmx:dcwcYY4uFpgZk-U8hiFYJ0Pw1h3dzE_3GGnV2Mso0tjqiqHI-Dg-8w>
    <xmx:dcwcYcgCFD-WXMae35pbE4Hx8Mzrm1EfHwwYEnFbBUoUZ01E7l5ZNw>
    <xmx:d8wcYYhXUK0jHYbpU5fXNqU3lL116o8o2KN8RURyT4H24UEptgPTZA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Aug 2021 05:01:40 -0400 (EDT)
Date:   Wed, 18 Aug 2021 11:01:39 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Icenowy Zheng <icenowy@sipeed.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/17] arm64: allwinner: dts: add DTSI file for R329 SoC
Message-ID: <20210818090139.rllz4fvvq3pzdkls@gilmour>
References: <20210802062212.73220-1-icenowy@sipeed.com>
 <20210802062212.73220-16-icenowy@sipeed.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dgafk337ems2a2tp"
Content-Disposition: inline
In-Reply-To: <20210802062212.73220-16-icenowy@sipeed.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dgafk337ems2a2tp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 02, 2021 at 02:22:10PM +0800, Icenowy Zheng wrote:
> Allwinner R329 is a new SoC focused on smart audio devices.
>=20
> Add a DTSI file for it.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
> ---
>  .../arm64/boot/dts/allwinner/sun50i-r329.dtsi | 244 ++++++++++++++++++
>  1 file changed, 244 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-r329.dtsi
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-r329.dtsi b/arch/arm64/=
boot/dts/allwinner/sun50i-r329.dtsi
> new file mode 100644
> index 000000000000..bfefa2b734b0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-r329.dtsi
> @@ -0,0 +1,244 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +// Copyright (c) 2021 Sipeed
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/sun50i-r329-ccu.h>
> +#include <dt-bindings/reset/sun50i-r329-ccu.h>
> +#include <dt-bindings/clock/sun50i-r329-r-ccu.h>
> +#include <dt-bindings/reset/sun50i-r329-r-ccu.h>
> +
> +/ {
> +	interrupt-parent =3D <&gic>;
> +	#address-cells =3D <1>;
> +	#size-cells =3D <1>;
> +
> +	cpus {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		cpu0: cpu@0 {
> +			compatible =3D "arm,cortex-a53";
> +			device_type =3D "cpu";
> +			reg =3D <0>;
> +			enable-method =3D "psci";
> +		};
> +
> +		cpu1: cpu@1 {
> +			compatible =3D "arm,cortex-a53";
> +			device_type =3D "cpu";
> +			reg =3D <1>;
> +			enable-method =3D "psci";
> +		};
> +	};
> +
> +	osc24M: osc24M_clk {
> +		#clock-cells =3D <0>;
> +		compatible =3D "fixed-clock";
> +		clock-frequency =3D <24000000>;
> +		clock-output-names =3D "osc24M";
> +	};
> +
> +	psci {
> +		compatible =3D "arm,psci-0.2";
> +		method =3D "smc";
> +	};
> +
> +	timer {
> +		compatible =3D "arm,armv8-timer";
> +		arm,no-tick-in-suspend;
> +		interrupts =3D <GIC_PPI 13
> +			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>,
> +			     <GIC_PPI 14
> +			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>,
> +			     <GIC_PPI 11
> +			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>,
> +			     <GIC_PPI 10
> +			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
> +	};
> +
> +	soc {
> +		compatible =3D "simple-bus";
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		ranges;
> +
> +		pio: pinctrl@2000400 {
> +			compatible =3D "allwinner,sun50i-r329-pinctrl";
> +			reg =3D <0x02000400 0x400>;
> +			interrupts =3D <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&ccu CLK_APB1>, <&osc24M>, <&rtc 0>;
> +			clock-names =3D "apb", "hosc", "losc";
> +			gpio-controller;
> +			#gpio-cells =3D <3>;
> +			interrupt-controller;
> +			#interrupt-cells =3D <3>;
> +
> +			uart0_pb_pins: uart0-pb-pins {
> +				pins =3D "PB4", "PB5";
> +				function =3D "uart0";
> +			};
> +
> +			mmc0_pf_pins: mmc0-pf-pins {
> +				pins =3D "PF0", "PF1", "PF2",
> +				       "PF3", "PF4", "PF5";
> +				function =3D "mmc0";
> +			};
> +
> +			mmc1_clk_pg0: mmc1-clk-pg0 {
> +				pins =3D "PG0";
> +				function =3D "mmc1_clk";
> +			};

Argh, of course it was bound to happen :)

Make sure your DT pass validation though, all your mmc1 node names will rep=
ort errors.

> +
> +			mmc1_cmd_pg1: mmc1-clk-pg1 {

s/clk/cmd/ ?

> +				pins =3D "PG1";
> +				function =3D "mmc1_cmd";
> +			};
> +
> +			mmc1_d0_pg2: mmc1-clk-pg2 {

s/clk/d0/

> +				pins =3D "PG2";
> +				function =3D "mmc1_d0";
> +			};
> +
> +			mmc1_d1_pg3: mmc1-clk-pg3 {

s/clk/d1/

> +				pins =3D "PG3";
> +				function =3D "mmc1_d1";
> +			};
> +
> +			mmc1_d2_pg4: mmc1-clk-pg4 {

s/clk/d2/

> +				pins =3D "PG4";
> +				function =3D "mmc1_d2";
> +			};
> +
> +			mmc1_d3_pg5: mmc1-clk-pg5 {

s/clk/d3/

> +				pins =3D "PG5";
> +				function =3D "mmc1_d3";
> +			};
> +		};
> +
> +		ccu: clock@2001000 {
> +			compatible =3D "allwinner,sun50i-r329-ccu";
> +			reg =3D <0x02001000 0x1000>;
> +			clocks =3D <&osc24M>, <&rtc 0>, <&rtc 2>;
> +			clock-names =3D "hosc", "losc", "iosc";

Do we have a clock tree for the RTC? Is it the same than the H616?

Maxime

--dgafk337ems2a2tp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYRzMcwAKCRDj7w1vZxhR
xXubAQCzgwOn/xozaa+B1nNA1mS27othgAAj+ZYv8+zptsTnSgEAluhr8NOdrZ2p
DpeJvbfAD8szA+MAucqVaH3TPgKtaAE=
=bY26
-----END PGP SIGNATURE-----

--dgafk337ems2a2tp--

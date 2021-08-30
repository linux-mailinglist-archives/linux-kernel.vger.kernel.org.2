Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8F33FB8E6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 17:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237494AbhH3PS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 11:18:29 -0400
Received: from mout.gmx.net ([212.227.17.21]:46323 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237218AbhH3PS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 11:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630336630;
        bh=I4E4Rendp4jhii6JjCdLdSOCsheSaYn1ijpWYeUaEGg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=QOsw9NiUDAuitqrd56V08G2iexnppzgWJSujTvskYkAaEl2e68FC0B/pnWbyY4acp
         JcuTC2dui9IWp87CS6+kDlcDSprshruxdbBcr9henp/fqbW3BM02a3pXtA/+APZsFQ
         RJxpFd00q4taH0qoMS9C/nj50LFI+rvfqc8Rh9u8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [157.180.227.230] ([157.180.227.230]) by web-mail.gmx.net
 (3c-app-gmx-bap54.server.lan [172.19.172.124]) (via HTTP); Mon, 30 Aug 2021
 17:17:10 +0200
MIME-Version: 1.0
Message-ID: <trinity-41954850-b71d-433f-9bd2-d5bce8f7e8fd-1630336630739@3c-app-gmx-bap54>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Sungbo Eo <mans0n@gorani.run>
Cc:     linux-mediatek@lists.infradead.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Min Guo <min.guo@mediatek.com>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sungbo Eo <mans0n@gorani.run>
Subject: Aw: [PATCH v3 1/1] arm: dts: mt7623: add musb device nodes
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 30 Aug 2021 17:17:10 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20210822041333.5264-2-mans0n@gorani.run>
References: <20210808123840.176738-1-mans0n@gorani.run>
 <20210822041333.5264-1-mans0n@gorani.run>
 <20210822041333.5264-2-mans0n@gorani.run>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:PVW6ogB5IbVNYXNq4+VxktgDFJueM9d5jQy5Rc1v6z6lh4eyTqTHewYt/atURSDJ+CJFA
 rN7JrQhEJXZW92ieXxpkeQLMC6AYQp95fO9zjZkWUbXEYNb/T+rT+9yn1xI77qoiadf+vQV+t0m8
 sEPfs5gJXP9SPaNIPnXEhOORxp1HQxUkGeDhYqdsLYjZD9HoJhlTzX2I2954wG4bSB3P2v/Eld3R
 415V93aGmBS9xlJC7ZNzMss/0b/QrRNGHGo4UBStiurfLO8FjVbkAbSK+AfDlALv7rtVDX2C+rBB
 Fk=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FTnVLzCX/RQ=:3m5+bh5XwLWE4iT48hrfMw
 8UfDFqeGQG+dhulVq1TFTUPelPBz4C9DbBso4DHlrLLmA3Ph55vBrPG6VGSj4uwn4ibHwBlLh
 GRQ/4uDUGIv0gbQV4tGiCoDO/Ymp0qzVCFqdMtTFvgbmgVkpbCSIAw0OIUPif7a06znjcejQp
 82XLP4HqVE9ehbB6v42Pc0sdpV4KU2YQm/MqOHZecC567saXVFSpWJv6hNeIMTqWuaIhLWIqN
 cip5moBG4n7e1IsuqywKoMZ0ZxGsbNmNa2VFjBDociNneBnQ/nysCTOtuPr7TZtHyq4r1PuIi
 +SRAN2REc1GPeKnQhHVcOu2986sDjCtuIh9Gd0qmPVy3gfmomO7PxUIiZ7PSbIGwsgKZgwMxs
 OpRKc/qfVCCgAdvYLYFpMQJbK1ZGUZKgF0HrUOZ1/tTvPYUJRyMP/c0l5LV+cmUFG/KCfe4FH
 rXg+zbWH8M41rpSbWr3fLekiMob9LV4DPF1pMJVdNd4t8ZjaUjPNWEEpDkc79/i/J8uL4Qzd5
 j5czFvgcQyRxN1Q7H3yFRpVJVRFMLOrueMnUcokdfhnAvSs+OE7fU1n0SDuTegztqsT4J0c+G
 IYBnP6xghu4NCC/gcvz1EBIPWhjJ9xTOsO+4pD8N4LvSb8m5AurR4Fn6chPdZlmuqaAU2cVTl
 hYNal+q4dCTu9nGBQsA6Iq37q8WY+flvdy8Hs7A2oqrUj20iUBtLVLK1uUUgHUOtrX9jBb6gd
 GyNYsH/3it/6LNSsI3f22meVFTm6/566IXry/rmpROSZxtQGSu7EdaO1yLiHxhad3Zo276JhP
 +td334ANPRmWZDSLo4d/XymfYwPPmdLdIXs5rZWovA4Mh6iYss=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Frank Wunderlich <frank-w@public-files.de>

after adding nodes for r2
https://patchwork.kernel.org/project/linux-mediatek/patch/20210830145958.1=
08605-1-linux@fw-web.de/

regards Frank


> Gesendet: Sonntag, 22. August 2021 um 06:13 Uhr
> Von: "Sungbo Eo" <mans0n@gorani.run>
> An: linux-mediatek@lists.infradead.org
> Cc: "Chunfeng Yun" <chunfeng.yun@mediatek.com>, "Greg Kroah-Hartman" <gr=
egkh@linuxfoundation.org>, "Rob Herring" <robh+dt@kernel.org>, "Matthias B=
rugger" <matthias.bgg@gmail.com>, "Min Guo" <min.guo@mediatek.com>, "Frank=
 Wunderlich" <frank-w@public-files.de>, devicetree@vger.kernel.org, linux-=
usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vg=
er.kernel.org, "Sungbo Eo" <mans0n@gorani.run>
> Betreff: [PATCH v3 1/1] arm: dts: mt7623: add musb device nodes
>
> MT7623 has an musb controller that is compatible with the one from MT270=
1.
>
> Signed-off-by: Sungbo Eo <mans0n@gorani.run>
> ---
> v3:
> * remove unnecessary status=3Dokay from u2port2
>
> v2:
> * rename usb3 label to usb0
> * move usb0 & u2phy1 nodes to the right sorted place
> * disable u2phy1 by default
> * correct u2port2 node name to match its reg address
> ---
>  arch/arm/boot/dts/mt7623.dtsi  | 33 +++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/mt7623a.dtsi |  4 ++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dt=
si
> index 3c11f7cfcc40..21c8a291b74e 100644
> --- a/arch/arm/boot/dts/mt7623.dtsi
> +++ b/arch/arm/boot/dts/mt7623.dtsi
> @@ -585,6 +585,39 @@ spi2: spi@11017000 {
>  		status =3D "disabled";
>  	};
>
> +	usb0: usb@11200000 {
> +		compatible =3D "mediatek,mt7623-musb",
> +			     "mediatek,mtk-musb";
> +		reg =3D <0 0x11200000 0 0x1000>;
> +		interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-names =3D "mc";
> +		phys =3D <&u2port2 PHY_TYPE_USB2>;
> +		dr_mode =3D "otg";
> +		clocks =3D <&pericfg CLK_PERI_USB0>,
> +			 <&pericfg CLK_PERI_USB0_MCU>,
> +			 <&pericfg CLK_PERI_USB_SLV>;
> +		clock-names =3D "main","mcu","univpll";
> +		power-domains =3D <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
> +		status =3D "disabled";
> +	};
> +
> +	u2phy1: t-phy@11210000 {
> +		compatible =3D "mediatek,mt7623-tphy",
> +			     "mediatek,generic-tphy-v1";
> +		reg =3D <0 0x11210000 0 0x0800>;
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		ranges;
> +		status =3D "disabled";
> +
> +		u2port2: usb-phy@11210800 {
> +			reg =3D <0 0x11210800 0 0x0100>;
> +			clocks =3D <&topckgen CLK_TOP_USB_PHY48M>;
> +			clock-names =3D "ref";
> +			#phy-cells =3D <1>;
> +		};
> +	};
> +
>  	audsys: clock-controller@11220000 {
>  		compatible =3D "mediatek,mt7623-audsys",
>  			     "mediatek,mt2701-audsys",
> diff --git a/arch/arm/boot/dts/mt7623a.dtsi b/arch/arm/boot/dts/mt7623a.=
dtsi
> index 0735a1fb8ad9..d304b62d24b5 100644
> --- a/arch/arm/boot/dts/mt7623a.dtsi
> +++ b/arch/arm/boot/dts/mt7623a.dtsi
> @@ -35,6 +35,10 @@ &scpsys {
>  	clock-names =3D "ethif";
>  };
>
> +&usb0 {
> +	power-domains =3D <&scpsys MT7623A_POWER_DOMAIN_IFR_MSC>;
> +};
> +
>  &usb1 {
>  	power-domains =3D <&scpsys MT7623A_POWER_DOMAIN_HIF>;
>  };
> --
> 2.33.0
>
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8A341131D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 12:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhITKuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 06:50:37 -0400
Received: from mout.gmx.net ([212.227.17.21]:45169 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229999AbhITKu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 06:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632134924;
        bh=UE6JPDxLxhHS8QF+kGYS6SUXXeB3wiXl2OFGWk3OyGs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CPR7SYqbDnEIHf2IgQzx7mMO9xt0ZVNCmAoqCT8yTPy7AB+j/NgIWGZrS42PMIjlO
         NGen88DHV1tnkKIXA2p98IcIz9vujw8ItkZlGPanHfn3y/kBIEH9bVDaMo0jYQjd4s
         pUDfBtpkTeizRdrVCjo21Mpmn5+tJZ/uj58z5M+I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.245.76.103] ([80.245.76.103]) by web-mail.gmx.net
 (3c-app-gmx-bap08.server.lan [172.19.172.78]) (via HTTP); Mon, 20 Sep 2021
 12:48:44 +0200
MIME-Version: 1.0
Message-ID: <trinity-1d1646a2-6fb9-4a81-9edc-45c4d216a279-1632134924710@3c-app-gmx-bap08>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Sungbo Eo <mans0n@gorani.run>,
        Matthias Brugger <matthias.bgg@kernel.org>
Cc:     linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sungbo Eo <mans0n@gorani.run>
Subject: Aw: [PATCH v4 1/2] arm: dts: mt7623: add musb device nodes
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 20 Sep 2021 12:48:44 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20210830155903.13907-2-mans0n@gorani.run>
References: <20210822041333.5264-1-mans0n@gorani.run>
 <20210830155903.13907-1-mans0n@gorani.run>
 <20210830155903.13907-2-mans0n@gorani.run>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:h+4u+2DNNQq/zFxGtQ+E9hroBIiOkc2j+6J/9LOROcecrSGZrwD7KyAje9UTcYe3Adrpf
 wxLLX03FCB+UBYr2y+/6W9mCCXarLsqxkmuTjF27xwVAIzdc4mNtUqnJg3tLkcACjsvPtDueNAAU
 uppDuW4tedE2jjUFJqZtgmf50QAZwbYVlJfS1dnwHK+5h6o4N/zn9Du38NIWLsQp1S84dq4UpgDF
 jOXj5yhXjD0ZCrYfZbDR1QYLn1TjALN1nn0BeIS5Y1a14P4w2iDWXrOmZuRuTcOBX3Dt8jSU/4gN
 pg=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WPDNJBBn+AY=:MmMNvz3wrtvo0tCZoZfq1U
 GzC4SCvrcWmYzVzP1xpiVVC/DvSfVyzXGrbWeqRx3WbjKyJYO6W/jwJFger6BR1S2drdXTGGq
 C+yHRL4dVfI2tguqvSB7pkI5LbkgCRg8l97GJ5vmghM7Twc7PN/tYYQyojiBOHzY91/uihR3/
 +YzZAg6v+y2aew8+7hmKNnu2qiDRwhEqfHc+eqWjyVQhgGv4dn9JtU10zLot1FhWG/MfVQQoq
 DJNsu/pOrvH6P7asE05CjcDlGIm1ZtlgjcWjeyJQBNSFDgkx4kUSDiSIL5BE2BMWZbYPSOH+o
 MTilrrmAflvhvUsdjZ6BGbsyiALTGxF1abplK3QD58LUkUxzaevUkieZMaXE0OPGnVoLjRZtT
 xULn6UP81Yiyawhtvr5Zugv9iWXtvl/ygWxtSHS97iuObUkqhrQ2KqItNHkD8f9fQoWcehkRk
 SL+7ssffFTOj3QaLf5TchQLWZOVvMYFwScZsG67JNXtF3hqFI0lJhQftXmFiLy9RldYiZDG7i
 /KzV+iwp5cifrEwDl7BZXi3uLlo6SCZQadYi5WpyXaoD4i7NhhEf6pCjgWhZmGOUR716dMOZx
 DaJKo3vMo1rshShJPkLpQSeX117rq5w55BJN33FUGAw347TOtk9l2bY6VOgcZwQQkrq+DYLxY
 NrX3/6jD+2KAXXOAmD7yU6G3XQ9ztzkt6K/7DOweOonb0PfDnwXwb0gqS8NszQMu6BMSXOsnb
 Xam5BBwfOBIpZvcrbMwm1DI84YTCTkK4IYS1XBZSCq+pn7A38qq7otG4+FkwEEgdsfFY99Uyw
 +FVdSbM
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just a gentle ping for this patch (second part is already merged to usb-tr=
ee) and my followup for bpi-r2

https://patchwork.kernel.org/project/linux-mediatek/patch/20210830145958.1=
08605-1-linux@fw-web.de/

regards Frank


> Gesendet: Montag, 30. August 2021 um 17:59 Uhr
> Von: "Sungbo Eo" <mans0n@gorani.run>
> An: linux-mediatek@lists.infradead.org
> Cc: "Rob Herring" <robh+dt@kernel.org>, "Matthias Brugger" <matthias.bgg=
@gmail.com>, "Bin Liu" <b-liu@ti.com>, "Greg Kroah-Hartman" <gregkh@linuxf=
oundation.org>, "Frank Wunderlich" <frank-w@public-files.de>, devicetree@v=
ger.kernel.org, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradea=
d.org, linux-kernel@vger.kernel.org, "Sungbo Eo" <mans0n@gorani.run>
> Betreff: [PATCH v4 1/2] arm: dts: mt7623: add musb device nodes
>
> MT7623 has an musb controller that is compatible with the one from MT270=
1.
>
> Signed-off-by: Sungbo Eo <mans0n@gorani.run>
> Tested-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v4:
> * add tested by Frank
>
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
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
>

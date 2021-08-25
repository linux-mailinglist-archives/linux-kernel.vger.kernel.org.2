Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A513F6F72
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 08:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238906AbhHYGZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 02:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238618AbhHYGZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 02:25:05 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4305DC0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 23:24:20 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id i21so8013935ejd.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 23:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Df29cJIkikql8uCIUFyNijz4gdU1XJpm3hrCoynmksA=;
        b=cSi2SkCnmf5ijIPHdAiQ+3/rzc5s51ripho8zLR8w4E/sj6Vn3oFiFmja9Ykm5WcPy
         ciRs+hyV56Jn2LwYSHFRoUCaOySLNB3r57K0tYBiaazQiR3w8/rmh0uqOuvOUOWpL3DU
         TPtM8YAhU0GHqCCl8zD8GkRRfQl48rU7ndW1X6T3A9of8us/0PSaipwPPU8K/UehecXz
         QEljGb0pn/FT1EWQefnHO/M+XW3s565bv2CL8Yq4lsM7Lg5VdDJR7pTg1lo5xqKmzVqK
         kB6T72WtQLDyyIl35Cx++6uUZxIsPF7emieK0WP/mLvT/Vu6EivFOQzZS9rb4THHpfA1
         cP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Df29cJIkikql8uCIUFyNijz4gdU1XJpm3hrCoynmksA=;
        b=sg9moo3kJv16LWZwArdO/ldpHl+vQ9VtIPzXR14mzYU4b5o05+XMKir2TDemXHmFDl
         AshCO0IkJ8Ki0M3Ake5r1SZB9hjsK+ot1rbzzTy/1IBIwxNWmMJ38jWncXAEx93nLbNi
         kv6sLajZVEzrcz+8bWQ9W2jSMiG39uq+OdHwmgsU9FJcnGRpUwCt2Vdq+vzqtMH0HlQj
         tQd3XaOga5tJShLaCSBYBZ9SgW1Q4DDoGMdLomkJ/wPqTaYZnGynmizgufh1wEqHsIUZ
         sswG0iNtE4ZuFYsPbfIzsnDHm9UXSKzhWiDliI1VvB++YozHDehY7SJKj/pT/JUDTIGm
         9BCg==
X-Gm-Message-State: AOAM530FuhiReMCRNzke2HiATo1JoqSjd+95em4IOhAUq8UuIBkp5EfM
        xfs6C8ZSAiFaMTSMvbC9+GlIV1nmZDyjb4jYzz/YHJIzQ7Z6zQ==
X-Google-Smtp-Source: ABdhPJxgeDnf90N3rMlZJmp6QAjDqQfFky/4QHvDCEbS6wG/gaG9fqw03vQW4mlTSPWVUlt8yRbOS9rtH5F7dKE6KDw=
X-Received: by 2002:a17:907:20d1:: with SMTP id qq17mr8450888ejb.439.1629872658738;
 Tue, 24 Aug 2021 23:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628244703.git.michal.simek@xilinx.com> <640a3bc0dc3e32560d3e84c2f78b5ae561396eb0.1628244703.git.michal.simek@xilinx.com>
In-Reply-To: <640a3bc0dc3e32560d3e84c2f78b5ae561396eb0.1628244703.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Wed, 25 Aug 2021 08:24:07 +0200
Message-ID: <CAHTX3dJ5JYi=8yNNA=F=T16Dmm6pe-RR14m_Ub9058NXa_Z_7Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] arm64: zynqmp: Enable xlnx,zynqmp-dwc3 driver for
 xilinx boards
To:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

p=C3=A1 6. 8. 2021 v 12:12 odes=C3=ADlatel Michal Simek <michal.simek@xilin=
x.com> napsal:
>
> The commit 84770f028fab ("usb: dwc3: Add driver for Xilinx platforms")
> finally add proper support for Xilinx dwc3 driver. This patch is adding D=
T
> description for it.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
> Changes in v3:
> - usb node name fix, remove undocumented properties reported by Michael T=
retter
> - Also remove status property from dwc3_0/1 nodes reported by Michael
>   Tretter
> - Move USB3 PHY properties from DWC3 node to USB node - reported by Manis=
h
>   Narani
>
> Changes in v2:
> - New patch in the series
>
>  .../dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    |  8 ++-
>  .../dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    |  7 +++
>  .../dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    | 14 +++++
>  .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    | 14 ++++-
>  .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    |  8 ++-
>  .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    |  8 ++-
>  .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    |  8 ++-
>  .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    |  8 ++-
>  .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    |  8 ++-
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 60 +++++++++++++++----
>  10 files changed, 122 insertions(+), 21 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arc=
h/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> index d93fe2efa39d..b05be2552826 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
> @@ -27,6 +27,7 @@ aliases {
>                 rtc0 =3D &rtc;
>                 serial0 =3D &uart0;
>                 spi0 =3D &qspi;
> +               usb0 =3D &usb0;
>         };
>
>         chosen {
> @@ -404,9 +405,14 @@ &usb0 {
>         status =3D "okay";
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&pinctrl_usb0_default>;
> -       dr_mode =3D "host";
>         phy-names =3D "usb3-phy";
>         phys =3D <&psgtr 2 PHY_TYPE_USB3 0 2>;
> +};
> +
> +&dwc3_0 {
> +       status =3D "okay";
> +       dr_mode =3D "host";
> +       snps,usb3_lpm_capable;
>         maximum-speed =3D "super-speed";
>  };
>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/arc=
h/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
> index cd61550c52e5..938b76bd0527 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
> @@ -26,6 +26,7 @@ aliases {
>                 serial1 =3D &uart1;
>                 spi0 =3D &spi0;
>                 spi1 =3D &spi1;
> +               usb0 =3D &usb1;
>         };
>
>         chosen {
> @@ -479,7 +480,13 @@ &usb1 {
>         status =3D "okay";
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&pinctrl_usb1_default>;
> +};
> +
> +&dwc3_1 {
> +       status =3D "okay";
>         dr_mode =3D "host";
> +       snps,usb3_lpm_capable;
> +       maximum-speed =3D "super-speed";
>  };
>
>  &uart0 {
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts b/arc=
h/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
> index ba7f1f21c579..4394ec3b6a23 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
> @@ -24,6 +24,8 @@ aliases {
>                 rtc0 =3D &rtc;
>                 serial0 =3D &uart0;
>                 serial1 =3D &uart1;
> +               usb0 =3D &usb0;
> +               usb1 =3D &usb1;
>         };
>
>         chosen {
> @@ -147,11 +149,23 @@ &uart1 {
>
>  &usb0 {
>         status =3D "okay";
> +};
> +
> +&dwc3_0 {
> +       status =3D "okay";
>         dr_mode =3D "host";
> +       snps,usb3_lpm_capable;
> +       maximum-speed =3D "super-speed";
>  };
>
>  /* ULPI SMSC USB3320 */
>  &usb1 {
>         status =3D "okay";
> +};
> +
> +&dwc3_1 {
> +       status =3D "okay";
>         dr_mode =3D "host";
> +       snps,usb3_lpm_capable;
> +       maximum-speed =3D "super-speed";
>  };
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm=
64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> index 80415e202814..f6aad4159ccd 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> @@ -30,6 +30,8 @@ aliases {
>                 serial2 =3D &dcc;
>                 spi0 =3D &spi0;
>                 spi1 =3D &spi1;
> +               usb0 =3D &usb0;
> +               usb1 =3D &usb1;
>                 mmc0 =3D &sdhci0;
>                 mmc1 =3D &sdhci1;
>         };
> @@ -537,9 +539,13 @@ &usb0 {
>         status =3D "okay";
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&pinctrl_usb0_default>;
> -       dr_mode =3D "peripheral";
>         phy-names =3D "usb3-phy";
>         phys =3D <&psgtr 2 PHY_TYPE_USB3 0 0>;
> +};
> +
> +&dwc3_0 {
> +       status =3D "okay";
> +       dr_mode =3D "peripheral";
>         maximum-speed =3D "super-speed";
>  };
>
> @@ -548,9 +554,13 @@ &usb1 {
>         status =3D "okay";
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&pinctrl_usb1_default>;
> -       dr_mode =3D "host";
>         phy-names =3D "usb3-phy";
>         phys =3D <&psgtr 3 PHY_TYPE_USB3 1 0>;
> +};
> +
> +&dwc3_1 {
> +       status =3D "okay";
> +       dr_mode =3D "host";
>         maximum-speed =3D "super-speed";
>  };
>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm=
64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> index 3d8d14ef1ede..7b9a88b125d1 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> @@ -31,6 +31,7 @@ aliases {
>                 serial1 =3D &uart1;
>                 serial2 =3D &dcc;
>                 spi0 =3D &qspi;
> +               usb0 =3D &usb0;
>         };
>
>         chosen {
> @@ -997,9 +998,14 @@ &usb0 {
>         status =3D "okay";
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&pinctrl_usb0_default>;
> -       dr_mode =3D "host";
>         phy-names =3D "usb3-phy";
>         phys =3D <&psgtr 2 PHY_TYPE_USB3 0 2>;
> +};
> +
> +&dwc3_0 {
> +       status =3D "okay";
> +       dr_mode =3D "host";
> +       snps,usb3_lpm_capable;
>         maximum-speed =3D "super-speed";
>  };
>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm=
64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> index 86fff3632c7d..bd8f20f3223d 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
> @@ -29,6 +29,7 @@ aliases {
>                 serial1 =3D &uart1;
>                 serial2 =3D &dcc;
>                 spi0 =3D &qspi;
> +               usb0 =3D &usb0;
>         };
>
>         chosen {
> @@ -481,9 +482,14 @@ &usb0 {
>         status =3D "okay";
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&pinctrl_usb0_default>;
> -       dr_mode =3D "host";
>         phy-names =3D "usb3-phy";
>         phys =3D <&psgtr 2 PHY_TYPE_USB3 0 2>;
> +};
> +
> +&dwc3_0 {
> +       status =3D "okay";
> +       dr_mode =3D "host";
> +       snps,usb3_lpm_capable;
>         maximum-speed =3D "super-speed";
>  };
>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm=
64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> index 2a872d439804..96feaad30166 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
> @@ -29,6 +29,7 @@ aliases {
>                 serial1 =3D &uart1;
>                 serial2 =3D &dcc;
>                 spi0 =3D &qspi;
> +               usb0 =3D &usb0;
>         };
>
>         chosen {
> @@ -493,9 +494,14 @@ &usb0 {
>         status =3D "okay";
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&pinctrl_usb0_default>;
> -       dr_mode =3D "host";
>         phy-names =3D "usb3-phy";
>         phys =3D <&psgtr 2 PHY_TYPE_USB3 0 2>;
> +};
> +
> +&dwc3_0 {
> +       status =3D "okay";
> +       dr_mode =3D "host";
> +       snps,usb3_lpm_capable;
>         maximum-speed =3D "super-speed";
>  };
>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm=
64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> index 057c04352591..20b7c75bb1d3 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> @@ -31,6 +31,7 @@ aliases {
>                 serial1 =3D &uart1;
>                 serial2 =3D &dcc;
>                 spi0 =3D &qspi;
> +               usb0 =3D &usb0;
>         };
>
>         chosen {
> @@ -990,9 +991,14 @@ &usb0 {
>         status =3D "okay";
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&pinctrl_usb0_default>;
> -       dr_mode =3D "host";
>         phy-names =3D "usb3-phy";
>         phys =3D <&psgtr 2 PHY_TYPE_USB3 0 2>;
> +};
> +
> +&dwc3_0 {
> +       status =3D "okay";
> +       dr_mode =3D "host";
> +       snps,usb3_lpm_capable;
>         maximum-speed =3D "super-speed";
>  };
>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm=
64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> index e1fff62a4cd5..e36df6adbeee 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> @@ -30,6 +30,7 @@ aliases {
>                 serial0 =3D &uart0;
>                 serial1 =3D &dcc;
>                 spi0 =3D &qspi;
> +               usb0 =3D &usb0;
>         };
>
>         chosen {
> @@ -827,9 +828,14 @@ &usb0 {
>         status =3D "okay";
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&pinctrl_usb0_default>;
> -       dr_mode =3D "host";
>         phy-names =3D "usb3-phy";
>         phys =3D <&psgtr 2 PHY_TYPE_USB3 0 2>;
> +};
> +
> +&dwc3_0 {
> +       status =3D "okay";
> +       dr_mode =3D "host";
> +       snps,usb3_lpm_capable;
>         maximum-speed =3D "super-speed";
>  };
>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts=
/xilinx/zynqmp.dtsi
> index b5fde9dddca5..74e66443e4ce 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -2,7 +2,7 @@
>  /*
>   * dts file for Xilinx ZynqMP
>   *
> - * (C) Copyright 2014 - 2019, Xilinx, Inc.
> + * (C) Copyright 2014 - 2021, Xilinx, Inc.
>   *
>   * Michal Simek <michal.simek@xilinx.com>
>   *
> @@ -805,24 +805,58 @@ uart1: serial@ff010000 {
>                         power-domains =3D <&zynqmp_firmware PD_UART_1>;
>                 };
>
> -               usb0: usb@fe200000 {
> -                       compatible =3D "snps,dwc3";
> +               usb0: usb@ff9d0000 {
> +                       #address-cells =3D <2>;
> +                       #size-cells =3D <2>;
>                         status =3D "disabled";
> -                       interrupt-parent =3D <&gic>;
> -                       interrupts =3D <0 65 4>;
> -                       reg =3D <0x0 0xfe200000 0x0 0x40000>;
> -                       clock-names =3D "clk_xin", "clk_ahb";
> +                       compatible =3D "xlnx,zynqmp-dwc3";
> +                       reg =3D <0x0 0xff9d0000 0x0 0x100>;
> +                       clock-names =3D "bus_clk", "ref_clk";
>                         power-domains =3D <&zynqmp_firmware PD_USB_0>;
> +                       resets =3D <&zynqmp_reset ZYNQMP_RESET_USB0_CORER=
ESET>,
> +                                <&zynqmp_reset ZYNQMP_RESET_USB0_HIBERRE=
SET>,
> +                                <&zynqmp_reset ZYNQMP_RESET_USB0_APB>;
> +                       reset-names =3D "usb_crst", "usb_hibrst", "usb_ap=
brst";
> +                       ranges;
> +
> +                       dwc3_0: usb@fe200000 {
> +                               compatible =3D "snps,dwc3";
> +                               reg =3D <0x0 0xfe200000 0x0 0x40000>;
> +                               interrupt-parent =3D <&gic>;
> +                               interrupt-names =3D "dwc_usb3", "otg";
> +                               interrupts =3D <0 65 4>, <0 69 4>;
> +                               #stream-id-cells =3D <1>;
> +                               iommus =3D <&smmu 0x860>;
> +                               snps,quirk-frame-length-adjustment =3D <0=
x20>;
> +                               /* dma-coherent; */
> +                       };
>                 };
>
> -               usb1: usb@fe300000 {
> -                       compatible =3D "snps,dwc3";
> +               usb1: usb@ff9e0000 {
> +                       #address-cells =3D <2>;
> +                       #size-cells =3D <2>;
>                         status =3D "disabled";
> -                       interrupt-parent =3D <&gic>;
> -                       interrupts =3D <0 70 4>;
> -                       reg =3D <0x0 0xfe300000 0x0 0x40000>;
> -                       clock-names =3D "clk_xin", "clk_ahb";
> +                       compatible =3D "xlnx,zynqmp-dwc3";
> +                       reg =3D <0x0 0xff9e0000 0x0 0x100>;
> +                       clock-names =3D "bus_clk", "ref_clk";
>                         power-domains =3D <&zynqmp_firmware PD_USB_1>;
> +                       resets =3D <&zynqmp_reset ZYNQMP_RESET_USB1_CORER=
ESET>,
> +                                <&zynqmp_reset ZYNQMP_RESET_USB1_HIBERRE=
SET>,
> +                                <&zynqmp_reset ZYNQMP_RESET_USB1_APB>;
> +                       reset-names =3D "usb_crst", "usb_hibrst", "usb_ap=
brst";
> +                       ranges;
> +
> +                       dwc3_1: usb@fe300000 {
> +                               compatible =3D "snps,dwc3";
> +                               reg =3D <0x0 0xfe300000 0x0 0x40000>;
> +                               interrupt-parent =3D <&gic>;
> +                               interrupt-names =3D "dwc_usb3", "otg";
> +                               interrupts =3D <0 70 4>, <0 74 4>;
> +                               #stream-id-cells =3D <1>;
> +                               iommus =3D <&smmu 0x861>;
> +                               snps,quirk-frame-length-adjustment =3D <0=
x20>;
> +                               /* dma-coherent; */
> +                       };
>                 };
>
>                 watchdog0: watchdog@fd4d0000 {
> --
> 2.32.0
>

Applied but only this patch. For Kria still waiting for Rob's reaction.

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

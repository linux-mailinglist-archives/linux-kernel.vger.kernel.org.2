Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A83318742
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 10:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhBKJmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 04:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbhBKJiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 04:38:23 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B7DC061786
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 01:37:43 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z22so6222687edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 01:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6hY1ZjZ+/9Got/zDgBihzh+T9youbOEaeflEdA/GJho=;
        b=oXHC3jLpRQUz/X+J47YQo23xALpa0lHDKrTX7ZNS4VT0G4vk/pqoV77J0Pee3BTbAO
         oT3bg6HJlvNJtPwNes4CJPWQeDEvVnXCLIRjJqRb+INln+6f3GOJD2hQVydXCS6b5eW4
         oh2GnQ+hvWkbK3kHSaykbdhWbGntzEq34jXTtEEn8viXSqE5MQaqc8eM8PoeRWdO1KIg
         +wAPRh0y/PtW4IbgyxlW3AwU+BjK/3RRV7JVM+I2Hw+E2nyIjHKERvyp2ETLMkHO7M/F
         +ueSwLs6Xsp09a7dwFiMKFn9JFWP/5OmHchfYBOk/Xx7Af9sDvPomh7BjhIrzYzTn6lD
         ljCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6hY1ZjZ+/9Got/zDgBihzh+T9youbOEaeflEdA/GJho=;
        b=mbetsiQ1AzJYgXgOE/2l1/hXFBuZ2kdhhJlFn/S62Wuu/VLHW8p3jJYJ7SuqyquMjj
         Rg7e5F3WNif1lM3Z0lbVIwGReXlZkgZ3DQBEm0Taqs44v6hvUImK6Vt4KM67p7o4D5bs
         tGrgR/KoyiIkp9yXJoIs+tSl3yFifKeM5zDsGMDZkEjWrLcGjFEGwmnBwZmv/93HUHmY
         k4YKsxS/d2my3MROY9S3wVKInSKtW+X/S5dhxD+MHkBcb4pbZuT+rSx8U3e+zcXDZmGW
         8R9ZU9c3kd99/67jPC0D29ynVbmwabv9LepUgTEn8yz0TfGTNVRhkPnjdqSj9BoKfljB
         LiEg==
X-Gm-Message-State: AOAM531cIDNzUwGd4eU46SlU5sYpXT+3VwQtxM5Mb8QoQ+/lsUdJRf0G
        fBSZEyVQ5JG+kJ06mtl7ypER38RTtcBU8WxaPd5V8jZSVS4=
X-Google-Smtp-Source: ABdhPJy7EKT8hi84IG7yCpFEKbAockBKvJsxODy2meMI23Us60rkiTSsSWBQRycQSXG/x8XyVSE147QC8KfOAa/0KLU=
X-Received: by 2002:a05:6402:3590:: with SMTP id y16mr7625655edc.21.1613036261643;
 Thu, 11 Feb 2021 01:37:41 -0800 (PST)
MIME-Version: 1.0
References: <4ece21a7e9691ed1e775fd6b0b4046b1562e44bd.1612951821.git.michal.simek@xilinx.com>
In-Reply-To: <4ece21a7e9691ed1e775fd6b0b4046b1562e44bd.1612951821.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Thu, 11 Feb 2021 10:37:30 +0100
Message-ID: <CAHTX3dKPTC1+awBADMCcgX+=PXsHPw2Bz3Po5=CocdKzVy3bRg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: spi: zynq: Convert Zynq QSPI binding to yaml
To:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

st 10. 2. 2021 v 11:10 odes=C3=ADlatel Michal Simek <michal.simek@xilinx.co=
m> napsal:
>
> Convert spi-zynq-qspi.txt to yaml.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
> Changes in v2:
> - s/additionalProperties: true/unevaluatedProperties: false/
>
>  .../devicetree/bindings/spi/spi-zynq-qspi.txt | 25 --------
>  .../bindings/spi/xlnx,zynq-qspi.yaml          | 59 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  3 files changed, 60 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-zynq-qspi.t=
xt
>  create mode 100644 Documentation/devicetree/bindings/spi/xlnx,zynq-qspi.=
yaml
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt b/Do=
cumentation/devicetree/bindings/spi/spi-zynq-qspi.txt
> deleted file mode 100644
> index 16b734ad3102..000000000000
> --- a/Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -Xilinx Zynq QSPI controller Device Tree Bindings
> --------------------------------------------------------------------
> -
> -Required properties:
> -- compatible           : Should be "xlnx,zynq-qspi-1.0".
> -- reg                  : Physical base address and size of QSPI register=
s map.
> -- interrupts           : Property with a value describing the interrupt
> -                         number.
> -- clock-names          : List of input clock names - "ref_clk", "pclk"
> -                         (See clock bindings for details).
> -- clocks               : Clock phandles (see clock bindings for details)=
.
> -
> -Optional properties:
> -- num-cs               : Number of chip selects used.
> -
> -Example:
> -       qspi: spi@e000d000 {
> -               compatible =3D "xlnx,zynq-qspi-1.0";
> -               reg =3D <0xe000d000 0x1000>;
> -               interrupt-parent =3D <&intc>;
> -               interrupts =3D <0 19 4>;
> -               clock-names =3D "ref_clk", "pclk";
> -               clocks =3D <&clkc 10>, <&clkc 43>;
> -               num-cs =3D <1>;
> -       };
> diff --git a/Documentation/devicetree/bindings/spi/xlnx,zynq-qspi.yaml b/=
Documentation/devicetree/bindings/spi/xlnx,zynq-qspi.yaml
> new file mode 100644
> index 000000000000..1f1c40a9f320
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/xlnx,zynq-qspi.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/xlnx,zynq-qspi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx Zynq QSPI controller
> +
> +description:
> +  The Xilinx Zynq QSPI controller is used to access multi-bit serial fla=
sh
> +  memory devices.
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"
> +
> +maintainers:
> +  - Michal Simek <michal.simek@xilinx.com>
> +
> +# Everything else is described in the common file
> +properties:
> +  compatible:
> +    const: xlnx,zynq-qspi-1.0
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: reference clock
> +      - description: peripheral clock
> +
> +  clock-names:
> +    items:
> +      - const: ref_clk
> +      - const: pclk
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi@e000d000 {
> +        compatible =3D "xlnx,zynq-qspi-1.0";
> +        reg =3D <0xe000d000 0x1000>;
> +        interrupt-parent =3D <&intc>;
> +        interrupts =3D <0 19 4>;
> +        clock-names =3D "ref_clk", "pclk";
> +        clocks =3D <&clkc 10>, <&clkc 43>;
> +        num-cs =3D <1>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 546aa66428c9..e494b061dcd1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2766,6 +2766,7 @@ W:        http://wiki.xilinx.com
>  T:     git https://github.com/Xilinx/linux-xlnx.git
>  F:     Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml
>  F:     Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
> +F:     Documentation/devicetree/bindings/spi/xlnx,zynq-qspi.yaml
>  F:     arch/arm/mach-zynq/
>  F:     drivers/block/xsysace.c
>  F:     drivers/clocksource/timer-cadence-ttc.c
> --
> 2.30.0
>

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

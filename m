Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBDE332B91
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 17:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhCIQIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 11:08:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:60270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231484AbhCIQIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 11:08:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43BE66525F;
        Tue,  9 Mar 2021 16:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615306111;
        bh=m5yotigglTwo/4/VjycEU38clNH30+i2DIYjIl592qA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G0ljtr9BVVQsh4aYdtmk4PPFcuCMgd40mscp7ZOLxQHlXdhQOH4gf1f4irrC+GTb8
         Y3W29GKPs1UKP20eytWOSbal2too+BYPSW9W5RuOSBHI1okUh2g/4pHpPAmekNkrFQ
         yssKTj+4uvzDTnD0aFm4rp9ZAO+cOlc7yI+lhgLIONv+f/co7WtWKQhfkZtq3PeQ27
         r87Ivafurt9WRx2BjZlmnWzO9PBYjtFak7Hn90DObzvxmrRgbZ/ugaDnfJg+5H1dsa
         AACFZsLDx//HfLFjVo3BQUoimM6jkrYBPQZb7+GAywUipro2lSvuvQE5Slzy/aqFBC
         DDQJR7iQMJIyg==
Received: by mail-ed1-f46.google.com with SMTP id b13so21295912edx.1;
        Tue, 09 Mar 2021 08:08:31 -0800 (PST)
X-Gm-Message-State: AOAM533KNWtButOHoLAAvQ03Xmc4Mc/drDiAHSe3KxjFUwtRgqqaXNbE
        oU/IohCkASyK76JQbRIWKG06tIpYfDc24UcMkw==
X-Google-Smtp-Source: ABdhPJyGtuy6K5pXjTmStnd6roHmLpIjnE3SvwReT2C3lCnehUjerCNkZkRqMRZn92X6m6qR1imyrgtfck8n6NUsCbs=
X-Received: by 2002:aa7:cf14:: with SMTP id a20mr4921872edy.49.1615306109722;
 Tue, 09 Mar 2021 08:08:29 -0800 (PST)
MIME-Version: 1.0
References: <1582279929-11535-1-git-send-email-macpaul.lin@mediatek.com> <1582279929-11535-4-git-send-email-macpaul.lin@mediatek.com>
In-Reply-To: <1582279929-11535-4-git-send-email-macpaul.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 10 Mar 2021 00:08:18 +0800
X-Gmail-Original-Message-ID: <CAAOTY__kSW0ci9YJjSALOfRqKxxR3ysZUQ3Mxsab77hmCO0TyA@mail.gmail.com>
Message-ID: <CAAOTY__kSW0ci9YJjSALOfRqKxxR3ysZUQ3Mxsab77hmCO0TyA@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] arm64: dts: mediatek: add mt6765 support
To:     Macpaul Lin <macpaul.lin@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        mtk01761 <wendell.lin@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Evan Green <evgreen@chromium.org>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <jroedel@suse.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-clk@vger.kernel.org,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Macpaul:

Macpaul Lin <macpaul.lin@mediatek.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=8821=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:22=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> From: Mars Cheng <mars.cheng@mediatek.com>
>
> Add basic chip support for Mediatek 6765, include
> uart node with correct uart clocks, pwrap device
>
> Add clock controller nodes, include topckgen, infracfg,
> apmixedsys and subsystem.
>
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile       |    1 +
>  arch/arm64/boot/dts/mediatek/mt6765-evb.dts |   33 ++++
>  arch/arm64/boot/dts/mediatek/mt6765.dtsi    |  253 +++++++++++++++++++++=
++++++
>  3 files changed, 287 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6765-evb.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6765.dtsi
>
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/=
mediatek/Makefile
> index 458bbc4..22bdf1a 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt2712-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt6755-evb.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt6765-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt6795-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt6797-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt6797-x20-dev.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt6765-evb.dts b/arch/arm64/boo=
t/dts/mediatek/mt6765-evb.dts
> new file mode 100644
> index 0000000..36dddff2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt6765-evb.dts
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * dts file for Mediatek MT6765
> + *
> + * (C) Copyright 2018. Mediatek, Inc.
> + *
> + * Mars Cheng <mars.cheng@mediatek.com>
> + */
> +
> +/dts-v1/;
> +#include "mt6765.dtsi"
> +
> +/ {
> +       model =3D "MediaTek MT6765 EVB";
> +       compatible =3D "mediatek,mt6765-evb", "mediatek,mt6765";
> +
> +       aliases {
> +               serial0 =3D &uart0;
> +       };
> +
> +       memory@40000000 {
> +               device_type =3D "memory";
> +               reg =3D <0 0x40000000 0 0x1e800000>;
> +       };
> +
> +       chosen {
> +               stdout-path =3D "serial0:921600n8";
> +       };
> +};
> +
> +&uart0 {
> +       status =3D "okay";
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt6765.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt6765.dtsi
> new file mode 100644
> index 0000000..2662470
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt6765.dtsi
> @@ -0,0 +1,253 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * dts file for Mediatek MT6765
> + *
> + * (C) Copyright 2018. Mediatek, Inc.
> + *
> + * Mars Cheng <mars.cheng@mediatek.com>
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/mt6765-clk.h>
> +
> +/ {
> +       compatible =3D "mediatek,mt6765";
> +       interrupt-parent =3D <&sysirq>;
> +       #address-cells =3D <2>;
> +       #size-cells =3D <2>;
> +

[snip]

> +
> +       soc {
> +               #address-cells =3D <2>;
> +               #size-cells =3D <2>;
> +               compatible =3D "simple-bus";
> +               ranges;
> +
> +               gic: interrupt-controller@c000000 {
> +                       compatible =3D "arm,gic-v3";
> +                       #interrupt-cells =3D <3>;
> +                       #address-cells =3D <2>;
> +                       #size-cells =3D <2>;
> +                       interrupt-parent =3D <&gic>;
> +                       interrupt-controller;
> +                       reg =3D <0 0x0c000000 0 0x40000>,  /* GICD */
> +                             <0 0x0c100000 0 0x200000>, /* GICR */
> +                             <0 0x0c400000 0 0x2000>,   /* GICC */
> +                             <0 0x0c410000 0 0x2000>,   /* GICH */
> +                             <0 0x0c420000 0 0x20000>;  /* GICV */
> +                       interrupts =3D <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +               };
> +
> +               topckgen: syscon@10000000 {
> +                       compatible =3D "mediatek,mt6765-topckgen", "sysco=
n";
> +                       reg =3D <0 0x10000000 0 0x1000>;
> +                       #clock-cells =3D <1>;
> +               };
> +
> +               infracfg: syscon@10001000 {
> +                       compatible =3D "mediatek,mt6765-infracfg", "sysco=
n";
> +                       reg =3D <0 0x10001000 0 0x1000>;
> +                       interrupts =3D <GIC_SPI 147 IRQ_TYPE_EDGE_RISING>=
;
> +                       #clock-cells =3D <1>;
> +               };
> +
> +               pericfg: pericfg@10003000 {
> +                       compatible =3D "mediatek,mt6765-pericfg", "syscon=
";
> +                       reg =3D <0 0x10003000 0 0x1000>;
> +               };
> +
> +               scpsys: scpsys@10006000 {
> +                       compatible =3D "mediatek,mt6765-scpsys";
> +                       reg =3D   <0 0x10006000 0 0x1000>; /* spm */
> +                       #power-domain-cells =3D <1>;
> +                       clocks =3D <&topckgen CLK_TOP_MFG_SEL>,
> +                                <&topckgen CLK_TOP_MM_SEL>,
> +                                <&mmsys_config CLK_MM_SMI_COMMON>,
> +                                <&mmsys_config CLK_MM_SMI_COMM0>,
> +                                <&mmsys_config CLK_MM_SMI_COMM1>,
> +                                <&mmsys_config CLK_MM_SMI_LARB0>,
> +                                <&imgsys CLK_IMG_LARB2>,
> +                                <&mmsys_config CLK_MM_SMI_IMG>,
> +                                <&camsys CLK_CAM_LARB3>,
> +                                <&camsys CLK_CAM_DFP_VAD>,
> +                                <&camsys CLK_CAM>,
> +                                <&camsys CLK_CAM_CCU>,
> +                                <&mmsys_config CLK_MM_SMI_CAM>;
> +                       clock-names =3D "mfg", "mm",
> +                                     "mm-0", "mm-1", "mm-2", "mm-3",
> +                                     "isp-0", "isp-1", "cam-0", "cam-1",
> +                                     "cam-2", "cam-3", "cam-4";
> +                       infracfg =3D <&infracfg>;
> +                       smi_comm =3D <&smi_common>;
> +               };
> +
> +               apmixed: syscon@1000c000 {
> +                       compatible =3D "mediatek,mt6765-apmixedsys", "sys=
con";
> +                       reg =3D <0 0x1000c000 0 0x1000>;
> +                       #clock-cells =3D <1>;
> +               };
> +
> +               sysirq: interrupt-controller@10200a80 {
> +                       compatible =3D "mediatek,mt6765-sysirq",
> +                                    "mediatek,mt6577-sysirq";
> +                       interrupt-controller;
> +                       #interrupt-cells =3D <3>;
> +                       interrupt-parent =3D <&gic>;
> +                       reg =3D <0 0x10200a80 0 0x50>;
> +               };
> +
> +               uart0: serial@11002000 {
> +                       compatible =3D "mediatek,mt6765-uart",
> +                                    "mediatek,mt6577-uart";
> +                       reg =3D <0 0x11002000 0 0x400>;
> +                       interrupts =3D <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
> +                       clocks =3D <&infracfg CLK_IFR_UART0>,
> +                                <&infracfg CLK_IFR_AP_DMA>;
> +                       clock-names =3D "baud", "bus";
> +                       status =3D "disabled";
> +               };
> +
> +               uart1: serial@11003000 {
> +                       compatible =3D "mediatek,mt6765-uart",
> +                                    "mediatek,mt6577-uart";
> +                       reg =3D <0 0x11003000 0 0x400>;
> +                       interrupts =3D <GIC_SPI 92 IRQ_TYPE_LEVEL_LOW>;
> +                       clocks =3D <&infracfg CLK_IFR_UART1>,
> +                                <&infracfg CLK_IFR_AP_DMA>;
> +                       clock-names =3D "baud", "bus";
> +                       status =3D "disabled";
> +               };
> +
> +               audio: syscon@11220000 {
> +                       compatible =3D "mediatek,mt6765-audsys", "syscon"=
;
> +                       reg =3D <0 0x11220000 0 0x1000>;
> +                       #clock-cells =3D <1>;
> +               };
> +
> +               mipi_rx_ana_csi0a: syscon@11c10000 {
> +                       compatible =3D "mediatek,mt6765-mipi0a",
> +                                    "syscon";
> +                       reg =3D <0 0x11c10000 0 0x1000>;
> +                       #clock-cells =3D <1>;
> +               };
> +
> +               mmsys_config: syscon@14000000 {
> +                       compatible =3D "mediatek,mt6765-mmsys", "syscon";
> +                       reg =3D <0 0x14000000 0 0x1000>;
> +                       interrupts =3D <GIC_SPI 227 IRQ_TYPE_LEVEL_LOW>;

I does not see interrupts property in binding document [1], please add
this in binding document first.
I'm curious about this interrupt. In which condition would it be triggered?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt?h=3Dv5.1=
2-rc2

Regards,
Chun-Kuang.

> +                       #clock-cells =3D <1>;
> +               };
> +
> +               smi_common: smi_common@14002000 {
> +                       compatible =3D "mediatek,mt6765-smi-common", "sys=
con";
> +                       reg =3D <0 0x14002000 0 0x1000>;
> +               };
> +
> +               imgsys: syscon@15020000 {
> +                       compatible =3D "mediatek,mt6765-imgsys", "syscon"=
;
> +                       reg =3D <0 0x15020000 0 0x1000>;
> +                       #clock-cells =3D <1>;
> +               };
> +
> +               venc_gcon: syscon@17000000 {
> +                       compatible =3D "mediatek,mt6765-vcodecsys", "sysc=
on";
> +                       reg =3D <0 0x17000000 0 0x10000>;
> +                       #clock-cells =3D <1>;
> +               };
> +
> +               camsys: syscon@1a000000  {
> +                       compatible =3D "mediatek,mt6765-camsys", "syscon"=
;
> +                       reg =3D <0 0x1a000000 0 0x1000>;
> +                       #clock-cells =3D <1>;
> +               };
> +       }; /* end of soc */
> +};
> --
> 1.7.9.5
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F7F41CE8B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 23:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346356AbhI2Vz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 17:55:29 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:34578 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345002AbhI2Vz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 17:55:28 -0400
Received: by mail-qt1-f175.google.com with SMTP id m26so3812355qtn.1;
        Wed, 29 Sep 2021 14:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dy7tWacIyVasGr51uylmiHt4pHFLEmjBm7qwT/JIX6s=;
        b=7C3GvbAIW9dZWJgtyOuh8kg9l/7PLOCNkE7jAXEEcN795yGOGVD3kZQv0ANRUx4wuM
         RdPqb/+e9qX9YH5YsBiIpb5sleqK9uMgJjSuTvUfpMLDqQVkCTaZboOvgJ/KoxHF6tQg
         WMTlOhGxUV+TjF4tce+eSHnGsRMNxjP3QbN2Sg0LMeq6qglaxSCfw+qhB7bndsqGlNWE
         TQnFQjDjgXp+5FNzakAr5t4hRqRi8FjNELQGKG8LeZrPbQ21l0/5f24swVTtUvXABBUD
         bbtTOBVnu5gBV8nSy+OItGyOJWFXqI/zSBnVF7QiAHv9+xEh9TEvk+LetpLCvCtL/CE8
         jNJA==
X-Gm-Message-State: AOAM532wl5d22OUGaQwdbGPnbLOehwjkXj/BMt5gYJq/xPjzWClnFlSS
        gSPQm7UIpuh6XfIWnQ5pBxX7Dsq5I+k=
X-Google-Smtp-Source: ABdhPJwPLycUZ4EXYZcj8EzQQSNHR89IoFoFUQkgRTYZT1lscVZbRILbRbEdAtTObJXT7su2fItKJA==
X-Received: by 2002:a05:622a:1356:: with SMTP id w22mr2680228qtk.26.1632952426136;
        Wed, 29 Sep 2021 14:53:46 -0700 (PDT)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com. [209.85.219.54])
        by smtp.gmail.com with ESMTPSA id d14sm616083qkg.49.2021.09.29.14.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 14:53:46 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id et16so2366498qvb.10;
        Wed, 29 Sep 2021 14:53:45 -0700 (PDT)
X-Received: by 2002:a05:6214:1461:: with SMTP id c1mr2230970qvy.19.1632952425407;
 Wed, 29 Sep 2021 14:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210928192154.1841889-1-robh@kernel.org>
In-Reply-To: <20210928192154.1841889-1-robh@kernel.org>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Wed, 29 Sep 2021 16:53:33 -0500
X-Gmail-Original-Message-ID: <CADRPPNSwy5U5kg8DGn6pBw3jGff10otnB1UHFmEh5k2L177f4w@mail.gmail.com>
Message-ID: <CADRPPNSwy5U5kg8DGn6pBw3jGff10otnB1UHFmEh5k2L177f4w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: freescale: Fix 'interrupt-map' parent address cells
To:     Rob Herring <robh@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 2:22 PM Rob Herring <robh@kernel.org> wrote:
>
> The 'interrupt-map' in several Layerscape SoCs is malformed. The
> '#address-cells' size of the parent interrupt controller (the GIC) is not
> accounted for.
>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Li Yang <leoyang.li@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Li Yang <leoyang.li@nxp.com>

> ---
>  .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 24 +++++++++----------
>  .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 24 +++++++++----------
>  .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 24 +++++++++----------
>  3 files changed, 36 insertions(+), 36 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index f85e437f80b7..84a31372b3fa 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -241,18 +241,18 @@ extirq: interrupt-controller@14 {
>                                 interrupt-controller;
>                                 reg = <0x14 4>;
>                                 interrupt-map =
> -                                       <0 0 &gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <1 0 &gic GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <2 0 &gic GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <3 0 &gic GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <4 0 &gic GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <5 0 &gic GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <6 0 &gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <7 0 &gic GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <8 0 &gic GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <9 0 &gic GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <10 0 &gic GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <11 0 &gic GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +                                       <0 0 &gic 0 0 GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <1 0 &gic 0 0 GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <2 0 &gic 0 0 GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <3 0 &gic 0 0 GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <4 0 &gic 0 0 GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <5 0 &gic 0 0 GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <6 0 &gic 0 0 GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <7 0 &gic 0 0 GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <8 0 &gic 0 0 GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <9 0 &gic 0 0 GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <10 0 &gic 0 0 GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <11 0 &gic 0 0 GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>                                 interrupt-map-mask = <0xffffffff 0x0>;
>                         };
>                 };
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> index 801ba9612d36..38aea4fce238 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> @@ -293,18 +293,18 @@ extirq: interrupt-controller@14 {
>                                 interrupt-controller;
>                                 reg = <0x14 4>;
>                                 interrupt-map =
> -                                       <0 0 &gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <1 0 &gic GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <2 0 &gic GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <3 0 &gic GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <4 0 &gic GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <5 0 &gic GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <6 0 &gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <7 0 &gic GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <8 0 &gic GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <9 0 &gic GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <10 0 &gic GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <11 0 &gic GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +                                       <0 0 &gic 0 0 GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <1 0 &gic 0 0 GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <2 0 &gic 0 0 GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <3 0 &gic 0 0 GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <4 0 &gic 0 0 GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <5 0 &gic 0 0 GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <6 0 &gic 0 0 GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <7 0 &gic 0 0 GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <8 0 &gic 0 0 GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <9 0 &gic 0 0 GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <10 0 &gic 0 0 GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <11 0 &gic 0 0 GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>                                 interrupt-map-mask = <0xffffffff 0x0>;
>                         };
>                 };
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index c4b1a59ba424..dc8661ebd1f6 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -680,18 +680,18 @@ extirq: interrupt-controller@14 {
>                                 interrupt-controller;
>                                 reg = <0x14 4>;
>                                 interrupt-map =
> -                                       <0 0 &gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <1 0 &gic GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <2 0 &gic GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <3 0 &gic GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <4 0 &gic GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <5 0 &gic GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <6 0 &gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <7 0 &gic GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <8 0 &gic GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <9 0 &gic GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <10 0 &gic GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> -                                       <11 0 &gic GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +                                       <0 0 &gic 0 0 GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <1 0 &gic 0 0 GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <2 0 &gic 0 0 GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <3 0 &gic 0 0 GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <4 0 &gic 0 0 GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <5 0 &gic 0 0 GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <6 0 &gic 0 0 GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <7 0 &gic 0 0 GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <8 0 &gic 0 0 GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <9 0 &gic 0 0 GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <10 0 &gic 0 0 GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <11 0 &gic 0 0 GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>                                 interrupt-map-mask = <0xffffffff 0x0>;
>                         };
>                 };
> --
> 2.30.2
>

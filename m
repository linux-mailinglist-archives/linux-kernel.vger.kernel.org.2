Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1ED33AFB4A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 05:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhFVDL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 23:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhFVDL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 23:11:28 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7973FC061574;
        Mon, 21 Jun 2021 20:09:13 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ji1so26000599ejc.4;
        Mon, 21 Jun 2021 20:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7niPUm2hSmXvDTZIayC2hRqOTqKfDH7sAfKGCNr3PSo=;
        b=Zx+57caGKfxlamUwXIlwuTe4G3ODjn+B6ted2HuK2+zIn7+TrVW2gdJcV3WxdX5s3N
         SZi/s1vDnktJkDb75Rju2zcYWol/4DqSJqO1AFsyRyAkqLmz5TRLavUZaK6+F9eqe9DK
         +xMHz+ytlIDL9ZwD+iy7cWeQ6KpavudGFcfEv2upbHvnoBjqpzH7oSy4rQKuvad1IQLV
         HLjWxc92fWmYc7nICmQ8qQI+XJ/BhU8mu+32kUgvtdIa1TjBAwWiCax9EeefIJvYK/pl
         VliD4SK7A5llEdkqCGaH2HgG81kNYg7Li/DSB4R7v6TgU0BHQ9uuxEsv10X7Yvnnbdz+
         qCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7niPUm2hSmXvDTZIayC2hRqOTqKfDH7sAfKGCNr3PSo=;
        b=sqp5sfj/+kCSRHmD2JabyWx9tHo24AK+gTJdaugAfefjEiscG5BW+xUw1BOU/i9x8e
         sw7+GORYZlzYjmHnLKkNhK+1PWhy7IfVwZ0nscTnDJc6tfdmx3QuZbjzUO4S/XdddWZh
         Nb0DV0XDn7NKH+IgYLXR0UoFb8yCE1tl2hAOe5qmV9ABjOpNPxp3gJHSndixNkSwsIWY
         ++yc4qHigQS0VP0gaCUuBj/MbsE6b+x2e5xTjjfgLQPJFyfjUlN9rTZXWuCYxOgaXVOo
         luugMiMO3VlT1BZHOah6AgGd1tAgSG7JuNr+yO70KoQslYaF21DZt/qG6vK0uH4/Qdp1
         Bgog==
X-Gm-Message-State: AOAM530Cka7lDRsGd8OWEXcxKPoBtFkamVsYsxHwMKlyuR1iAsqefozu
        NL6VtnJLDAT4hsg60e/TeMliJzOXIMoHOJWyfME=
X-Google-Smtp-Source: ABdhPJzozl3nK5cYfHbxs2Xty143R2O1VPZnWLAKoR/K4faLM/z8uiVuXlXqTrzTGoJdLISQuhOYfLCbJqd47LLTINE=
X-Received: by 2002:a17:907:1611:: with SMTP id hb17mr1418947ejc.450.1624331351539;
 Mon, 21 Jun 2021 20:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210621072424.111733-1-jagan@amarulasolutions.com> <20210621072424.111733-8-jagan@amarulasolutions.com>
In-Reply-To: <20210621072424.111733-8-jagan@amarulasolutions.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 21 Jun 2021 22:09:00 -0500
Message-ID: <CAHCN7x+RKuOwBEFC5ySHJuFiC26ZdYuv620+5FiTfrh-3y2-Lg@mail.gmail.com>
Subject: Re: [RFC PATCH 7/9] arm64: dts: imx8mm: Add eLCDIF node support
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Tomasz Figa <t.figa@samsung.com>,
        Fancy Fang <chen.fang@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Francis Laniel <francis.laniel@amarulasolutions.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Milco Pratesi <milco.pratesi@engicam.com>,
        Anthony Brandon <anthony@amarulasolutions.com>,
        linux-phy@lists.infradead.org, linux-amarula@amarulasolutions.com,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 2:25 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Add eLCDIF controller node for i.MX8MM.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index fe5485ee9419..5f68182ed3a6 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -1030,6 +1030,25 @@ aips4: bus@32c00000 {
>                         #size-cells = <1>;
>                         ranges = <0x32c00000 0x32c00000 0x400000>;
>
> +                       lcdif: lcdif@32e00000 {
> +                               compatible = "fsl,imx8mm-lcdif", "fsl,imx6sx-lcdif";

Based on a comment I read from Marek [1] from this patch series for
the driver, I think fallback compatible should be fsl,imx28-lcdif.

"The iMX8MM and iMX8MN do not support the overlay plane, so they are MXSFB V4"

[1] - https://patchwork.kernel.org/project/dri-devel/patch/20210620224834.189411-1-marex@denx.de/

adam

> +                               reg = <0x32e00000 0x10000>;
> +                               clocks = <&clk IMX8MM_CLK_LCDIF_PIXEL>,
> +                                        <&clk IMX8MM_CLK_DISP_AXI_ROOT>,
> +                                        <&clk IMX8MM_CLK_DISP_APB_ROOT>;
> +                               clock-names = "pix", "disp_axi", "axi";
> +                               assigned-clocks = <&clk IMX8MM_CLK_LCDIF_PIXEL>,
> +                                                 <&clk IMX8MM_CLK_DISP_AXI>,
> +                                                 <&clk IMX8MM_CLK_DISP_APB>;
> +                               assigned-clock-parents = <&clk IMX8MM_VIDEO_PLL1_OUT>,
> +                                                        <&clk IMX8MM_SYS_PLL2_1000M>,
> +                                                        <&clk IMX8MM_SYS_PLL1_800M>;
> +                               assigned-clock-rate = <594000000>, <500000000>, <200000000>;
> +                               interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> +                               power-domains = <&dispmix_blk_ctl IMX8MM_BLK_CTL_PD_DISPMIX_LCDIF>;
> +                               status = "disabled";
> +                       };
> +
>                         dispmix_blk_ctl: blk-ctl@32e28000 {
>                                 compatible = "fsl,imx8mm-dispmix-blk-ctl", "syscon";
>                                 reg = <0x32e28000 0x100>;
> --
> 2.25.1
>

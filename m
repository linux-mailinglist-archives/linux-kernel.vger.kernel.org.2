Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E383AFB3E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 05:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhFVDFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 23:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhFVDFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 23:05:19 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9D8C061574;
        Mon, 21 Jun 2021 20:03:03 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id dm5so19679946ejc.9;
        Mon, 21 Jun 2021 20:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=da+4q6NaLwSyvJdC1cHJtymWI03kW2GYkjWCT/Y1A3w=;
        b=gy2k2zUS3vvHEeFT8K/t1uw/Ik/U8ZjUSwaAI78IZK/2Rh/hXPm53jDGu00N38dqVb
         P7KTGSKmzPTTjnJAEK90CsQmtG21Jn/o5sHd8Dj3OioiQK05/j0iRwsDhQfgz07f5L6H
         H9HmdFf7PCTnybtXIG0QvMxU+nFamIAImlTZd2cnHZDCyttjql5Q83/QZyMxPsfJqM3C
         Fi4G5aYI45nB04c6Ov7qhTQDnXYERb7MZzt5PxkZBH51RKmi8pbtSvZxzaX/40cpZQHJ
         uiN3fboLR2B5IXVKdhFMK9YApdP2tAUgwFl5TJYg4xsbBLUKSm7KtraCAtlgxiKYJ9gc
         OOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=da+4q6NaLwSyvJdC1cHJtymWI03kW2GYkjWCT/Y1A3w=;
        b=NYFr0Dig42C0dak51Bh2IhyOrjku9AMwg4woJ6xRc1AcOai0toG+B+fFHqsMj+EuQ0
         EHftkhwvHhI8S4vpj79h5+LQFfdkpMm/wmgoKneQG9Fvf7vdtI6gYgR3oul4DzQy+EVs
         l8w0jo3MKqcsb0Ur/4znwCG0vFAl95vcVMqivK9DjhtdUffWV5vLPSKPpZY8MkR0vaIU
         SaMAlMTtP6KQPoLIgQVBNXSHVTxtUX3pf+ncB+LXlwXlVLmjA2J61RlVCfzsSKXUDpp0
         vt8gxGnuZZztAHUmplNNUdh5PDaukLTKiJfwv1UI9Gub47l/XKmpjSXv0bt/kSzu3AUN
         H86Q==
X-Gm-Message-State: AOAM530BPyalghvAjY7NvX+FSmymwm0o17s7XIoNW10urSXvZK6Gr3rF
        uXTj9ZAh3Og76gVGRnJBcJMmc1x6CUFctP/vNTw=
X-Google-Smtp-Source: ABdhPJwTpZSUk7a7ji8GbDsL0O3cqdtmO37/E7ZrMLkoLP94ZzbbS+wlrcGNOVyZFoXHv/hgM50vJA0TdhnuoPUoPI4=
X-Received: by 2002:a17:906:244d:: with SMTP id a13mr1416742ejb.551.1624330981487;
 Mon, 21 Jun 2021 20:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210621072424.111733-1-jagan@amarulasolutions.com> <20210621072424.111733-9-jagan@amarulasolutions.com>
In-Reply-To: <20210621072424.111733-9-jagan@amarulasolutions.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 21 Jun 2021 22:02:50 -0500
Message-ID: <CAHCN7xKNarHo6DaAN-J=QLAsfTXOvChOuLR68h6CPgRe-q+rmA@mail.gmail.com>
Subject: Re: [RFC PATCH 8/9] arm64: dts: imx8mm: Add MIPI DSI pipeline
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
> Add MIPI DSI pipeline for i.MX8MM.
>
> Video pipeline start from eLCDIF to MIPI DSI and respective
> Panel or Bridge on the backend side.
>
> Add support for it.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 59 +++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index 5f68182ed3a6..bc09fce0f6a9 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -1047,6 +1047,65 @@ lcdif: lcdif@32e00000 {
>                                 interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>                                 power-domains = <&dispmix_blk_ctl IMX8MM_BLK_CTL_PD_DISPMIX_LCDIF>;
>                                 status = "disabled";
> +
> +                               port {
> +                                       lcdif_out_dsi: endpoint {
> +                                               remote-endpoint = <&dsi_in_lcdif>;
> +                                       };
> +                               };
> +                       };
> +
> +                       dsi: dsi@32e10000 {
> +                               compatible = "fsl,imx8mm-sec-dsim";
> +                               reg = <0x32e10000 0xa0>;
> +                               clocks = <&clk IMX8MM_CLK_DSI_CORE>,
> +                                        <&clk IMX8MM_CLK_DSI_PHY_REF>;
> +                               clock-names = "bus", "phy_ref";
> +                               assigned-clocks = <&clk IMX8MM_CLK_DSI_CORE>,
> +                                                 <&clk IMX8MM_VIDEO_PLL1_OUT>,
> +                                                 <&clk IMX8MM_CLK_DSI_PHY_REF>;
> +                               assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_266M>,
> +                                                        <&clk IMX8MM_VIDEO_PLL1_BYPASS>,
> +                                                        <&clk IMX8MM_VIDEO_PLL1_OUT>;
> +                               assigned-clock-rates = <266000000>, <594000000>, <27000000>;
> +                               interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
> +                               phys = <&dphy>;
> +                               phy-names = "dphy";
> +                               power-domains = <&dispmix_blk_ctl IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_DSI>;
> +                               samsung,burst-clock-frequency = <891000000>;
> +                               samsung,esc-clock-frequency = <54000000>;
> +                               samsung,pll-clock-frequency = <27000000>;
> +                               status = "disabled";
> +
> +                               ports {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +
> +                                       port@0 {
> +                                               reg = <0>;
> +                                               #address-cells = <1>;
> +                                               #size-cells = <0>;
> +
> +                                               dsi_in_lcdif: endpoint@0 {
> +                                                       reg = <0>;

When I build this with W=1, I get a warning:

Warning (graph_child_address):
/soc@0/bus@32c00000/dsi@32e10000/ports/port@0: graph node has single
child node 'endpoint@0', #address-cells/#size-cells are not necessary

Are there supposed to be two endpoints for port@0?

> +                                                       remote-endpoint = <&lcdif_out_dsi>;
> +                                               };
> +                                       };
> +
> +                                       port@1 {
> +                                               reg = <1>;
> +                                       };
> +                               };
> +                       };
> +
> +                       dphy: dphy@32e100a4 {
> +                               compatible = "fsl,imx8mm-sec-dsim-dphy";
> +                               reg = <0x32e100a4 0xbc>;
> +                               clocks = <&clk IMX8MM_CLK_DSI_PHY_REF>;
> +                               clock-names = "phy_ref";
> +                               #phy-cells = <0>;
> +                               power-domains = <&dispmix_blk_ctl IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_DPHY>;
> +                               status = "disabled";
>                         };
>
>                         dispmix_blk_ctl: blk-ctl@32e28000 {
> --
> 2.25.1
>

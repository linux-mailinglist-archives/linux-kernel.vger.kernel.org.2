Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93AD42E2D2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 22:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhJNUew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 16:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhJNUev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 16:34:51 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141BDC061570;
        Thu, 14 Oct 2021 13:32:46 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r18so29140919edv.12;
        Thu, 14 Oct 2021 13:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SyuUb7yHK016Zv8A4qIys6KCejm1JerRAsv0E4TU/mQ=;
        b=IQ0K377CfvF/IJAuL2RmxL05Blq96H1eJyG79Hiwwf6J3EdBxM/WVi0vBwICZ5nhoO
         RuIEBH2AKOudbw0TQhCBAEPR4Pt0xyvXhk1Nx3w+Rtw/HCxsjhZSAReife2adwS1wMIC
         WIXGgqNLjqqqtrqr/Ly75C/X5ZpxTks6UldI9d6nwZavIqzaEdDQZS568Ej7qCPvL+ec
         LgSbHw+ozh1LpbfuFvn1liXx8m8TLzRaV2pcCyiycwERqRwsifyehF/m1uECWSGcOWQp
         Ie+zoLv3goa/z/43VvxT6E0miAS0shwpUOzfAPNb2tPTuLm5aottPmpY1KxdIlTUOhGw
         m+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SyuUb7yHK016Zv8A4qIys6KCejm1JerRAsv0E4TU/mQ=;
        b=Hgov4/75iIPZs3albYtFWyTodVr5lOMWcmLv26yiztMh8gNvYmpSguJs48p6qZW8ty
         H3pw6KSjV1EsAoiqkmyKx4Bl+xr0id820fuV68pPIsI4a+cRaMwVzITUrwL2YdbUQ5Fk
         8f8/G7dXqzNPm+GKV/0FdiNKBti1YwQ1CotHvALvRlRcAeoz0QqeVc5M3J1GPaIfUe7D
         78O0Ll5cJ85lzyLBMqRC5JZzjPFulfLg6GgVLga4/h0M+wKK3iWGi+kw9zrUo2lQ//V8
         94Ide09CS2mLk+SP06Zf5paPBPswwkyKNJ4HBCO+vhv6vUIE6rTtezt72rq1JrN4JxGX
         l7Sg==
X-Gm-Message-State: AOAM533gFgGdTweMjYacOYGya85dJae+kC0pQnpDUyENziVMMzCVtM/S
        FEzCT52hYSq71I2Q3KJ9u8s0k+cmmXct14NGo9U=
X-Google-Smtp-Source: ABdhPJzShQ/SIz8F8lALyGQ5/iwUUHOPDG5Eipb30Q0y9FwWhEYyrBWf6BBhU0RxmcTUBCGuZwT80/gKpG1h0D2hjes=
X-Received: by 2002:a05:6402:cb2:: with SMTP id cn18mr9201826edb.249.1634243564475;
 Thu, 14 Oct 2021 13:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211014025234.145147-1-aford173@gmail.com>
In-Reply-To: <20211014025234.145147-1-aford173@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 14 Oct 2021 15:32:33 -0500
Message-ID: <CAHCN7xL8FOZcRkqsxGo5k88_3P7HW67tWdwcbQdeBWx4KY4ihg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mm: Add CSI nodes
To:     arm-soc <linux-arm-kernel@lists.infradead.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 9:52 PM Adam Ford <aford173@gmail.com> wrote:
>
> There is a csi bridge and csis interface that tie together
> to allow csi2 capture.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Laurent,

Since you did some work to make the csis functional on the imx8mm, I
was hoping you might have some insights.  Please see below:

>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index c2f3f118f82e..8a8a5d0a4a1e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -1068,6 +1068,22 @@ aips4: bus@32c00000 {
>                         #size-cells = <1>;
>                         ranges = <0x32c00000 0x32c00000 0x400000>;
>
> +                       csi: csi@32e20000 {
> +                               compatible = "fsl,imx7-csi";
> +                               reg = <0x32e20000 0x1000>;
> +                               interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> +                               clocks = <&clk IMX8MM_CLK_CSI1_ROOT>;
> +                               clock-names = "mclk";
> +                               power-domains = <&disp_blk_ctrl IMX8MM_DISPBLK_PD_CSI_BRIDGE>;
> +                               status = "disabled";
> +
> +                               port {
> +                                       csi_in: endpoint {
> +                                               remote-endpoint = <&imx8mm_mipi_csi_out>;
> +                                       };
> +                               };
> +                       };
> +
>                         disp_blk_ctrl: blk-ctrl@32e28000 {
>                                 compatible = "fsl,imx8mm-disp-blk-ctrl", "syscon";
>                                 reg = <0x32e28000 0x100>;
> @@ -1095,6 +1111,41 @@ disp_blk_ctrl: blk-ctrl@32e28000 {
>                                 #power-domain-cells = <1>;
>                         };
>
> +                       mipi_csi2: mipi-csi@32e30000 {
> +                               compatible = "fsl,imx8mm-mipi-csi2";
> +                               reg = <0x32e30000 0x1000>;
> +                               interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> +                               clock-frequency = <333000000>;
> +                               clocks = <&clk IMX8MM_CLK_DISP_APB_ROOT>,
> +                                        <&clk IMX8MM_CLK_CSI1_ROOT>,
> +                                        <&clk IMX8MM_CLK_CSI1_PHY_REF>,
> +                                        <&clk IMX8MM_CLK_DISP_AXI_ROOT>;

When comparing clock parents and the clock rates to one of NXP's
kernels, it appears we need assigned-clocks and assigned-clock-parents
to allow the CSI1 clocks to run fast enough.

assigned-clocks = <&clk IMX8MM_CLK_CSI1_PHY_REF>,
  <&clk IMX8MM_CLK_CSI1_CORE>,
  <&clk IMX8MM_CLK_CSI1_ROOT>,
  <&clk IMX8MM_CLK_CSI1_ESC>;
assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_1000M>,
  <&clk IMX8MM_SYS_PLL2_1000M>,
  <&clk IMX8MM_CLK_CSI1_CORE>,
  <&clk IMX8MM_SYS_PLL1_800M>;

However, even with this, I am attempting to capture.  While I can get
the pipeline enabled, when I try to capture a file, I get no data.  i
can use control-c to exit gstreamer, so I know the kernel didn't hang.
I don't get errors, but I don't get data either.

Any ideas if what/if any other clock entries might be missing?


> +                               clock-names = "pclk", "wrap", "phy", "axi";
> +                               power-domains = <&disp_blk_ctrl IMX8MM_DISPBLK_PD_MIPI_CSI>;
> +                               status = "disabled";
> +
> +                               ports {
> +                                       #address-cells = <1>;
> +                                       #size-cells = <0>;
> +
> +                                       port@0 {
> +                                               reg = <0>;
> +
> +                                               imx8mm_mipi_csi_in: endpoint {
> +                                               };
> +                                       };
> +
> +                                       port@1 {
> +                                               reg = <1>;
> +
> +                                               imx8mm_mipi_csi_out: endpoint {
> +                                                       remote-endpoint = <&csi_in>;
> +                                               };
> +                                       };
> +                               };
> +                       };
> +
> +
>                         usbotg1: usb@32e40000 {
>                                 compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb";
>                                 reg = <0x32e40000 0x200>;
> --
> 2.25.1
>

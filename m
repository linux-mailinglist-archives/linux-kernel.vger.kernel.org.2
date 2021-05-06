Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBED37528F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 12:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbhEFKpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 06:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbhEFKp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 06:45:28 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CD4C061574;
        Thu,  6 May 2021 03:44:29 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id s7so915244edq.12;
        Thu, 06 May 2021 03:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I2+WVTkmT2ktDZMN/gY7kY+twfnNnV+x4l5PitKJK0w=;
        b=nUkdF9IgSr/6K/Vuo+H/lruDCGCJ7GTGvJRCFYRgncapK1FXL+5yUEf+CO4J/pZQWw
         sJNi2wEI0ZNq1iecitg2nvJPZzSZJomCEo7UQ2Udi0/7IUivhrL1tLS4BDTsUVIlkX4I
         h/7M/iN4WG2XtkuFBisncd7VuT+8ISFpVS8NYF4RDNV0M+YNcu3V7MzK6hlxTDnaoDC+
         AVFf+56zSYynBs3vfrckPipldWkZF2ds2wWRbtjhXnwFtL6mKGtDYP+LDuRy6onXJwiH
         F03A2I5ErQlDFchlYBC66EGHpryZNj2SB92UaHdLSKyc5YL+zO+Vf1c0M35R0+7BEGTg
         YrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I2+WVTkmT2ktDZMN/gY7kY+twfnNnV+x4l5PitKJK0w=;
        b=noCkTfqeBs7/hEvyQO6Xqel+FWVahgHL4yurHHsFoPf3uJ9eLJ5mzRtkLmNmAiAYlJ
         4s0oRbtBqdJHWOtZxAhoVpA7I4rc0Tlc+llllB7g9PNEp2+0cWkbbqzPW1xS6qDFzT+/
         XYZczHwYJk+L0jpsLdVocN/SBhOj+5JoWwvHre9d194I+kz/Lol66GdmS8cyOks6NEtL
         /cqFs97oiblilRuGlTFGF3ykAKB1S9khpWOW/x6krz6DwmhPPAH/Ne5cWw4udQm9xjd8
         gZNNxTYD2Z15yfI1WwsABSfvPrITJsgTirr+SoUmz8/bzby0I0CfYElq5uQ0fll4znQn
         Fb+Q==
X-Gm-Message-State: AOAM532O5oHC8EtlPuB6O/gQcwr5+89vq4hF6jjN6N0E/TYjbRmvFOtm
        VTmKsJFlscooL4EwGTlimDhtAKn9KjFXzJq4JIQ=
X-Google-Smtp-Source: ABdhPJzeQvXEOGH5WM7j5lVvi9H+XSSoduC5KnE1Y1zWtx62lW2trtKLpZIVz/pUBVYXxgZsUSS6I/N92RiCPXIvvaE=
X-Received: by 2002:a05:6402:268c:: with SMTP id w12mr4566374edd.234.1620297867594;
 Thu, 06 May 2021 03:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210505191126.1239309-1-aford173@gmail.com>
In-Reply-To: <20210505191126.1239309-1-aford173@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 6 May 2021 05:44:17 -0500
Message-ID: <CAHCN7xK2GLeeoRgaa1m5A9CxBieyGQe4PLZRJSEMYu+h4Wheuw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mm-beacon: Enable more audio
To:     arm-soc <linux-arm-kernel@lists.infradead.org>
Cc:     Adam Ford-BE <aford@beaconembedded.com>,
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

On Wed, May 5, 2021 at 2:11 PM Adam Ford <aford173@gmail.com> wrote:
>
> There are audio ports for SPDIF and MICFIL on the baseboard.
> Enable them.
>

Sorry for the noise,  I copied these bindings from NXP's 5.10 branch,
but I didn't realize that fsl,imx-audio-micfil doesn't exist upstream.
I'm going to see if a simple audio driver will work.  Either way, I'll
NAK my own work and submit a V2 later.

adam
> Signed-off-by: Adam Ford <aford173@gmail.com>
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
> index 6f5e63696ec0..3039a030f3d8 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
> @@ -65,6 +65,20 @@ sound {
>                         "AMIC", "MICBIAS",
>                         "IN3R", "AMIC";
>         };
> +
> +       sound-micfil {
> +               compatible = "fsl,imx-audio-micfil";
> +               model = "imx-audio-micfil";
> +               cpu-dai = <&micfil>;
> +       };
> +
> +       sound-spdif {
> +               compatible = "fsl,imx-audio-spdif";
> +               model = "imx-spdif";
> +               spdif-controller = <&spdif1>;
> +               spdif-out;
> +               spdif-in;
> +       };
>  };
>
>  &ecspi2 {
> @@ -141,6 +155,15 @@ pca6416_1: gpio@21 {
>         };
>  };
>
> +&micfil {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_micfil>;
> +       assigned-clocks = <&clk IMX8MM_CLK_PDM>;
> +       assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
> +       assigned-clock-rates = <196608000>;
> +       status = "okay";
> +};
> +
>  &sai3 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_sai3>;
> @@ -155,6 +178,23 @@ &snvs_pwrkey {
>         status = "okay";
>  };
>
> +&spdif1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_spdif1>;
> +       assigned-clocks = <&clk IMX8MM_CLK_SPDIF1>;
> +       assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
> +       assigned-clock-rates = <24576000>;
> +       clocks = <&clk IMX8MM_CLK_AUDIO_AHB>, <&clk IMX8MM_CLK_24M>,
> +               <&clk IMX8MM_CLK_SPDIF1>, <&clk IMX8MM_CLK_DUMMY>,
> +               <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>,
> +               <&clk IMX8MM_CLK_AUDIO_AHB>, <&clk IMX8MM_CLK_DUMMY>,
> +               <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>,
> +               <&clk IMX8MM_AUDIO_PLL1_OUT>, <&clk IMX8MM_AUDIO_PLL2_OUT>;
> +       clock-names = "core", "rxtx0", "rxtx1", "rxtx2", "rxtx3",
> +               "rxtx4", "rxtx5", "rxtx6", "rxtx7", "spba", "pll8k", "pll11k";
> +       status = "okay";
> +};
> +
>  &uart2 { /* console */
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_uart2>;
> @@ -209,6 +249,13 @@ MX8MM_IOMUXC_SAI3_RXFS_GPIO4_IO28  0x41
>                 >;
>         };
>
> +       pinctrl_micfil: micfilgrp {
> +               fsl,pins = <
> +                       MX8MM_IOMUXC_SAI5_RXC_PDM_CLK           0xd6
> +                       MX8MM_IOMUXC_SAI5_RXD0_PDM_DATA0        0xd6
> +               >;
> +       };
> +
>         pinctrl_pcal6414: pcal6414-gpiogrp {
>                 fsl,pins = <
>                         MX8MM_IOMUXC_SAI2_MCLK_GPIO4_IO27               0x19
> @@ -225,6 +272,14 @@ MX8MM_IOMUXC_SAI3_RXD_SAI3_RX_DATA0        0xd6
>                 >;
>         };
>
> +       pinctrl_spdif1: spdif1grp {
> +               fsl,pins = <
> +                       MX8MM_IOMUXC_SPDIF_TX_SPDIF1_OUT        0xd6
> +                       MX8MM_IOMUXC_SPDIF_RX_SPDIF1_IN         0xd6
> +                       MX8MM_IOMUXC_SPDIF_EXT_CLK_SPDIF1_EXT_CLK       0xd6
> +               >;
> +       };
> +
>         pinctrl_uart2: uart2grp {
>                 fsl,pins = <
>                         MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX     0x140
> --
> 2.25.1
>

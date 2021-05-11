Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F8C37A4E2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 12:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhEKKqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 06:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbhEKKqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 06:46:38 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201DAC061574;
        Tue, 11 May 2021 03:45:31 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id f24so29058947ejc.6;
        Tue, 11 May 2021 03:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bWKGwnwAwFRl36HwtmKxtqsTpE9XdFfKDjDcwRdKExw=;
        b=kcEOB9++K3pe+4XTCRH3oLbORZ4nzWQ9kEQiRNJ1dW+oU2N+Sd0HaZhVwU/TBGz5S4
         l/B+novxVhXPmgB3tRrLAU1wHlJYQyS/2zOdCO8W7KDH6eka0G2Na1Hl4BcZdVS89aXO
         ApAhLTwP5tAGYHzByyUOBcuOvYwdbSnu3GvoQ7vmHyHzlx/u95mlmO6JjdllI8JFc2gt
         AkPP9WH16eEvafOabigPDBNYJwpzpOxshzmUIQq3/PC3SlH5Xjj+PGNAPgwJ/g9dBnIu
         xZfdWyiXceo3o2BxIUQBDt/98bgozRChTRJw8RQ+RoFebwqxJzf9H/2jOq+Scli7Il8c
         fq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bWKGwnwAwFRl36HwtmKxtqsTpE9XdFfKDjDcwRdKExw=;
        b=PxJkiN246zvxN+oNxSWXQO5viKAvFhMGyeTCcyYoytA2zSl0Ytqbc6UCbb+os9YFA8
         cMmx/sTb9ZxdFWJG2NvH13jLRXYiEq8VGMUplE0aOFOmPszzZWy2u34dEOJCDRtHjI+J
         vTZR70brtkJ2YxLKm4C8SrDisriPJNlR8acy6XSQfou0/IoA2bMdtG1aF36nP5kzCVd/
         WRp5WzwKnrSw+Bw1l8fuKhZb5ATSuNmH314THYGpz7D+2/yjh097i7+RZMZdmaQI3FWz
         JbW8KpwDHaQ454QyWLJUj2pgXji37GCjCLfbEzJ1bpDW7nYesYA7/V+pxrYBzLOckMpx
         k7Sw==
X-Gm-Message-State: AOAM532fbWDehW8ebW3lQy8HK1wo4tN7YfqJ10nC+WrCO1yUHm6NiCsq
        2NW8z/uRv37hRR4dFeOcpZjM7ORFBa2WHs5FTCs=
X-Google-Smtp-Source: ABdhPJxl6p2gQdPm8BORwq0bVwzWhMQQLIiSAKvtPX270GOkf816VrXHxAerJtpe1JXpnG/MqO4mXszAThlhMFebQmk=
X-Received: by 2002:a17:906:7ac9:: with SMTP id k9mr31528167ejo.229.1620729929659;
 Tue, 11 May 2021 03:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210406013344.124255-1-aford173@gmail.com> <20210511024604.GE3425@dragon>
In-Reply-To: <20210511024604.GE3425@dragon>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 11 May 2021 05:45:17 -0500
Message-ID: <CAHCN7xLFpL=9BF9M5gUA6sMhc2ZZMNz+GP0OLmLfpJAWdD7W-w@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mn: Add spba1 bus
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
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

On Mon, May 10, 2021 at 9:46 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Mon, Apr 05, 2021 at 08:33:42PM -0500, Adam Ford wrote:
> > The i.MX8MN has an SPBA bus which covers much of the audio, but
> > there is a second SPBA bus which covers many of the serial interfaces
> > like SPI and UARTs currently missing from the device tree. The reference
> > manual calls the bus handling the audio peripherals SPBA2, and the bus
> > handling the serial peripherals is called SPBA1.
> >
> > Rename the existing spba bus to spba2 and add spba1.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > index 4dac4da38f4c..e961acd237a8 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
> > @@ -255,7 +255,7 @@ aips1: bus@30000000 {
> >                       #size-cells = <1>;
> >                       ranges;
> >
> > -                     spba: spba-bus@30000000 {
> > +                     spba2: spba-bus@30000000 {
> >                               compatible = "fsl,spba-bus", "simple-bus";
>
> Just noticed that "fsl,spba-bus" is undocumented, no?

I attempted to push the bindings, and I was told it was applied, but
when I asked where the bindings were applied I never got a response -
[1].

Do you want me to resend the bindings?

>
> Also may I ask if you have a real use case for this bus node?

The reference manual shows the SPBA bus tells the DMA controller which
peripherals are associated with it.  Nearly all the i.MX boards use
this.  The boards I support have Bluetooth devices connected to a UART
running high speeds, and if the DMA driver isn't loaded, I can see a
performance change.  In fact, if the DMA firmware isn't loaded, I
often get transfer errors.

adam

[1] - https://lore.kernel.org/linux-devicetree/CAHCN7x+om4W5jqnuAW4-nMkZLc5nrYu7NUsbM36r0wyFSYa4-g@mail.gmail.com/T/

>
> Shawn
>
> >                               #address-cells = <1>;
> >                               #size-cells = <1>;
> > @@ -681,80 +681,88 @@ aips3: bus@30800000 {
> >                       #size-cells = <1>;
> >                       ranges;
> >
> > -                     ecspi1: spi@30820000 {
> > -                             compatible = "fsl,imx8mn-ecspi", "fsl,imx51-ecspi";
> > +                     spba1: spba-bus@30800000 {
> > +                             compatible = "fsl,spba-bus", "simple-bus";
> >                               #address-cells = <1>;
> > -                             #size-cells = <0>;
> > -                             reg = <0x30820000 0x10000>;
> > -                             interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> > -                             clocks = <&clk IMX8MN_CLK_ECSPI1_ROOT>,
> > -                                      <&clk IMX8MN_CLK_ECSPI1_ROOT>;
> > -                             clock-names = "ipg", "per";
> > -                             dmas = <&sdma1 0 7 1>, <&sdma1 1 7 2>;
> > -                             dma-names = "rx", "tx";
> > -                             status = "disabled";
> > -                     };
> > +                             #size-cells = <1>;
> > +                             reg = <0x30800000 0x100000>;
> > +                             ranges;
> >
> > -                     ecspi2: spi@30830000 {
> > -                             compatible = "fsl,imx8mn-ecspi", "fsl,imx51-ecspi";
> > -                             #address-cells = <1>;
> > -                             #size-cells = <0>;
> > -                             reg = <0x30830000 0x10000>;
> > -                             interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> > -                             clocks = <&clk IMX8MN_CLK_ECSPI2_ROOT>,
> > -                                      <&clk IMX8MN_CLK_ECSPI2_ROOT>;
> > -                             clock-names = "ipg", "per";
> > -                             dmas = <&sdma1 2 7 1>, <&sdma1 3 7 2>;
> > -                             dma-names = "rx", "tx";
> > -                             status = "disabled";
> > -                     };
> > +                             ecspi1: spi@30820000 {
> > +                                     compatible = "fsl,imx8mn-ecspi", "fsl,imx51-ecspi";
> > +                                     #address-cells = <1>;
> > +                                     #size-cells = <0>;
> > +                                     reg = <0x30820000 0x10000>;
> > +                                     interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> > +                                     clocks = <&clk IMX8MN_CLK_ECSPI1_ROOT>,
> > +                                              <&clk IMX8MN_CLK_ECSPI1_ROOT>;
> > +                                     clock-names = "ipg", "per";
> > +                                     dmas = <&sdma1 0 7 1>, <&sdma1 1 7 2>;
> > +                                     dma-names = "rx", "tx";
> > +                                     status = "disabled";
> > +                             };
> >
> > -                     ecspi3: spi@30840000 {
> > -                             compatible = "fsl,imx8mn-ecspi", "fsl,imx51-ecspi";
> > -                             #address-cells = <1>;
> > -                             #size-cells = <0>;
> > -                             reg = <0x30840000 0x10000>;
> > -                             interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> > -                             clocks = <&clk IMX8MN_CLK_ECSPI3_ROOT>,
> > -                                      <&clk IMX8MN_CLK_ECSPI3_ROOT>;
> > -                             clock-names = "ipg", "per";
> > -                             dmas = <&sdma1 4 7 1>, <&sdma1 5 7 2>;
> > -                             dma-names = "rx", "tx";
> > -                             status = "disabled";
> > -                     };
> > +                             ecspi2: spi@30830000 {
> > +                                     compatible = "fsl,imx8mn-ecspi", "fsl,imx51-ecspi";
> > +                                     #address-cells = <1>;
> > +                                     #size-cells = <0>;
> > +                                     reg = <0x30830000 0x10000>;
> > +                                     interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> > +                                     clocks = <&clk IMX8MN_CLK_ECSPI2_ROOT>,
> > +                                              <&clk IMX8MN_CLK_ECSPI2_ROOT>;
> > +                                     clock-names = "ipg", "per";
> > +                                     dmas = <&sdma1 2 7 1>, <&sdma1 3 7 2>;
> > +                                     dma-names = "rx", "tx";
> > +                                     status = "disabled";
> > +                             };
> >
> > -                     uart1: serial@30860000 {
> > -                             compatible = "fsl,imx8mn-uart", "fsl,imx6q-uart";
> > -                             reg = <0x30860000 0x10000>;
> > -                             interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> > -                             clocks = <&clk IMX8MN_CLK_UART1_ROOT>,
> > -                                      <&clk IMX8MN_CLK_UART1_ROOT>;
> > -                             clock-names = "ipg", "per";
> > -                             dmas = <&sdma1 22 4 0>, <&sdma1 23 4 0>;
> > -                             dma-names = "rx", "tx";
> > -                             status = "disabled";
> > -                     };
> > +                             ecspi3: spi@30840000 {
> > +                                     compatible = "fsl,imx8mn-ecspi", "fsl,imx51-ecspi";
> > +                                     #address-cells = <1>;
> > +                                     #size-cells = <0>;
> > +                                     reg = <0x30840000 0x10000>;
> > +                                     interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> > +                                     clocks = <&clk IMX8MN_CLK_ECSPI3_ROOT>,
> > +                                              <&clk IMX8MN_CLK_ECSPI3_ROOT>;
> > +                                     clock-names = "ipg", "per";
> > +                                     dmas = <&sdma1 4 7 1>, <&sdma1 5 7 2>;
> > +                                     dma-names = "rx", "tx";
> > +                                     status = "disabled";
> > +                             };
> >
> > -                     uart3: serial@30880000 {
> > -                             compatible = "fsl,imx8mn-uart", "fsl,imx6q-uart";
> > -                             reg = <0x30880000 0x10000>;
> > -                             interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> > -                             clocks = <&clk IMX8MN_CLK_UART3_ROOT>,
> > -                                      <&clk IMX8MN_CLK_UART3_ROOT>;
> > -                             clock-names = "ipg", "per";
> > -                             dmas = <&sdma1 26 4 0>, <&sdma1 27 4 0>;
> > -                             dma-names = "rx", "tx";
> > -                             status = "disabled";
> > -                     };
> > +                             uart1: serial@30860000 {
> > +                                     compatible = "fsl,imx8mn-uart", "fsl,imx6q-uart";
> > +                                     reg = <0x30860000 0x10000>;
> > +                                     interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> > +                                     clocks = <&clk IMX8MN_CLK_UART1_ROOT>,
> > +                                              <&clk IMX8MN_CLK_UART1_ROOT>;
> > +                                     clock-names = "ipg", "per";
> > +                                     dmas = <&sdma1 22 4 0>, <&sdma1 23 4 0>;
> > +                                     dma-names = "rx", "tx";
> > +                                     status = "disabled";
> > +                             };
> >
> > -                     uart2: serial@30890000 {
> > -                             compatible = "fsl,imx8mn-uart", "fsl,imx6q-uart";
> > -                             reg = <0x30890000 0x10000>;
> > -                             interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
> > -                             clocks = <&clk IMX8MN_CLK_UART2_ROOT>,
> > -                                      <&clk IMX8MN_CLK_UART2_ROOT>;
> > -                             clock-names = "ipg", "per";
> > -                             status = "disabled";
> > +                             uart3: serial@30880000 {
> > +                                     compatible = "fsl,imx8mn-uart", "fsl,imx6q-uart";
> > +                                     reg = <0x30880000 0x10000>;
> > +                                     interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> > +                                     clocks = <&clk IMX8MN_CLK_UART3_ROOT>,
> > +                                              <&clk IMX8MN_CLK_UART3_ROOT>;
> > +                                     clock-names = "ipg", "per";
> > +                                     dmas = <&sdma1 26 4 0>, <&sdma1 27 4 0>;
> > +                                     dma-names = "rx", "tx";
> > +                                     status = "disabled";
> > +                             };
> > +
> > +                             uart2: serial@30890000 {
> > +                                     compatible = "fsl,imx8mn-uart", "fsl,imx6q-uart";
> > +                                     reg = <0x30890000 0x10000>;
> > +                                     interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
> > +                                     clocks = <&clk IMX8MN_CLK_UART2_ROOT>,
> > +                                              <&clk IMX8MN_CLK_UART2_ROOT>;
> > +                                     clock-names = "ipg", "per";
> > +                                     status = "disabled";
> > +                             };
> >                       };
> >
> >                       crypto: crypto@30900000 {
> > --
> > 2.25.1
> >

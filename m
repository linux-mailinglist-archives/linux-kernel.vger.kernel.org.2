Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB0C42D957
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 14:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhJNMfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 08:35:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230177AbhJNMfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 08:35:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DCFB61130;
        Thu, 14 Oct 2021 12:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634214822;
        bh=RzeylZ/P8x5KQVd3L6CJnKExKqdgjhxzj85+6UhIMm8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ljVcbHGVTczlkVC7vHhhCQuqYe0equRdtOUpMCpuRpgyhqosziC4k8T+knTCT9X4b
         6id5F1xtARmDPPViBbuzWyVC/i8X59VghnSshHhHGNSf/u2DbgFHzLAm+2fK6vCQD1
         5Kc/hmge0LSx/ou+COWai128l/CjE6/lhoShMLAt9UeZ7DNt89bAxoiXJOyS8Pxodp
         RQ4gU2WNmhcHQSl36DVRJ4utiM0d02him1Awi3U2vzvE26Tjz8NgM7zP98cW/TlrZo
         5xFd8XNMb97X/0Uhytl45MBd8QWheJAT1gSmW6ZtPUGT+yD/txD1IB/QvBmVzZhsSN
         Xa3z/T6kR7cTA==
Received: by mail-ed1-f48.google.com with SMTP id g10so23806225edj.1;
        Thu, 14 Oct 2021 05:33:42 -0700 (PDT)
X-Gm-Message-State: AOAM530YBrbx3+GSU9QTW8zH18/hZWLqNDzcnZvOvaAeYu/IxMhNudm8
        JwugcG3wIYP1jHZzuomMcW1cFA779p62o3lgVg==
X-Google-Smtp-Source: ABdhPJz9TzvElbvIznv9o6eIIhwkZkQvDvfEK/2kZapQkBCcKpS4ncnsn5muDvV6i+hmDO5BxA6TJzf2waYTwhLdyeE=
X-Received: by 2002:a17:906:9399:: with SMTP id l25mr3470036ejx.363.1634214819463;
 Thu, 14 Oct 2021 05:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20211014113123.2358-1-agust@denx.de>
In-Reply-To: <20211014113123.2358-1-agust@denx.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 14 Oct 2021 07:33:26 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJQ8_3+pwT0a-gj5iSUSo3kYZXFraejjBGObNHpB+xcTg@mail.gmail.com>
Message-ID: <CAL_JsqJQ8_3+pwT0a-gj5iSUSo3kYZXFraejjBGObNHpB+xcTg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mpc512x: dts: fix PSC node warnings
To:     Anatolij Gustschin <agust@denx.de>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 6:31 AM Anatolij Gustschin <agust@denx.de> wrote:
>
> Fix build warnings like:
> mpc5121.dtsi:397.13-406.5: Warning (spi_bus_bridge): /soc@80000000/psc@11400: node name for SPI buses should be 'spi'
> mpc5121.dtsi:409.13-418.5: Warning (spi_bus_bridge): /soc@80000000/psc@11500: node name for SPI buses should be 'spi'
> mpc5121.dtsi:457.13-466.5: Warning (spi_bus_bridge): /soc@80000000/psc@11900: node name for SPI buses should be 'spi'
>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
>  arch/powerpc/boot/dts/ac14xx.dts   | 17 +++++++++++++++--
>  arch/powerpc/boot/dts/pdm360ng.dts | 11 ++++++++++-
>  2 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/ac14xx.dts b/arch/powerpc/boot/dts/ac14xx.dts
> index 5d8877e1f4ad..662d7aa2e4e8 100644
> --- a/arch/powerpc/boot/dts/ac14xx.dts
> +++ b/arch/powerpc/boot/dts/ac14xx.dts
> @@ -301,13 +301,21 @@
>                         fsl,tx-fifo-size = <512>;
>                 };
>
> +               /delete-node/ psc@11400;
> +               /delete-node/ psc@11500;

That's an odd way to fix this, and means every user of the .dtsi file
with these nodes will have to repeat the same thing.

> +
>                 /* PSC4 in SPI mode */
> -               spi4: psc@11400 {
> +               spi4: spi@11400 {
>                         compatible = "fsl,mpc5121-psc-spi", "fsl,mpc5121-psc";
> +                       reg = <0x11400 0x100>;
>                         fsl,rx-fifo-size = <768>;
>                         fsl,tx-fifo-size = <768>;
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> +                       interrupts = <40 0x8>;
> +                       clocks = <&clks MPC512x_CLK_PSC4>,
> +                                <&clks MPC512x_CLK_PSC4_MCLK>;
> +                       clock-names = "ipg", "mclk";
>                         num-cs = <1>;
>                         cs-gpios = <&gpio_pic 25 0>;
>
> @@ -326,13 +334,18 @@
>                 };
>
>                 /* PSC5 in SPI mode */
> -               spi5: psc@11500 {
> +               spi5: spi@11500 {
>                         compatible = "fsl,mpc5121-psc-spi", "fsl,mpc5121-psc";
> +                       reg = <0x11500 0x100>;
>                         fsl,mode = "spi-master";
>                         fsl,rx-fifo-size = <128>;
>                         fsl,tx-fifo-size = <128>;
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> +                       interrupts = <40 0x8>;
> +                       clocks = <&clks MPC512x_CLK_PSC5>,
> +                                <&clks MPC512x_CLK_PSC5_MCLK>;
> +                       clock-names = "ipg", "mclk";
>
>                         lcd@0 {
>                                 compatible = "ilitek,ili922x";
> diff --git a/arch/powerpc/boot/dts/pdm360ng.dts b/arch/powerpc/boot/dts/pdm360ng.dts
> index 67c3b9db75d7..2733d15079a9 100644
> --- a/arch/powerpc/boot/dts/pdm360ng.dts
> +++ b/arch/powerpc/boot/dts/pdm360ng.dts
> @@ -169,10 +169,19 @@
>                         compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
>                 };
>
> -               psc@11900 {
> +               /delete-node/ psc@11900;
> +
> +               spi@11900 {
>                         compatible = "fsl,mpc5121-psc-spi", "fsl,mpc5121-psc";
> +                       reg = <0x11900 0x100>;
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> +                       interrupts = <40 0x8>;
> +                       fsl,rx-fifo-size = <16>;
> +                       fsl,tx-fifo-size = <16>;
> +                       clocks = <&clks MPC512x_CLK_PSC9>,
> +                                <&clks MPC512x_CLK_PSC9_MCLK>;
> +                       clock-names = "ipg", "mclk";
>
>                         /* ADS7845 touch screen controller */
>                         ts@0 {
> --
> 2.17.1
>

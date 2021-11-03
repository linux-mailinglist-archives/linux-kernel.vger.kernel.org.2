Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3064448AE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 19:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhKCS6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 14:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhKCS6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 14:58:42 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC558C061714;
        Wed,  3 Nov 2021 11:56:05 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id e65so3181553pgc.5;
        Wed, 03 Nov 2021 11:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q/BrXCmOSs3/mGKmysJ1cd+BoUzUQUIDjvCN0RCeiw8=;
        b=NSwMeLR1j7w1qSNmkTnf3xnPLC9Z3bdnDxsH7+/ioFXR4avq8tZT9vmiGNvbnV2pU6
         c0dhQ+XuYG/CDn41eo/FSLoPNl9qr18l4LCKP25Y8Sz8lyKB2V5UOyvIFQkByv9HeBRF
         dklqbvtdB6dVDIkU44FVEul9rkGIYHJSivnFWQik0CfibTKzB7Z7XljaEgJWmmW6cSra
         v1bWC9uhksYBnlo0mwi1IvIbMpWizCRGbbgcDVXMSVPitJcbNTFB/K1UkPjGmGvWWasL
         dFahh/CabnqdAWwY2y49s51dvPGlZ3VWPEJK9m9ZstH7Tl5505E2J4MW3ltCbvBwayd2
         mdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q/BrXCmOSs3/mGKmysJ1cd+BoUzUQUIDjvCN0RCeiw8=;
        b=U06X4u2Dt/8TJxcfFsJ7GBrnGTNeSpPcbCwtFyTngA3g61cf4YvN3P7FqthnZYi5vJ
         etg3Qanv8S99583B8+YdalWnRcbqtX8wTvf6X6L9WWhD5xqJSmG6Oskinl7eikTl+nXf
         2J4sSZeIyTStqfpCBODbg9awzkZ3m0TtxXBMXOSpIFOseri2KQA38OzRfBKsWPA6AHuU
         36w3QafG+ep0POk+I7GqaHRa+HvBTp3UgBGH3OLzbttM4bYBW+GPuqU9+/X3qe1/zPch
         jTEjjfJFrkRsCIoNsSsBNuB/j01gNcm/uVYAqjyQvNtdLh5M3jZPAw2oXgpm2EL0XD44
         ayxQ==
X-Gm-Message-State: AOAM530fLY3gxo93sa+Ww5Ty6X07qsAGoyzi3yiPraBw8fEDOl4wh2ty
        Drwv9WCkOokrzepDiyAGo9AEYW1ki3P77q+GYLM=
X-Google-Smtp-Source: ABdhPJxTZj1iVDBD+igMJrt6cgGEXt4/wkX17YOCZmoKy2lm82ZBJHpFyBB4oHn84FqNgmFsQb1EVGcZzaNAkqRMyV4=
X-Received: by 2002:a63:ed0e:: with SMTP id d14mr3402467pgi.92.1635965764955;
 Wed, 03 Nov 2021 11:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <20211103135313.6428-1-tomm.merciai@gmail.com>
In-Reply-To: <20211103135313.6428-1-tomm.merciai@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 3 Nov 2021 13:55:54 -0500
Message-ID: <CAHCN7xLOkvahKSzuUAe5d4sBMoMs51PHDt3G5PB+jEtDkRf30Q@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: imx8mm: Add NOC node
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 8:53 AM Tommaso Merciai <tomm.merciai@gmail.com> wrote:
>
> Add support for dynamic frequency scaling of the main NOC configuration
> on imx8mm.
>
> References:
>  - i.MX 8M Mini Applications Processor RM, Rev. 3, 11/2020
>  - f18e6d573b80 arm64: dts: imx8mq: Add NOC node
>  - 912b9dacf3f0 arm64: dts: imx8mq: increase NOC clock to 800 MHz
>  - https://source.codeaurora.org/external/imx/linux-imx/tree/arch/ \
>    arm64/boot/dts/freescale/imx8mm.dtsi?h=lf-5.10.y
>

You're missing the signed-off-by tag.

From what I can tell, the default NOC clock is 750MHz.  With this
patch enabled, i can manually change the NOC clock to 150, 375 or 750,
but it's not clear to me what this impacts.  In the 8MQ, there are a
couple peripherals that are linked to the NOC, but we don't have those
same peripherals enabled in the 8mm.  The
dt-bindings/interconnect/imx8mq.h list more NOC references than are
used in the device tree, so it's unclear to me if and what we need to
reference anything in the 8MM based on
dt-bindings/interconnect/imx8mm.h

adam

> ---
> Changes since v1:
>  - Fix noc_opp_table frequencies taking NXP bsp as reference
>  - Add reference link to nxp imx8mm dtsi on commit body
>
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 25 +++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index c2f3f118f82e..1bcc5e361ca3 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -719,6 +719,31 @@ pgc_mipi: power-domain@11 {
>                         };
>                 };
>
> +               noc: interconnect@32700000 {
> +                       compatible = "fsl,imx8mm-noc", "fsl,imx8m-noc";
> +                       reg = <0x32700000 0x100000>;
> +                       clocks = <&clk IMX8MM_CLK_NOC>;
> +                       fsl,ddrc = <&ddrc>;
> +                       #interconnect-cells = <1>;
> +                       operating-points-v2 = <&noc_opp_table>;
> +
> +                       noc_opp_table: opp-table {
> +                               compatible = "operating-points-v2";
> +
> +                               opp-150M {
> +                                       opp-hz = /bits/ 64 <150000000>;
> +                               };
> +
> +                               opp-375M {
> +                                       opp-hz = /bits/ 64 <375000000>;
> +                               };
> +
> +                               opp-750M {
> +                                       opp-hz = /bits/ 64 <750000000>;
> +                               };
> +                       };
> +               };
> +
>                 aips2: bus@30400000 {
>                         compatible = "fsl,aips-bus", "simple-bus";
>                         reg = <0x30400000 0x400000>;
> --
> 2.25.1
>

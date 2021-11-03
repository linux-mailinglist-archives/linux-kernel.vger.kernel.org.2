Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB32444245
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 14:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhKCNW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 09:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhKCNWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 09:22:25 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12576C061714;
        Wed,  3 Nov 2021 06:19:49 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id o8so9178441edc.3;
        Wed, 03 Nov 2021 06:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iBw1yCNAA4AvNhG6fsCpNeC6xd4fv5a0QO7+TeMW5tA=;
        b=HTIoVNTxRT6hNM5LESbhnxcGZT7AvCkDzzgpLZhbYoUYfyHgpYWtcPNB9nSZweVMeT
         lzZhxLQaJLYt9Wd1f/djPCvUAFW21ZOYGzFj6OHdfl8pt2Qn6uFhAI70gfD5Hx6HqtXB
         q0WIKRsR/g0+OiM04hRDMrasK2TVVfgYWkPpCTWPv7u9sTNGMY4BjI4OEgTq/FuGNTtw
         lHRCtBvdw0s03AaZvOOihBhPhz8l6QFJWB60kdMAIO8KniJgBKkSD4EUFHHPmVpDKtD2
         4GUsgh4ry0Jpm7jIMNx7r34GpJ8q0yfHetZEsnCQP1IoWsQbTgMP0Bht19kx9o7qxtcE
         /jfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iBw1yCNAA4AvNhG6fsCpNeC6xd4fv5a0QO7+TeMW5tA=;
        b=HJRbMqXhHkFQIhAiHOuSGcJaouW6mHgyzBlf7V3ClxMEUAYGYwE0yVh1ettLVy9qXN
         eY7Ke80Q1+fvpJT83g0Qta0vzR+sF5156yoffFE+KIb63TR/I1hzZG8ofnHFk5RDOVP9
         cbKS7hVrhtEjft4Q50WKyH9V4WALlxEJ50AA1zxAwDvVhhrdLoye8+CQyCOQv92mxz0H
         dXcCJRbKSokhJLBMD7abzn6uGrqvctWWbOTMPJZJd9AftPXQHBE6kobGCZUN8JqRJn0N
         O28IkyLi7VtXfsQZNaUQd6BHiKuzNhn5oxl7ujtdCFgbrWAo7jl8iADsCrz23ajKMn5P
         uzug==
X-Gm-Message-State: AOAM5330rkugB+koiXMDjDutjX9sH15cylPpImoK8Ku/eiDykrjYVvf6
        Cozp1N/FSUHTUyD8NfVqAzr9UCP9rz4/fuf5d2o=
X-Google-Smtp-Source: ABdhPJymNaCzymWXJ7HPOMdKPi+w3XAJ/Jbn3I1ltpX9fSk5Hp/PjzgUNq7MBbIr63pBoadGGQ1dyVlQOddMi+IlfKQ=
X-Received: by 2002:a17:907:75f0:: with SMTP id jz16mr4601572ejc.77.1635945586742;
 Wed, 03 Nov 2021 06:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211103124329.171124-1-tomm.merciai@gmail.com>
In-Reply-To: <20211103124329.171124-1-tomm.merciai@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 3 Nov 2021 08:19:34 -0500
Message-ID: <CAHCN7x+MbLJ=JLLJBK1_XpW7CtP5NUqZixB0AHnDg=r83uC2Bw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mm: Add NOC node
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 7:43 AM Tommaso Merciai <tomm.merciai@gmail.com> wrote:
>
> Add support for dynamic frequency scaling of the main NOC configuration
> on imx8mm.
>
> References:
>  - i.MX 8M Mini Applications Processor RM, Rev. 3, 11/2020
>  - f18e6d573b80 arm64: dts: imx8mq: Add NOC node
>  - 912b9dacf3f0 arm64: dts: imx8mq: increase NOC clock to 800 MHz
> ---

+ Abel

>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 25 +++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index c2f3f118f82e..c5f64abcecff 100644
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
> +                               opp-133M {
> +                                       opp-hz = /bits/ 64 <133333333>;
> +                               };
> +
> +                               opp-400M {
> +                                       opp-hz = /bits/ 64 <400000000>;
> +                               };
> +
> +                               opp-800M {
> +                                       opp-hz = /bits/ 64 <800000000>;
> +                               };

When I look at the opp table from the NXP's custom kernel [1] , they
have a different opp table with a max frequency of 750MHz instead of
800MHz.  The i.MX8MM Ref manual shows there is something at 3270_0000,
but it doesn't go into details of the registers there. However the max
speed of the NOC clock does appear to be 800MHz and not the 750 MHz
listed in the NXP kernel.

However, In the clk node of imx8mm.dtsi file, the IMX8MM_CLK_NOC
parent is set to IMX8MM_SYS_PLL3_OUT and IMX8MM_SYS_PLL3_OUT is set to
750MHz, so I think setting the IMX8MM_CLK_NOC to 800MHz is likely not
what we want if we're setting this clock parent and clock rate to
750MHz.  However if the NOC operates correctly at 800MHz when the
parent is set to IMX8MM_SYS_PLL1_800M, it might make sense.  Looking
at the imx8mq.dtsi file, it appears that the NOC node is referencing
the ddrc node, and the imx8mq is able to operate the ddrc at 800MHz,
while I beleive the 8MM is capped at 750M.

Since I do not know if the NOC is tied to the processor speed, the
DRAM speed, or it runs independently, I can't say with any confidence
what it should be and/or how to test it, but I would assume that with
the ddrc node capped at 750MHz, the opp table in the NXP kernel is
probably the correct one.

[1] - https://source.codeaurora.org/external/imx/linux-imx/tree/arch/arm64/boot/dts/freescale/imx8mm.dtsi?h=lf-5.10.y

adam

> +                       };
> +               };
> +
>                 aips2: bus@30400000 {
>                         compatible = "fsl,aips-bus", "simple-bus";
>                         reg = <0x30400000 0x400000>;
> --
> 2.25.1
>

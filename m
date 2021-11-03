Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E674443DD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 15:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhKCOwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 10:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhKCOwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 10:52:44 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C961DC061714;
        Wed,  3 Nov 2021 07:50:07 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id f8so10315628edy.4;
        Wed, 03 Nov 2021 07:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z6Ffr3auqY5aQvzV5hOlatJdK1wDtUKhp272cbbCL0s=;
        b=lhSUM+kKjh5byxhg6ghIYZIUwkxQ+7/6dumA5dTZCqdf/9fRdz8Yn8RXsXPKFxwMj8
         4H0QJq4Y33O5yGFDw6iu+vgPQkGQlrqiSm206XrsvIV4HQTyFYxcaO/WNlI9xOA3GibA
         GbgNLjvuCawDk6K2gAnF/BxUt2j3F7Fbc09Q96JAVixFX1Zr0C4sCrG3nIdI/aMbr3yS
         xA252AcKguMDyjTZJDUmMGd95x2J4PmA6n3ihr/fkhb5F9OeHg0l7MxIov9A92PtTS70
         NZrTH7+TQLMt3qyxVpOVQ6UP20ZOoJETrKTgMf1/vrnVi2DRxHoPyUKcbBNCL2p8jWsf
         BGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z6Ffr3auqY5aQvzV5hOlatJdK1wDtUKhp272cbbCL0s=;
        b=zPn8YO60TBf1X2nzQCQFWEf2/nE/Idb97HrgKIRkoirZHdqE4ACjJV4yzh1D3Agw59
         f1jnPqQD7lOOVK76oUQjjY8S8YTNzHSoH6MB+CltDOOxX98KsAv+lIwTVcyn0sDAsSCP
         /bdsrDivnc15dEeveOdCVsoEo26HkBvPrAw7/IS85qqdcqRtVDA4FH68kxrtnOWo+o1w
         3fH5j+uRVdYHQpYyAHIL21c1ZA7qgL3qmg9s6gZoT7yz9gXEon4uKQnt4/kgeLQxJ2t5
         g8t+saXja1QTepxdsXQzwG1tYn75ix74thf0uWK/eXtcKygDs8aG5GV0QH9Bfq1/s1RS
         DADA==
X-Gm-Message-State: AOAM532+q56hMf1KDCi6do2un6uquSijVifQe74C1+QQv0pSdG9jvxpW
        buQJ29cUELvtXlGwu7Assno=
X-Google-Smtp-Source: ABdhPJzFfm3p+KwmX8t+yzKQvlYXrlx7PQjbJMi3mCIEHpD6IzWZqzkOnlHWTb9vAtAB0+UQCOfDjg==
X-Received: by 2002:a05:6402:3552:: with SMTP id f18mr15452251edd.129.1635951006129;
        Wed, 03 Nov 2021 07:50:06 -0700 (PDT)
Received: from tom-desktop (net-188-153-110-208.cust.vodafonedsl.it. [188.153.110.208])
        by smtp.gmail.com with ESMTPSA id i8sm1441241edq.80.2021.11.03.07.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 07:50:05 -0700 (PDT)
Date:   Wed, 3 Nov 2021 15:50:02 +0100
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Adam Ford <aford173@gmail.com>
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
Subject: Re: [PATCH] arm64: dts: imx8mm: Add NOC node
Message-ID: <20211103145002.GA224875@tom-desktop>
References: <20211103124329.171124-1-tomm.merciai@gmail.com>
 <CAHCN7x+MbLJ=JLLJBK1_XpW7CtP5NUqZixB0AHnDg=r83uC2Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7x+MbLJ=JLLJBK1_XpW7CtP5NUqZixB0AHnDg=r83uC2Bw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 08:19:34AM -0500, Adam Ford wrote:
> On Wed, Nov 3, 2021 at 7:43 AM Tommaso Merciai <tomm.merciai@gmail.com> wrote:
> >
> > Add support for dynamic frequency scaling of the main NOC configuration
> > on imx8mm.
> >
> > References:
> >  - i.MX 8M Mini Applications Processor RM, Rev. 3, 11/2020
> >  - f18e6d573b80 arm64: dts: imx8mq: Add NOC node
> >  - 912b9dacf3f0 arm64: dts: imx8mq: increase NOC clock to 800 MHz
> > ---
> 
> + Abel
> 
> >  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 25 +++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > index c2f3f118f82e..c5f64abcecff 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > @@ -719,6 +719,31 @@ pgc_mipi: power-domain@11 {
> >                         };
> >                 };
> >
> > +               noc: interconnect@32700000 {
> > +                       compatible = "fsl,imx8mm-noc", "fsl,imx8m-noc";
> > +                       reg = <0x32700000 0x100000>;
> > +                       clocks = <&clk IMX8MM_CLK_NOC>;
> > +                       fsl,ddrc = <&ddrc>;
> > +                       #interconnect-cells = <1>;
> > +                       operating-points-v2 = <&noc_opp_table>;
> > +
> > +                       noc_opp_table: opp-table {
> > +                               compatible = "operating-points-v2";
> > +
> > +                               opp-133M {
> > +                                       opp-hz = /bits/ 64 <133333333>;
> > +                               };
> > +
> > +                               opp-400M {
> > +                                       opp-hz = /bits/ 64 <400000000>;
> > +                               };
> > +
> > +                               opp-800M {
> > +                                       opp-hz = /bits/ 64 <800000000>;
> > +                               };
> 
> When I look at the opp table from the NXP's custom kernel [1] , they
> have a different opp table with a max frequency of 750MHz instead of
> 800MHz.  The i.MX8MM Ref manual shows there is something at 3270_0000,
> but it doesn't go into details of the registers there. However the max
> speed of the NOC clock does appear to be 800MHz and not the 750 MHz
> listed in the NXP kernel.
> 
> However, In the clk node of imx8mm.dtsi file, the IMX8MM_CLK_NOC
> parent is set to IMX8MM_SYS_PLL3_OUT and IMX8MM_SYS_PLL3_OUT is set to
> 750MHz, so I think setting the IMX8MM_CLK_NOC to 800MHz is likely not
> what we want if we're setting this clock parent and clock rate to
> 750MHz.  However if the NOC operates correctly at 800MHz when the
> parent is set to IMX8MM_SYS_PLL1_800M, it might make sense.  Looking
> at the imx8mq.dtsi file, it appears that the NOC node is referencing
> the ddrc node, and the imx8mq is able to operate the ddrc at 800MHz,
> while I beleive the 8MM is capped at 750M.
> 
> Since I do not know if the NOC is tied to the processor speed, the
> DRAM speed, or it runs independently, I can't say with any confidence
> what it should be and/or how to test it, but I would assume that with
> the ddrc node capped at 750MHz, the opp table in the NXP kernel is
> probably the correct one.
> 
> [1] - https://source.codeaurora.org/external/imx/linux-imx/tree/arch/arm64/boot/dts/freescale/imx8mm.dtsi?h=lf-5.10.y
> 
> adam
  
  Hi Adam,
  Thanks for your review.

  Tommaso

> 
> > +                       };
> > +               };
> > +
> >                 aips2: bus@30400000 {
> >                         compatible = "fsl,aips-bus", "simple-bus";
> >                         reg = <0x30400000 0x400000>;
> > --
> > 2.25.1
> >

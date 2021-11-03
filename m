Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27876444B44
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 00:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhKCXKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 19:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhKCXKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 19:10:48 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3437AC061714;
        Wed,  3 Nov 2021 16:08:11 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r12so14865091edt.6;
        Wed, 03 Nov 2021 16:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xl5cn8E/wPJYRVhpWssNntfrU+1/sEUN2K7n++mZ4J4=;
        b=WDrHgOvWhMNrWgszsPpiWr+ph7MSuDPem95jpJ+diyhxfKzTnsBQRHan5txP5X/KoN
         qoaTVQOQ9GiZbn25KWxk32jdMTXz5DfYvs5KjP88+o5g5sulbSn7511W1MEK44/pAlg1
         5UDi7R0Id4YEFzS+zsb+P5hbxua1a5cYFelKeeYe4+5YupUTwqCjxT0cIsCvAhDNCsJt
         0sK4g1WyeYn6mmD18vPUYY1ADDPMKoaExQKiyAlPMsFpwxfS/4w5lOauNnQ6aVPV8NXM
         gfGz2NdlQML9iuickwkYbFb6DL2kO9MqWqOtspVC3nG/2BD6RNBWV+Ff/v6XhwASJYEL
         EUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xl5cn8E/wPJYRVhpWssNntfrU+1/sEUN2K7n++mZ4J4=;
        b=hU9javh0hzwD4KOxfCrZsfIeNwnv4jXNtYZPSpMrq0Xp54RUAx9oGmNdZZO4C9yLur
         MS0Iag9wJvXsJfFuB9dfdVFw1uTr3r7hCmaHV8Q6HDzn6Ck+uYnep23//9IAwp2f+9oN
         /lV6L6rddhUB4lK6G1TZVVN530RZRSbh6+lvLR3HmYoKUn0oi5lSzpdUnYh+7L5D1ZEc
         SRz6+RfOg6ia5IWHglmNKkPIJ1UdEkeXh9GemGPa8nEUEksNGB3wT6lufypuYBUKcqdu
         4khw0aYbYAePcTP9m/+3FmPOHcnt2Xe9WpKOZrodP+70E3O/RTtcTTgtimnSBzlvpTSq
         Issg==
X-Gm-Message-State: AOAM532fzNBp0ib3IX5q302cP6ZxOO73Jb9j5M/Ov6CVsAFvVMMK8SKu
        KH5GDuslsPDchCiEKupZjKE=
X-Google-Smtp-Source: ABdhPJzFu0pkSpoC3yzqFdLMNsVH1Mz6KMjDY0SNWN5bpf5e7mVjzn7U0jlr7o6M+tpb/mRaitHrkA==
X-Received: by 2002:a17:906:478e:: with SMTP id cw14mr41850973ejc.46.1635980889808;
        Wed, 03 Nov 2021 16:08:09 -0700 (PDT)
Received: from tom-ThinkPad-T470p (net-188-153-110-208.cust.vodafonedsl.it. [188.153.110.208])
        by smtp.gmail.com with ESMTPSA id h20sm1952066eds.88.2021.11.03.16.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 16:08:09 -0700 (PDT)
Date:   Thu, 4 Nov 2021 00:08:06 +0100
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Adam Ford <aford173@gmail.com>
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
Subject: Re: [PATCH v2] arm64: dts: imx8mm: Add NOC node
Message-ID: <20211103230806.GB34552@tom-ThinkPad-T470p>
References: <20211103135313.6428-1-tomm.merciai@gmail.com>
 <CAHCN7xLOkvahKSzuUAe5d4sBMoMs51PHDt3G5PB+jEtDkRf30Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7xLOkvahKSzuUAe5d4sBMoMs51PHDt3G5PB+jEtDkRf30Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 01:55:54PM -0500, Adam Ford wrote:
> On Wed, Nov 3, 2021 at 8:53 AM Tommaso Merciai <tomm.merciai@gmail.com> wrote:
> >
> > Add support for dynamic frequency scaling of the main NOC configuration
> > on imx8mm.
> >
> > References:
> >  - i.MX 8M Mini Applications Processor RM, Rev. 3, 11/2020
> >  - f18e6d573b80 arm64: dts: imx8mq: Add NOC node
> >  - 912b9dacf3f0 arm64: dts: imx8mq: increase NOC clock to 800 MHz
> >  - https://source.codeaurora.org/external/imx/linux-imx/tree/arch/ \
> >    arm64/boot/dts/freescale/imx8mm.dtsi?h=lf-5.10.y
> >
> 
> You're missing the signed-off-by tag.
  
  Yes, sorry.
> 
> From what I can tell, the default NOC clock is 750MHz.  With this
> patch enabled, i can manually change the NOC clock to 150, 375 or 750,
> but it's not clear to me what this impacts.  In the 8MQ, there are a
> couple peripherals that are linked to the NOC, but we don't have those
> same peripherals enabled in the 8mm.  The
> dt-bindings/interconnect/imx8mq.h list more NOC references than are
> used in the device tree, so it's unclear to me if and what we need to
> reference anything in the 8MM based on
> dt-bindings/interconnect/imx8mm.h
> 
> adam

 Hi Adam,
 Yes you are right, you mean that NOC is using default frequencies than
 this this node at the moment is only a duplicate. But on the other
 side, maybe in the future someone will need to modify default table and
 use it. What do you think about? Let me know.

 Thanks,
 Tommaso
> 
> > ---
> > Changes since v1:
> >  - Fix noc_opp_table frequencies taking NXP bsp as reference
> >  - Add reference link to nxp imx8mm dtsi on commit body
> >
> >  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 25 +++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > index c2f3f118f82e..1bcc5e361ca3 100644
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
> > +                               opp-150M {
> > +                                       opp-hz = /bits/ 64 <150000000>;
> > +                               };
> > +
> > +                               opp-375M {
> > +                                       opp-hz = /bits/ 64 <375000000>;
> > +                               };
> > +
> > +                               opp-750M {
> > +                                       opp-hz = /bits/ 64 <750000000>;
> > +                               };
> > +                       };
> > +               };
> > +
> >                 aips2: bus@30400000 {
> >                         compatible = "fsl,aips-bus", "simple-bus";
> >                         reg = <0x30400000 0x400000>;
> > --
> > 2.25.1
> >

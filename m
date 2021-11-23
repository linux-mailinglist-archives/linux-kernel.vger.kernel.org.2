Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED24B459F14
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 10:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbhKWJTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 04:19:10 -0500
Received: from mout02.posteo.de ([185.67.36.66]:42477 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234666AbhKWJTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 04:19:09 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 8D235240105
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 10:15:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1637658959; bh=Yr9tkx7XywJ1L3ABv15FR7x3R0tOikYobRlp42uOJ3w=;
        h=Subject:From:To:Cc:Date:From;
        b=NWgoedMNKEvHNCxMGG2P0kejK9kSsEaJHo8AO5YtF9i1Hsw9qsq1i8HAhgGSoL6dA
         QTzSLOa9ovnHWDMicnCqdRD1IErku/Otx1hL1InIAbDP68RaUX+gDJDs892iUBQafH
         b39N8b1WadsnqD135p3ZQRQS7jGZqSisT76orWSOHf8i52JJITYkgTr/s5MtIcxPMZ
         RYv+O51VME0SFy0199EsmBJvgUHt2RAj4eJ0KE0IhC1Lcq3umj6zzJX+WutASOrivn
         piLs4Qbg4Q+f+Lhe5/aTdhKYox/mKiDGTWeGnazKz+8pbxbop5Yn0ntI5wg7XtKhyw
         PrL/DVGsytTEQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Hyz5T4g0Qz9rxF;
        Tue, 23 Nov 2021 10:15:57 +0100 (CET)
Message-ID: <9b9fe3a5b04179870d6ca0ece754fee9abb306b4.camel@posteo.de>
Subject: Re: [PATCH] arm64: dts: freescale: imx8mq: Disable noc dts node
From:   Martin Kepplinger <martink@posteo.de>
To:     Shawn Guo <shawnguo@kernel.org>, Abel Vesa <abel.vesa@nxp.com>
Cc:     Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Date:   Tue, 23 Nov 2021 09:15:57 +0000
In-Reply-To: <20211123085841.GX31998@dragon>
References: <1636629369-23988-1-git-send-email-abel.vesa@nxp.com>
         <20211123085841.GX31998@dragon>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, dem 23.11.2021 um 16:58 +0800 schrieb Shawn Guo:
> On Thu, Nov 11, 2021 at 01:16:09PM +0200, Abel Vesa wrote:
> > Adding interconnect properties to the consumer nodes creates
> > a dependency on noc device. The imx-bus devfreq driver is not
> > usable
> > without the full interconnect support. The interconnect is not yet
> > working on i.MX platforms. The devlink created on device_add makes
> > the lcdif and other nodes that have the interconnect properties
> > wait for the noc (imx-bus driver) to probe first.
> > 
> > To make sure the interconnect consumers (nodes that have
> > interconnect
> > properties already added) will still probe, lets disable the noc
> > node
> > for now. Once the interconnect on i.MX platforms is fully
> > functional,
> > the status of the noc node can be changed.
> > 
> > Fixes: ad1abc8a03fdbc05b ("arm64: dts: imx8mq: Add interconnect for
> > lcdif")
> 
> Martin,
> 
> Do you have any comment?  So your commit added something untested?
> 
> Shawn

hi Shawn,

well, for imx8mq the only missing piece is the mxsfb icc bandwidth
request. I posted a first version a year ago but that didn't make it
in:
https://lore.kernel.org/linux-arm-kernel/20201201103757.32165-1-martin.kepplinger@puri.sm/

So this should create a working state until the real fix in mxsfb is
there (although I'd revert commit ad1abc8a03fd ("arm64: dts: imx8mq:
Add interconnect for lcdif") instead). I am indeed to blame for this
and I'm sorry I haven't yet taken the time to work on mxsfb again.

I can say I plan to do so soon, but without promise that I quickly find
a solution that'll be merged...

If you merge this (or revert ad1abc8a03fd), I'll remember to revert
with said update.

thanks,
                        martin

> 
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > index 972766b67a15..f3182878f596 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > @@ -1305,6 +1305,7 @@ noc: interconnect@32700000 {
> >                         fsl,ddrc = <&ddrc>;
> >                         #interconnect-cells = <1>;
> >                         operating-points-v2 = <&noc_opp_table>;
> > +                       status = "disabled";
> >  
> >                         noc_opp_table: opp-table {
> >                                 compatible = "operating-points-v2";
> > -- 
> > 2.31.1
> > 



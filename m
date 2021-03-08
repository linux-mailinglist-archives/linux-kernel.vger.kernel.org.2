Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3099330921
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 09:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhCHIEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 03:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhCHIER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 03:04:17 -0500
Received: from metis.ext.pengutronix.de (unknown [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40221C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 00:04:16 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1lJArq-0006II-Us; Mon, 08 Mar 2021 09:03:54 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1lJArq-0004Vk-9L; Mon, 08 Mar 2021 09:03:54 +0100
Date:   Mon, 8 Mar 2021 09:03:54 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Teresa Remmet <T.Remmet@phytec.de>
Cc:     "hs@denx.de" <hs@denx.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: Re: [PATCH 2/2] arm64: imx8mp: imx8mp-phycore-som enable spi nor
Message-ID: <20210308080354.lp2ogzxkhwi5jprp@pengutronix.de>
References: <20210308064046.1576267-1-hs@denx.de>
 <20210308064046.1576267-3-hs@denx.de>
 <9f77093260dbf37ffff3e1dd167162a8a2b75c73.camel@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f77093260dbf37ffff3e1dd167162a8a2b75c73.camel@phytec.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:00:28 up 95 days, 22:06, 39 users,  load average: 0.15, 0.08,
 0.10
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Teresa, Heiko,

On 21-03-08 07:46, Teresa Remmet wrote:
> Hello Heiko,
> 
> first thanks for the patch :).
> 
> Am Montag, den 08.03.2021, 07:40 +0100 schrieb Heiko Schocher:
> > enable the mt25qu256aba spi nor on the imx8mp-phycore-som.
> > 
> > Signed-off-by: Heiko Schocher <hs@denx.de>
> > ---
> > 
> >  .../dts/freescale/imx8mp-phycore-som.dtsi     | 27
> > +++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
> > index 44a8c2337cee4..0284e7a5c6bba 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
> > @@ -65,6 +65,22 @@ ethphy1: ethernet-phy@0 {
> >  	};
> >  };
> >  
> > +&flexspi {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_flexspi0>;
> > +	status = "okay";
> > +
> > +	flash0: mt25qu256aba@0 {
> 
> you can remove the label. As it is not used here right now.

I would keep the label since most the time the bootloaders will fixup
the device tree because they adding a of-partition to it. It's mostly
just a matter of time.

> Also rename the node name to device type like "flash" maybe.

+1

I would name it 'som_flash: flash@0 { }'

Regards,
  Marco

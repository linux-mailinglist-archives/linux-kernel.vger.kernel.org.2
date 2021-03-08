Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE288330A4B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 10:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhCHJ3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 04:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhCHJ23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 04:28:29 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FFFC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 01:28:28 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1lJCBc-0007iB-Qq; Mon, 08 Mar 2021 10:28:24 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1lJCBc-0008VO-0m; Mon, 08 Mar 2021 10:28:24 +0100
Date:   Mon, 8 Mar 2021 10:28:23 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Teresa Remmet <T.Remmet@phytec.de>
Cc:     "hs@denx.de" <hs@denx.de>, "krzk@kernel.org" <krzk@kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 2/2] arm64: imx8mp: imx8mp-phycore-som enable spi nor
Message-ID: <20210308092823.a3ffj4auysnoti6o@pengutronix.de>
References: <20210308064046.1576267-1-hs@denx.de>
 <20210308064046.1576267-3-hs@denx.de>
 <20210308084047.numy4o2jvsiz5d3v@pengutronix.de>
 <196131b90400b434931992ba5a9078828d1eaf2a.camel@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <196131b90400b434931992ba5a9078828d1eaf2a.camel@phytec.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:25:47 up 95 days, 23:32, 42 users,  load average: 0.23, 0.24,
 0.15
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-08 08:52, Teresa Remmet wrote:
> Hello Marco,
> 
> Am Montag, den 08.03.2021, 09:40 +0100 schrieb Marco Felsch:
> > On 21-03-08 07:40, Heiko Schocher wrote:
> > > enable the mt25qu256aba spi nor on the imx8mp-phycore-som.
> > > 
> > > Signed-off-by: Heiko Schocher <hs@denx.de>
> > > ---
> > > 
> > >  .../dts/freescale/imx8mp-phycore-som.dtsi     | 27
> > > +++++++++++++++++++
> > >  1 file changed, 27 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
> > > b/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
> > > index 44a8c2337cee4..0284e7a5c6bba 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi
> > > @@ -65,6 +65,22 @@ ethphy1: ethernet-phy@0 {
> > >  	};
> > >  };
> > >  
> > > +&flexspi {
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&pinctrl_flexspi0>;
> > > +	status = "okay";
> > > +
> > > +	flash0: mt25qu256aba@0 {
> > > +		reg = <0>;
> > > +		#address-cells = <1>;
> > > +		#size-cells = <1>;
> > > +		compatible = "jedec,spi-nor";
> > 
> > Please make the compatible the first property followed by the reg
> > property. Also you don't need to add the #size-cells and #address-
> > cells
> > now since you don't add a child node.
> 
> but is this not similar to the label here? If you add partitions in the
> bootloader you need the cells properties?

If the bootloader will add partitions the bootloader can add the
size/address-cells too using the phandle. But this is more a nit.

Regards,
  Marco

> Teresa
> 
> > 
> > Regards,
> >   Marco
> > 
> > > +		spi-max-frequency = <80000000>;
> > > +		spi-tx-bus-width = <4>;
> > > +		spi-rx-bus-width = <4>;
> > > +	};
> > > +};
> > > +
> > >  &i2c1 {
> > >  	clock-frequency = <400000>;
> > >  	pinctrl-names = "default";
> > > @@ -217,6 +233,17 @@ MX8MP_IOMUXC_GPIO1_IO15__GPIO1_IO15		
> > > 0x11
> > >  		>;
> > >  	};
> > >  
> > > +	pinctrl_flexspi0: flexspi0grp {
> > > +		fsl,pins = <
> > > +			MX8MP_IOMUXC_NAND_ALE__FLEXSPI_A_SCLK		
> > > 0x1c2
> > > +			MX8MP_IOMUXC_NAND_CE0_B__FLEXSPI_A_SS0_B	0x8
> > > 2
> > > +			MX8MP_IOMUXC_NAND_DATA00__FLEXSPI_A_DATA00	0x8
> > > 2
> > > +			MX8MP_IOMUXC_NAND_DATA01__FLEXSPI_A_DATA01	0x8
> > > 2
> > > +			MX8MP_IOMUXC_NAND_DATA02__FLEXSPI_A_DATA02	0x8
> > > 2
> > > +			MX8MP_IOMUXC_NAND_DATA03__FLEXSPI_A_DATA03	0x8
> > > 2
> > > +		>;
> > > +	};
> > > +
> > >  	pinctrl_i2c1: i2c1grp {
> > >  		fsl,pins = <
> > >  			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL		0x4
> > > 00001c3
> > > -- 
> > > 2.29.2
> > > 
> > > 
> > > 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

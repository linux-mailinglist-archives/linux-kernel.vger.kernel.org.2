Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05F1422633
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 14:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbhJEMTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 08:19:55 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:38296 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233784AbhJEMTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 08:19:54 -0400
X-Greylist: delayed 336 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Oct 2021 08:19:53 EDT
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id DC7CEFB03;
        Tue,  5 Oct 2021 14:12:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9MfrIIi09mzw; Tue,  5 Oct 2021 14:12:23 +0200 (CEST)
Date:   Tue, 5 Oct 2021 14:12:22 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <guido.gunther@puri.sm>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Martin Kepplinger <martin.kepplinger@puri.sm>, robh@kernel.org,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        kernel@puri.sm
Subject: Re: [PATCH v1 3/6] arm64: dts: imx8mq-librem5: wire up the wifi
 regulator
Message-ID: <YVxBJoWTDgznfsJN@qwark.sigxcpu.org>
References: <20210913135706.309685-1-martin.kepplinger@puri.sm>
 <20210913135706.309685-4-martin.kepplinger@puri.sm>
 <20211004120054.GG15650@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211004120054.GG15650@dragon>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,
On Mon, Oct 04, 2021 at 08:00:57PM +0800, Shawn Guo wrote:
> On Mon, Sep 13, 2021 at 03:57:03PM +0200, Martin Kepplinger wrote:
> > From: Guido Günther <agx@sigxcpu.org>
> > 
> > Connect the wifi power regulator to the corresponding GPIO.
> > 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> > index ba26c6ee98a0..b5562c8f9a3c 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> > @@ -138,9 +138,15 @@ reg_vsys_3v4: regulator-vsys-3v4 {
> >  
> >  	reg_wifi_3v3: regulator-wifi-3v3 {
> >  		compatible = "regulator-fixed";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_wifi_pwr>;
> >  		regulator-name = "3V3_WIFI";
> >  		regulator-min-microvolt = <3300000>;
> >  		regulator-max-microvolt = <3300000>;
> > +		gpio = <&gpio3 10 GPIO_ACTIVE_HIGH>;
> > +		enable-active-high;
> > +		vin-supply = <&reg_vdd_3v3>;
> > +		regulator-always-on;
> 
> Any reason you need to have this always-on?

I think we can drop the `regulator-always-on` nowadays - it's wired up
correctly as `vmmc-supply` so turned on accordingly. Will drop for
the next revision.
Cheers,
 -- Guido

> 
> Shawn
> 
> >  	};
> >  
> >  	sound {
> > @@ -638,6 +644,13 @@ MX8MQ_IOMUXC_SD2_RESET_B_USDHC2_RESET_B 0xc1
> >  		>;
> >  	};
> >  
> > +	pinctrl_wifi_pwr: wifipwrgrp {
> > +		fsl,pins = <
> > +			/* WIFI3V3_EN */
> > +			MX8MQ_IOMUXC_NAND_DATA04_GPIO3_IO10	0x83
> > +		>;
> > +	};
> > +
> >  	pinctrl_wdog: wdoggrp {
> >  		fsl,pins = <
> >  			/* nWDOG */
> > -- 
> > 2.30.2
> > 
> 

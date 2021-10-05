Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42510421F11
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 08:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbhJEGvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 02:51:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230526AbhJEGvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 02:51:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1683A6137F;
        Tue,  5 Oct 2021 06:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633416581;
        bh=am9djVxIkg8W2+HaNT26dMc7/VJKG3pWaAhj9MsVOpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AIxfWutvh/k+OJhI4qaIiphhYrti7ug+t70bHe+cjhOQc+VsrOwXRrXEmmTu5vbXo
         zS1vDvR31vtFkkCzoiqHljJ4q75CaSFMWg/gTOuCsWiWGMUdxgonnMoTGRxjsxHLOP
         4u3WlT9U0saEapGe8VW76AtagEi6ZlO1Nv1I5yVerEPFoyOboXoV9hdRIJ59aKLuY0
         Za8gF2OL3A0unIbGK7gGUwx7ywf0VUxrBlLPdBqtPHbwGG/ttWbWcTKutPKX8zgj++
         ARWFf+9TUT5/uyOE8eJ0lYEwDd5HZqmk7gWHoAQQcHTLGA+/YbpbqQ+20OVsm/UEHW
         1yDnZWF7TouTQ==
Date:   Tue, 5 Oct 2021 14:49:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     Frieder Schrempf <frieder@fris.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 2/8] arm64: dts: imx8mm-kontron: Make sure SOC and DRAM
 supply voltages are correct
Message-ID: <20211005064934.GY20743@dragon>
References: <20210930155633.2745201-1-frieder@fris.de>
 <20210930155633.2745201-3-frieder@fris.de>
 <bf6ab1b2-664c-1d1d-18b9-71ced9fbb518@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf6ab1b2-664c-1d1d-18b9-71ced9fbb518@kontron.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 06:02:01PM +0200, Frieder Schrempf wrote:
> On 30.09.21 17:56, Frieder Schrempf wrote:
> > From: Frieder Schrempf <frieder.schrempf@kontron.de>
> > 
> > VDD_SOC should be 800 mV in suspend and 850 mV in run mode. VDD_DRAM
> > should be 950 mV for DDR clock frequencies of 1.5 GHz.
> > 
> > This information is taken from the datasheet and the uboot-imx code.
> > 
> > Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> This should also have:
> 
> Fixes: 21c4f45b335f ("arm64: dts: Add the Kontron i.MX8M Mini SoMs and
> baseboards")

$ git log 21c4f45b335f
fatal: ambiguous argument '21c4f45b335f': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'

Shawn

> Cc: stable@vger.kernel.org
> 
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
> > index 03b3516abd64..b12fb7ce6686 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
> > @@ -92,10 +92,12 @@ regulators {
> >  			reg_vdd_soc: BUCK1 {
> >  				regulator-name = "buck1";
> >  				regulator-min-microvolt = <800000>;
> > -				regulator-max-microvolt = <900000>;
> > +				regulator-max-microvolt = <850000>;
> >  				regulator-boot-on;
> >  				regulator-always-on;
> >  				regulator-ramp-delay = <3125>;
> > +				nxp,dvs-run-voltage = <850000>;
> > +				nxp,dvs-standby-voltage = <800000>;
> >  			};
> >  
> >  			reg_vdd_arm: BUCK2 {
> > @@ -111,7 +113,7 @@ reg_vdd_arm: BUCK2 {
> >  			reg_vdd_dram: BUCK3 {
> >  				regulator-name = "buck3";
> >  				regulator-min-microvolt = <850000>;
> > -				regulator-max-microvolt = <900000>;
> > +				regulator-max-microvolt = <950000>;
> >  				regulator-boot-on;
> >  				regulator-always-on;
> >  			};
> > 

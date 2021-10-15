Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F2A42E76A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 05:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbhJODxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 23:53:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235225AbhJODxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 23:53:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D71D1611C3;
        Fri, 15 Oct 2021 03:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634269894;
        bh=HRiWV+8zHe2qqxJgo56IMSWbI8+MHo9yh+QgaaZsvtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tDLwis3n2ThfcX1Fy8D9CxQP864NyJ4aDZk4T4GB5OCKNutkll8StU7Jzt/pwzlqT
         NGwEW/sjcxyqYXIUveg8eVYPh1QJ4ZKjt1tRR+0G9yZiG6uY08n+irsmU4mEmQ4JrQ
         mzyqiIg1aJCPfTMs9cWloY0ZuxsbC5lW/8GmlYyNX4MjEQBsypdLqbieDmwFoJSiJB
         UyMfAg5/8NuAVz21mewx7V9Wi00aGVdvkHRQ+s++S+38zVNWUby2Zsz9t1WajvOw5L
         bFKsBlV06WZm850pNoceMCnHFold8eri4UEfo7Pj1qmk60a69TOLdzU8XpJApRWGFU
         U4C1HjyoiTuxg==
Date:   Fri, 15 Oct 2021 11:51:27 +0800
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
Message-ID: <20211015035122.GE22881@dragon>
References: <20210930155633.2745201-1-frieder@fris.de>
 <20210930155633.2745201-3-frieder@fris.de>
 <20211005065358.GZ20743@dragon>
 <cefc9a67-120e-fda6-cb69-af4cabc58a15@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cefc9a67-120e-fda6-cb69-af4cabc58a15@kontron.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 03:10:14PM +0200, Frieder Schrempf wrote:
> On 05.10.21 08:53, Shawn Guo wrote:
> > On Thu, Sep 30, 2021 at 05:56:25PM +0200, Frieder Schrempf wrote:
> >> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> >>
> >> VDD_SOC should be 800 mV in suspend and 850 mV in run mode. VDD_DRAM
> >> should be 950 mV for DDR clock frequencies of 1.5 GHz.
> >>
> >> This information is taken from the datasheet and the uboot-imx code.
> > 
> > I'm wondering where the existing settings were coming from?
> 
> Good question, but I can't really retrace now how I actually determined
> the values back then. Seems like I had failed to validate them properly.

Please update commit log with these background info.

Shawn

> 
> > 
> >>
> >> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> >> ---
> >>  arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi | 6 ++++--
> >>  1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
> >> index 03b3516abd64..b12fb7ce6686 100644
> >> --- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
> >> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
> >> @@ -92,10 +92,12 @@ regulators {
> >>  			reg_vdd_soc: BUCK1 {
> >>  				regulator-name = "buck1";
> >>  				regulator-min-microvolt = <800000>;
> >> -				regulator-max-microvolt = <900000>;
> >> +				regulator-max-microvolt = <850000>;
> >>  				regulator-boot-on;
> >>  				regulator-always-on;
> >>  				regulator-ramp-delay = <3125>;
> >> +				nxp,dvs-run-voltage = <850000>;
> >> +				nxp,dvs-standby-voltage = <800000>;
> >>  			};
> >>  
> >>  			reg_vdd_arm: BUCK2 {
> >> @@ -111,7 +113,7 @@ reg_vdd_arm: BUCK2 {
> >>  			reg_vdd_dram: BUCK3 {
> >>  				regulator-name = "buck3";
> >>  				regulator-min-microvolt = <850000>;
> >> -				regulator-max-microvolt = <900000>;
> >> +				regulator-max-microvolt = <950000>;
> >>  				regulator-boot-on;
> >>  				regulator-always-on;
> >>  			};
> >> -- 
> >> 2.33.0
> >>

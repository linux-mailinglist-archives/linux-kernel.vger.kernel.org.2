Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CEA421F23
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 08:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbhJEGz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 02:55:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230526AbhJEGzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 02:55:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3180E6138F;
        Tue,  5 Oct 2021 06:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633416845;
        bh=b7QzjFO7hZD8ywQA6H3ZkbswlXTN6z1Bpr2GKwUdVzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j23HgdkHVmGIY0nYmkth4nMgVrSa3DVFN2Dv/+lXDkBtmVhrcDVWO9UlGh9lkAjx2
         AvP1BzSAS6zxqU5BnGSlSPJiXf/hrtoYwj5yfvIZ6N5R2QmL1jfzvLEpshoXm9Z+DH
         Tz5OhuCkE8QhreB3rdKAgNMVJhs8x8NO+tCdfAyQLcjQFFVeP+aMYEXHD1Ix5SQBh8
         JdWbJ6C40ejjsii+HPs6JRXVv7KDzuHDH9ztFE7wnwycq0PsRCbX2Wu/yaq5XEBWbW
         388Wxw3PBJFU0oG67yVygy39pZDiWn/QU5AKsxRJbKotvTAFG2RvH3zzPlPn9YTYj/
         MvdEL9jmK2z4Q==
Date:   Tue, 5 Oct 2021 14:53:59 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Frieder Schrempf <frieder@fris.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 2/8] arm64: dts: imx8mm-kontron: Make sure SOC and DRAM
 supply voltages are correct
Message-ID: <20211005065358.GZ20743@dragon>
References: <20210930155633.2745201-1-frieder@fris.de>
 <20210930155633.2745201-3-frieder@fris.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930155633.2745201-3-frieder@fris.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 05:56:25PM +0200, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> VDD_SOC should be 800 mV in suspend and 850 mV in run mode. VDD_DRAM
> should be 950 mV for DDR clock frequencies of 1.5 GHz.
> 
> This information is taken from the datasheet and the uboot-imx code.

I'm wondering where the existing settings were coming from?

Shawn

> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
> index 03b3516abd64..b12fb7ce6686 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
> @@ -92,10 +92,12 @@ regulators {
>  			reg_vdd_soc: BUCK1 {
>  				regulator-name = "buck1";
>  				regulator-min-microvolt = <800000>;
> -				regulator-max-microvolt = <900000>;
> +				regulator-max-microvolt = <850000>;
>  				regulator-boot-on;
>  				regulator-always-on;
>  				regulator-ramp-delay = <3125>;
> +				nxp,dvs-run-voltage = <850000>;
> +				nxp,dvs-standby-voltage = <800000>;
>  			};
>  
>  			reg_vdd_arm: BUCK2 {
> @@ -111,7 +113,7 @@ reg_vdd_arm: BUCK2 {
>  			reg_vdd_dram: BUCK3 {
>  				regulator-name = "buck3";
>  				regulator-min-microvolt = <850000>;
> -				regulator-max-microvolt = <900000>;
> +				regulator-max-microvolt = <950000>;
>  				regulator-boot-on;
>  				regulator-always-on;
>  			};
> -- 
> 2.33.0
> 

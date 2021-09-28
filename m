Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9029841B300
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241642AbhI1Pee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:34:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241509AbhI1Ped (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:34:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C760E61213;
        Tue, 28 Sep 2021 15:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632843173;
        bh=F2nQqa4g8ueLOBhXruqyVJfSqOXJZFX2UlZMl2Dc+X8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QrgAWAIcJU8bzBnAV+SY/nSuQvj1cVDSgbKIOk7YTDaVGZ1OW22AHVvfnsO61Q2Lw
         tZvO2XC13OsZ449HSv7CM/3EDSXXLvUC8X6hKKD9GlshEq4rWUY6DW2qBNravZpMOf
         3qHG9Vd2P8PICBxbQ4JZdzeDjC/ckyJ2IHqvOE31MN/h5yjBxD4dtJjPpSPiW4lNad
         USPU8jFQsf+PBhHk30S0oHoZLGgWNw/sDqGReBcv8SrDKhhNdW4PNnC9EKUVCWEOJH
         VQ9lPx74mQQCvXCMRA8VnlyNTVjdSV15NJadQvo67QEjd/7mqLdRh2OvBQh1H0UxWJ
         2a9dQP1tifZ0w==
Received: by pali.im (Postfix)
        id 7D7B57E1; Tue, 28 Sep 2021 17:32:51 +0200 (CEST)
Date:   Tue, 28 Sep 2021 17:32:51 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: marvell: espressobin-ultra: add PHY and
 switch reset pins
Message-ID: <20210928153251.ogmtnpg3slhp4lb7@pali>
References: <20210927154159.2168500-1-robert.marko@sartura.hr>
 <20210927154159.2168500-3-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927154159.2168500-3-robert.marko@sartura.hr>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 September 2021 17:41:58 Robert Marko wrote:
> Both the Topaz switch and 88E1512 PHY have their reset and interrupts
> connected to the SoC.
> 
> So, define the Topaz and 88E1512 reset pins in the DTS.

Are reset pins connected only on ultra variant? Or on all espressobin
variants? Because if they are on all variants then definitions should go
into common dtsi file.

I see that "gpionb 2" is on v7 variant connected to LED2. So I'm not
sure if this one gpio is also shared or not.

> Defining the interrupt pins wont work as both the 88E1512 and the
> Topaz switch uses active LOW IRQ signals but the A37xx GPIO controller
> only supports edge triggers.
> 88E1512 would require special setup anyway as its INT pin is shared with
> the LED2 and you first need to configure it as INT.

Do you plan to finish also this additional setup?

> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> index 8a700afd0570..96855a10b4a0 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> @@ -118,12 +118,16 @@ &usb3 {
>  &mdio {
>  	extphy: ethernet-phy@1 {
>  		reg = <1>;
> +
> +		reset-gpios = <&gpionb 2 GPIO_ACTIVE_LOW>;
>  	};
>  };
>  
>  &switch0 {
>  	reg = <3>;
>  
> +	reset-gpios = <&gpiosb 23 GPIO_ACTIVE_LOW>;
> +
>  	ports {
>  		switch0port1: port@1 {
>  			reg = <1>;
> -- 
> 2.31.1
> 

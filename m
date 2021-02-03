Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFDEC30DCC2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbhBCO3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbhBCO3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:29:04 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC711C0613ED;
        Wed,  3 Feb 2021 06:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1g9mJIH7vHc18Vb4ro8icdyOeiI9Qb2JuSlrPce0kmE=; b=J8ltLmGK6lI9nMKohb/KigrPb
        76mDC3tMaO9tFruHDpZ/84fEQZHWPAlcwW/gTFmpFoi9BFqaTciarL1pvS07AejihqQT1WRbkXUc7
        cgZmKswsNJPzqFOwV76HO17K2RKxyEtxW3z7sLdSdJbil04pjEbEVztX9LU0Vf+c7LbZVjbbZcHML
        /ei2AS2Dm2Suf6bSPAFBR7UKekFOfMeYfT+/2vglrUEcg2Rv7o4LdkvQWZwiQVlu4wTZ9k4zvXVhw
        eo08BBfz3BGyBLmn937P+1MZ3FnOFtg8q6imDsXBLEnJP5Q9feSnWoQpu7qbEMU2EuZrlbcwcjqhe
        nAD031JOA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38690)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1l7J8b-0005jP-PB; Wed, 03 Feb 2021 14:28:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1l7J8Y-0004CC-Tf; Wed, 03 Feb 2021 14:28:06 +0000
Date:   Wed, 3 Feb 2021 14:28:06 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     kostap@marvell.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        andrew@lunn.ch, mw@semihalf.com, jaz@semihalf.com,
        nadavh@marvell.com, stefanc@marvell.com, bpeled@marvell.com
Subject: Re: [PATCH 03/11] dts: mvebu: Add pin control definitions for SDIO
 interafce
Message-ID: <20210203142806.GQ1463@shell.armlinux.org.uk>
References: <20210203133138.10754-1-kostap@marvell.com>
 <20210203133138.10754-4-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203133138.10754-4-kostap@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 03:31:30PM +0200, kostap@marvell.com wrote:
> From: Konstantin Porotchkin <kostap@marvell.com>
> 
> Add SDIO mode pin control configration for CP0 on A8K DB.
> 
> Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-70x0.dtsi | 6 ++++++
>  arch/arm64/boot/dts/marvell/armada-80x0.dtsi | 6 ++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-70x0.dtsi b/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
> index 293403a1a333..179218774ba9 100644
> --- a/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
> @@ -47,6 +47,12 @@
>  	cp0_pinctrl: pinctrl {
>  		compatible = "marvell,armada-7k-pinctrl";
>  
> +		sdhci_pins: sdhi-pins {

sdhi-pins ?

> +			marvell,pins = "mpp56", "mpp57", "mpp58",
> +				       "mpp59", "mpp60", "mpp61", "mpp62";
> +			marvell,function = "sdio";
> +		};
> +
>  		nand_pins: nand-pins {
>  			marvell,pins =
>  			"mpp15", "mpp16", "mpp17", "mpp18",
> diff --git a/arch/arm64/boot/dts/marvell/armada-80x0.dtsi b/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
> index ee67c70bf02e..64100ae204da 100644
> --- a/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-80x0.dtsi
> @@ -70,6 +70,12 @@
>  &cp0_syscon0 {
>  	cp0_pinctrl: pinctrl {
>  		compatible = "marvell,armada-8k-cpm-pinctrl";
> +
> +		sdhci_pins: sdhi-pins {

sdhi-pins ?

> +			marvell,pins = "mpp56", "mpp57", "mpp58",
> +				       "mpp59", "mpp60", "mpp61", "mpp62";
> +			marvell,function = "sdio";
> +		};
>  	};
>  };
>  
> -- 
> 2.17.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

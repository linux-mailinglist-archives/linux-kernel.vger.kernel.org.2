Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7E5318882
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 11:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhBKKqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 05:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbhBKKnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 05:43:13 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5819C0613D6;
        Thu, 11 Feb 2021 02:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=o7ab9JUxixDXYDGljSQP/l2L/YnDFISQ2zB4qQEZTdQ=; b=ykEfrmgkjmaiuzOQprM9Y1oBD
        k9hsfOAWLS41kgMHXWYx8CCkgq3qLq2bbF8JrMosFtESEA7mU6FQSZRUgh/AdIYXj20QNrNZZydE4
        zraGp0eoC3sre/ssAP9k1HLvR11RCwMQ7Ff5XFES8T3pqr9Hbn+EC2w9ueCe532412F2Xr7bzd3qd
        8X7w0FM9yegcjRRQqIAm6Aw6PWCXk+SMajIcvRxRSfznjn7Gwrnr4btvMM918Nxa5GzUwqLq9Ce86
        SQjBAok/K3omRX6oueyaTn3EYpuG4JC9LvDIVMqird4Nftc2M8SW+Bc2b87QVSKQCyB6t9Gh5FqU4
        IfYUoVKRg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41982)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lA9QH-0005vl-R8; Thu, 11 Feb 2021 10:42:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lA9QG-00060n-RF; Thu, 11 Feb 2021 10:42:08 +0000
Date:   Thu, 11 Feb 2021 10:42:08 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     kostap@marvell.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        andrew@lunn.ch, mw@semihalf.com, jaz@semihalf.com,
        nadavh@marvell.com, stefanc@marvell.com, bpeled@marvell.com
Subject: Re: [PATCH v2 02/12] dts: mvebu: Update A8K AP806/AP807 SDHCI
 settings
Message-ID: <20210211104208.GX1463@shell.armlinux.org.uk>
References: <20210210140949.32515-1-kostap@marvell.com>
 <20210210140949.32515-3-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210140949.32515-3-kostap@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 04:09:39PM +0200, kostap@marvell.com wrote:
> From: Konstantin Porotchkin <kostap@marvell.com>
> 
> Select the AP SDHCI PHY slow mode for AP806 die only (move it
> from armada-ap80x.dtsi to armada-ap806.dtsi). This will allow
> running AP807 based devices at HS400 speed.
> Remove Ap SDHCI slow mode property from MacchiatoBin board DTS
> since it is already selected on the SoC level.
> 
> Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

> ---
>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi |  5 -----
>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi      | 12 ++++++++++++
>  arch/arm64/boot/dts/marvell/armada-ap80x.dtsi      |  1 -
>  3 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
> index 73733b4126e2..69653de998e2 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
> @@ -109,11 +109,6 @@
>  
>  &ap_sdhci0 {
>  	bus-width = <8>;
> -	/*
> -	 * Not stable in HS modes - phy needs "more calibration", so add
> -	 * the "slow-mode" and disable SDR104, SDR50 and DDR50 modes.
> -	 */
> -	marvell,xenon-phy-slow-mode;
>  	no-1-8-v;
>  	no-sd;
>  	no-sdio;
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> index 866628679ac7..828cd539173b 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> @@ -28,3 +28,15 @@
>  		reg = <0x278 0xa30>;
>  	};
>  };
> +
> +&ap_sdhci0 {
> +	/*
> +	 * SoC based on AP806 revision A0, A1 and A2 should use slow mode
> +	 * settings for Ap SDHCI due to HW Erratum HWE-7296210
> +	 * AP806 revesion B0 and later has this erratum fixed and the slow
> +	 * mode could be removed in board DTS:
> +	 *     /delete-property/marvell,xenon-phy-slow-mode;
> +	 * Starting from B0 revision, the AP SDHCI can run with HS400 timing.
> +	 */
> +	marvell,xenon-phy-slow-mode;
> +};
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> index 12e477f1aeb9..edd6131a0587 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> @@ -257,7 +257,6 @@
>  				clock-names = "core";
>  				clocks = <&ap_clk 4>;
>  				dma-coherent;
> -				marvell,xenon-phy-slow-mode;
>  				status = "disabled";
>  			};
>  
> -- 
> 2.17.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

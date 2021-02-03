Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A711E30DC11
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhBCN7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 08:59:44 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:35412 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232193AbhBCN7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:59:23 -0500
Received: from tarshish (unknown [10.0.8.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id B0E80440849;
        Wed,  3 Feb 2021 15:58:37 +0200 (IST)
References: <20210203133138.10754-1-kostap@marvell.com>
 <20210203133138.10754-3-kostap@marvell.com>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     kostap@marvell.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andrew@lunn.ch, jaz@semihalf.com, gregory.clement@bootlin.com,
        linux@armlinux.org.uk, nadavh@marvell.com, robh+dt@kernel.org,
        stefanc@marvell.com, mw@semihalf.com, bpeled@marvell.com,
        sebastian.hesselbarth@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/11] dts: mvebu: Update A8K AP806 SDHCI settings
In-reply-to: <20210203133138.10754-3-kostap@marvell.com>
Date:   Wed, 03 Feb 2021 15:58:37 +0200
Message-ID: <87h7mtckxe.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konstantin,

On Wed, Feb 03 2021, kostap@marvell.com wrote:
> From: Konstantin Porotchkin <kostap@marvell.com>
>
> Update the settings for AP806 SDHCI interface according to
> latest Xenon drivers changes.
> - no need to select the PHY slow mode anymore

Why? Has anything changed since the introduction of
marvell,xenon-phy-slow-mode?

baruch

> - recommended to add HS400 support at 1.8V signalling on AP806-B0
> - fix the bus witdth for A8040 DB from 4 to 8 bits.
>
> Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-8040-db.dts     | 11 ++++++++++-
>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi |  5 -----
>  arch/arm64/boot/dts/marvell/armada-ap80x.dtsi      |  1 -
>  3 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> index 09fb5256f1db..6362e654a823 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> @@ -347,7 +347,16 @@
>  
>  &ap_sdhci0 {
>  	status = "okay";
> -	bus-width = <4>;
> +	bus-width = <8>;
> +	/* The below property should be added to boards with AP806-B0
> +	 * for enabling HS400 speed mode. Otherwise the device highest
> +	 * speed mode will be HS200.
> +	 * Should not be added to boards with earlier release of AP806
> +	 * since it will cause SDHCI driver to fail upon initialization.
> +	 * Reference - HWE-7296210 (errata for releases A0/A1/A2)
> +	 *
> +	 * mmc-hs400-1_8v;
> +	 */
>  	non-removable;
>  };
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


-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

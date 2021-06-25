Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45743B3F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 10:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhFYIlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 04:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhFYIlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 04:41:07 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0FCC061574;
        Fri, 25 Jun 2021 01:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=y/xQbMyMnMxZ5Gql4eu4zBlccrgde0Q2Cbp1fMJpM/0=; b=h8GK8ea9YmRjCkYMkRYtPHWlU
        GICBKOokMCyNagLzYbZyTBBizq8nPfm9GX20I47WwD/UkrvyGwu6zik4FK+USO0YdswhCCxe35IJX
        lMY+hj+PpyqCiyGBnuwuq05W0et8+ZaweQUJZYtsaPYhGV5Wt4NhSF30mLHbCrmNCp8I0dpmbUEaa
        +X3kN1pYPogAwRc/X5IRiO/gbaD17IIckAXJjk519u4SPBafp7tzp0W2PwZwk85fkSxxwG5XV0zKI
        2aqVBP+kUfG4j0/JpPHJo9RWO6JBjkwj7g3mHKBB395+Kf4J4royVR96DBfZ/q67hXJ/uJwtOjH3b
        3uWL79wTQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45336)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lwhMG-0000NX-LP; Fri, 25 Jun 2021 09:38:40 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lwhMG-0006WW-6w; Fri, 25 Jun 2021 09:38:40 +0100
Date:   Fri, 25 Jun 2021 09:38:40 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, thomas.petazzoni@bootlin.com,
        herve.codina@bootlin.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6qdl-sr-som: Increase the PHY reset
 duration to 10ms
Message-ID: <20210625083840.GS22278@shell.armlinux.org.uk>
References: <20210625083051.3691737-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210625083051.3691737-1-maxime.chevallier@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 10:30:51AM +0200, Maxime Chevallier wrote:
> The datasheet for the AR803x PHY present on this SoM recommends that the
> reset line is asserted low for 10ms, so that the PHY has time to
> properly reset the internal blocks.
> 
> The previous value of 2ms was found to be problematic on some setups,
> causing intermittent issues where the PHY would be unresponsive
> every once in a while on some sytems, with a low occurence (it typically
> took around 30 consecutive reboots to encounter the issue).
> 
> Bumping the delay to the 10ms recommended value makes the issue
> dissapear, with more than 2500 consecutive reboots performed without the
> issue showing-up.

This isn't actually what the datasheet says, which is:

  Input clock including the crystal and external input clock should be
  stable for at least 1ms before RESET can be deasserted.

  When using crystal, the clock is generated internally after power is
  stable. For a reliable power on reset, suggest to keep asserting the
  reset low long enough (10ms) to ensure the clock is stable and
  clock-to-reset 1ms requirement is satisfied.

The 10ms duration you quote is the _power on reset_ duration, and in
those circumstances, there is a delay before the required clocks will
be stable.

This is not a power on reset scenario - the power was applied long ago
by the time the kernel starts booting, and XI clock would have been
running.

So, I think the commit message which seems to be claiming that the reset
line always needs to be asserted for 10ms is not entirely accurate.

> 
> Fixes: 208d7baf8085 ("ARM: imx: initial SolidRun HummingBoard support")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Tested-by: Hervé Codina <herve.codina@bootlin.com>
> ---
>  arch/arm/boot/dts/imx6qdl-sr-som.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sr-som.dtsi b/arch/arm/boot/dts/imx6qdl-sr-som.dtsi
> index 0ad8ccde0cf8..a54dafce025b 100644
> --- a/arch/arm/boot/dts/imx6qdl-sr-som.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sr-som.dtsi
> @@ -54,7 +54,7 @@ &fec {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_microsom_enet_ar8035>;
>  	phy-mode = "rgmii-id";
> -	phy-reset-duration = <2>;
> +	phy-reset-duration = <10>;
>  	phy-reset-gpios = <&gpio4 15 GPIO_ACTIVE_LOW>;
>  	status = "okay";
>  
> -- 
> 2.25.4
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

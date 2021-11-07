Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6726044753A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 20:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhKGTWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 14:22:01 -0500
Received: from vps.xff.cz ([195.181.215.36]:41354 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhKGTWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 14:22:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1636312756; bh=3A4Dli+gg8HWNov7I1Eit9gqhTCBR/mKSOT/BJaGxdU=;
        h=Date:From:To:Subject:X-My-GPG-KeyId:References:From;
        b=e8O1Ig5CN8RH38LZg6yzToDBqt2MJjikmDxd+Ccm7IJtzEKal1U0B+5XMoWB/bBpA
         sYF2N6duAh51fLoLh3WT660E9NBTMru5ugi0lCwBMo8h7aC7GZmk7BDoZj+7tmvYC5
         fHE/iZ6hFE0qFzzzR3PmORgDVENEWGeX+XKEX/II=
Date:   Sun, 7 Nov 2021 20:19:16 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        kernel test robot <lkp@intel.com>,
        Tobias Schramm <t.schramm@manjaro.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: phy: rockchip-inno-usb2: Don't print useless error
Message-ID: <20211107191916.5bkgjqiptftr3b7i@core>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        kernel test robot <lkp@intel.com>,
        Tobias Schramm <t.schramm@manjaro.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        "moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20211107185836.2540901-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211107185836.2540901-1-megous@megous.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 07, 2021 at 07:58:35PM +0100, megous hlavni wrote:
> The interrupt is optional, make the dmesg not complain about it
> missing.

Ooops. Sorry, this applies only on top of Peter Geis's 

"phy: phy-rockchip-inno-usb2: support muxed interrupts"

which is not mainline yet. Please ignore.

kind regards,
	o.

> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index 428c2313a9cb2..27820bee04eae 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -1180,7 +1180,7 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
>  	phy_cfgs = match->data;
>  	rphy->chg_state = USB_CHG_STATE_UNDEFINED;
>  	rphy->chg_type = POWER_SUPPLY_TYPE_UNKNOWN;
> -	rphy->irq = platform_get_irq(pdev, 0);
> +	rphy->irq = platform_get_irq_optional(pdev, 0);
>  	platform_set_drvdata(pdev, rphy);
>  
>  	ret = rockchip_usb2phy_extcon_register(rphy);
> -- 
> 2.33.1
> 

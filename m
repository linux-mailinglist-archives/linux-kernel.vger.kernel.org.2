Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2D931315E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 12:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbhBHLuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 06:50:11 -0500
Received: from mailoutvs44.siol.net ([185.57.226.235]:38057 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232995AbhBHL2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:28:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 5ABB65222CC;
        Mon,  8 Feb 2021 12:27:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xCUIjupoRsvj; Mon,  8 Feb 2021 12:27:46 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 10562522380;
        Mon,  8 Feb 2021 12:27:46 +0100 (CET)
Received: from kista.localnet (cpe-86-58-58-53.static.triera.net [86.58.58.53])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id BEF76522137;
        Mon,  8 Feb 2021 12:27:45 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Chen-Yu Tsai <wens@kernel.org>, Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "B.R. Oake" <broake@mailfence.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, devicetree@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun8i: h3: orangepi-plus: Fix Ethernet PHY mode
Date:   Mon, 08 Feb 2021 12:27:45 +0100
Message-ID: <2006991.bPDHmd0WOD@kista>
In-Reply-To: <1243888060.510560.1612783497400@ichabod.co-bxl>
References: <1243888060.510560.1612783497400@ichabod.co-bxl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 08. februar 2021 ob 12:24:57 CET je B.R. Oake napisal(a):
> Since commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx
> delay config"), Ethernet no longer works on the Orange Pi Plus,
> because that commit sets the RX/TX delay according to the phy-mode
> property in the device tree, which is "rgmii", the wrong setting
> for this board.
> 
> Following the example of others who fixed the same problem for
> many other boards, this patch changes the phy-mode to "rgmii-id"
> which gets Ethernet working again on this board.
> 
> Fixes: 4904337fe34f ("ARM: dts: sunxi: Restore EMAC changes (boards)")
> Fixes: 1dcd0095019a ("ARM: sun8i: orangepi-plus: Enable dwmac-sun8i")
> Signed-off-by: B.R. Oake <broake@mailfence.com>
> ---
>  arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>

Thanks!

Best regards,
Jernej

> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/
dts/sun8i-h3-orangepi-plus.dts
> index 97f497854e..d05fa679dc 100644
> --- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
> @@ -85,7 +85,7 @@
>  	pinctrl-0 = <&emac_rgmii_pins>;
>  	phy-supply = <&reg_gmac_3v3>;
>  	phy-handle = <&ext_rgmii_phy>;
> -	phy-mode = "rgmii";
> +	phy-mode = "rgmii-id";
>  
>  	status = "okay";
>  };
> -- 
> 2.20.1
> 
> 


